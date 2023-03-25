from fastapi import FastAPI, HTTPException, Depends, status, Request
from fastapi.security import HTTPBasic, HTTPBasicCredentials, OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from fastapi.middleware.cors import CORSMiddleware
from passlib.context import CryptContext
from datetime import datetime, timedelta
import psycopg2
import requests

app = FastAPI()
security = HTTPBasic()
pwd_context = CryptContext(schemes=['bcrypt'], deprecated="auto")
oauth_2_scheme = OAuth2PasswordBearer(tokenUrl="token")



SECRET_KEY = "4FD1F5769D50F9E928AE45AB078A092E"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30
HOST = "127.0.0.1"
PORT = "8001"
BACKEND_URL = f"http://{HOST}:{PORT}"



app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.middleware("http")
async def db_connection_middleware(request: Request, call_next):
    conn = psycopg2.connect(
        host="localhost",
        database="pmtool",
        user="postgres",
        password="invmtharun"
    )
    request.state.db = conn
    response = await call_next(request)
    conn.close()
    return response

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def get_user(request, username):
    cur = request.state.db.cursor()
    cur.execute(f"SELECT * FROM users where name='{username}'")
    user_id, name, enc_psd, role = cur.fetchone()
    result = dict(user_id=user_id, name=name, enc_psd=enc_psd, role=role)
    cur.close()
    return result

def authenticate_user(request, username, password):
    user = get_user(request, username)
    print(user)
    if not user:
        return False
    if not verify_password(password, user["enc_psd"]):
        return False
    return user

def create_access_token(data, expires_delta):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes = 15)

    to_encode.update({"exp":expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, ALGORITHM)
    return encoded_jwt

async def get_current_user(request: Request, token:str = Depends(oauth_2_scheme)):
    credential_exception = HTTPException(status_code = status.HTTP_401_UNAUTHORIZED, detail="Could not validate credentials", headers = {"WWW-Authenticate": "Bearer"})
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms = [ALGORITHM])
        username = payload.get("sub")
        if username is None:
            raise credential_exception
        ##
        token_data = username
    except JWTError:
        raise credential_exception
    user = get_user(request, username=username)
    if user is None:
        raise credential_exception
    return user

async def get_current_active_user(current_user=Depends(get_current_user)):
    # if current_user["disabled"]:
    #     raise HTTPException(status_code = 400, detail="inactive user")
    return current_user

##
@app.post('/token')
async def login_for_access_token(request: Request, form_data: OAuth2PasswordRequestForm= Depends()):
    user = authenticate_user(request, form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code = status.HTTP_401_UNAUTHORIZED, detail="Incorrect Credentials", headers = {"WWW-Authenticate": "Bearer"})
    access_token_expires = timedelta(minutes = ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(data={"sub": user["name"]}, expires_delta=access_token_expires)
    return {"access_token": access_token, "token_type":"bearer"}

##
@app.get("/users/me/")
async def read_users_me(current_user = Depends(get_current_active_user)):
    if current_user["role"] == "staff":
        raise HTTPException(status_code = status.HTTP_403_FORBIDDEN, detail="Only managers can access the page", headers = {"WWW-Authenticate": "Bearer"})
    else:
        return "You are a manager. You can see this"


def make_get_request(url, params=None):
    response = requests.get(url, params)
    if response.status_code == 200:
        data = response.json()
        return data
    else:
        return f'Request failed with status code {response.status_code}'

@app.get("/get_users")
async def get_users(current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_users'
    return make_get_request(url)

@app.get("/get_managers")
async def get_managers(current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_managers'
    return make_get_request(url)


@app.get("/get_employees")
async def get_employees(  manager_id, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_employees'
    params = {
        'manager_id': manager_id
    }
    return make_get_request(url, params)

@app.get("/get_manager_tickets")
async def get_manager_tickets(  manager_id, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_manager_tickets'
    params = {
        'manager_id': manager_id
    }
    return make_get_request(url, params)

@app.get("/get_ticket_detail")
async def get_ticket_detail(  ticket_id, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_ticket_detail'
    params = {
        'ticket_id': ticket_id
    }
    return make_get_request(url, params)

@app.get("/get_employee_tickets")
async def get_employee_tickets(  employee_id, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_employee_tickets'
    params = {
        'employee_id': employee_id
    }
    return make_get_request(url, params)

@app.get("/update_ticket_status")
async def update_ticket_status(ticket_id, status, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/update_ticket_status'
    params = {
        'ticket_id': ticket_id,
        'status' : status
    }
    return make_get_request(url, params)

@app.get("/get_ticket_comments")
async def get_ticket_comments(ticket_id, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/get_ticket_comments'
    params = {
        'ticket_id': ticket_id
    }
    return make_get_request(url, params)


@app.get("/update_comment")
async def update_comment(ticket_id, comment, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/update_comment'
    params = {
        'ticket_id': ticket_id,
        'comment':comment
    }
    return make_get_request(url, params)

@app.get("/create_ticket")
async def create_ticket(employee_id, manager_id, title, description, current_user = Depends(get_current_active_user)):
    url = f'{BACKEND_URL}/create_ticket'
    params = {
        'employee_id': employee_id,
        'manager_id':manager_id,
        'description':description,
        'title': title
    }
    return make_get_request(url, params)




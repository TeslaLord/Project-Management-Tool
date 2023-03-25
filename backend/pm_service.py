from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
import psycopg2

app = FastAPI()

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

@app.get("/get_users")
async def get_users(request: Request):
    cur = request.state.db.cursor()
    cur.execute("SELECT * FROM users where user_id=10")
    result = cur.fetchone()
    print(result)
    cur.execute("SELECT * FROM users")
    results = cur.fetchall()
    cur.close()
    return {"users": results}

@app.get("/get_managers")
async def get_managers(request: Request):
    cur = request.state.db.cursor()
    cur.execute("SELECT * FROM manager")
    results = cur.fetchall()
    cur.close()
    return {"managers": results}


@app.get("/get_employees")
async def get_employees(request: Request, manager_id):
    cur = request.state.db.cursor()
    cur.execute(f"SELECT * FROM employee where man_id={manager_id}")
    results = cur.fetchall()
    cur.close()
    return {"employees": results}

@app.get("/get_manager_tickets")
async def get_manager_tickets(request: Request, manager_id):
    cur = request.state.db.cursor()
    cur.execute(f"SELECT * FROM ticket where man_id={manager_id}")
    results = cur.fetchall()
    cur.close()
    return {"tickets": results}

@app.get("/get_ticket_detail")
async def get_ticket_detail(request: Request, ticket_id):
    cur = request.state.db.cursor()
    cur.execute(f"SELECT * FROM ticket where ticket_id={ticket_id}")
    results = cur.fetchall()
    cur.close()
    return {"tickets": results}

@app.get("/get_employee_tickets")
async def get_employee_tickets(request: Request, employee_id):
    cur = request.state.db.cursor()
    cur.execute(f"SELECT * FROM ticket where emp_id={employee_id}")
    results = cur.fetchall()
    cur.close()
    return {"tickets": results}

@app.get("/update_ticket_status")
async def update_ticket_status(request: Request, ticket_id, status):
    cur = request.state.db.cursor()
    print(status, ticket_id)
    cur.execute(f"Update ticket set status='{status}' where ticket_id = {ticket_id}")
    request.state.db.commit()
    cur.close()
    return {"Response": "successfully updated"}

@app.get("/get_ticket_comments")
async def get_ticket_comments(request: Request, ticket_id):
    cur = request.state.db.cursor()
    cur.execute(f"SELECT * FROM ticket_comment, comment where ticket_comment.ticket_id={ticket_id} and ticket_comment.comment_id=comment.comment_id")
    results = cur.fetchall()
    cur.close()
    return {"tickets": results}


@app.get("/update_comment")
async def update_comment(request: Request, ticket_id, comment):
    cur = request.state.db.cursor()
    cur.execute(f"INSERT INTO comment (comment, timestamp) VALUES ('{comment}', NOW());")
    cur.execute(f"SELECT comment_id FROM comment ORDER BY timestamp DESC LIMIT 1;")
    result = cur.fetchone()[0]
    cur.execute(f"INSERT INTO ticket_comment (ticket_id, comment_id) VALUES ({ticket_id}, {result});")
    request.state.db.commit()
    cur.close()
    return {"Response": "successfully updated"}

@app.get("/create_ticket")
async def create_ticket(request: Request, employee_id, manager_id, title, description):
    cur = request.state.db.cursor()
    cur.execute(f"INSERT INTO ticket (emp_id, man_id, title, description, status) VALUES ('{employee_id}', '{manager_id}', '{title}', '{description}', 'To-Do');")
    request.state.db.commit()
    cur.close()
    return {"Response": "successfully updated"}
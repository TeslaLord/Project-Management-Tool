--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.0

-- Started on 2023-03-29 11:03:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16597)
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    comment_id integer NOT NULL,
    comment text NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16596)
-- Name: comment_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comment_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_comment_id_seq OWNER TO postgres;

--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 220
-- Name: comment_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comment_comment_id_seq OWNED BY public.comment.comment_id;


--
-- TOC entry 219 (class 1259 OID 16580)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    emp_id integer NOT NULL,
    user_id integer,
    man_id integer
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16579)
-- Name: employee_emp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_emp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.employee_emp_id_seq OWNER TO postgres;

--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 218
-- Name: employee_emp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_emp_id_seq OWNED BY public.employee.emp_id;


--
-- TOC entry 217 (class 1259 OID 16568)
-- Name: manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manager (
    man_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.manager OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16567)
-- Name: manager_man_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manager_man_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.manager_man_id_seq OWNER TO postgres;

--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 216
-- Name: manager_man_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manager_man_id_seq OWNED BY public.manager.man_id;


--
-- TOC entry 223 (class 1259 OID 16607)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    ticket_id integer NOT NULL,
    emp_id integer,
    man_id integer,
    description text,
    status text,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL,
    title text
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16636)
-- Name: ticket_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_comment (
    ticket_id integer NOT NULL,
    comment_id integer NOT NULL
);


ALTER TABLE public.ticket_comment OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16606)
-- Name: ticket_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 222
-- Name: ticket_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;


--
-- TOC entry 215 (class 1259 OID 16561)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(50) NOT NULL,
    enc_psd character varying(255) NOT NULL,
    role character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16560)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 3200 (class 2604 OID 16600)
-- Name: comment comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment ALTER COLUMN comment_id SET DEFAULT nextval('public.comment_comment_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 16583)
-- Name: employee emp_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee ALTER COLUMN emp_id SET DEFAULT nextval('public.employee_emp_id_seq'::regclass);


--
-- TOC entry 3198 (class 2604 OID 16571)
-- Name: manager man_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager ALTER COLUMN man_id SET DEFAULT nextval('public.manager_man_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 16610)
-- Name: ticket ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket ALTER COLUMN ticket_id SET DEFAULT nextval('public.ticket_ticket_id_seq'::regclass);


--
-- TOC entry 3197 (class 2604 OID 16564)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3374 (class 0 OID 16597)
-- Dependencies: 221
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (comment_id, comment, "timestamp") FROM stdin;
2	First comment for ticket 1	2023-03-24 12:47:03.684445
3	Second comment for ticket 1	2023-03-24 12:47:19.820462
4	asdf	2023-03-26 00:51:32.950487
5	Third comment	2023-03-26 00:56:37.412362
6	Fourth	2023-03-26 00:56:50.518037
7	Hello there	2023-03-28 12:28:58.543381
8	First comment	2023-03-28 13:03:17.072326
9		2023-03-28 13:04:44.187256
10	Second	2023-03-28 13:06:08.478653
11	Third	2023-03-28 13:06:42.742488
12	Fourth	2023-03-28 13:06:52.599783
13	Fifth	2023-03-28 13:07:36.123943
\.


--
-- TOC entry 3372 (class 0 OID 16580)
-- Dependencies: 219
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (emp_id, user_id, man_id) FROM stdin;
1	4	1
2	5	1
3	6	1
4	7	2
5	8	2
\.


--
-- TOC entry 3370 (class 0 OID 16568)
-- Dependencies: 217
-- Data for Name: manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manager (man_id, user_id) FROM stdin;
1	1
2	2
3	3
\.


--
-- TOC entry 3376 (class 0 OID 16607)
-- Dependencies: 223
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket (ticket_id, emp_id, man_id, description, status, "timestamp", title) FROM stdin;
3	1	1	Fake description	To-Do	2023-03-24 16:58:27.983266	Second ticket
4	1	1	desc	To-Do	2023-03-25 20:14:47.314957	asd
5	1	1	Four des	To-Do	2023-03-25 20:30:11.01183	Fourth from pageeee
6	1	1	asdf	To-Do	2023-03-25 22:29:54.133628	asdf
7	1	1	From good manager	To-Do	2023-03-25 22:42:17.60903	From manager me good
8	2	1	Second Employee first ticket desc	Completed	2023-03-28 12:28:14.168294	For second Employee
1	1	1	First ticket for employee 1 by tharun	To-do	2023-03-24 12:45:19.292578	Containerize the application
\.


--
-- TOC entry 3377 (class 0 OID 16636)
-- Dependencies: 224
-- Data for Name: ticket_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket_comment (ticket_id, comment_id) FROM stdin;
1	2
1	3
1	4
1	5
1	6
1	7
8	8
8	9
8	10
8	11
8	12
8	13
\.


--
-- TOC entry 3368 (class 0 OID 16561)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, enc_psd, role) FROM stdin;
1	tharun	$2b$12$LF4sH7hqVZYZq4.rhv7sye.MB8ogBzSITkvWv8A.6lujz1FTXhM8e	manager
2	shilpa	$2b$12$AXjDRrgQ8zDTriHwrsbHAO7rl0iJHOLrEu8SZUOaa2CC01h4i/SOi	manager
3	asmaa	$2b$12$NgJmwxqjEmhUHcnAzBRo/uCP5yVUcpF009NIBRSQ9Dl/AWgKOdk0q	manager
4	emp1	$2b$12$lJ79QjHD308BBLEL9av5cec3vHWbs8LaOMGD0PFmlMAq.Nl.RLxiC	staff
5	emp2	$2b$12$.e6vCG2r3TbmqkPaTPp7.uQrsxZMy1w3kzxCsXga4v7AkkCLhmuQ6	staff
6	emp3	$2b$12$D56eudZ1y1KEDqsRiwmkpeE1MqWnSrMy.Hu568NK6sIRvwJ3Frv4u	staff
7	emp4	$2b$12$FMdE6Aa0DuJJj2Ig35sJ..OrVPbyH4Rlq87UP.IYsQGmdxfrXTqO2	staff
8	emp5	$2b$12$7ykXLuXZQ0qHdXB2HXruh.EL7ntaWfxnYI9cpOcwoG8A9/avqQMu6	staff
\.


--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 220
-- Name: comment_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comment_comment_id_seq', 13, true);


--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 218
-- Name: employee_emp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_emp_id_seq', 6, true);


--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 216
-- Name: manager_man_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manager_man_id_seq', 3, true);


--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 222
-- Name: ticket_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_ticket_id_seq', 8, true);


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);


--
-- TOC entry 3211 (class 2606 OID 16605)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- TOC entry 3209 (class 2606 OID 16585)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (emp_id);


--
-- TOC entry 3207 (class 2606 OID 16573)
-- Name: manager manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (man_id);


--
-- TOC entry 3215 (class 2606 OID 16640)
-- Name: ticket_comment ticket_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_comment
    ADD CONSTRAINT ticket_comment_pkey PRIMARY KEY (ticket_id, comment_id);


--
-- TOC entry 3213 (class 2606 OID 16615)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3205 (class 2606 OID 16566)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3217 (class 2606 OID 16591)
-- Name: employee employee_man_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_man_id_fkey FOREIGN KEY (man_id) REFERENCES public.manager(man_id);


--
-- TOC entry 3218 (class 2606 OID 16586)
-- Name: employee employee_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3216 (class 2606 OID 16574)
-- Name: manager manager_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3223 (class 2606 OID 16646)
-- Name: ticket_comment ticket_comment_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_comment
    ADD CONSTRAINT ticket_comment_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comment(comment_id);


--
-- TOC entry 3224 (class 2606 OID 16641)
-- Name: ticket_comment ticket_comment_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_comment
    ADD CONSTRAINT ticket_comment_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.ticket(ticket_id);


--
-- TOC entry 3219 (class 2606 OID 16616)
-- Name: ticket ticket_emp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(emp_id);


--
-- TOC entry 3220 (class 2606 OID 16626)
-- Name: ticket ticket_emp_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_emp_id_fkey1 FOREIGN KEY (emp_id) REFERENCES public.employee(emp_id);


--
-- TOC entry 3221 (class 2606 OID 16621)
-- Name: ticket ticket_man_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_man_id_fkey FOREIGN KEY (man_id) REFERENCES public.manager(man_id);


--
-- TOC entry 3222 (class 2606 OID 16631)
-- Name: ticket ticket_man_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_man_id_fkey1 FOREIGN KEY (man_id) REFERENCES public.manager(man_id);


-- Completed on 2023-03-29 11:03:32

--
-- PostgreSQL database dump complete
--


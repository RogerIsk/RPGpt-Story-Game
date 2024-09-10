--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

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
-- Name: enemies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enemies (
    id integer NOT NULL,
    name character varying(50),
    hp integer,
    damage integer,
    armor integer
);


ALTER TABLE public.enemies OWNER TO postgres;

--
-- Name: enemies_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enemies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enemies_id_seq OWNER TO postgres;

--
-- Name: enemies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enemies_id_seq OWNED BY public.enemies.id;


--
-- Name: heroes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.heroes (
    id integer NOT NULL,
    name character varying(50),
    race character varying(20),
    gender character varying(10),
    class character varying(20),
    hp integer,
    damage integer,
    armor integer
);


ALTER TABLE public.heroes OWNER TO postgres;

--
-- Name: heroes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.heroes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.heroes_id_seq OWNER TO postgres;

--
-- Name: heroes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.heroes_id_seq OWNED BY public.heroes.id;


--
-- Name: enemies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemies ALTER COLUMN id SET DEFAULT nextval('public.enemies_id_seq'::regclass);


--
-- Name: heroes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes ALTER COLUMN id SET DEFAULT nextval('public.heroes_id_seq'::regclass);


--
-- Data for Name: enemies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enemies (id, name, hp, damage, armor) FROM stdin;
1	a wild centaur	40	15	15
2	cannibal goblin	15	20	5
3	archespore	65	5	5
4	desert serpent	20	15	20
5	evil mushroom	40	15	0
6	mummy	20	20	0
\.


--
-- Data for Name: heroes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.heroes (id, name, race, gender, class, hp, damage, armor) FROM stdin;
1	Human male Warrior	Human	Male	Warrior	50	10	15
2	Human female Warrior	Human	Female	Warrior	50	10	15
3	Human male Mage	Human	Male	Mage	50	15	10
4	Human female Mage	Human	Female	Mage	50	15	10
5	Human male Ranger	Human	Male	Ranger	55	10	10
6	Human female Ranger	Human	Female	Ranger	55	10	10
7	Elf male Warrior	Elf	Male	Warrior	45	11	14
8	Elf female Warrior	Elf	Female	Warrior	45	11	14
9	Elf male Mage	Elf	Male	Mage	45	16	9
10	Elf female Mage	Elf	Female	Mage	45	16	9
11	Elf male Ranger	Elf	Male	Ranger	50	11	9
12	Elf female Ranger	Elf	Female	Ranger	50	11	9
13	Dwarf male Warrior	Dwarf	Male	Warrior	55	9	16
14	Dwarf female Warrior	Dwarf	Female	Warrior	55	9	16
15	Dwarf male Mage	Dwarf	Male	Mage	55	14	11
16	Dwarf female Mage	Dwarf	Female	Mage	55	14	11
17	Dwarf male Ranger	Dwarf	Male	Ranger	60	14	11
18	Dwarf female Ranger	Dwarf	Female	Ranger	60	14	11
\.


--
-- Name: enemies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enemies_id_seq', 6, true);


--
-- Name: heroes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.heroes_id_seq', 18, true);


--
-- Name: enemies enemies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemies
    ADD CONSTRAINT enemies_pkey PRIMARY KEY (id);


--
-- Name: heroes heroes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--


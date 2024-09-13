--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)
-- Dumped by pg_dump version 16.4 (Ubuntu 16.4-0ubuntu0.24.04.2)

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
-- Name: characters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.characters (
    character_id integer NOT NULL,
    name character varying(100) NOT NULL,
    species character varying(50),
    gender character varying(10),
    class character varying(50),
    hp integer,
    damage integer,
    armor integer,
    items integer[],
    equipped_weapon integer,
    equipped_armor integer
);


ALTER TABLE public.characters OWNER TO postgres;

--
-- Name: characters_character_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.characters_character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.characters_character_id_seq OWNER TO postgres;

--
-- Name: characters_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.characters_character_id_seq OWNED BY public.characters.character_id;


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


ALTER SEQUENCE public.enemies_id_seq OWNER TO postgres;

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
    species character varying(20),
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


ALTER SEQUENCE public.heroes_id_seq OWNER TO postgres;

--
-- Name: heroes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.heroes_id_seq OWNED BY public.heroes.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.items (
    item_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    bonus_type character varying(50) NOT NULL,
    bonus_value integer NOT NULL,
    image_file character varying(255)
);


ALTER TABLE public.items OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.items_item_id_seq OWNER TO postgres;

--
-- Name: items_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;


--
-- Name: characters character_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters ALTER COLUMN character_id SET DEFAULT nextval('public.characters_character_id_seq'::regclass);


--
-- Name: enemies id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enemies ALTER COLUMN id SET DEFAULT nextval('public.enemies_id_seq'::regclass);


--
-- Name: heroes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.heroes ALTER COLUMN id SET DEFAULT nextval('public.heroes_id_seq'::regclass);


--
-- Name: items item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characters (character_id, name, species, gender, class, hp, damage, armor, items, equipped_weapon, equipped_armor) FROM stdin;
1	Sora	elf	female	ranger	50	10	9	{5,7,14}	5	7
2	Unknown	human	male	ranger	55	12	10	\N	\N	\N
3	Unknown	elf	female	ranger	57	10	10	\N	\N	\N
4	Unknown	elf	female	warrior	52	10	15	\N	\N	\N
5	Unknown	dwarf	female	ranger	55	10	12	\N	\N	\N
6	Unknown	dwarf	female	warrior	50	10	17	\N	\N	\N
7	Unknown	elf	female	warrior	52	10	15	\N	\N	\N
8	Unknown	human	male	warrior	50	12	15	\N	\N	\N
9	Unknown	human	female	warrior	50	12	15	\N	\N	\N
10	Unknown	human	male	ranger	55	12	10	\N	\N	\N
11	Unknown	dwarf	female	warrior	50	10	17	\N	\N	\N
12	Unknown	dwarf	female	warrior	50	10	17	\N	\N	\N
13	Unknown	elf	female	ranger	57	10	10	\N	\N	\N
14	Unknown	elf	male	mage	52	15	10	\N	\N	\N
15	Unknown	dwarf	female	mage	50	15	12	\N	\N	\N
16	Unknown	dwarf	male	ranger	55	10	12	\N	\N	\N
17	Unknown	human	male	mage	50	17	10	\N	\N	\N
18	Unknown	dwarf	female	ranger	55	10	12	\N	\N	\N
19	Unknown	dwarf	male	ranger	55	10	12	\N	\N	\N
20	Unknown	human	female	ranger	55	12	10	\N	\N	\N
21	Unknown	elf	female	mage	52	15	10	\N	\N	\N
22	Unknown	elf	male	ranger	57	10	10	\N	\N	\N
23	Unknown	dwarf	female	warrior	50	10	17	\N	\N	\N
24	Unknown	elf	female	mage	52	15	10	\N	\N	\N
25	Unknown	elf	male	warrior	52	10	15	\N	\N	\N
26	Unknown	dwarf	male	mage	50	15	12	\N	\N	\N
27	Unknown	dwarf	female	ranger	55	10	12	\N	\N	\N
28	Unknown	human	female	ranger	55	12	10	\N	\N	\N
29	Unknown	dwarf	male	ranger	55	10	12	\N	\N	\N
30	Unknown	elf	female	mage	52	15	10	\N	\N	\N
31	Unknown	dwarf	female	mage	50	15	12	\N	\N	\N
32	Unknown	elf	female	ranger	57	10	10	\N	\N	\N
33	Unknown	dwarf	female	warrior	50	10	17	\N	\N	\N
34	Unknown	human	male	warrior	50	12	15	\N	\N	\N
35	Unknown	dwarf	male	mage	50	15	12	\N	\N	\N
36	Unknown	elf	female	mage	52	15	10	\N	\N	\N
37	Unknown	dwarf	male	warrior	50	10	17	\N	\N	\N
38	Unknown	elf	male	ranger	57	10	10	\N	\N	\N
39	Unknown	dwarf	male	mage	50	15	12	\N	\N	\N
40	Unknown	elf	female	ranger	57	10	10	\N	\N	\N
41	Unknown	elf	male	mage	52	15	10	\N	\N	\N
\.


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

COPY public.heroes (id, name, species, gender, class, hp, damage, armor) FROM stdin;
1	Human male Warrior	Human	Male	Warrior	50	12	15
2	Human female Warrior	Human	Female	Warrior	50	12	15
3	Human male Mage	Human	Male	Mage	50	17	10
4	Human female Mage	Human	Female	Mage	50	17	10
5	Human male Ranger	Human	Male	Ranger	55	12	10
6	Human female Ranger	Human	Female	Ranger	55	12	10
7	Elf male Warrior	Elf	Male	Warrior	52	10	15
8	Elf female Warrior	Elf	Female	Warrior	52	10	15
9	Elf male Mage	Elf	Male	Mage	52	15	10
10	Elf female Mage	Elf	Female	Mage	52	15	10
11	Elf male Ranger	Elf	Male	Ranger	57	10	10
12	Elf female Ranger	Elf	Female	Ranger	57	10	10
13	Dwarf male Warrior	Dwarf	Male	Warrior	50	10	17
14	Dwarf female Warrior	Dwarf	Female	Warrior	50	10	17
15	Dwarf male Mage	Dwarf	Male	Mage	50	15	12
16	Dwarf female Mage	Dwarf	Female	Mage	50	15	12
17	Dwarf male Ranger	Dwarf	Male	Ranger	55	10	12
18	Dwarf female Ranger	Dwarf	Female	Ranger	55	10	12
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (item_id, name, type, bonus_type, bonus_value, image_file) FROM stdin;
7	Dragon battle mail	armor	armor	10	armor-dragon-battlemail.jpg
8	Heart of darkness	armor	armor	12	armor-heart-of-darkness.jpg
9	Grimmags starry robe	armor	armor	3	armor-grimmags-starry-robe.jpg
10	Sigrismarrs eternal staff	armor	armor	10	weapon-sigrismars-eternal-staff.jpg
11	Poison buster armor	armor	armor	4	armor-poison-buster.jpg
12	Witch seeker brigandine	armor	armor	6	armor-witchseeker-brigandine.jpg
1	Spider hatchet	weapon	dmg	8	weapon-spider-hatchet.jpg
2	Dark exile two handed sword	weapon	dmg	10	weapon-dark-exile-two-handed-sword.jpg
3	Dark exile scythe	weapon	dmg	9	weapon-dark-exile-scyte.jpg
4	Wisdom seeker robe	weapon	dmg	4	armor-wisdom-seeker.jpg
5	Aegis longbow	weapon	dmg	10	weapon-aegis-longbow.jpg
6	Desert flame shortbow	weapon	dmg	6	weapon-desert-flame-shortbow.jpg
13	Health potion	potion	hp	20	potion-health.jpg
14	Attack potion	potion	dmg	5	potion-attack.jpg
\.


--
-- Name: characters_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characters_character_id_seq', 41, true);


--
-- Name: enemies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enemies_id_seq', 6, true);


--
-- Name: heroes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.heroes_id_seq', 18, true);


--
-- Name: items_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.items_item_id_seq', 14, true);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);


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
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);


--
-- Name: characters characters_equipped_armor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_armor_fkey FOREIGN KEY (equipped_armor) REFERENCES public.items(item_id) ON DELETE SET NULL;


--
-- Name: characters characters_equipped_weapon_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_weapon_fkey FOREIGN KEY (equipped_weapon) REFERENCES public.items(item_id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--


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
    equipped_weapon integer,
    equipped_armor integer,
    level integer,
    xp integer,
    next_level_xp integer,
    history character varying(1000),
    world_type character varying(50),
    turns integer,
    is_active boolean,
    gold integer
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
-- Name: hero_with_equipped_weapon; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.hero_with_equipped_weapon AS
 SELECT "character".character_id,
    "character".name,
    "character".class,
    item.name AS weapon_name,
    item.type AS weapon_type
   FROM (public.characters "character"
     JOIN public.items item ON (("character".equipped_weapon = item.item_id)));


ALTER VIEW public.hero_with_equipped_weapon OWNER TO postgres;

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
-- Name: inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventory (
    character_id integer NOT NULL,
    item_id integer NOT NULL
);


ALTER TABLE public.inventory OWNER TO postgres;

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

COPY public.characters (character_id, name, species, gender, class, hp, damage, armor, equipped_weapon, equipped_armor, level, xp, next_level_xp, history, world_type, turns, is_active, gold) FROM stdin;
1	Sora	elf	female	ranger	50	10	9	5	7	\N	\N	\N	\N	\N	\N	\N	\N
265	Dagnal	dwarf	female	mage	50	15	12	\N	\N	1	50	0		Feudal Japan	0	f	50
261	Dagnal	dwarf	female	warrior	50	15	12	\N	\N	1	50	0		Feudal Japan	0	f	50
262	Zelphar	elf	male	mage	52	15	10	\N	\N	1	50	0		Classic Medieval	0	f	50
250	Blythe	human	female	mage	50	17	10	\N	\N	1	50	0	\N	Post-Apocalyptic Zombies	0	f	50
228	Eldra	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Game of Thrones	0	f	50
220	Sigrid	dwarf	female	ranger	55	10	12	\N	\N	1	50	0	\N	Classic Medieval	0	f	50
212	Gimli	dwarf	male	mage	50	15	12	\N	\N	1	50	0	\N	Post-Apocalyptic Zombies	0	f	50
206	Maera	dwarf	female	mage	50	15	12	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
199	Yelraen	elf	male	ranger	57	10	10	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
200	Morgana	human	female	mage	50	17	10	\N	\N	1	50	0	\N	Fantasy	0	f	50
201	Mardred	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Fantasy	0	f	50
270	Orin	human	male	ranger	55	12	10	\N	\N	1	50	0	\N	Cyberpunk	0	f	50
272	Naeris	elf	male	warrior	52	10	15	\N	\N	1	50	0		Fantasy	0	f	50
255	Elaethan	elf	male	warrior	52	10	15	\N	\N	1	50	0		Game of Thrones	0	f	50
257	Gerard	human	male	mage	50	17	10	\N	\N	1	50	0		Feudal Japan	0	f	50
260	Ayda	elf	female	mage	52	15	10	\N	\N	1	50	0	\N	Post-Apocalyptic Zombies	0	f	50
263	Amrynn	elf	male	mage	52	15	10	\N	\N	1	50	0	\N	Dark Fantasy - Hard	0	f	50
264	Einkil	dwarf	male	warrior	50	10	17	\N	\N	1	50	0		Classic Medieval	0	f	50
266	Penelope	human	female	warrior	50	12	15	\N	\N	1	50	0		Post-Apocalyptic Fallout	0	f	50
258	Kargan	dwarf	male	ranger	55	10	12	\N	\N	1	50	0		Anime	0	f	50
256	Dara	elf	female	ranger	57	10	10	\N	\N	1	50	0		Post-Apocalyptic Fallout	0	f	50
248	Zanthis	elf	female	warrior	52	10	15	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
244	Viggo	human	male	mage	50	17	10	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
275	Thalia	elf	female	warrior	52	10	15	\N	\N	1	50	0		Dark Fantasy - Hard	0	t	50
202	Durin	dwarf	male	warrior	50	10	17	\N	\N	1	50	0	\N	Cyberpunk	0	f	50
240	Clarimond	human	female	ranger	55	12	10	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
243	Guinevere	human	female	ranger	55	12	10	\N	\N	1	50	0	\N	Game of Thrones	0	f	50
246	Quinlan	human	male	ranger	55	12	10	\N	\N	1	50	0	\N	Fantasy	0	f	50
247	Maith	elf	female	mage	52	15	10	\N	\N	1	50	0	\N	Anime	0	f	50
251	Sebastian	human	male	warrior	50	12	15	\N	\N	1	50	0		Classic Medieval	0	f	50
253	Vespera	human	female	ranger	55	12	10	\N	\N	1	50	0		Feudal Japan	0	f	50
223	Solana	elf	female	ranger	57	10	10	\N	\N	1	50	0	\N	Anime	0	f	50
224	Gunnloda	dwarf	female	ranger	55	10	12	\N	\N	1	50	0	\N	Fantasy	0	f	50
219	Zara	human	female	warrior	50	12	15	\N	\N	1	50	0	\N	Fantasy	0	f	50
271	Audhild	dwarf	female	mage	50	15	12	\N	\N	1	50	0		Feudal Japan	0	f	50
217	Seraphina	human	female	ranger	55	12	10	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
210	Caladrel	elf	male	mage	52	15	10	\N	\N	1	50	0	\N	Anime	0	f	50
213	Gerta	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Fantasy	0	f	50
254	Dain	dwarf	male	ranger	55	10	12	\N	\N	1	50	0		Fantasy	0	f	50
215	Ulric	human	male	warrior	50	12	15	\N	\N	1	50	0	\N	Dark Fantasy - Hard Mode	0	f	50
203	Mara	dwarf	female	ranger	55	10	12	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
209	Mara	dwarf	female	warrior	55	10	12	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
222	Sigrid	dwarf	female	warrior	55	10	12	\N	\N	1	50	0	\N	Classic Medieval	0	f	50
225	Tia	elf	female	mage	52	15	10	\N	\N	1	50	0	\N	Anime	0	f	50
231	Ariadne	elf	female	ranger	57	10	10	\N	\N	1	50	0	\N	Classic Medieval	0	f	50
235	Delg	dwarf	male	ranger	55	10	12	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
204	Arthur	human	male	warrior	50	12	15	\N	\N	1	50	0	\N	Classic Medieval	0	f	50
249	Quinn	human	female	mage	50	17	10	\N	\N	1	50	0	\N	Classic Medieval	0	f	50
245	Rhilda	dwarf	female	mage	50	15	12	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
242	Petronilla	human	female	warrior	50	12	15	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
205	Elaine	human	female	warrior	50	12	15	\N	\N	1	50	0	\N	Fantasy	0	f	50
207	Sigrun	dwarf	female	mage	50	15	12	\N	\N	1	50	0	\N	Game of Thrones	0	f	50
208	Jelenneth	elf	female	ranger	57	10	10	\N	\N	1	50	0	\N	Dark Fantasy - Hard Mode	0	f	50
239	Tilda	dwarf	female	ranger	55	10	12	\N	\N	1	50	0	\N	Game of Thrones	0	f	50
230	Helja	dwarf	female	mage	50	10	17	\N	\N	1	50	0	\N	Anime	0	f	50
252	Osric	human	male	warrior	50	12	15	\N	\N	1	50	0	\N	Dark Fantasy - Hard Mode	0	f	50
273	Laucian	elf	male	ranger	57	10	10	\N	\N	1	50	0		Classic Medieval	0	f	50
241	Helja	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Anime	0	f	50
233	Harbek	dwarf	male	warrior	50	10	17	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
214	Hlin	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Fantasy	0	f	50
229	Hlin	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Fantasy	0	f	50
227	Felicity	human	female	warrior	50	12	15	\N	\N	1	50	0	\N	Anime	0	f	50
221	Roderick	human	male	warrior	50	12	15	\N	\N	1	50	0	\N	Anime	0	f	50
218	Mara	dwarf	female	ranger	55	10	12	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
226	Alaric	human	male	warrior	50	12	15	\N	\N	1	50	0	\N	Dark Fantasy - Hard Mode	0	f	50
232	Tristan	human	male	ranger	55	12	10	\N	\N	1	50	0	\N	Dark Fantasy - Hard Mode	0	f	50
234	Eilistraee	elf	female	ranger	57	10	10	\N	\N	1	50	0	\N	Post-Apocalyptic Zombies	0	f	50
236	Falkrunn	dwarf	female	warrior	50	10	17	\N	\N	1	50	0	\N	Post-Apocalyptic Fallout	0	f	50
237	Anastrianna	elf	female	ranger	57	10	10	\N	\N	1	50	0	\N	Game of Thrones	0	f	50
238	Lavinia	human	female	ranger	55	12	10	\N	\N	1	50	0	\N	Feudal Japan	0	f	50
259	Ula	dwarf	female	ranger	55	10	12	\N	\N	1	50	0		Dark Fantasy - Hard	0	f	50
216	Amrynn	elf	male	warrior	52	10	15	\N	\N	1	50	0	\N	Dark Fantasy - Hard	0	f	50
267	Eiravel	elf	male	mage	52	15	10	\N	\N	1	50	0	\N	Dark Fantasy - Hard	0	f	50
268	Delgora	dwarf	female	mage	50	15	12	\N	\N	1	50	0		Post-Apocalyptic Fallout	0	f	50
269	Torbera	dwarf	female	warrior	50	10	17	\N	\N	1	50	0		Post-Apocalyptic Fallout	0	f	50
274	Dain	dwarf	male	warrior	55	10	12	\N	\N	1	50	0		Fantasy	0	f	50
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
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventory (character_id, item_id) FROM stdin;
1	7
1	12
1	2
1	5
1	13
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.items (item_id, name, type, bonus_type, bonus_value, image_file) FROM stdin;
7	Dragon Battle Mail	armor	armor	10	armor-dragon-battlemail.jpg
8	Heart Of Darkness	armor	armor	12	armor-heart-of-darkness.jpg
9	Grimmags Starry Robe	armor	armor	3	armor-grimmags-starry-robe.jpg
10	Sigrismarrs Eternal Staff	armor	armor	10	weapon-sigrismars-eternal-staff.jpg
11	Poison Buster Armor	armor	armor	4	armor-poison-buster.jpg
12	Witch Seeker Brigandine	armor	armor	6	armor-witchseeker-brigandine.jpg
1	Spider Hatchet	weapon	dmg	8	weapon-spider-hatchet.jpg
2	Dark Exile Two Handed Sword	weapon	dmg	10	weapon-dark-exile-two-handed-sword.jpg
3	Dark Exile Scythe	weapon	dmg	9	weapon-dark-exile-scyte.jpg
4	Wisdom Seeker Robe	weapon	dmg	4	armor-wisdom-seeker.jpg
5	Aegis Longbow	weapon	dmg	10	weapon-aegis-longbow.jpg
6	Desert Flame Shortbow	weapon	dmg	6	weapon-desert-flame-shortbow.jpg
13	Health Potion	potion	hp	20	potion-health.jpg
14	Attack Potion	potion	dmg	5	potion-attack.jpg
\.


--
-- Name: characters_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characters_character_id_seq', 275, true);


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
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (character_id, item_id);


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
-- Name: inventory inventory_character_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);


--
-- Name: inventory inventory_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);


--
-- PostgreSQL database dump complete
--


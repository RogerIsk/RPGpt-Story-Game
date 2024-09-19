--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'LATIN1';
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
    level integer DEFAULT 1 NOT NULL,
    xp integer DEFAULT 50,
    next_level_xp integer DEFAULT 0,
    history character varying(1000),
    world_type character varying(50),
    turns integer,
    is_active boolean DEFAULT false,
    gold integer DEFAULT 50
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


ALTER TABLE public.characters_character_id_seq OWNER TO postgres;

--
-- Name: characters_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.characters_character_id_seq OWNED BY public.characters.character_id;


--
-- Name: characters character_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters ALTER COLUMN character_id SET DEFAULT nextval('public.characters_character_id_seq'::regclass);


--
-- Data for Name: characters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.characters (character_id, name, species, gender, class, hp, damage, armor, equipped_weapon, equipped_armor, level, xp, next_level_xp, history, world_type, turns, is_active, gold) FROM stdin;
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
211	Kendrick	human	male	mage	50	17	10	\N	\N	1	50	0	\N	Dark Fantasy - Hard Mode	0	f	50
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
-- Name: characters_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.characters_character_id_seq', 275, true);


--
-- Name: characters characters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);


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


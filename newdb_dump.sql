PGDMP             	            |           rpg_game %   14.13 (Ubuntu 14.13-0ubuntu0.22.04.1) %   14.13 (Ubuntu 14.13-0ubuntu0.22.04.1) "    9           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            :           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ;           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            <           1262    16449    rpg_game    DATABASE     ]   CREATE DATABASE rpg_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE rpg_game;
                postgres    false            �            1259    16514 
   characters    TABLE     Z  CREATE TABLE public.characters (
    character_id integer NOT NULL,
    name character varying(100) NOT NULL,
    race character varying(50),
    gender character varying(10),
    class character varying(50),
    hp integer,
    damage integer,
    armor integer,
    item_id integer[],
    equipped_weapon integer,
    equipped_armor integer
);
    DROP TABLE public.characters;
       public         heap    postgres    false            �            1259    16513    characters_character_id_seq    SEQUENCE     �   CREATE SEQUENCE public.characters_character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.characters_character_id_seq;
       public          postgres    false    216            =           0    0    characters_character_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.characters_character_id_seq OWNED BY public.characters.character_id;
          public          postgres    false    215            �            1259    16458    enemies    TABLE     �   CREATE TABLE public.enemies (
    id integer NOT NULL,
    name character varying(50),
    hp integer,
    damage integer,
    armor integer
);
    DROP TABLE public.enemies;
       public         heap    postgres    false            �            1259    16457    enemies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.enemies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.enemies_id_seq;
       public          postgres    false    212            >           0    0    enemies_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.enemies_id_seq OWNED BY public.enemies.id;
          public          postgres    false    211            �            1259    16451    heroes    TABLE     �   CREATE TABLE public.heroes (
    id integer NOT NULL,
    name character varying(50),
    race character varying(20),
    gender character varying(10),
    class character varying(20),
    hp integer,
    damage integer,
    armor integer
);
    DROP TABLE public.heroes;
       public         heap    postgres    false            �            1259    16450    heroes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.heroes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.heroes_id_seq;
       public          postgres    false    210            ?           0    0    heroes_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.heroes_id_seq OWNED BY public.heroes.id;
          public          postgres    false    209            �            1259    16481    items    TABLE       CREATE TABLE public.items (
    item_id integer NOT NULL,
    item_name character varying(100) NOT NULL,
    item_type character varying(50) NOT NULL,
    bonus_type character varying(50) NOT NULL,
    bonus_value integer NOT NULL,
    image_path character varying(255)
);
    DROP TABLE public.items;
       public         heap    postgres    false            �            1259    16480    items_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.items_item_id_seq;
       public          postgres    false    214            @           0    0    items_item_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;
          public          postgres    false    213            �           2604    16517    characters character_id    DEFAULT     �   ALTER TABLE ONLY public.characters ALTER COLUMN character_id SET DEFAULT nextval('public.characters_character_id_seq'::regclass);
 F   ALTER TABLE public.characters ALTER COLUMN character_id DROP DEFAULT;
       public          postgres    false    215    216    216            �           2604    16461 
   enemies id    DEFAULT     h   ALTER TABLE ONLY public.enemies ALTER COLUMN id SET DEFAULT nextval('public.enemies_id_seq'::regclass);
 9   ALTER TABLE public.enemies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211    212            �           2604    16454 	   heroes id    DEFAULT     f   ALTER TABLE ONLY public.heroes ALTER COLUMN id SET DEFAULT nextval('public.heroes_id_seq'::regclass);
 8   ALTER TABLE public.heroes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            �           2604    16484    items item_id    DEFAULT     n   ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);
 <   ALTER TABLE public.items ALTER COLUMN item_id DROP DEFAULT;
       public          postgres    false    213    214    214            6          0    16514 
   characters 
   TABLE DATA           �   COPY public.characters (character_id, name, race, gender, class, hp, damage, armor, item_id, equipped_weapon, equipped_armor) FROM stdin;
    public          postgres    false    216   �&       2          0    16458    enemies 
   TABLE DATA           >   COPY public.enemies (id, name, hp, damage, armor) FROM stdin;
    public          postgres    false    212   '       0          0    16451    heroes 
   TABLE DATA           R   COPY public.heroes (id, name, race, gender, class, hp, damage, armor) FROM stdin;
    public          postgres    false    210   �'       4          0    16481    items 
   TABLE DATA           c   COPY public.items (item_id, item_name, item_type, bonus_type, bonus_value, image_path) FROM stdin;
    public          postgres    false    214   �(       A           0    0    characters_character_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.characters_character_id_seq', 1, false);
          public          postgres    false    215            B           0    0    enemies_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.enemies_id_seq', 6, true);
          public          postgres    false    211            C           0    0    heroes_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.heroes_id_seq', 18, true);
          public          postgres    false    209            D           0    0    items_item_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.items_item_id_seq', 14, true);
          public          postgres    false    213            �           2606    16521    characters characters_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);
 D   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_pkey;
       public            postgres    false    216            �           2606    16463    enemies enemies_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.enemies
    ADD CONSTRAINT enemies_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.enemies DROP CONSTRAINT enemies_pkey;
       public            postgres    false    212            �           2606    16456    heroes heroes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.heroes DROP CONSTRAINT heroes_pkey;
       public            postgres    false    210            �           2606    16486    items items_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public            postgres    false    214            �           2606    16527 )   characters characters_equipped_armor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_armor_fkey FOREIGN KEY (equipped_armor) REFERENCES public.items(item_id) ON DELETE SET NULL;
 S   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_equipped_armor_fkey;
       public          postgres    false    216    3231    214            �           2606    16522 *   characters characters_equipped_weapon_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_weapon_fkey FOREIGN KEY (equipped_weapon) REFERENCES public.items(item_id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_equipped_weapon_fkey;
       public          postgres    false    216    3231    214            6      x������ � �      2   x   x�-�A� ��W�*����BV�V�}��l�`��	��!��%]�,���ޥ6�����gKw���g.�բ��R�\���S���d!�Y[=J��?0�B��g�݆7"��%u      0   �   x�m�1� �g���T��m�ťK�.j��MH���x��^����<����,�l��xk�F�s#���`�dR�2
��@r��^T�-�{��=�������W��a��'Ϗ��!�7ԝ�.��:�7�����u��Up��!X�1}{�FƉ$�$Vn�1Lr]�iX���":+#���������^�?Ⲏ����98��Rx�CK�	��eC7 :?��k�"wt �����h@�:q��؞�w      4     x�}ѽN1���~D���*`BH,]�ƽ��KN��ѷ�Uo@(�$C~���(�MuL�#�!���4��jװ{i��%鐿R�hSq�{�T$T+V?+�p��U�������K�l��ۤ�/S����,�Ǟ���_��B-e��f=�J=�H�"�y�w������Y���I����H�R�\�~��V���X2�8���,�$-���?X��Q���������v����c��A�Wayk 3:t����lvWM�|�     
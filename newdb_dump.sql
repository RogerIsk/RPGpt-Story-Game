PGDMP  2    &                |           rpg_game #   16.4 (Ubuntu 16.4-0ubuntu0.24.04.2) #   16.4 (Ubuntu 16.4-0ubuntu0.24.04.2) )    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16389    rpg_game    DATABASE     t   CREATE DATABASE rpg_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'oc_FR.UTF-8';
    DROP DATABASE rpg_game;
                postgres    false            �            1259    16438 
   characters    TABLE     F  CREATE TABLE public.characters (
    character_id integer NOT NULL,
    name character varying(100) NOT NULL,
    species character varying(50),
    gender character varying(10),
    class character varying(50),
    hp integer,
    damage integer,
    armor integer,
    equipped_weapon integer,
    equipped_armor integer
);
    DROP TABLE public.characters;
       public         heap    postgres    false            �            1259    16452    items    TABLE       CREATE TABLE public.items (
    item_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    bonus_type character varying(50) NOT NULL,
    bonus_value integer NOT NULL,
    image_file character varying(255)
);
    DROP TABLE public.items;
       public         heap    postgres    false            �            1259    16601    character_full_stats    VIEW     *  CREATE VIEW public.character_full_stats AS
 SELECT characters.character_id,
    characters.name,
    characters.species,
    characters.class,
    characters.hp,
    characters.damage,
    characters.armor,
    weapon.name AS equipped_weapon,
    weapon.bonus_value AS weapon_bonus,
    armor.name AS equipped_armor,
    armor.bonus_value AS armor_bonus
   FROM ((public.characters
     LEFT JOIN public.items weapon ON ((characters.equipped_weapon = weapon.item_id)))
     LEFT JOIN public.items armor ON ((characters.equipped_armor = armor.item_id)));
 '   DROP VIEW public.character_full_stats;
       public          postgres    false    215    215    215    221    215    215    215    215    221    221    215    215            �            1259    16443    characters_character_id_seq    SEQUENCE     �   CREATE SEQUENCE public.characters_character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.characters_character_id_seq;
       public          postgres    false    215            �           0    0    characters_character_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.characters_character_id_seq OWNED BY public.characters.character_id;
          public          postgres    false    216            �            1259    16444    enemies    TABLE     �   CREATE TABLE public.enemies (
    id integer NOT NULL,
    name character varying(50),
    hp integer,
    damage integer,
    armor integer
);
    DROP TABLE public.enemies;
       public         heap    postgres    false            �            1259    16447    enemies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.enemies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.enemies_id_seq;
       public          postgres    false    217            �           0    0    enemies_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.enemies_id_seq OWNED BY public.enemies.id;
          public          postgres    false    218            �            1259    16553    hero_with_equipped_weapon    VIEW     1  CREATE VIEW public.hero_with_equipped_weapon AS
 SELECT "character".character_id,
    "character".name,
    "character".class,
    item.name AS weapon_name,
    item.type AS weapon_type
   FROM (public.characters "character"
     JOIN public.items item ON (("character".equipped_weapon = item.item_id)));
 ,   DROP VIEW public.hero_with_equipped_weapon;
       public          postgres    false    221    215    215    221    221    215    215            �            1259    16448    heroes    TABLE     �   CREATE TABLE public.heroes (
    id integer NOT NULL,
    name character varying(50),
    species character varying(20),
    gender character varying(10),
    class character varying(20),
    hp integer,
    damage integer,
    armor integer
);
    DROP TABLE public.heroes;
       public         heap    postgres    false            �            1259    16451    heroes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.heroes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.heroes_id_seq;
       public          postgres    false    219            �           0    0    heroes_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.heroes_id_seq OWNED BY public.heroes.id;
          public          postgres    false    220            �            1259    16501 	   inventory    TABLE     c   CREATE TABLE public.inventory (
    character_id integer NOT NULL,
    item_id integer NOT NULL
);
    DROP TABLE public.inventory;
       public         heap    postgres    false            �            1259    16455    items_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.items_item_id_seq;
       public          postgres    false    221            �           0    0    items_item_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;
          public          postgres    false    222                       2604    16456    characters character_id    DEFAULT     �   ALTER TABLE ONLY public.characters ALTER COLUMN character_id SET DEFAULT nextval('public.characters_character_id_seq'::regclass);
 F   ALTER TABLE public.characters ALTER COLUMN character_id DROP DEFAULT;
       public          postgres    false    216    215                       2604    16457 
   enemies id    DEFAULT     h   ALTER TABLE ONLY public.enemies ALTER COLUMN id SET DEFAULT nextval('public.enemies_id_seq'::regclass);
 9   ALTER TABLE public.enemies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217                       2604    16458 	   heroes id    DEFAULT     f   ALTER TABLE ONLY public.heroes ALTER COLUMN id SET DEFAULT nextval('public.heroes_id_seq'::regclass);
 8   ALTER TABLE public.heroes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            	           2604    16459    items item_id    DEFAULT     n   ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);
 <   ALTER TABLE public.items ALTER COLUMN item_id DROP DEFAULT;
       public          postgres    false    222    221            �          0    16438 
   characters 
   TABLE DATA           �   COPY public.characters (character_id, name, species, gender, class, hp, damage, armor, equipped_weapon, equipped_armor) FROM stdin;
    public          postgres    false    215   b2       �          0    16444    enemies 
   TABLE DATA           >   COPY public.enemies (id, name, hp, damage, armor) FROM stdin;
    public          postgres    false    217   �2       �          0    16448    heroes 
   TABLE DATA           U   COPY public.heroes (id, name, species, gender, class, hp, damage, armor) FROM stdin;
    public          postgres    false    219   ,3       �          0    16501 	   inventory 
   TABLE DATA           :   COPY public.inventory (character_id, item_id) FROM stdin;
    public          postgres    false    223   64       �          0    16452    items 
   TABLE DATA           Y   COPY public.items (item_id, name, type, bonus_type, bonus_value, image_file) FROM stdin;
    public          postgres    false    221   c4       �           0    0    characters_character_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.characters_character_id_seq', 2, true);
          public          postgres    false    216            �           0    0    enemies_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.enemies_id_seq', 6, true);
          public          postgres    false    218            �           0    0    heroes_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.heroes_id_seq', 18, true);
          public          postgres    false    220            �           0    0    items_item_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.items_item_id_seq', 14, true);
          public          postgres    false    222                       2606    16461    characters characters_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);
 D   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_pkey;
       public            postgres    false    215                       2606    16463    enemies enemies_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.enemies
    ADD CONSTRAINT enemies_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.enemies DROP CONSTRAINT enemies_pkey;
       public            postgres    false    217                       2606    16465    heroes heroes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.heroes DROP CONSTRAINT heroes_pkey;
       public            postgres    false    219                       2606    16505    inventory inventory_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (character_id, item_id);
 B   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_pkey;
       public            postgres    false    223    223                       2606    16467    items items_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public            postgres    false    221                       2606    16468 )   characters characters_equipped_armor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_armor_fkey FOREIGN KEY (equipped_armor) REFERENCES public.items(item_id) ON DELETE SET NULL;
 S   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_equipped_armor_fkey;
       public          postgres    false    3345    221    215                       2606    16473 *   characters characters_equipped_weapon_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_weapon_fkey FOREIGN KEY (equipped_weapon) REFERENCES public.items(item_id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_equipped_weapon_fkey;
       public          postgres    false    3345    215    221                       2606    16506 %   inventory inventory_character_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_character_id_fkey FOREIGN KEY (character_id) REFERENCES public.characters(character_id);
 O   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_character_id_fkey;
       public          postgres    false    223    215    3339                       2606    16511     inventory inventory_item_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(item_id);
 J   ALTER TABLE ONLY public.inventory DROP CONSTRAINT inventory_item_id_fkey;
       public          postgres    false    221    3345    223            �   2   x�3��/J�L�I�LK�M�I�,J�KO-�45�44��4�4����� 2
U      �   x   x�-�A� ��W�*����BV�V�}��l�`��	��!��%]�,���ޥ6�����gKw���g.�բ��R�\���S���d!�Y[=J��?0�B��g�݆7"��%u      �   �   x�m�1� �g���T��m�ťK�.j��MH���x��^����<����,�l��xk�F�s#���`�dR�2
��@r��^T�-�{��=�������W��a��'Ϗ��!�7ԝ�.��:�7�����u��Up��!X�1}{�FƉ$�$Vn�1Lr]�iX���":+#���������^�?Ⲏ����98��Rx�CK�	��eC7 :?��k�"wt �����h@�:q��؞�w      �      x�3�4�2�44 l
�s��qqq 0Ib      �   �  x�m��N�0���S�A[
,��e�#���8���&q�1
�=�ۓV�����23���xU�^ޫZ#_�m����zu�@3%sa�C=��F� �*�Q~����<Ǜ���@g��w��ۮS5�"(��+͑a�uO ;����*v��C0�Wm�U�i+�Q5�{�$<Z�*��Ļ�g�*�G�.sMsP2��s�׆m#cv����V���qS�,#��By@�I�դxVĘ�k�����F�I��"n�|����FG�^-��y=��G�01 atd��`�b�,�?�1S����X�@P�n?��IzyE� ���bmj����u��󵫈@����Ơ�3�ت��m�'�աb&��$`&���d����.X���b~�_�&"�K�Amw'|����WL0��b6��8(5Y     
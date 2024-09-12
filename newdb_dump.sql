PGDMP  "                    |           rpg_game #   16.4 (Ubuntu 16.4-0ubuntu0.24.04.2) #   16.4 (Ubuntu 16.4-0ubuntu0.24.04.2) "    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16389    rpg_game    DATABASE     t   CREATE DATABASE rpg_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'oc_FR.UTF-8';
    DROP DATABASE rpg_game;
                postgres    false            �            1259    16438 
   characters    TABLE     [  CREATE TABLE public.characters (
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
    DROP TABLE public.characters;
       public         heap    postgres    false            �            1259    16443    characters_character_id_seq    SEQUENCE     �   CREATE SEQUENCE public.characters_character_id_seq
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
          public          postgres    false    218            �            1259    16448    heroes    TABLE     �   CREATE TABLE public.heroes (
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
          public          postgres    false    220            �            1259    16452    items    TABLE       CREATE TABLE public.items (
    item_id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    bonus_type character varying(50) NOT NULL,
    bonus_value integer NOT NULL,
    image_file character varying(255)
);
    DROP TABLE public.items;
       public         heap    postgres    false            �            1259    16455    items_item_id_seq    SEQUENCE     �   CREATE SEQUENCE public.items_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.items_item_id_seq;
       public          postgres    false    221            �           0    0    items_item_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.items_item_id_seq OWNED BY public.items.item_id;
          public          postgres    false    222            �           2604    16456    characters character_id    DEFAULT     �   ALTER TABLE ONLY public.characters ALTER COLUMN character_id SET DEFAULT nextval('public.characters_character_id_seq'::regclass);
 F   ALTER TABLE public.characters ALTER COLUMN character_id DROP DEFAULT;
       public          postgres    false    216    215            �           2604    16457 
   enemies id    DEFAULT     h   ALTER TABLE ONLY public.enemies ALTER COLUMN id SET DEFAULT nextval('public.enemies_id_seq'::regclass);
 9   ALTER TABLE public.enemies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217            �           2604    16458 	   heroes id    DEFAULT     f   ALTER TABLE ONLY public.heroes ALTER COLUMN id SET DEFAULT nextval('public.heroes_id_seq'::regclass);
 8   ALTER TABLE public.heroes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            �           2604    16459    items item_id    DEFAULT     n   ALTER TABLE ONLY public.items ALTER COLUMN item_id SET DEFAULT nextval('public.items_item_id_seq'::regclass);
 <   ALTER TABLE public.items ALTER COLUMN item_id DROP DEFAULT;
       public          postgres    false    222    221            �          0    16438 
   characters 
   TABLE DATA           �   COPY public.characters (character_id, name, species, gender, class, hp, damage, armor, items, equipped_weapon, equipped_armor) FROM stdin;
    public          postgres    false    215   �&       �          0    16444    enemies 
   TABLE DATA           >   COPY public.enemies (id, name, hp, damage, armor) FROM stdin;
    public          postgres    false    217   �&       �          0    16448    heroes 
   TABLE DATA           U   COPY public.heroes (id, name, species, gender, class, hp, damage, armor) FROM stdin;
    public          postgres    false    219   o'       �          0    16452    items 
   TABLE DATA           Y   COPY public.items (item_id, name, type, bonus_type, bonus_value, image_file) FROM stdin;
    public          postgres    false    221   y(       �           0    0    characters_character_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.characters_character_id_seq', 1, false);
          public          postgres    false    216            �           0    0    enemies_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.enemies_id_seq', 6, true);
          public          postgres    false    218            �           0    0    heroes_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.heroes_id_seq', 18, true);
          public          postgres    false    220            �           0    0    items_item_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.items_item_id_seq', 14, true);
          public          postgres    false    222            �           2606    16461    characters characters_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_pkey PRIMARY KEY (character_id);
 D   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_pkey;
       public            postgres    false    215                       2606    16463    enemies enemies_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.enemies
    ADD CONSTRAINT enemies_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.enemies DROP CONSTRAINT enemies_pkey;
       public            postgres    false    217                       2606    16465    heroes heroes_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.heroes
    ADD CONSTRAINT heroes_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.heroes DROP CONSTRAINT heroes_pkey;
       public            postgres    false    219                       2606    16467    items items_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public            postgres    false    221                       2606    16468 )   characters characters_equipped_armor_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_armor_fkey FOREIGN KEY (equipped_armor) REFERENCES public.items(item_id) ON DELETE SET NULL;
 S   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_equipped_armor_fkey;
       public          postgres    false    221    3333    215                       2606    16473 *   characters characters_equipped_weapon_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.characters
    ADD CONSTRAINT characters_equipped_weapon_fkey FOREIGN KEY (equipped_weapon) REFERENCES public.items(item_id) ON DELETE SET NULL;
 T   ALTER TABLE ONLY public.characters DROP CONSTRAINT characters_equipped_weapon_fkey;
       public          postgres    false    3333    215    221            �      x������ � �      �   x   x�-�A� ��W�*����BV�V�}��l�`��	��!��%]�,���ޥ6�����gKw���g.�բ��R�\���S���d!�Y[=J��?0�B��g�݆7"��%u      �   �   x�m�1� �g���T��m�ťK�.j��MH���x��^����<����,�l��xk�F�s#���`�dR�2
��@r��^T�-�{��=�������W��a��'Ϗ��!�7ԝ�.��:�7�����u��Up��!X�1}{�FƉ$�$Vn�1Lr]�iX���":+#���������^�?Ⲏ����98��Rx�CK�	��eC7 :?��k�"wt �����h@�:q��؞�w      �   �  x�m�Mn�0F��)|�A�%R��Ģ�n�$.IٮRn��؁�����}�����M�K�}�x't˄�M��2>�$"���Pg;�����T\
{�s�z��&``*�0��������k�ܚR=$�S@�@� �2��U��wǕW�mȫ��VF%l�M����1o�>�va&�W�<#^�T�@D.�9����p�����Z�R��MmS�؈��I�4h��@F�T;�]�v�F�����#N��?���G�~/��n4V�C��[$ 
 �"��Hw��F̓�/r�(p N�n�m��.n�D��;�Z;ޚ�.���vHi[vTNᙬZ�a����I��*&�����_������k�ҭX�L/�P#�����~��xA�ߋ,��]8�     
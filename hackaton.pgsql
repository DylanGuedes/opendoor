--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: air_qualities; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE air_qualities (
    id bigint NOT NULL,
    worker_uuid character varying,
    worker integer,
    uuid character varying,
    platform_id bigint,
    region character varying,
    lat double precision,
    lon double precision,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    step integer
);


ALTER TABLE air_qualities OWNER TO dylan;

--
-- Name: air_qualities_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE air_qualities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE air_qualities_id_seq OWNER TO dylan;

--
-- Name: air_qualities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE air_qualities_id_seq OWNED BY air_qualities.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO dylan;

--
-- Name: bike_stations; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE bike_stations (
    id bigint NOT NULL,
    worker_uuid character varying,
    worker integer,
    uuid character varying,
    platform_id bigint,
    bike_station_uuid character varying,
    lat double precision,
    lon double precision,
    step integer,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    address character varying
);


ALTER TABLE bike_stations OWNER TO dylan;

--
-- Name: bike_stations_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE bike_stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bike_stations_id_seq OWNER TO dylan;

--
-- Name: bike_stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE bike_stations_id_seq OWNED BY bike_stations.id;


--
-- Name: initiatives; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE initiatives (
    id bigint NOT NULL,
    worker_uuid character varying,
    worker integer,
    uuid character varying,
    platform_id bigint,
    region character varying,
    lat double precision,
    lon double precision,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying,
    address character varying,
    state character varying,
    city character varying
);


ALTER TABLE initiatives OWNER TO dylan;

--
-- Name: initiatives_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE initiatives_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE initiatives_id_seq OWNER TO dylan;

--
-- Name: initiatives_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE initiatives_id_seq OWNED BY initiatives.id;


--
-- Name: platforms; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE platforms (
    id bigint NOT NULL,
    url character varying,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE platforms OWNER TO dylan;

--
-- Name: platforms_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE platforms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE platforms_id_seq OWNER TO dylan;

--
-- Name: platforms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE platforms_id_seq OWNED BY platforms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO dylan;

--
-- Name: static_entities; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE static_entities (
    id bigint NOT NULL,
    worker_uuid character varying,
    worker integer,
    uuid character varying,
    platform_id bigint,
    lat double precision,
    lon double precision,
    status character varying
);


ALTER TABLE static_entities OWNER TO dylan;

--
-- Name: static_entities_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE static_entities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE static_entities_id_seq OWNER TO dylan;

--
-- Name: static_entities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE static_entities_id_seq OWNED BY static_entities.id;


--
-- Name: weathers; Type: TABLE; Schema: public; Owner: dylan
--

CREATE TABLE weathers (
    id bigint NOT NULL,
    worker_uuid character varying,
    worker integer,
    uuid character varying,
    platform_id bigint,
    region character varying,
    neighborhood character varying,
    lat double precision,
    lon double precision,
    status character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE weathers OWNER TO dylan;

--
-- Name: weathers_id_seq; Type: SEQUENCE; Schema: public; Owner: dylan
--

CREATE SEQUENCE weathers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE weathers_id_seq OWNER TO dylan;

--
-- Name: weathers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dylan
--

ALTER SEQUENCE weathers_id_seq OWNED BY weathers.id;


--
-- Name: air_qualities id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY air_qualities ALTER COLUMN id SET DEFAULT nextval('air_qualities_id_seq'::regclass);


--
-- Name: bike_stations id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY bike_stations ALTER COLUMN id SET DEFAULT nextval('bike_stations_id_seq'::regclass);


--
-- Name: initiatives id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY initiatives ALTER COLUMN id SET DEFAULT nextval('initiatives_id_seq'::regclass);


--
-- Name: platforms id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY platforms ALTER COLUMN id SET DEFAULT nextval('platforms_id_seq'::regclass);


--
-- Name: static_entities id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY static_entities ALTER COLUMN id SET DEFAULT nextval('static_entities_id_seq'::regclass);


--
-- Name: weathers id; Type: DEFAULT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY weathers ALTER COLUMN id SET DEFAULT nextval('weathers_id_seq'::regclass);


--
-- Data for Name: air_qualities; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY air_qualities (id, worker_uuid, worker, uuid, platform_id, region, lat, lon, status, created_at, updated_at, step) FROM stdin;
1	Capão Redondo	0	49a19020-a32e-43f3-9bb3-2ded10282444	1	Capão Redondo	-23.6684610999999983	-46.7689718999999968	active	2017-11-10 13:21:33.038937	2017-11-10 13:21:33.815655	\N
2	Carapicuíba	0	7f07503d-a8ce-4acb-8649-7b070eac78bf	1	Carapicuíba	-23.5239623000000009	-46.841124299999997	active	2017-11-10 13:21:34.949184	2017-11-10 13:21:35.432534	\N
3	Cerqueira César	0	5d80d3c0-750c-4e63-aa73-723dc220db8c	1	Cerqueira César	-23.5592143999999983	-46.6677316999999974	active	2017-11-10 13:22:20.297799	2017-11-10 13:22:20.833109	\N
4	Congonhas	0	f2510708-35c2-43d5-85f8-2864fd0f6bff	1	Congonhas	-23.6273246000000015	-46.6565841999999975	active	2017-11-10 13:22:21.716144	2017-11-10 13:22:22.061422	\N
5	Grajau-Parelheiros	0	2da07c5b-4272-487e-95fc-426e15937de6	1	Grajau-Parelheiros	-23.8310662999999998	-46.7303617000000031	active	2017-11-10 13:22:23.012923	2017-11-10 13:22:23.554498	\N
6	Guarulhos-Paço Municipal	0	2576c342-1b82-4193-af2a-462b3707f99f	1	Guarulhos-Paço Municipal	-23.5989930000000001	-46.6245694999999998	active	2017-11-10 13:22:46.883142	2017-11-10 13:22:47.415881	\N
7	Guarulhos-Pimentas	0	044e7b0b-1fed-4cc5-b4f6-13ee009bc73b	1	Guarulhos-Pimentas	-23.4533668000000013	-46.4064848000000012	active	2017-11-10 13:22:48.363476	2017-11-10 13:22:48.91599	\N
8	Ibirapuera	0	0c80ab30-6ad7-4af3-bc8a-1f7de762faa5	1	Ibirapuera	-23.5874161999999998	-46.6576335999999969	active	2017-11-10 13:23:57.222203	2017-11-10 13:23:57.553828	\N
9	Interlagos	0	7dd90ecb-4e2b-4546-aa67-713881f5c47d	1	Interlagos	-23.7001625000000011	-46.6967355999999967	active	2017-11-10 13:23:58.465711	2017-11-10 13:23:58.793841	\N
10	Capão Redondo	0	a09b2202-a332-4ee1-b5e9-36b8d357e11f	2	Capão Redondo	-23.6684610999999983	-46.7689718999999968	active	2017-11-10 13:29:17.146166	2017-11-10 13:29:17.43638	\N
11	Carapicuíba	0	2ee9af98-754c-4458-a15d-002f5bcf85eb	2	Carapicuíba	-23.5239623000000009	-46.841124299999997	active	2017-11-10 13:31:00.693574	2017-11-10 13:31:01.189495	\N
12	Cerqueira César	0	f09688e9-d2b4-4604-97f2-d6c86ff8276c	2	Cerqueira César	-23.5592143999999983	-46.6677316999999974	active	2017-11-10 13:35:43.343618	2017-11-10 13:35:44.016226	\N
13	Congonhas	0	482865b7-15a9-49ca-9170-12d98c485a69	2	Congonhas	-23.6273246000000015	-46.6565841999999975	active	2017-11-10 13:35:45.087975	2017-11-10 13:35:45.795346	\N
14	Grajau-Parelheiros	0	75e00fef-c974-4bee-b51b-3c9a4b1d2a27	2	Grajau-Parelheiros	-23.8310662999999998	-46.7303617000000031	active	2017-11-10 13:35:46.549588	2017-11-10 13:35:47.201863	\N
15	Guarulhos-Paço Municipal	0	0081d919-412c-4550-b4e6-489222bddfc5	2	Guarulhos-Paço Municipal	-23.5989930000000001	-46.6245694999999998	active	2017-11-10 13:35:47.299862	2017-11-10 13:35:47.893504	\N
16	Guarulhos-Pimentas	0	ccac2e35-7009-4c43-a582-0248271bd7b7	2	Guarulhos-Pimentas	-23.4533668000000013	-46.4064848000000012	active	2017-11-10 13:35:48.794153	2017-11-10 13:35:49.234333	\N
17	Ibirapuera	0	06e8fe5e-78e4-4704-9371-84c136a0f26a	2	Ibirapuera	-23.5874161999999998	-46.6576335999999969	active	2017-11-10 13:40:38.669775	2017-11-10 13:40:39.712542	\N
18	Itaim Paulista	0	e08e9e2f-c34e-4057-a9da-84b9422793ba	1	Itaim Paulista	-23.4691052999999989	-46.4036655000000025	active	2017-11-10 13:47:22.642009	2017-11-10 13:47:23.25038	\N
19	Itaquera	0	95381d9a-cf56-4395-8d06-6080555db8c2	1	Itaquera	-23.5398463000000007	-46.4475327999999976	active	2017-11-10 13:47:24.098269	2017-11-10 13:47:24.634071	\N
20	Marg.Tietê-Pte Remédios	0	ac3b86b3-90e8-4fa5-8444-57f6225e6c6a	1	Marg.Tietê-Pte Remédios	-23.5226493000000012	-46.748647400000003	active	2017-11-10 13:47:25.483458	2017-11-10 13:47:25.860543	\N
21	Mauá	0	d7d129cc-e863-44a6-8ea4-52739e09bcd3	1	Mauá	-23.6681629999999998	-46.4617085999999873	active	2017-11-10 13:47:26.782881	2017-11-10 13:47:27.279551	\N
22	Mogi das Cruzes	0	8e56769f-1b22-4b33-9c42-c4519e5761f3	1	Mogi das Cruzes	-23.5213378999999989	-46.1858669999999876	active	2017-11-10 13:47:28.255837	2017-11-10 13:47:28.601242	\N
23	Mooca	0	fb756a0c-4037-4432-8e8e-b1af41d0db97	1	Mooca	-23.5603264999999986	-46.5995903000000027	active	2017-11-10 13:47:29.503882	2017-11-10 13:47:30.065878	\N
24	N.Senhora do Ó	0	02742cd8-ba6e-4cea-8089-e929b1464ee5	1	N.Senhora do Ó	-23.4991968	-46.7031368000000029	active	2017-11-10 13:47:31.093697	2017-11-10 13:47:31.48791	\N
25	Osasco	0	787ed0ee-f6e7-4534-949b-13773c66eb0c	1	Osasco	-23.5328870999999999	-46.7919977999999972	active	2017-11-10 14:11:25.723612	2017-11-10 14:11:26.196703	\N
26	Interlagos	0	\N	2	Interlagos	-23.7001625000000011	-46.6967355999999967	active	2017-11-10 14:17:05.721228	2017-11-10 14:17:05.721228	\N
27	Itaim Paulista	0	\N	2	Itaim Paulista	-23.4691052999999989	-46.4036655000000025	active	2017-11-10 14:19:07.59516	2017-11-10 14:19:07.59516	\N
28	Pico do Jaraguá	0	f7c98070-e9fd-4d54-a5f7-b0d5a482eead	1	Pico do Jaraguá	-23.4583329999999997	-46.7652780000000021	active	2017-11-10 14:53:32.543951	2017-11-10 14:53:32.993064	\N
29	Pinheiros	0	17ab1378-36cf-4131-a215-b3d2bc20ce34	1	Pinheiros	-23.5630036999999994	-46.6864347000000066	active	2017-11-10 14:53:33.933002	2017-11-10 14:53:34.471912	\N
30	S.André-Capuava	0	49fd3af5-604d-4866-9382-debfc795666e	1	S.André-Capuava	-23.6575112999999995	-46.4934030000000078	active	2017-11-10 16:26:20.077268	2017-11-10 16:26:20.607008	\N
31	S.Bernardo-Centro	0	06f85e86-d03d-40af-a3b9-386aa4e07307	1	S.Bernardo-Centro	-23.7015513999999996	-46.5529056000000026	active	2017-11-10 16:26:21.715941	2017-11-10 16:26:22.264793	\N
32	S.Bernardo-Paulicéia	0	53c1f44b-cd9e-4af4-8ac6-11ac162e86c2	1	S.Bernardo-Paulicéia	-23.6671936000000009	-46.5861072000000007	active	2017-11-10 16:26:23.157656	2017-11-10 16:26:23.702839	\N
33	Santana	0	1ddfb90a-fe89-44f6-9449-118c621cec89	1	Santana	-23.4981809999999989	-46.6263306000000028	active	2017-11-10 16:26:24.696094	2017-11-10 16:26:25.04758	\N
34	Santo Amaro	0	5b0a7eb2-9313-48d9-929f-c49d6e2c5485	1	Santo Amaro	38.9687967999999998	-7.58297820000000034	active	2017-11-10 16:26:25.080202	2017-11-10 16:26:25.207249	\N
35	São Caetano do Sul	0	7823dc94-c0eb-4762-9d2a-c399746d0797	1	São Caetano do Sul	-23.6233624999999989	-46.5552433000000008	active	2017-11-10 16:26:26.145812	2017-11-10 16:26:26.716213	\N
36	Taboão da Serra	0	a4412759-d5ea-4fdf-a802-34ff35c463de	1	Taboão da Serra	-23.6228759000000004	-46.7816647000000003	active	2017-11-10 16:26:27.614485	2017-11-10 16:26:27.934308	\N
37	Itaquera	0	13c0c080-d4d0-4639-8908-f83a3544f8e0	2	Itaquera	-23.5398463000000007	-46.4475327999999976	active	2017-11-10 20:20:33.453975	2017-11-10 20:20:34.118585	\N
38	Marg.Tietê-Pte Remédios	0	9cfc3c56-6988-47a4-8106-3117c87cbf22	2	Marg.Tietê-Pte Remédios	-23.5226493000000012	-46.748647400000003	active	2017-11-10 20:20:35.067249	2017-11-10 20:20:35.602956	\N
39	Mauá	0	bed37df5-5a3b-4097-8d6a-826b532eb5b6	2	Mauá	-23.6681629999999998	-46.4617085999999873	active	2017-11-10 20:20:36.51608	2017-11-10 20:20:37.093976	\N
40	Mogi das Cruzes	0	5f38d7af-dd99-42d4-9ce5-2e2903921e8c	2	Mogi das Cruzes	-23.5213378999999989	-46.1858669999999876	active	2017-11-10 20:20:38.048061	2017-11-10 20:20:38.596966	\N
41	Mooca	0	0cb2cd56-e84f-4533-ae9d-1c90f396aa21	2	Mooca	-23.5603264999999986	-46.5995903000000027	active	2017-11-10 20:21:16.26138	2017-11-10 20:21:16.659568	\N
42	N.Senhora do Ó	0	e7601996-2744-462f-876f-fbad8e85eee5	2	N.Senhora do Ó	-23.4991968	-46.7031368000000029	active	2017-11-10 20:23:56.650002	2017-11-10 20:23:57.335073	\N
43	Osasco	0	8a4ce17c-0f7c-4f34-9feb-e1e4b10c9f04	2	Osasco	-23.5328870999999999	-46.7919977999999972	active	2017-11-10 20:23:58.435429	2017-11-10 20:23:58.930892	\N
44	Pico do Jaraguá	0	782749a0-0540-4433-9a58-6aae03c7bc44	2	Pico do Jaraguá	-23.4583329999999997	-46.7652780000000021	active	2017-11-10 20:27:18.629973	2017-11-10 20:27:19.118032	\N
45	Pinheiros	0	8d489149-01ae-43f5-8482-d434460e4c39	2	Pinheiros	-23.5630036999999994	-46.6864347000000066	active	2017-11-10 20:27:20.166866	2017-11-10 20:27:20.546316	\N
46	S.Bernardo-Centro	0	efb297ad-4c34-4902-b039-35cd81d44175	2	S.Bernardo-Centro	-23.7015513999999996	-46.5529056000000026	active	2017-11-10 20:27:21.613503	2017-11-10 20:27:22.051118	\N
47	S.Bernardo-Paulicéia	0	179fb793-6c9a-457f-888b-b63a3aad9040	2	S.Bernardo-Paulicéia	-23.6671936000000009	-46.5861072000000007	active	2017-11-10 20:27:22.969745	2017-11-10 20:27:23.358678	\N
48	Santana	0	eb87aee8-a25b-46e5-ba03-588db6e7f7d1	2	Santana	-23.4981809999999989	-46.6263306000000028	active	2017-11-10 20:27:23.39726	2017-11-10 20:27:23.834956	\N
49	Santo Amaro	0	a17c5747-6e10-4967-b562-aac4b5aa0985	2	Santo Amaro	38.9687967999999998	-7.58297820000000034	active	2017-11-10 20:27:23.897072	2017-11-10 20:27:24.325068	\N
50	São Caetano do Sul	0	cca7f784-df82-4323-a591-cebe63136397	2	São Caetano do Sul	-23.6233624999999989	-46.5552433000000008	active	2017-11-10 20:27:25.540171	2017-11-10 20:27:25.821539	\N
51	Taboão da Serra	0	e2b74a8e-e0fd-424d-9fb6-14902b44ffff	2	Taboão da Serra	-23.6228759000000004	-46.7816647000000003	active	2017-11-10 20:27:26.64912	2017-11-10 20:27:27.071933	\N
\.


--
-- Name: air_qualities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('air_qualities_id_seq', 51, true);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-11-09 23:21:00.197188	2017-11-09 23:21:00.197188
\.


--
-- Data for Name: bike_stations; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY bike_stations (id, worker_uuid, worker, uuid, platform_id, bike_station_uuid, lat, lon, step, status, created_at, updated_at, address) FROM stdin;
665	5680224655e3ac2d97b2f67919a0012e	0	2dfc1b93-11f9-4fce-9574-a86abb8667a8	2	5680224655e3ac2d97b2f67919a0012e	-23.9443739999999998	-46.3814240000000026	\N	active	2017-11-10 19:45:13.333792	2017-11-10 19:45:13.776695	Av. Afonso Schimidt
666	7c3ee0e1a37a5a8396ef011b3a563d29	0	d05f3709-0443-4786-b3e3-6530f0c1b3a6	2	7c3ee0e1a37a5a8396ef011b3a563d29	-23.9708129999999997	-46.3294849999999983	\N	active	2017-11-10 19:45:13.813282	2017-11-10 19:45:14.151867	Avenida Washington Luis / Esquina Avenida Vicente de Carvalho
683	3d7488bd91f71ac76138c768eb356320	0	695939af-ad96-4f65-a952-a1257619cabc	2	3d7488bd91f71ac76138c768eb356320	-23.9800429999999984	-46.3131580000000014	\N	active	2017-11-10 19:45:21.662114	2017-11-10 19:45:22.570861	Av. Bartolomeu de Gusmão
678	e22963b87513984c063d6f5eb8dd3fe2	0	dee44e80-64da-4986-b58b-649a1f4c240f	2	e22963b87513984c063d6f5eb8dd3fe2	-23.9373679999999993	-46.3255690000000016	\N	active	2017-11-10 19:45:19.589565	2017-11-10 19:45:20.182016	Avenida Senador Feijó
667	45b70fbe1d676d00fe652a8aea02273e	0	eaa92b90-e4e4-4c02-8f15-6dbbc97cbcff	2	45b70fbe1d676d00fe652a8aea02273e	-23.9679989999999989	-46.3491939999999971	\N	active	2017-11-10 19:45:14.188111	2017-11-10 19:45:14.614985	Avenida Presidente Wilson
668	86b4d97226ead612287c2e012e587070	0	64105905-3957-419e-9cae-57ef8eedc9e4	2	86b4d97226ead612287c2e012e587070	-23.9908789999999996	-46.3048190000000019	\N	active	2017-11-10 19:45:14.637444	2017-11-10 19:45:15.229807	Avenida Almirante Saldanha da Gama
669	bfcd664810fc003f4dcedee3c14032f6	0	af6f78b8-81f7-426d-b125-9bfcb1e3a8be	2	bfcd664810fc003f4dcedee3c14032f6	-23.9805470000000014	-46.300023000000003	\N	active	2017-11-10 19:45:15.252447	2017-11-10 19:45:15.702581	Praça Eng. José Rebouças
670	62ce17e805d85aca4edd3ba7ec3fceba	0	96018a13-220f-4443-9526-2ba1c80a6af6	2	62ce17e805d85aca4edd3ba7ec3fceba	-23.9765279999999983	-46.3119859999999974	\N	active	2017-11-10 19:45:15.724837	2017-11-10 19:45:16.052053	Rua Conselheiro Ribas
671	23fc5b84d369c141cf7cdd6d97ebdd54	0	49d4489c-1458-4a46-bb15-15b6df7b9018	2	23fc5b84d369c141cf7cdd6d97ebdd54	-23.9749200000000009	-46.3200649999999996	\N	active	2017-11-10 19:45:16.080839	2017-11-10 19:45:16.411609	Avenida Bartolomeu
672	dbe8a5e5f82ff04eaef664267834988a	0	4e76305e-3fbe-48fa-80e1-b5e921d83175	2	dbe8a5e5f82ff04eaef664267834988a	-23.9643130000000006	-46.3215670000000017	\N	active	2017-11-10 19:45:16.433	2017-11-10 19:45:17.713153	Rua Oswaldo Cruz
673	b3d18ffdcba7fffd7e455cde2e6160b2	0	b522b787-3ad8-453f-ba12-9814ed5b3af4	2	b3d18ffdcba7fffd7e455cde2e6160b2	-23.9680970000000002	-46.3331009999999992	\N	active	2017-11-10 19:45:17.752636	2017-11-10 19:45:18.073356	Avenida Dona Ana Costa
674	3d3bdcce092d503546aef22ef4b7f48d	0	5011bc37-37bf-404a-a4e8-7da314b7f100	2	3d3bdcce092d503546aef22ef4b7f48d	-23.9617240000000002	-46.3375849999999971	\N	active	2017-11-10 19:45:18.112709	2017-11-10 19:45:18.424359	Avenida Marechal Deodoro
675	d16a1538d0c96f9e80e343c54c12af7d	0	7ca2d1a2-25e5-4637-affe-303bee29cbaa	2	d16a1538d0c96f9e80e343c54c12af7d	-23.9730510000000017	-46.3023730000000029	\N	active	2017-11-10 19:45:18.447567	2017-11-10 19:45:18.738138	Praça Nossa Senhora Aparecida
676	3c5e1fa48e40117c681d81d2736389cd	0	8cb1b505-8fbc-477d-b21b-eeddea5afb6a	2	3c5e1fa48e40117c681d81d2736389cd	-23.9519389999999994	-46.3298389999999998	\N	active	2017-11-10 19:45:18.75654	2017-11-10 19:45:19.222413	Rua Julio Conceicao
677	c31a053c46acd1b1ce812cff0aef3951	0	c3311a62-419e-4ec0-8b58-33705d81c1cf	2	c31a053c46acd1b1ce812cff0aef3951	-23.9568030000000007	-46.3232939999999971	\N	active	2017-11-10 19:45:19.247017	2017-11-10 19:45:19.571321	Rua Barão de Paranapiacaba
679	b886673c4007e8a5afaa884af29023dc	0	eabe6702-c9bb-486b-857f-1a6ad39eb49c	2	b886673c4007e8a5afaa884af29023dc	-23.9333279999999995	-46.3284439999999975	\N	active	2017-11-10 19:45:20.205978	2017-11-10 19:45:20.502216	Praça Visconde de Mauá
680	b8cf1faf68e01e9828dc69fd242e24f2	0	2d401321-a11f-4651-8991-d364a789d822	2	b8cf1faf68e01e9828dc69fd242e24f2	-23.9684990000000013	-46.3394410000000008	\N	active	2017-11-10 19:45:20.528993	2017-11-10 19:45:20.831593	Avenida Presidente Wilson / Esquina Avenida Bernardino de Campos
681	750ccac55a338c3823f581fa01b1e468	0	164671eb-d023-499b-86f0-4d43905762d0	2	750ccac55a338c3823f581fa01b1e468	-23.9863399999999984	-46.3083269999999985	\N	active	2017-11-10 19:45:20.850238	2017-11-10 19:45:21.153216	Avenida Bartolomeu de Gusmão
682	1397dd9003da09d5072b6930f5285308	0	0591d570-0e9a-4c73-bcdf-9f351982425f	2	1397dd9003da09d5072b6930f5285308	-23.988232	-46.2963000000000022	\N	active	2017-11-10 19:45:21.171012	2017-11-10 19:45:21.61891	Avenida Almirante Saldanha da Gama
684	bd00a12042481147005b7562c73329cf	0	cefc460e-8b6a-49a8-a5d4-0b666131de44	2	bd00a12042481147005b7562c73329cf	-23.9590579999999989	-46.3318340000000006	\N	active	2017-11-10 19:45:22.610211	2017-11-10 19:45:23.10465	Avenida Dona Ana Costa (Praça dos Expedicionários) / Esquina Avenida General Francisco Glicério
685	a9a579c7daecff04bb853493ecc04887	0	1c349687-4dfa-4522-b080-7b698165b5ef	2	a9a579c7daecff04bb853493ecc04887	-23.9615180000000016	-46.3456740000000025	\N	active	2017-11-10 19:45:23.131414	2017-11-10 19:45:23.758642	Rua João Caetano
686	d05123e9d1762c8bcc51a2c7f67c0ed1	0	21d9e4f4-3616-4e1d-8305-0b4fa07bbf1c	2	d05123e9d1762c8bcc51a2c7f67c0ed1	-23.9645280000000014	-46.3107839999999982	\N	active	2017-11-10 19:45:23.785782	2017-11-10 19:45:24.109618	Praça Cel. Fernando Prestes
687	d75ea414eb417c9e726e71a5d2c98450	0	b50e04c3-fae4-4ea9-9fc6-5b7bfb637448	2	d75ea414eb417c9e726e71a5d2c98450	-23.9431539999999998	-46.3284009999999995	\N	active	2017-11-10 19:45:24.138694	2017-11-10 19:45:24.46055	Avenida Rangel Pestana
688	e1d7cdd2ca0aa9863d2daae9d3e94fc5	0	66af49b8-3fca-42fa-a683-19406e0c84dc	2	e1d7cdd2ca0aa9863d2daae9d3e94fc5	-23.9536440000000006	-46.337606000000001	\N	active	2017-11-10 19:45:24.482026	2017-11-10 19:45:25.052144	Avenida Doutor Bernardino de Campos
689	59bd26be417f0a7caaad8cdeeb3d442b	0	bb7d4e3d-af05-4aa5-a479-7ceea907b4d4	2	59bd26be417f0a7caaad8cdeeb3d442b	-23.9460370000000005	-46.321748999999997	\N	active	2017-11-10 19:45:25.073023	2017-11-10 19:45:25.352381	Avenida Conselheiro Nébias
690	ab00804c135f2fbe8661d390b960f9e4	0	e6127d4e-d561-4e4f-9a29-a725e7b6c0a4	2	ab00804c135f2fbe8661d390b960f9e4	-23.9499689999999994	-46.3404390000000035	\N	active	2017-11-10 19:45:25.380258	2017-11-10 19:45:25.677901	Praça da Bíblia
691	17363b9510a918b69c24cdf53f0c75ee	0	6979864b-5b7a-41a6-9004-c6eb04f6b47a	2	17363b9510a918b69c24cdf53f0c75ee	-23.9329460000000012	-46.3245009999999979	\N	active	2017-11-10 19:45:25.698813	2017-11-10 19:45:25.989072	Praça da República
692	fe47eb5bf6b1ca3fab0191a88aa953c9	0	1600e7b2-f065-4b8b-9fa2-e71853847a02	2	fe47eb5bf6b1ca3fab0191a88aa953c9	-23.9348379999999992	-46.3321880000000021	\N	active	2017-11-10 19:45:26.021733	2017-11-10 19:45:26.775706	Praça dos Andradas
693	6cbe25b61e82d84c49554077e93de3d4	0	9896b9ab-ff44-4d1d-8053-826724a78f77	2	6cbe25b61e82d84c49554077e93de3d4	-23.9308280000000018	-46.3462320000000005	\N	active	2017-11-10 19:45:26.796397	2017-11-10 19:45:27.100318	Praça Ruy de Lugo Viña
694	92e633f3c606e019d4d72e9b137479f1	0	cfbb043c-561d-4a40-97ee-76f545b0bc42	2	92e633f3c606e019d4d72e9b137479f1	-23.9425020000000011	-46.3771589999999989	\N	active	2017-11-10 19:45:27.139685	2017-11-10 19:45:27.638753	Rua Jonas Pereira Filho
695	ebed2b111390bfbeebd4b513d4f6f422	0	f495309c-8af9-4f61-8de9-64f94fd6e5ca	2	ebed2b111390bfbeebd4b513d4f6f422	-23.9447480000000006	-46.363667999999997	\N	active	2017-11-10 19:45:27.69058	2017-11-10 19:45:28.042411	Avenida Francisco Ferreira Canto
696	3f8cfdd84bb33dda906205ac96494678	0	6e28601f-2108-47e7-9fd0-036d92362af6	2	3f8cfdd84bb33dda906205ac96494678	-23.9359259999999985	-46.362718000000001	\N	active	2017-11-10 19:45:28.08155	2017-11-10 19:45:28.423683	Av. Nossa Senhora de Fátima
697	cdce63e5c152b08f398c53adfb30d849	0	a1a5ac5f-8422-4ad0-823d-1365c95dbe00	2	cdce63e5c152b08f398c53adfb30d849	-23.9437710000000017	-46.3342730000000032	\N	active	2017-11-10 19:45:28.442482	2017-11-10 19:45:28.780997	Praça Coimbra
698	98522e9dd8f3c61e2e73bdbb30fb3f57	0	613b8315-b086-4221-a32c-0ea08dc78917	2	98522e9dd8f3c61e2e73bdbb30fb3f57	-23.9598310000000012	-46.322887999999999	\N	active	2017-11-10 19:45:28.799973	2017-11-10 19:45:29.360821	Rua Dagoberto Gasgon
699	6fed48e695846f1054e5f059127ab5ff	0	88fcd5cc-400a-42c0-8f38-94c70e96c5fa	2	6fed48e695846f1054e5f059127ab5ff	-20	-45	\N	active	2017-11-10 19:45:29.38544	2017-11-10 19:45:29.721238	rua marechal pego junior
700	62d47ae9187ceec951b44c262dcd6001	0	13f6bd25-4678-4618-aef4-6547a4b2d5fa	2	62d47ae9187ceec951b44c262dcd6001	-23.9406929999999996	-46.3192170000000019	\N	active	2017-11-10 19:45:29.737512	2017-11-10 19:45:30.058447	Avenida 7 de Setembro / Esquina Praça Iguatemi Martins
701	5680224655e3ac2d97b2f67919a0012e	0	87aa28cb-4774-4de3-9bb4-79a3fe9626c0	1	5680224655e3ac2d97b2f67919a0012e	-23.9443739999999998	-46.3814240000000026	\N	active	2017-11-10 19:57:28.807891	2017-11-10 19:57:29.07336	Av. Afonso Schimidt
702	7c3ee0e1a37a5a8396ef011b3a563d29	0	194dc2aa-b3ab-4bcc-8da5-89757e235828	1	7c3ee0e1a37a5a8396ef011b3a563d29	-23.9708129999999997	-46.3294849999999983	\N	active	2017-11-10 19:57:29.105347	2017-11-10 19:57:29.278145	Avenida Washington Luis / Esquina Avenida Vicente de Carvalho
703	45b70fbe1d676d00fe652a8aea02273e	0	37a58e53-71fb-468e-a138-88c14fb2cdd5	1	45b70fbe1d676d00fe652a8aea02273e	-23.9679989999999989	-46.3491939999999971	\N	active	2017-11-10 19:57:29.320039	2017-11-10 19:57:29.574979	Avenida Presidente Wilson
704	86b4d97226ead612287c2e012e587070	0	f42fbd87-4aa8-4443-ba51-78e321c033f6	1	86b4d97226ead612287c2e012e587070	-23.9908789999999996	-46.3048190000000019	\N	active	2017-11-10 19:57:29.617712	2017-11-10 19:57:30.240289	Avenida Almirante Saldanha da Gama
705	bfcd664810fc003f4dcedee3c14032f6	0	60a48b32-89a9-4e8f-a688-b3275bbf751a	1	bfcd664810fc003f4dcedee3c14032f6	-23.9805470000000014	-46.300023000000003	\N	active	2017-11-10 19:57:30.268677	2017-11-10 19:57:30.85152	Praça Eng. José Rebouças
706	62ce17e805d85aca4edd3ba7ec3fceba	0	6dbd6e79-2dbf-4d43-a2ba-74e6fff8f8ac	1	62ce17e805d85aca4edd3ba7ec3fceba	-23.9765279999999983	-46.3119859999999974	\N	active	2017-11-10 19:57:30.889214	2017-11-10 19:57:31.452123	Rua Conselheiro Ribas
707	23fc5b84d369c141cf7cdd6d97ebdd54	0	6dc6429f-1802-4a4c-9713-f9ad1da0876f	1	23fc5b84d369c141cf7cdd6d97ebdd54	-23.9749200000000009	-46.3200649999999996	\N	active	2017-11-10 19:57:31.486902	2017-11-10 19:57:31.724707	Avenida Bartolomeu
708	dbe8a5e5f82ff04eaef664267834988a	0	eb686ec9-57c3-474b-8919-65faab523a39	1	dbe8a5e5f82ff04eaef664267834988a	-23.9643130000000006	-46.3215670000000017	\N	active	2017-11-10 19:57:31.762934	2017-11-10 19:57:32.017194	Rua Oswaldo Cruz
709	b3d18ffdcba7fffd7e455cde2e6160b2	0	7c2fe029-d3fe-43b4-909a-a236a53d2f32	1	b3d18ffdcba7fffd7e455cde2e6160b2	-23.9680970000000002	-46.3331009999999992	\N	active	2017-11-10 19:57:32.053385	2017-11-10 19:57:32.291603	Avenida Dona Ana Costa
710	3d3bdcce092d503546aef22ef4b7f48d	0	5cb289b2-b6ad-4c32-b76c-18080d97fbb6	1	3d3bdcce092d503546aef22ef4b7f48d	-23.9617240000000002	-46.3375849999999971	\N	active	2017-11-10 19:57:32.327505	2017-11-10 19:57:32.577793	Avenida Marechal Deodoro
711	d16a1538d0c96f9e80e343c54c12af7d	0	823443db-18b1-45d8-9c6b-c3e859246be7	1	d16a1538d0c96f9e80e343c54c12af7d	-23.9730510000000017	-46.3023730000000029	\N	active	2017-11-10 19:57:32.603169	2017-11-10 19:57:32.837103	Praça Nossa Senhora Aparecida
712	3c5e1fa48e40117c681d81d2736389cd	0	b34b79d5-9385-4647-9221-c8bf1498f2b8	1	3c5e1fa48e40117c681d81d2736389cd	-23.9519389999999994	-46.3298389999999998	\N	active	2017-11-10 19:57:32.86865	2017-11-10 19:57:33.12747	Rua Julio Conceicao
713	c31a053c46acd1b1ce812cff0aef3951	0	590c047d-fdc4-49e4-81a6-630d5d1db968	1	c31a053c46acd1b1ce812cff0aef3951	-23.9568030000000007	-46.3232939999999971	\N	active	2017-11-10 19:57:33.188028	2017-11-10 19:57:33.375541	Rua Barão de Paranapiacaba
714	e22963b87513984c063d6f5eb8dd3fe2	0	cd9aabbe-27dc-4fc4-870e-bfc92983c09b	1	e22963b87513984c063d6f5eb8dd3fe2	-23.9373679999999993	-46.3255690000000016	\N	active	2017-11-10 19:57:33.411419	2017-11-10 19:57:33.657666	Avenida Senador Feijó
715	b886673c4007e8a5afaa884af29023dc	0	2ca66048-8d0f-4b0a-97b5-e48346546cc3	1	b886673c4007e8a5afaa884af29023dc	-23.9333279999999995	-46.3284439999999975	\N	active	2017-11-10 19:57:33.724704	2017-11-10 19:57:34.134293	Praça Visconde de Mauá
716	b8cf1faf68e01e9828dc69fd242e24f2	0	4367a0b0-78a9-46fe-9347-6a4f96c8c5cc	1	b8cf1faf68e01e9828dc69fd242e24f2	-23.9684990000000013	-46.3394410000000008	\N	active	2017-11-10 19:57:34.16422	2017-11-10 19:57:34.34443	Avenida Presidente Wilson / Esquina Avenida Bernardino de Campos
717	750ccac55a338c3823f581fa01b1e468	0	e9a35c87-5bd6-42e6-b47a-d2bab87e72cb	1	750ccac55a338c3823f581fa01b1e468	-23.9863399999999984	-46.3083269999999985	\N	active	2017-11-10 19:57:34.37719	2017-11-10 19:57:34.986092	Avenida Bartolomeu de Gusmão
718	1397dd9003da09d5072b6930f5285308	0	c81453ea-6c78-4995-beae-fb2784181bad	1	1397dd9003da09d5072b6930f5285308	-23.988232	-46.2963000000000022	\N	active	2017-11-10 19:57:35.017399	2017-11-10 19:57:39.225395	Avenida Almirante Saldanha da Gama
719	3d7488bd91f71ac76138c768eb356320	0	695f333b-6a87-46fc-8ad3-db29d2d67a45	1	3d7488bd91f71ac76138c768eb356320	-23.9800429999999984	-46.3131580000000014	\N	active	2017-11-10 19:57:39.256697	2017-11-10 19:57:40.238805	Av. Bartolomeu de Gusmão
720	bd00a12042481147005b7562c73329cf	0	a46a6fb3-2e92-4d23-ae8c-a830f7f8d3e0	1	bd00a12042481147005b7562c73329cf	-23.9590579999999989	-46.3318340000000006	\N	active	2017-11-10 19:57:40.297568	2017-11-10 19:57:41.209522	Avenida Dona Ana Costa (Praça dos Expedicionários) / Esquina Avenida General Francisco Glicério
721	a9a579c7daecff04bb853493ecc04887	0	6465729c-a5cf-496b-a988-a8cbc596d35d	1	a9a579c7daecff04bb853493ecc04887	-23.9615180000000016	-46.3456740000000025	\N	active	2017-11-10 19:57:41.236709	2017-11-10 19:57:41.6024	Rua João Caetano
722	d05123e9d1762c8bcc51a2c7f67c0ed1	0	48b43043-2131-40f4-913d-2126a3f7b9cb	1	d05123e9d1762c8bcc51a2c7f67c0ed1	-23.9645280000000014	-46.3107839999999982	\N	active	2017-11-10 19:57:41.623405	2017-11-10 19:57:42.32867	Praça Cel. Fernando Prestes
723	d75ea414eb417c9e726e71a5d2c98450	0	081f011e-c698-433e-a38e-08d1752619a0	1	d75ea414eb417c9e726e71a5d2c98450	-23.9431539999999998	-46.3284009999999995	\N	active	2017-11-10 19:57:42.368244	2017-11-10 19:57:43.06172	Avenida Rangel Pestana
724	e1d7cdd2ca0aa9863d2daae9d3e94fc5	0	003e90af-57fa-4c9a-bc76-2e5f555d2777	1	e1d7cdd2ca0aa9863d2daae9d3e94fc5	-23.9536440000000006	-46.337606000000001	\N	active	2017-11-10 19:57:43.101962	2017-11-10 19:57:43.301898	Avenida Doutor Bernardino de Campos
725	59bd26be417f0a7caaad8cdeeb3d442b	0	6d8a46a3-c38f-4a56-87e9-23fee2dd651b	1	59bd26be417f0a7caaad8cdeeb3d442b	-23.9460370000000005	-46.321748999999997	\N	active	2017-11-10 19:57:43.377622	2017-11-10 19:57:43.919957	Avenida Conselheiro Nébias
726	ab00804c135f2fbe8661d390b960f9e4	0	bf8f47f1-1e04-428f-9a9a-deba63a9acf7	1	ab00804c135f2fbe8661d390b960f9e4	-23.9499689999999994	-46.3404390000000035	\N	active	2017-11-10 19:57:43.951421	2017-11-10 19:57:44.201794	Praça da Bíblia
727	17363b9510a918b69c24cdf53f0c75ee	0	3213725c-e7cd-4bb9-99c7-46e8bc0e5635	1	17363b9510a918b69c24cdf53f0c75ee	-23.9329460000000012	-46.3245009999999979	\N	active	2017-11-10 19:57:44.236482	2017-11-10 19:57:44.797076	Praça da República
728	fe47eb5bf6b1ca3fab0191a88aa953c9	0	e19b20a6-6694-433d-be8f-8d1713da02ff	1	fe47eb5bf6b1ca3fab0191a88aa953c9	-23.9348379999999992	-46.3321880000000021	\N	active	2017-11-10 19:57:44.836947	2017-11-10 19:57:45.449507	Praça dos Andradas
729	6cbe25b61e82d84c49554077e93de3d4	0	bac06233-b609-40fe-b2ba-56ce1df5a587	1	6cbe25b61e82d84c49554077e93de3d4	-23.9308280000000018	-46.3462320000000005	\N	active	2017-11-10 19:57:45.490497	2017-11-10 19:57:46.083128	Praça Ruy de Lugo Viña
730	92e633f3c606e019d4d72e9b137479f1	0	1330d164-4b5b-40a6-924e-606a22d64955	1	92e633f3c606e019d4d72e9b137479f1	-23.9425020000000011	-46.3771589999999989	\N	active	2017-11-10 19:57:46.120344	2017-11-10 19:57:46.669223	Rua Jonas Pereira Filho
731	ebed2b111390bfbeebd4b513d4f6f422	0	2757fae8-60c4-4843-90eb-68377ac1027e	1	ebed2b111390bfbeebd4b513d4f6f422	-23.9447480000000006	-46.363667999999997	\N	active	2017-11-10 19:57:46.710769	2017-11-10 19:57:46.953583	Avenida Francisco Ferreira Canto
732	3f8cfdd84bb33dda906205ac96494678	0	ee85413a-30b4-4866-9a9a-8069e5327587	1	3f8cfdd84bb33dda906205ac96494678	-23.9359259999999985	-46.362718000000001	\N	active	2017-11-10 19:57:46.984278	2017-11-10 19:57:47.450363	Av. Nossa Senhora de Fátima
733	cdce63e5c152b08f398c53adfb30d849	0	8c6fc6ab-4ad9-4ac0-bc74-fd735e50d71f	1	cdce63e5c152b08f398c53adfb30d849	-23.9437710000000017	-46.3342730000000032	\N	active	2017-11-10 19:57:47.483413	2017-11-10 19:57:48.070875	Praça Coimbra
734	98522e9dd8f3c61e2e73bdbb30fb3f57	0	0a093243-9030-49f2-ab77-cd08642b7363	1	98522e9dd8f3c61e2e73bdbb30fb3f57	-23.9598310000000012	-46.322887999999999	\N	active	2017-11-10 19:57:48.101752	2017-11-10 19:57:48.338005	Rua Dagoberto Gasgon
735	6fed48e695846f1054e5f059127ab5ff	0	6a7eae33-e6eb-4da1-9fdb-041c00dd71fb	1	6fed48e695846f1054e5f059127ab5ff	-20	-45	\N	active	2017-11-10 19:57:48.368914	2017-11-10 19:57:48.614161	rua marechal pego junior
736	62d47ae9187ceec951b44c262dcd6001	0	81b732e0-ed6f-480c-9938-dfbbf5f1d56e	1	62d47ae9187ceec951b44c262dcd6001	-23.9406929999999996	-46.3192170000000019	\N	active	2017-11-10 19:57:48.641272	2017-11-10 19:57:49.200572	Avenida 7 de Setembro / Esquina Praça Iguatemi Martins
\.


--
-- Name: bike_stations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('bike_stations_id_seq', 736, true);


--
-- Data for Name: initiatives; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY initiatives (id, worker_uuid, worker, uuid, platform_id, region, lat, lon, status, created_at, updated_at, name, address, state, city) FROM stdin;
\.


--
-- Name: initiatives_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('initiatives_id_seq', 1, false);


--
-- Data for Name: platforms; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY platforms (id, url, description, created_at, updated_at) FROM stdin;
1	localhost:8000	kong local	2017-11-09 23:24:12.563289	2017-11-09 23:24:12.563289
2	143.107.45.126:30134	Servidor de Produção	2017-11-09 23:42:37.249011	2017-11-09 23:42:37.249011
3	35.198.3.112	my instance	2017-11-10 12:16:58.231187	2017-11-10 12:16:58.231187
\.


--
-- Name: platforms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('platforms_id_seq', 3, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY schema_migrations (version) FROM stdin;
20171109172206
20171101152750
20171101152839
20171101134329
20171101101356
20171001173626
20171101152707
20171012192317
20171101152932
20171107181810
20171012234343
20171110134013
\.


--
-- Data for Name: static_entities; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY static_entities (id, worker_uuid, worker, uuid, platform_id, lat, lon, status) FROM stdin;
\.


--
-- Name: static_entities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('static_entities_id_seq', 1, false);


--
-- Data for Name: weathers; Type: TABLE DATA; Schema: public; Owner: dylan
--

COPY weathers (id, worker_uuid, worker, uuid, platform_id, region, neighborhood, lat, lon, status, created_at, updated_at) FROM stdin;
311	Guaianases	2	3f944ec1-3fe0-496a-82fc-306e85d00f32	3	Guaianases	Guaianases	-23.5766072999999992	-46.4097689999999972	active	2017-11-10 13:55:22.914159	2017-11-10 13:55:23.627569
312	Iguatemi	2	81774e35-d08f-4911-80d4-b29dd68a9812	3	Iguatemi	Iguatemi	-23.5771249000000012	-46.6882359000000022	active	2017-11-10 13:55:24.883482	2017-11-10 13:55:25.407158
313	Ipiranga	2	4bca70c7-5661-4335-9f41-4ffb8db021b9	3	Ipiranga	Ipiranga	-23.5854976000000001	-46.5990105999999997	active	2017-11-10 13:55:26.609631	2017-11-10 13:55:26.959432
27	Penha	2	4907f817-979d-494e-9ea9-55a29526d0e9	2	Penha	Penha	-23.5252365999999995	-46.5475598000000019	active	2017-11-09 23:47:38.363931	2017-11-09 23:47:38.830952
6	Anhanguera	2	957d0c66-8567-4d41-81f4-7f11e76d7ac2	1	Anhanguera	Anhanguera	-23.4378791	-46.7932802999999993	active	2017-11-09 23:31:13.023456	2017-11-09 23:31:13.873751
7	Perus	2	c56b79f7-36ce-449e-a95d-7a03ba3d211d	1	Perus	Perus	-23.4047769999999993	-46.7483786000000023	active	2017-11-09 23:31:16.960414	2017-11-09 23:31:17.532596
8	Jaraguá	2	b5d66f8e-0c7c-486b-b1c7-ee61fc50da61	1	Jaraguá	Jaraguá	-23.4398790000000012	-46.7825026000000079	active	2017-11-09 23:31:19.924964	2017-11-09 23:31:20.394508
9	Anhanguera	2	2fb06b91-9e2a-4a65-9689-dee9c4f326db	2	Anhanguera	Anhanguera	-23.4378791	-46.7932802999999993	active	2017-11-09 23:42:53.871333	2017-11-09 23:42:54.411041
10	Perus	2	f4ec7b30-57c0-48e9-943a-041fb7c50887	2	Perus	Perus	-23.4047769999999993	-46.7483786000000023	active	2017-11-09 23:42:57.386363	2017-11-09 23:42:57.81635
11	Jaraguá	2	2d7b94a3-2d46-411d-8886-35cf2af2a412	2	Jaraguá	Jaraguá	-23.4398790000000012	-46.7825026000000079	active	2017-11-09 23:43:01.218407	2017-11-09 23:43:01.636272
12	Brasilândia	2	339d28bf-b5aa-47fc-8cf6-a939c8d6495d	2	Brasilândia	Brasilândia	-23.4703331000000013	-46.6899782999999999	active	2017-11-09 23:46:36.81208	2017-11-09 23:46:37.238861
13	Pirituba	2	a673352b-38a8-4666-9fd2-ae954cc0c49c	2	Pirituba	Pirituba	-23.4559999999999995	-46.7204472999999965	active	2017-11-09 23:46:40.579729	2017-11-09 23:46:40.991693
14	São Domingos	2	31d505fa-952f-4dbc-9534-d30ed1bca8cf	2	São Domingos	São Domingos	-23.5043386000000005	-46.7433611000000084	active	2017-11-09 23:46:44.534342	2017-11-09 23:46:44.965825
15	Freguesia do Ó	2	af211cb2-d66d-4b1e-83ef-c75e47b1f846	2	Freguesia do Ó	Freguesia do Ó	-23.5014967000000006	-46.6977015999999878	active	2017-11-09 23:46:48.352653	2017-11-09 23:46:48.772031
16	Cachoeirinha	2	d0ca75ea-89b0-4c79-97d7-d2d5ec68462b	2	Cachoeirinha	Cachoeirinha	-23.479046799999999	-46.6595768999999976	active	2017-11-09 23:46:53.081248	2017-11-09 23:46:53.492811
17	Mandaqui	2	c9e670c8-8c7f-41ec-8316-39ecf24c939a	2	Mandaqui	Mandaqui	-23.4820871000000011	-46.6258905999999982	active	2017-11-09 23:46:57.62351	2017-11-09 23:46:58.026456
18	Tucuruvi	2	8555043f-3472-485d-93c6-aa93dfb9e55e	2	Tucuruvi	Tucuruvi	-23.473904000000001	-46.6108173999999877	active	2017-11-09 23:47:00.883332	2017-11-09 23:47:01.11416
19	Tremembé	2	d1c872ab-0e0c-4233-864b-1c6165b1fe12	2	Tremembé	Tremembé	-23.4598630999999997	-46.6254737999999875	active	2017-11-09 23:47:06.782891	2017-11-09 23:47:07.472798
20	Jaçanã	2	fd1f3adc-f937-49ed-aa82-cf3ed9674c43	2	Jaçanã	Jaçanã	-23.4532947999999983	-46.5720801999999878	active	2017-11-09 23:47:11.265501	2017-11-09 23:47:11.960854
21	Casa Verde	2	57ff0814-2b49-4fa6-b31d-3123fd0381fe	2	Casa Verde	Casa Verde	-23.5109880999999987	-46.6574418999999878	active	2017-11-09 23:47:15.437169	2017-11-09 23:47:15.862653
22	Santana	2	d6aa95c1-1bb2-4300-92d1-be97a1fead27	2	Santana	Santana	-23.4981809999999989	-46.6263306000000028	active	2017-11-09 23:47:19.169668	2017-11-09 23:47:20.728685
23	Vila Guilherme	2	1eec0129-384a-4598-b60f-d56c24c8fc65	2	Vila Guilherme	Vila Guilherme	-23.5153019999999984	-46.6079436999999999	active	2017-11-09 23:47:23.570963	2017-11-09 23:47:24.304433
24	Vila Medeiros	2	1c87e9bc-50aa-4b75-8aac-5ecd2aed2543	2	Vila Medeiros	Vila Medeiros	-23.4892825999999992	-46.5845914999999877	active	2017-11-09 23:47:27.6902	2017-11-09 23:47:28.349914
25	Vila Maria	2	583bdb49-928b-4538-ba9f-7028f1ecfede	2	Vila Maria	Vila Maria	-22.6088325999999995	-45.5681086000000022	active	2017-11-09 23:47:33.838834	2017-11-09 23:47:34.310931
314	Itaim Bibi	2	29d2bc97-23f5-4a4a-9466-59758bbf9df8	3	Itaim Bibi	Itaim Bibi	-23.5858163999999988	-46.6826257000000027	active	2017-11-10 13:55:28.207592	2017-11-10 13:55:28.703255
315	Itaim Paulista	2	6b3e179b-2081-404a-b841-a2c73efabc3a	3	Itaim Paulista	Itaim Paulista	-23.4691052999999989	-46.4036655000000025	active	2017-11-10 13:55:30.507691	2017-11-10 13:55:31.020056
29	Vila Matilde	2	0e56946f-742c-4d74-a301-1bde68dd6a51	2	Vila Matilde	Vila Matilde	-23.5355595000000015	-46.5271816999999999	active	2017-11-09 23:47:41.832265	2017-11-09 23:47:42.242732
31	Artur Alvim	2	80cdb1e8-9b58-402d-b434-334a88555944	2	Artur Alvim	Artur Alvim	-23.5487514000000004	-46.477195100000003	active	2017-11-09 23:47:44.958906	2017-11-09 23:47:45.146032
33	Ponte Rasa	2	5e88847d-1f7b-453a-b577-8b6a91d3e4b2	2	Ponte Rasa	Ponte Rasa	-23.5092737000000014	-46.4952313000000004	active	2017-11-09 23:47:48.136302	2017-11-09 23:47:48.531541
35	Ermelino Matarazzo	2	d31b71c5-d4d1-4ca4-b74c-8fc4cb38dcbb	2	Ermelino Matarazzo	Ermelino Matarazzo	-23.4888852999999997	-46.4680451999999988	active	2017-11-09 23:47:51.832047	2017-11-09 23:47:52.243345
37	Vila Jacuí	2	f037eb5e-038f-4c7f-af2f-c4691ae28e1e	2	Vila Jacuí	Vila Jacuí	-23.5004424000000007	-46.454774399999998	active	2017-11-09 23:47:55.459732	2017-11-09 23:47:56.028598
39	Itaquera	2	131a21df-0af0-4219-a37d-68d0840461c9	2	Itaquera	Itaquera	-23.5398463000000007	-46.4475327999999976	active	2017-11-09 23:47:59.158732	2017-11-09 23:47:59.580103
41	São Miguel	2	70e51e8d-0dec-4696-b382-6509debed752	2	São Miguel	São Miguel	-23.4929957999999992	-46.4375349999999969	active	2017-11-09 23:48:03.478873	2017-11-09 23:48:03.919316
43	Jardim Helena	2	a33160fc-88d6-4e82-bb1c-ff391d8246d9	2	Jardim Helena	Jardim Helena	-23.4842340000000007	-46.4187854999999985	active	2017-11-09 23:48:06.741841	2017-11-09 23:48:07.130592
45	Vila Curuçá	2	bc1008ca-9e27-46b1-8c71-fecb28984963	2	Vila Curuçá	Vila Curuçá	-23.6446317999999991	-46.5188746999999978	active	2017-11-09 23:48:10.279726	2017-11-09 23:48:10.841844
47	Itaim Paulista	2	d09131ac-556b-47af-9de4-c620ab049e7f	2	Itaim Paulista	Itaim Paulista	-23.4691052999999989	-46.4036655000000025	active	2017-11-09 23:48:15.143169	2017-11-09 23:48:15.555177
49	Lajeado	2	21f59a39-5459-4558-a91c-09092c16cc74	2	Lajeado	Lajeado	-22.3333329999999997	-47.3666669999999996	active	2017-11-09 23:48:20.235522	2017-11-09 23:48:20.721257
51	Guaianases	2	d3858c91-dd34-4958-9a4d-8ab01404be0d	2	Guaianases	Guaianases	-23.5766072999999992	-46.4097689999999972	active	2017-11-09 23:48:24.319441	2017-11-09 23:48:24.891884
54	Cidade Tiradentes	2	bbbebffb-04de-4017-ba83-260a4d59051c	2	Cidade Tiradentes	Cidade Tiradentes	-23.6016778999999985	-46.398766700000003	active	2017-11-09 23:48:27.941503	2017-11-09 23:48:28.35545
56	José Bonifácio	2	bfabd5de-330e-47f6-9574-74eeacf0935d	2	José Bonifácio	José Bonifácio	-21.0482478999999998	-49.6879727000000031	active	2017-11-09 23:48:33.421472	2017-11-09 23:48:33.77816
58	Parque do Carmo	2	dfb05e7c-90a1-4e9c-949d-2afdb5c4c544	2	Parque do Carmo	Parque do Carmo	-23.5817434000000006	-46.462333000000001	active	2017-11-09 23:48:36.592246	2017-11-09 23:48:37.290062
59	Aricanduva	2	c54930ad-2b04-4355-9ac7-08674323f436	2	Aricanduva	Aricanduva	-23.5795193000000012	-46.5110261000000023	active	2017-11-09 23:48:40.405924	2017-11-09 23:48:41.113035
61	Carrão	2	2b1f05c7-11dc-4397-9137-7dda1c9cf7d6	2	Carrão	Carrão	-23.5504582000000013	-46.5379276000000033	active	2017-11-09 23:48:45.695933	2017-11-09 23:48:46.134725
63	Vila Formosa	2	0301e24e-0b45-4e70-b2c0-19da06da4daf	2	Vila Formosa	Vila Formosa	-23.5668787000000002	-46.5439884000000035	active	2017-11-09 23:48:48.701702	2017-11-09 23:48:49.475113
65	Tatuapé	2	14c2adef-ff7d-4081-9958-b78bd1d196a4	2	Tatuapé	Tatuapé	-23.5352451999999985	-46.5754629999999992	active	2017-11-09 23:48:54.065108	2017-11-09 23:48:54.528074
67	Belém	2	05fa42a7-7574-44cb-9336-291df776d6b5	2	Belém	Belém	-23.5470833000000006	-46.5911994000000007	active	2017-11-09 23:48:57.453361	2017-11-09 23:48:58.026071
69	Mooca	2	49066e2c-5ecf-4032-a9f5-e774ad7f89a3	2	Mooca	Mooca	-23.5603264999999986	-46.5995903000000027	active	2017-11-09 23:49:00.764563	2017-11-09 23:49:01.176384
72	Água Rasa	2	a358f699-9df2-49b1-a23a-a9238bd627a8	2	Água Rasa	Água Rasa	-23.5532086000000014	-46.5818896999999978	active	2017-11-09 23:49:04.095531	2017-11-09 23:49:04.474369
73	Vila Prudente	2	b7c702b4-92f8-44dd-b660-bf7e683f1ba2	2	Vila Prudente	Vila Prudente	-23.5790135999999997	-46.5797560999999973	active	2017-11-09 23:49:08.098946	2017-11-09 23:49:08.663424
75	São Lucas	2	5c2db7af-977c-4bf9-aa12-e49de44bfdd8	2	São Lucas	São Lucas	-23.5865182000000004	-46.5352089999999876	active	2017-11-09 23:49:11.471083	2017-11-09 23:49:12.122737
77	São Mateus	2	618197fc-c500-4e7a-a509-8ecb76efdb80	2	São Mateus	São Mateus	-23.6047547000000009	-46.4650474000000031	active	2017-11-09 23:49:14.838998	2017-11-09 23:49:15.236003
79	Iguatemi	2	46fd8a88-e9eb-4308-9772-3da8eb2ffa6b	2	Iguatemi	Iguatemi	-23.5771249000000012	-46.6882359000000022	active	2017-11-09 23:49:18.042976	2017-11-09 23:49:18.496647
81	São Rafael	2	d04a4e00-6389-4b86-bfdd-880dc2447592	2	São Rafael	São Rafael	-19.3672037999999986	-40.4472132000000002	active	2017-11-09 23:49:21.386896	2017-11-09 23:49:21.766963
82	Sapopemba	2	35720b03-db98-46d7-bd7b-533306d5b35a	2	Sapopemba	Sapopemba	-23.574888399999999	-46.5240488000000028	active	2017-11-09 23:49:24.723922	2017-11-09 23:49:25.1636
84	Brás	2	7af7c167-9a5d-4ea2-affc-60266835fcb2	2	Brás	Brás	-23.5380469999999988	-46.6139117000000027	active	2017-11-09 23:49:29.394113	2017-11-09 23:49:30.078087
86	Pari	2	e3b3392f-f928-4f29-b542-3d33a9c35024	2	Pari	Pari	-23.5271137999999986	-46.6114202999999989	active	2017-11-09 23:49:35.260395	2017-11-09 23:49:35.708866
88	Limão	2	1f2796ad-f100-479e-9a98-aa5d686e3880	2	Limão	Limão	-23.5074450000000006	-46.6717411999999996	active	2017-11-09 23:49:39.5373	2017-11-09 23:49:40.107897
90	Bom Retiro	2	167f0069-1308-4f89-84be-cc43fcdcff39	2	Bom Retiro	Bom Retiro	-23.5256699000000005	-46.6407059999999873	active	2017-11-09 23:49:44.171678	2017-11-09 23:49:44.656444
91	Santa Cecília	2	07dda900-9ae5-4de8-ba2b-05d26588dcb9	2	Santa Cecília	Santa Cecília	-23.5381968000000015	-46.6572575000000001	active	2017-11-09 23:49:47.311906	2017-11-09 23:49:47.704065
92	República	2	66c613c6-717e-4b4e-8dcd-29d9c55b5b11	2	República	República	-22.25	-47.4833329999999876	active	2017-11-09 23:49:50.93477	2017-11-09 23:49:51.309468
95	Sé	2	6f58ed10-073b-4456-9c5c-e90236a82cff	2	Sé	Sé	-23.5528486999999984	-46.6307150000000021	active	2017-11-09 23:49:54.238629	2017-11-09 23:49:54.631581
96	Consolação	2	55c6255c-a36d-4d48-a7ad-274bb5346a90	2	Consolação	Consolação	-23.5525683999999984	-46.6556591000000012	active	2017-11-09 23:49:57.356635	2017-11-09 23:49:57.760369
98	Bela Vista	2	727ddbbd-dc6a-43a9-b37c-7fb545d787df	2	Bela Vista	Bela Vista	-23.5628311000000004	-46.6462594999999993	active	2017-11-09 23:50:01.195855	2017-11-09 23:50:01.610997
99	Liberdade	2	2aaa04fa-fc24-4e75-83c8-327509e3ad53	2	Liberdade	Liberdade	-23.5600626999999996	-46.6327578000000003	active	2017-11-09 23:50:13.096762	2017-11-09 23:50:13.499853
100	Cambuci	2	78a47385-cb8f-4438-bfa6-351f29afebb9	2	Cambuci	Cambuci	-23.5644728999999984	-46.6211125999999965	active	2017-11-09 23:50:16.216338	2017-11-09 23:50:17.714219
103	Barra Funda	2	6f2851ec-668f-450f-a12c-b4433ec761b2	2	Barra Funda	Barra Funda	-23.5303761999999992	-46.6574318999999988	active	2017-11-09 23:50:20.621685	2017-11-09 23:50:20.936079
104	Perdizes	2	67a115ac-8687-4bae-a048-0d55b368355e	2	Perdizes	Perdizes	-23.5369017000000014	-46.6743165999999974	active	2017-11-09 23:50:24.306516	2017-11-09 23:50:24.718559
106	Lapa	2	6bf23ac7-0aa9-47d3-b6d4-5788e93975de	2	Lapa	Lapa	-23.522741400000001	-46.7104399999999984	active	2017-11-09 23:50:27.639579	2017-11-09 23:50:27.993122
108	Jaguara	2	bd0749ad-b2d6-4d5e-ab3d-311b255b4d60	2	Jaguara	Jaguara	-23.5140405000000001	-46.7454429999999874	active	2017-11-09 23:50:30.8648	2017-11-09 23:50:31.212042
111	Vila Leopoldina	2	0e8aa12f-f11a-4da9-8ad4-9b983b840131	2	Vila Leopoldina	Vila Leopoldina	-23.5300265000000017	-46.7358448000000024	active	2017-11-09 23:50:34.251126	2017-11-09 23:50:34.620108
112	Jaguaré	2	0df67b91-2acd-42ae-9b13-8fc12ce74c2d	2	Jaguaré	Jaguaré	-23.5442745000000002	-46.7475353999999967	active	2017-11-09 23:50:38.27635	2017-11-09 23:50:38.859512
114	Alto de Pinheiros	2	17cdbdd1-ce57-48eb-9ce7-e8379c2d9e7a	2	Alto de Pinheiros	Alto de Pinheiros	-23.5537093000000013	-46.708834699999997	active	2017-11-09 23:50:41.263666	2017-11-09 23:50:41.686251
116	Pinheiros	2	5587352f-0135-461d-a4ea-d8866215a94f	2	Pinheiros	Pinheiros	-23.5630036999999994	-46.6864347000000066	active	2017-11-09 23:50:44.78753	2017-11-09 23:50:45.176843
119	Jardim Paulista	2	1e2380d7-323f-481e-b78c-7cc484599900	2	Jardim Paulista	Jardim Paulista	-23.5693243000000017	-46.6565455	active	2017-11-09 23:50:48.249341	2017-11-09 23:50:48.73209
120	Butantã	2	81085927-5119-42e8-b08a-660f5f1b2437	2	Butantã	Butantã	-12.8666669999999996	-39.3333330000000032	active	2017-11-09 23:50:51.485466	2017-11-09 23:50:51.871326
123	Rio Pequeno	2	7c2d592b-30c6-42bc-90ae-906d6b7efa3a	2	Rio Pequeno	Rio Pequeno	-23.5644875999999996	-46.7539347000000021	active	2017-11-09 23:50:54.585339	2017-11-09 23:50:54.94071
124	Itaim Bibi	2	9daaa725-e72f-4a37-8ef6-8aa8d0d041dd	2	Itaim Bibi	Itaim Bibi	-23.5858163999999988	-46.6826257000000027	active	2017-11-09 23:50:57.67314	2017-11-09 23:50:58.277334
126	Morumbi	2	82453cb1-88c9-40f0-b90f-2262a336e312	2	Morumbi	Morumbi	-23.598138800000001	-46.7200704999999985	active	2017-11-09 23:51:01.744354	2017-11-09 23:51:02.159056
128	Vila Sônia	2	27522d33-8332-4dba-b95b-90da8b3137e5	2	Vila Sônia	Vila Sônia	-23.5950562999999995	-46.7321348999999984	active	2017-11-09 23:51:05.427115	2017-11-09 23:51:05.821781
130	Raposo Tavares	2	368a263a-7843-4829-a881-68e218f6b4fa	2	Raposo Tavares	Raposo Tavares	-24.2982531000000002	-47.1381680999999872	active	2017-11-09 23:51:09.009708	2017-11-09 23:51:09.429465
132	Ipiranga	2	4541ad56-08e3-409d-9786-cb0f16212da3	2	Ipiranga	Ipiranga	-23.5854976000000001	-46.5990105999999997	active	2017-11-09 23:51:12.599309	2017-11-09 23:51:12.98308
134	Sacomã	2	99995c9a-0aa7-4a0d-a780-0716e2aa702b	2	Sacomã	Sacomã	-23.6149954000000015	-46.5969540999999978	active	2017-11-09 23:51:15.615495	2017-11-09 23:51:16.034021
136	Cursino	2	b8dee8ea-9bbb-4f9d-8619-33b6261d86f0	2	Cursino	Cursino	-23.6029915000000017	-46.6255389000000022	active	2017-11-09 23:51:18.802311	2017-11-09 23:51:19.585068
138	Vila Mariana	2	fab6a7e9-1d86-4621-8b86-59a502fe3ea8	2	Vila Mariana	Vila Mariana	-23.5870563000000004	-46.6357437000000132	active	2017-11-09 23:51:22.991463	2017-11-09 23:51:23.372825
140	Moema	2	9f16750c-dc12-465a-9114-98824e02f984	2	Moema	Moema	-23.6020214000000017	-46.6721032000000022	active	2017-11-09 23:51:26.22919	2017-11-09 23:51:26.680441
143	Saúde	2	7f958323-30a1-46b9-8287-114c9a422bdb	2	Saúde	Saúde	-23.6183379000000002	-46.6354972000000032	active	2017-11-09 23:51:29.277146	2017-11-09 23:51:29.670222
144	Campo Belo	2	e132d3ba-f8cc-4fde-b89d-26420e3ab569	2	Campo Belo	Campo Belo	-23.6220296000000012	-46.6720199000000022	active	2017-11-09 23:51:32.608506	2017-11-09 23:51:32.954508
146	Jabaquara	2	01773dec-8396-47c8-9efc-586fdc78e311	2	Jabaquara	Jabaquara	-23.6364963999999986	-46.645190999999997	active	2017-11-09 23:51:35.901804	2017-11-09 23:51:36.191944
148	Santo Amaro	2	428ecfe3-a01f-46bf-a833-eff9f2964b3f	2	Santo Amaro	Santo Amaro	38.9687967999999998	-7.58297820000000034	active	2017-11-09 23:51:39.130549	2017-11-09 23:51:39.49558
151	Vila Andrade	2	4f4e07aa-9f15-4ff9-ae60-0db00cbe170e	2	Vila Andrade	Vila Andrade	-23.6320629999999987	-46.7374642999999992	active	2017-11-09 23:51:42.239126	2017-11-09 23:51:42.703218
152	Campo Limpo	2	5cf0a48e-69e5-4a22-947c-ea195d6f5c61	2	Campo Limpo	Campo Limpo	-23.6347959000000003	-46.7549901999999875	active	2017-11-09 23:51:45.689216	2017-11-09 23:51:46.074035
154	Capão Redondo	2	a9773c2a-bcb3-4f1b-ab6a-1aa12f261ce3	2	Capão Redondo	Capão Redondo	-23.6684610999999983	-46.7689718999999968	active	2017-11-09 23:51:48.685319	2017-11-09 23:51:49.08868
156	Jardim São Luís	2	0871dd50-ce72-434b-b5dc-bfc41931b374	2	Jardim São Luís	Jardim São Luís	-23.6513756000000015	-46.7330562	active	2017-11-09 23:51:51.773947	2017-11-09 23:51:52.501495
158	Campo Grande	2	cecf7594-b9f2-4ca7-b912-17bcc4ac203c	2	Campo Grande	Campo Grande	-23.6848068000000005	-46.6828568999999973	active	2017-11-09 23:51:55.67798	2017-11-09 23:51:56.315575
160	Cidade Ademar	2	ccaf79e0-6c22-47ba-ab94-8d9d41ccf95b	2	Cidade Ademar	Cidade Ademar	-23.670858599999999	-46.6566540999999972	active	2017-11-09 23:51:58.253746	2017-11-09 23:51:58.610101
162	Socorro	2	fd497c89-079d-455b-886a-07f11ac79aa5	2	Socorro	Socorro	-22.5905905999999987	-46.5282972999999984	active	2017-11-09 23:52:01.650403	2017-11-09 23:52:02.048639
165	Jardim ângela	2	d5482149-69c2-426a-af92-572f921ba886	2	Jardim ângela	Jardim ângela	-23.7027974999999991	-46.7691877999999974	active	2017-11-09 23:52:05.061945	2017-11-09 23:52:05.463292
166	Pedreira	2	7d76190d-4591-4dd1-98c0-f8afbcf5d8e9	2	Pedreira	Pedreira	-22.7418343000000007	-46.8952924999999965	active	2017-11-09 23:52:08.217592	2017-11-09 23:52:08.600185
169	Cidade Dutra	2	b7ea114d-474d-4dce-9740-6d70b0c3f97b	2	Cidade Dutra	Cidade Dutra	-23.7116913999999994	-46.7038790000000006	active	2017-11-09 23:52:11.714043	2017-11-09 23:52:12.087896
171	Grajaú	2	a5ff0772-cbbe-448a-b24f-c5ce8f0b4418	2	Grajaú	Grajaú	-23.7721939000000013	-46.6682947999999982	active	2017-11-09 23:52:14.270392	2017-11-09 23:52:14.69058
173	Parelheiros	2	1438ce87-61ac-425d-9215-fbabfcdd725f	2	Parelheiros	Parelheiros	-23.826951900000001	-46.7270204000000007	active	2017-11-09 23:52:17.53552	2017-11-09 23:52:17.912232
175	Marsilac	2	58029da2-14fc-4afe-a144-b10285543795	2	Marsilac	Marsilac	-23.9073074000000005	-46.7064200000000014	active	2017-11-09 23:52:21.247726	2017-11-09 23:52:21.698296
176	Brasilândia	2	141644fd-b93f-4f1c-8336-72e133593f09	1	Brasilândia	Brasilândia	-23.4703331000000013	-46.6899782999999999	active	2017-11-09 23:55:17.151707	2017-11-09 23:55:17.753549
177	Pirituba	2	bf3615d7-6850-4cb0-8f87-ec595cfde01f	1	Pirituba	Pirituba	-23.4559999999999995	-46.7204472999999965	active	2017-11-09 23:55:20.671278	2017-11-09 23:55:21.2431
178	São Domingos	2	383ab04b-0e81-41be-8e00-37e7e8f60c35	1	São Domingos	São Domingos	-23.5043386000000005	-46.7433611000000084	active	2017-11-09 23:55:24.999622	2017-11-09 23:55:25.484345
179	Freguesia do Ó	2	258310d2-5695-4ed4-88b7-f4aa962f67c6	1	Freguesia do Ó	Freguesia do Ó	-23.5014967000000006	-46.6977015999999878	active	2017-11-09 23:55:27.996147	2017-11-09 23:55:28.513731
180	Cachoeirinha	2	6c99e0f3-a301-45aa-b9ff-2ad9818feaf6	1	Cachoeirinha	Cachoeirinha	-23.479046799999999	-46.6595768999999976	active	2017-11-09 23:55:30.991359	2017-11-09 23:55:31.476094
181	Mandaqui	2	e3b749c6-4255-439f-a486-a2e724b24422	1	Mandaqui	Mandaqui	-23.4820871000000011	-46.6258905999999982	active	2017-11-09 23:55:35.760842	2017-11-09 23:55:35.948252
182	Tucuruvi	2	3cd79bd1-602a-49b2-85b8-8545687a9470	1	Tucuruvi	Tucuruvi	-23.473904000000001	-46.6108173999999877	active	2017-11-09 23:55:39.19224	2017-11-09 23:55:39.793159
183	Tremembé	2	c620d849-aa6e-4cc3-93f5-f927b7e09236	1	Tremembé	Tremembé	-23.4598630999999997	-46.6254737999999875	active	2017-11-09 23:55:45.273453	2017-11-09 23:55:45.439996
184	Jaçanã	2	64ea55ac-deb8-4807-86b1-a53520c5695a	1	Jaçanã	Jaçanã	-23.4532947999999983	-46.5720801999999878	active	2017-11-09 23:55:48.062957	2017-11-09 23:55:48.707837
185	Casa Verde	2	0eacbe3b-a6cb-45a3-845b-76e2c15df936	1	Casa Verde	Casa Verde	-23.5109880999999987	-46.6574418999999878	active	2017-11-09 23:55:52.540449	2017-11-09 23:55:53.052259
186	Santana	2	1d448032-d7f9-4e41-9a3d-4686e85298b4	1	Santana	Santana	-23.4981809999999989	-46.6263306000000028	active	2017-11-09 23:55:56.46528	2017-11-09 23:55:56.98851
187	Vila Guilherme	2	a1be8796-85d1-4763-8711-0df987761731	1	Vila Guilherme	Vila Guilherme	-23.5153019999999984	-46.6079436999999999	active	2017-11-09 23:56:00.537075	2017-11-09 23:56:01.143364
188	Vila Medeiros	2	74ab0b18-9a2a-48b4-8c46-246b08843dce	1	Vila Medeiros	Vila Medeiros	-23.4892825999999992	-46.5845914999999877	active	2017-11-09 23:56:04.305789	2017-11-09 23:56:04.895491
189	Vila Maria	2	d061c810-8f56-4767-822f-9015f01add8d	1	Vila Maria	Vila Maria	-22.6088325999999995	-45.5681086000000022	active	2017-11-09 23:56:07.371334	2017-11-09 23:56:17.526744
190	Penha	2	e2d53703-4ca3-48d9-9ed0-57d34c4250e9	1	Penha	Penha	-23.5252365999999995	-46.5475598000000019	active	2017-11-09 23:56:21.14566	2017-11-09 23:56:21.647196
191	Vila Matilde	2	c4db66ae-850b-4c34-91e3-b3c4d4b080f9	1	Vila Matilde	Vila Matilde	-23.5355595000000015	-46.5271816999999999	active	2017-11-09 23:56:24.323587	2017-11-09 23:56:24.832022
192	Artur Alvim	2	395c1384-3227-4da3-96e1-2f4c51529eac	1	Artur Alvim	Artur Alvim	-23.5487514000000004	-46.477195100000003	active	2017-11-09 23:56:27.540284	2017-11-09 23:56:28.026397
193	Ponte Rasa	2	3fa609d9-0ce5-4549-881e-12902a1611f9	1	Ponte Rasa	Ponte Rasa	-23.5092737000000014	-46.4952313000000004	active	2017-11-09 23:56:30.711828	2017-11-09 23:56:31.20064
194	Ermelino Matarazzo	2	c9826682-d986-4b58-bf75-fda9595a3ac5	1	Ermelino Matarazzo	Ermelino Matarazzo	-23.4888852999999997	-46.4680451999999988	active	2017-11-09 23:56:34.976606	2017-11-09 23:56:39.178679
195	Vila Jacuí	2	59acc538-7e76-49f3-9b6a-35062596dbcb	1	Vila Jacuí	Vila Jacuí	-23.5004424000000007	-46.454774399999998	active	2017-11-09 23:56:48.190236	2017-11-09 23:56:48.744757
196	Itaquera	2	edcdcd0e-a4bf-4c1b-870b-f9e57e08ffc4	1	Itaquera	Itaquera	-23.5398463000000007	-46.4475327999999976	active	2017-11-09 23:56:51.380206	2017-11-09 23:56:51.902995
197	São Miguel	2	be16bd25-e6c1-4a67-84b8-3299236d2adb	1	São Miguel	São Miguel	-23.4929957999999992	-46.4375349999999969	active	2017-11-09 23:56:55.375701	2017-11-09 23:56:55.870029
198	Jardim Helena	2	ab9dbb2f-bfda-47e6-9962-e9472f27dae2	1	Jardim Helena	Jardim Helena	-23.4842340000000007	-46.4187854999999985	active	2017-11-09 23:56:59.017043	2017-11-09 23:56:59.190965
199	Vila Curuçá	2	dc31744e-933d-4b00-8ed5-93cd240edb39	1	Vila Curuçá	Vila Curuçá	-23.6446317999999991	-46.5188746999999978	active	2017-11-09 23:57:02.456993	2017-11-09 23:57:03.042111
200	Itaim Paulista	2	87b0d092-83ac-4964-97c0-34c62073e379	1	Itaim Paulista	Itaim Paulista	-23.4691052999999989	-46.4036655000000025	active	2017-11-09 23:57:06.798223	2017-11-09 23:57:07.278419
201	Lajeado	2	ad2a6343-595d-46e5-a16f-cf1bc01ae9fc	1	Lajeado	Lajeado	-23.6044200000000011	-46.7483569999999986	active	2017-11-09 23:57:14.413879	2017-11-09 23:57:14.920487
202	Guaianases	2	8a5fd64b-7c86-453b-ae94-f1c98c4afcf1	1	Guaianases	Guaianases	-23.6044200000000011	-46.7483569999999986	active	2017-11-09 23:57:23.277632	2017-11-09 23:57:27.403608
203	Cidade Tiradentes	2	21fb8b42-7bcd-4cbf-ab00-017e93e00086	1	Cidade Tiradentes	Cidade Tiradentes	-23.6016778999999985	-46.398766700000003	active	2017-11-09 23:57:30.80007	2017-11-09 23:57:31.593559
204	José Bonifácio	2	f1786092-b9e2-4b9c-ad0c-c977b5406156	1	José Bonifácio	José Bonifácio	-21.0482478999999998	-49.6879727000000031	active	2017-11-09 23:57:36.809726	2017-11-09 23:57:37.3041
205	Parque do Carmo	2	5e602365-5659-4e03-ac83-fc266c0e8853	1	Parque do Carmo	Parque do Carmo	-23.5817434000000006	-46.462333000000001	active	2017-11-09 23:57:39.055258	2017-11-09 23:57:39.553291
206	Aricanduva	2	828fe024-b5a2-4b75-8879-3c3b81f7b44d	1	Aricanduva	Aricanduva	-23.5795193000000012	-46.5110261000000023	active	2017-11-09 23:57:42.452314	2017-11-09 23:57:43.051812
207	Carrão	2	7d20d659-db9d-47b8-96bf-a7ce541f660a	1	Carrão	Carrão	-23.5504582000000013	-46.5379276000000033	active	2017-11-09 23:57:49.988355	2017-11-09 23:57:50.468191
208	Vila Formosa	2	fda3b74b-4595-43aa-b63d-b489de6ba9e8	1	Vila Formosa	Vila Formosa	-23.5668787000000002	-46.5439884000000035	active	2017-11-09 23:57:52.93326	2017-11-09 23:57:53.467457
209	Tatuapé	2	89ab9ae6-82fb-4e60-bfe4-8ab263e0595e	1	Tatuapé	Tatuapé	-23.5352451999999985	-46.5754629999999992	active	2017-11-09 23:57:55.548224	2017-11-09 23:57:56.045595
210	Belém	2	b325c6e5-f4bd-4667-9dce-06c353de5bba	1	Belém	Belém	-23.5470833000000006	-46.5911994000000007	active	2017-11-09 23:57:59.203557	2017-11-09 23:57:59.812612
211	Mooca	2	e73b7533-4dd2-49d7-897a-86f2c94124c6	1	Mooca	Mooca	-23.5603264999999986	-46.5995903000000027	active	2017-11-09 23:58:02.816491	2017-11-09 23:58:03.290246
212	Água Rasa	2	87d80bbf-9a46-4887-a40a-2290420843ae	1	Água Rasa	Água Rasa	-23.5532086000000014	-46.5818896999999978	active	2017-11-09 23:58:06.718669	2017-11-09 23:58:07.242622
213	Vila Prudente	2	d8143178-161c-4f84-b3a3-b7a8023cab89	1	Vila Prudente	Vila Prudente	-23.5790135999999997	-46.5797560999999973	active	2017-11-09 23:58:10.198998	2017-11-09 23:58:10.825757
214	São Lucas	2	96670874-a46e-409f-83ed-3680b3fb9a43	1	São Lucas	São Lucas	-23.5865182000000004	-46.5352089999999876	active	2017-11-09 23:58:13.456414	2017-11-09 23:58:13.997092
215	São Mateus	2	c7aee8bf-64e9-4f4b-a709-b548560220b7	1	São Mateus	São Mateus	-23.6047547000000009	-46.4650474000000031	active	2017-11-09 23:58:16.696916	2017-11-09 23:58:17.320316
216	Iguatemi	2	12511de1-da8b-40fb-a95b-db27b8e38f40	1	Iguatemi	Iguatemi	-23.5771249000000012	-46.6882359000000022	active	2017-11-09 23:58:19.924409	2017-11-09 23:58:20.400713
217	São Rafael	2	97ea5e8e-ac8d-4d13-bb5a-ec8fd480346a	1	São Rafael	São Rafael	-19.3672037999999986	-40.4472132000000002	active	2017-11-09 23:58:23.40688	2017-11-09 23:58:23.674796
218	Sapopemba	2	46d1d9a9-7de1-4cd8-846d-fed929cdd9cb	1	Sapopemba	Sapopemba	-23.574888399999999	-46.5240488000000028	active	2017-11-09 23:58:26.218121	2017-11-09 23:58:26.758974
219	Brás	2	dc72f5c6-3338-43b4-bfb0-343053669adb	1	Brás	Brás	-23.5380469999999988	-46.6139117000000027	active	2017-11-09 23:58:30.50879	2017-11-09 23:58:31.017429
220	Pari	2	e28d3662-ad51-45ca-a7ed-999c7b29b3d7	1	Pari	Pari	-23.5271137999999986	-46.6114202999999989	active	2017-11-09 23:58:34.194071	2017-11-09 23:58:34.704682
221	Limão	2	0001a877-97a0-4b93-8beb-13600f2b9d86	1	Limão	Limão	-23.5074450000000006	-46.6717411999999996	active	2017-11-09 23:58:37.844065	2017-11-09 23:58:38.488842
222	Bom Retiro	2	67f14b28-ce34-4518-befb-1d6843b74600	1	Bom Retiro	Bom Retiro	-23.5256699000000005	-46.6407059999999873	active	2017-11-09 23:58:41.879429	2017-11-09 23:58:42.415729
223	Santa Cecília	2	2c179cca-4a0d-41db-a310-29418f6ae62f	1	Santa Cecília	Santa Cecília	-23.5381968000000015	-46.6572575000000001	active	2017-11-09 23:58:45.507471	2017-11-09 23:58:46.081806
224	República	2	a6a21c4e-5b7c-4d01-8dc3-2064fb3cd936	1	República	República	-22.25	-47.4833329999999876	active	2017-11-09 23:58:49.07519	2017-11-09 23:58:49.502756
225	Sé	2	abf171e6-454a-4b7b-9a95-abe87809aa5f	1	Sé	Sé	-23.5528486999999984	-46.6307150000000021	active	2017-11-09 23:58:52.176196	2017-11-09 23:58:52.647699
226	Consolação	2	559ea895-9468-4332-8a84-dc040cb70161	1	Consolação	Consolação	-23.5525683999999984	-46.6556591000000012	active	2017-11-09 23:58:55.558349	2017-11-09 23:58:56.356072
227	Bela Vista	2	ed1882cd-22e2-4418-bff1-67ce8740d117	1	Bela Vista	Bela Vista	-23.5628311000000004	-46.6462594999999993	active	2017-11-09 23:58:59.242166	2017-11-09 23:58:59.761127
228	Liberdade	2	e215e7f7-e8bb-4f18-838d-6705d733a559	1	Liberdade	Liberdade	-23.5600626999999996	-46.6327578000000003	active	2017-11-09 23:59:02.245545	2017-11-09 23:59:02.674109
229	Cambuci	2	68ef586e-3c2f-4f0b-a470-a3660a3e2f75	1	Cambuci	Cambuci	-23.5644728999999984	-46.6211125999999965	active	2017-11-09 23:59:05.557052	2017-11-09 23:59:06.048361
230	Barra Funda	2	96baebf1-8547-4ec3-b6eb-aa86d4b68267	1	Barra Funda	Barra Funda	-23.5303761999999992	-46.6574318999999988	active	2017-11-09 23:59:13.508513	2017-11-09 23:59:13.974273
231	Perdizes	2	8677f4f9-f6a8-4dd3-acb3-eb8358b253d4	1	Perdizes	Perdizes	-23.5369017000000014	-46.6743165999999974	active	2017-11-09 23:59:15.787419	2017-11-09 23:59:16.297814
232	Lapa	2	b978e68e-a8e3-4efd-ac99-d1e476b03379	1	Lapa	Lapa	-23.522741400000001	-46.7104399999999984	active	2017-11-09 23:59:19.212129	2017-11-09 23:59:19.700836
233	Jaguara	2	13e5d3ff-9778-444f-8ee2-68cf6230fc18	1	Jaguara	Jaguara	-23.5140405000000001	-46.7454429999999874	active	2017-11-09 23:59:22.548254	2017-11-09 23:59:23.046166
234	Vila Leopoldina	2	3af88dca-3284-4853-8426-9b954a26a7c3	1	Vila Leopoldina	Vila Leopoldina	-23.5300265000000017	-46.7358448000000024	active	2017-11-09 23:59:26.22138	2017-11-09 23:59:26.752375
235	Jaguaré	2	96c6a2a5-5ff3-4280-9a9b-c1c2e317e508	1	Jaguaré	Jaguaré	-23.5442745000000002	-46.7475353999999967	active	2017-11-09 23:59:30.515023	2017-11-09 23:59:31.116293
236	Alto de Pinheiros	2	f6080495-4f80-41b9-a841-31634ff4f036	1	Alto de Pinheiros	Alto de Pinheiros	-23.5537093000000013	-46.708834699999997	active	2017-11-09 23:59:33.12513	2017-11-09 23:59:33.748536
237	Pinheiros	2	9fc6e33d-5341-4816-bf9a-8ee60360bec6	1	Pinheiros	Pinheiros	-23.5630036999999994	-46.6864347000000066	active	2017-11-09 23:59:38.053986	2017-11-09 23:59:38.574805
238	Jardim Paulista	2	a2a46a8b-b5a7-4415-917c-aa0050f85e27	1	Jardim Paulista	Jardim Paulista	-23.5693243000000017	-46.6565455	active	2017-11-09 23:59:41.955914	2017-11-09 23:59:42.449148
239	Butantã	2	6e4ce76b-053d-4e49-90fa-7831e7c97d39	1	Butantã	Butantã	-12.8666669999999996	-39.3333330000000032	active	2017-11-09 23:59:45.398047	2017-11-09 23:59:45.907431
240	Rio Pequeno	2	8ae83488-42c5-4834-bf73-10b4ea409e6d	1	Rio Pequeno	Rio Pequeno	-23.5644875999999996	-46.7539347000000021	active	2017-11-09 23:59:48.986481	2017-11-09 23:59:49.531148
241	Itaim Bibi	2	40fb9858-9445-4520-a90b-8cd75a9e3ee2	1	Itaim Bibi	Itaim Bibi	-23.5858163999999988	-46.6826257000000027	active	2017-11-09 23:59:52.446358	2017-11-09 23:59:52.974573
242	Morumbi	2	0877eff7-53d4-4631-9a7e-72fb713eacba	1	Morumbi	Morumbi	-23.598138800000001	-46.7200704999999985	active	2017-11-09 23:59:56.111154	2017-11-09 23:59:56.603845
243	Vila Sônia	2	508b4713-f474-40f7-bc22-0e1aeacbc1b2	1	Vila Sônia	Vila Sônia	-23.5950562999999995	-46.7321348999999984	active	2017-11-09 23:59:59.086314	2017-11-09 23:59:59.582718
244	Raposo Tavares	2	2f6b162f-1513-4fea-9362-717650ced735	1	Raposo Tavares	Raposo Tavares	-24.2982531000000002	-47.1381680999999872	active	2017-11-10 00:00:06.945226	2017-11-10 00:00:07.357074
245	Ipiranga	2	7c60cf6d-5057-4e63-b1d6-78edce0e88c6	1	Ipiranga	Ipiranga	-23.6044200000000011	-46.7483569999999986	active	2017-11-10 00:00:12.454468	2017-11-10 00:00:12.636077
246	Sacomã	2	ccfb70f7-ffae-4359-b64b-5a01c2f0b0b2	1	Sacomã	Sacomã	-23.6149954000000015	-46.5969540999999978	active	2017-11-10 00:00:15.152437	2017-11-10 00:00:15.649232
247	Cursino	2	a00cc8a9-cf80-4fd9-a0e4-fdc5826a6511	1	Cursino	Cursino	-23.6029915000000017	-46.6255389000000022	active	2017-11-10 00:00:19.032205	2017-11-10 00:00:19.579053
248	Vila Mariana	2	39bdd283-1bc5-4215-8e12-1f50fc139c6a	1	Vila Mariana	Vila Mariana	-23.5870563000000004	-46.6357437000000132	active	2017-11-10 00:00:22.943571	2017-11-10 00:00:23.442277
249	Moema	2	e426a221-2506-4cf6-930f-a35adc36699a	1	Moema	Moema	-23.6020214000000017	-46.6721032000000022	active	2017-11-10 00:00:26.42921	2017-11-10 00:00:26.996273
250	Saúde	2	8432e913-23aa-45fe-9188-849cf3d1df2c	1	Saúde	Saúde	-23.6183379000000002	-46.6354972000000032	active	2017-11-10 00:00:29.746919	2017-11-10 00:00:30.241815
251	Campo Belo	2	e2875c65-3c80-48f3-825e-a3f9586b500b	1	Campo Belo	Campo Belo	-23.6220296000000012	-46.6720199000000022	active	2017-11-10 00:00:33.219158	2017-11-10 00:00:33.705673
252	Jabaquara	2	76307c88-69a1-495b-af7e-fbbab6bb51d3	1	Jabaquara	Jabaquara	-23.6364963999999986	-46.645190999999997	active	2017-11-10 00:00:36.756561	2017-11-10 00:00:37.095608
253	Santo Amaro	2	60081a87-4399-4449-91b0-d30e17737dc1	1	Santo Amaro	Santo Amaro	38.9687967999999998	-7.58297820000000034	active	2017-11-10 00:00:39.804935	2017-11-10 00:00:40.294348
254	Vila Andrade	2	3474b3d4-4c0b-4a61-82ce-c7893e4aded7	1	Vila Andrade	Vila Andrade	-23.6320629999999987	-46.7374642999999992	active	2017-11-10 00:00:43.1103	2017-11-10 00:00:43.59012
255	Campo Limpo	2	df6322da-0748-404c-82ef-ded581e88c3e	1	Campo Limpo	Campo Limpo	-23.6044200000000011	-46.7483569999999986	active	2017-11-10 00:00:46.179417	2017-11-10 00:00:46.698244
256	Capão Redondo	2	87ba64e0-595d-4506-8697-a113bc1c1b4c	1	Capão Redondo	Capão Redondo	-23.6684610999999983	-46.7689718999999968	active	2017-11-10 00:00:49.27066	2017-11-10 00:00:49.849215
257	Jardim São Luís	2	dc03d56e-0f0a-4593-a047-67bcff6a6be1	1	Jardim São Luís	Jardim São Luís	-23.6513756000000015	-46.7330562	active	2017-11-10 00:00:52.63077	2017-11-10 00:00:53.151552
258	Campo Grande	2	b5ad314e-b171-4fd1-be48-59f3a749dd2c	1	Campo Grande	Campo Grande	-23.6848068000000005	-46.6828568999999973	active	2017-11-10 00:00:56.169494	2017-11-10 00:00:56.649274
259	Cidade Ademar	2	4d63dd44-3dfa-44f6-9b01-9090c8b70a19	1	Cidade Ademar	Cidade Ademar	-23.670858599999999	-46.6566540999999972	active	2017-11-10 00:00:59.686681	2017-11-10 00:01:00.023052
260	Socorro	2	37f8c546-c554-4eff-83d8-104085f1d271	1	Socorro	Socorro	-22.5905905999999987	-46.5282972999999984	active	2017-11-10 00:01:03.754731	2017-11-10 00:01:04.104045
261	Jardim ângela	2	220b29bf-1985-46cc-91bd-769556b3715c	1	Jardim ângela	Jardim ângela	-23.7027974999999991	-46.7691877999999974	active	2017-11-10 00:01:07.537477	2017-11-10 00:01:08.019273
262	Pedreira	2	59a78dd4-94c5-446c-85a3-f6895456357b	1	Pedreira	Pedreira	-22.7418343000000007	-46.8952924999999965	active	2017-11-10 00:01:11.013259	2017-11-10 00:01:11.448482
263	Cidade Dutra	2	cbfb420c-94c9-4b95-aee7-65a76ca2d315	1	Cidade Dutra	Cidade Dutra	-23.6044200000000011	-46.7483569999999986	active	2017-11-10 00:01:13.491057	2017-11-10 00:01:13.99419
264	Grajaú	2	0484c4de-5545-499c-9200-d6170207e7ed	1	Grajaú	Grajaú	-23.7721939000000013	-46.6682947999999982	active	2017-11-10 00:01:16.557265	2017-11-10 00:01:17.016528
265	Parelheiros	2	61a446e7-2b1e-44f6-94c6-c6f98c2498d1	1	Parelheiros	Parelheiros	-23.826951900000001	-46.7270204000000007	active	2017-11-10 00:01:19.058605	2017-11-10 00:01:19.572936
266	Marsilac	2	68fe1e09-7d08-4da9-a990-1ec17b032922	1	Marsilac	Marsilac	-23.9073074000000005	-46.7064200000000014	active	2017-11-10 00:01:22.780756	2017-11-10 00:01:23.232441
267	Anhanguera	2	32402e8a-16d7-44e3-a472-c4328f45921a	3	Anhanguera	Anhanguera	-23.4378791	-46.7932802999999993	active	2017-11-10 12:17:53.635298	2017-11-10 12:17:55.041105
268	Perus	2	af39a74f-3c19-4e19-a39a-14e62a22b8dc	3	Perus	Perus	-23.4047769999999993	-46.7483786000000023	active	2017-11-10 12:17:56.575145	2017-11-10 12:17:57.064383
269	Jaraguá	2	7c79449d-34d5-4ee7-a410-96d4355eeb2a	3	Jaraguá	Jaraguá	-23.4398790000000012	-46.7825026000000079	active	2017-11-10 12:17:59.964601	2017-11-10 12:18:00.512311
270	Brasilândia	2	11a02ca9-02c6-45ad-8ec1-2050e46385cf	3	Brasilândia	Brasilândia	-23.4703331000000013	-46.6899782999999999	active	2017-11-10 12:19:39.676287	2017-11-10 12:19:40.349381
271	Pirituba	2	1cbc01ec-1f05-4fca-b24c-364d2b85224c	3	Pirituba	Pirituba	-23.4559999999999995	-46.7204472999999965	active	2017-11-10 12:19:42.331394	2017-11-10 12:19:42.998335
272	São Domingos	2	eebe99b5-15ab-4df0-a066-ee4b17193f45	3	São Domingos	São Domingos	-23.5043386000000005	-46.7433611000000084	active	2017-11-10 12:19:46.291723	2017-11-10 12:19:46.639302
273	Freguesia do Ó	2	b80be0f6-9d2d-4269-b27d-cb549a266240	3	Freguesia do Ó	Freguesia do Ó	-23.5014967000000006	-46.6977015999999878	active	2017-11-10 12:19:48.544117	2017-11-10 12:19:49.015527
274	Cachoeirinha	2	ae2f91f7-7ff3-4af1-91e1-924ee3153e4f	3	Cachoeirinha	Cachoeirinha	-23.479046799999999	-46.6595768999999976	active	2017-11-10 12:19:51.665493	2017-11-10 12:19:52.214281
275	Mandaqui	2	3ec753b0-5834-48bb-868e-450d2a6044f1	3	Mandaqui	Mandaqui	-23.4820871000000011	-46.6258905999999982	active	2017-11-10 12:19:53.5151	2017-11-10 12:19:54.038329
276	Tucuruvi	2	8b15f10c-cb27-4533-9d5a-eb354ec2d6de	3	Tucuruvi	Tucuruvi	-23.473904000000001	-46.6108173999999877	active	2017-11-10 12:19:56.254753	2017-11-10 12:19:56.590478
277	Tremembé	2	14b0840f-123c-414a-8588-db8c7cfed5c0	3	Tremembé	Tremembé	-23.4598630999999997	-46.6254737999999875	active	2017-11-10 12:19:59.06192	2017-11-10 12:19:59.466965
278	Jaçanã	2	45b5e68d-bd50-4ef8-bc7d-2eb86795cf2b	3	Jaçanã	Jaçanã	-23.4532947999999983	-46.5720801999999878	active	2017-11-10 12:20:04.745901	2017-11-10 12:20:05.227722
279	Casa Verde	2	4f0c0bb0-1c82-4431-89d0-691bdca18c4e	3	Casa Verde	Casa Verde	-23.5109880999999987	-46.6574418999999878	active	2017-11-10 12:20:12.343069	2017-11-10 12:20:12.819912
280	Santana	2	a7fc86c7-cf01-49e1-b209-6d9f9ce977c0	3	Santana	Santana	-23.4981809999999989	-46.6263306000000028	active	2017-11-10 12:20:15.432003	2017-11-10 12:20:15.782876
281	Vila Guilherme	2	d756c47d-e484-4e85-ba64-c1204e3d4492	3	Vila Guilherme	Vila Guilherme	-23.5153019999999984	-46.6079436999999999	active	2017-11-10 12:20:17.962692	2017-11-10 12:20:18.428609
282	Vila Medeiros	2	d6db2f03-5a95-4c99-b467-597a5a30b3e9	3	Vila Medeiros	Vila Medeiros	-23.4892825999999992	-46.5845914999999877	active	2017-11-10 12:20:20.467005	2017-11-10 12:20:20.987033
283	Vila Maria	2	e43cc9ea-03b5-4b28-a4dd-39e9e3fed9d4	3	Vila Maria	Vila Maria	-22.6088325999999995	-45.5681086000000022	active	2017-11-10 12:20:22.560413	2017-11-10 12:20:23.015192
284	Penha	2	0075c697-7d18-471d-be59-97d5654f17fc	3	Penha	Penha	-23.5252365999999995	-46.5475598000000019	active	2017-11-10 12:20:24.816361	2017-11-10 12:20:25.174825
285	Vila Matilde	2	c9eb3c46-a0d0-4085-a648-0e76ae26afde	3	Vila Matilde	Vila Matilde	-23.5355595000000015	-46.5271816999999999	active	2017-11-10 12:21:51.403468	2017-11-10 12:21:51.968321
286	Artur Alvim	2	1ffb4853-2307-4c47-ad83-ae9cc1cc2a67	3	Artur Alvim	Artur Alvim	-23.5487514000000004	-46.477195100000003	active	2017-11-10 12:21:54.290108	2017-11-10 12:21:54.852418
287	Ponte Rasa	2	01efbe81-c129-4efc-868a-f1b7c7bf7392	3	Ponte Rasa	Ponte Rasa	-23.5092737000000014	-46.4952313000000004	active	2017-11-10 12:21:56.144601	2017-11-10 12:21:56.671915
288	Ermelino Matarazzo	2	94cc56d4-2d84-4d8c-b656-5048069131a5	3	Ermelino Matarazzo	Ermelino Matarazzo	-23.4888852999999997	-46.4680451999999988	active	2017-11-10 12:21:58.768746	2017-11-10 12:21:59.271886
289	Vila Jacuí	2	44fcaeba-b8f2-4e92-aa77-1ea59d46e6c0	3	Vila Jacuí	Vila Jacuí	-23.5004424000000007	-46.454774399999998	active	2017-11-10 12:22:00.828836	2017-11-10 12:22:01.366807
290	Itaquera	2	6254d377-aa88-4aec-8ece-52206c8f5f6c	3	Itaquera	Itaquera	-23.5398463000000007	-46.4475327999999976	active	2017-11-10 12:22:04.664213	2017-11-10 12:22:05.194999
291	Alto de Pinheiros	2	56281c23-56e3-433f-ac40-4fcc0810f43a	3	Alto de Pinheiros	Alto de Pinheiros	-23.5537093000000013	-46.708834699999997	active	2017-11-10 12:26:42.977211	2017-11-10 12:26:43.634226
292	Aricanduva	2	cdff1594-fce3-4fe2-a801-2170f5ee8e4d	3	Aricanduva	Aricanduva	-23.5795193000000012	-46.5110261000000023	active	2017-11-10 12:33:35.768197	2017-11-10 12:33:36.302357
293	Barra Funda	2	285af1c5-7dac-4590-b5a5-0339e51feb86	3	Barra Funda	Barra Funda	-23.5303761999999992	-46.6574318999999988	active	2017-11-10 12:33:40.41747	2017-11-10 12:33:40.941607
294	Bela Vista	2	ea2fd2af-f957-499e-9b3c-e1f53e56e181	3	Bela Vista	Bela Vista	-23.5628311000000004	-46.6462594999999993	active	2017-11-10 12:33:44.074927	2017-11-10 12:33:44.461147
295	Belém	2	4395ed76-1495-4bdc-9a9d-5e6a2607412b	3	Belém	Belém	-23.5470833000000006	-46.5911994000000007	active	2017-11-10 12:33:46.675693	2017-11-10 12:33:47.215955
296	Bom Retiro	2	d600bb31-e5d7-4c95-a9fd-729704c6d2e9	3	Bom Retiro	Bom Retiro	-23.5256699000000005	-46.6407059999999873	active	2017-11-10 12:33:49.369486	2017-11-10 12:33:49.890574
297	Brás	2	88445584-82fb-4223-abeb-c0ff706fcab0	3	Brás	Brás	-23.5380469999999988	-46.6139117000000027	active	2017-11-10 12:33:52.585386	2017-11-10 12:33:53.161522
298	Butantã	2	4a46f2c6-497c-48ce-97aa-fbadaba4204d	3	Butantã	Butantã	-12.8666669999999996	-39.3333330000000032	active	2017-11-10 12:33:55.131382	2017-11-10 12:33:55.463191
299	Cambuci	2	7bd9557d-2501-4bf9-a323-fb7bcb9f9ffb	3	Cambuci	Cambuci	-23.5644728999999984	-46.6211125999999965	active	2017-11-10 12:33:58.645111	2017-11-10 12:33:59.195461
300	Campo Belo	2	db8ec5ff-f84b-4b3b-bc22-087ec982bca0	3	Campo Belo	Campo Belo	-23.6220296000000012	-46.6720199000000022	active	2017-11-10 12:47:31.328921	2017-11-10 12:47:31.860509
301	Campo Grande	2	e28c8832-165f-487a-a3e9-82e3e9a4765f	3	Campo Grande	Campo Grande	-23.6848068000000005	-46.6828568999999973	active	2017-11-10 12:47:34.068396	2017-11-10 12:47:34.637169
302	Campo Limpo	2	22dec63a-f929-4942-9b5d-17e3f40e49ba	3	Campo Limpo	Campo Limpo	-23.6347959000000003	-46.7549901999999875	active	2017-11-10 12:47:36.923075	2017-11-10 12:47:37.393793
303	Capão Redondo	2	583bb652-a257-41da-9c36-0ac299e5d775	3	Capão Redondo	Capão Redondo	-23.6684610999999983	-46.7689718999999968	active	2017-11-10 12:47:39.270521	2017-11-10 12:47:39.850456
304	Carrão	2	4583a895-9f50-4d1b-8d29-ec4bca39d538	3	Carrão	Carrão	-23.5504582000000013	-46.5379276000000033	active	2017-11-10 12:47:42.185584	2017-11-10 12:47:42.609529
305	Cidade Ademar	2	e3bd7d1b-2186-49ac-b5e4-758d7215dfe4	3	Cidade Ademar	Cidade Ademar	-23.670858599999999	-46.6566540999999972	active	2017-11-10 12:47:45.843276	2017-11-10 12:47:46.178498
306	Cidade Dutra	2	2ad47856-ddac-4b7f-8b2e-188d61a75d5a	3	Cidade Dutra	Cidade Dutra	-23.7116913999999994	-46.7038790000000006	active	2017-11-10 12:47:47.565367	2017-11-10 12:47:48.1203
307	Cidade Tiradentes	2	df42448a-c20a-467b-86f5-f0fb95c92127	3	Cidade Tiradentes	Cidade Tiradentes	-23.6016778999999985	-46.398766700000003	active	2017-11-10 12:47:50.240205	2017-11-10 12:47:50.753808
308	Consolação	2	3cb31f0c-818e-4ae3-a5af-4d909855dc2f	3	Consolação	Consolação	-23.5525683999999984	-46.6556591000000012	active	2017-11-10 12:47:52.149004	2017-11-10 12:47:52.673651
309	Cursino	2	b2d8ad7d-b04d-4e58-8362-625f70b291c2	3	Cursino	Cursino	-23.6029915000000017	-46.6255389000000022	active	2017-11-10 12:47:54.868689	2017-11-10 12:47:55.392957
310	Grajaú	2	23f26061-bc51-4690-92b6-56840b48a767	3	Grajaú	Grajaú	-23.7721939000000013	-46.6682947999999982	active	2017-11-10 12:47:58.938927	2017-11-10 12:47:59.448034
\.


--
-- Name: weathers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dylan
--

SELECT pg_catalog.setval('weathers_id_seq', 315, true);


--
-- Name: air_qualities air_qualities_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY air_qualities
    ADD CONSTRAINT air_qualities_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bike_stations bike_stations_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY bike_stations
    ADD CONSTRAINT bike_stations_pkey PRIMARY KEY (id);


--
-- Name: initiatives initiatives_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY initiatives
    ADD CONSTRAINT initiatives_pkey PRIMARY KEY (id);


--
-- Name: platforms platforms_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY platforms
    ADD CONSTRAINT platforms_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: static_entities static_entities_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY static_entities
    ADD CONSTRAINT static_entities_pkey PRIMARY KEY (id);


--
-- Name: weathers weathers_pkey; Type: CONSTRAINT; Schema: public; Owner: dylan
--

ALTER TABLE ONLY weathers
    ADD CONSTRAINT weathers_pkey PRIMARY KEY (id);


--
-- Name: index_air_qualities_on_platform_id; Type: INDEX; Schema: public; Owner: dylan
--

CREATE INDEX index_air_qualities_on_platform_id ON air_qualities USING btree (platform_id);


--
-- Name: index_bike_stations_on_platform_id; Type: INDEX; Schema: public; Owner: dylan
--

CREATE INDEX index_bike_stations_on_platform_id ON bike_stations USING btree (platform_id);


--
-- Name: index_initiatives_on_platform_id; Type: INDEX; Schema: public; Owner: dylan
--

CREATE INDEX index_initiatives_on_platform_id ON initiatives USING btree (platform_id);


--
-- Name: index_static_entities_on_platform_id; Type: INDEX; Schema: public; Owner: dylan
--

CREATE INDEX index_static_entities_on_platform_id ON static_entities USING btree (platform_id);


--
-- Name: index_weathers_on_platform_id; Type: INDEX; Schema: public; Owner: dylan
--

CREATE INDEX index_weathers_on_platform_id ON weathers USING btree (platform_id);


--
-- PostgreSQL database dump complete
--


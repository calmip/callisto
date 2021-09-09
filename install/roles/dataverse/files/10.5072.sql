--
-- PostgreSQL database dump
--

-- Dumped from database version 10.14
-- Dumped by pg_dump version 10.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
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


--
-- Name: generateidentifierassequentialnumber(); Type: FUNCTION; Schema: public; Owner: dvnuser
--

CREATE FUNCTION public.generateidentifierassequentialnumber(OUT identifier integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    select nextval('datasetidentifier_seq') into identifier;
END;
$$;


ALTER FUNCTION public.generateidentifierassequentialnumber(OUT identifier integer) OWNER TO dvnuser;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: EJB__TIMER__TBL; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public."EJB__TIMER__TBL" (
    "TIMERID" character varying(255) NOT NULL,
    "APPLICATIONID" bigint,
    "BLOB" bytea,
    "CONTAINERID" bigint,
    "CREATIONTIMERAW" bigint,
    "INITIALEXPIRATIONRAW" bigint,
    "INTERVALDURATION" bigint,
    "LASTEXPIRATIONRAW" bigint,
    "OWNERID" character varying(255),
    "PKHASHCODE" integer,
    "SCHEDULE" character varying(255),
    "STATE" integer
);


ALTER TABLE public."EJB__TIMER__TBL" OWNER TO dvnuser;

--
-- Name: actionlogrecord; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.actionlogrecord (
    id character varying(36) NOT NULL,
    actionresult character varying(255),
    actionsubtype character varying(255),
    actiontype character varying(255),
    endtime timestamp without time zone,
    info text,
    starttime timestamp without time zone,
    useridentifier character varying(255)
);


ALTER TABLE public.actionlogrecord OWNER TO dvnuser;

--
-- Name: alternativepersistentidentifier; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.alternativepersistentidentifier (
    id integer NOT NULL,
    authority character varying(255),
    globalidcreatetime timestamp without time zone,
    identifier character varying(255),
    identifierregistered boolean,
    protocol character varying(255),
    storagelocationdesignator boolean,
    dvobject_id bigint NOT NULL
);


ALTER TABLE public.alternativepersistentidentifier OWNER TO dvnuser;

--
-- Name: alternativepersistentidentifier_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.alternativepersistentidentifier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alternativepersistentidentifier_id_seq OWNER TO dvnuser;

--
-- Name: alternativepersistentidentifier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.alternativepersistentidentifier_id_seq OWNED BY public.alternativepersistentidentifier.id;


--
-- Name: apitoken; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.apitoken (
    id integer NOT NULL,
    createtime timestamp without time zone NOT NULL,
    disabled boolean NOT NULL,
    expiretime timestamp without time zone NOT NULL,
    tokenstring character varying(255) NOT NULL,
    authenticateduser_id bigint NOT NULL
);


ALTER TABLE public.apitoken OWNER TO dvnuser;

--
-- Name: apitoken_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.apitoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.apitoken_id_seq OWNER TO dvnuser;

--
-- Name: apitoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.apitoken_id_seq OWNED BY public.apitoken.id;


--
-- Name: authenticateduser; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.authenticateduser (
    id integer NOT NULL,
    affiliation character varying(255),
    createdtime timestamp without time zone NOT NULL,
    email character varying(255) NOT NULL,
    emailconfirmed timestamp without time zone,
    firstname character varying(255),
    lastapiusetime timestamp without time zone,
    lastlogintime timestamp without time zone,
    lastname character varying(255),
    "position" character varying(255),
    superuser boolean,
    useridentifier character varying(255) NOT NULL
);


ALTER TABLE public.authenticateduser OWNER TO dvnuser;

--
-- Name: authenticateduser_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.authenticateduser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authenticateduser_id_seq OWNER TO dvnuser;

--
-- Name: authenticateduser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.authenticateduser_id_seq OWNED BY public.authenticateduser.id;


--
-- Name: authenticateduserlookup; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.authenticateduserlookup (
    id integer NOT NULL,
    authenticationproviderid character varying(255),
    persistentuserid character varying(255),
    authenticateduser_id bigint NOT NULL
);


ALTER TABLE public.authenticateduserlookup OWNER TO dvnuser;

--
-- Name: authenticateduserlookup_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.authenticateduserlookup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authenticateduserlookup_id_seq OWNER TO dvnuser;

--
-- Name: authenticateduserlookup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.authenticateduserlookup_id_seq OWNED BY public.authenticateduserlookup.id;


--
-- Name: authenticationproviderrow; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.authenticationproviderrow (
    id character varying(255) NOT NULL,
    enabled boolean,
    factoryalias character varying(255),
    factorydata text,
    subtitle character varying(255),
    title character varying(255)
);


ALTER TABLE public.authenticationproviderrow OWNER TO dvnuser;

--
-- Name: builtinuser; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.builtinuser (
    id integer NOT NULL,
    encryptedpassword character varying(255),
    passwordencryptionversion integer,
    username character varying(255) NOT NULL
);


ALTER TABLE public.builtinuser OWNER TO dvnuser;

--
-- Name: builtinuser_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.builtinuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.builtinuser_id_seq OWNER TO dvnuser;

--
-- Name: builtinuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.builtinuser_id_seq OWNED BY public.builtinuser.id;


--
-- Name: categorymetadata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.categorymetadata (
    id integer NOT NULL,
    wfreq double precision,
    category_id bigint NOT NULL,
    variablemetadata_id bigint NOT NULL
);


ALTER TABLE public.categorymetadata OWNER TO dvnuser;

--
-- Name: categorymetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.categorymetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorymetadata_id_seq OWNER TO dvnuser;

--
-- Name: categorymetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.categorymetadata_id_seq OWNED BY public.categorymetadata.id;


--
-- Name: clientharvestrun; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.clientharvestrun (
    id integer NOT NULL,
    deleteddatasetcount bigint,
    faileddatasetcount bigint,
    finishtime timestamp without time zone,
    harvestresult integer,
    harvesteddatasetcount bigint,
    starttime timestamp without time zone,
    harvestingclient_id bigint NOT NULL
);


ALTER TABLE public.clientharvestrun OWNER TO dvnuser;

--
-- Name: clientharvestrun_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.clientharvestrun_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clientharvestrun_id_seq OWNER TO dvnuser;

--
-- Name: clientharvestrun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.clientharvestrun_id_seq OWNED BY public.clientharvestrun.id;


--
-- Name: confirmemaildata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.confirmemaildata (
    id integer NOT NULL,
    created timestamp without time zone NOT NULL,
    expires timestamp without time zone NOT NULL,
    token character varying(255),
    authenticateduser_id bigint NOT NULL
);


ALTER TABLE public.confirmemaildata OWNER TO dvnuser;

--
-- Name: confirmemaildata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.confirmemaildata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.confirmemaildata_id_seq OWNER TO dvnuser;

--
-- Name: confirmemaildata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.confirmemaildata_id_seq OWNED BY public.confirmemaildata.id;


--
-- Name: controlledvocabalternate; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.controlledvocabalternate (
    id integer NOT NULL,
    strvalue text,
    controlledvocabularyvalue_id bigint NOT NULL,
    datasetfieldtype_id bigint NOT NULL
);


ALTER TABLE public.controlledvocabalternate OWNER TO dvnuser;

--
-- Name: controlledvocabalternate_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.controlledvocabalternate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.controlledvocabalternate_id_seq OWNER TO dvnuser;

--
-- Name: controlledvocabalternate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.controlledvocabalternate_id_seq OWNED BY public.controlledvocabalternate.id;


--
-- Name: controlledvocabularyvalue; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.controlledvocabularyvalue (
    id integer NOT NULL,
    displayorder integer,
    identifier character varying(255),
    strvalue text,
    datasetfieldtype_id bigint
);


ALTER TABLE public.controlledvocabularyvalue OWNER TO dvnuser;

--
-- Name: controlledvocabularyvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.controlledvocabularyvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.controlledvocabularyvalue_id_seq OWNER TO dvnuser;

--
-- Name: controlledvocabularyvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.controlledvocabularyvalue_id_seq OWNED BY public.controlledvocabularyvalue.id;


--
-- Name: customfieldmap; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.customfieldmap (
    id integer NOT NULL,
    sourcedatasetfield character varying(255),
    sourcetemplate character varying(255),
    targetdatasetfield character varying(255)
);


ALTER TABLE public.customfieldmap OWNER TO dvnuser;

--
-- Name: customfieldmap_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.customfieldmap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customfieldmap_id_seq OWNER TO dvnuser;

--
-- Name: customfieldmap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.customfieldmap_id_seq OWNED BY public.customfieldmap.id;


--
-- Name: customquestion; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.customquestion (
    id integer NOT NULL,
    displayorder integer,
    hidden boolean,
    questionstring character varying(255) NOT NULL,
    questiontype character varying(255) NOT NULL,
    required boolean,
    guestbook_id bigint NOT NULL
);


ALTER TABLE public.customquestion OWNER TO dvnuser;

--
-- Name: customquestion_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.customquestion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customquestion_id_seq OWNER TO dvnuser;

--
-- Name: customquestion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.customquestion_id_seq OWNED BY public.customquestion.id;


--
-- Name: customquestionresponse; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.customquestionresponse (
    id integer NOT NULL,
    response text,
    customquestion_id bigint NOT NULL,
    guestbookresponse_id bigint NOT NULL
);


ALTER TABLE public.customquestionresponse OWNER TO dvnuser;

--
-- Name: customquestionresponse_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.customquestionresponse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customquestionresponse_id_seq OWNER TO dvnuser;

--
-- Name: customquestionresponse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.customquestionresponse_id_seq OWNED BY public.customquestionresponse.id;


--
-- Name: customquestionvalue; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.customquestionvalue (
    id integer NOT NULL,
    displayorder integer,
    valuestring character varying(255) NOT NULL,
    customquestion_id bigint NOT NULL
);


ALTER TABLE public.customquestionvalue OWNER TO dvnuser;

--
-- Name: customquestionvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.customquestionvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customquestionvalue_id_seq OWNER TO dvnuser;

--
-- Name: customquestionvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.customquestionvalue_id_seq OWNED BY public.customquestionvalue.id;


--
-- Name: customzipservicerequest; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.customzipservicerequest (
    key character varying(63),
    storagelocation character varying(255),
    filename character varying(255),
    issuetime timestamp without time zone
);


ALTER TABLE public.customzipservicerequest OWNER TO dvnuser;

--
-- Name: datafile; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datafile (
    id bigint NOT NULL,
    checksumtype character varying(255) NOT NULL,
    checksumvalue character varying(255) NOT NULL,
    contenttype character varying(255) NOT NULL,
    filesize bigint,
    ingeststatus character(1),
    previousdatafileid bigint,
    prov_entityname text,
    restricted boolean,
    rootdatafileid bigint NOT NULL
);


ALTER TABLE public.datafile OWNER TO dvnuser;

--
-- Name: datafilecategory; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datafilecategory (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    dataset_id bigint NOT NULL
);


ALTER TABLE public.datafilecategory OWNER TO dvnuser;

--
-- Name: datafilecategory_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datafilecategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datafilecategory_id_seq OWNER TO dvnuser;

--
-- Name: datafilecategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datafilecategory_id_seq OWNED BY public.datafilecategory.id;


--
-- Name: datafiletag; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datafiletag (
    id integer NOT NULL,
    type integer NOT NULL,
    datafile_id bigint NOT NULL
);


ALTER TABLE public.datafiletag OWNER TO dvnuser;

--
-- Name: datafiletag_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datafiletag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datafiletag_id_seq OWNER TO dvnuser;

--
-- Name: datafiletag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datafiletag_id_seq OWNED BY public.datafiletag.id;


--
-- Name: dataset; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataset (
    id bigint NOT NULL,
    fileaccessrequest boolean,
    harvestidentifier character varying(255),
    lastexporttime timestamp without time zone,
    usegenericthumbnail boolean,
    citationdatedatasetfieldtype_id bigint,
    harvestingclient_id bigint,
    guestbook_id bigint,
    thumbnailfile_id bigint
);


ALTER TABLE public.dataset OWNER TO dvnuser;

--
-- Name: datasetexternalcitations; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetexternalcitations (
    id bigint NOT NULL,
    citedbyurl character varying(255) NOT NULL,
    dataset_id bigint NOT NULL
);


ALTER TABLE public.datasetexternalcitations OWNER TO dvnuser;

--
-- Name: datasetfield; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetfield (
    id integer NOT NULL,
    datasetfieldtype_id bigint NOT NULL,
    datasetversion_id bigint,
    parentdatasetfieldcompoundvalue_id bigint,
    template_id bigint
);


ALTER TABLE public.datasetfield OWNER TO dvnuser;

--
-- Name: datasetfield_controlledvocabularyvalue; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetfield_controlledvocabularyvalue (
    datasetfield_id bigint NOT NULL,
    controlledvocabularyvalues_id bigint NOT NULL
);


ALTER TABLE public.datasetfield_controlledvocabularyvalue OWNER TO dvnuser;

--
-- Name: datasetfield_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetfield_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetfield_id_seq OWNER TO dvnuser;

--
-- Name: datasetfield_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetfield_id_seq OWNED BY public.datasetfield.id;


--
-- Name: datasetfieldcompoundvalue; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetfieldcompoundvalue (
    id integer NOT NULL,
    displayorder integer,
    parentdatasetfield_id bigint
);


ALTER TABLE public.datasetfieldcompoundvalue OWNER TO dvnuser;

--
-- Name: datasetfieldcompoundvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetfieldcompoundvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetfieldcompoundvalue_id_seq OWNER TO dvnuser;

--
-- Name: datasetfieldcompoundvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetfieldcompoundvalue_id_seq OWNED BY public.datasetfieldcompoundvalue.id;


--
-- Name: datasetfielddefaultvalue; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetfielddefaultvalue (
    id integer NOT NULL,
    displayorder integer,
    strvalue text,
    datasetfield_id bigint NOT NULL,
    defaultvalueset_id bigint NOT NULL,
    parentdatasetfielddefaultvalue_id bigint
);


ALTER TABLE public.datasetfielddefaultvalue OWNER TO dvnuser;

--
-- Name: datasetfielddefaultvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetfielddefaultvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetfielddefaultvalue_id_seq OWNER TO dvnuser;

--
-- Name: datasetfielddefaultvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetfielddefaultvalue_id_seq OWNED BY public.datasetfielddefaultvalue.id;


--
-- Name: datasetfieldtype; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetfieldtype (
    id integer NOT NULL,
    advancedsearchfieldtype boolean,
    allowcontrolledvocabulary boolean,
    allowmultiples boolean,
    description text,
    displayformat character varying(255),
    displayoncreate boolean,
    displayorder integer,
    facetable boolean,
    fieldtype character varying(255) NOT NULL,
    name text,
    required boolean,
    title text,
    uri text,
    validationformat character varying(255),
    watermark character varying(255),
    metadatablock_id bigint,
    parentdatasetfieldtype_id bigint
);


ALTER TABLE public.datasetfieldtype OWNER TO dvnuser;

--
-- Name: datasetfieldtype_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetfieldtype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetfieldtype_id_seq OWNER TO dvnuser;

--
-- Name: datasetfieldtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetfieldtype_id_seq OWNED BY public.datasetfieldtype.id;


--
-- Name: datasetfieldvalue; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetfieldvalue (
    id integer NOT NULL,
    displayorder integer,
    value text,
    datasetfield_id bigint NOT NULL
);


ALTER TABLE public.datasetfieldvalue OWNER TO dvnuser;

--
-- Name: datasetfieldvalue_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetfieldvalue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetfieldvalue_id_seq OWNER TO dvnuser;

--
-- Name: datasetfieldvalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetfieldvalue_id_seq OWNED BY public.datasetfieldvalue.id;


--
-- Name: datasetidentifier_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetidentifier_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetidentifier_seq OWNER TO dvnuser;

--
-- Name: datasetlinkingdataverse; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetlinkingdataverse (
    id integer NOT NULL,
    linkcreatetime timestamp without time zone NOT NULL,
    dataset_id bigint NOT NULL,
    linkingdataverse_id bigint NOT NULL
);


ALTER TABLE public.datasetlinkingdataverse OWNER TO dvnuser;

--
-- Name: datasetlinkingdataverse_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetlinkingdataverse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetlinkingdataverse_id_seq OWNER TO dvnuser;

--
-- Name: datasetlinkingdataverse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetlinkingdataverse_id_seq OWNED BY public.datasetlinkingdataverse.id;


--
-- Name: datasetlock; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetlock (
    id integer NOT NULL,
    info character varying(255),
    reason character varying(255) NOT NULL,
    starttime timestamp without time zone,
    dataset_id bigint NOT NULL,
    user_id bigint NOT NULL
);


ALTER TABLE public.datasetlock OWNER TO dvnuser;

--
-- Name: datasetlock_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetlock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetlock_id_seq OWNER TO dvnuser;

--
-- Name: datasetlock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetlock_id_seq OWNED BY public.datasetlock.id;


--
-- Name: datasetmetrics; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetmetrics (
    id integer NOT NULL,
    countrycode character varying(255),
    downloadstotalmachine bigint,
    downloadstotalregular bigint,
    downloadsuniquemachine bigint,
    downloadsuniqueregular bigint,
    monthyear character varying(255),
    viewstotalmachine bigint,
    viewstotalregular bigint,
    viewsuniquemachine bigint,
    viewsuniqueregular bigint,
    dataset_id bigint NOT NULL
);


ALTER TABLE public.datasetmetrics OWNER TO dvnuser;

--
-- Name: datasetmetrics_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetmetrics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetmetrics_id_seq OWNER TO dvnuser;

--
-- Name: datasetmetrics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetmetrics_id_seq OWNED BY public.datasetmetrics.id;


--
-- Name: datasetversion; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetversion (
    id integer NOT NULL,
    unf character varying(255),
    archivalcopylocation text,
    archivenote character varying(1000),
    archivetime timestamp without time zone,
    createtime timestamp without time zone NOT NULL,
    deaccessionlink character varying(255),
    lastupdatetime timestamp without time zone NOT NULL,
    minorversionnumber bigint,
    releasetime timestamp without time zone,
    version bigint,
    versionnote character varying(1000),
    versionnumber bigint,
    versionstate character varying(255),
    dataset_id bigint,
    termsofuseandaccess_id bigint
);


ALTER TABLE public.datasetversion OWNER TO dvnuser;

--
-- Name: datasetversion_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetversion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetversion_id_seq OWNER TO dvnuser;

--
-- Name: datasetversion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetversion_id_seq OWNED BY public.datasetversion.id;


--
-- Name: datasetversionuser; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datasetversionuser (
    id integer NOT NULL,
    lastupdatedate timestamp without time zone NOT NULL,
    authenticateduser_id bigint,
    datasetversion_id bigint
);


ALTER TABLE public.datasetversionuser OWNER TO dvnuser;

--
-- Name: datasetversionuser_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datasetversionuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datasetversionuser_id_seq OWNER TO dvnuser;

--
-- Name: datasetversionuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datasetversionuser_id_seq OWNED BY public.datasetversionuser.id;


--
-- Name: datatable; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datatable (
    id integer NOT NULL,
    casequantity bigint,
    originalfileformat character varying(255),
    originalfilename character varying(255),
    originalfilesize bigint,
    originalformatversion character varying(255),
    recordspercase bigint,
    unf character varying(255) NOT NULL,
    varquantity bigint,
    datafile_id bigint NOT NULL
);


ALTER TABLE public.datatable OWNER TO dvnuser;

--
-- Name: datatable_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datatable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datatable_id_seq OWNER TO dvnuser;

--
-- Name: datatable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datatable_id_seq OWNED BY public.datatable.id;


--
-- Name: datavariable; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.datavariable (
    id integer NOT NULL,
    factor boolean,
    fileendposition bigint,
    fileorder integer,
    filestartposition bigint,
    format character varying(255),
    formatcategory character varying(255),
    "interval" integer,
    label text,
    name character varying(255),
    numberofdecimalpoints bigint,
    orderedfactor boolean,
    recordsegmentnumber bigint,
    type integer,
    unf character varying(255),
    weighted boolean,
    datatable_id bigint NOT NULL
);


ALTER TABLE public.datavariable OWNER TO dvnuser;

--
-- Name: datavariable_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.datavariable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.datavariable_id_seq OWNER TO dvnuser;

--
-- Name: datavariable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.datavariable_id_seq OWNED BY public.datavariable.id;


--
-- Name: dataverse; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataverse (
    id bigint NOT NULL,
    affiliation character varying(255),
    alias character varying(255) NOT NULL,
    dataversetype character varying(255) NOT NULL,
    description text,
    facetroot boolean,
    guestbookroot boolean,
    metadatablockroot boolean,
    name character varying(255) NOT NULL,
    permissionroot boolean,
    storagedriver character varying(255),
    templateroot boolean,
    themeroot boolean,
    defaultcontributorrole_id bigint,
    defaulttemplate_id bigint
);


ALTER TABLE public.dataverse OWNER TO dvnuser;

--
-- Name: dataverse_citationdatasetfieldtypes; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataverse_citationdatasetfieldtypes (
    dataverse_id bigint NOT NULL,
    citationdatasetfieldtype_id bigint NOT NULL
);


ALTER TABLE public.dataverse_citationdatasetfieldtypes OWNER TO dvnuser;

--
-- Name: dataverse_metadatablock; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataverse_metadatablock (
    dataverse_id bigint NOT NULL,
    metadatablocks_id bigint NOT NULL
);


ALTER TABLE public.dataverse_metadatablock OWNER TO dvnuser;

--
-- Name: dataversecontact; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataversecontact (
    id integer NOT NULL,
    contactemail character varying(255) NOT NULL,
    displayorder integer,
    dataverse_id bigint
);


ALTER TABLE public.dataversecontact OWNER TO dvnuser;

--
-- Name: dataversecontact_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataversecontact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataversecontact_id_seq OWNER TO dvnuser;

--
-- Name: dataversecontact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataversecontact_id_seq OWNED BY public.dataversecontact.id;


--
-- Name: dataversefacet; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataversefacet (
    id integer NOT NULL,
    displayorder integer,
    datasetfieldtype_id bigint,
    dataverse_id bigint
);


ALTER TABLE public.dataversefacet OWNER TO dvnuser;

--
-- Name: dataversefacet_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataversefacet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataversefacet_id_seq OWNER TO dvnuser;

--
-- Name: dataversefacet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataversefacet_id_seq OWNED BY public.dataversefacet.id;


--
-- Name: dataversefeatureddataverse; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataversefeatureddataverse (
    id integer NOT NULL,
    displayorder integer,
    dataverse_id bigint,
    featureddataverse_id bigint
);


ALTER TABLE public.dataversefeatureddataverse OWNER TO dvnuser;

--
-- Name: dataversefeatureddataverse_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataversefeatureddataverse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataversefeatureddataverse_id_seq OWNER TO dvnuser;

--
-- Name: dataversefeatureddataverse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataversefeatureddataverse_id_seq OWNED BY public.dataversefeatureddataverse.id;


--
-- Name: dataversefieldtypeinputlevel; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataversefieldtypeinputlevel (
    id integer NOT NULL,
    include boolean,
    required boolean,
    datasetfieldtype_id bigint,
    dataverse_id bigint
);


ALTER TABLE public.dataversefieldtypeinputlevel OWNER TO dvnuser;

--
-- Name: dataversefieldtypeinputlevel_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataversefieldtypeinputlevel_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataversefieldtypeinputlevel_id_seq OWNER TO dvnuser;

--
-- Name: dataversefieldtypeinputlevel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataversefieldtypeinputlevel_id_seq OWNED BY public.dataversefieldtypeinputlevel.id;


--
-- Name: dataverselinkingdataverse; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataverselinkingdataverse (
    id integer NOT NULL,
    linkcreatetime timestamp without time zone,
    dataverse_id bigint NOT NULL,
    linkingdataverse_id bigint NOT NULL
);


ALTER TABLE public.dataverselinkingdataverse OWNER TO dvnuser;

--
-- Name: dataverselinkingdataverse_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataverselinkingdataverse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataverselinkingdataverse_id_seq OWNER TO dvnuser;

--
-- Name: dataverselinkingdataverse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataverselinkingdataverse_id_seq OWNED BY public.dataverselinkingdataverse.id;


--
-- Name: dataverserole; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataverserole (
    id integer NOT NULL,
    alias character varying(255) NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL,
    permissionbits bigint,
    owner_id bigint
);


ALTER TABLE public.dataverserole OWNER TO dvnuser;

--
-- Name: dataverserole_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataverserole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataverserole_id_seq OWNER TO dvnuser;

--
-- Name: dataverserole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataverserole_id_seq OWNED BY public.dataverserole.id;


--
-- Name: dataversesubjects; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataversesubjects (
    dataverse_id bigint NOT NULL,
    controlledvocabularyvalue_id bigint NOT NULL
);


ALTER TABLE public.dataversesubjects OWNER TO dvnuser;

--
-- Name: dataversetheme; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dataversetheme (
    id integer NOT NULL,
    backgroundcolor character varying(255),
    linkcolor character varying(255),
    linkurl character varying(255),
    logo character varying(255),
    logoalignment character varying(255),
    logobackgroundcolor character varying(255),
    logofooter character varying(255),
    logofooteralignment integer,
    logofooterbackgroundcolor character varying(255),
    logoformat character varying(255),
    tagline character varying(255),
    textcolor character varying(255),
    dataverse_id bigint
);


ALTER TABLE public.dataversetheme OWNER TO dvnuser;

--
-- Name: dataversetheme_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dataversetheme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataversetheme_id_seq OWNER TO dvnuser;

--
-- Name: dataversetheme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dataversetheme_id_seq OWNED BY public.dataversetheme.id;


--
-- Name: defaultvalueset; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.defaultvalueset (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.defaultvalueset OWNER TO dvnuser;

--
-- Name: defaultvalueset_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.defaultvalueset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.defaultvalueset_id_seq OWNER TO dvnuser;

--
-- Name: defaultvalueset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.defaultvalueset_id_seq OWNED BY public.defaultvalueset.id;


--
-- Name: doidataciteregistercache; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.doidataciteregistercache (
    id integer NOT NULL,
    doi character varying(255),
    status character varying(255),
    url character varying(255),
    xml text
);


ALTER TABLE public.doidataciteregistercache OWNER TO dvnuser;

--
-- Name: doidataciteregistercache_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.doidataciteregistercache_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doidataciteregistercache_id_seq OWNER TO dvnuser;

--
-- Name: doidataciteregistercache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.doidataciteregistercache_id_seq OWNED BY public.doidataciteregistercache.id;


--
-- Name: dvobject; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.dvobject (
    id integer NOT NULL,
    dtype character varying(31),
    authority character varying(255),
    createdate timestamp without time zone NOT NULL,
    globalidcreatetime timestamp without time zone,
    identifier character varying(255),
    identifierregistered boolean,
    indextime timestamp without time zone,
    modificationtime timestamp without time zone NOT NULL,
    permissionindextime timestamp without time zone,
    permissionmodificationtime timestamp without time zone,
    previewimageavailable boolean,
    protocol character varying(255),
    publicationdate timestamp without time zone,
    storageidentifier character varying(255),
    creator_id bigint,
    owner_id bigint,
    releaseuser_id bigint
);


ALTER TABLE public.dvobject OWNER TO dvnuser;

--
-- Name: dvobject_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.dvobject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dvobject_id_seq OWNER TO dvnuser;

--
-- Name: dvobject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.dvobject_id_seq OWNED BY public.dvobject.id;


--
-- Name: explicitgroup; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.explicitgroup (
    id integer NOT NULL,
    description character varying(1024),
    displayname character varying(255),
    groupalias character varying(255),
    groupaliasinowner character varying(255),
    owner_id bigint
);


ALTER TABLE public.explicitgroup OWNER TO dvnuser;

--
-- Name: explicitgroup_authenticateduser; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.explicitgroup_authenticateduser (
    explicitgroup_id bigint NOT NULL,
    containedauthenticatedusers_id bigint NOT NULL
);


ALTER TABLE public.explicitgroup_authenticateduser OWNER TO dvnuser;

--
-- Name: explicitgroup_containedroleassignees; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.explicitgroup_containedroleassignees (
    explicitgroup_id bigint,
    containedroleassignees character varying(255)
);


ALTER TABLE public.explicitgroup_containedroleassignees OWNER TO dvnuser;

--
-- Name: explicitgroup_explicitgroup; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.explicitgroup_explicitgroup (
    explicitgroup_id bigint NOT NULL,
    containedexplicitgroups_id bigint NOT NULL
);


ALTER TABLE public.explicitgroup_explicitgroup OWNER TO dvnuser;

--
-- Name: explicitgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.explicitgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.explicitgroup_id_seq OWNER TO dvnuser;

--
-- Name: explicitgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.explicitgroup_id_seq OWNED BY public.explicitgroup.id;


--
-- Name: externaltool; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.externaltool (
    id integer NOT NULL,
    contenttype text,
    description text,
    displayname character varying(255) NOT NULL,
    haspreviewmode boolean NOT NULL,
    scope character varying(255) NOT NULL,
    toolname character varying(255),
    toolparameters character varying(255) NOT NULL,
    toolurl character varying(255) NOT NULL,
    type character varying(255) NOT NULL
);


ALTER TABLE public.externaltool OWNER TO dvnuser;

--
-- Name: externaltool_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.externaltool_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.externaltool_id_seq OWNER TO dvnuser;

--
-- Name: externaltool_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.externaltool_id_seq OWNED BY public.externaltool.id;


--
-- Name: fileaccessrequests; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.fileaccessrequests (
    datafile_id bigint NOT NULL,
    authenticated_user_id bigint NOT NULL
);


ALTER TABLE public.fileaccessrequests OWNER TO dvnuser;

--
-- Name: filedownload; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.filedownload (
    downloadtimestamp timestamp without time zone,
    downloadtype character varying(255),
    guestbookresponse_id bigint NOT NULL,
    sessionid character varying(255)
);


ALTER TABLE public.filedownload OWNER TO dvnuser;

--
-- Name: filemetadata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.filemetadata (
    id integer NOT NULL,
    description text,
    directorylabel character varying(255),
    label character varying(255) NOT NULL,
    prov_freeform text,
    restricted boolean,
    version bigint,
    datafile_id bigint NOT NULL,
    datasetversion_id bigint NOT NULL
);


ALTER TABLE public.filemetadata OWNER TO dvnuser;

--
-- Name: filemetadata_datafilecategory; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.filemetadata_datafilecategory (
    filecategories_id bigint NOT NULL,
    filemetadatas_id bigint NOT NULL
);


ALTER TABLE public.filemetadata_datafilecategory OWNER TO dvnuser;

--
-- Name: filemetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.filemetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.filemetadata_id_seq OWNER TO dvnuser;

--
-- Name: filemetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.filemetadata_id_seq OWNED BY public.filemetadata.id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO dvnuser;

--
-- Name: foreignmetadatafieldmapping; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.foreignmetadatafieldmapping (
    id integer NOT NULL,
    datasetfieldname text,
    foreignfieldxpath text,
    isattribute boolean,
    foreignmetadataformatmapping_id bigint,
    parentfieldmapping_id bigint
);


ALTER TABLE public.foreignmetadatafieldmapping OWNER TO dvnuser;

--
-- Name: foreignmetadatafieldmapping_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.foreignmetadatafieldmapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foreignmetadatafieldmapping_id_seq OWNER TO dvnuser;

--
-- Name: foreignmetadatafieldmapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.foreignmetadatafieldmapping_id_seq OWNED BY public.foreignmetadatafieldmapping.id;


--
-- Name: foreignmetadataformatmapping; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.foreignmetadataformatmapping (
    id integer NOT NULL,
    displayname character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    schemalocation character varying(255),
    startelement character varying(255)
);


ALTER TABLE public.foreignmetadataformatmapping OWNER TO dvnuser;

--
-- Name: foreignmetadataformatmapping_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.foreignmetadataformatmapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.foreignmetadataformatmapping_id_seq OWNER TO dvnuser;

--
-- Name: foreignmetadataformatmapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.foreignmetadataformatmapping_id_seq OWNED BY public.foreignmetadataformatmapping.id;


--
-- Name: guestbook; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.guestbook (
    id integer NOT NULL,
    createtime timestamp without time zone NOT NULL,
    emailrequired boolean,
    enabled boolean,
    institutionrequired boolean,
    name character varying(255),
    namerequired boolean,
    positionrequired boolean,
    dataverse_id bigint
);


ALTER TABLE public.guestbook OWNER TO dvnuser;

--
-- Name: guestbook_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.guestbook_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guestbook_id_seq OWNER TO dvnuser;

--
-- Name: guestbook_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.guestbook_id_seq OWNED BY public.guestbook.id;


--
-- Name: guestbookresponse; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.guestbookresponse (
    id integer NOT NULL,
    email character varying(255),
    institution character varying(255),
    name character varying(255),
    "position" character varying(255),
    responsetime timestamp without time zone,
    authenticateduser_id bigint,
    datafile_id bigint NOT NULL,
    dataset_id bigint NOT NULL,
    datasetversion_id bigint,
    guestbook_id bigint NOT NULL
);


ALTER TABLE public.guestbookresponse OWNER TO dvnuser;

--
-- Name: guestbookresponse_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.guestbookresponse_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guestbookresponse_id_seq OWNER TO dvnuser;

--
-- Name: guestbookresponse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.guestbookresponse_id_seq OWNED BY public.guestbookresponse.id;


--
-- Name: harvestingclient; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.harvestingclient (
    id integer NOT NULL,
    archivedescription text,
    archiveurl character varying(255),
    deleted boolean,
    harveststyle character varying(255),
    harvesttype character varying(255),
    harvestingnow boolean,
    harvestingset character varying(255),
    harvestingurl character varying(255),
    metadataprefix character varying(255),
    name character varying(255) NOT NULL,
    scheduledayofweek integer,
    schedulehourofday integer,
    scheduleperiod character varying(255),
    scheduled boolean,
    dataverse_id bigint
);


ALTER TABLE public.harvestingclient OWNER TO dvnuser;

--
-- Name: harvestingclient_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.harvestingclient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.harvestingclient_id_seq OWNER TO dvnuser;

--
-- Name: harvestingclient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.harvestingclient_id_seq OWNED BY public.harvestingclient.id;


--
-- Name: harvestingdataverseconfig; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.harvestingdataverseconfig (
    id bigint NOT NULL,
    archivedescription text,
    archiveurl character varying(255),
    harveststyle character varying(255),
    harvesttype character varying(255),
    harvestingset character varying(255),
    harvestingurl character varying(255),
    dataverse_id bigint
);


ALTER TABLE public.harvestingdataverseconfig OWNER TO dvnuser;

--
-- Name: ingestreport; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.ingestreport (
    id integer NOT NULL,
    endtime timestamp without time zone,
    report text,
    starttime timestamp without time zone,
    status integer,
    type integer,
    datafile_id bigint NOT NULL
);


ALTER TABLE public.ingestreport OWNER TO dvnuser;

--
-- Name: ingestreport_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.ingestreport_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingestreport_id_seq OWNER TO dvnuser;

--
-- Name: ingestreport_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.ingestreport_id_seq OWNED BY public.ingestreport.id;


--
-- Name: ingestrequest; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.ingestrequest (
    id integer NOT NULL,
    controlcard character varying(255),
    forcetypecheck boolean,
    labelsfile character varying(255),
    textencoding character varying(255),
    datafile_id bigint
);


ALTER TABLE public.ingestrequest OWNER TO dvnuser;

--
-- Name: ingestrequest_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.ingestrequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingestrequest_id_seq OWNER TO dvnuser;

--
-- Name: ingestrequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.ingestrequest_id_seq OWNED BY public.ingestrequest.id;


--
-- Name: ipv4range; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.ipv4range (
    id bigint NOT NULL,
    bottomaslong bigint,
    topaslong bigint,
    owner_id bigint
);


ALTER TABLE public.ipv4range OWNER TO dvnuser;

--
-- Name: ipv6range; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.ipv6range (
    id bigint NOT NULL,
    bottoma bigint,
    bottomb bigint,
    bottomc bigint,
    bottomd bigint,
    topa bigint,
    topb bigint,
    topc bigint,
    topd bigint,
    owner_id bigint
);


ALTER TABLE public.ipv6range OWNER TO dvnuser;

--
-- Name: maplayermetadata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.maplayermetadata (
    id integer NOT NULL,
    embedmaplink character varying(255) NOT NULL,
    isjoinlayer boolean,
    joindescription text,
    lastverifiedstatus integer,
    lastverifiedtime timestamp without time zone,
    layerlink character varying(255) NOT NULL,
    layername character varying(255) NOT NULL,
    mapimagelink character varying(255),
    maplayerlinks text,
    worldmapusername character varying(255) NOT NULL,
    dataset_id bigint NOT NULL,
    datafile_id bigint NOT NULL
);


ALTER TABLE public.maplayermetadata OWNER TO dvnuser;

--
-- Name: maplayermetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.maplayermetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maplayermetadata_id_seq OWNER TO dvnuser;

--
-- Name: maplayermetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.maplayermetadata_id_seq OWNED BY public.maplayermetadata.id;


--
-- Name: metadatablock; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.metadatablock (
    id integer NOT NULL,
    displayname character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    namespaceuri text,
    owner_id bigint
);


ALTER TABLE public.metadatablock OWNER TO dvnuser;

--
-- Name: metadatablock_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.metadatablock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metadatablock_id_seq OWNER TO dvnuser;

--
-- Name: metadatablock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.metadatablock_id_seq OWNED BY public.metadatablock.id;


--
-- Name: metric; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.metric (
    id integer NOT NULL,
    datalocation text,
    daystring text,
    lastcalleddate timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    valuejson text
);


ALTER TABLE public.metric OWNER TO dvnuser;

--
-- Name: metric_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.metric_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.metric_id_seq OWNER TO dvnuser;

--
-- Name: metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.metric_id_seq OWNED BY public.metric.id;


--
-- Name: oairecord; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.oairecord (
    id integer NOT NULL,
    globalid character varying(255),
    lastupdatetime timestamp without time zone,
    removed boolean,
    setname character varying(255)
);


ALTER TABLE public.oairecord OWNER TO dvnuser;

--
-- Name: oairecord_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.oairecord_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oairecord_id_seq OWNER TO dvnuser;

--
-- Name: oairecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.oairecord_id_seq OWNED BY public.oairecord.id;


--
-- Name: oaiset; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.oaiset (
    id integer NOT NULL,
    definition text,
    deleted boolean,
    description text,
    name text,
    spec text,
    updateinprogress boolean,
    version bigint
);


ALTER TABLE public.oaiset OWNER TO dvnuser;

--
-- Name: oaiset_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.oaiset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oaiset_id_seq OWNER TO dvnuser;

--
-- Name: oaiset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.oaiset_id_seq OWNED BY public.oaiset.id;


--
-- Name: oauth2tokendata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.oauth2tokendata (
    id integer NOT NULL,
    accesstoken text,
    expirydate timestamp without time zone,
    oauthproviderid character varying(255),
    rawresponse text,
    refreshtoken character varying(64),
    tokentype character varying(32),
    user_id bigint
);


ALTER TABLE public.oauth2tokendata OWNER TO dvnuser;

--
-- Name: oauth2tokendata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.oauth2tokendata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.oauth2tokendata_id_seq OWNER TO dvnuser;

--
-- Name: oauth2tokendata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.oauth2tokendata_id_seq OWNED BY public.oauth2tokendata.id;


--
-- Name: passwordresetdata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.passwordresetdata (
    id integer NOT NULL,
    created timestamp without time zone NOT NULL,
    expires timestamp without time zone NOT NULL,
    reason character varying(255),
    token character varying(255),
    builtinuser_id bigint NOT NULL
);


ALTER TABLE public.passwordresetdata OWNER TO dvnuser;

--
-- Name: passwordresetdata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.passwordresetdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.passwordresetdata_id_seq OWNER TO dvnuser;

--
-- Name: passwordresetdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.passwordresetdata_id_seq OWNED BY public.passwordresetdata.id;


--
-- Name: pendingworkflowinvocation; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.pendingworkflowinvocation (
    invocationid character varying(255) NOT NULL,
    datasetexternallyreleased boolean,
    ipaddress character varying(255),
    nextminorversionnumber bigint,
    nextversionnumber bigint,
    pendingstepidx integer,
    typeordinal integer,
    userid character varying(255),
    workflow_id bigint,
    dataset_id bigint
);


ALTER TABLE public.pendingworkflowinvocation OWNER TO dvnuser;

--
-- Name: pendingworkflowinvocation_localdata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.pendingworkflowinvocation_localdata (
    pendingworkflowinvocation_invocationid character varying(255),
    localdata character varying(255),
    localdata_key character varying(255)
);


ALTER TABLE public.pendingworkflowinvocation_localdata OWNER TO dvnuser;

--
-- Name: persistedglobalgroup; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.persistedglobalgroup (
    id bigint NOT NULL,
    dtype character varying(31),
    description character varying(255),
    displayname character varying(255),
    persistedgroupalias character varying(255),
    emaildomains character varying(255)
);


ALTER TABLE public.persistedglobalgroup OWNER TO dvnuser;

--
-- Name: roleassignment; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.roleassignment (
    id integer NOT NULL,
    assigneeidentifier character varying(255) NOT NULL,
    privateurltoken character varying(255),
    definitionpoint_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.roleassignment OWNER TO dvnuser;

--
-- Name: roleassignment_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.roleassignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roleassignment_id_seq OWNER TO dvnuser;

--
-- Name: roleassignment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.roleassignment_id_seq OWNED BY public.roleassignment.id;


--
-- Name: savedsearch; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.savedsearch (
    id integer NOT NULL,
    query text,
    creator_id bigint NOT NULL,
    definitionpoint_id bigint NOT NULL
);


ALTER TABLE public.savedsearch OWNER TO dvnuser;

--
-- Name: savedsearch_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.savedsearch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.savedsearch_id_seq OWNER TO dvnuser;

--
-- Name: savedsearch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.savedsearch_id_seq OWNED BY public.savedsearch.id;


--
-- Name: savedsearchfilterquery; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.savedsearchfilterquery (
    id integer NOT NULL,
    filterquery text,
    savedsearch_id bigint NOT NULL
);


ALTER TABLE public.savedsearchfilterquery OWNER TO dvnuser;

--
-- Name: savedsearchfilterquery_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.savedsearchfilterquery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.savedsearchfilterquery_id_seq OWNER TO dvnuser;

--
-- Name: savedsearchfilterquery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.savedsearchfilterquery_id_seq OWNED BY public.savedsearchfilterquery.id;


--
-- Name: sequence; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.sequence (
    seq_name character varying(50) NOT NULL,
    seq_count numeric(38,0)
);


ALTER TABLE public.sequence OWNER TO dvnuser;

--
-- Name: setting; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.setting (
    id integer NOT NULL,
    content text,
    lang text,
    name text,
    CONSTRAINT non_empty_lang CHECK ((lang <> ''::text))
);


ALTER TABLE public.setting OWNER TO dvnuser;

--
-- Name: setting_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.setting_id_seq OWNER TO dvnuser;

--
-- Name: setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.setting_id_seq OWNED BY public.setting.id;


--
-- Name: setting_id_seq1; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.setting_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.setting_id_seq1 OWNER TO dvnuser;

--
-- Name: setting_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.setting_id_seq1 OWNED BY public.setting.id;


--
-- Name: shibgroup; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.shibgroup (
    id integer NOT NULL,
    attribute character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    pattern character varying(255) NOT NULL
);


ALTER TABLE public.shibgroup OWNER TO dvnuser;

--
-- Name: shibgroup_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.shibgroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shibgroup_id_seq OWNER TO dvnuser;

--
-- Name: shibgroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.shibgroup_id_seq OWNED BY public.shibgroup.id;


--
-- Name: storagesite; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.storagesite (
    id integer NOT NULL,
    hostname text,
    name text,
    primarystorage boolean NOT NULL,
    transferprotocols text
);


ALTER TABLE public.storagesite OWNER TO dvnuser;

--
-- Name: storagesite_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.storagesite_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.storagesite_id_seq OWNER TO dvnuser;

--
-- Name: storagesite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.storagesite_id_seq OWNED BY public.storagesite.id;


--
-- Name: summarystatistic; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.summarystatistic (
    id integer NOT NULL,
    type integer,
    value character varying(255),
    datavariable_id bigint NOT NULL
);


ALTER TABLE public.summarystatistic OWNER TO dvnuser;

--
-- Name: summarystatistic_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.summarystatistic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.summarystatistic_id_seq OWNER TO dvnuser;

--
-- Name: summarystatistic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.summarystatistic_id_seq OWNED BY public.summarystatistic.id;


--
-- Name: template; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.template (
    id integer NOT NULL,
    createtime timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    usagecount bigint,
    dataverse_id bigint,
    termsofuseandaccess_id bigint
);


ALTER TABLE public.template OWNER TO dvnuser;

--
-- Name: template_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.template_id_seq OWNER TO dvnuser;

--
-- Name: template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.template_id_seq OWNED BY public.template.id;


--
-- Name: termsofuseandaccess; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.termsofuseandaccess (
    id integer NOT NULL,
    availabilitystatus text,
    citationrequirements text,
    conditions text,
    confidentialitydeclaration text,
    contactforaccess text,
    dataaccessplace text,
    depositorrequirements text,
    disclaimer text,
    fileaccessrequest boolean,
    license character varying(255),
    originalarchive text,
    restrictions text,
    sizeofcollection text,
    specialpermissions text,
    studycompletion text,
    termsofaccess text,
    termsofuse text
);


ALTER TABLE public.termsofuseandaccess OWNER TO dvnuser;

--
-- Name: termsofuseandaccess_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.termsofuseandaccess_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.termsofuseandaccess_id_seq OWNER TO dvnuser;

--
-- Name: termsofuseandaccess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.termsofuseandaccess_id_seq OWNED BY public.termsofuseandaccess.id;


--
-- Name: usernotification; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.usernotification (
    id integer NOT NULL,
    emailed boolean,
    objectid bigint,
    readnotification boolean,
    senddate timestamp without time zone,
    type integer NOT NULL,
    requestor_id bigint,
    user_id bigint NOT NULL
);


ALTER TABLE public.usernotification OWNER TO dvnuser;

--
-- Name: usernotification_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.usernotification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usernotification_id_seq OWNER TO dvnuser;

--
-- Name: usernotification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.usernotification_id_seq OWNED BY public.usernotification.id;


--
-- Name: vargroup; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.vargroup (
    id integer NOT NULL,
    label text,
    filemetadata_id bigint NOT NULL
);


ALTER TABLE public.vargroup OWNER TO dvnuser;

--
-- Name: vargroup_datavariable; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.vargroup_datavariable (
    vargroup_id bigint NOT NULL,
    varsingroup_id bigint NOT NULL
);


ALTER TABLE public.vargroup_datavariable OWNER TO dvnuser;

--
-- Name: vargroup_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.vargroup_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vargroup_id_seq OWNER TO dvnuser;

--
-- Name: vargroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.vargroup_id_seq OWNED BY public.vargroup.id;


--
-- Name: variablecategory; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.variablecategory (
    id integer NOT NULL,
    catorder integer,
    frequency double precision,
    label character varying(255),
    missing boolean,
    value character varying(255),
    datavariable_id bigint NOT NULL
);


ALTER TABLE public.variablecategory OWNER TO dvnuser;

--
-- Name: variablecategory_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.variablecategory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variablecategory_id_seq OWNER TO dvnuser;

--
-- Name: variablecategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.variablecategory_id_seq OWNED BY public.variablecategory.id;


--
-- Name: variablemetadata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.variablemetadata (
    id integer NOT NULL,
    interviewinstruction text,
    isweightvar boolean,
    label text,
    literalquestion text,
    notes text,
    postquestion text,
    universe character varying(255),
    weighted boolean,
    datavariable_id bigint NOT NULL,
    filemetadata_id bigint NOT NULL,
    weightvariable_id bigint
);


ALTER TABLE public.variablemetadata OWNER TO dvnuser;

--
-- Name: variablemetadata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.variablemetadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variablemetadata_id_seq OWNER TO dvnuser;

--
-- Name: variablemetadata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.variablemetadata_id_seq OWNED BY public.variablemetadata.id;


--
-- Name: variablerange; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.variablerange (
    id integer NOT NULL,
    beginvalue character varying(255),
    beginvaluetype integer,
    endvalue character varying(255),
    endvaluetype integer,
    datavariable_id bigint NOT NULL
);


ALTER TABLE public.variablerange OWNER TO dvnuser;

--
-- Name: variablerange_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.variablerange_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variablerange_id_seq OWNER TO dvnuser;

--
-- Name: variablerange_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.variablerange_id_seq OWNED BY public.variablerange.id;


--
-- Name: variablerangeitem; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.variablerangeitem (
    id integer NOT NULL,
    value numeric(38,0),
    datavariable_id bigint NOT NULL
);


ALTER TABLE public.variablerangeitem OWNER TO dvnuser;

--
-- Name: variablerangeitem_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.variablerangeitem_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.variablerangeitem_id_seq OWNER TO dvnuser;

--
-- Name: variablerangeitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.variablerangeitem_id_seq OWNED BY public.variablerangeitem.id;


--
-- Name: workflow; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.workflow (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.workflow OWNER TO dvnuser;

--
-- Name: workflow_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.workflow_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflow_id_seq OWNER TO dvnuser;

--
-- Name: workflow_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.workflow_id_seq OWNED BY public.workflow.id;


--
-- Name: workflowcomment; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.workflowcomment (
    id integer NOT NULL,
    created timestamp without time zone NOT NULL,
    message text,
    type character varying(255) NOT NULL,
    authenticateduser_id bigint,
    datasetversion_id bigint NOT NULL
);


ALTER TABLE public.workflowcomment OWNER TO dvnuser;

--
-- Name: workflowcomment_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.workflowcomment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflowcomment_id_seq OWNER TO dvnuser;

--
-- Name: workflowcomment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.workflowcomment_id_seq OWNED BY public.workflowcomment.id;


--
-- Name: workflowstepdata; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.workflowstepdata (
    id integer NOT NULL,
    providerid character varying(255),
    steptype character varying(255),
    parent_id bigint,
    index integer
);


ALTER TABLE public.workflowstepdata OWNER TO dvnuser;

--
-- Name: workflowstepdata_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.workflowstepdata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workflowstepdata_id_seq OWNER TO dvnuser;

--
-- Name: workflowstepdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.workflowstepdata_id_seq OWNED BY public.workflowstepdata.id;


--
-- Name: workflowstepdata_stepparameters; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.workflowstepdata_stepparameters (
    workflowstepdata_id bigint,
    stepparameters character varying(2048),
    stepparameters_key character varying(255)
);


ALTER TABLE public.workflowstepdata_stepparameters OWNER TO dvnuser;

--
-- Name: workflowstepdata_stepsettings; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.workflowstepdata_stepsettings (
    workflowstepdata_id bigint,
    stepsettings character varying(2048),
    stepsettings_key character varying(255)
);


ALTER TABLE public.workflowstepdata_stepsettings OWNER TO dvnuser;

--
-- Name: worldmapauth_token; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.worldmapauth_token (
    id integer NOT NULL,
    created timestamp without time zone NOT NULL,
    hasexpired boolean NOT NULL,
    lastrefreshtime timestamp without time zone NOT NULL,
    modified timestamp without time zone NOT NULL,
    token character varying(255),
    application_id bigint NOT NULL,
    datafile_id bigint NOT NULL,
    dataverseuser_id bigint NOT NULL
);


ALTER TABLE public.worldmapauth_token OWNER TO dvnuser;

--
-- Name: worldmapauth_token_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.worldmapauth_token_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.worldmapauth_token_id_seq OWNER TO dvnuser;

--
-- Name: worldmapauth_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.worldmapauth_token_id_seq OWNED BY public.worldmapauth_token.id;


--
-- Name: worldmapauth_tokentype; Type: TABLE; Schema: public; Owner: dvnuser
--

CREATE TABLE public.worldmapauth_tokentype (
    id integer NOT NULL,
    contactemail character varying(255),
    created timestamp without time zone NOT NULL,
    hostname character varying(255),
    ipaddress character varying(255),
    mapitlink character varying(255) NOT NULL,
    md5 character varying(255) NOT NULL,
    modified timestamp without time zone NOT NULL,
    name character varying(255) NOT NULL,
    timelimitminutes integer DEFAULT 30,
    timelimitseconds bigint DEFAULT 1800
);


ALTER TABLE public.worldmapauth_tokentype OWNER TO dvnuser;

--
-- Name: worldmapauth_tokentype_id_seq; Type: SEQUENCE; Schema: public; Owner: dvnuser
--

CREATE SEQUENCE public.worldmapauth_tokentype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.worldmapauth_tokentype_id_seq OWNER TO dvnuser;

--
-- Name: worldmapauth_tokentype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dvnuser
--

ALTER SEQUENCE public.worldmapauth_tokentype_id_seq OWNED BY public.worldmapauth_tokentype.id;


--
-- Name: alternativepersistentidentifier id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.alternativepersistentidentifier ALTER COLUMN id SET DEFAULT nextval('public.alternativepersistentidentifier_id_seq'::regclass);


--
-- Name: apitoken id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.apitoken ALTER COLUMN id SET DEFAULT nextval('public.apitoken_id_seq'::regclass);


--
-- Name: authenticateduser id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduser ALTER COLUMN id SET DEFAULT nextval('public.authenticateduser_id_seq'::regclass);


--
-- Name: authenticateduserlookup id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduserlookup ALTER COLUMN id SET DEFAULT nextval('public.authenticateduserlookup_id_seq'::regclass);


--
-- Name: builtinuser id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.builtinuser ALTER COLUMN id SET DEFAULT nextval('public.builtinuser_id_seq'::regclass);


--
-- Name: categorymetadata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.categorymetadata ALTER COLUMN id SET DEFAULT nextval('public.categorymetadata_id_seq'::regclass);


--
-- Name: clientharvestrun id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.clientharvestrun ALTER COLUMN id SET DEFAULT nextval('public.clientharvestrun_id_seq'::regclass);


--
-- Name: confirmemaildata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.confirmemaildata ALTER COLUMN id SET DEFAULT nextval('public.confirmemaildata_id_seq'::regclass);


--
-- Name: controlledvocabalternate id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabalternate ALTER COLUMN id SET DEFAULT nextval('public.controlledvocabalternate_id_seq'::regclass);


--
-- Name: controlledvocabularyvalue id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabularyvalue ALTER COLUMN id SET DEFAULT nextval('public.controlledvocabularyvalue_id_seq'::regclass);


--
-- Name: customfieldmap id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customfieldmap ALTER COLUMN id SET DEFAULT nextval('public.customfieldmap_id_seq'::regclass);


--
-- Name: customquestion id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestion ALTER COLUMN id SET DEFAULT nextval('public.customquestion_id_seq'::regclass);


--
-- Name: customquestionresponse id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionresponse ALTER COLUMN id SET DEFAULT nextval('public.customquestionresponse_id_seq'::regclass);


--
-- Name: customquestionvalue id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionvalue ALTER COLUMN id SET DEFAULT nextval('public.customquestionvalue_id_seq'::regclass);


--
-- Name: datafilecategory id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafilecategory ALTER COLUMN id SET DEFAULT nextval('public.datafilecategory_id_seq'::regclass);


--
-- Name: datafiletag id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafiletag ALTER COLUMN id SET DEFAULT nextval('public.datafiletag_id_seq'::regclass);


--
-- Name: datasetfield id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield ALTER COLUMN id SET DEFAULT nextval('public.datasetfield_id_seq'::regclass);


--
-- Name: datasetfieldcompoundvalue id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldcompoundvalue ALTER COLUMN id SET DEFAULT nextval('public.datasetfieldcompoundvalue_id_seq'::regclass);


--
-- Name: datasetfielddefaultvalue id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfielddefaultvalue ALTER COLUMN id SET DEFAULT nextval('public.datasetfielddefaultvalue_id_seq'::regclass);


--
-- Name: datasetfieldtype id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldtype ALTER COLUMN id SET DEFAULT nextval('public.datasetfieldtype_id_seq'::regclass);


--
-- Name: datasetfieldvalue id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldvalue ALTER COLUMN id SET DEFAULT nextval('public.datasetfieldvalue_id_seq'::regclass);


--
-- Name: datasetlinkingdataverse id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlinkingdataverse ALTER COLUMN id SET DEFAULT nextval('public.datasetlinkingdataverse_id_seq'::regclass);


--
-- Name: datasetlock id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlock ALTER COLUMN id SET DEFAULT nextval('public.datasetlock_id_seq'::regclass);


--
-- Name: datasetmetrics id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetmetrics ALTER COLUMN id SET DEFAULT nextval('public.datasetmetrics_id_seq'::regclass);


--
-- Name: datasetversion id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversion ALTER COLUMN id SET DEFAULT nextval('public.datasetversion_id_seq'::regclass);


--
-- Name: datasetversionuser id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversionuser ALTER COLUMN id SET DEFAULT nextval('public.datasetversionuser_id_seq'::regclass);


--
-- Name: datatable id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datatable ALTER COLUMN id SET DEFAULT nextval('public.datatable_id_seq'::regclass);


--
-- Name: datavariable id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datavariable ALTER COLUMN id SET DEFAULT nextval('public.datavariable_id_seq'::regclass);


--
-- Name: dataversecontact id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversecontact ALTER COLUMN id SET DEFAULT nextval('public.dataversecontact_id_seq'::regclass);


--
-- Name: dataversefacet id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefacet ALTER COLUMN id SET DEFAULT nextval('public.dataversefacet_id_seq'::regclass);


--
-- Name: dataversefeatureddataverse id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefeatureddataverse ALTER COLUMN id SET DEFAULT nextval('public.dataversefeatureddataverse_id_seq'::regclass);


--
-- Name: dataversefieldtypeinputlevel id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefieldtypeinputlevel ALTER COLUMN id SET DEFAULT nextval('public.dataversefieldtypeinputlevel_id_seq'::regclass);


--
-- Name: dataverselinkingdataverse id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverselinkingdataverse ALTER COLUMN id SET DEFAULT nextval('public.dataverselinkingdataverse_id_seq'::regclass);


--
-- Name: dataverserole id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverserole ALTER COLUMN id SET DEFAULT nextval('public.dataverserole_id_seq'::regclass);


--
-- Name: dataversetheme id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversetheme ALTER COLUMN id SET DEFAULT nextval('public.dataversetheme_id_seq'::regclass);


--
-- Name: defaultvalueset id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.defaultvalueset ALTER COLUMN id SET DEFAULT nextval('public.defaultvalueset_id_seq'::regclass);


--
-- Name: doidataciteregistercache id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.doidataciteregistercache ALTER COLUMN id SET DEFAULT nextval('public.doidataciteregistercache_id_seq'::regclass);


--
-- Name: dvobject id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject ALTER COLUMN id SET DEFAULT nextval('public.dvobject_id_seq'::regclass);


--
-- Name: explicitgroup id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup ALTER COLUMN id SET DEFAULT nextval('public.explicitgroup_id_seq'::regclass);


--
-- Name: externaltool id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.externaltool ALTER COLUMN id SET DEFAULT nextval('public.externaltool_id_seq'::regclass);


--
-- Name: filemetadata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata ALTER COLUMN id SET DEFAULT nextval('public.filemetadata_id_seq'::regclass);


--
-- Name: foreignmetadatafieldmapping id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadatafieldmapping ALTER COLUMN id SET DEFAULT nextval('public.foreignmetadatafieldmapping_id_seq'::regclass);


--
-- Name: foreignmetadataformatmapping id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadataformatmapping ALTER COLUMN id SET DEFAULT nextval('public.foreignmetadataformatmapping_id_seq'::regclass);


--
-- Name: guestbook id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbook ALTER COLUMN id SET DEFAULT nextval('public.guestbook_id_seq'::regclass);


--
-- Name: guestbookresponse id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse ALTER COLUMN id SET DEFAULT nextval('public.guestbookresponse_id_seq'::regclass);


--
-- Name: harvestingclient id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.harvestingclient ALTER COLUMN id SET DEFAULT nextval('public.harvestingclient_id_seq'::regclass);


--
-- Name: ingestreport id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ingestreport ALTER COLUMN id SET DEFAULT nextval('public.ingestreport_id_seq'::regclass);


--
-- Name: ingestrequest id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ingestrequest ALTER COLUMN id SET DEFAULT nextval('public.ingestrequest_id_seq'::regclass);


--
-- Name: maplayermetadata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.maplayermetadata ALTER COLUMN id SET DEFAULT nextval('public.maplayermetadata_id_seq'::regclass);


--
-- Name: metadatablock id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.metadatablock ALTER COLUMN id SET DEFAULT nextval('public.metadatablock_id_seq'::regclass);


--
-- Name: metric id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.metric ALTER COLUMN id SET DEFAULT nextval('public.metric_id_seq'::regclass);


--
-- Name: oairecord id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oairecord ALTER COLUMN id SET DEFAULT nextval('public.oairecord_id_seq'::regclass);


--
-- Name: oaiset id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oaiset ALTER COLUMN id SET DEFAULT nextval('public.oaiset_id_seq'::regclass);


--
-- Name: oauth2tokendata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oauth2tokendata ALTER COLUMN id SET DEFAULT nextval('public.oauth2tokendata_id_seq'::regclass);


--
-- Name: passwordresetdata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.passwordresetdata ALTER COLUMN id SET DEFAULT nextval('public.passwordresetdata_id_seq'::regclass);


--
-- Name: roleassignment id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.roleassignment ALTER COLUMN id SET DEFAULT nextval('public.roleassignment_id_seq'::regclass);


--
-- Name: savedsearch id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearch ALTER COLUMN id SET DEFAULT nextval('public.savedsearch_id_seq'::regclass);


--
-- Name: savedsearchfilterquery id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearchfilterquery ALTER COLUMN id SET DEFAULT nextval('public.savedsearchfilterquery_id_seq'::regclass);


--
-- Name: setting id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.setting ALTER COLUMN id SET DEFAULT nextval('public.setting_id_seq'::regclass);


--
-- Name: shibgroup id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.shibgroup ALTER COLUMN id SET DEFAULT nextval('public.shibgroup_id_seq'::regclass);


--
-- Name: storagesite id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.storagesite ALTER COLUMN id SET DEFAULT nextval('public.storagesite_id_seq'::regclass);


--
-- Name: summarystatistic id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.summarystatistic ALTER COLUMN id SET DEFAULT nextval('public.summarystatistic_id_seq'::regclass);


--
-- Name: template id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.template ALTER COLUMN id SET DEFAULT nextval('public.template_id_seq'::regclass);


--
-- Name: termsofuseandaccess id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.termsofuseandaccess ALTER COLUMN id SET DEFAULT nextval('public.termsofuseandaccess_id_seq'::regclass);


--
-- Name: usernotification id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.usernotification ALTER COLUMN id SET DEFAULT nextval('public.usernotification_id_seq'::regclass);


--
-- Name: vargroup id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.vargroup ALTER COLUMN id SET DEFAULT nextval('public.vargroup_id_seq'::regclass);


--
-- Name: variablecategory id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablecategory ALTER COLUMN id SET DEFAULT nextval('public.variablecategory_id_seq'::regclass);


--
-- Name: variablemetadata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablemetadata ALTER COLUMN id SET DEFAULT nextval('public.variablemetadata_id_seq'::regclass);


--
-- Name: variablerange id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablerange ALTER COLUMN id SET DEFAULT nextval('public.variablerange_id_seq'::regclass);


--
-- Name: variablerangeitem id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablerangeitem ALTER COLUMN id SET DEFAULT nextval('public.variablerangeitem_id_seq'::regclass);


--
-- Name: workflow id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflow ALTER COLUMN id SET DEFAULT nextval('public.workflow_id_seq'::regclass);


--
-- Name: workflowcomment id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowcomment ALTER COLUMN id SET DEFAULT nextval('public.workflowcomment_id_seq'::regclass);


--
-- Name: workflowstepdata id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowstepdata ALTER COLUMN id SET DEFAULT nextval('public.workflowstepdata_id_seq'::regclass);


--
-- Name: worldmapauth_token id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_token ALTER COLUMN id SET DEFAULT nextval('public.worldmapauth_token_id_seq'::regclass);


--
-- Name: worldmapauth_tokentype id; Type: DEFAULT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_tokentype ALTER COLUMN id SET DEFAULT nextval('public.worldmapauth_tokentype_id_seq'::regclass);


--
-- Data for Name: EJB__TIMER__TBL; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public."EJB__TIMER__TBL" ("TIMERID", "APPLICATIONID", "BLOB", "CONTAINERID", "CREATIONTIMERAW", "INITIALEXPIRATIONRAW", "INTERVALDURATION", "LASTEXPIRATIONRAW", "OWNERID", "PKHASHCODE", "SCHEDULE", "STATE") FROM stdin;
1@@1601887561683@@server@@domain1	104981301713502208	\\xaced0005737200326f72672e676c617373666973682e656a622e70657273697374656e742e74696d65722e54696d6572537461746524426c6f6245b42025117023f80200025b000a696e666f42797465735f7400025b425b00107072696d6172794b657942797465735f71007e000178707070	104981301713567002	1601887561684	1602369000000	0	0	server	0	0 # 30 # 0 # * # * # 0 # * # null # null # null # true # makeLinksForAllSavedSearchesTimer # 0	0
1@@1601901942952@@server@@domain1	104981301713502208	\\xaced0005737200326f72672e676c617373666973682e656a622e70657273697374656e742e74696d65722e54696d6572537461746524426c6f6245b42025117023f80200025b000a696e666f42797465735f7400025b425b00107072696d6172794b657942797465735f71007e00017870757200025b42acf317f8060854e0020000787000000069aced00057372002e6564752e686172766172642e69712e6461746176657273652e74696d65722e4d6f7468657254696d6572496e666fa60b9505b0fae3450200014c000873657276657249647400124c6a6176612f6c616e672f537472696e673b770300013a78707070	104981301713523163	1601901942952	1601902200952	3600000	0	server	0	\N	0
2@@1601901942952@@server@@domain1	104981301713502208	\\xaced0005737200326f72672e676c617373666973682e656a622e70657273697374656e742e74696d65722e54696d6572537461746524426c6f6245b42025117023f80200025b000a696e666f42797465735f7400025b425b00107072696d6172794b657942797465735f71007e00017870757200025b42acf317f8060854e0020000787000000069aced00057372002e6564752e686172766172642e69712e6461746176657273652e74696d65722e4578706f727454696d6572496e666f0bf7b87a75b4093b0200014c000873657276657249647400124c6a6176612f6c616e672f537472696e673b770300013a78707070	104981301713523163	1601901942960	1601942400960	86400000	0	server	0	\N	0
\.


--
-- Data for Name: actionlogrecord; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.actionlogrecord (id, actionresult, actionsubtype, actiontype, endtime, info, starttime, useridentifier) FROM stdin;
30894914-a1c9-45b4-a336-f670d923360b	OK	loadDatasetFields	Admin	2020-10-05 10:46:10.044	rep8675676439831584908tmp	2020-10-05 10:46:08.023	\N
03b49164-44d2-43a1-bc3f-f0aaf188aaf1	OK	loadDatasetFields	Admin	2020-10-05 10:46:11.302	rep5473305708004631437tmp	2020-10-05 10:46:10.075	\N
1d58c76b-d1ed-4bd9-801d-6e507b4a3cc9	OK	loadDatasetFields	Admin	2020-10-05 10:46:11.431	rep2864566074680175472tmp	2020-10-05 10:46:11.326	\N
f6077eab-d764-4b18-a9ec-b33a6a7f2ca2	OK	loadDatasetFields	Admin	2020-10-05 10:46:11.653	rep1800579303925205255tmp	2020-10-05 10:46:11.448	\N
1fcdc01b-2fa7-4ba3-a9d0-a8751dbd2ac9	OK	loadDatasetFields	Admin	2020-10-05 10:46:12.785	rep1549118569871539474tmp	2020-10-05 10:46:11.671	\N
dc300b58-5a00-4bbc-9569-b0d9641ec12d	OK	loadDatasetFields	Admin	2020-10-05 10:46:12.932	rep6551896887711326911tmp	2020-10-05 10:46:12.803	\N
348899b2-de34-45a3-ba2b-0eed769e1964	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.098	admin:A person who has all permissions for dataverses, datasets, and files.	2020-10-05 10:46:13.083	\N
d78b83cb-a706-4663-b181-9c2109cd83f4	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.119	fileDownloader:A person who can download a published file.	2020-10-05 10:46:13.116	\N
449d9567-d976-4226-824c-70111c1fe024	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.138	fullContributor:A person who can add subdataverses and datasets within a dataverse.	2020-10-05 10:46:13.135	\N
9e3821d5-0778-4efe-bf06-05626fc5ed11	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.154	dvContributor:A person who can add subdataverses within a dataverse.	2020-10-05 10:46:13.15	\N
710f80c7-8c6e-40d5-98b7-123d69951e7d	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.172	dsContributor:A person who can add datasets within a dataverse.	2020-10-05 10:46:13.168	\N
d03ca202-fd28-4c7f-9699-ace8d8741f38	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.186	contributor:For datasets, a person who can edit License + Terms, and then submit them for review.	2020-10-05 10:46:13.184	\N
a8bb8a93-d21c-4abc-9069-44418ded6422	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.204	curator:For datasets, a person who can edit License + Terms, edit Permissions, and publish datasets.	2020-10-05 10:46:13.201	\N
2e34899c-2d6f-4c7a-9749-ff9a1f057a4f	OK	createBuiltInRole	Admin	2020-10-05 10:46:13.221	member:A person who can view both unpublished dataverses and datasets.	2020-10-05 10:46:13.218	\N
72a4951f-f1d8-4a79-ab17-0bcb5acc23bd	OK	registerProvider	Auth	2020-10-05 10:46:13.255	builtin:Username/Email	2020-10-05 10:46:13.255	\N
9ab7e96d-2b03-4dfd-aa09-d7d15571d87d	OK	set	Setting	2020-10-05 10:46:13.275	:AllowSignUp: yes	2020-10-05 10:46:13.274	\N
77363aa3-9204-46f9-bbf3-d3ad0a5ff823	OK	set	Setting	2020-10-05 10:46:13.292	:SignUpUrl: /dataverseuser.xhtml?editMode=CREATE	2020-10-05 10:46:13.292	\N
e6aa094f-6aea-49d3-8779-6bd872f2057b	OK	set	Setting	2020-10-05 10:46:13.312	:Protocol: doi	2020-10-05 10:46:13.312	\N
aeddcc9b-3b9b-4248-b818-a716851454e3	OK	set	Setting	2020-10-05 10:46:13.326	:Authority: 10.5072	2020-10-05 10:46:13.326	\N
6f3afddd-407e-4903-909e-892f5fbc07ac	OK	set	Setting	2020-10-05 10:46:13.34	:Shoulder: FK2/	2020-10-05 10:46:13.34	\N
971c61a1-fca3-4aa4-ad41-91b73eb972ca	OK	set	Setting	2020-10-05 10:46:13.357	:DoiProvider: DataCite	2020-10-05 10:46:13.357	\N
ab88bb1b-f167-4580-be65-a8f0a209d78d	OK	set	Setting	2020-10-05 10:46:13.374	BuiltinUsers.KEY: burrito	2020-10-05 10:46:13.374	\N
50cfb964-ad32-4137-833d-2a7776fe0293	OK	set	Setting	2020-10-05 10:46:13.391	:BlockedApiPolicy: localhost-only	2020-10-05 10:46:13.39	\N
63a2be91-673a-4b0a-a68b-34c368ce8e84	OK	set	Setting	2020-10-05 10:46:13.406	:UploadMethods: native/http	2020-10-05 10:46:13.406	\N
a0d179e8-886b-49ba-9ae1-c6c6c4900831	OK	createUser	Auth	2020-10-05 10:46:13.581	@dataverseAdmin	2020-10-05 10:46:13.581	\N
5370c4c1-2f3c-49d4-84c2-8db1a64a71e3	OK	generateApiToken	Auth	2020-10-05 10:46:13.598	user:@dataverseAdmin token:e0967c6e-4679-4c4b-b74f-4e165bd6866c	2020-10-05 10:46:13.598	\N
d6d76229-c0a0-41d9-811c-d55c2725b943	OK	create	BuiltinUser	2020-10-05 10:46:13.611	builtinUser:dataverseAdmin authenticatedUser:@dataverseAdmin	2020-10-05 10:46:13.433	\N
4ddd3602-b806-4c69-a05d-873fe0d8d006	OK	toggleSuperuser	Admin	2020-10-05 10:46:13.626	dataverseAdmin	2020-10-05 10:46:13.622	\N
3e0b6e6b-65f9-4ca6-ac69-d83bdb39c1da	OK	edu.harvard.iq.dataverse.engine.command.impl.CreateDataverseCommand	Command	2020-10-05 10:46:13.949	:<null> 	2020-10-05 10:46:13.713	@dataverseAdmin
fb939d62-23cd-4480-ae6c-c990d71e395a	OK	edu.harvard.iq.dataverse.engine.command.impl.UpdateDataverseMetadataBlocksCommand.SetRoot	Command	2020-10-05 10:46:13.997	:[1 Root] 	2020-10-05 10:46:13.995	@dataverseAdmin
de71bcc9-2e19-49d2-87a3-94677e91df03	OK	edu.harvard.iq.dataverse.engine.command.impl.UpdateDataverseMetadataBlocksCommand.SetBlocks	Command	2020-10-05 10:46:13.999	:[1 Root] 	2020-10-05 10:46:13.991	@dataverseAdmin
1be09652-0d44-4efa-9664-16fd555fa724	OK	edu.harvard.iq.dataverse.engine.command.impl.UpdateDataverseCommand	Command	2020-10-05 10:46:14.058	:[1 Root] 	2020-10-05 10:46:14.033	@dataverseAdmin
c0daa1dc-8f86-498f-9500-77d8f5f4cac4	OK	delete	Setting	2020-10-05 10:46:14.086	BuiltinUsers.KEY	2020-10-05 10:46:14.086	\N
96895f8c-6571-46a3-9f05-df98ea841bf0	OK	set	Setting	2020-10-05 10:46:14.107	:BlockedApiEndpoints: admin,test	2020-10-05 10:46:14.107	\N
b26cd891-0470-40bc-846b-2aa60660bdf9	OK	set	Setting	2020-10-05 10:46:14.125	:SystemEmail: noreply@dataverse.yourinstitution.edu	2020-10-05 10:46:14.125	\N
6ef7f3aa-fbef-4507-9b98-c97d295ade74	OK	set	Setting	2020-10-05 10:47:14.011	:GoogleAnalyticsCode: 	2020-10-05 10:47:14.007	\N
635a4170-62cc-4659-bb4f-2bf428edec48	OK	set	Setting	2020-10-05 10:47:14.803	:FooterCopyright: Your Institution	2020-10-05 10:47:14.803	\N
1ddd1040-18eb-4693-b9bb-d0df8062b2c1	OK	set	Setting	2020-10-05 10:47:15.389	:SystemEmail: noreply@dataverse.yourinstitution.edu	2020-10-05 10:47:15.389	\N
fdae0313-865c-4c5e-9145-e8d9ff359dd8	OK	set	Setting	2020-10-05 10:47:15.979	:Protocol: doi	2020-10-05 10:47:15.978	\N
264d77e1-f495-46d1-af22-016d30fa4de2	OK	set	Setting	2020-10-05 10:47:16.548	:DoiProvider: FAKE	2020-10-05 10:47:16.548	\N
7e3480de-345f-4222-a0e1-3b7f47167ebb	OK	set	Setting	2020-10-05 10:47:17.164	:Authority: 10.5072	2020-10-05 10:47:17.164	\N
0e61d5db-bf9b-474b-a7a9-abacc18eba50	OK	set	Setting	2020-10-05 10:47:17.757	:Shoulder: FK2/	2020-10-05 10:47:17.757	\N
56a1e5f9-f08e-4cc9-94a8-729f07395e91	OK	set	Setting	2020-10-05 10:47:18.375	:ShibEnabled: False	2020-10-05 10:47:18.374	\N
93f08868-b852-4f7e-99c8-446ca8c681d0	OK	set	Setting	2020-10-05 10:47:18.975	:AllowSignUp: True	2020-10-05 10:47:18.975	\N
7de3f465-2d2a-48c5-a49a-42e6a9c64746	OK	set	Setting	2020-10-05 10:47:19.561	:BlockedApiEndpoints: admin,test	2020-10-05 10:47:19.561	\N
401c7a38-bf0a-40a6-9585-da8124f0cdf6	OK	set	Setting	2020-10-05 10:47:20.158	:BlockedApiPolicy: localhost-only	2020-10-05 10:47:20.158	\N
064d48de-d6ee-4b3f-8f91-709b2aa407a2	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.297	External tool added with id 1.	2020-10-05 10:47:28.296	\N
46b28e31-163a-4a29-8baa-6e3ef06865eb	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.32	External tool added with id 2.	2020-10-05 10:47:28.32	\N
57f3f79c-6888-43e1-9123-dab37fa6e780	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.341	External tool added with id 3.	2020-10-05 10:47:28.341	\N
3c19d6d2-81a6-49cd-889f-9730093b81d2	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.362	External tool added with id 4.	2020-10-05 10:47:28.362	\N
4367db09-d915-4f0b-80d8-a74de639245c	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.383	External tool added with id 5.	2020-10-05 10:47:28.383	\N
d03cc802-fd8f-44dc-8859-4354f29d8649	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.405	External tool added with id 6.	2020-10-05 10:47:28.405	\N
544a2884-899d-4720-8aec-fc3480a4c0ac	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.426	External tool added with id 7.	2020-10-05 10:47:28.426	\N
89b7c6cd-cd7a-43be-84f9-21474bab48e8	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.45	External tool added with id 8.	2020-10-05 10:47:28.45	\N
07c43f60-4a22-423d-941e-74431fdf5bc3	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.471	External tool added with id 9.	2020-10-05 10:47:28.471	\N
fdf9b60a-5052-4dae-9886-a0b660ae9c2d	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.492	External tool added with id 10.	2020-10-05 10:47:28.492	\N
246ba75d-40b8-481d-a8ec-161a6bf5f915	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.513	External tool added with id 11.	2020-10-05 10:47:28.513	\N
0cb02684-5ff1-48f1-9b55-27d52ce69ff1	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.535	External tool added with id 12.	2020-10-05 10:47:28.535	\N
9889b0b9-8a51-407a-bbc0-355d7f18595c	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.555	External tool added with id 13.	2020-10-05 10:47:28.554	\N
aa439b4d-8757-4b3b-9f2a-bd3a8c84793f	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.574	External tool added with id 14.	2020-10-05 10:47:28.574	\N
d128f652-77a3-40a8-a18e-3e7fcec04d16	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.594	External tool added with id 15.	2020-10-05 10:47:28.594	\N
61a5b5be-c336-497b-bcc6-44a9bc3da8d2	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.617	External tool added with id 16.	2020-10-05 10:47:28.616	\N
ea19f5ec-cc36-4809-b2bd-ebb6a9254f46	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.639	External tool added with id 17.	2020-10-05 10:47:28.639	\N
ea4d4f80-0a6a-4359-b8bd-beac3e4697fb	OK	addExternalTool	ExternalTool	2020-10-05 10:47:28.66	External tool added with id 18.	2020-10-05 10:47:28.66	\N
547c9a54-d3e9-4d21-bab0-43c068c1251c	OK	addExternalTool	ExternalTool	2020-10-05 10:47:29.857	External tool added with id 19.	2020-10-05 10:47:29.857	\N
e70983fc-e289-4c17-afcf-a31c3915c8dd	OK	addExternalTool	ExternalTool	2020-10-05 10:47:30.457	External tool added with id 20.	2020-10-05 10:47:30.457	\N
511d7105-da59-45ee-b48f-9b4b961871b0	OK	registerProvider	Auth	2020-10-05 10:51:56.305	builtin:Username/Email	2020-10-05 10:51:56.301	\N
5aacc91f-7cc6-4bfb-8037-8e91d2dfa8c5	OK	login	SessionManagement	2020-10-05 10:52:31.698	\N	2020-10-05 10:52:31.698	@dataverseAdmin
665912b8-64ef-440d-af0b-a1fe23559900	OK	edu.harvard.iq.dataverse.engine.command.impl.CreateDataverseCommand	Command	2020-10-05 13:16:27.685	:[1 Root] 	2020-10-05 13:16:27.212	@dataverseAdmin
4dd50e30-5326-4d33-9f2c-0fc71aa4abe2	OK	edu.harvard.iq.dataverse.engine.command.impl.GetPrivateUrlCommand	Command	2020-10-05 13:16:34.846	:[null ] 	2020-10-05 13:16:34.846	@dataverseAdmin
3bec2df9-a183-45ae-bc24-b164bd56b7ae	OK	edu.harvard.iq.dataverse.engine.command.impl.CreateNewDatasetCommand	Command	2020-10-05 13:22:44.059	:[null PSD Processing TEST FILES - NOT FOR SCIENTIFIC USE] 	2020-10-05 13:22:43.56	@dataverseAdmin
df019c13-5c61-4e6c-a71f-d5d1d3ca41e8	OK	edu.harvard.iq.dataverse.engine.command.impl.UpdateDatasetVersionCommand	Command	2020-10-05 13:22:44.847	:[3 PSD Processing TEST FILES - NOT FOR SCIENTIFIC USE] 	2020-10-05 13:22:44.266	@dataverseAdmin
a3132dd8-898a-4c51-9133-88589373eb02	OK	edu.harvard.iq.dataverse.engine.command.impl.GetPrivateUrlCommand	Command	2020-10-05 13:22:45.011	:[3 PSD Processing TEST FILES - NOT FOR SCIENTIFIC USE] 	2020-10-05 13:22:45.002	@dataverseAdmin
1a7e423d-6e12-4feb-bc79-8691ba78ba7c	OK	edu.harvard.iq.dataverse.engine.command.impl.GetPrivateUrlCommand	Command	2020-10-05 13:31:21.37	:[null ] 	2020-10-05 13:31:21.37	@dataverseAdmin
01f45568-0156-4e41-98a7-dd3331c0638c	OK	edu.harvard.iq.dataverse.engine.command.impl.CreateNewDatasetCommand	Command	2020-10-05 13:37:54.774	:[null TESTING PURPOSES ONLY - Calculated pressure coefficient] 	2020-10-05 13:37:54.419	@dataverseAdmin
08a16d5d-94e1-4be1-9197-768f34131677	OK	edu.harvard.iq.dataverse.engine.command.impl.UpdateDatasetVersionCommand	Command	2020-10-05 13:37:55.361	:[5 TESTING PURPOSES ONLY - Calculated pressure coefficient] 	2020-10-05 13:37:54.831	@dataverseAdmin
a8ff7336-2035-4178-a7fc-8c32ce8ea0ac	OK	edu.harvard.iq.dataverse.engine.command.impl.GetPrivateUrlCommand	Command	2020-10-05 13:37:55.74	:[5 TESTING PURPOSES ONLY - Calculated pressure coefficient] 	2020-10-05 13:37:55.731	@dataverseAdmin
4b735add-a168-43fe-a7f6-ddc8e039ab33	OK	edu.harvard.iq.dataverse.engine.command.impl.GetPrivateUrlCommand	Command	2020-10-05 13:40:15.599	:[5 TESTING PURPOSES ONLY - Calculated pressure coefficient] 	2020-10-05 13:40:15.59	@dataverseAdmin
\.


--
-- Data for Name: alternativepersistentidentifier; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.alternativepersistentidentifier (id, authority, globalidcreatetime, identifier, identifierregistered, protocol, storagelocationdesignator, dvobject_id) FROM stdin;
\.


--
-- Data for Name: apitoken; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.apitoken (id, createtime, disabled, expiretime, tokenstring, authenticateduser_id) FROM stdin;
1	2020-10-05 10:46:13.597	f	2021-10-05 10:46:13.597	e0967c6e-4679-4c4b-b74f-4e165bd6866c	1
\.


--
-- Data for Name: authenticateduser; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.authenticateduser (id, affiliation, createdtime, email, emailconfirmed, firstname, lastapiusetime, lastlogintime, lastname, "position", superuser, useridentifier) FROM stdin;
1	Dataverse.org	2020-10-05 10:46:13.556	dataverse@mailinator.com	\N	Dataverse	2020-10-05 10:46:14.029	2020-10-05 10:52:31.662	Admin	Admin	t	dataverseAdmin
\.


--
-- Data for Name: authenticateduserlookup; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.authenticateduserlookup (id, authenticationproviderid, persistentuserid, authenticateduser_id) FROM stdin;
1	builtin	dataverseAdmin	1
\.


--
-- Data for Name: authenticationproviderrow; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.authenticationproviderrow (id, enabled, factoryalias, factorydata, subtitle, title) FROM stdin;
builtin	t	BuiltinAuthenticationProvider		Datavers' Internal Authentication provider	Dataverse Local
\.


--
-- Data for Name: builtinuser; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.builtinuser (id, encryptedpassword, passwordencryptionversion, username) FROM stdin;
1	$2a$10$4VqDxDPcfz3moUg2/1G5Z.djHJNt1XNdl095HpW1i6btBrhd7A4H6	1	dataverseAdmin
\.


--
-- Data for Name: categorymetadata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.categorymetadata (id, wfreq, category_id, variablemetadata_id) FROM stdin;
\.


--
-- Data for Name: clientharvestrun; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.clientharvestrun (id, deleteddatasetcount, faileddatasetcount, finishtime, harvestresult, harvesteddatasetcount, starttime, harvestingclient_id) FROM stdin;
\.


--
-- Data for Name: confirmemaildata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.confirmemaildata (id, created, expires, token, authenticateduser_id) FROM stdin;
1	2020-10-05 10:46:13.58	2020-10-06 10:46:13.58	86264ef2-7176-4226-96d0-e4d9cfe629dc	1
\.


--
-- Data for Name: controlledvocabalternate; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.controlledvocabalternate (id, strvalue, controlledvocabularyvalue_id, datasetfieldtype_id) FROM stdin;
1	BOTSWANA	272	80
2	Brasil	274	80
3	Gambia, The	323	80
4	Germany (Federal Republic of)	325	80
5	GHANA	326	80
6	INDIA	345	80
7	Sumatra	346	80
8	Iran	347	80
9	Iran (Islamic Republic of)	347	80
10	IRAQ	348	80
11	Laos	364	80
12	LESOTHO	367	80
13	MOZAMBIQUE	394	80
14	NAMIBIA	396	80
15	SWAZILAND	456	80
16	Taiwan	460	80
17	Tanzania	462	80
18	UAE	476	80
19	USA	478	80
20	U.S.A	478	80
21	United States of America	478	80
22	U.S.A.	478	80
23	YEMEN	489	80
\.


--
-- Data for Name: controlledvocabularyvalue; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.controlledvocabularyvalue (id, displayorder, identifier, strvalue, datasetfieldtype_id) FROM stdin;
1	0	\N	N/A	\N
2	0	D01	Agricultural Sciences	20
3	1	D0	Arts and Humanities	20
4	2	D1	Astronomy and Astrophysics	20
5	3	D2	Business and Management	20
6	4	D3	Chemistry	20
7	5	D7	Computer and Information Science	20
8	6	D4	Earth and Environmental Sciences	20
9	7	D5	Engineering	20
10	8	D8	Law	20
11	9	D9	Mathematical Sciences	20
12	10	D6	Medicine, Health and Life Sciences	20
13	11	D10	Physics	20
14	12	D11	Social Sciences	20
15	13	D12	Other	20
16	0		ark	31
17	1		arXiv	31
18	2		bibcode	31
19	3		doi	31
20	4		ean13	31
21	5		eissn	31
22	6		handle	31
23	7		isbn	31
24	8		issn	31
25	9		istc	31
26	10		lissn	31
27	11		lsid	31
28	12		pmid	31
29	13		purl	31
30	14		upc	31
31	15		url	31
32	16		urn	31
33	0		Data Collector	45
34	1		Data Curator	45
35	2		Data Manager	45
36	3		Editor	45
37	4		Funder	45
38	5		Hosting Institution	45
39	6		Project Leader	45
40	7		Project Manager	45
41	8		Project Member	45
42	9		Related Person	45
43	10		Researcher	45
44	11		Research Group	45
45	12		Rights Holder	45
46	13		Sponsor	45
47	14		Supervisor	45
48	15		Work Package Leader	45
49	16		Other	45
50	0		ORCID	11
51	1		ISNI	11
52	2		LCNA	11
53	3		VIAF	11
54	4		GND	11
55	5		DAI	11
56	6		ResearcherID	11
57	7		ScopusID	11
58	0		Abkhaz	35
59	1		Afar	35
60	2		Afrikaans	35
61	3		Akan	35
62	4		Albanian	35
63	5		Amharic	35
64	6		Arabic	35
65	7		Aragonese	35
66	8		Armenian	35
67	9		Assamese	35
68	10		Avaric	35
69	11		Avestan	35
70	12		Aymara	35
71	13		Azerbaijani	35
72	14		Bambara	35
73	15		Bashkir	35
74	16		Basque	35
75	17		Belarusian	35
76	18		Bengali, Bangla	35
77	19		Bihari	35
78	20		Bislama	35
79	21		Bosnian	35
80	22		Breton	35
81	23		Bulgarian	35
82	24		Burmese	35
83	25		Catalan,Valencian	35
84	26		Chamorro	35
85	27		Chechen	35
86	28		Chichewa, Chewa, Nyanja	35
87	29		Chinese	35
88	30		Chuvash	35
89	31		Cornish	35
90	32		Corsican	35
91	33		Cree	35
92	34		Croatian	35
93	35		Czech	35
94	36		Danish	35
95	37		Divehi, Dhivehi, Maldivian	35
96	38		Dutch	35
97	39		Dzongkha	35
98	40		English	35
99	41		Esperanto	35
100	42		Estonian	35
101	43		Ewe	35
102	44		Faroese	35
103	45		Fijian	35
104	46		Finnish	35
105	47		French	35
106	48		Fula, Fulah, Pulaar, Pular	35
107	49		Galician	35
108	50		Georgian	35
109	51		German	35
110	52		Greek (modern)	35
111	53		Guaran��	35
112	54		Gujarati	35
113	55		Haitian, Haitian Creole	35
114	56		Hausa	35
115	57		Hebrew (modern)	35
116	58		Herero	35
117	59		Hindi	35
118	60		Hiri Motu	35
119	61		Hungarian	35
120	62		Interlingua	35
121	63		Indonesian	35
122	64		Interlingue	35
123	65		Irish	35
124	66		Igbo	35
125	67		Inupiaq	35
126	68		Ido	35
127	69		Icelandic	35
128	70		Italian	35
129	71		Inuktitut	35
130	72		Japanese	35
131	73		Javanese	35
132	74		Kalaallisut, Greenlandic	35
133	75		Kannada	35
134	76		Kanuri	35
135	77		Kashmiri	35
136	78		Kazakh	35
137	79		Khmer	35
138	80		Kikuyu, Gikuyu	35
139	81		Kinyarwanda	35
140	82		Kyrgyz	35
141	83		Komi	35
142	84		Kongo	35
143	85		Korean	35
144	86		Kurdish	35
145	87		Kwanyama, Kuanyama	35
146	88		Latin	35
147	89		Luxembourgish, Letzeburgesch	35
148	90		Ganda	35
149	91		Limburgish, Limburgan, Limburger	35
150	92		Lingala	35
151	93		Lao	35
152	94		Lithuanian	35
153	95		Luba-Katanga	35
154	96		Latvian	35
155	97		Manx	35
156	98		Macedonian	35
157	99		Malagasy	35
158	100		Malay	35
159	101		Malayalam	35
160	102		Maltese	35
161	103		M��ori	35
162	104		Marathi (Mar�����h��)	35
163	105		Marshallese	35
164	106		Mixtepec Mixtec	35
165	107		Mongolian	35
166	108		Nauru	35
167	109		Navajo, Navaho	35
168	110		Northern Ndebele	35
169	111		Nepali	35
170	112		Ndonga	35
171	113		Norwegian Bokm��l	35
172	114		Norwegian Nynorsk	35
173	115		Norwegian	35
174	116		Nuosu	35
175	117		Southern Ndebele	35
176	118		Occitan	35
177	119		Ojibwe, Ojibwa	35
178	120		Old Church Slavonic,Church Slavonic,Old Bulgarian	35
179	121		Oromo	35
180	122		Oriya	35
181	123		Ossetian, Ossetic	35
182	124		Panjabi, Punjabi	35
183	125		P��li	35
184	126		Persian (Farsi)	35
185	127		Polish	35
186	128		Pashto, Pushto	35
187	129		Portuguese	35
188	130		Quechua	35
189	131		Romansh	35
190	132		Kirundi	35
191	133		Romanian	35
192	134		Russian	35
193	135		Sanskrit (Sa���sk���ta)	35
194	136		Sardinian	35
195	137		Sindhi	35
196	138		Northern Sami	35
197	139		Samoan	35
198	140		Sango	35
199	141		Serbian	35
200	142		Scottish Gaelic, Gaelic	35
201	143		Shona	35
202	144		Sinhala, Sinhalese	35
203	145		Slovak	35
204	146		Slovene	35
205	147		Somali	35
206	148		Southern Sotho	35
207	149		Spanish, Castilian	35
208	150		Sundanese	35
209	151		Swahili	35
210	152		Swati	35
211	153		Swedish	35
212	154		Tamil	35
213	155		Telugu	35
214	156		Tajik	35
215	157		Thai	35
216	158		Tigrinya	35
217	159		Tibetan Standard, Tibetan, Central	35
218	160		Turkmen	35
219	161		Tagalog	35
220	162		Tswana	35
221	163		Tonga (Tonga Islands)	35
222	164		Turkish	35
223	165		Tsonga	35
224	166		Tatar	35
225	167		Twi	35
226	168		Tahitian	35
227	169		Uyghur, Uighur	35
228	170		Ukrainian	35
229	171		Urdu	35
230	172		Uzbek	35
231	173		Venda	35
232	174		Vietnamese	35
233	175		Volap��k	35
234	176		Walloon	35
235	177		Welsh	35
236	178		Wolof	35
237	179		Western Frisian	35
238	180		Xhosa	35
239	181		Yiddish	35
240	182		Yoruba	35
241	183		Zhuang, Chuang	35
242	184		Zulu	35
243	185		Not applicable	35
244	0		Afghanistan	80
245	1		Albania	80
246	2		Algeria	80
247	3		American Samoa	80
248	4		Andorra	80
249	5		Angola	80
250	6		Anguilla	80
251	7		Antarctica	80
252	8		Antigua and Barbuda	80
253	9		Argentina	80
254	10		Armenia	80
255	11		Aruba	80
256	12		Australia	80
257	13		Austria	80
258	14		Azerbaijan	80
259	15		Bahamas	80
260	16		Bahrain	80
261	17		Bangladesh	80
262	18		Barbados	80
263	19		Belarus	80
264	20		Belgium	80
265	21		Belize	80
266	22		Benin	80
267	23		Bermuda	80
268	24		Bhutan	80
269	25		Bolivia, Plurinational State of	80
270	26		Bonaire, Sint Eustatius and Saba	80
271	27		Bosnia and Herzegovina	80
272	28		Botswana	80
273	29		Bouvet Island	80
274	30		Brazil	80
275	31		British Indian Ocean Territory	80
276	32		Brunei Darussalam	80
277	33		Bulgaria	80
278	34		Burkina Faso	80
279	35		Burundi	80
280	36		Cambodia	80
281	37		Cameroon	80
282	38		Canada	80
283	39		Cape Verde	80
284	40		Cayman Islands	80
285	41		Central African Republic	80
286	42		Chad	80
287	43		Chile	80
288	44		China	80
289	45		Christmas Island	80
290	46		Cocos (Keeling) Islands	80
291	47		Colombia	80
292	48		Comoros	80
293	49		Congo	80
294	50		Congo, the Democratic Republic of the	80
295	51		Cook Islands	80
296	52		Costa Rica	80
297	53		Croatia	80
298	54		Cuba	80
299	55		Cura��ao	80
300	56		Cyprus	80
301	57		Czech Republic	80
302	58		C��te d'Ivoire	80
303	59		Denmark	80
304	60		Djibouti	80
305	61		Dominica	80
306	62		Dominican Republic	80
307	63		Ecuador	80
308	64		Egypt	80
309	65		El Salvador	80
310	66		Equatorial Guinea	80
311	67		Eritrea	80
312	68		Estonia	80
313	69		Ethiopia	80
314	70		Falkland Islands (Malvinas)	80
315	71		Faroe Islands	80
316	72		Fiji	80
317	73		Finland	80
318	74		France	80
319	75		French Guiana	80
320	76		French Polynesia	80
321	77		French Southern Territories	80
322	78		Gabon	80
323	79		Gambia	80
324	80		Georgia	80
325	81		Germany	80
326	82		Ghana	80
327	83		Gibraltar	80
328	84		Greece	80
329	85		Greenland	80
330	86		Grenada	80
331	87		Guadeloupe	80
332	88		Guam	80
333	89		Guatemala	80
334	90		Guernsey	80
335	91		Guinea	80
336	92		Guinea-Bissau	80
337	93		Guyana	80
338	94		Haiti	80
339	95		Heard Island and Mcdonald Islands	80
340	96		Holy See (Vatican City State)	80
341	97		Honduras	80
342	98		Hong Kong	80
343	99		Hungary	80
344	100		Iceland	80
345	101		India	80
346	102		Indonesia	80
347	103		Iran, Islamic Republic of	80
348	104		Iraq	80
349	105		Ireland	80
350	106		Isle of Man	80
351	107		Israel	80
352	108		Italy	80
353	109		Jamaica	80
354	110		Japan	80
355	111		Jersey	80
356	112		Jordan	80
357	113		Kazakhstan	80
358	114		Kenya	80
359	115		Kiribati	80
360	116		Korea, Democratic People's Republic of	80
361	117		Korea, Republic of	80
362	118		Kuwait	80
363	119		Kyrgyzstan	80
364	120		Lao People's Democratic Republic	80
365	121		Latvia	80
366	122		Lebanon	80
367	123		Lesotho	80
368	124		Liberia	80
369	125		Libya	80
370	126		Liechtenstein	80
371	127		Lithuania	80
372	128		Luxembourg	80
373	129		Macao	80
374	130		Macedonia, the Former Yugoslav Republic of	80
375	131		Madagascar	80
376	132		Malawi	80
377	133		Malaysia	80
378	134		Maldives	80
379	135		Mali	80
380	136		Malta	80
381	137		Marshall Islands	80
382	138		Martinique	80
383	139		Mauritania	80
384	140		Mauritius	80
385	141		Mayotte	80
386	142		Mexico	80
387	143		Micronesia, Federated States of	80
388	144		Moldova, Republic of	80
389	145		Monaco	80
390	146		Mongolia	80
391	147		Montenegro	80
392	148		Montserrat	80
393	149		Morocco	80
394	150		Mozambique	80
395	151		Myanmar	80
396	152		Namibia	80
397	153		Nauru	80
398	154		Nepal	80
399	155		Netherlands	80
400	156		New Caledonia	80
401	157		New Zealand	80
402	158		Nicaragua	80
403	159		Niger	80
404	160		Nigeria	80
405	161		Niue	80
406	162		Norfolk Island	80
407	163		Northern Mariana Islands	80
408	164		Norway	80
409	165		Oman	80
410	166		Pakistan	80
411	167		Palau	80
412	168		Palestine, State of	80
413	169		Panama	80
414	170		Papua New Guinea	80
415	171		Paraguay	80
416	172		Peru	80
417	173		Philippines	80
418	174		Pitcairn	80
419	175		Poland	80
420	176		Portugal	80
421	177		Puerto Rico	80
422	178		Qatar	80
423	179		Romania	80
424	180		Russian Federation	80
425	181		Rwanda	80
426	182		R��union	80
427	183		Saint Barth��lemy	80
428	184		Saint Helena, Ascension and Tristan da Cunha	80
429	185		Saint Kitts and Nevis	80
430	186		Saint Lucia	80
431	187		Saint Martin (French part)	80
432	188		Saint Pierre and Miquelon	80
433	189		Saint Vincent and the Grenadines	80
434	190		Samoa	80
435	191		San Marino	80
436	192		Sao Tome and Principe	80
437	193		Saudi Arabia	80
438	194		Senegal	80
439	195		Serbia	80
440	196		Seychelles	80
441	197		Sierra Leone	80
442	198		Singapore	80
443	199		Sint Maarten (Dutch part)	80
444	200		Slovakia	80
445	201		Slovenia	80
446	202		Solomon Islands	80
447	203		Somalia	80
448	204		South Africa	80
449	205		South Georgia and the South Sandwich Islands	80
450	206		South Sudan	80
451	207		Spain	80
452	208		Sri Lanka	80
453	209		Sudan	80
454	210		Suriname	80
455	211		Svalbard and Jan Mayen	80
456	212		Swaziland	80
457	213		Sweden	80
458	214		Switzerland	80
459	215		Syrian Arab Republic	80
460	216		Taiwan, Province of China	80
461	217		Tajikistan	80
462	218		Tanzania, United Republic of	80
463	219		Thailand	80
464	220		Timor-Leste	80
465	221		Togo	80
466	222		Tokelau	80
467	223		Tonga	80
468	224		Trinidad and Tobago	80
469	225		Tunisia	80
470	226		Turkey	80
471	227		Turkmenistan	80
472	228		Turks and Caicos Islands	80
473	229		Tuvalu	80
474	230		Uganda	80
475	231		Ukraine	80
476	232		United Arab Emirates	80
477	233		United Kingdom	80
478	234		United States	80
479	235		United States Minor Outlying Islands	80
480	236		Uruguay	80
481	237		Uzbekistan	80
482	238		Vanuatu	80
483	239		Venezuela, Bolivarian Republic of	80
484	240		Viet Nam	80
485	241		Virgin Islands, British	80
486	242		Virgin Islands, U.S.	80
487	243		Wallis and Futuna	80
488	244		Western Sahara	80
489	245		Yemen	80
490	246		Zambia	80
491	247		Zimbabwe	80
492	248		��land Islands	80
493	0		Image	116
494	1		Mosaic	116
495	2		EventList	116
496	3		Spectrum	116
497	4		Cube	116
498	5		Table	116
499	6		Catalog	116
500	7		LightCurve	116
501	8		Simulation	116
502	9		Figure	116
503	10		Artwork	116
504	11		Animation	116
505	12		PrettyPicture	116
506	13		Documentation	116
507	14		Other	116
508	15		Library	116
509	16		Press Release	116
510	17		Facsimile	116
511	18		Historical	116
512	19		Observation	116
513	20		Object	116
514	21		Value	116
515	22		ValuePair	116
516	23		Survey	116
517	0	EFO_0001427	Case Control	142
518	1	EFO_0001428	Cross Sectional	142
519	2	OCRE100078	Cohort Study	142
520	3	NCI_C48202	Nested Case Control Design	142
521	4	OTHER_DESIGN	Not Specified	142
522	5	OBI_0500006	Parallel Group Design	142
523	6	OBI_0001033	Perturbation Design	142
524	7	MESH_D016449	Randomized Controlled Trial	142
525	8	TECH_DESIGN	Technological Design	142
526	0	EFO_0000246	Age	143
527	1	BIOMARKERS	Biomarkers	143
528	2	CELL_SURFACE_M	Cell Surface Markers	143
529	3	EFO_0000324;EFO_0000322	Cell Type/Cell Line	143
530	4	EFO_0000399	Developmental Stage	143
531	5	OBI_0001293	Disease State	143
532	6	IDO_0000469	Drug Susceptibility	143
533	7	FBcv_0010001	Extract Molecule	143
534	8	OBI_0001404	Genetic Characteristics	143
535	9	OBI_0000690	Immunoprecipitation Antibody	143
536	10	OBI_0100026	Organism	143
537	11	OTHER_FACTOR	Other	143
538	12	PASSAGES_FACTOR	Passages	143
539	13	OBI_0000050	Platform	143
540	14	EFO_0000695	Sex	143
541	15	EFO_0005135	Strain	143
542	16	EFO_0000724	Time Point	143
543	17	BTO_0001384	Tissue Type	143
544	18	EFO_0000369	Treatment Compound	143
545	19	EFO_0000727	Treatment Type	143
546	0	ERO_0001899	cell counting	146
547	1	CHMO_0001085	cell sorting	146
548	2	OBI_0000520	clinical chemistry analysis	146
549	3	OBI_0000537	copy number variation profiling	146
550	4	OBI_0000634	DNA methylation profiling	146
551	5	OBI_0000748	DNA methylation profiling (Bisulfite-Seq)	146
552	6	_OBI_0000634	DNA methylation profiling (MeDIP-Seq)	146
553	7	_IDO_0000469	drug susceptibility	146
554	8	ENV_GENE_SURVEY	environmental gene survey	146
555	9	ERO_0001183	genome sequencing	146
556	10	OBI_0000630	hematology	146
557	11	OBI_0600020	histology	146
558	12	OBI_0002017	Histone Modification (ChIP-Seq)	146
559	13	SO_0001786	loss of heterozygosity profiling	146
560	14	OBI_0000366	metabolite profiling	146
561	15	METAGENOME_SEQ	metagenome sequencing	146
562	16	OBI_0000615	protein expression profiling	146
563	17	ERO_0000346	protein identification	146
564	18	PROTEIN_DNA_BINDING	protein-DNA binding site identification	146
565	19	OBI_0000288	protein-protein interaction detection	146
566	20	PROTEIN_RNA_BINDING	protein-RNA binding (RIP-Seq)	146
567	21	OBI_0000435	SNP analysis	146
568	22	TARGETED_SEQ	targeted sequencing	146
569	23	OBI_0002018	transcription factor binding (ChIP-Seq)	146
570	24	OBI_0000291	transcription factor binding site identification	146
571	26	EFO_0001032	transcription profiling	146
572	27	TRANSCRIPTION_PROF	transcription profiling (Microarray)	146
573	28	OBI_0001271	transcription profiling (RNA-Seq)	146
574	29	TRAP_TRANS_PROF	TRAP translational profiling	146
575	30	OTHER_MEASUREMENT	Other	146
576	0	NCBITaxon_3702	Arabidopsis thaliana	144
577	1	NCBITaxon_9913	Bos taurus	144
578	2	NCBITaxon_6239	Caenorhabditis elegans	144
579	3	NCBITaxon_3055	Chlamydomonas reinhardtii	144
580	4	NCBITaxon_7955	Danio rerio (zebrafish)	144
581	5	NCBITaxon_44689	Dictyostelium discoideum	144
582	6	NCBITaxon_7227	Drosophila melanogaster	144
583	7	NCBITaxon_562	Escherichia coli	144
584	8	NCBITaxon_11103	Hepatitis C virus	144
585	9	NCBITaxon_9606	Homo sapiens	144
586	10	NCBITaxon_10090	Mus musculus	144
587	11	NCBITaxon_33894	Mycobacterium africanum	144
588	12	NCBITaxon_78331	Mycobacterium canetti	144
589	13	NCBITaxon_1773	Mycobacterium tuberculosis	144
590	14	NCBITaxon_2104	Mycoplasma pneumoniae	144
591	15	NCBITaxon_4530	Oryza sativa	144
592	16	NCBITaxon_5833	Plasmodium falciparum	144
593	17	NCBITaxon_4754	Pneumocystis carinii	144
594	18	NCBITaxon_10116	Rattus norvegicus	144
595	19	NCBITaxon_4932	Saccharomyces cerevisiae (brewer's yeast)	144
596	20	NCBITaxon_4896	Schizosaccharomyces pombe	144
597	21	NCBITaxon_31033	Takifugu rubripes	144
598	22	NCBITaxon_8355	Xenopus laevis	144
599	23	NCBITaxon_4577	Zea mays	144
600	24	OTHER_TAXONOMY	Other	144
601	0	CULTURE_DRUG_TEST_SINGLE	culture based drug susceptibility testing, single concentration	148
602	1	CULTURE_DRUG_TEST_TWO	culture based drug susceptibility testing, two concentrations	148
603	2	CULTURE_DRUG_TEST_THREE	culture based drug susceptibility testing, three or more concentrations (minimium inhibitory concentration measurement)	148
604	3	OBI_0400148	DNA microarray	148
605	4	OBI_0000916	flow cytometry	148
606	5	OBI_0600053	gel electrophoresis	148
607	6	OBI_0000470	mass spectrometry	148
608	7	OBI_0000623	NMR spectroscopy	148
609	8	OBI_0000626	nucleotide sequencing	148
610	9	OBI_0400149	protein microarray	148
611	10	OBI_0000893	real time PCR	148
612	11	NO_TECHNOLOGY	no technology required	148
613	12	OTHER_TECHNOLOGY	Other	148
614	0	210_MS_GC	210-MS GC Ion Trap (Varian)	149
615	1	220_MS_GC	220-MS GC Ion Trap (Varian)	149
616	2	225_MS_GC	225-MS GC Ion Trap (Varian)	149
617	3	240_MS_GC	240-MS GC Ion Trap (Varian)	149
618	4	300_MS_GCMS	300-MS quadrupole GC/MS (Varian)	149
619	5	320_MS_LCMS	320-MS LC/MS (Varian)	149
620	6	325_MS_LCMS	325-MS LC/MS (Varian)	149
621	7	500_MS_GCMS	320-MS GC/MS (Varian)	149
622	8	500_MS_LCMS	500-MS LC/MS (Varian)	149
623	9	800D	800D (Jeol)	149
624	10	910_MS_TQFT	910-MS TQ-FT (Varian)	149
625	11	920_MS_TQFT	920-MS TQ-FT (Varian)	149
626	12	3100_MASS_D	3100 Mass Detector (Waters)	149
627	13	6110_QUAD_LCMS	6110 Quadrupole LC/MS (Agilent)	149
628	14	6120_QUAD_LCMS	6120 Quadrupole LC/MS (Agilent)	149
629	15	6130_QUAD_LCMS	6130 Quadrupole LC/MS (Agilent)	149
630	16	6140_QUAD_LCMS	6140 Quadrupole LC/MS (Agilent)	149
631	17	6310_ION_LCMS	6310 Ion Trap LC/MS (Agilent)	149
632	18	6320_ION_LCMS	6320 Ion Trap LC/MS (Agilent)	149
633	19	6330_ION_LCMS	6330 Ion Trap LC/MS (Agilent)	149
634	20	6340_ION_LCMS	6340 Ion Trap LC/MS (Agilent)	149
635	21	6410_TRIPLE_LCMS	6410 Triple Quadrupole LC/MS (Agilent)	149
636	22	6430_TRIPLE_LCMS	6430 Triple Quadrupole LC/MS (Agilent)	149
637	23	6460_TRIPLE_LCMS	6460 Triple Quadrupole LC/MS (Agilent)	149
638	24	6490_TRIPLE_LCMS	6490 Triple Quadrupole LC/MS (Agilent)	149
639	25	6530_Q_TOF_LCMS	6530 Q-TOF LC/MS (Agilent)	149
640	26	6540_Q_TOF_LCMS	6540 Q-TOF LC/MS (Agilent)	149
641	27	6210_Q_TOF_LCMS	6210 TOF LC/MS (Agilent)	149
642	28	6220_Q_TOF_LCMS	6220 TOF LC/MS (Agilent)	149
643	29	6230_Q_TOF_LCMS	6230 TOF LC/MS (Agilent)	149
644	30	700B_TRIPLE_GCMS	7000B Triple Quadrupole GC/MS (Agilent)	149
645	31	ACCUTO_DART	AccuTO DART (Jeol)	149
646	32	ACCUTOF_GC	AccuTOF GC (Jeol)	149
647	33	ACCUTOF_LC	AccuTOF LC (Jeol)	149
648	34	ACQUITY_SQD	ACQUITY SQD (Waters)	149
649	35	ACQUITY_TQD	ACQUITY TQD (Waters)	149
650	36	AGILENT	Agilent	149
651	37	AGILENT_ 5975E_GCMSD	Agilent 5975E GC/MSD (Agilent)	149
652	38	AGILENT_5975T_LTM_GCMSD	Agilent 5975T LTM GC/MSD (Agilent)	149
653	39	5975C_GCMSD	5975C Series GC/MSD (Agilent)	149
654	40	AFFYMETRIX	Affymetrix	149
655	41	AMAZON_ETD_ESI	amaZon ETD ESI Ion Trap (Bruker)	149
656	42	AMAZON_X_ESI	amaZon X ESI Ion Trap (Bruker)	149
657	43	APEX_ULTRA_QQ_FTMS	apex-ultra hybrid Qq-FTMS (Bruker)	149
658	44	API_2000	API 2000 (AB Sciex)	149
659	45	API_3200	API 3200 (AB Sciex)	149
660	46	API_3200_QTRAP	API 3200 QTRAP (AB Sciex)	149
661	47	API_4000	API 4000 (AB Sciex)	149
662	48	API_4000_QTRAP	API 4000 QTRAP (AB Sciex)	149
663	49	API_5000	API 5000 (AB Sciex)	149
664	50	API_5500	API 5500 (AB Sciex)	149
665	51	API_5500_QTRAP	API 5500 QTRAP (AB Sciex)	149
666	52	APPLIED_BIOSYSTEMS	Applied Biosystems Group (ABI)	149
667	53	AQI_BIOSCIENCES	AQI Biosciences	149
668	54	ATMOS_GC	Atmospheric Pressure GC (Waters)	149
669	55	AUTOFLEX_III_MALDI_TOF_MS	autoflex III MALDI-TOF MS (Bruker)	149
670	56	AUTOFLEX_SPEED	autoflex speed(Bruker)	149
671	57	AUTOSPEC_PREMIER	AutoSpec Premier (Waters)	149
672	58	AXIMA_MEGA_TOF	AXIMA Mega TOF (Shimadzu)	149
673	59	AXIMA_PERF_MALDI_TOF	AXIMA Performance MALDI TOF/TOF (Shimadzu)	149
674	60	A_10_ANALYZER	A-10 Analyzer (Apogee)	149
675	61	A_40_MINIFCM	A-40-MiniFCM (Apogee)	149
676	62	BACTIFLOW	Bactiflow (Chemunex SA)	149
677	63	BASE4INNOVATION	Base4innovation	149
678	64	BD_BACTEC_MGIT_320	BD BACTEC MGIT 320	149
679	65	BD_BACTEC_MGIT_960	BD BACTEC MGIT 960	149
680	66	BD_RADIO_BACTEC_460TB	BD Radiometric BACTEC 460TB	149
681	67	BIONANOMATRIX	BioNanomatrix	149
682	68	CELL_LAB_QUANTA_SC	Cell Lab Quanta SC (Becman Coulter)	149
683	69	CLARUS_560_D_GCMS	Clarus 560 D GC/MS (PerkinElmer)	149
684	70	CLARUS_560_S_GCMS	Clarus 560 S GC/MS (PerkinElmer)	149
685	71	CLARUS_600_GCMS	Clarus 600 GC/MS (PerkinElmer)	149
686	72	COMPLETE_GENOMICS	Complete Genomics	149
687	73	CYAN	Cyan (Dako Cytomation)	149
688	74	CYFLOW_ML	CyFlow ML (Partec)	149
689	75	CYFLOW_SL	Cyow SL (Partec)	149
690	76	CYFLOW_SL3	CyFlow SL3 (Partec)	149
691	77	CYTOBUOY	CytoBuoy (Cyto Buoy Inc)	149
692	78	CYTOSENCE	CytoSence (Cyto Buoy Inc)	149
693	79	CYTOSUB	CytoSub (Cyto Buoy Inc)	149
694	80	DANAHER	Danaher	149
695	81	DFS	DFS (Thermo Scientific)	149
696	82	EXACTIVE	Exactive(Thermo Scientific)	149
697	83	FACS_CANTO	FACS Canto (Becton Dickinson)	149
698	84	FACS_CANTO2	FACS Canto2 (Becton Dickinson)	149
699	85	FACS_SCAN	FACS Scan (Becton Dickinson)	149
700	86	FC_500	FC 500 (Becman Coulter)	149
701	87	GCMATE_II	GCmate II GC/MS (Jeol)	149
702	88	GCMS_QP2010_PLUS	GCMS-QP2010 Plus (Shimadzu)	149
703	89	GCMS_QP2010S_PLUS	GCMS-QP2010S Plus (Shimadzu)	149
704	90	GCT_PREMIER	GCT Premier (Waters)	149
705	91	GENEQ	GENEQ	149
706	92	GENOME_CORP	Genome Corp.	149
707	93	GENOVOXX	GenoVoxx	149
708	94	GNUBIO	GnuBio	149
709	95	GUAVA_EASYCYTE_MINI	Guava EasyCyte Mini (Millipore)	149
710	96	GUAVA_EASYCYTE_PLUS	Guava EasyCyte Plus (Millipore)	149
711	97	GUAVA_PERSONAL_CELL	Guava Personal Cell Analysis (Millipore)	149
712	98	GUAVA_PERSONAL_CELL_96	Guava Personal Cell Analysis-96 (Millipore)	149
713	99	HELICOS_BIO	Helicos BioSciences	149
714	100	ILLUMINA	Illumina	149
715	101	INDIRECT_LJ_MEDIUM	Indirect proportion method on LJ medium	149
716	102	INDIRECT_AGAR_7H9	Indirect proportion method on Middlebrook Agar 7H9	149
717	103	INDIRECT_AGAR_7H10	Indirect proportion method on Middlebrook Agar 7H10	149
718	104	INDIRECT_AGAR_7H11	Indirect proportion method on Middlebrook Agar 7H11	149
719	105	INFLUX_ANALYZER	inFlux Analyzer (Cytopeia)	149
720	106	INTELLIGENT_BIOSYSTEMS	Intelligent Bio-Systems	149
721	107	ITQ_700	ITQ 700 (Thermo Scientific)	149
722	108	ITQ_900	ITQ 900 (Thermo Scientific)	149
723	109	ITQ_1100	ITQ 1100 (Thermo Scientific)	149
824	26		reprint	155
724	110	JMS_53000_SPIRAL	JMS-53000 SpiralTOF (Jeol)	149
725	111	LASERGEN	LaserGen	149
726	112	LCMS_2020	LCMS-2020 (Shimadzu)	149
727	113	LCMS_2010EV	LCMS-2010EV (Shimadzu)	149
728	114	LCMS_IT_TOF	LCMS-IT-TOF (Shimadzu)	149
729	115	LI_COR	Li-Cor	149
730	116	LIFE_TECH	Life Tech	149
731	117	LIGHTSPEED_GENOMICS	LightSpeed Genomics	149
732	118	LCT_PREMIER_XE	LCT Premier XE (Waters)	149
733	119	LCQ_DECA_XP_MAX	LCQ Deca XP MAX (Thermo Scientific)	149
734	120	LCQ_FLEET	LCQ Fleet (Thermo Scientific)	149
735	121	LXQ_THERMO	LXQ (Thermo Scientific)	149
736	122	LTQ_CLASSIC	LTQ Classic (Thermo Scientific)	149
737	123	LTQ_XL	LTQ XL (Thermo Scientific)	149
738	124	LTQ_VELOS	LTQ Velos (Thermo Scientific)	149
739	125	LTQ_ORBITRAP_CLASSIC	LTQ Orbitrap Classic (Thermo Scientific)	149
740	126	LTQ_ORBITRAP_XL	LTQ Orbitrap XL (Thermo Scientific)	149
741	127	LTQ_ORBITRAP_DISCOVERY	LTQ Orbitrap Discovery (Thermo Scientific)	149
742	128	LTQ_ORBITRAP_VELOS	LTQ Orbitrap Velos (Thermo Scientific)	149
743	129	LUMINEX_100	Luminex 100 (Luminex)	149
744	130	LUMINEX_200	Luminex 200 (Luminex)	149
745	131	MACS_QUANT	MACS Quant (Miltenyi)	149
746	132	MALDI_SYNAPT_G2_HDMS	MALDI SYNAPT G2 HDMS (Waters)	149
747	133	MALDI_SYNAPT_G2_MS	MALDI SYNAPT G2 MS (Waters)	149
748	134	MALDI_SYNAPT_HDMS	MALDI SYNAPT HDMS (Waters)	149
749	135	MALDI_SYNAPT_MS	MALDI SYNAPT MS (Waters)	149
750	136	MALDI_MICROMX	MALDI micro MX (Waters)	149
751	137	MAXIS	maXis (Bruker)	149
752	138	MAXISG4	maXis G4 (Bruker)	149
753	139	MICROFLEX_LT_MALDI_TOF_MS	microflex LT MALDI-TOF MS (Bruker)	149
754	140	MICROFLEX_LRF_MALDI_TOF_MS	microflex LRF MALDI-TOF MS (Bruker)	149
755	141	MICROFLEX_III_TOF_MS	microflex III MALDI-TOF MS (Bruker)	149
756	142	MICROTOF_II_ESI_TOF	micrOTOF II ESI TOF (Bruker)	149
757	143	MICROTOF_Q_II_ESI_QQ_TOF	micrOTOF-Q II ESI-Qq-TOF (Bruker)	149
758	144	MICROPLATE_ALAMAR_BLUE_COLORIMETRIC	microplate Alamar Blue (resazurin) colorimetric method	149
759	145	MSTATION	Mstation (Jeol)	149
760	146	MSQ_PLUS	MSQ Plus (Thermo Scientific)	149
761	147	NABSYS	NABsys	149
762	148	NANOPHOTONICS_BIOSCIENCES	Nanophotonics Biosciences	149
763	149	NETWORK_BIOSYSTEMS	Network Biosystems	149
764	150	NIMBLEGEN	Nimblegen	149
765	151	OXFORD_NANOPORE_TECHNOLOGIES	Oxford Nanopore Technologies	149
766	152	PACIFIC_BIOSCIENCES	Pacific Biosciences	149
767	153	POPULATION_GENETICS_TECHNOLOGIES	Population Genetics Technologies	149
768	154	Q1000GC_ULTRAQUAD	Q1000GC UltraQuad (Jeol)	149
769	155	QUATTRO_MICRO_API	Quattro micro API (Waters)	149
770	156	QUATTRO_MICRO_GC	Quattro micro GC (Waters)	149
771	157	QUATTRO_PREMIER_XE	Quattro Premier XE (Waters)	149
772	158	QSTAR	QSTAR (AB Sciex)	149
773	159	REVEO	Reveo	149
774	160	ROCHE	Roche	149
775	161	SEIRAD	Seirad	149
776	162	SOLARIX_HYBRID_QQ_FTMS	solariX hybrid Qq-FTMS (Bruker)	149
777	163	SOMACOUNT	Somacount (Bently Instruments)	149
778	164	SOMASCOPE	SomaScope (Bently Instruments)	149
779	165	SYNAPT_G2_HDMS	SYNAPT G2 HDMS (Waters)	149
780	166	SYNAPT_G2_MS	SYNAPT G2 MS (Waters)	149
781	167	SYNAPT_HDMS	SYNAPT HDMS (Waters)	149
782	168	SYNAPT_MS	SYNAPT MS (Waters)	149
783	169	TRIPLETOF_5600	TripleTOF 5600 (AB Sciex)	149
784	170	TSQ_QUANTUM_ULTRA	TSQ Quantum Ultra (Thermo Scientific)	149
785	171	TSQ_QUANTUM_ACCESS	TSQ Quantum Access (Thermo Scientific)	149
786	172	TSQ_QUANTUM_ACCESS_MAX	TSQ Quantum Access MAX (Thermo Scientific)	149
787	173	TSQ_QUANTUM_DISCOVERY_MAX	TSQ Quantum Discovery MAX (Thermo Scientific)	149
788	174	TSQ_QUANTUM_GC	TSQ Quantum GC (Thermo Scientific)	149
789	175	TSQ_QUANTUM_XLS	TSQ Quantum XLS (Thermo Scientific)	149
790	176	TSQ_VANTAGE	TSQ Vantage (Thermo Scientific)	149
791	177	ULTRAFLEXTREME_MALDI_TOF_MS	ultrafleXtreme MALDI-TOF MS (Bruker)	149
792	178	VISIGEN_BIO	VisiGen Biotechnologies	149
793	179	XEVO_G2_QTOF	Xevo G2 QTOF (Waters)	149
794	180	XEVO_QTOF_MS	Xevo QTof MS (Waters)	149
795	181	XEVO_TQ_MS	Xevo TQ MS (Waters)	149
796	182	XEVO_TQ_S	Xevo TQ-S (Waters)	149
797	183	OTHER_PLATFORM	Other	149
798	0		abstract	155
799	1		addendum	155
800	2		announcement	155
801	3		article-commentary	155
802	4		book review	155
803	5		books received	155
804	6		brief report	155
805	7		calendar	155
806	8		case report	155
807	9		collection	155
808	10		correction	155
809	11		data paper	155
810	12		discussion	155
811	13		dissertation	155
812	14		editorial	155
813	15		in brief	155
814	16		introduction	155
815	17		letter	155
816	18		meeting report	155
817	19		news	155
818	20		obituary	155
819	21		oration	155
820	22		partial retraction	155
821	23		product review	155
822	24		rapid communication	155
823	25		reply	155
825	27		research article	155
826	28		retraction	155
827	29		review article	155
828	30		translation	155
829	31		other	155
\.


--
-- Data for Name: customfieldmap; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.customfieldmap (id, sourcedatasetfield, sourcetemplate, targetdatasetfield) FROM stdin;
\.


--
-- Data for Name: customquestion; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.customquestion (id, displayorder, hidden, questionstring, questiontype, required, guestbook_id) FROM stdin;
\.


--
-- Data for Name: customquestionresponse; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.customquestionresponse (id, response, customquestion_id, guestbookresponse_id) FROM stdin;
\.


--
-- Data for Name: customquestionvalue; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.customquestionvalue (id, displayorder, valuestring, customquestion_id) FROM stdin;
\.


--
-- Data for Name: customzipservicerequest; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.customzipservicerequest (key, storagelocation, filename, issuetime) FROM stdin;
\.


--
-- Data for Name: datafile; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datafile (id, checksumtype, checksumvalue, contenttype, filesize, ingeststatus, previousdatafileid, prov_entityname, restricted, rootdatafileid) FROM stdin;
4	MD5	0656cacd1129e81c2f8b0c7185a6a40d	application/octet-stream	35062617	A	\N	\N	f	-1
6	MD5	91db354963db3f7262bc1fe6ba09918c	text/csv	1104	D	\N	\N	f	-1
8	MD5	a669fa6b366afab582ff63a1bbc687f8	text/csv	1109	D	\N	\N	f	-1
13	MD5	685d3a712c0ccbdf3b05c350daf63999	text/csv	1112	D	\N	\N	f	-1
7	MD5	6cbb82d561f83cdd8ce8bb62d29ca82a	text/csv	1115	D	\N	\N	f	-1
9	MD5	b90cc62f15e54e64f28e55d8d9e69051	text/csv	1150	D	\N	\N	f	-1
10	MD5	1fd8d912f5371a73bd463b586ff7c75a	text/csv	1151	D	\N	\N	f	-1
11	MD5	a6659aebaddfed219a9df73d183e3ad9	text/csv	1157	D	\N	\N	f	-1
12	MD5	3ce804adb71b851fe3927e3c6523eab8	text/csv	1163	D	\N	\N	f	-1
\.


--
-- Data for Name: datafilecategory; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datafilecategory (id, name, dataset_id) FROM stdin;
\.


--
-- Data for Name: datafiletag; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datafiletag (id, type, datafile_id) FROM stdin;
\.


--
-- Data for Name: dataset; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataset (id, fileaccessrequest, harvestidentifier, lastexporttime, usegenericthumbnail, citationdatedatasetfieldtype_id, harvestingclient_id, guestbook_id, thumbnailfile_id) FROM stdin;
3	f	\N	\N	f	\N	\N	\N	\N
5	f	\N	\N	f	\N	\N	\N	\N
\.


--
-- Data for Name: datasetexternalcitations; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetexternalcitations (id, citedbyurl, dataset_id) FROM stdin;
\.


--
-- Data for Name: datasetfield; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetfield (id, datasetfieldtype_id, datasetversion_id, parentdatasetfieldcompoundvalue_id, template_id) FROM stdin;
1	17	1	\N	\N
2	8	1	\N	\N
3	21	1	\N	\N
4	13	1	\N	\N
7	24	\N	3	\N
8	9	\N	2	\N
9	16	\N	4	\N
10	23	\N	3	\N
11	22	\N	3	\N
12	14	\N	4	\N
14	20	1	\N	\N
15	10	\N	2	\N
16	1	1	\N	\N
17	15	\N	4	\N
18	57	1	\N	\N
19	58	1	\N	\N
20	18	\N	1	\N
21	13	2	\N	\N
22	8	2	\N	\N
24	17	2	\N	\N
25	21	2	\N	\N
26	10	\N	7	\N
27	57	2	\N	\N
28	9	\N	7	\N
30	24	\N	10	\N
31	20	2	\N	\N
32	58	2	\N	\N
33	18	\N	9	\N
34	14	\N	6	\N
35	15	\N	6	\N
36	23	\N	10	\N
37	16	\N	6	\N
38	1	2	\N	\N
40	22	\N	10	\N
\.


--
-- Data for Name: datasetfield_controlledvocabularyvalue; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetfield_controlledvocabularyvalue (datasetfield_id, controlledvocabularyvalues_id) FROM stdin;
14	13
31	13
\.


--
-- Data for Name: datasetfieldcompoundvalue; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetfieldcompoundvalue (id, displayorder, parentdatasetfield_id) FROM stdin;
1	0	1
2	0	2
3	0	3
4	0	4
6	0	21
7	0	22
9	0	24
10	0	25
\.


--
-- Data for Name: datasetfielddefaultvalue; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetfielddefaultvalue (id, displayorder, strvalue, datasetfield_id, defaultvalueset_id, parentdatasetfielddefaultvalue_id) FROM stdin;
\.


--
-- Data for Name: datasetfieldtype; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetfieldtype (id, advancedsearchfieldtype, allowcontrolledvocabulary, allowmultiples, description, displayformat, displayoncreate, displayorder, facetable, fieldtype, name, required, title, uri, validationformat, watermark, metadatablock_id, parentdatasetfieldtype_id) FROM stdin;
1	t	f	f	Full title by which the Dataset is known.		t	0	f	TEXT	title	t	Title	http://purl.org/dc/terms/title	\N	Enter title...	1	\N
2	f	f	f	A secondary title used to amplify or state certain limitations on the main title.		f	1	f	TEXT	subtitle	f	Subtitle	\N	\N		1	\N
3	f	f	f	A title by which the work is commonly referred, or an abbreviation of the title.		f	2	f	TEXT	alternativeTitle	f	Alternative Title	http://purl.org/dc/terms/alternative	\N		1	\N
4	f	f	f	A URL where the dataset can be viewed, such as a personal or project website.  	<a href="#VALUE" target="_blank">#VALUE</a>	f	3	f	URL	alternativeURL	f	Alternative URL	https://schema.org/distribution	\N	Enter full URL, starting with http://	1	\N
5	f	f	t	Another unique identifier that identifies this Dataset (e.g., producer's or another repository's number).	:	f	4	f	NONE	otherId	f	Other ID	\N	\N		1	\N
6	f	f	f	Name of agency which generated this identifier.	#VALUE	f	5	f	TEXT	otherIdAgency	f	Agency	\N	\N		1	5
7	f	f	f	Other identifier that corresponds to this Dataset.	#VALUE	f	6	f	TEXT	otherIdValue	f	Identifier	\N	\N		1	5
8	f	f	t	The person(s), corporate body(ies), or agency(ies) responsible for creating the work.		t	7	f	NONE	author	f	Author	http://purl.org/dc/terms/creator	\N		1	\N
9	t	f	f	The author's Family Name, Given Name or the name of the organization responsible for this Dataset.	#VALUE	t	8	t	TEXT	authorName	t	Name	\N	\N	FamilyName, GivenName or Organization	1	8
10	t	f	f	The organization with which the author is affiliated.	(#VALUE)	t	9	t	TEXT	authorAffiliation	f	Affiliation	\N	\N		1	8
11	f	t	f	Name of the identifier scheme (ORCID, ISNI).	- #VALUE:	t	10	f	TEXT	authorIdentifierScheme	f	Identifier Scheme	http://purl.org/spar/datacite/AgentIdentifierScheme	\N		1	8
12	f	f	f	Uniquely identifies an individual author or organization, according to various schemes.	#VALUE	t	11	f	TEXT	authorIdentifier	f	Identifier	http://purl.org/spar/datacite/AgentIdentifier	\N		1	8
13	f	f	t	The contact(s) for this Dataset.		t	12	f	NONE	datasetContact	f	Contact	\N	\N		1	\N
14	f	f	f	The contact's Family Name, Given Name or the name of the organization.	#VALUE	t	13	f	TEXT	datasetContactName	f	Name	\N	\N	FamilyName, GivenName or Organization	1	13
15	f	f	f	The organization with which the contact is affiliated.	(#VALUE)	t	14	f	TEXT	datasetContactAffiliation	f	Affiliation	\N	\N		1	13
16	f	f	f	The e-mail address(es) of the contact(s) for the Dataset. This will not be displayed.	#EMAIL	t	15	f	EMAIL	datasetContactEmail	t	E-mail	\N	\N		1	13
17	f	f	t	A summary describing the purpose, nature, and scope of the Dataset.		t	16	f	NONE	dsDescription	f	Description	\N	\N		1	\N
18	t	f	f	A summary describing the purpose, nature, and scope of the Dataset.	#VALUE	t	17	f	TEXTBOX	dsDescriptionValue	t	Text	\N	\N		1	17
19	f	f	f	In cases where a Dataset contains more than one description (for example, one might be supplied by the data producer and another prepared by the data repository where the data are deposited), the date attribute is used to distinguish between the two descriptions. The date attribute follows the ISO convention of YYYY-MM-DD.	(#VALUE)	t	18	f	DATE	dsDescriptionDate	f	Date	\N	\N	YYYY-MM-DD	1	17
20	t	t	t	Domain-specific Subject Categories that are topically relevant to the Dataset.		t	19	t	TEXT	subject	t	Subject	http://purl.org/dc/terms/subject	\N		1	\N
21	f	f	t	Key terms that describe important aspects of the Dataset.		t	20	f	NONE	keyword	f	Keyword	\N	\N		1	\N
22	t	f	f	Key terms that describe important aspects of the Dataset. Can be used for building keyword indexes and for classification and retrieval purposes. A controlled vocabulary can be employed. The vocab attribute is provided for specification of the controlled vocabulary in use, such as LCSH, MeSH, or others. The vocabURI attribute specifies the location for the full controlled vocabulary.	#VALUE	t	21	t	TEXT	keywordValue	f	Term	\N	\N		1	21
23	f	f	f	For the specification of the keyword controlled vocabulary in use, such as LCSH, MeSH, or others.	(#VALUE)	t	22	f	TEXT	keywordVocabulary	f	Vocabulary	\N	\N		1	21
24	f	f	f	Keyword vocabulary URL points to the web presence that describes the keyword vocabulary, if appropriate. Enter an absolute URL where the keyword vocabulary web site is found, such as http://www.my.org.	<a href="#VALUE" target="_blank" rel="noopener">#VALUE</a>	t	23	f	URL	keywordVocabularyURI	f	Vocabulary URL	\N	\N	Enter full URL, starting with http://	1	21
25	f	f	t	The classification field indicates the broad important topic(s) and subjects that the data cover. Library of Congress subject terms may be used here.  		f	24	f	NONE	topicClassification	f	Topic Classification	\N	\N		1	\N
26	t	f	f	Topic or Subject term that is relevant to this Dataset.	#VALUE	f	25	t	TEXT	topicClassValue	f	Term	\N	\N		1	25
27	f	f	f	Provided for specification of the controlled vocabulary in use, e.g., LCSH, MeSH, etc.	(#VALUE)	f	26	f	TEXT	topicClassVocab	f	Vocabulary	\N	\N		1	25
28	f	f	f	Specifies the URL location for the full controlled vocabulary.	<a href="#VALUE" target="_blank" rel="noopener">#VALUE</a>	f	27	f	URL	topicClassVocabURI	f	Vocabulary URL	\N	\N	Enter full URL, starting with http://	1	25
29	f	f	t	Publications that use the data from this Dataset. The full list of Related Publications will be displayed on the metadata tab.		t	28	f	NONE	publication	f	Related Publication	http://purl.org/dc/terms/isReferencedBy	\N		1	\N
30	t	f	f	The full bibliographic citation for this related publication.	#VALUE	t	29	f	TEXTBOX	publicationCitation	f	Citation	http://purl.org/dc/terms/bibliographicCitation	\N		1	29
31	t	t	f	The type of digital identifier used for this publication (e.g., Digital Object Identifier (DOI)).	#VALUE: 	t	30	f	TEXT	publicationIDType	f	ID Type	http://purl.org/spar/datacite/ResourceIdentifierScheme	\N		1	29
32	t	f	f	The identifier for the selected ID type.	#VALUE	t	31	f	TEXT	publicationIDNumber	f	ID Number	http://purl.org/spar/datacite/ResourceIdentifier	\N		1	29
33	f	f	f	Link to the publication web page (e.g., journal article page, archive record page, or other).	<a href="#VALUE" target="_blank" rel="noopener">#VALUE</a>	f	32	f	URL	publicationURL	f	URL	https://schema.org/distribution	\N	Enter full URL, starting with http://	1	29
34	f	f	f	Additional important information about the Dataset.		t	33	f	TEXTBOX	notesText	f	Notes	\N	\N		1	\N
35	t	t	t	Language of the Dataset		f	34	t	TEXT	language	f	Language	http://purl.org/dc/terms/language	\N		1	\N
36	f	f	t	Person or organization with the financial or administrative responsibility over this Dataset		f	35	f	NONE	producer	f	Producer	\N	\N		1	\N
37	t	f	f	Producer name	#VALUE	f	36	t	TEXT	producerName	f	Name	\N	\N	FamilyName, GivenName or Organization	1	36
38	f	f	f	The organization with which the producer is affiliated.	(#VALUE)	f	37	f	TEXT	producerAffiliation	f	Affiliation	\N	\N		1	36
39	f	f	f	The abbreviation by which the producer is commonly known. (ex. IQSS, ICPSR)	(#VALUE)	f	38	f	TEXT	producerAbbreviation	f	Abbreviation	\N	\N		1	36
40	f	f	f	Producer URL points to the producer's web presence, if appropriate. Enter an absolute URL where the producer's web site is found, such as http://www.my.org.  	<a href="#VALUE" target="_blank" rel="noopener">#VALUE</a>	f	39	f	URL	producerURL	f	URL	\N	\N	Enter full URL, starting with http://	1	36
41	f	f	f	URL for the producer's logo, which points to this  producer's web-accessible logo image. Enter an absolute URL where the producer's logo image is found, such as http://www.my.org/images/logo.gif.	<img src="#VALUE" alt="#NAME" class="metadata-logo"/><br/>	f	40	f	URL	producerLogoURL	f	Logo URL	\N	\N	Enter full URL for image, starting with http://	1	36
42	t	f	f	Date when the data collection or other materials were produced (not distributed, published or archived).		f	41	t	DATE	productionDate	f	Production Date	\N	\N	YYYY-MM-DD	1	\N
43	f	f	f	The location where the data collection and any other related materials were produced.		f	42	f	TEXT	productionPlace	f	Production Place	\N	\N		1	\N
44	f	f	t	The organization or person responsible for either collecting, managing, or otherwise contributing in some form to the development of the resource.	:	f	43	f	NONE	contributor	f	Contributor	http://purl.org/dc/terms/contributor	\N		1	\N
45	t	t	f	The type of contributor of the  resource.  	#VALUE 	f	44	t	TEXT	contributorType	f	Type	\N	\N		1	44
46	t	f	f	The Family Name, Given Name or organization name of the contributor.	#VALUE	f	45	t	TEXT	contributorName	f	Name	\N	\N	FamilyName, GivenName or Organization	1	44
47	f	f	t	Grant Information	:	f	46	f	NONE	grantNumber	f	Grant Information	https://schema.org/sponsor	\N		1	\N
48	t	f	f	Grant Number Agency	#VALUE	f	47	t	TEXT	grantNumberAgency	f	Grant Agency	\N	\N		1	47
49	t	f	f	The grant or contract number of the project that  sponsored the effort.	#VALUE	f	48	t	TEXT	grantNumberValue	f	Grant Number	\N	\N		1	47
50	f	f	t	The organization designated by the author or producer to generate copies of the particular work including any necessary editions or revisions.		f	49	f	NONE	distributor	f	Distributor	\N	\N		1	\N
51	t	f	f	Distributor name	#VALUE	f	50	t	TEXT	distributorName	f	Name	\N	\N	FamilyName, GivenName or Organization	1	50
52	f	f	f	The organization with which the distributor contact is affiliated.	(#VALUE)	f	51	f	TEXT	distributorAffiliation	f	Affiliation	\N	\N		1	50
53	f	f	f	The abbreviation by which this distributor is commonly known (e.g., IQSS, ICPSR).	(#VALUE)	f	52	f	TEXT	distributorAbbreviation	f	Abbreviation	\N	\N		1	50
54	f	f	f	Distributor URL points to the distributor's web presence, if appropriate. Enter an absolute URL where the distributor's web site is found, such as http://www.my.org.	<a href="#VALUE" target="_blank" rel="noopener">#VALUE</a>	f	53	f	URL	distributorURL	f	URL	\N	\N	Enter full URL, starting with http://	1	50
55	f	f	f	URL of the distributor's logo, which points to this  distributor's web-accessible logo image. Enter an absolute URL where the distributor's logo image is found, such as http://www.my.org/images/logo.gif.	<img src="#VALUE" alt="#NAME" class="metadata-logo"/><br/>	f	54	f	URL	distributorLogoURL	f	Logo URL	\N	\N	Enter full URL for image, starting with http://	1	50
56	t	f	f	Date that the work was made available for distribution/presentation.		f	55	t	DATE	distributionDate	f	Distribution Date	\N	\N	YYYY-MM-DD	1	\N
57	f	f	f	The person (Family Name, Given Name) or the name of the organization that deposited this Dataset to the repository.		f	56	f	TEXT	depositor	f	Depositor	\N	\N		1	\N
58	f	f	f	Date that the Dataset was deposited into the repository.		f	57	t	DATE	dateOfDeposit	f	Deposit Date	http://purl.org/dc/terms/dateSubmitted	\N	YYYY-MM-DD	1	\N
59	f	f	t	Time period to which the data refer. This item reflects the time period covered by the data, not the dates of coding or making documents machine-readable or the dates the data were collected. Also known as span.	;	f	58	f	NONE	timePeriodCovered	f	Time Period Covered	https://schema.org/temporalCoverage	\N		1	\N
60	t	f	f	Start date which reflects the time period covered by the data, not the dates of coding or making documents machine-readable or the dates the data were collected.	#NAME: #VALUE 	f	59	t	DATE	timePeriodCoveredStart	f	Start	\N	\N	YYYY-MM-DD	1	59
61	t	f	f	End date which reflects the time period covered by the data, not the dates of coding or making documents machine-readable or the dates the data were collected.	#NAME: #VALUE 	f	60	t	DATE	timePeriodCoveredEnd	f	End	\N	\N	YYYY-MM-DD	1	59
62	f	f	t	Contains the date(s) when the data were collected.	;	f	61	f	NONE	dateOfCollection	f	Date of Collection	\N	\N		1	\N
63	f	f	f	Date when the data collection started.	#NAME: #VALUE 	f	62	f	DATE	dateOfCollectionStart	f	Start	\N	\N	YYYY-MM-DD	1	62
64	f	f	f	Date when the data collection ended.	#NAME: #VALUE 	f	63	f	DATE	dateOfCollectionEnd	f	End	\N	\N	YYYY-MM-DD	1	62
65	t	f	t	Type of data included in the file: survey data, census/enumeration data, aggregate data, clinical data, event/transaction data, program source code, machine-readable text, administrative records data, experimental data, psychological test, textual data, coded textual, coded documents, time budget diaries, observation data/ratings, process-produced data, or other.		f	64	t	TEXT	kindOfData	f	Kind of Data	http://rdf-vocabulary.ddialliance.org/discovery#kindOfData	\N		1	\N
66	f	f	f	Information about the Dataset series.	:	f	65	f	NONE	series	f	Series	\N	\N		1	\N
67	t	f	f	Name of the dataset series to which the Dataset belongs.	#VALUE	f	66	t	TEXT	seriesName	f	Name	\N	\N		1	66
68	f	f	f	History of the series and summary of those features that apply to the series as a whole.	#VALUE	f	67	f	TEXTBOX	seriesInformation	f	Information	\N	\N		1	66
69	f	f	t	Information about the software used to generate the Dataset.	,	f	68	f	NONE	software	f	Software	https://www.w3.org/TR/prov-o/#wasGeneratedBy	\N		1	\N
70	f	t	f	Name of software used to generate the Dataset.	#VALUE	f	69	f	TEXT	softwareName	f	Name	\N	\N		1	69
71	f	f	f	Version of the software used to generate the Dataset.	#NAME: #VALUE	f	70	f	TEXT	softwareVersion	f	Version	\N	\N		1	69
72	f	f	t	Any material related to this Dataset.		f	71	f	TEXTBOX	relatedMaterial	f	Related Material	\N	\N		1	\N
73	f	f	t	Any Datasets that are related to this Dataset, such as previous research on this subject.		f	72	f	TEXTBOX	relatedDatasets	f	Related Datasets	http://purl.org/dc/terms/relation	\N		1	\N
74	f	f	t	Any references that would serve as background or supporting material to this Dataset.		f	73	f	TEXT	otherReferences	f	Other References	http://purl.org/dc/terms/references	\N		1	\N
75	f	f	t	List of books, articles, serials, or machine-readable data files that served as the sources of the data collection.		f	74	f	TEXTBOX	dataSources	f	Data Sources	https://www.w3.org/TR/prov-o/#wasDerivedFrom	\N		1	\N
76	f	f	f	For historical materials, information about the origin of the sources and the rules followed in establishing the sources should be specified.		f	75	f	TEXTBOX	originOfSources	f	Origin of Sources	\N	\N		1	\N
77	f	f	f	Assessment of characteristics and source material.		f	76	f	TEXTBOX	characteristicOfSources	f	Characteristic of Sources Noted	\N	\N		1	\N
78	f	f	f	Level of documentation of the original sources.		f	77	f	TEXTBOX	accessToSources	f	Documentation and Access to Sources	\N	\N		1	\N
79	f	f	t	Information on the geographic coverage of the data. Includes the total geographic scope of the data.		f	0	f	NONE	geographicCoverage	f	Geographic Coverage	\N	\N		2	\N
80	t	t	f	The country or nation that the Dataset is about.	#VALUE, 	f	1	t	TEXT	country	f	Country / Nation	\N	\N		2	79
81	t	f	f	The state or province that the Dataset is about. Use GeoNames for correct spelling and avoid abbreviations.	#VALUE, 	f	2	t	TEXT	state	f	State / Province	\N	\N		2	79
82	t	f	f	The name of the city that the Dataset is about. Use GeoNames for correct spelling and avoid abbreviations.	#VALUE, 	f	3	t	TEXT	city	f	City	\N	\N		2	79
83	f	f	f	Other information on the geographic coverage of the data.	#VALUE, 	f	4	f	TEXT	otherGeographicCoverage	f	Other	\N	\N		2	79
84	t	f	t	Lowest level of geographic aggregation covered by the Dataset, e.g., village, county, region.		f	5	t	TEXT	geographicUnit	f	Geographic Unit	\N	\N		2	\N
85	f	f	t	The fundamental geometric description for any Dataset that models geography is the geographic bounding box. It describes the minimum box, defined by west and east longitudes and north and south latitudes, which includes the largest geographic extent of the  Dataset's geographic coverage. This element is used in the first pass of a coordinate-based search. Inclusion of this element in the codebook is recommended, but is required if the bound polygon box is included. 		f	6	f	NONE	geographicBoundingBox	f	Geographic Bounding Box	\N	\N		2	\N
86	f	f	f	Westernmost coordinate delimiting the geographic extent of the Dataset. A valid range of values,  expressed in decimal degrees, is -180,0 <= West  Bounding Longitude Value <= 180,0.		f	7	f	TEXT	westLongitude	f	West Longitude	\N	\N		2	85
87	f	f	f	Easternmost coordinate delimiting the geographic extent of the Dataset. A valid range of values,  expressed in decimal degrees, is -180,0 <= East Bounding Longitude Value <= 180,0.		f	8	f	TEXT	eastLongitude	f	East Longitude	\N	\N		2	85
88	f	f	f	Northernmost coordinate delimiting the geographic extent of the Dataset. A valid range of values,  expressed in decimal degrees, is -90,0 <= North Bounding Latitude Value <= 90,0.		f	9	f	TEXT	northLongitude	f	North Latitude	\N	\N		2	85
89	f	f	f	Southernmost coordinate delimiting the geographic extent of the Dataset. A valid range of values,  expressed in decimal degrees, is -90,0 <= South Bounding Latitude Value <= 90,0.		f	10	f	TEXT	southLongitude	f	South Latitude	\N	\N		2	85
90	t	f	t	Basic unit of analysis or observation that this Dataset describes, such as individuals, families/households, groups, institutions/organizations, administrative units, and more. For information about the DDI's controlled vocabulary for this element, please refer to the DDI web page at http://www.ddialliance.org/controlled-vocabularies.		f	0	t	TEXTBOX	unitOfAnalysis	f	Unit of Analysis	\N	\N		3	\N
91	t	f	t	Description of the population covered by the data in the file; the group of people or other elements that are the object of the study and to which the study results refer. Age, nationality, and residence commonly help to  delineate a given universe, but any number of other factors may be used, such as age limits, sex, marital status, race, ethnic group, nationality, income, veteran status, criminal convictions, and more. The universe may consist of elements other than persons, such as housing units, court cases, deaths, countries, and so on. In general, it should be possible to tell from the description of the universe whether a given individual or element is a member of the population under study. Also known as the universe of interest, population of interest, and target population.		f	1	t	TEXTBOX	universe	f	Universe	\N	\N		3	\N
92	t	f	f	The time method or time dimension of the data collection, such as panel, cross-sectional, trend, time- series, or other.		f	2	t	TEXT	timeMethod	f	Time Method	\N	\N		3	\N
93	f	f	f	Individual, agency or organization responsible for  administering the questionnaire or interview or compiling the data.		f	3	f	TEXT	dataCollector	f	Data Collector	\N	\N	FamilyName, GivenName or Organization	3	\N
94	f	f	f	Type of training provided to the data collector		f	4	f	TEXT	collectorTraining	f	Collector Training	\N	\N		3	\N
95	t	f	f	If the data collected includes more than one point in time, indicate the frequency with which the data was collected; that is, monthly, quarterly, or other.		f	5	t	TEXT	frequencyOfDataCollection	f	Frequency	\N	\N		3	\N
96	f	f	f	Type of sample and sample design used to select the survey respondents to represent the population. May include reference to the target sample size and the sampling fraction.		f	6	f	TEXTBOX	samplingProcedure	f	Sampling Procedure	\N	\N		3	\N
97	f	f	f	Specific information regarding the target sample size, actual  sample size, and the formula used to determine this.		f	7	f	NONE	targetSampleSize	f	Target Sample Size	\N	\N		3	\N
98	f	f	f	Actual sample size.		f	8	f	INT	targetSampleActualSize	f	Actual	\N	\N	Enter an integer...	3	97
99	f	f	f	Formula used to determine target sample size.		f	9	f	TEXT	targetSampleSizeFormula	f	Formula	\N	\N		3	97
100	f	f	f	Show correspondence as well as discrepancies between the sampled units (obtained) and available statistics for the population (age, sex-ratio, marital status, etc.) as a whole.		f	10	f	TEXT	deviationsFromSampleDesign	f	Major Deviations for Sample Design	\N	\N		3	\N
101	f	f	f	Method used to collect the data; instrumentation characteristics (e.g., telephone interview, mail questionnaire, or other).		f	11	f	TEXTBOX	collectionMode	f	Collection Mode	\N	\N		3	\N
141	f	f	f	The maximum value of the redshift (unitless) or Doppler velocity (km/s in the data object.		f	25	f	FLOAT	coverage.Redshift.MaximumValue	f	Maximum	\N	\N	Enter a floating-point number.	4	139
102	f	f	f	Type of data collection instrument used. Structured indicates an instrument in which all respondents are asked the same questions/tests, possibly with precoded answers. If a small portion of such a questionnaire includes open-ended questions, provide appropriate comments. Semi-structured indicates that the research instrument contains mainly open-ended questions. Unstructured indicates that in-depth interviews were conducted.		f	12	f	TEXT	researchInstrument	f	Type of Research Instrument	\N	\N		3	\N
103	f	f	f	Description of noteworthy aspects of the data collection situation. Includes information on factors such as cooperativeness of respondents, duration of interviews, number of call backs, or similar.		f	13	f	TEXTBOX	dataCollectionSituation	f	Characteristics of Data Collection Situation	\N	\N		3	\N
104	f	f	f	Summary of actions taken to minimize data loss. Include information on actions such as follow-up visits, supervisory checks, historical matching, estimation, and so on.		f	14	f	TEXT	actionsToMinimizeLoss	f	Actions to Minimize Losses	\N	\N		3	\N
105	f	f	f	Control OperationsMethods to facilitate data control performed by the primary investigator or by the data archive.		f	15	f	TEXT	controlOperations	f	Control Operations	\N	\N		3	\N
106	f	f	f	The use of sampling procedures might make it necessary to apply weights to produce accurate statistical results. Describes the criteria for using weights in analysis of a collection. If a weighting formula or coefficient was developed, the formula is provided, its elements are defined, and it is indicated how the formula was applied to the data.		f	16	f	TEXTBOX	weighting	f	Weighting	\N	\N		3	\N
107	f	f	f	Methods used to clean the data collection, such as consistency checking, wildcode checking, or other.		f	17	f	TEXT	cleaningOperations	f	Cleaning Operations	\N	\N		3	\N
108	f	f	f	Note element used for any information annotating or clarifying the methodology and processing of the study. 		f	18	f	TEXT	datasetLevelErrorNotes	f	Study Level Error Notes	\N	\N		3	\N
109	t	f	f	Percentage of sample members who provided information.		f	19	t	TEXTBOX	responseRate	f	Response Rate	\N	\N		3	\N
110	f	f	f	Measure of how precisely one can estimate a population value from a given sample.		f	20	f	TEXT	samplingErrorEstimates	f	Estimates of Sampling Error	\N	\N		3	\N
111	f	f	f	Other issues pertaining to the data appraisal. Describe issues such as response variance, nonresponse rate  and testing for bias, interviewer and response bias, confidence levels, question bias, or similar.		f	21	f	TEXT	otherDataAppraisal	f	Other Forms of Data Appraisal	\N	\N		3	\N
112	f	f	f	General notes about this Dataset.		f	22	f	NONE	socialScienceNotes	f	Notes	\N	\N		3	\N
113	f	f	f	Type of note.		f	23	f	TEXT	socialScienceNotesType	f	Type	\N	\N		3	112
114	f	f	f	Note subject.		f	24	f	TEXT	socialScienceNotesSubject	f	Subject	\N	\N		3	112
115	f	f	f	Text for this note.		f	25	f	TEXTBOX	socialScienceNotesText	f	Text	\N	\N		3	112
116	t	t	t	The nature or genre of the content of the files in the dataset.		f	0	t	TEXT	astroType	f	Type	\N	\N		4	\N
117	t	t	t	The observatory or facility where the data was obtained. 		f	1	t	TEXT	astroFacility	f	Facility	\N	\N		4	\N
118	t	t	t	The instrument used to collect the data.		f	2	t	TEXT	astroInstrument	f	Instrument	\N	\N		4	\N
119	t	f	t	Astronomical Objects represented in the data (Given as SIMBAD recognizable names preferred).		f	3	t	TEXT	astroObject	f	Object	\N	\N		4	\N
120	t	f	f	The spatial (angular) resolution that is typical of the observations, in decimal degrees.		f	4	t	TEXT	resolution.Spatial	f	Spatial Resolution	\N	\N		4	\N
121	t	f	f	The spectral resolution that is typical of the observations, given as the ratio \\u03bb/\\u0394\\u03bb.		f	5	t	TEXT	resolution.Spectral	f	Spectral Resolution	\N	\N		4	\N
122	f	f	f	The temporal resolution that is typical of the observations, given in seconds.		f	6	f	TEXT	resolution.Temporal	f	Time Resolution	\N	\N		4	\N
123	t	t	t	Conventional bandpass name		f	7	t	TEXT	coverage.Spectral.Bandpass	f	Bandpass	\N	\N		4	\N
124	t	f	t	The central wavelength of the spectral bandpass, in meters.		f	8	t	FLOAT	coverage.Spectral.CentralWavelength	f	Central Wavelength (m)	\N	\N	Enter a floating-point number.	4	\N
125	f	f	t	The minimum and maximum wavelength of the spectral bandpass.		f	9	f	NONE	coverage.Spectral.Wavelength	f	Wavelength Range	\N	\N	Enter a floating-point number.	4	\N
126	t	f	f	The minimum wavelength of the spectral bandpass, in meters.		f	10	t	FLOAT	coverage.Spectral.MinimumWavelength	f	Minimum (m)	\N	\N	Enter a floating-point number.	4	125
127	t	f	f	The maximum wavelength of the spectral bandpass, in meters.		f	11	t	FLOAT	coverage.Spectral.MaximumWavelength	f	Maximum (m)	\N	\N	Enter a floating-point number.	4	125
128	f	f	t	 Time period covered by the data.		f	12	f	NONE	coverage.Temporal	f	Dataset Date Range	\N	\N		4	\N
129	t	f	f	Dataset Start Date		f	13	t	DATE	coverage.Temporal.StartTime	f	Start	\N	\N	YYYY-MM-DD	4	128
130	t	f	f	Dataset End Date		f	14	t	DATE	coverage.Temporal.StopTime	f	End	\N	\N	YYYY-MM-DD	4	128
131	f	f	t	The sky coverage of the data object.		f	15	f	TEXT	coverage.Spatial	f	Sky Coverage	\N	\N		4	\N
132	f	f	f	The (typical) depth coverage, or sensitivity, of the data object in Jy.		f	16	f	FLOAT	coverage.Depth	f	Depth Coverage	\N	\N	Enter a floating-point number.	4	\N
133	f	f	f	The (typical) density of objects, catalog entries, telescope pointings, etc., on the sky, in number per square degree.		f	17	f	FLOAT	coverage.ObjectDensity	f	Object Density	\N	\N	Enter a floating-point number.	4	\N
134	f	f	f	The total number of objects, catalog entries, etc., in the data object.		f	18	f	INT	coverage.ObjectCount	f	Object Count	\N	\N	Enter an integer.	4	\N
135	f	f	f	The fraction of the sky represented in the observations, ranging from 0 to 1.		f	19	f	FLOAT	coverage.SkyFraction	f	Fraction of Sky	\N	\N	Enter a floating-point number.	4	\N
136	f	f	f	The polarization coverage		f	20	f	TEXT	coverage.Polarization	f	Polarization	\N	\N		4	\N
137	f	f	f	RedshiftType string C "Redshift"; or "Optical" or "Radio" definitions of Doppler velocity used in the data object.		f	21	f	TEXT	redshiftType	f	RedshiftType	\N	\N		4	\N
138	f	f	f	The resolution in redshift (unitless) or Doppler velocity (km/s) in the data object.		f	22	f	FLOAT	resolution.Redshift	f	Redshift Resolution	\N	\N	Enter a floating-point number.	4	\N
139	f	f	t	The value of the redshift (unitless) or Doppler velocity (km/s in the data object.		f	23	f	FLOAT	coverage.RedshiftValue	f	Redshift Value	\N	\N	Enter a floating-point number.	4	\N
140	f	f	f	The minimum value of the redshift (unitless) or Doppler velocity (km/s in the data object.		f	24	f	FLOAT	coverage.Redshift.MinimumValue	f	Minimum	\N	\N	Enter a floating-point number.	4	139
142	t	t	t	Design types that are based on the overall experimental design.		f	0	t	TEXT	studyDesignType	f	Design Type	\N	\N		5	\N
143	t	t	t	Factors used in the Dataset. 		f	1	t	TEXT	studyFactorType	f	Factor Type	\N	\N		5	\N
144	t	t	t	The taxonomic name of the organism used in the Dataset or from which the  starting biological material derives.		f	2	t	TEXT	studyAssayOrganism	f	Organism	\N	\N		5	\N
145	t	f	t	If Other was selected in Organism, list any other organisms that were used in this Dataset. Terms from the NCBI Taxonomy are recommended.		f	3	t	TEXT	studyAssayOtherOrganism	f	Other Organism	\N	\N		5	\N
146	t	t	t	A term to qualify the endpoint, or what is being measured (e.g. gene expression profiling; protein identification). 		f	4	t	TEXT	studyAssayMeasurementType	f	Measurement Type	\N	\N		5	\N
147	t	f	t	If Other was selected in Measurement Type, list any other measurement types that were used. Terms from NCBO Bioportal are recommended.		f	5	t	TEXT	studyAssayOtherMeasurmentType	f	Other Measurement Type	\N	\N		5	\N
148	t	t	t	A term to identify the technology used to perform the measurement (e.g. DNA microarray; mass spectrometry).		f	6	t	TEXT	studyAssayTechnologyType	f	Technology Type	\N	\N		5	\N
149	t	t	t	The manufacturer and name of the technology platform used in the assay (e.g. Bruker AVANCE).		f	7	t	TEXT	studyAssayPlatform	f	Technology Platform	\N	\N		5	\N
150	t	t	t	The name of the cell line from which the source or sample derives.		f	8	t	TEXT	studyAssayCellType	f	Cell Type	\N	\N		5	\N
151	f	f	t	Indicates the volume, issue and date of a journal, which this Dataset is associated with.		f	0	f	NONE	journalVolumeIssue	f	Journal	\N	\N		6	\N
152	t	f	f	The journal volume which this Dataset is associated with (e.g., Volume 4).		f	1	t	TEXT	journalVolume	f	Volume	\N	\N		6	151
153	t	f	f	The journal issue number which this Dataset is associated with (e.g., Number 2, Autumn).		f	2	t	TEXT	journalIssue	f	Issue	\N	\N		6	151
154	t	f	f	The publication date for this journal volume/issue, which this Dataset is associated with (e.g., 1999).		f	3	t	DATE	journalPubDate	f	Publication Date	\N	\N	YYYY or YYYY-MM or YYYY-MM-DD	6	151
155	t	t	f	Indicates what kind of article this is, for example, a research article, a commentary, a book or product review, a case report, a calendar, etc (based on JATS). 		f	4	t	TEXT	journalArticleType	f	Type of Article	\N	\N		6	\N
\.


--
-- Data for Name: datasetfieldvalue; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetfieldvalue (id, displayorder, value, datasetfield_id) FROM stdin;
1	0	Thierry Louge	8
2	0	thierry.louge@toulouse-inp.fr	9
3	0	Callisto demonstration ontology	10
4	0	PSD Processing TEST FILES - NOT FOR SCIENTIFIC USE	16
5	0	CALMIP	15
6	0	Thierry Louge	12
7	0	2020-10-05	19
8	0	BEWARE - TESTING PURPOSES only, those files should NOT be used for scientific analysis, they DO NOT belong to any real-world measurements. Signal for PSD processing	20
9	0	https://allegro.callisto.calmip.univ-toulouse.fr/#/repositories/sms/node/%3Chttp://www.callisto.calmip.univ-toulouse.fr/DEMONSTRATION.rdf%23Signal%3E	7
10	0	Admin, Dataverse	18
11	0	Signal	11
12	0	CALMIP	17
13	0	TESTING PURPOSES ONLY - Calculated pressure coefficient	38
14	0	C_p	40
15	0	CALMIP	35
16	0	https://allegro.callisto.calmip.univ-toulouse.fr/#/repositories/sms/node/%3Chttp://www.callisto.calmip.univ-toulouse.fr/DEMONSTRATION.rdf	30
17	0	Thierry Louge	34
18	0	CALMIP	26
19	0	thierry.louge@toulouse-inp.fr	37
20	0	BEWARE - TESTING PURPOSES only, those files should NOT be used for scientific analysis, they DO NOT belong to any real-world measurements. Pressure coefficient calculated from measured pressure on a plane wing C_p = (P-P_inf)/(0.5*rho_inf*V_inf^2) With: P is the measured pressure (Pascals) P_inf is a reference pressure taken as the static pressure at infinity (upstream of the wing), free-stream rho_inf is the density taken at infinity, free-stream V_inf is the velocity of the flow to infinity, free-stream	33
21	0	Admin, Dataverse	27
22	0	2020-10-05	32
23	0	Callisto demonstration ontology	36
24	0	Thierry Louge	28
\.


--
-- Data for Name: datasetlinkingdataverse; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetlinkingdataverse (id, linkcreatetime, dataset_id, linkingdataverse_id) FROM stdin;
\.


--
-- Data for Name: datasetlock; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetlock (id, info, reason, starttime, dataset_id, user_id) FROM stdin;
\.


--
-- Data for Name: datasetmetrics; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetmetrics (id, countrycode, downloadstotalmachine, downloadstotalregular, downloadsuniquemachine, downloadsuniqueregular, monthyear, viewstotalmachine, viewstotalregular, viewsuniquemachine, viewsuniqueregular, dataset_id) FROM stdin;
\.


--
-- Data for Name: datasetversion; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetversion (id, unf, archivalcopylocation, archivenote, archivetime, createtime, deaccessionlink, lastupdatetime, minorversionnumber, releasetime, version, versionnote, versionnumber, versionstate, dataset_id, termsofuseandaccess_id) FROM stdin;
1	\N	\N	\N	\N	2020-10-05 13:22:43.582	\N	2020-10-05 13:22:44.266	\N	\N	2	\N	\N	DRAFT	3	1
2	\N	\N	\N	\N	2020-10-05 13:37:54.423	\N	2020-10-05 13:37:54.831	\N	\N	2	\N	\N	DRAFT	5	2
\.


--
-- Data for Name: datasetversionuser; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datasetversionuser (id, lastupdatedate, authenticateduser_id, datasetversion_id) FROM stdin;
1	2020-10-05 13:22:44.266	1	1
2	2020-10-05 13:37:54.831	1	2
\.


--
-- Data for Name: datatable; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datatable (id, casequantity, originalfileformat, originalfilename, originalfilesize, originalformatversion, recordspercase, unf, varquantity, datafile_id) FROM stdin;
\.


--
-- Data for Name: datavariable; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.datavariable (id, factor, fileendposition, fileorder, filestartposition, format, formatcategory, "interval", label, name, numberofdecimalpoints, orderedfactor, recordsegmentnumber, type, unf, weighted, datatable_id) FROM stdin;
\.


--
-- Data for Name: dataverse; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataverse (id, affiliation, alias, dataversetype, description, facetroot, guestbookroot, metadatablockroot, name, permissionroot, storagedriver, templateroot, themeroot, defaultcontributorrole_id, defaulttemplate_id) FROM stdin;
1	\N	root	UNCATEGORIZED	The root dataverse.	t	f	t	Root	t	\N	f	t	6	\N
2	CALMIP	demonstration	LABORATORY	BEWARE - TESTING PURPOSES only, those files should NOT be used for scientific analysis, they DO NOT belong to any real-world measurements. Signal for PSD processing 	f	f	f	demonstration	t	\N	f	t	6	\N
\.


--
-- Data for Name: dataverse_citationdatasetfieldtypes; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataverse_citationdatasetfieldtypes (dataverse_id, citationdatasetfieldtype_id) FROM stdin;
\.


--
-- Data for Name: dataverse_metadatablock; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataverse_metadatablock (dataverse_id, metadatablocks_id) FROM stdin;
1	1
\.


--
-- Data for Name: dataversecontact; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataversecontact (id, contactemail, displayorder, dataverse_id) FROM stdin;
1	root@mailinator.com	0	1
2	thierry.louge@toulouse-inp.fr	0	2
\.


--
-- Data for Name: dataversefacet; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataversefacet (id, displayorder, datasetfieldtype_id, dataverse_id) FROM stdin;
1	2	22	1
2	0	9	1
3	3	58	1
4	1	20	1
\.


--
-- Data for Name: dataversefeatureddataverse; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataversefeatureddataverse (id, displayorder, dataverse_id, featureddataverse_id) FROM stdin;
\.


--
-- Data for Name: dataversefieldtypeinputlevel; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataversefieldtypeinputlevel (id, include, required, datasetfieldtype_id, dataverse_id) FROM stdin;
\.


--
-- Data for Name: dataverselinkingdataverse; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataverselinkingdataverse (id, linkcreatetime, dataverse_id, linkingdataverse_id) FROM stdin;
\.


--
-- Data for Name: dataverserole; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataverserole (id, alias, description, name, permissionbits, owner_id) FROM stdin;
1	admin	A person who has all permissions for dataverses, datasets, and files.	Admin	8191	\N
2	fileDownloader	A person who can download a published file.	File Downloader	16	\N
3	fullContributor	A person who can add subdataverses and datasets within a dataverse.	Dataverse + Dataset Creator	3	\N
4	dvContributor	A person who can add subdataverses within a dataverse.	Dataverse Creator	1	\N
5	dsContributor	A person who can add datasets within a dataverse.	Dataset Creator	2	\N
6	contributor	For datasets, a person who can edit License + Terms, and then submit them for review.	Contributor	4184	\N
7	curator	For datasets, a person who can edit License + Terms, edit Permissions, and publish datasets.	Curator	5471	\N
8	member	A person who can view both unpublished dataverses and datasets.	Member	28	\N
\.


--
-- Data for Name: dataversesubjects; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataversesubjects (dataverse_id, controlledvocabularyvalue_id) FROM stdin;
\.


--
-- Data for Name: dataversetheme; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dataversetheme (id, backgroundcolor, linkcolor, linkurl, logo, logoalignment, logobackgroundcolor, logofooter, logofooteralignment, logofooterbackgroundcolor, logoformat, tagline, textcolor, dataverse_id) FROM stdin;
\.


--
-- Data for Name: defaultvalueset; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.defaultvalueset (id, name) FROM stdin;
\.


--
-- Data for Name: doidataciteregistercache; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.doidataciteregistercache (id, doi, status, url, xml) FROM stdin;
\.


--
-- Data for Name: dvobject; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.dvobject (id, dtype, authority, createdate, globalidcreatetime, identifier, identifierregistered, indextime, modificationtime, permissionindextime, permissionmodificationtime, previewimageavailable, protocol, publicationdate, storageidentifier, creator_id, owner_id, releaseuser_id) FROM stdin;
1	Dataverse	\N	2020-10-05 10:46:13.723	\N	\N	f	\N	2020-10-05 10:46:14.034	\N	2020-10-05 10:46:13.765	f	\N	\N	\N	1	\N	\N
2	Dataverse	\N	2020-10-05 13:16:27.218	\N	\N	f	2020-10-05 13:16:27.603	2020-10-05 13:16:27.281	2020-10-05 13:16:27.681	2020-10-05 13:16:27.281	f	\N	\N	\N	1	1	\N
4	DataFile	\N	2020-10-05 13:22:44.266	\N	\N	f	\N	2020-10-05 13:22:44.266	\N	2020-10-05 13:22:36.944	f	\N	\N	file://174f87fc410-2a27de02ed45	1	3	\N
3	Dataset	10.5072	2020-10-05 13:22:43.559	2020-10-05 13:22:43.559	FK2/VGVX2C	t	2020-10-05 13:22:44.674	2020-10-05 13:22:44.266	2020-10-05 13:22:44.845	2020-10-05 13:22:43.559	f	doi	\N	file://10.5072/FK2/VGVX2C	1	2	\N
6	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.636	f	\N	\N	file://174f88d305c-32ed08b69e17	1	5	\N
7	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.619	f	\N	\N	file://174f88d304b-fc053c5cfad8	1	5	\N
8	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.647	f	\N	\N	file://174f88d3067-f5881fe40b2b	1	5	\N
9	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.595	f	\N	\N	file://174f88d3033-de9373b93f5b	1	5	\N
10	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.611	f	\N	\N	file://174f88d3043-3b235f79f970	1	5	\N
11	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.586	f	\N	\N	file://174f88d302a-5f11670950a9	1	5	\N
12	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.602	f	\N	\N	file://174f88d303a-ae79bb4b6ec7	1	5	\N
13	DataFile	\N	2020-10-05 13:37:54.831	\N	\N	f	\N	2020-10-05 13:37:54.831	\N	2020-10-05 13:37:16.628	f	\N	\N	file://174f88d3054-f25f51541465	1	5	\N
5	Dataset	10.5072	2020-10-05 13:37:54.419	2020-10-05 13:37:54.419	FK2/9BHFXX	t	2020-10-05 13:37:55.195	2020-10-05 13:37:54.831	2020-10-05 13:37:55.359	2020-10-05 13:37:54.419	f	doi	\N	file://10.5072/FK2/9BHFXX	1	2	\N
\.


--
-- Data for Name: explicitgroup; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.explicitgroup (id, description, displayname, groupalias, groupaliasinowner, owner_id) FROM stdin;
\.


--
-- Data for Name: explicitgroup_authenticateduser; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.explicitgroup_authenticateduser (explicitgroup_id, containedauthenticatedusers_id) FROM stdin;
\.


--
-- Data for Name: explicitgroup_containedroleassignees; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.explicitgroup_containedroleassignees (explicitgroup_id, containedroleassignees) FROM stdin;
\.


--
-- Data for Name: explicitgroup_explicitgroup; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.explicitgroup_explicitgroup (explicitgroup_id, containedexplicitgroups_id) FROM stdin;
\.


--
-- Data for Name: externaltool; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.externaltool (id, contenttype, description, displayname, haspreviewmode, scope, toolname, toolparameters, toolurl, type) FROM stdin;
1	text/plain	Read the text file.	Read Text	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/TextPreview.html	EXPLORE
2	text/html	View the html file.	View Html	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/HtmlPreview.html	EXPLORE
3	audio/mp3	Listen to an audio file.	Play Audio	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/AudioPreview.html	EXPLORE
4	audio/mpeg	Listen to an audio file.	Play Audio	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/AudioPreview.html	EXPLORE
5	audio/wav	Listen to an audio file.	Play Audio	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/AudioPreview.html	EXPLORE
6	audio/ogg	Listen to an audio file.	Play Audio	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/AudioPreview.html	EXPLORE
7	image/gif	Preview an image file.	View Image	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/ImagePreview.html	EXPLORE
8	image/jpeg	Preview an image file.	View Image	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/ImagePreview.html	EXPLORE
9	image/png	Preview an image file.	View Image	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/ImagePreview.html	EXPLORE
10	application/pdf	Read a pdf document.	Read Document	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/PDFPreview.html	EXPLORE
11	video/mp4	Watch a video file.	Play Video	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/VideoPreview.html	EXPLORE
12	video/ogg	Watch a video file.	Play Video	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/VideoPreview.html	EXPLORE
13	video/quicktime	Watch a video file.	Play Video	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/VideoPreview.html	EXPLORE
14	text/comma-separated-values	View the spreadsheet data.	View Data	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/SpreadsheetPreview.html	EXPLORE
15	text/tab-separated-values	View the spreadsheet data.	View Data	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/SpreadsheetPreview.html	EXPLORE
16	application/x-stata-syntax	View the Stata file as text.	View Stata File	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/TextPreview.html	EXPLORE
17	type/x-r-syntax	View the R file as text.	View R file	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/TextPreview.html	EXPLORE
18	application/x-json-hypothesis	View the annotation entries in a file.	View Annotations	t	FILE	\N	{"queryParameters":[{"fileid":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"datasetid":"{datasetId}"},{"datasetversion":"{datasetVersion}"},{"locale":"{localeCode}"}]}	/dataverse-previewers/previewers/HypothesisPreview.html	EXPLORE
19	text/tab-separated-values	Data Curation Tool for curation of variables	Data Curation Tool	f	FILE	\N	{"queryParameters":[{"dfId":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"},{"fileMetadataId":"{fileMetadataId}"}]}	https://scholarsportal.github.io/Dataverse-Data-Curation-Tool/	CONFIGURE
20	text/tab-separated-values	The Data Explorer provides a GUI which lists the variables in a tabular data file allowing searching, charting and cross tabulation analysis.	Data Explorer	f	FILE	\N	{"queryParameters":[{"fileId":"{fileId}"},{"siteUrl":"{siteUrl}"},{"key":"{apiToken}"}]}	https://scholarsportal.github.io/Dataverse-Data-Explorer/	EXPLORE
\.


--
-- Data for Name: fileaccessrequests; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.fileaccessrequests (datafile_id, authenticated_user_id) FROM stdin;
\.


--
-- Data for Name: filedownload; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.filedownload (downloadtimestamp, downloadtype, guestbookresponse_id, sessionid) FROM stdin;
\.


--
-- Data for Name: filemetadata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.filemetadata (id, description, directorylabel, label, prov_freeform, restricted, version, datafile_id, datasetversion_id) FROM stdin;
1	\N	\N	Cx_Cz_Cm_365.plt	\N	f	1	4	1
2	\N	\N	MODELPRES00001__EG0001_alfa1.csv	\N	f	1	11	2
3	\N	\N	MODELPRES00001__EG0002_alfa1.csv	\N	f	1	7	2
4	\N	\N	MODELPRES00001__EG0001_alfa3.csv	\N	f	1	12	2
5	\N	\N	MODELPRES00001__EG0002_alfa2.csv	\N	f	1	13	2
6	\N	\N	MODELPRES00001__EG0002_alfa3.csv	\N	f	1	6	2
7	\N	\N	MODELPRES00001__EG0001_alfa4.csv	\N	f	1	10	2
8	\N	\N	MODELPRES00001__EG0002_alfa4.csv	\N	f	1	8	2
9	\N	\N	MODELPRES00001__EG0001_alfa2.csv	\N	f	1	9	2
\.


--
-- Data for Name: filemetadata_datafilecategory; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.filemetadata_datafilecategory (filecategories_id, filemetadatas_id) FROM stdin;
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	<< Flyway Baseline >>	BASELINE	<< Flyway Baseline >>	\N	dvnuser	2020-10-05 10:46:01.897602	0	t
2	4.11	5513-database-variablemetadata	SQL	V4.11__5513-database-variablemetadata.sql	767369850	dvnuser	2020-10-05 10:46:01.923087	3	t
3	4.11.0.1	5565-sanitize-directory-labels	SQL	V4.11.0.1__5565-sanitize-directory-labels.sql	-274470039	dvnuser	2020-10-05 10:46:01.930853	3	t
4	4.12.0.1	4.13-re-sanitize-filemetadata	SQL	V4.12.0.1__4.13-re-sanitize-filemetadata.sql	-95635412	dvnuser	2020-10-05 10:46:01.938109	1	t
5	4.13.0.1	3575-usernames	SQL	V4.13.0.1__3575-usernames.sql	1916037265	dvnuser	2020-10-05 10:46:01.943818	2	t
6	4.14.0.1	5822-export-var-meta	SQL	V4.14.0.1__5822-export-var-meta.sql	2019772659	dvnuser	2020-10-05 10:46:01.950462	0	t
7	4.15.0.1	2043-split-gbr-table	SQL	V4.15.0.1__2043-split-gbr-table.sql	-1955706731	dvnuser	2020-10-05 10:46:01.954143	6	t
8	4.16.0.1	5303-addColumn-to-settingTable	SQL	V4.16.0.1__5303-addColumn-to-settingTable.sql	1442682945	dvnuser	2020-10-05 10:46:01.965313	5	t
9	4.16.0.2	5028-dataset-explore	SQL	V4.16.0.2__5028-dataset-explore.sql	797098461	dvnuser	2020-10-05 10:46:01.975596	1	t
10	4.16.0.3	6156-FooterImageforSub-Dataverse	SQL	V4.16.0.3__6156-FooterImageforSub-Dataverse.sql	-88679435	dvnuser	2020-10-05 10:46:01.980092	1	t
11	4.17.0.1	5991-update-scribejava	SQL	V4.17.0.1__5991-update-scribejava.sql	-1195698165	dvnuser	2020-10-05 10:46:01.984141	1	t
12	4.17.0.2	3578-file-page-preview	SQL	V4.17.0.2__3578-file-page-preview.sql	-4976721	dvnuser	2020-10-05 10:46:01.988901	1	t
13	4.18.1.1	6459-contenttype-nullable	SQL	V4.18.1.1__6459-contenttype-nullable.sql	-294036505	dvnuser	2020-10-05 10:46:01.994258	0	t
14	4.19.0.1	6485 multistore	SQL	V4.19.0.1__6485_multistore.sql	-889428141	dvnuser	2020-10-05 10:46:01.998225	1	t
15	4.19.0.2	6644-update-editor-role-alias	SQL	V4.19.0.2__6644-update-editor-role-alias.sql	1822084145	dvnuser	2020-10-05 10:46:02.003469	1	t
16	4.20.0.1	2734-alter-data-table-add-orig-file-name	SQL	V4.20.0.1__2734-alter-data-table-add-orig-file-name.sql	-842134191	dvnuser	2020-10-05 10:46:02.008615	1	t
17	4.20.0.2	6748-configure-dropdown-toolname	SQL	V4.20.0.2__6748-configure-dropdown-toolname.sql	-222908387	dvnuser	2020-10-05 10:46:02.012776	1	t
18	4.20.0.3	6558-file-validation	SQL	V4.20.0.3__6558-file-validation.sql	1209461763	dvnuser	2020-10-05 10:46:02.016752	1	t
19	4.20.0.4	6936-maildomain-groups	SQL	V4.20.0.4__6936-maildomain-groups.sql	576953306	dvnuser	2020-10-05 10:46:02.020799	1	t
20	4.20.0.5	6505-zipdownload-jobs	SQL	V4.20.0.5__6505-zipdownload-jobs.sql	-409990981	dvnuser	2020-10-05 10:46:02.026639	1	t
\.


--
-- Data for Name: foreignmetadatafieldmapping; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.foreignmetadatafieldmapping (id, datasetfieldname, foreignfieldxpath, isattribute, foreignmetadataformatmapping_id, parentfieldmapping_id) FROM stdin;
1	title	:title	f	1	\N
2	otherIdValue	:identifier	f	1	\N
3	authorName	:creator	f	1	\N
4	productionDate	:date	f	1	\N
5	keywordValue	:subject	f	1	\N
6	dsDescriptionValue	:description	f	1	\N
7	relatedMaterial	:relation	f	1	\N
8	publicationCitation	:isReferencedBy	f	1	\N
9	publicationURL	holdingsURI	t	1	8
10	publicationIDType	agency	t	1	8
11	publicationIDNumber	IDNo	t	1	8
12	otherGeographicCoverage	:coverage	f	1	\N
13	kindOfData	:type	f	1	\N
14	dataSources	:source	f	1	\N
15	authorAffiliation	affiliation	t	1	3
16	contributorName	:contributor	f	1	\N
17	contributorType	type	t	1	16
18	producerName	:publisher	f	1	\N
19	language	:language	f	1	\N
\.


--
-- Data for Name: foreignmetadataformatmapping; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.foreignmetadataformatmapping (id, displayname, name, schemalocation, startelement) FROM stdin;
1	dcterms: DCMI Metadata Terms	http://purl.org/dc/terms/	http://dublincore.org/schemas/xmls/qdc/dcterms.xsd	entry
\.


--
-- Data for Name: guestbook; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.guestbook (id, createtime, emailrequired, enabled, institutionrequired, name, namerequired, positionrequired, dataverse_id) FROM stdin;
1	2020-10-05 10:46:07.619657	f	t	f	Default	f	f	\N
\.


--
-- Data for Name: guestbookresponse; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.guestbookresponse (id, email, institution, name, "position", responsetime, authenticateduser_id, datafile_id, dataset_id, datasetversion_id, guestbook_id) FROM stdin;
\.


--
-- Data for Name: harvestingclient; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.harvestingclient (id, archivedescription, archiveurl, deleted, harveststyle, harvesttype, harvestingnow, harvestingset, harvestingurl, metadataprefix, name, scheduledayofweek, schedulehourofday, scheduleperiod, scheduled, dataverse_id) FROM stdin;
\.


--
-- Data for Name: harvestingdataverseconfig; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.harvestingdataverseconfig (id, archivedescription, archiveurl, harveststyle, harvesttype, harvestingset, harvestingurl, dataverse_id) FROM stdin;
\.


--
-- Data for Name: ingestreport; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.ingestreport (id, endtime, report, starttime, status, type, datafile_id) FROM stdin;
1	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	6
2	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	8
3	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	13
4	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	7
5	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	9
6	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	10
7	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	11
8	\N	The header contains a duplicate name: "TAP_NAME" in [, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME, TAP_NAME]	\N	3	0	12
\.


--
-- Data for Name: ingestrequest; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.ingestrequest (id, controlcard, forcetypecheck, labelsfile, textencoding, datafile_id) FROM stdin;
\.


--
-- Data for Name: ipv4range; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.ipv4range (id, bottomaslong, topaslong, owner_id) FROM stdin;
\.


--
-- Data for Name: ipv6range; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.ipv6range (id, bottoma, bottomb, bottomc, bottomd, topa, topb, topc, topd, owner_id) FROM stdin;
\.


--
-- Data for Name: maplayermetadata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.maplayermetadata (id, embedmaplink, isjoinlayer, joindescription, lastverifiedstatus, lastverifiedtime, layerlink, layername, mapimagelink, maplayerlinks, worldmapusername, dataset_id, datafile_id) FROM stdin;
\.


--
-- Data for Name: metadatablock; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.metadatablock (id, displayname, name, namespaceuri, owner_id) FROM stdin;
1	Citation Metadata	citation	https://dataverse.org/schema/citation/	\N
2	Geospatial Metadata	geospatial	\N	\N
3	Social Science and Humanities Metadata	socialscience	\N	\N
4	Astronomy and Astrophysics Metadata	astrophysics	\N	\N
5	Life Sciences Metadata	biomedical	\N	\N
6	Journal Metadata	journal	\N	\N
\.


--
-- Data for Name: metric; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.metric (id, datalocation, daystring, lastcalleddate, name, valuejson) FROM stdin;
\.


--
-- Data for Name: oairecord; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.oairecord (id, globalid, lastupdatetime, removed, setname) FROM stdin;
\.


--
-- Data for Name: oaiset; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.oaiset (id, definition, deleted, description, name, spec, updateinprogress, version) FROM stdin;
\.


--
-- Data for Name: oauth2tokendata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.oauth2tokendata (id, accesstoken, expirydate, oauthproviderid, rawresponse, refreshtoken, tokentype, user_id) FROM stdin;
\.


--
-- Data for Name: passwordresetdata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.passwordresetdata (id, created, expires, reason, token, builtinuser_id) FROM stdin;
\.


--
-- Data for Name: pendingworkflowinvocation; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.pendingworkflowinvocation (invocationid, datasetexternallyreleased, ipaddress, nextminorversionnumber, nextversionnumber, pendingstepidx, typeordinal, userid, workflow_id, dataset_id) FROM stdin;
\.


--
-- Data for Name: pendingworkflowinvocation_localdata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.pendingworkflowinvocation_localdata (pendingworkflowinvocation_invocationid, localdata, localdata_key) FROM stdin;
\.


--
-- Data for Name: persistedglobalgroup; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.persistedglobalgroup (id, dtype, description, displayname, persistedgroupalias, emaildomains) FROM stdin;
\.


--
-- Data for Name: roleassignment; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.roleassignment (id, assigneeidentifier, privateurltoken, definitionpoint_id, role_id) FROM stdin;
1	@dataverseAdmin	\N	1	1
2	@dataverseAdmin	\N	2	1
3	@dataverseAdmin	\N	3	6
4	@dataverseAdmin	\N	5	6
\.


--
-- Data for Name: savedsearch; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.savedsearch (id, query, creator_id, definitionpoint_id) FROM stdin;
\.


--
-- Data for Name: savedsearchfilterquery; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.savedsearchfilterquery (id, filterquery, savedsearch_id) FROM stdin;
\.


--
-- Data for Name: sequence; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.sequence (seq_name, seq_count) FROM stdin;
SEQ_GEN	0
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.setting (id, content, lang, name) FROM stdin;
2	/dataverseuser.xhtml?editMode=CREATE	\N	:SignUpUrl
3	doi	\N	:Protocol
4	10.5072	\N	:Authority
5	FK2/	\N	:Shoulder
8	localhost-only	\N	:BlockedApiPolicy
9	native/http	\N	:UploadMethods
10	admin,test	\N	:BlockedApiEndpoints
11	noreply@dataverse.yourinstitution.edu	\N	:SystemEmail
12		\N	:GoogleAnalyticsCode
13	Your Institution	\N	:FooterCopyright
6	FAKE	\N	:DoiProvider
14	False	\N	:ShibEnabled
1	True	\N	:AllowSignUp
\.


--
-- Data for Name: shibgroup; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.shibgroup (id, attribute, name, pattern) FROM stdin;
\.


--
-- Data for Name: storagesite; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.storagesite (id, hostname, name, primarystorage, transferprotocols) FROM stdin;
\.


--
-- Data for Name: summarystatistic; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.summarystatistic (id, type, value, datavariable_id) FROM stdin;
\.


--
-- Data for Name: template; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.template (id, createtime, name, usagecount, dataverse_id, termsofuseandaccess_id) FROM stdin;
\.


--
-- Data for Name: termsofuseandaccess; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.termsofuseandaccess (id, availabilitystatus, citationrequirements, conditions, confidentialitydeclaration, contactforaccess, dataaccessplace, depositorrequirements, disclaimer, fileaccessrequest, license, originalarchive, restrictions, sizeofcollection, specialpermissions, studycompletion, termsofaccess, termsofuse) FROM stdin;
1	\N	\N	\N	\N	\N	\N	\N	\N	f	CC0	\N	\N	\N	\N	\N	\N	\N
2	\N	\N	\N	\N	\N	\N	\N	\N	f	CC0	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: usernotification; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.usernotification (id, emailed, objectid, readnotification, senddate, type, requestor_id, user_id) FROM stdin;
1	t	2	f	2020-10-05 13:16:27.218	2	\N	1
2	t	1	f	2020-10-05 13:22:43.559	3	\N	1
3	t	2	f	2020-10-05 13:37:54.419	3	\N	1
4	t	5	f	2020-10-05 13:37:55.923	19	\N	1
\.


--
-- Data for Name: vargroup; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.vargroup (id, label, filemetadata_id) FROM stdin;
\.


--
-- Data for Name: vargroup_datavariable; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.vargroup_datavariable (vargroup_id, varsingroup_id) FROM stdin;
\.


--
-- Data for Name: variablecategory; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.variablecategory (id, catorder, frequency, label, missing, value, datavariable_id) FROM stdin;
\.


--
-- Data for Name: variablemetadata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.variablemetadata (id, interviewinstruction, isweightvar, label, literalquestion, notes, postquestion, universe, weighted, datavariable_id, filemetadata_id, weightvariable_id) FROM stdin;
\.


--
-- Data for Name: variablerange; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.variablerange (id, beginvalue, beginvaluetype, endvalue, endvaluetype, datavariable_id) FROM stdin;
\.


--
-- Data for Name: variablerangeitem; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.variablerangeitem (id, value, datavariable_id) FROM stdin;
\.


--
-- Data for Name: workflow; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.workflow (id, name) FROM stdin;
\.


--
-- Data for Name: workflowcomment; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.workflowcomment (id, created, message, type, authenticateduser_id, datasetversion_id) FROM stdin;
\.


--
-- Data for Name: workflowstepdata; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.workflowstepdata (id, providerid, steptype, parent_id, index) FROM stdin;
\.


--
-- Data for Name: workflowstepdata_stepparameters; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.workflowstepdata_stepparameters (workflowstepdata_id, stepparameters, stepparameters_key) FROM stdin;
\.


--
-- Data for Name: workflowstepdata_stepsettings; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.workflowstepdata_stepsettings (workflowstepdata_id, stepsettings, stepsettings_key) FROM stdin;
\.


--
-- Data for Name: worldmapauth_token; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.worldmapauth_token (id, created, hasexpired, lastrefreshtime, modified, token, application_id, datafile_id, dataverseuser_id) FROM stdin;
\.


--
-- Data for Name: worldmapauth_tokentype; Type: TABLE DATA; Schema: public; Owner: dvnuser
--

COPY public.worldmapauth_tokentype (id, contactemail, created, hostname, ipaddress, mapitlink, md5, modified, name, timelimitminutes, timelimitseconds) FROM stdin;
1	support@dataverse.org	2020-10-05 10:46:07.619657	geoconnect.datascience.iq.harvard.edu	140.247.115.127	http://geoconnect.datascience.iq.harvard.edu/shapefile/map-it	38c0a931b2d582a5c43fc79405b30c22	2020-10-05 10:46:07.619657	GEOCONNECT	30	1800
\.


--
-- Name: alternativepersistentidentifier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.alternativepersistentidentifier_id_seq', 1, false);


--
-- Name: apitoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.apitoken_id_seq', 1, true);


--
-- Name: authenticateduser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.authenticateduser_id_seq', 1, true);


--
-- Name: authenticateduserlookup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.authenticateduserlookup_id_seq', 1, true);


--
-- Name: builtinuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.builtinuser_id_seq', 1, true);


--
-- Name: categorymetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.categorymetadata_id_seq', 1, false);


--
-- Name: clientharvestrun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.clientharvestrun_id_seq', 1, false);


--
-- Name: confirmemaildata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.confirmemaildata_id_seq', 1, true);


--
-- Name: controlledvocabalternate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.controlledvocabalternate_id_seq', 23, true);


--
-- Name: controlledvocabularyvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.controlledvocabularyvalue_id_seq', 829, true);


--
-- Name: customfieldmap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.customfieldmap_id_seq', 1, false);


--
-- Name: customquestion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.customquestion_id_seq', 1, false);


--
-- Name: customquestionresponse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.customquestionresponse_id_seq', 1, false);


--
-- Name: customquestionvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.customquestionvalue_id_seq', 1, false);


--
-- Name: datafilecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datafilecategory_id_seq', 1, false);


--
-- Name: datafiletag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datafiletag_id_seq', 1, false);


--
-- Name: datasetfield_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetfield_id_seq', 40, true);


--
-- Name: datasetfieldcompoundvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetfieldcompoundvalue_id_seq', 10, true);


--
-- Name: datasetfielddefaultvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetfielddefaultvalue_id_seq', 1, false);


--
-- Name: datasetfieldtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetfieldtype_id_seq', 155, true);


--
-- Name: datasetfieldvalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetfieldvalue_id_seq', 24, true);


--
-- Name: datasetidentifier_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetidentifier_seq', 1, false);


--
-- Name: datasetlinkingdataverse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetlinkingdataverse_id_seq', 1, false);


--
-- Name: datasetlock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetlock_id_seq', 3, true);


--
-- Name: datasetmetrics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetmetrics_id_seq', 1, false);


--
-- Name: datasetversion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetversion_id_seq', 2, true);


--
-- Name: datasetversionuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datasetversionuser_id_seq', 2, true);


--
-- Name: datatable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datatable_id_seq', 1, false);


--
-- Name: datavariable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.datavariable_id_seq', 1, false);


--
-- Name: dataversecontact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataversecontact_id_seq', 2, true);


--
-- Name: dataversefacet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataversefacet_id_seq', 4, true);


--
-- Name: dataversefeatureddataverse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataversefeatureddataverse_id_seq', 1, false);


--
-- Name: dataversefieldtypeinputlevel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataversefieldtypeinputlevel_id_seq', 1, false);


--
-- Name: dataverselinkingdataverse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataverselinkingdataverse_id_seq', 1, false);


--
-- Name: dataverserole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataverserole_id_seq', 8, true);


--
-- Name: dataversetheme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dataversetheme_id_seq', 1, false);


--
-- Name: defaultvalueset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.defaultvalueset_id_seq', 1, false);


--
-- Name: doidataciteregistercache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.doidataciteregistercache_id_seq', 1, false);


--
-- Name: dvobject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.dvobject_id_seq', 13, true);


--
-- Name: explicitgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.explicitgroup_id_seq', 1, false);


--
-- Name: externaltool_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.externaltool_id_seq', 20, true);


--
-- Name: filemetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.filemetadata_id_seq', 9, true);


--
-- Name: foreignmetadatafieldmapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.foreignmetadatafieldmapping_id_seq', 1, false);


--
-- Name: foreignmetadataformatmapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.foreignmetadataformatmapping_id_seq', 1, false);


--
-- Name: guestbook_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.guestbook_id_seq', 1, true);


--
-- Name: guestbookresponse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.guestbookresponse_id_seq', 1, false);


--
-- Name: harvestingclient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.harvestingclient_id_seq', 1, false);


--
-- Name: ingestreport_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.ingestreport_id_seq', 8, true);


--
-- Name: ingestrequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.ingestrequest_id_seq', 1, false);


--
-- Name: maplayermetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.maplayermetadata_id_seq', 1, false);


--
-- Name: metadatablock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.metadatablock_id_seq', 6, true);


--
-- Name: metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.metric_id_seq', 1, false);


--
-- Name: oairecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.oairecord_id_seq', 1, false);


--
-- Name: oaiset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.oaiset_id_seq', 1, false);


--
-- Name: oauth2tokendata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.oauth2tokendata_id_seq', 1, false);


--
-- Name: passwordresetdata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.passwordresetdata_id_seq', 1, false);


--
-- Name: roleassignment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.roleassignment_id_seq', 4, true);


--
-- Name: savedsearch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.savedsearch_id_seq', 1, false);


--
-- Name: savedsearchfilterquery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.savedsearchfilterquery_id_seq', 1, false);


--
-- Name: setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.setting_id_seq', 14, true);


--
-- Name: setting_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.setting_id_seq1', 1, false);


--
-- Name: shibgroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.shibgroup_id_seq', 1, false);


--
-- Name: storagesite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.storagesite_id_seq', 1, false);


--
-- Name: summarystatistic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.summarystatistic_id_seq', 1, false);


--
-- Name: template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.template_id_seq', 1, false);


--
-- Name: termsofuseandaccess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.termsofuseandaccess_id_seq', 2, true);


--
-- Name: usernotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.usernotification_id_seq', 4, true);


--
-- Name: vargroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.vargroup_id_seq', 1, false);


--
-- Name: variablecategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.variablecategory_id_seq', 1, false);


--
-- Name: variablemetadata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.variablemetadata_id_seq', 1, false);


--
-- Name: variablerange_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.variablerange_id_seq', 1, false);


--
-- Name: variablerangeitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.variablerangeitem_id_seq', 1, false);


--
-- Name: workflow_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.workflow_id_seq', 1, false);


--
-- Name: workflowcomment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.workflowcomment_id_seq', 1, false);


--
-- Name: workflowstepdata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.workflowstepdata_id_seq', 1, false);


--
-- Name: worldmapauth_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.worldmapauth_token_id_seq', 1, false);


--
-- Name: worldmapauth_tokentype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dvnuser
--

SELECT pg_catalog.setval('public.worldmapauth_tokentype_id_seq', 1, true);


--
-- Name: EJB__TIMER__TBL EJB__TIMER__TBL_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public."EJB__TIMER__TBL"
    ADD CONSTRAINT "EJB__TIMER__TBL_pkey" PRIMARY KEY ("TIMERID");


--
-- Name: actionlogrecord actionlogrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.actionlogrecord
    ADD CONSTRAINT actionlogrecord_pkey PRIMARY KEY (id);


--
-- Name: alternativepersistentidentifier alternativepersistentidentifier_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.alternativepersistentidentifier
    ADD CONSTRAINT alternativepersistentidentifier_pkey PRIMARY KEY (id);


--
-- Name: apitoken apitoken_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.apitoken
    ADD CONSTRAINT apitoken_pkey PRIMARY KEY (id);


--
-- Name: apitoken apitoken_tokenstring_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.apitoken
    ADD CONSTRAINT apitoken_tokenstring_key UNIQUE (tokenstring);


--
-- Name: authenticateduser authenticateduser_email_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduser
    ADD CONSTRAINT authenticateduser_email_key UNIQUE (email);


--
-- Name: authenticateduser authenticateduser_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduser
    ADD CONSTRAINT authenticateduser_pkey PRIMARY KEY (id);


--
-- Name: authenticateduser authenticateduser_useridentifier_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduser
    ADD CONSTRAINT authenticateduser_useridentifier_key UNIQUE (useridentifier);


--
-- Name: authenticateduserlookup authenticateduserlookup_authenticateduser_id_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduserlookup
    ADD CONSTRAINT authenticateduserlookup_authenticateduser_id_key UNIQUE (authenticateduser_id);


--
-- Name: authenticateduserlookup authenticateduserlookup_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduserlookup
    ADD CONSTRAINT authenticateduserlookup_pkey PRIMARY KEY (id);


--
-- Name: authenticationproviderrow authenticationproviderrow_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticationproviderrow
    ADD CONSTRAINT authenticationproviderrow_pkey PRIMARY KEY (id);


--
-- Name: builtinuser builtinuser_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.builtinuser
    ADD CONSTRAINT builtinuser_pkey PRIMARY KEY (id);


--
-- Name: builtinuser builtinuser_username_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.builtinuser
    ADD CONSTRAINT builtinuser_username_key UNIQUE (username);


--
-- Name: categorymetadata categorymetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.categorymetadata
    ADD CONSTRAINT categorymetadata_pkey PRIMARY KEY (id);


--
-- Name: clientharvestrun clientharvestrun_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.clientharvestrun
    ADD CONSTRAINT clientharvestrun_pkey PRIMARY KEY (id);


--
-- Name: confirmemaildata confirmemaildata_authenticateduser_id_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.confirmemaildata
    ADD CONSTRAINT confirmemaildata_authenticateduser_id_key UNIQUE (authenticateduser_id);


--
-- Name: confirmemaildata confirmemaildata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.confirmemaildata
    ADD CONSTRAINT confirmemaildata_pkey PRIMARY KEY (id);


--
-- Name: controlledvocabalternate controlledvocabalternate_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabalternate
    ADD CONSTRAINT controlledvocabalternate_pkey PRIMARY KEY (id);


--
-- Name: controlledvocabularyvalue controlledvocabularyvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabularyvalue
    ADD CONSTRAINT controlledvocabularyvalue_pkey PRIMARY KEY (id);


--
-- Name: customfieldmap customfieldmap_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customfieldmap
    ADD CONSTRAINT customfieldmap_pkey PRIMARY KEY (id);


--
-- Name: customquestion customquestion_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestion
    ADD CONSTRAINT customquestion_pkey PRIMARY KEY (id);


--
-- Name: customquestionresponse customquestionresponse_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionresponse
    ADD CONSTRAINT customquestionresponse_pkey PRIMARY KEY (id);


--
-- Name: customquestionvalue customquestionvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionvalue
    ADD CONSTRAINT customquestionvalue_pkey PRIMARY KEY (id);


--
-- Name: datafile datafile_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafile
    ADD CONSTRAINT datafile_pkey PRIMARY KEY (id);


--
-- Name: datafilecategory datafilecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafilecategory
    ADD CONSTRAINT datafilecategory_pkey PRIMARY KEY (id);


--
-- Name: datafiletag datafiletag_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafiletag
    ADD CONSTRAINT datafiletag_pkey PRIMARY KEY (id);


--
-- Name: dataset dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT dataset_pkey PRIMARY KEY (id);


--
-- Name: datasetexternalcitations datasetexternalcitations_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetexternalcitations
    ADD CONSTRAINT datasetexternalcitations_pkey PRIMARY KEY (id);


--
-- Name: datasetfield_controlledvocabularyvalue datasetfield_controlledvocabularyvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield_controlledvocabularyvalue
    ADD CONSTRAINT datasetfield_controlledvocabularyvalue_pkey PRIMARY KEY (datasetfield_id, controlledvocabularyvalues_id);


--
-- Name: datasetfield datasetfield_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield
    ADD CONSTRAINT datasetfield_pkey PRIMARY KEY (id);


--
-- Name: datasetfieldcompoundvalue datasetfieldcompoundvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldcompoundvalue
    ADD CONSTRAINT datasetfieldcompoundvalue_pkey PRIMARY KEY (id);


--
-- Name: datasetfielddefaultvalue datasetfielddefaultvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfielddefaultvalue
    ADD CONSTRAINT datasetfielddefaultvalue_pkey PRIMARY KEY (id);


--
-- Name: datasetfieldtype datasetfieldtype_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldtype
    ADD CONSTRAINT datasetfieldtype_pkey PRIMARY KEY (id);


--
-- Name: datasetfieldvalue datasetfieldvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldvalue
    ADD CONSTRAINT datasetfieldvalue_pkey PRIMARY KEY (id);


--
-- Name: datasetlinkingdataverse datasetlinkingdataverse_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlinkingdataverse
    ADD CONSTRAINT datasetlinkingdataverse_pkey PRIMARY KEY (id);


--
-- Name: datasetlock datasetlock_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlock
    ADD CONSTRAINT datasetlock_pkey PRIMARY KEY (id);


--
-- Name: datasetmetrics datasetmetrics_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetmetrics
    ADD CONSTRAINT datasetmetrics_pkey PRIMARY KEY (id);


--
-- Name: datasetversion datasetversion_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversion
    ADD CONSTRAINT datasetversion_pkey PRIMARY KEY (id);


--
-- Name: datasetversionuser datasetversionuser_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversionuser
    ADD CONSTRAINT datasetversionuser_pkey PRIMARY KEY (id);


--
-- Name: datatable datatable_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datatable
    ADD CONSTRAINT datatable_pkey PRIMARY KEY (id);


--
-- Name: datavariable datavariable_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datavariable
    ADD CONSTRAINT datavariable_pkey PRIMARY KEY (id);


--
-- Name: dataverse dataverse_alias_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse
    ADD CONSTRAINT dataverse_alias_key UNIQUE (alias);


--
-- Name: dataverse_citationdatasetfieldtypes dataverse_citationdatasetfieldtypes_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse_citationdatasetfieldtypes
    ADD CONSTRAINT dataverse_citationdatasetfieldtypes_pkey PRIMARY KEY (dataverse_id, citationdatasetfieldtype_id);


--
-- Name: dataverse_metadatablock dataverse_metadatablock_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse_metadatablock
    ADD CONSTRAINT dataverse_metadatablock_pkey PRIMARY KEY (dataverse_id, metadatablocks_id);


--
-- Name: dataverse dataverse_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse
    ADD CONSTRAINT dataverse_pkey PRIMARY KEY (id);


--
-- Name: dataversecontact dataversecontact_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversecontact
    ADD CONSTRAINT dataversecontact_pkey PRIMARY KEY (id);


--
-- Name: dataversefacet dataversefacet_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefacet
    ADD CONSTRAINT dataversefacet_pkey PRIMARY KEY (id);


--
-- Name: dataversefeatureddataverse dataversefeatureddataverse_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefeatureddataverse
    ADD CONSTRAINT dataversefeatureddataverse_pkey PRIMARY KEY (id);


--
-- Name: dataversefieldtypeinputlevel dataversefieldtypeinputlevel_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefieldtypeinputlevel
    ADD CONSTRAINT dataversefieldtypeinputlevel_pkey PRIMARY KEY (id);


--
-- Name: dataverselinkingdataverse dataverselinkingdataverse_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverselinkingdataverse
    ADD CONSTRAINT dataverselinkingdataverse_pkey PRIMARY KEY (id);


--
-- Name: dataverserole dataverserole_alias_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverserole
    ADD CONSTRAINT dataverserole_alias_key UNIQUE (alias);


--
-- Name: dataverserole dataverserole_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverserole
    ADD CONSTRAINT dataverserole_pkey PRIMARY KEY (id);


--
-- Name: dataversesubjects dataversesubjects_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversesubjects
    ADD CONSTRAINT dataversesubjects_pkey PRIMARY KEY (dataverse_id, controlledvocabularyvalue_id);


--
-- Name: dataversetheme dataversetheme_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversetheme
    ADD CONSTRAINT dataversetheme_pkey PRIMARY KEY (id);


--
-- Name: defaultvalueset defaultvalueset_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.defaultvalueset
    ADD CONSTRAINT defaultvalueset_pkey PRIMARY KEY (id);


--
-- Name: doidataciteregistercache doidataciteregistercache_doi_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.doidataciteregistercache
    ADD CONSTRAINT doidataciteregistercache_doi_key UNIQUE (doi);


--
-- Name: doidataciteregistercache doidataciteregistercache_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.doidataciteregistercache
    ADD CONSTRAINT doidataciteregistercache_pkey PRIMARY KEY (id);


--
-- Name: dvobject dvobject_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject
    ADD CONSTRAINT dvobject_pkey PRIMARY KEY (id);


--
-- Name: explicitgroup_authenticateduser explicitgroup_authenticateduser_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_authenticateduser
    ADD CONSTRAINT explicitgroup_authenticateduser_pkey PRIMARY KEY (explicitgroup_id, containedauthenticatedusers_id);


--
-- Name: explicitgroup_explicitgroup explicitgroup_explicitgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_explicitgroup
    ADD CONSTRAINT explicitgroup_explicitgroup_pkey PRIMARY KEY (explicitgroup_id, containedexplicitgroups_id);


--
-- Name: explicitgroup explicitgroup_groupalias_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup
    ADD CONSTRAINT explicitgroup_groupalias_key UNIQUE (groupalias);


--
-- Name: explicitgroup explicitgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup
    ADD CONSTRAINT explicitgroup_pkey PRIMARY KEY (id);


--
-- Name: externaltool externaltool_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.externaltool
    ADD CONSTRAINT externaltool_pkey PRIMARY KEY (id);


--
-- Name: fileaccessrequests fileaccessrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.fileaccessrequests
    ADD CONSTRAINT fileaccessrequests_pkey PRIMARY KEY (datafile_id, authenticated_user_id);


--
-- Name: filedownload filedownload_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filedownload
    ADD CONSTRAINT filedownload_pkey PRIMARY KEY (guestbookresponse_id);


--
-- Name: filemetadata_datafilecategory filemetadata_datafilecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata_datafilecategory
    ADD CONSTRAINT filemetadata_datafilecategory_pkey PRIMARY KEY (filecategories_id, filemetadatas_id);


--
-- Name: filemetadata filemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata
    ADD CONSTRAINT filemetadata_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: foreignmetadatafieldmapping foreignmetadatafieldmapping_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadatafieldmapping
    ADD CONSTRAINT foreignmetadatafieldmapping_pkey PRIMARY KEY (id);


--
-- Name: foreignmetadataformatmapping foreignmetadataformatmapping_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadataformatmapping
    ADD CONSTRAINT foreignmetadataformatmapping_pkey PRIMARY KEY (id);


--
-- Name: guestbook guestbook_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbook
    ADD CONSTRAINT guestbook_pkey PRIMARY KEY (id);


--
-- Name: guestbookresponse guestbookresponse_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse
    ADD CONSTRAINT guestbookresponse_pkey PRIMARY KEY (id);


--
-- Name: harvestingclient harvestingclient_name_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.harvestingclient
    ADD CONSTRAINT harvestingclient_name_key UNIQUE (name);


--
-- Name: harvestingclient harvestingclient_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.harvestingclient
    ADD CONSTRAINT harvestingclient_pkey PRIMARY KEY (id);


--
-- Name: harvestingdataverseconfig harvestingdataverseconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.harvestingdataverseconfig
    ADD CONSTRAINT harvestingdataverseconfig_pkey PRIMARY KEY (id);


--
-- Name: ingestreport ingestreport_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ingestreport
    ADD CONSTRAINT ingestreport_pkey PRIMARY KEY (id);


--
-- Name: ingestrequest ingestrequest_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ingestrequest
    ADD CONSTRAINT ingestrequest_pkey PRIMARY KEY (id);


--
-- Name: ipv4range ipv4range_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ipv4range
    ADD CONSTRAINT ipv4range_pkey PRIMARY KEY (id);


--
-- Name: ipv6range ipv6range_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ipv6range
    ADD CONSTRAINT ipv6range_pkey PRIMARY KEY (id);


--
-- Name: maplayermetadata maplayermetadata_datafile_id_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.maplayermetadata
    ADD CONSTRAINT maplayermetadata_datafile_id_key UNIQUE (datafile_id);


--
-- Name: maplayermetadata maplayermetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.maplayermetadata
    ADD CONSTRAINT maplayermetadata_pkey PRIMARY KEY (id);


--
-- Name: metadatablock metadatablock_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.metadatablock
    ADD CONSTRAINT metadatablock_pkey PRIMARY KEY (id);


--
-- Name: metric metric_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.metric
    ADD CONSTRAINT metric_pkey PRIMARY KEY (id);


--
-- Name: oairecord oairecord_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oairecord
    ADD CONSTRAINT oairecord_pkey PRIMARY KEY (id);


--
-- Name: oaiset oaiset_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oaiset
    ADD CONSTRAINT oaiset_pkey PRIMARY KEY (id);


--
-- Name: oauth2tokendata oauth2tokendata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oauth2tokendata
    ADD CONSTRAINT oauth2tokendata_pkey PRIMARY KEY (id);


--
-- Name: passwordresetdata passwordresetdata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.passwordresetdata
    ADD CONSTRAINT passwordresetdata_pkey PRIMARY KEY (id);


--
-- Name: pendingworkflowinvocation pendingworkflowinvocation_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.pendingworkflowinvocation
    ADD CONSTRAINT pendingworkflowinvocation_pkey PRIMARY KEY (invocationid);


--
-- Name: persistedglobalgroup persistedglobalgroup_persistedgroupalias_key; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.persistedglobalgroup
    ADD CONSTRAINT persistedglobalgroup_persistedgroupalias_key UNIQUE (persistedgroupalias);


--
-- Name: persistedglobalgroup persistedglobalgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.persistedglobalgroup
    ADD CONSTRAINT persistedglobalgroup_pkey PRIMARY KEY (id);


--
-- Name: roleassignment roleassignment_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.roleassignment
    ADD CONSTRAINT roleassignment_pkey PRIMARY KEY (id);


--
-- Name: savedsearch savedsearch_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearch
    ADD CONSTRAINT savedsearch_pkey PRIMARY KEY (id);


--
-- Name: savedsearchfilterquery savedsearchfilterquery_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearchfilterquery
    ADD CONSTRAINT savedsearchfilterquery_pkey PRIMARY KEY (id);


--
-- Name: sequence sequence_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.sequence
    ADD CONSTRAINT sequence_pkey PRIMARY KEY (seq_name);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (id);


--
-- Name: shibgroup shibgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.shibgroup
    ADD CONSTRAINT shibgroup_pkey PRIMARY KEY (id);


--
-- Name: storagesite storagesite_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.storagesite
    ADD CONSTRAINT storagesite_pkey PRIMARY KEY (id);


--
-- Name: summarystatistic summarystatistic_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.summarystatistic
    ADD CONSTRAINT summarystatistic_pkey PRIMARY KEY (id);


--
-- Name: template template_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT template_pkey PRIMARY KEY (id);


--
-- Name: termsofuseandaccess termsofuseandaccess_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.termsofuseandaccess
    ADD CONSTRAINT termsofuseandaccess_pkey PRIMARY KEY (id);


--
-- Name: authenticateduserlookup unq_authenticateduserlookup_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduserlookup
    ADD CONSTRAINT unq_authenticateduserlookup_0 UNIQUE (persistentuserid, authenticationproviderid);


--
-- Name: datasetversion unq_datasetversion_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversion
    ADD CONSTRAINT unq_datasetversion_0 UNIQUE (dataset_id, versionnumber, minorversionnumber);


--
-- Name: dataversefieldtypeinputlevel unq_dataversefieldtypeinputlevel_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefieldtypeinputlevel
    ADD CONSTRAINT unq_dataversefieldtypeinputlevel_0 UNIQUE (dataverse_id, datasetfieldtype_id);


--
-- Name: dvobject unq_dvobject_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject
    ADD CONSTRAINT unq_dvobject_0 UNIQUE (authority, protocol, identifier);


--
-- Name: dvobject unq_dvobject_1; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject
    ADD CONSTRAINT unq_dvobject_1 UNIQUE (owner_id, storageidentifier);


--
-- Name: foreignmetadatafieldmapping unq_foreignmetadatafieldmapping_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadatafieldmapping
    ADD CONSTRAINT unq_foreignmetadatafieldmapping_0 UNIQUE (foreignmetadataformatmapping_id, foreignfieldxpath);


--
-- Name: roleassignment unq_roleassignment_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.roleassignment
    ADD CONSTRAINT unq_roleassignment_0 UNIQUE (assigneeidentifier, role_id, definitionpoint_id);


--
-- Name: variablemetadata unq_variablemetadata_0; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablemetadata
    ADD CONSTRAINT unq_variablemetadata_0 UNIQUE (datavariable_id, filemetadata_id);


--
-- Name: usernotification usernotification_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.usernotification
    ADD CONSTRAINT usernotification_pkey PRIMARY KEY (id);


--
-- Name: vargroup_datavariable vargroup_datavariable_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.vargroup_datavariable
    ADD CONSTRAINT vargroup_datavariable_pkey PRIMARY KEY (vargroup_id, varsingroup_id);


--
-- Name: vargroup vargroup_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.vargroup
    ADD CONSTRAINT vargroup_pkey PRIMARY KEY (id);


--
-- Name: variablecategory variablecategory_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablecategory
    ADD CONSTRAINT variablecategory_pkey PRIMARY KEY (id);


--
-- Name: variablemetadata variablemetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablemetadata
    ADD CONSTRAINT variablemetadata_pkey PRIMARY KEY (id);


--
-- Name: variablerange variablerange_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablerange
    ADD CONSTRAINT variablerange_pkey PRIMARY KEY (id);


--
-- Name: variablerangeitem variablerangeitem_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablerangeitem
    ADD CONSTRAINT variablerangeitem_pkey PRIMARY KEY (id);


--
-- Name: workflow workflow_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflow
    ADD CONSTRAINT workflow_pkey PRIMARY KEY (id);


--
-- Name: workflowcomment workflowcomment_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowcomment
    ADD CONSTRAINT workflowcomment_pkey PRIMARY KEY (id);


--
-- Name: workflowstepdata workflowstepdata_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowstepdata
    ADD CONSTRAINT workflowstepdata_pkey PRIMARY KEY (id);


--
-- Name: worldmapauth_token worldmapauth_token_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_token
    ADD CONSTRAINT worldmapauth_token_pkey PRIMARY KEY (id);


--
-- Name: worldmapauth_tokentype worldmapauth_tokentype_pkey; Type: CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_tokentype
    ADD CONSTRAINT worldmapauth_tokentype_pkey PRIMARY KEY (id);


--
-- Name: application_name; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX application_name ON public.worldmapauth_tokentype USING btree (name);


--
-- Name: dataverse_alias_unique_idx; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX dataverse_alias_unique_idx ON public.dataverse USING btree (lower((alias)::text));


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: index_actionlogrecord_actiontype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_actionlogrecord_actiontype ON public.actionlogrecord USING btree (actiontype);


--
-- Name: index_actionlogrecord_starttime; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_actionlogrecord_starttime ON public.actionlogrecord USING btree (starttime);


--
-- Name: index_actionlogrecord_useridentifier; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_actionlogrecord_useridentifier ON public.actionlogrecord USING btree (useridentifier);


--
-- Name: index_apitoken_authenticateduser_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_apitoken_authenticateduser_id ON public.apitoken USING btree (authenticateduser_id);


--
-- Name: index_authenticateduser_lower_email; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX index_authenticateduser_lower_email ON public.authenticateduser USING btree (lower((email)::text));


--
-- Name: index_authenticateduser_lower_useridentifier; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX index_authenticateduser_lower_useridentifier ON public.authenticateduser USING btree (lower((useridentifier)::text));


--
-- Name: index_authenticationproviderrow_enabled; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_authenticationproviderrow_enabled ON public.authenticationproviderrow USING btree (enabled);


--
-- Name: index_builtinuser_username; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_builtinuser_username ON public.builtinuser USING btree (username);


--
-- Name: index_categorymetadata_category_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_categorymetadata_category_id ON public.categorymetadata USING btree (category_id);


--
-- Name: index_categorymetadata_variablemetadata_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_categorymetadata_variablemetadata_id ON public.categorymetadata USING btree (variablemetadata_id);


--
-- Name: index_confirmemaildata_authenticateduser_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_confirmemaildata_authenticateduser_id ON public.confirmemaildata USING btree (authenticateduser_id);


--
-- Name: index_confirmemaildata_token; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_confirmemaildata_token ON public.confirmemaildata USING btree (token);


--
-- Name: index_controlledvocabalternate_controlledvocabularyvalue_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_controlledvocabalternate_controlledvocabularyvalue_id ON public.controlledvocabalternate USING btree (controlledvocabularyvalue_id);


--
-- Name: index_controlledvocabalternate_datasetfieldtype_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_controlledvocabalternate_datasetfieldtype_id ON public.controlledvocabalternate USING btree (datasetfieldtype_id);


--
-- Name: index_controlledvocabularyvalue_datasetfieldtype_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_controlledvocabularyvalue_datasetfieldtype_id ON public.controlledvocabularyvalue USING btree (datasetfieldtype_id);


--
-- Name: index_controlledvocabularyvalue_displayorder; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_controlledvocabularyvalue_displayorder ON public.controlledvocabularyvalue USING btree (displayorder);


--
-- Name: index_customfieldmap_sourcedatasetfield; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_customfieldmap_sourcedatasetfield ON public.customfieldmap USING btree (sourcedatasetfield);


--
-- Name: index_customfieldmap_sourcetemplate; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_customfieldmap_sourcetemplate ON public.customfieldmap USING btree (sourcetemplate);


--
-- Name: index_customquestion_guestbook_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_customquestion_guestbook_id ON public.customquestion USING btree (guestbook_id);


--
-- Name: index_customquestionresponse_guestbookresponse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_customquestionresponse_guestbookresponse_id ON public.customquestionresponse USING btree (guestbookresponse_id);


--
-- Name: index_datafile_checksumvalue; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datafile_checksumvalue ON public.datafile USING btree (checksumvalue);


--
-- Name: index_datafile_contenttype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datafile_contenttype ON public.datafile USING btree (contenttype);


--
-- Name: index_datafile_ingeststatus; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datafile_ingeststatus ON public.datafile USING btree (ingeststatus);


--
-- Name: index_datafile_restricted; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datafile_restricted ON public.datafile USING btree (restricted);


--
-- Name: index_datafilecategory_dataset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datafilecategory_dataset_id ON public.datafilecategory USING btree (dataset_id);


--
-- Name: index_datafiletag_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datafiletag_datafile_id ON public.datafiletag USING btree (datafile_id);


--
-- Name: index_dataset_guestbook_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataset_guestbook_id ON public.dataset USING btree (guestbook_id);


--
-- Name: index_dataset_thumbnailfile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataset_thumbnailfile_id ON public.dataset USING btree (thumbnailfile_id);


--
-- Name: index_datasetfield_controlledvocabularyvalue_controlledvocabula; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfield_controlledvocabularyvalue_controlledvocabula ON public.datasetfield_controlledvocabularyvalue USING btree (controlledvocabularyvalues_id);


--
-- Name: index_datasetfield_controlledvocabularyvalue_datasetfield_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfield_controlledvocabularyvalue_datasetfield_id ON public.datasetfield_controlledvocabularyvalue USING btree (datasetfield_id);


--
-- Name: index_datasetfield_datasetfieldtype_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfield_datasetfieldtype_id ON public.datasetfield USING btree (datasetfieldtype_id);


--
-- Name: index_datasetfield_datasetversion_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfield_datasetversion_id ON public.datasetfield USING btree (datasetversion_id);


--
-- Name: index_datasetfield_parentdatasetfieldcompoundvalue_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfield_parentdatasetfieldcompoundvalue_id ON public.datasetfield USING btree (parentdatasetfieldcompoundvalue_id);


--
-- Name: index_datasetfield_template_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfield_template_id ON public.datasetfield USING btree (template_id);


--
-- Name: index_datasetfieldcompoundvalue_parentdatasetfield_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfieldcompoundvalue_parentdatasetfield_id ON public.datasetfieldcompoundvalue USING btree (parentdatasetfield_id);


--
-- Name: index_datasetfielddefaultvalue_datasetfield_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfielddefaultvalue_datasetfield_id ON public.datasetfielddefaultvalue USING btree (datasetfield_id);


--
-- Name: index_datasetfielddefaultvalue_defaultvalueset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfielddefaultvalue_defaultvalueset_id ON public.datasetfielddefaultvalue USING btree (defaultvalueset_id);


--
-- Name: index_datasetfielddefaultvalue_displayorder; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfielddefaultvalue_displayorder ON public.datasetfielddefaultvalue USING btree (displayorder);


--
-- Name: index_datasetfielddefaultvalue_parentdatasetfielddefaultvalue_i; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfielddefaultvalue_parentdatasetfielddefaultvalue_i ON public.datasetfielddefaultvalue USING btree (parentdatasetfielddefaultvalue_id);


--
-- Name: index_datasetfieldtype_metadatablock_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfieldtype_metadatablock_id ON public.datasetfieldtype USING btree (metadatablock_id);


--
-- Name: index_datasetfieldtype_parentdatasetfieldtype_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfieldtype_parentdatasetfieldtype_id ON public.datasetfieldtype USING btree (parentdatasetfieldtype_id);


--
-- Name: index_datasetfieldvalue_datasetfield_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetfieldvalue_datasetfield_id ON public.datasetfieldvalue USING btree (datasetfield_id);


--
-- Name: index_datasetlinkingdataverse_dataset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetlinkingdataverse_dataset_id ON public.datasetlinkingdataverse USING btree (dataset_id);


--
-- Name: index_datasetlinkingdataverse_linkingdataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetlinkingdataverse_linkingdataverse_id ON public.datasetlinkingdataverse USING btree (linkingdataverse_id);


--
-- Name: index_datasetlock_dataset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetlock_dataset_id ON public.datasetlock USING btree (dataset_id);


--
-- Name: index_datasetlock_user_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetlock_user_id ON public.datasetlock USING btree (user_id);


--
-- Name: index_datasetversion_dataset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetversion_dataset_id ON public.datasetversion USING btree (dataset_id);


--
-- Name: index_datasetversionuser_authenticateduser_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetversionuser_authenticateduser_id ON public.datasetversionuser USING btree (authenticateduser_id);


--
-- Name: index_datasetversionuser_datasetversion_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datasetversionuser_datasetversion_id ON public.datasetversionuser USING btree (datasetversion_id);


--
-- Name: index_datatable_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datatable_datafile_id ON public.datatable USING btree (datafile_id);


--
-- Name: index_datavariable_datatable_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_datavariable_datatable_id ON public.datavariable USING btree (datatable_id);


--
-- Name: index_dataverse_affiliation; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_affiliation ON public.dataverse USING btree (affiliation);


--
-- Name: index_dataverse_alias; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_alias ON public.dataverse USING btree (alias);


--
-- Name: index_dataverse_dataversetype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_dataversetype ON public.dataverse USING btree (dataversetype);


--
-- Name: index_dataverse_defaultcontributorrole_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_defaultcontributorrole_id ON public.dataverse USING btree (defaultcontributorrole_id);


--
-- Name: index_dataverse_defaulttemplate_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_defaulttemplate_id ON public.dataverse USING btree (defaulttemplate_id);


--
-- Name: index_dataverse_facetroot; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_facetroot ON public.dataverse USING btree (facetroot);


--
-- Name: index_dataverse_guestbookroot; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_guestbookroot ON public.dataverse USING btree (guestbookroot);


--
-- Name: index_dataverse_metadatablockroot; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_metadatablockroot ON public.dataverse USING btree (metadatablockroot);


--
-- Name: index_dataverse_permissionroot; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_permissionroot ON public.dataverse USING btree (permissionroot);


--
-- Name: index_dataverse_templateroot; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_templateroot ON public.dataverse USING btree (templateroot);


--
-- Name: index_dataverse_themeroot; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverse_themeroot ON public.dataverse USING btree (themeroot);


--
-- Name: index_dataversecontact_contactemail; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversecontact_contactemail ON public.dataversecontact USING btree (contactemail);


--
-- Name: index_dataversecontact_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversecontact_dataverse_id ON public.dataversecontact USING btree (dataverse_id);


--
-- Name: index_dataversecontact_displayorder; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversecontact_displayorder ON public.dataversecontact USING btree (displayorder);


--
-- Name: index_dataversefacet_datasetfieldtype_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefacet_datasetfieldtype_id ON public.dataversefacet USING btree (datasetfieldtype_id);


--
-- Name: index_dataversefacet_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefacet_dataverse_id ON public.dataversefacet USING btree (dataverse_id);


--
-- Name: index_dataversefacet_displayorder; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefacet_displayorder ON public.dataversefacet USING btree (displayorder);


--
-- Name: index_dataversefeatureddataverse_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefeatureddataverse_dataverse_id ON public.dataversefeatureddataverse USING btree (dataverse_id);


--
-- Name: index_dataversefeatureddataverse_displayorder; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefeatureddataverse_displayorder ON public.dataversefeatureddataverse USING btree (displayorder);


--
-- Name: index_dataversefeatureddataverse_featureddataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefeatureddataverse_featureddataverse_id ON public.dataversefeatureddataverse USING btree (featureddataverse_id);


--
-- Name: index_dataversefieldtypeinputlevel_datasetfieldtype_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefieldtypeinputlevel_datasetfieldtype_id ON public.dataversefieldtypeinputlevel USING btree (datasetfieldtype_id);


--
-- Name: index_dataversefieldtypeinputlevel_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefieldtypeinputlevel_dataverse_id ON public.dataversefieldtypeinputlevel USING btree (dataverse_id);


--
-- Name: index_dataversefieldtypeinputlevel_required; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversefieldtypeinputlevel_required ON public.dataversefieldtypeinputlevel USING btree (required);


--
-- Name: index_dataverselinkingdataverse_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverselinkingdataverse_dataverse_id ON public.dataverselinkingdataverse USING btree (dataverse_id);


--
-- Name: index_dataverselinkingdataverse_linkingdataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverselinkingdataverse_linkingdataverse_id ON public.dataverselinkingdataverse USING btree (linkingdataverse_id);


--
-- Name: index_dataverserole_alias; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverserole_alias ON public.dataverserole USING btree (alias);


--
-- Name: index_dataverserole_name; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverserole_name ON public.dataverserole USING btree (name);


--
-- Name: index_dataverserole_owner_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataverserole_owner_id ON public.dataverserole USING btree (owner_id);


--
-- Name: index_dataversetheme_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dataversetheme_dataverse_id ON public.dataversetheme USING btree (dataverse_id);


--
-- Name: index_dvobject_creator_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dvobject_creator_id ON public.dvobject USING btree (creator_id);


--
-- Name: index_dvobject_dtype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dvobject_dtype ON public.dvobject USING btree (dtype);


--
-- Name: index_dvobject_owner_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dvobject_owner_id ON public.dvobject USING btree (owner_id);


--
-- Name: index_dvobject_releaseuser_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_dvobject_releaseuser_id ON public.dvobject USING btree (releaseuser_id);


--
-- Name: index_explicitgroup_groupaliasinowner; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_explicitgroup_groupaliasinowner ON public.explicitgroup USING btree (groupaliasinowner);


--
-- Name: index_explicitgroup_owner_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_explicitgroup_owner_id ON public.explicitgroup USING btree (owner_id);


--
-- Name: index_filemetadata_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_filemetadata_datafile_id ON public.filemetadata USING btree (datafile_id);


--
-- Name: index_filemetadata_datafilecategory_filecategories_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_filemetadata_datafilecategory_filecategories_id ON public.filemetadata_datafilecategory USING btree (filecategories_id);


--
-- Name: index_filemetadata_datafilecategory_filemetadatas_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_filemetadata_datafilecategory_filemetadatas_id ON public.filemetadata_datafilecategory USING btree (filemetadatas_id);


--
-- Name: index_filemetadata_datasetversion_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_filemetadata_datasetversion_id ON public.filemetadata USING btree (datasetversion_id);


--
-- Name: index_foreignmetadatafieldmapping_foreignfieldxpath; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_foreignmetadatafieldmapping_foreignfieldxpath ON public.foreignmetadatafieldmapping USING btree (foreignfieldxpath);


--
-- Name: index_foreignmetadatafieldmapping_foreignmetadataformatmapping_; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_foreignmetadatafieldmapping_foreignmetadataformatmapping_ ON public.foreignmetadatafieldmapping USING btree (foreignmetadataformatmapping_id);


--
-- Name: index_foreignmetadatafieldmapping_parentfieldmapping_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_foreignmetadatafieldmapping_parentfieldmapping_id ON public.foreignmetadatafieldmapping USING btree (parentfieldmapping_id);


--
-- Name: index_foreignmetadataformatmapping_name; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_foreignmetadataformatmapping_name ON public.foreignmetadataformatmapping USING btree (name);


--
-- Name: index_guestbookresponse_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_guestbookresponse_datafile_id ON public.guestbookresponse USING btree (datafile_id);


--
-- Name: index_guestbookresponse_dataset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_guestbookresponse_dataset_id ON public.guestbookresponse USING btree (dataset_id);


--
-- Name: index_guestbookresponse_guestbook_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_guestbookresponse_guestbook_id ON public.guestbookresponse USING btree (guestbook_id);


--
-- Name: index_harvestingclient_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingclient_dataverse_id ON public.harvestingclient USING btree (dataverse_id);


--
-- Name: index_harvestingclient_harvestingurl; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingclient_harvestingurl ON public.harvestingclient USING btree (harvestingurl);


--
-- Name: index_harvestingclient_harveststyle; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingclient_harveststyle ON public.harvestingclient USING btree (harveststyle);


--
-- Name: index_harvestingclient_harvesttype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingclient_harvesttype ON public.harvestingclient USING btree (harvesttype);


--
-- Name: index_harvestingdataverseconfig_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingdataverseconfig_dataverse_id ON public.harvestingdataverseconfig USING btree (dataverse_id);


--
-- Name: index_harvestingdataverseconfig_harvestingurl; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingdataverseconfig_harvestingurl ON public.harvestingdataverseconfig USING btree (harvestingurl);


--
-- Name: index_harvestingdataverseconfig_harveststyle; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingdataverseconfig_harveststyle ON public.harvestingdataverseconfig USING btree (harveststyle);


--
-- Name: index_harvestingdataverseconfig_harvesttype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_harvestingdataverseconfig_harvesttype ON public.harvestingdataverseconfig USING btree (harvesttype);


--
-- Name: index_ingestreport_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_ingestreport_datafile_id ON public.ingestreport USING btree (datafile_id);


--
-- Name: index_ingestrequest_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_ingestrequest_datafile_id ON public.ingestrequest USING btree (datafile_id);


--
-- Name: index_ipv4range_owner_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_ipv4range_owner_id ON public.ipv4range USING btree (owner_id);


--
-- Name: index_ipv6range_owner_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_ipv6range_owner_id ON public.ipv6range USING btree (owner_id);


--
-- Name: index_maplayermetadata_dataset_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_maplayermetadata_dataset_id ON public.maplayermetadata USING btree (dataset_id);


--
-- Name: index_metadatablock_name; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_metadatablock_name ON public.metadatablock USING btree (name);


--
-- Name: index_metadatablock_owner_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_metadatablock_owner_id ON public.metadatablock USING btree (owner_id);


--
-- Name: index_metric_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_metric_id ON public.metric USING btree (id);


--
-- Name: index_passwordresetdata_builtinuser_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_passwordresetdata_builtinuser_id ON public.passwordresetdata USING btree (builtinuser_id);


--
-- Name: index_passwordresetdata_token; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_passwordresetdata_token ON public.passwordresetdata USING btree (token);


--
-- Name: index_persistedglobalgroup_dtype; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_persistedglobalgroup_dtype ON public.persistedglobalgroup USING btree (dtype);


--
-- Name: index_roleassignment_assigneeidentifier; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_roleassignment_assigneeidentifier ON public.roleassignment USING btree (assigneeidentifier);


--
-- Name: index_roleassignment_definitionpoint_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_roleassignment_definitionpoint_id ON public.roleassignment USING btree (definitionpoint_id);


--
-- Name: index_roleassignment_role_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_roleassignment_role_id ON public.roleassignment USING btree (role_id);


--
-- Name: index_savedsearch_creator_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_savedsearch_creator_id ON public.savedsearch USING btree (creator_id);


--
-- Name: index_savedsearch_definitionpoint_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_savedsearch_definitionpoint_id ON public.savedsearch USING btree (definitionpoint_id);


--
-- Name: index_savedsearchfilterquery_savedsearch_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_savedsearchfilterquery_savedsearch_id ON public.savedsearchfilterquery USING btree (savedsearch_id);


--
-- Name: index_summarystatistic_datavariable_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_summarystatistic_datavariable_id ON public.summarystatistic USING btree (datavariable_id);


--
-- Name: index_template_dataverse_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_template_dataverse_id ON public.template USING btree (dataverse_id);


--
-- Name: index_usernotification_user_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_usernotification_user_id ON public.usernotification USING btree (user_id);


--
-- Name: index_vargroup_filemetadata_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_vargroup_filemetadata_id ON public.vargroup USING btree (filemetadata_id);


--
-- Name: index_variablecategory_datavariable_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_variablecategory_datavariable_id ON public.variablecategory USING btree (datavariable_id);


--
-- Name: index_variablemetadata_datavariable_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_variablemetadata_datavariable_id ON public.variablemetadata USING btree (datavariable_id);


--
-- Name: index_variablemetadata_datavariable_id_filemetadata_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_variablemetadata_datavariable_id_filemetadata_id ON public.variablemetadata USING btree (datavariable_id, filemetadata_id);


--
-- Name: index_variablemetadata_filemetadata_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_variablemetadata_filemetadata_id ON public.variablemetadata USING btree (filemetadata_id);


--
-- Name: index_variablerange_datavariable_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_variablerange_datavariable_id ON public.variablerange USING btree (datavariable_id);


--
-- Name: index_variablerangeitem_datavariable_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_variablerangeitem_datavariable_id ON public.variablerangeitem USING btree (datavariable_id);


--
-- Name: index_worldmapauth_token_application_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_worldmapauth_token_application_id ON public.worldmapauth_token USING btree (application_id);


--
-- Name: index_worldmapauth_token_datafile_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_worldmapauth_token_datafile_id ON public.worldmapauth_token USING btree (datafile_id);


--
-- Name: index_worldmapauth_token_dataverseuser_id; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE INDEX index_worldmapauth_token_dataverseuser_id ON public.worldmapauth_token USING btree (dataverseuser_id);


--
-- Name: one_draft_version_per_dataset; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX one_draft_version_per_dataset ON public.datasetversion USING btree (dataset_id) WHERE ((versionstate)::text = 'DRAFT'::text);


--
-- Name: token_value; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX token_value ON public.worldmapauth_token USING btree (token);


--
-- Name: unique_settings; Type: INDEX; Schema: public; Owner: dvnuser
--

CREATE UNIQUE INDEX unique_settings ON public.setting USING btree (name, COALESCE(lang, ''::text));


--
-- Name: dataverse_citationdatasetfieldtypes dataverse_citationdatasetfieldtypes_citationdatasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse_citationdatasetfieldtypes
    ADD CONSTRAINT dataverse_citationdatasetfieldtypes_citationdatasetfieldtype_id FOREIGN KEY (citationdatasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: datasetfield_controlledvocabularyvalue dtasetfieldcontrolledvocabularyvaluecntrolledvocabularyvaluesid; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield_controlledvocabularyvalue
    ADD CONSTRAINT dtasetfieldcontrolledvocabularyvaluecntrolledvocabularyvaluesid FOREIGN KEY (controlledvocabularyvalues_id) REFERENCES public.controlledvocabularyvalue(id);


--
-- Name: explicitgroup_authenticateduser explicitgroup_authenticateduser_containedauthenticatedusers_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_authenticateduser
    ADD CONSTRAINT explicitgroup_authenticateduser_containedauthenticatedusers_id FOREIGN KEY (containedauthenticatedusers_id) REFERENCES public.authenticateduser(id);


--
-- Name: alternativepersistentidentifier fk_alternativepersistentidentifier_dvobject_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.alternativepersistentidentifier
    ADD CONSTRAINT fk_alternativepersistentidentifier_dvobject_id FOREIGN KEY (dvobject_id) REFERENCES public.dvobject(id);


--
-- Name: apitoken fk_apitoken_authenticateduser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.apitoken
    ADD CONSTRAINT fk_apitoken_authenticateduser_id FOREIGN KEY (authenticateduser_id) REFERENCES public.authenticateduser(id);


--
-- Name: authenticateduserlookup fk_authenticateduserlookup_authenticateduser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.authenticateduserlookup
    ADD CONSTRAINT fk_authenticateduserlookup_authenticateduser_id FOREIGN KEY (authenticateduser_id) REFERENCES public.authenticateduser(id);


--
-- Name: categorymetadata fk_categorymetadata_category_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.categorymetadata
    ADD CONSTRAINT fk_categorymetadata_category_id FOREIGN KEY (category_id) REFERENCES public.variablecategory(id);


--
-- Name: categorymetadata fk_categorymetadata_variablemetadata_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.categorymetadata
    ADD CONSTRAINT fk_categorymetadata_variablemetadata_id FOREIGN KEY (variablemetadata_id) REFERENCES public.variablemetadata(id);


--
-- Name: clientharvestrun fk_clientharvestrun_harvestingclient_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.clientharvestrun
    ADD CONSTRAINT fk_clientharvestrun_harvestingclient_id FOREIGN KEY (harvestingclient_id) REFERENCES public.harvestingclient(id);


--
-- Name: confirmemaildata fk_confirmemaildata_authenticateduser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.confirmemaildata
    ADD CONSTRAINT fk_confirmemaildata_authenticateduser_id FOREIGN KEY (authenticateduser_id) REFERENCES public.authenticateduser(id);


--
-- Name: controlledvocabalternate fk_controlledvocabalternate_controlledvocabularyvalue_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabalternate
    ADD CONSTRAINT fk_controlledvocabalternate_controlledvocabularyvalue_id FOREIGN KEY (controlledvocabularyvalue_id) REFERENCES public.controlledvocabularyvalue(id);


--
-- Name: controlledvocabalternate fk_controlledvocabalternate_datasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabalternate
    ADD CONSTRAINT fk_controlledvocabalternate_datasetfieldtype_id FOREIGN KEY (datasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: controlledvocabularyvalue fk_controlledvocabularyvalue_datasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.controlledvocabularyvalue
    ADD CONSTRAINT fk_controlledvocabularyvalue_datasetfieldtype_id FOREIGN KEY (datasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: customquestion fk_customquestion_guestbook_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestion
    ADD CONSTRAINT fk_customquestion_guestbook_id FOREIGN KEY (guestbook_id) REFERENCES public.guestbook(id);


--
-- Name: customquestionresponse fk_customquestionresponse_customquestion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionresponse
    ADD CONSTRAINT fk_customquestionresponse_customquestion_id FOREIGN KEY (customquestion_id) REFERENCES public.customquestion(id);


--
-- Name: customquestionresponse fk_customquestionresponse_guestbookresponse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionresponse
    ADD CONSTRAINT fk_customquestionresponse_guestbookresponse_id FOREIGN KEY (guestbookresponse_id) REFERENCES public.guestbookresponse(id);


--
-- Name: customquestionvalue fk_customquestionvalue_customquestion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.customquestionvalue
    ADD CONSTRAINT fk_customquestionvalue_customquestion_id FOREIGN KEY (customquestion_id) REFERENCES public.customquestion(id);


--
-- Name: datafile fk_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafile
    ADD CONSTRAINT fk_datafile_id FOREIGN KEY (id) REFERENCES public.dvobject(id);


--
-- Name: datafilecategory fk_datafilecategory_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafilecategory
    ADD CONSTRAINT fk_datafilecategory_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: datafiletag fk_datafiletag_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datafiletag
    ADD CONSTRAINT fk_datafiletag_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: dataset fk_dataset_citationdatedatasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_citationdatedatasetfieldtype_id FOREIGN KEY (citationdatedatasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: dataset fk_dataset_guestbook_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_guestbook_id FOREIGN KEY (guestbook_id) REFERENCES public.guestbook(id);


--
-- Name: dataset fk_dataset_harvestingclient_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_harvestingclient_id FOREIGN KEY (harvestingclient_id) REFERENCES public.harvestingclient(id);


--
-- Name: dataset fk_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_id FOREIGN KEY (id) REFERENCES public.dvobject(id);


--
-- Name: dataset fk_dataset_thumbnailfile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT fk_dataset_thumbnailfile_id FOREIGN KEY (thumbnailfile_id) REFERENCES public.dvobject(id);


--
-- Name: datasetexternalcitations fk_datasetexternalcitations_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetexternalcitations
    ADD CONSTRAINT fk_datasetexternalcitations_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: datasetfield_controlledvocabularyvalue fk_datasetfield_controlledvocabularyvalue_datasetfield_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield_controlledvocabularyvalue
    ADD CONSTRAINT fk_datasetfield_controlledvocabularyvalue_datasetfield_id FOREIGN KEY (datasetfield_id) REFERENCES public.datasetfield(id);


--
-- Name: datasetfield fk_datasetfield_datasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield
    ADD CONSTRAINT fk_datasetfield_datasetfieldtype_id FOREIGN KEY (datasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: datasetfield fk_datasetfield_datasetversion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield
    ADD CONSTRAINT fk_datasetfield_datasetversion_id FOREIGN KEY (datasetversion_id) REFERENCES public.datasetversion(id);


--
-- Name: datasetfield fk_datasetfield_parentdatasetfieldcompoundvalue_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield
    ADD CONSTRAINT fk_datasetfield_parentdatasetfieldcompoundvalue_id FOREIGN KEY (parentdatasetfieldcompoundvalue_id) REFERENCES public.datasetfieldcompoundvalue(id);


--
-- Name: datasetfield fk_datasetfield_template_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfield
    ADD CONSTRAINT fk_datasetfield_template_id FOREIGN KEY (template_id) REFERENCES public.template(id);


--
-- Name: datasetfieldcompoundvalue fk_datasetfieldcompoundvalue_parentdatasetfield_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldcompoundvalue
    ADD CONSTRAINT fk_datasetfieldcompoundvalue_parentdatasetfield_id FOREIGN KEY (parentdatasetfield_id) REFERENCES public.datasetfield(id);


--
-- Name: datasetfielddefaultvalue fk_datasetfielddefaultvalue_datasetfield_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfielddefaultvalue
    ADD CONSTRAINT fk_datasetfielddefaultvalue_datasetfield_id FOREIGN KEY (datasetfield_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: datasetfielddefaultvalue fk_datasetfielddefaultvalue_defaultvalueset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfielddefaultvalue
    ADD CONSTRAINT fk_datasetfielddefaultvalue_defaultvalueset_id FOREIGN KEY (defaultvalueset_id) REFERENCES public.defaultvalueset(id);


--
-- Name: datasetfielddefaultvalue fk_datasetfielddefaultvalue_parentdatasetfielddefaultvalue_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfielddefaultvalue
    ADD CONSTRAINT fk_datasetfielddefaultvalue_parentdatasetfielddefaultvalue_id FOREIGN KEY (parentdatasetfielddefaultvalue_id) REFERENCES public.datasetfielddefaultvalue(id);


--
-- Name: datasetfieldtype fk_datasetfieldtype_metadatablock_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldtype
    ADD CONSTRAINT fk_datasetfieldtype_metadatablock_id FOREIGN KEY (metadatablock_id) REFERENCES public.metadatablock(id);


--
-- Name: datasetfieldtype fk_datasetfieldtype_parentdatasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldtype
    ADD CONSTRAINT fk_datasetfieldtype_parentdatasetfieldtype_id FOREIGN KEY (parentdatasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: datasetfieldvalue fk_datasetfieldvalue_datasetfield_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetfieldvalue
    ADD CONSTRAINT fk_datasetfieldvalue_datasetfield_id FOREIGN KEY (datasetfield_id) REFERENCES public.datasetfield(id);


--
-- Name: datasetlinkingdataverse fk_datasetlinkingdataverse_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlinkingdataverse
    ADD CONSTRAINT fk_datasetlinkingdataverse_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: datasetlinkingdataverse fk_datasetlinkingdataverse_linkingdataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlinkingdataverse
    ADD CONSTRAINT fk_datasetlinkingdataverse_linkingdataverse_id FOREIGN KEY (linkingdataverse_id) REFERENCES public.dvobject(id);


--
-- Name: datasetlock fk_datasetlock_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlock
    ADD CONSTRAINT fk_datasetlock_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: datasetlock fk_datasetlock_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetlock
    ADD CONSTRAINT fk_datasetlock_user_id FOREIGN KEY (user_id) REFERENCES public.authenticateduser(id);


--
-- Name: datasetmetrics fk_datasetmetrics_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetmetrics
    ADD CONSTRAINT fk_datasetmetrics_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: datasetversion fk_datasetversion_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversion
    ADD CONSTRAINT fk_datasetversion_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: datasetversion fk_datasetversion_termsofuseandaccess_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversion
    ADD CONSTRAINT fk_datasetversion_termsofuseandaccess_id FOREIGN KEY (termsofuseandaccess_id) REFERENCES public.termsofuseandaccess(id);


--
-- Name: datasetversionuser fk_datasetversionuser_authenticateduser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversionuser
    ADD CONSTRAINT fk_datasetversionuser_authenticateduser_id FOREIGN KEY (authenticateduser_id) REFERENCES public.authenticateduser(id);


--
-- Name: datasetversionuser fk_datasetversionuser_datasetversion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datasetversionuser
    ADD CONSTRAINT fk_datasetversionuser_datasetversion_id FOREIGN KEY (datasetversion_id) REFERENCES public.datasetversion(id);


--
-- Name: datatable fk_datatable_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datatable
    ADD CONSTRAINT fk_datatable_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: datavariable fk_datavariable_datatable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.datavariable
    ADD CONSTRAINT fk_datavariable_datatable_id FOREIGN KEY (datatable_id) REFERENCES public.datatable(id);


--
-- Name: dataverse_citationdatasetfieldtypes fk_dataverse_citationdatasetfieldtypes_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse_citationdatasetfieldtypes
    ADD CONSTRAINT fk_dataverse_citationdatasetfieldtypes_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataverse fk_dataverse_defaultcontributorrole_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse
    ADD CONSTRAINT fk_dataverse_defaultcontributorrole_id FOREIGN KEY (defaultcontributorrole_id) REFERENCES public.dataverserole(id);


--
-- Name: dataverse fk_dataverse_defaulttemplate_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse
    ADD CONSTRAINT fk_dataverse_defaulttemplate_id FOREIGN KEY (defaulttemplate_id) REFERENCES public.template(id);


--
-- Name: dataverse fk_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse
    ADD CONSTRAINT fk_dataverse_id FOREIGN KEY (id) REFERENCES public.dvobject(id);


--
-- Name: dataverse_metadatablock fk_dataverse_metadatablock_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse_metadatablock
    ADD CONSTRAINT fk_dataverse_metadatablock_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataverse_metadatablock fk_dataverse_metadatablock_metadatablocks_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverse_metadatablock
    ADD CONSTRAINT fk_dataverse_metadatablock_metadatablocks_id FOREIGN KEY (metadatablocks_id) REFERENCES public.metadatablock(id);


--
-- Name: dataversecontact fk_dataversecontact_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversecontact
    ADD CONSTRAINT fk_dataversecontact_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataversefacet fk_dataversefacet_datasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefacet
    ADD CONSTRAINT fk_dataversefacet_datasetfieldtype_id FOREIGN KEY (datasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: dataversefacet fk_dataversefacet_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefacet
    ADD CONSTRAINT fk_dataversefacet_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataversefeatureddataverse fk_dataversefeatureddataverse_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefeatureddataverse
    ADD CONSTRAINT fk_dataversefeatureddataverse_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataversefeatureddataverse fk_dataversefeatureddataverse_featureddataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefeatureddataverse
    ADD CONSTRAINT fk_dataversefeatureddataverse_featureddataverse_id FOREIGN KEY (featureddataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataversefieldtypeinputlevel fk_dataversefieldtypeinputlevel_datasetfieldtype_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefieldtypeinputlevel
    ADD CONSTRAINT fk_dataversefieldtypeinputlevel_datasetfieldtype_id FOREIGN KEY (datasetfieldtype_id) REFERENCES public.datasetfieldtype(id);


--
-- Name: dataversefieldtypeinputlevel fk_dataversefieldtypeinputlevel_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversefieldtypeinputlevel
    ADD CONSTRAINT fk_dataversefieldtypeinputlevel_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataverselinkingdataverse fk_dataverselinkingdataverse_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverselinkingdataverse
    ADD CONSTRAINT fk_dataverselinkingdataverse_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataverselinkingdataverse fk_dataverselinkingdataverse_linkingdataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverselinkingdataverse
    ADD CONSTRAINT fk_dataverselinkingdataverse_linkingdataverse_id FOREIGN KEY (linkingdataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataverserole fk_dataverserole_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataverserole
    ADD CONSTRAINT fk_dataverserole_owner_id FOREIGN KEY (owner_id) REFERENCES public.dvobject(id);


--
-- Name: dataversesubjects fk_dataversesubjects_controlledvocabularyvalue_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversesubjects
    ADD CONSTRAINT fk_dataversesubjects_controlledvocabularyvalue_id FOREIGN KEY (controlledvocabularyvalue_id) REFERENCES public.controlledvocabularyvalue(id);


--
-- Name: dataversesubjects fk_dataversesubjects_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversesubjects
    ADD CONSTRAINT fk_dataversesubjects_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dataversetheme fk_dataversetheme_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dataversetheme
    ADD CONSTRAINT fk_dataversetheme_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: dvobject fk_dvobject_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject
    ADD CONSTRAINT fk_dvobject_creator_id FOREIGN KEY (creator_id) REFERENCES public.authenticateduser(id);


--
-- Name: dvobject fk_dvobject_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject
    ADD CONSTRAINT fk_dvobject_owner_id FOREIGN KEY (owner_id) REFERENCES public.dvobject(id);


--
-- Name: dvobject fk_dvobject_releaseuser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.dvobject
    ADD CONSTRAINT fk_dvobject_releaseuser_id FOREIGN KEY (releaseuser_id) REFERENCES public.authenticateduser(id);


--
-- Name: explicitgroup_authenticateduser fk_explicitgroup_authenticateduser_explicitgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_authenticateduser
    ADD CONSTRAINT fk_explicitgroup_authenticateduser_explicitgroup_id FOREIGN KEY (explicitgroup_id) REFERENCES public.explicitgroup(id);


--
-- Name: explicitgroup_containedroleassignees fk_explicitgroup_containedroleassignees_explicitgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_containedroleassignees
    ADD CONSTRAINT fk_explicitgroup_containedroleassignees_explicitgroup_id FOREIGN KEY (explicitgroup_id) REFERENCES public.explicitgroup(id);


--
-- Name: explicitgroup_explicitgroup fk_explicitgroup_explicitgroup_containedexplicitgroups_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_explicitgroup
    ADD CONSTRAINT fk_explicitgroup_explicitgroup_containedexplicitgroups_id FOREIGN KEY (containedexplicitgroups_id) REFERENCES public.explicitgroup(id);


--
-- Name: explicitgroup_explicitgroup fk_explicitgroup_explicitgroup_explicitgroup_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup_explicitgroup
    ADD CONSTRAINT fk_explicitgroup_explicitgroup_explicitgroup_id FOREIGN KEY (explicitgroup_id) REFERENCES public.explicitgroup(id);


--
-- Name: explicitgroup fk_explicitgroup_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.explicitgroup
    ADD CONSTRAINT fk_explicitgroup_owner_id FOREIGN KEY (owner_id) REFERENCES public.dvobject(id);


--
-- Name: fileaccessrequests fk_fileaccessrequests_authenticated_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.fileaccessrequests
    ADD CONSTRAINT fk_fileaccessrequests_authenticated_user_id FOREIGN KEY (authenticated_user_id) REFERENCES public.authenticateduser(id);


--
-- Name: fileaccessrequests fk_fileaccessrequests_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.fileaccessrequests
    ADD CONSTRAINT fk_fileaccessrequests_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: filedownload fk_filedownload_guestbookresponse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filedownload
    ADD CONSTRAINT fk_filedownload_guestbookresponse_id FOREIGN KEY (guestbookresponse_id) REFERENCES public.guestbookresponse(id);


--
-- Name: filemetadata fk_filemetadata_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata
    ADD CONSTRAINT fk_filemetadata_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: filemetadata_datafilecategory fk_filemetadata_datafilecategory_filecategories_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata_datafilecategory
    ADD CONSTRAINT fk_filemetadata_datafilecategory_filecategories_id FOREIGN KEY (filecategories_id) REFERENCES public.datafilecategory(id);


--
-- Name: filemetadata_datafilecategory fk_filemetadata_datafilecategory_filemetadatas_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata_datafilecategory
    ADD CONSTRAINT fk_filemetadata_datafilecategory_filemetadatas_id FOREIGN KEY (filemetadatas_id) REFERENCES public.filemetadata(id);


--
-- Name: filemetadata fk_filemetadata_datasetversion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.filemetadata
    ADD CONSTRAINT fk_filemetadata_datasetversion_id FOREIGN KEY (datasetversion_id) REFERENCES public.datasetversion(id);


--
-- Name: foreignmetadatafieldmapping fk_foreignmetadatafieldmapping_foreignmetadataformatmapping_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadatafieldmapping
    ADD CONSTRAINT fk_foreignmetadatafieldmapping_foreignmetadataformatmapping_id FOREIGN KEY (foreignmetadataformatmapping_id) REFERENCES public.foreignmetadataformatmapping(id);


--
-- Name: foreignmetadatafieldmapping fk_foreignmetadatafieldmapping_parentfieldmapping_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.foreignmetadatafieldmapping
    ADD CONSTRAINT fk_foreignmetadatafieldmapping_parentfieldmapping_id FOREIGN KEY (parentfieldmapping_id) REFERENCES public.foreignmetadatafieldmapping(id);


--
-- Name: guestbook fk_guestbook_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbook
    ADD CONSTRAINT fk_guestbook_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: guestbookresponse fk_guestbookresponse_authenticateduser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse
    ADD CONSTRAINT fk_guestbookresponse_authenticateduser_id FOREIGN KEY (authenticateduser_id) REFERENCES public.authenticateduser(id);


--
-- Name: guestbookresponse fk_guestbookresponse_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse
    ADD CONSTRAINT fk_guestbookresponse_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: guestbookresponse fk_guestbookresponse_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse
    ADD CONSTRAINT fk_guestbookresponse_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: guestbookresponse fk_guestbookresponse_datasetversion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse
    ADD CONSTRAINT fk_guestbookresponse_datasetversion_id FOREIGN KEY (datasetversion_id) REFERENCES public.datasetversion(id);


--
-- Name: guestbookresponse fk_guestbookresponse_guestbook_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.guestbookresponse
    ADD CONSTRAINT fk_guestbookresponse_guestbook_id FOREIGN KEY (guestbook_id) REFERENCES public.guestbook(id);


--
-- Name: harvestingclient fk_harvestingclient_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.harvestingclient
    ADD CONSTRAINT fk_harvestingclient_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: harvestingdataverseconfig fk_harvestingdataverseconfig_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.harvestingdataverseconfig
    ADD CONSTRAINT fk_harvestingdataverseconfig_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: ingestreport fk_ingestreport_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ingestreport
    ADD CONSTRAINT fk_ingestreport_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: ingestrequest fk_ingestrequest_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ingestrequest
    ADD CONSTRAINT fk_ingestrequest_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: ipv4range fk_ipv4range_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ipv4range
    ADD CONSTRAINT fk_ipv4range_owner_id FOREIGN KEY (owner_id) REFERENCES public.persistedglobalgroup(id);


--
-- Name: ipv6range fk_ipv6range_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.ipv6range
    ADD CONSTRAINT fk_ipv6range_owner_id FOREIGN KEY (owner_id) REFERENCES public.persistedglobalgroup(id);


--
-- Name: maplayermetadata fk_maplayermetadata_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.maplayermetadata
    ADD CONSTRAINT fk_maplayermetadata_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: maplayermetadata fk_maplayermetadata_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.maplayermetadata
    ADD CONSTRAINT fk_maplayermetadata_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: metadatablock fk_metadatablock_owner_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.metadatablock
    ADD CONSTRAINT fk_metadatablock_owner_id FOREIGN KEY (owner_id) REFERENCES public.dvobject(id);


--
-- Name: oauth2tokendata fk_oauth2tokendata_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.oauth2tokendata
    ADD CONSTRAINT fk_oauth2tokendata_user_id FOREIGN KEY (user_id) REFERENCES public.authenticateduser(id);


--
-- Name: passwordresetdata fk_passwordresetdata_builtinuser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.passwordresetdata
    ADD CONSTRAINT fk_passwordresetdata_builtinuser_id FOREIGN KEY (builtinuser_id) REFERENCES public.builtinuser(id);


--
-- Name: pendingworkflowinvocation fk_pendingworkflowinvocation_dataset_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.pendingworkflowinvocation
    ADD CONSTRAINT fk_pendingworkflowinvocation_dataset_id FOREIGN KEY (dataset_id) REFERENCES public.dvobject(id);


--
-- Name: pendingworkflowinvocation fk_pendingworkflowinvocation_workflow_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.pendingworkflowinvocation
    ADD CONSTRAINT fk_pendingworkflowinvocation_workflow_id FOREIGN KEY (workflow_id) REFERENCES public.workflow(id);


--
-- Name: roleassignment fk_roleassignment_definitionpoint_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.roleassignment
    ADD CONSTRAINT fk_roleassignment_definitionpoint_id FOREIGN KEY (definitionpoint_id) REFERENCES public.dvobject(id);


--
-- Name: roleassignment fk_roleassignment_role_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.roleassignment
    ADD CONSTRAINT fk_roleassignment_role_id FOREIGN KEY (role_id) REFERENCES public.dataverserole(id);


--
-- Name: savedsearch fk_savedsearch_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearch
    ADD CONSTRAINT fk_savedsearch_creator_id FOREIGN KEY (creator_id) REFERENCES public.authenticateduser(id);


--
-- Name: savedsearch fk_savedsearch_definitionpoint_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearch
    ADD CONSTRAINT fk_savedsearch_definitionpoint_id FOREIGN KEY (definitionpoint_id) REFERENCES public.dvobject(id);


--
-- Name: savedsearchfilterquery fk_savedsearchfilterquery_savedsearch_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.savedsearchfilterquery
    ADD CONSTRAINT fk_savedsearchfilterquery_savedsearch_id FOREIGN KEY (savedsearch_id) REFERENCES public.savedsearch(id);


--
-- Name: summarystatistic fk_summarystatistic_datavariable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.summarystatistic
    ADD CONSTRAINT fk_summarystatistic_datavariable_id FOREIGN KEY (datavariable_id) REFERENCES public.datavariable(id);


--
-- Name: template fk_template_dataverse_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT fk_template_dataverse_id FOREIGN KEY (dataverse_id) REFERENCES public.dvobject(id);


--
-- Name: template fk_template_termsofuseandaccess_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.template
    ADD CONSTRAINT fk_template_termsofuseandaccess_id FOREIGN KEY (termsofuseandaccess_id) REFERENCES public.termsofuseandaccess(id);


--
-- Name: usernotification fk_usernotification_requestor_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.usernotification
    ADD CONSTRAINT fk_usernotification_requestor_id FOREIGN KEY (requestor_id) REFERENCES public.authenticateduser(id);


--
-- Name: usernotification fk_usernotification_user_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.usernotification
    ADD CONSTRAINT fk_usernotification_user_id FOREIGN KEY (user_id) REFERENCES public.authenticateduser(id);


--
-- Name: vargroup_datavariable fk_vargroup_datavariable_vargroup_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.vargroup_datavariable
    ADD CONSTRAINT fk_vargroup_datavariable_vargroup_id FOREIGN KEY (vargroup_id) REFERENCES public.vargroup(id);


--
-- Name: vargroup_datavariable fk_vargroup_datavariable_varsingroup_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.vargroup_datavariable
    ADD CONSTRAINT fk_vargroup_datavariable_varsingroup_id FOREIGN KEY (varsingroup_id) REFERENCES public.datavariable(id);


--
-- Name: vargroup fk_vargroup_filemetadata_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.vargroup
    ADD CONSTRAINT fk_vargroup_filemetadata_id FOREIGN KEY (filemetadata_id) REFERENCES public.filemetadata(id);


--
-- Name: variablecategory fk_variablecategory_datavariable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablecategory
    ADD CONSTRAINT fk_variablecategory_datavariable_id FOREIGN KEY (datavariable_id) REFERENCES public.datavariable(id);


--
-- Name: variablemetadata fk_variablemetadata_datavariable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablemetadata
    ADD CONSTRAINT fk_variablemetadata_datavariable_id FOREIGN KEY (datavariable_id) REFERENCES public.datavariable(id);


--
-- Name: variablemetadata fk_variablemetadata_filemetadata_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablemetadata
    ADD CONSTRAINT fk_variablemetadata_filemetadata_id FOREIGN KEY (filemetadata_id) REFERENCES public.filemetadata(id);


--
-- Name: variablemetadata fk_variablemetadata_weightvariable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablemetadata
    ADD CONSTRAINT fk_variablemetadata_weightvariable_id FOREIGN KEY (weightvariable_id) REFERENCES public.datavariable(id);


--
-- Name: variablerange fk_variablerange_datavariable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablerange
    ADD CONSTRAINT fk_variablerange_datavariable_id FOREIGN KEY (datavariable_id) REFERENCES public.datavariable(id);


--
-- Name: variablerangeitem fk_variablerangeitem_datavariable_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.variablerangeitem
    ADD CONSTRAINT fk_variablerangeitem_datavariable_id FOREIGN KEY (datavariable_id) REFERENCES public.datavariable(id);


--
-- Name: workflowcomment fk_workflowcomment_authenticateduser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowcomment
    ADD CONSTRAINT fk_workflowcomment_authenticateduser_id FOREIGN KEY (authenticateduser_id) REFERENCES public.authenticateduser(id);


--
-- Name: workflowcomment fk_workflowcomment_datasetversion_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowcomment
    ADD CONSTRAINT fk_workflowcomment_datasetversion_id FOREIGN KEY (datasetversion_id) REFERENCES public.datasetversion(id);


--
-- Name: workflowstepdata fk_workflowstepdata_parent_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowstepdata
    ADD CONSTRAINT fk_workflowstepdata_parent_id FOREIGN KEY (parent_id) REFERENCES public.workflow(id);


--
-- Name: workflowstepdata_stepparameters fk_workflowstepdata_stepparameters_workflowstepdata_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowstepdata_stepparameters
    ADD CONSTRAINT fk_workflowstepdata_stepparameters_workflowstepdata_id FOREIGN KEY (workflowstepdata_id) REFERENCES public.workflowstepdata(id);


--
-- Name: workflowstepdata_stepsettings fk_workflowstepdata_stepsettings_workflowstepdata_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.workflowstepdata_stepsettings
    ADD CONSTRAINT fk_workflowstepdata_stepsettings_workflowstepdata_id FOREIGN KEY (workflowstepdata_id) REFERENCES public.workflowstepdata(id);


--
-- Name: worldmapauth_token fk_worldmapauth_token_application_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_token
    ADD CONSTRAINT fk_worldmapauth_token_application_id FOREIGN KEY (application_id) REFERENCES public.worldmapauth_tokentype(id);


--
-- Name: worldmapauth_token fk_worldmapauth_token_datafile_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_token
    ADD CONSTRAINT fk_worldmapauth_token_datafile_id FOREIGN KEY (datafile_id) REFERENCES public.dvobject(id);


--
-- Name: worldmapauth_token fk_worldmapauth_token_dataverseuser_id; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.worldmapauth_token
    ADD CONSTRAINT fk_worldmapauth_token_dataverseuser_id FOREIGN KEY (dataverseuser_id) REFERENCES public.authenticateduser(id);


--
-- Name: pendingworkflowinvocation_localdata pndngwrkflwinvocationlocaldatapndngwrkflwinvocationinvocationid; Type: FK CONSTRAINT; Schema: public; Owner: dvnuser
--

ALTER TABLE ONLY public.pendingworkflowinvocation_localdata
    ADD CONSTRAINT pndngwrkflwinvocationlocaldatapndngwrkflwinvocationinvocationid FOREIGN KEY (pendingworkflowinvocation_invocationid) REFERENCES public.pendingworkflowinvocation(invocationid);


--
-- PostgreSQL database dump complete
--


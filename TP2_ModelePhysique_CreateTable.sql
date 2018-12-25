/* DROP ALL TABLE
________________________*/

DROP TABLE Users
DROP TABLE Poll;
DROP TABLE Decision;
DROP TABLE PollSubject;

/* CREATE ALL TABLE
________________________*/

CREATE TABLE Users
(
    id NUMBER(10) PRIMARY KEY,
	nom VARCHAR2(50) NOT NULL,
	prenom VARCHAR2(50) NOT NULL,
	login VARCHAR2(15) NOT NULL,
	password VARCHAR2(6) NOT NULL,
	email VARCHAR2(50) NOT NULL,
	role VARCHAR2(15) CHECK( role IN ('Officer','Elector') ) NOT NULL
);

CREATE TABLE Poll
(
    id NUMBER(10) PRIMARY KEY,
    starts DATE NOT NULL,
	ends DATE NOT NULL,
	publics VARCHAR2(1) CHECK( publics IN ('T','F') ) NOT NULL,
	anonymous VARCHAR2(1) CHECK( anonymous IN ('T','F') ) NOT NULL
);

CREATE TABLE Decision
(
    id NUMBER(10) PRIMARY KEY,
    dates DATE NOT NULL,
	firstChoice NUMBER(1) NOT NULL,
	secondChoice NUMBER(1) NOT NULL,
	thirdChoice NUMBER(1) NOT NULL,
	id_Poll NUMBER(10) NOT NULL, 
	id_Users NUMBER(10) NOT NULL 
);

CREATE TABLE PollSubject
(
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
	description VARCHAR2(50),
	image VARCHAR2(50),/*BLOB*/
	id_Poll NUMBER(10) 
);

-30-

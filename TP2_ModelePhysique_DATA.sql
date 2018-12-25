/*BDA.F16.HW2_DATA
__________________
By: Max Laniel
__________________
*/
 
/*USER*/
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(1,'Aganier','Michaël','AGANIERM','n8mBJh','aganierm@colval.qc.ca','Officer');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(2,'Barriault','Alexandre','BARRIAULTA','8uwFYy','barriaulta@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(3,'Boileau','Samuel','BOILEAUS','N3M7nk','boileaus@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(4,'Boudreault','Olivier','BOUDREAULTO','6wmZV8','boudreaulto@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(5,'Desrochers','Steven','DESROCHERSS','X6kXAB','desrocherss@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(6,'Dufresne Diamond','Alexis','DUFRESNEA','Gf8mSm','dufresnea@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(7,'Lalonde','Mathieu','LALONDEM','R78gve','lalondem@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(8,'Landry-Gravel','Nycholas','LANDRYN','7u7P5g','landryn@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(9,'Laniel','Maxime','LANIELM','7XFrjY','lanielm@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(10,'Lupien','Joël','LUPIENJ','G2emeC','lupienj@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(11,'Pelchat-Laflamme','Brandon','PELCHATB','VNEv7m','pelchatb@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(12,'Raymond','Mélissa','RAYMONDM','tV5vWy','raymondm@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(13,'Sauvé','Marco','SAUVEM','5jPvHs','sauvem@colval.qc.ca','Elector');
INSERT INTO Users (id, nom, prenom, login, password, email, role)
VALUES(14,'Wallot','Alex','WALLOTA','8aGzEp','wallota@colval.qc.ca','Elector');

/*Poll*/
INSERT INTO Poll (id, starts, ends, publics, anonymous)
VALUES(1,TO_DATE('20161022','YYYYMMDD'), TO_DATE('20161201','YYYYMMDD'), 'F', 'T');

/*Decision*/
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(1,TO_DATE('20161022','YYYYMMDD'), 1, 2, 3, 1, 1);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(2,TO_DATE('20161022','YYYYMMDD'), 2, 3, 1, 1, 2);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(3,TO_DATE('20161022','YYYYMMDD'), 1, 3, 4, 1, 3);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(4,TO_DATE('20161022','YYYYMMDD'), 1, 2, 3, 1, 4);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(5,TO_DATE('20161022','YYYYMMDD'), 1, 3, 2, 1, 5);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(6,TO_DATE('20161022','YYYYMMDD'), 4, 1, 3, 1, 6 );
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(7,TO_DATE('20161022','YYYYMMDD'), 2, 1, 3, 1, 7);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(8,TO_DATE('20161022','YYYYMMDD'), 3, 1, 2, 1, 8);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(9,TO_DATE('20161022','YYYYMMDD'), 2, 3, 1, 1, 9);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(10,TO_DATE('20161022','YYYYMMDD'), 3, 2, 1, 1, 10);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(11,TO_DATE('20161022','YYYYMMDD'), 3, 4, 2, 1, 11);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(12,TO_DATE('20161022','YYYYMMDD'), 2, 3, 1, 1, 12);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(13,TO_DATE('20161022','YYYYMMDD'), 4, 2, 3, 1, 13);
INSERT INTO Decision (id, dates, firstChoice, secondChoice, thirdChoice, id_Poll, id_Users)
VALUES(14,TO_DATE('20161022','YYYYMMDD'), 2, 1, 3, 1, 14);

/*PollSubject*/
INSERT INTO PollSubject (id, name, description, image, id_Poll)
VALUES(1,'Jean-francois Lisée','Journaliste','image #1','1');
INSERT INTO PollSubject (id, name, description, image, id_Poll)
VALUES(2,'Alexandre Cloutier','Avocat','image #2','1');
INSERT INTO PollSubject (id, name, description, image, id_Poll)
VALUES(3,'Martine Ouellet','Ingénieure','image #3','1');
INSERT INTO PollSubject (id, name, description, image, id_Poll)
VALUES(4,'Pierre Paul Plamondon','Chroniqueur','image #4','1');

-30-

/* DROP CONSTRAINT
________________________*/ 

ALTER TABLE Decision DROP CONSTRAINT Decision_FK1;
ALTER TABLE Decision DROP CONSTRAINT Decision_FK2;
ALTER TABLE PollSubject DROP CONSTRAINT PollSubject_FK1;

/* ALTER ALL TABLE
________________________*/


ALTER TABLE Decision ADD CONSTRAINT Decision_FK1 FOREIGN KEY (id_Poll) 
REFERENCES  Poll (id) ON DELETE CASCADE ENABLE;

ALTER TABLE Decision ADD CONSTRAINT Decision_FK2 FOREIGN KEY (id_Users) 
REFERENCES  Users (id) ON DELETE CASCADE ENABLE;

ALTER TABLE PollSubject ADD CONSTRAINT PollSubject_FK1 FOREIGN KEY (id_Poll) 
REFERENCES  Poll (id) ON DELETE CASCADE ENABLE;
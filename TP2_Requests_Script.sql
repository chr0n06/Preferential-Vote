/*TP2_1*/

DECLARE
PROCEDURE getNumberOfInFavor (PollSubjectID DECISION.firstchoice%TYPE) IS

CURSOR T1  (PollSubjectid DECISION.firstchoice%TYPE) IS
           SELECT firstchoice FROM DECISION
           WHERE firstchoice  = (SELECT id FROM POLLSUBJECT
                                WHERE id = PollSubjectID);
CURSOR T2  (PollSubjectid DECISION.firstchoice%TYPE) IS
           SELECT secondchoice FROM DECISION
           WHERE secondchoice  = (SELECT id FROM POLLSUBJECT
                                WHERE id = PollSubjectID);
CURSOR T3  (PollSubjectid DECISION.firstchoice%TYPE) IS
           SELECT thirdchoice FROM DECISION
           WHERE thirdchoice  = (SELECT id FROM POLLSUBJECT
                                WHERE id = PollSubjectID);
           nbrevote1 DECISION.id%TYPE :=0;
           nbrevote2 DECISION.id%TYPE :=0;
           nbrevote3 DECISION.id%TYPE :=0;
BEGIN
   FOR x in T1(PollSubjectID) LOOP
   nbrevote1 := nbrevote1 +1;
END LOOP;
dbms_output.put_line('Nombre de vote au premier tour : ' || nbrevote1);

FOR x in T2(PollSubjectID) LOOP
   nbrevote2 := nbrevote2 +1;
END LOOP;
dbms_output.put_line('Nombre de vote au deuxième tour : ' || nbrevote2);

FOR x in T3(PollSubjectID) LOOP
   nbrevote3 := nbrevote3 +1;
END LOOP;
dbms_output.put_line('Nombre de vote au troisième tour : ' || nbrevote3);
END;

/*CALL IS*/

BEGIN 
getNumberOfInFavor (2);
END;


/*TP2_2*/

DECLARE 
PROCEDURE getRatioOfInFavor (PollSubjectID DECISION.firstchoice%TYPE) IS

CURSOR T1  (PollSubjectid DECISION.firstchoice%TYPE) IS
           SELECT firstchoice FROM DECISION
           WHERE firstchoice  = (SELECT id FROM POLLSUBJECT
                                WHERE id = PollSubjectID);
CURSOR T2  (PollSubjectid DECISION.firstchoice%TYPE) IS
           SELECT secondchoice FROM DECISION
           WHERE secondchoice  = (SELECT id FROM POLLSUBJECT
                                WHERE id = PollSubjectID);
CURSOR T3  (PollSubjectid DECISION.firstchoice%TYPE) IS
           SELECT thirdchoice FROM DECISION
           WHERE thirdchoice  = (SELECT id FROM POLLSUBJECT
                                WHERE id = PollSubjectID);
CURSOR NBREVOTE IS
           SELECT * FROM DECISION;

           nbrevote1 DECISION.id%TYPE :=0;
           nbrevote2 DECISION.id%TYPE :=0;
           nbrevote3 DECISION.id%TYPE :=0;
           nbredeparticipants DECISION.id%TYPE :=0;
           forRatio NUMBER(4,2);
BEGIN

FOR x in NBREVOTE LOOP
   nbredeparticipants := nbredeparticipants +1;
END LOOP;

FOR x in T1(PollSubjectID) LOOP
   nbrevote1 := nbrevote1 +1;
forRatio := nbrevote1 / nbredeparticipants;
END LOOP;

dbms_output.put_line('Ratio simple lors du vote au premier tour : ' || forRatio);

FOR x in T2(PollSubjectID) LOOP
   nbrevote2 := nbrevote2 +1;
forRatio := nbrevote2 / nbredeparticipants;
END LOOP;
dbms_output.put_line('Ratio simple lors du vote au deuxième tour : ' || forRatio);

FOR x in T3(PollSubjectID) LOOP
   nbrevote3 := nbrevote3 +1;
forRatio := nbrevote3 / nbredeparticipants;
END LOOP;
dbms_output.put_line('Ratio simple lors du vote au troisième tour : ' || forRatio);
END;

/*CALL IS*/

BEGIN 
getRatioOfInFavor (1);
END;


/*TP2_3*/

DECLARE 
PROCEDURE getNumberOfParticipantPoll (PollID POLL.ID%TYPE) IS

CURSOR NBREPARTICIPANT (Poll_id Poll.id%TYPE) IS
           SELECT id FROM DECISION
           WHERE id_Poll = (SELECT id FROM POLL
                                WHERE id = PollID );
           nbredeparticipants Poll.id%TYPE :=0;
BEGIN

FOR x in NBREPARTICIPANT(PollID ) LOOP
   nbredeparticipants := nbredeparticipants +1;
END LOOP;
dbms_output.put_line('Nombre de total de votants dans le Poll#' || PollID  || ' est de : ' || nbredeparticipants );
END;

/*CALL IS*/
BEGIN 

getNumberOfParticipantPoll (1);

END;


/*TP2_4*/
CREATE OR REPLACE FUNCTION electorRegtToVote (PollID Poll.ID%TYPE, ELECTORID POLL.ID%TYPE )
RETURN POLL.ID%TYPE IS

CURSOR dec (elec POLL.ID%TYPE, Pol POLL.ID%TYPE) IS
           SELECT id_Poll FROM DECISION
           WHERE ID  = elec
           AND id_Poll = Pol; 
CURSOR sortall (val POLL.ID%TYPE) IS
           SELECT id FROM DECISION 
           WHERE id_Poll = val;

rep DECISION.ID%TYPE;
value1 DECISION.ID%TYPE;
somme DECISION.ID%TYPE :=0;

BEGIN 

OPEN dec(ELECTORID, PollID);
FETCH dec INTO value1;
CLOSE dec;

FOR x IN SORTALL(value1) LOOP
somme := somme +1;
END LOOP;

rep := somme;
RETURN rep;
END;

/*CALL IS*/

DECLARE 
reponse Poll.ID%TYPE;

BEGIN 
reponse := electorRegtToVote(1,4);
dbms_output.put_line(reponse);
END;


/*TP2_5*/

CREATE OR REPLACE FUNCTION subjectRegtToVote (PollID Poll.ID%TYPE, Pollsubj POLL.ID%TYPE )
RETURN POLL.ID%TYPE IS

CURSOR dec (Pol POLL.ID%TYPE,psubj POLL.ID%TYPE) IS
           SELECT PollSubject.id FROM DECISION, PollSubject
           WHERE PollSubject.id  = psubj
           AND DECISION.id_Poll = Pol; 
CURSOR sortall (val POLLSUBJECT.ID%TYPE) IS
           SELECT id FROM PollSubject 
           WHERE id_Poll = val;

rep DECISION.ID%TYPE;
value1 DECISION.ID%TYPE;
somme DECISION.ID%TYPE :=0;

BEGIN 

OPEN dec(PollID , Pollsubj );
FETCH dec INTO value1;
CLOSE dec;

FOR x IN SORTALL(value1) LOOP
somme := somme +1;
END LOOP;

rep := somme;
RETURN rep;
END;

/*call is*/

DECLARE 
reponse Poll.ID%TYPE;

BEGIN 
reponse := subjectRegtToVote(1,1);
dbms_output.put_line(reponse);
END;


/*TP2_6*/

DECLARE 
PROCEDURE createDecision (PollID POLL.ID%TYPE, ElectorID POLL.ID%TYPE, DecisionID POLL.ID%TYPE, PollSubjectID POLL.ID%TYPE) IS

CURSOR c_poll (Poll_id Poll.id%TYPE) IS
           SELECT id FROM POLL
           WHERE id = Poll_id;
CURSOR c_Elector (ElectorID Poll.id%TYPE) IS
           SELECT id FROM USERS
           WHERE id = ElectorID ;
CURSOR c_Decision (DecisionID Poll.id%TYPE) IS
           SELECT id FROM DECISION
           WHERE id = DecisionID;
CURSOR c_PollSubject (PollSubjectID Poll.id%TYPE) IS
           SELECT id FROM PollSubject
           WHERE id = PollSubjectID ;
tampon Poll.id%TYPE := 0;
errorPoll Poll.id%TYPE := 0;
errorElector Poll.id%TYPE := 0;
errorDecision Poll.id%TYPE := 0;
errorPollSubject Poll.id%TYPE := 0;
info varchar2(50);

BEGIN

FOR x IN c_poll (PollID) LOOP
tampon := tampon + 1;
errorPoll := 1; 
END LOOP;

FOR x IN c_Elector (ElectorID) LOOP
tampon := tampon + 1;
errorElector := 1;
END LOOP;

FOR x IN c_Decision (DecisionID) LOOP
tampon := tampon + 1;
errorDecision := 1;
END LOOP;

FOR x IN c_PollSubject (PollSubjectID) LOOP
tampon := tampon + 1;
errorPollSubject := 1;
END LOOP;

IF tampon < 4 THEN 
   dbms_output.put_line('Opération non réussie les paramètres suivants n''existent pas !' || info);
   IF errorPoll = 0 THEN dbms_output.put_line('Poll #'||PollID ); END IF;
   IF errorElector = 0 THEN  dbms_output.put_line('Users #'||ElectorID ); END IF;   
   IF errorDecision = 0 THEN  dbms_output.put_line('Decision #'||DecisionID ); END IF; 
   IF errorPollSubject = 0 THEN  dbms_output.put_line('PollSubject #'||PollSubjectID ); END IF;  
ELSE 
 dbms_output.put_line('Opération réussie!');
END IF;
END;

/*CALL IS*/
BEGIN 
CreateDecision (1,1,1,1);
END;


/*TP2_7*/

DECLARE 
PROCEDURE loneScan(PollID Poll.id%TYPE) IS

CURSOR VERIFYEXIST (Poll_id Poll.id%TYPE) IS
          SELECT id FROM Poll
          WHERE Poll.id = Poll_id;

CURSOR T1 (Poll_id Poll.id%TYPE) IS
          SELECT firstchoice FROM DECISION 
          WHERE id_Poll = (SELECT id FROM POLL
                           WHERE id = Poll_id);

CURSOR SORTWINNER (ide PollSubject.id%TYPE) IS
          SELECT name FROM PollSubject
          WHERE Pollsubject.id = ide;  

CURSOR NBREPARTICIPANT (Poll_id Poll.id%TYPE) IS
           SELECT id FROM DECISION
           WHERE id_Poll = (SELECT id FROM POLL
                                WHERE id = Poll_id);
W Poll.id%TYPE :=0;
X Poll.id%TYPE :=0;
Y Poll.id%TYPE :=0;
Z Poll.id%TYPE :=0;
LW Poll.id%TYPE :=1;
LX Poll.id%TYPE :=2;
LY Poll.id%TYPE :=3;
LZ Poll.id%TYPE :=4;
total Poll.id%TYPE := 0;
tampon Poll.id%TYPE := 0;
name Pollsubject.name%TYPE;
WINNER_EXCEPTION EXCEPTION;
NODATA_EXCEPTION EXCEPTION;

BEGIN
 
OPEN VERIFYEXIST(PollID);
FETCH VERIFYEXIST INTO tampon;
CLOSE VERIFYEXIST;
IF tampon = 0 THEN RAISE NODATA_EXCEPTION; END IF;

OPEN T1(PollID);
LOOP
   FETCH T1 INTO tampon; 
   EXIT WHEN T1 %NOTFOUND;
   IF tampon = 1 THEN W := W + 1; END IF;
   IF tampon = 2 THEN X := X + 1; END IF;
   IF tampon = 3 THEN Y := Y + 1; END IF;
   IF tampon = 4 THEN Z := Z + 1; END IF;
   total := total + 1;
END LOOP;
CLOSE T1;

OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| W || '  Pourcentage du vote = ' || ROUND(W/total,2));
OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| X || '  Pourcentage du vote = ' || ROUND(X/total,2));
OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| Y || '  Pourcentage du vote = ' || ROUND(Y/total,2));
OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| Z || '  Pourcentage du vote = ' || ROUND(Z/total,2));

RAISE WINNER_EXCEPTION; 

EXCEPTION
WHEN NODATA_EXCEPTION THEN 
     dbms_output.put_line('Aucun Poll ne porte le # ' || PollID);

WHEN ZERO_DIVIDE THEN
     dbms_output.put_line('Attention division par zéro');

WHEN WINNER_EXCEPTION THEN
     dbms_output.put_line('');
     IF W = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
     IF X = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
     IF Y = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
     IF Z = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
END;

/*CALL IS*/

BEGIN 
loneScan (1);
END;


/*TP2_8*/

DECLARE 
PROCEDURE polyscan(PollID Poll.id%TYPE) IS

CURSOR VERIFYEXIST (Poll_id Poll.id%TYPE) IS
          SELECT id FROM Poll
          WHERE Poll.id = Poll_id;

CURSOR T1 (Poll_id Poll.id%TYPE) IS
          SELECT firstchoice FROM DECISION 
          WHERE id_Poll = (SELECT id FROM POLL
                           WHERE id = Poll_id);

CURSOR ELIMIN1 (elimin Poll.id%TYPE) IS
          SELECT secondchoice FROM DECISION 
          WHERE DECISION.firstchoice = elimin;  

CURSOR ELIMIN2 (elimin Poll.id%TYPE, tampoon Poll.id%TYPE) IS
          SELECT thirdchoice FROM DECISION 
          WHERE DECISION.firstchoice = elimin AND
                DECISION.secondchoice = tampoon;  

CURSOR SORTWINNER (ide PollSubject.id%TYPE) IS
          SELECT name FROM PollSubject
          WHERE Pollsubject.id = ide;  

CURSOR NBREPARTICIPANT (Poll_id Poll.id%TYPE) IS
           SELECT id FROM DECISION
           WHERE id_Poll = (SELECT id FROM POLL
                                WHERE id = Poll_id);
W Poll.id%TYPE :=0;
X Poll.id%TYPE :=0;
Y Poll.id%TYPE :=0;
Z Poll.id%TYPE :=0;
LW Poll.id%TYPE :=1;
LX Poll.id%TYPE :=2;
LY Poll.id%TYPE :=3;
LZ Poll.id%TYPE :=4;
total Poll.id%TYPE := 0;
tampon Poll.id%TYPE := 0;
elimine1 Poll.id%TYPE := 0;
elimine2 Poll.id%TYPE := 0;
continue Poll.id%TYPE := 0;
name Pollsubject.name%TYPE;
WINNER_EXCEPTION EXCEPTION;
NODATA_EXCEPTION EXCEPTION;
RELIABILITY_EXCEPTION EXCEPTION;

BEGIN

/*Le poll existe-t-il?*/ 
OPEN VERIFYEXIST(PollID);
FETCH VERIFYEXIST INTO tampon;
CLOSE VERIFYEXIST;

/*Calcul des votes au premier tour*/
OPEN T1(PollID);
LOOP
   FETCH T1 INTO tampon;
   EXIT WHEN T1 %NOTFOUND;
   IF tampon < 1 THEN RAISE RELIABILITY_EXCEPTION ; END IF;
   IF tampon = 1 THEN W := W + 1; END IF;
   IF tampon = 2 THEN X := X + 1; END IF;
   IF tampon = 3 THEN Y := Y + 1; END IF;
   IF tampon = 4 THEN Z := Z + 1; END IF;
   total := total + 1;
END LOOP;
CLOSE T1;

dbms_output.put_line('Premier tour');
OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| W || '  Pourcentage du vote = ' || ROUND(W/total,2));
OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| X || '  Pourcentage du vote = ' || ROUND(X/total,2));
OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| Y || '  Pourcentage du vote = ' || ROUND(Y/total,2));
OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
dbms_output.put_line(name ||' = '|| Z || '  Pourcentage du vote = ' || ROUND(Z/total,2));

IF(W/total) >= 0.50 THEN continue :=1; END IF;
IF(X/total) >= 0.50 THEN continue :=1; END IF;
IF(Y/total) >= 0.50 THEN continue :=1; END IF;
IF(Z/total) >= 0.50 THEN continue :=1; END IF;

IF continue = 1 THEN RAISE WINNER_EXCEPTION ; END IF;

/*Qui doit être éliminé au premier tour?*/
IF  W = LEAST(W,X,Y,Z) THEN OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine1 := 1; LW := 0; W := 0; END IF;
IF  X = LEAST(W,X,Y,Z) THEN OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine1 := 2; LX := 0; X := 0; END IF;
IF  Y = LEAST(W,X,Y,Z) THEN OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine1 := 3; LY := 0; Y := 0; END IF;
IF  Z = LEAST(W,X,Y,Z) THEN OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine1 := 4; LZ := 0; Z := 0; END IF;

OPEN ELIMIN1(elimine1);
LOOP
FETCH ELIMIN1 INTO tampon;
EXIT WHEN ELIMIN1 %NOTFOUND;
   IF tampon < 1 THEN RAISE RELIABILITY_EXCEPTION ; END IF;
   IF tampon = 1 AND LW != 0 THEN W := W + 1; END IF;
   IF tampon = 2 AND LX != 0 THEN X := X + 1; END IF;
   IF tampon = 3 AND LY != 0 THEN Y := Y + 1; END IF;
   IF tampon = 4 AND LZ != 0 THEN Z := Z + 1; END IF;
END LOOP;
CLOSE ELIMIN1;

dbms_output.put_line('');
dbms_output.put_line('Deuxième tour');
OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LW != 0 THEN dbms_output.put_line(name ||' = '|| W || '  Pourcentage du vote = ' || ROUND(W/total,2)); END IF;
OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LX != 0 THEN dbms_output.put_line(name ||' = '|| X || '  Pourcentage du vote = ' || ROUND(X/total,2)); END IF;
OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LY != 0 THEN dbms_output.put_line(name ||' = '|| Y || '  Pourcentage du vote = ' || ROUND(Y/total,2)); END IF;
OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LZ != 0 THEN dbms_output.put_line(name ||' = '|| Z || '  Pourcentage du vote = ' || ROUND(Z/total,2)); END IF;

IF LW != 0 THEN IF (W/total) >= 0.50 THEN continue :=1; END IF; END IF;
IF LX != 0 THEN IF (X/total) >= 0.50 THEN continue :=1; END IF; END IF;
IF LY != 0 THEN IF (Y/total) >= 0.50 THEN continue :=1; END IF; END IF;
IF LZ != 0 THEN IF (Z/total) >= 0.50 THEN continue :=1; END IF; END IF;

IF continue = 1 THEN RAISE WINNER_EXCEPTION ; END IF;

/*Qui doit être éliminé au deuxième tour?*/
IF LW = 0 THEN IF  X = LEAST(X,Y,Z) THEN OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 2; LX := 0; X := 0; END IF;
               IF  Y = LEAST(X,Y,Z) THEN OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 3; LY := 0; Y := 0; END IF;
               IF  Z = LEAST(X,Y,Z) THEN OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 4; LZ := 0; Z := 0; END IF;
END IF;
IF LX = 0 THEN IF  W = LEAST(W,Y,Z) THEN OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 1; LW := 0; W := 0; END IF;
               IF  Y = LEAST(W,Y,Z) THEN OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 3; LY := 0; Y := 0; END IF;
               IF  Z = LEAST(W,Y,Z) THEN OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 4; LZ := 0; Z := 0; END IF;
END IF;
IF LY = 0 THEN IF  W = LEAST(W,X,Z) THEN OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 1; LW := 0; W := 0; END IF;
               IF  X = LEAST(W,X,Z) THEN OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 2; LX := 0; X := 0; END IF;
               IF  Z = LEAST(W,X,Z) THEN OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 4; LZ := 0; Z := 0; END IF;
END IF;
IF LZ = 0 THEN IF  W = LEAST(W,X,Y) THEN OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 1; LW := 0; W := 0; END IF;
               IF  X = LEAST(W,X,Y) THEN OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 2; LX := 0; X := 0; END IF;
               IF  Y = LEAST(W,X,Y) THEN OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' est éliminé(e)'); elimine2 := 3; LY := 0; Y := 0; END IF;
END IF;

OPEN ELIMIN1(elimine2);
LOOP
FETCH ELIMIN1 INTO tampon;
EXIT WHEN ELIMIN1 %NOTFOUND;
   IF tampon < 1 THEN RAISE RELIABILITY_EXCEPTION ; END IF;
   IF tampon = elimine1 THEN OPEN ELIMIN2(elimine2, tampon);
                             FETCH ELIMIN2 INTO tampon;
                             CLOSE ELIMIN2;END IF;
   IF tampon = 1 AND LW != 0 THEN W := W + 1; END IF;
   IF tampon = 2 AND LX != 0 THEN X := X + 1; END IF;
   IF tampon = 3 AND LY != 0 THEN Y := Y + 1; END IF;
   IF tampon = 4 AND LZ != 0 THEN Z := Z + 1; END IF;
END LOOP;
CLOSE ELIMIN1;

dbms_output.put_line('');
dbms_output.put_line('Troisième tour');
OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LW != 0 THEN dbms_output.put_line(name ||' = '|| W || '  Pourcentage du vote = ' || ROUND(W/total,2)); END IF;
OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LX != 0 THEN dbms_output.put_line(name ||' = '|| X || '  Pourcentage du vote = ' || ROUND(X/total,2)); END IF;
OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LY != 0 THEN dbms_output.put_line(name ||' = '|| Y || '  Pourcentage du vote = ' || ROUND(Y/total,2)); END IF;
OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER;
IF LZ != 0 THEN dbms_output.put_line(name ||' = '|| Z || '  Pourcentage du vote = ' || ROUND(Z/total,2)); END IF;

IF LW != 0 THEN IF (W/total) >= 0.50 THEN continue :=1; END IF; END IF;
IF LX != 0 THEN IF (X/total) >= 0.50 THEN continue :=1; END IF; END IF;
IF LY != 0 THEN IF (Y/total) >= 0.50 THEN continue :=1; END IF; END IF;
IF LZ != 0 THEN IF (Z/total) >= 0.50 THEN continue :=1; END IF; END IF;

IF continue = 1 THEN RAISE WINNER_EXCEPTION ; END IF;

EXCEPTION

WHEN RELIABILITY_EXCEPTION THEN
     dbms_output.put_line('Inférieur au Threshold');

WHEN NODATA_EXCEPTION THEN 
     dbms_output.put_line('Aucun Poll ne porte le # ' || PollID);

WHEN ZERO_DIVIDE THEN
     dbms_output.put_line('Attention division par zéro');

WHEN WINNER_EXCEPTION THEN
     dbms_output.put_line('');
     IF W = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LW); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
     IF X = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LX); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
     IF Y = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LY); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
     IF Z = GREATEST(W,X,Y,Z) THEN OPEN SORTWINNER(LZ); FETCH SORTWINNER INTO name; CLOSE SORTWINNER; dbms_output.put_line(name || ' is the Winner!'); END IF;
END;

/*CALL IS*/
BEGIN 
polyscan (1);
END;


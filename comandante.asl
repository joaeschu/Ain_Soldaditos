
/* Creencia que se dispara cuando se inicia la partida */
+flag(F) 
	<-
	.register_service("comandante");
	.get_medics;
	.get_fieldops;
	.wait(500);
	.get_service("defensor");
	.get_service("lider_patrulla");
	.goto(F);
	+i(0).
	
/*Utiliza al primer lider_patrulla como lider la patrulla de exploradores, y le manda una lista con su equipo*/
/*Además, le dice a los medico y el fieldop sobrantes que patrullen la bandera*/

+lider_patrulla(L)
	<-
	?defensores(D);
	.nth(0,L,L1);
	+lider(L1);
	.print("ahora ", L1, " es el lider de la patrulla");
	.nth(1,L,S);
	?myFieldops(F);
	?myMedics(M);
	.nth(0,F,FL);
	.nth(0,M,ML);
	.nth(1,F,FB);
	.nth(1,M,MB);
	.send([FB,MB],tell,bandera);
	.send(L1,tell,respPatrulla([FL,ML,S])).
	
/*Coge a los 3 defensores y los reparte en torno a la bandera. Luego se mueve a su lugar*/
+defensor(D)
	<-
	+defensores(D);
	?flag(F);
	.print("Conozco a mis 3 defensores, les digo donde ir");
	/*posiciones de defensa*/
	.pDefensiva(F, 20, Po);
	
	.nth(0,Po, P1);
	.nth(0, D, S1);
    .send(S1, tell, posicion_defensa(P1));
    .print("Ahora",S1," es defensor.");
	
	.nth(1,Po,P2);
	.nth(1, D, S2);
    .send(S2, tell, posicion_defensa(P2));
    .print("Ahora",S2," es defensor.");
	
	.nth(2,Po, P3);
	.nth(2, D, S3);
    .send(S3, tell, posicion_defensa(P3));
    .print("Ahora",S3," es defensor.");
	
	.nth(3,Po, P4);
	+posicion_defender(P4);
	.goto(P4);
	.print("fin de asignacion").
	

/*A PARTIR DE AQUI SE COMPORTA COMO UN DEFENSOR*/	

+target_reached(T)
	<-
	!!vigilar.

/*Busca enemigos cual peonza*/	
+!vigilar: position([X,Y,Z]) & peligro & not(enemies_in_fov(ID,Type,Angle,Distance,Health,Position))
    <-
    -peligro;
	!!check;
	!!vigilar.
	
+!vigilar: position([X,Y,Z]) & peligro
    <-
	!!vigilar.
	
+!vigilar: position([X,Y,Z]) & not peligro
    <-
    .look_at([X+1,Y,Z]);
	.look_at([X-1,Y,Z]);
	.look_at([X,Y,Z+1]);
	.look_at([X,Y,Z-1]);
	!!vigilar.
	

/*Si ve a alguien mientras vigila, dispara, avisa y entra en modo peligro*/
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): not peligro
	<-
	+peligro;
	?position(Pos);
	?lider(L);
	.send(L,tell,peligro_en(Position));
	.look_at(Position);
	.shoot(1,Position).
	
/*Sigue disparando si ve a alguien en modo peligro*/	
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): peligro
	<-
	.look_at(Position);
	.shoot(1,Position).
	
/*Comprueba si tiene munición o vida bajas y va a reponer*/
+!check:ammo(A) & health(H) & (H < 60 | A < 60)
    <-
    .print("Reabasteciendo...");
    +reponer;
	!!check.
	
+!check:ammo(A) & health(H) & (H >= 70 & A >= 50)
	<-
	?posicion_defender(P);
	.goto(P).
	
+!reponer: packs_in_fov(ID,Type,Angle,Distance,Health,Position) & Type<1003
	<-	
	.goto(Position).
	
+!reponer: not (packs_in_fov(ID,Type,Angle,Distance,Health,Position))
	<-	
	.turn(1.57);
	!!reponer.
	
	
	
	

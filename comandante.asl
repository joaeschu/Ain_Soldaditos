
/* Creencia que se dispara cuando se inicia la partida */
+flag(F) 
	<-
	.register_service("comandante");
	.get_medics;
	.get_fieldops;
	.wait(500);
	.get_service("defensor");
	.goto(F);
	+i(0).
	
/*Coge a los 3 defensores y los reparte en torno a la bandera. Luego se mueve a su lugar*/
+defensor(D)
	<-
	?flag(F);
	.print("Conozco a mis 3 defensores, les digo donde ir");
	.pDefensiva(F, Po);
	
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
	.goto(P4);
	.print("fin de asignacion").
	
/*Cuando recibe una solicitud de patrulla del lider de escuadrón L, 
le manda los integrantes de su patrulla*/
+solPatrulla[source(L)]
	<-
	.print("le mando el escuadron a: ",L);
	?myMedics(M);
	?myFieldops(F);
	.nth(0,F,FL);
	.quitar(0,F,F2);
	.nth(0,M,ML);
	.quitar(0,M,M2);
	.send(L,tell,respPatrulla([FL,ML]));
	-+myFieldops(F2);
	-+myMedics(M2).
	

/*A PARTIR DE AQU´´I SE COMPORTA COMO UN DEFENSOR*/	

/*Busca enemigos cual peonza*/	
+vigilar: position([X,Y,Z])
    <-
    .look_at([X+1,Y,Z]);
	.wait(400);
	.look_at([X-1,Y,Z]);
	.wait(400);
	.look_at([X,Y,Z+1]);
	.wait(400);
	.look_at([X,Y,Z-1]);
	.wait(400).
	

/*Si ve a alguien mientras vigila, dispara, avisa y entra en modo peligro*/
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): not peligro
	<-
	+peligro;
	?position(Pos);
	?lideres(L);
	.send(L,tell,peligro_en(Position));
	.send(L,tell,venid(Pos));
	.look_at(Position);
	.shoot(1,Position).
	
/*Sigue disparando si ve a alguien en modo peligro*/	
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): peligro
	<-
	.look_at(Position);
	.shoot(1,Position).
	
/*Comprueba si tiene munición o vida bajas y va a reponer*/
+check:ammo(A) & health(H) & not recuperando & position(P) & peligro
    <-
    if(H < 40 | A < 20){
    .print("Reabasteciendo...");
    ?flag(F);
	.distMedia(P,F,M);
    .goto(M);
	.print("Volviendo al combate");
	.goto(P).
	
	

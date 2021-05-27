
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
	

	
	


/* Creencia que se dispara cuando se inicia la partida */
+flag(F) 
	<-
	.register_service("comandante");
	.get_medics;
	.get_fieldops;
	.wait(100);
	.get_service("defensor");
	.goto(F).
	
/*Coge a los 3 defensores y los reparte en torno a la bandera*/
+defensor([D1,D2,D3])
	<-
	?flag([X,Y,Z]);
	.print("Conozco a mis 3 defensores, les digo donde ir");
	.send(D1,tell,posicion_defensa([X,Y,Z+20]));
	.send(D2,tell,posicion_defensa([X-17.3,Y,Z-10]));
	.send(D3,tell,posicion_defensa([X+17.3,Y,Z-10])).
	
/*Cuando recibe una solicitud de patrulla del lider de escuadrón L, 
le manda los integrantes de su patrulla*/
+solPatrulla[source(L)]
	<-
	.print("le mando el escuadrón a: ",L);
	?myMedics(M);
	?myFieldops(F);
	.nth(0,F,FL);
	.quitar(0,F,F2);
	.nth(0,M,ML);
	.quitar(0,M,M2);
	.send(L,tell,respPatrulla[FL,ML]);
	-+myFieldops(F2);
	-+myMedics(M2).
	

	
	
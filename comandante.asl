
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
+defensor(D)
	<-
	?flag(F);
	.print("Conozco a mis 4 defensores, les digo donde ir");
	.pDefensiva(F, Po);
	while(i(I) & I < 4) {
    .nth(I,Po, P1);
    .print("Punto ",I, ": ", P1);

    .nth(I, D, Sold);
    .send(Sold, tell, posicion_defensa(P1));
    .print("Ahora",Sold," es defensor.");
    -+i(I+1);
	}
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
	.send(L,tell,respPatrulla[FL,ML]);
	-+myFieldops(F2);
	-+myMedics(M2).
	

	
	
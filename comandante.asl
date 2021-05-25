
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
	?flag(Pos);
	.print("Conozco a mis 3 defensores, les digo donde ir");
	.calcula(Pos,[P1,P2,P3],[PD1,PD2,PD3]);
	.send(D1,tell,posicion_defensa(PD1));
	.send(D2,tell,posicion_defensa(PD2));
	.send(D3,tell,posicion_defensa(PD3)).
	
/*Cuando recibe una solicitud de patrulla del lider de escuadrón L, 
le manda los integrantes de su patrulla*/
+solPatrulla(_)[source(L)]
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
	

	
	
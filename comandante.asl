
/* Creencia que se dispara cuando se inicia la partida */
+flag (F): team(200) 
	<-
	.register_service("comandante");
	.get_medics;
	.get_backups;
	.get_fieldops.

+solPatrulla[source(L)]
	<-
	?myMedics(M);
	?myFieldops(F);
	.nth(0,F,FL);
	.quitar(0,F);
	.nth(0,M,ML);
	.quitar(0,M);
	.send(L,tell,respPatrulla[FL,ML]).
	
	
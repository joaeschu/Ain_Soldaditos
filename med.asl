
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.wait(500);
	.get_service("comandante").

+sigueme(Pos)[source(L)]
	<-
	.goto(Pos).
	
+fieldop(F)[source(L)]
	<-
	+miFieldop(F).
	
+target_reached(T)
	<-
	.turn(1.57);
	.wait(50);
	.turn(1.57);
	.wait(50);
	.turn(1.57);
	.wait(50);
	.turn(1.57);
	.wait(50);
	-target_reached(T).




	


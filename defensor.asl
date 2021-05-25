
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.register_service("defensa");
	.wait(100);
	.get_service("comandante").

+posicion_defensa(Pos)[source(C)]
	<-
	.print("Tengo que ir a: ", Pos);
	.goto(Pos).




	


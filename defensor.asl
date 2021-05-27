
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.register_service("defensor");
	.wait(500);
	.get_service("comandante");
	.get_service("lider_patrulla").

+lider_patrulla(L)
	<-
	+lideres(L).

+posicion_defensa(Pos)[source(C)]
	<-
	.print("Tengo que ir a: ", Pos);
	.goto(Pos).

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): not peligro
	<-
	+peligro;
	?position(Pos);
	?lideres(L);
	.send(L,tell,peligro_en(Position));
	.send(L,tell,venid(Pos)).

	


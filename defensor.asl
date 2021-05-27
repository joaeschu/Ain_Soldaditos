
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
	
+defensor(LD)
	<-
	+defensores(LD).

+posicion_defensa(Pos)[source(C)]
	<-
	.print("Tengo que ir a: ", Pos);
	.goto(Pos).

+enemies_in_fov(_,_,_,_,_,P): not peligro
	<-
	+peligro;
	?position(Pos);
	?defensores(D);
	?lideres(L);
	.send(D,tell,peligro_en(P));
	.send(L,tell,venid(Pos)).

	



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
	
    




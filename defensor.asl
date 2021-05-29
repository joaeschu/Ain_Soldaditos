
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.register_service("defensor");
	.wait(500);
	.get_service("comandante").

+es_lider(L)[sourde(C)]
	<-
	+lider(L).

+posicion_defensa(Pos)[source(C)]
	<-
	.print("Tengo que ir a: ", Pos);
	+posicion_defender(Pos);
	.goto(Pos).
	
+pos_reponer(Pos)[source(C)]
	<-
	+posicion_reponer(Pos).

+target_reached(T)
	<-
	!!vigilar.

/*Busca enemigos cual peonza*/	
+!vigilar: position([X,Y,Z]) & peligro & not(enemies_in_fov(ID,Type,Angle,Distance,Health,Position))
    <-
    -peligro;
	!!check;
	!!vigilar.
	
+!vigilar: position([X,Y,Z]) & peligro
    <-
	!!vigilar.
	
+!vigilar: position([X,Y,Z]) & not peligro
    <-
    .look_at([X+1,Y,Z]);
	.look_at([X-1,Y,Z]);
	.look_at([X,Y,Z+1]);
	.look_at([X,Y,Z-1]);
	!!vigilar.
	

/*Si ve a alguien mientras vigila, dispara, avisa y entra en modo peligro*/
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): not peligro
	<-
	+peligro;
	?position(Pos);
	?lider(L);
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
+!check:ammo(A) & health(H) & (H < 60 | A < 60)
    <-
    .print("Reabasteciendo...");
    ?posicion_reponer(P);
    .goto(P);
	!!check.
	
+!check:ammo(A) & health(H) & (H >= 70 & A >= 50)
	<-
	?posicion_defender(P);
	.goto(P).
	
    




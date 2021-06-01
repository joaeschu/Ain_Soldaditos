
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.register_service("defensor");
	.wait(500);
	.get_service("comandante");
	.get_service("lider_patrulla").

+lider_patrulla(L)
	<-
	.nth(0,L,L1);
	+lider(L1).

+posicion_defensa(Pos)[source(C)]
	<-
	.print("Tengo que ir a: ", Pos);
	+posicion_defender(Pos);
	.goto(Pos).

+target_reached(T)
	<-
	!!vigilar.

/*Si no ve enemigos, espera un segundo, quita el modo peligro y manda un mensaje de todo bien*/	
+!vigilar: position([X,Y,Z]) & peligro & not(enemies_in_fov(ID,Type,Angle,Distance,Health,Position))
    <-
	.wait(1000);
    -peligro;
	?lider(L);
	.send(L,tell,todo_bien);
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
    !!reponer;
	!!check.
	
+!check:ammo(A) & health(H) & (H >= 70 & A >= 50)
	<-
	?posicion_defender(P);
	.goto(P).

+!reponer: packs_in_fov(ID,Type,Angle,Distance,Health,Position) & Type<1003
	<-	
	.goto(Position).
	
+!reponer: not (packs_in_fov(ID,Type,Angle,Distance,Health,Position))
	<-	
	.turn(1.57);
	!!reponer.
	
    




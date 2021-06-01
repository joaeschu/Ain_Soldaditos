
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.wait(500);
	.get_service("comandante").

+sigueme(Pos)[source(L)]
	<-
	.wait(500);
	.goto(Pos).
	
+escuadron([L1,L2,L3])[source(L)]
	<-
	+miSoldado(L3);
	+miMedico(L2);
	+miLider(L).
	
+target_reached(T): not base
	<-
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.reload;
	-target_reached(T).

/*Si ve a alguien, dispara*/	
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
	<-
	.look_at(Position);
	.shoot(1,Position).
	
/*Comprueba si tiene munición o vida bajas y va a reponer*/
+!check:ammo(A) & health(H) & (H < 60 | A < 60)
    <-
    .print("Reabasteciendo...");
	.reload;
    !!reponer;
	!!check.

+!reponer: packs_in_fov(ID,Type,Angle,Distance,Health,Position) & Type<1003
	<-	
	.goto(Position).
	
+!reponer: not (packs_in_fov(ID,Type,Angle,Distance,Health,Position))
	<-	
	.turn(1.57);
	!!reponer.
	
/*Si le llega el mensaje bandera, pasa a formar parte del equipo de la bandera*/
+bandera[source(C)]
	<-
	+base;
	?flag(F);
	.pDefensiva(F, 24, P);
	+control_points(P);
	+total_control_points(4);
	+patrulla(0).

+patrulla(P): total_control_points(T) & P<T
	<-
	?control_points(C);
	.nth(P,C,A);
	.goto(A).

+patrulla(P): total_control_points(T) & P==T
	<-
	-patrulla(P);
	+patrulla(0).
  
+target_reached(T): base
	<-
	?patrulla(N);
	.reload;
	-+patrulla(N+1);
	-target_reached(T).



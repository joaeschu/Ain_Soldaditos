
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.register_service("lider_patrulla");
	.wait(500);
	.get_service("comandante").
	
/*El comandante le manda su patrulla*/
+respPatrulla([L1,L2,L3])[source(C)]
	<-
	.print("el comandante me da mi escuadron");
	+miFieldops(L1);
	+miMedico(L2);
	+miSoldado(L3);
	
	.send([L1,L2,L3],tell,escuadron(L2));
	
	+crea_puntos;
	+pedir_seguimiento([L1,L2,L3]).
	
+pedir_seguimiento([L1,L2,L3])
	<-
	?control_points(C);
	.nth(0,C,Pos);
	.send([L1,L2,L3],tell,sigueme(Pos)).
	
/*Crea puntos de control*/
+crea_puntos
	<-
	?flag(Pos);
	.create_control_points(Pos,75,4,C);
	+control_points(C);
	.length(C,L);
	+total_control_points(L);
	+patrulla(0).
	
+patrulla(P): total_control_points(T) & P<T
	<-
	?control_points(C);
	.nth(P,C,A);
	?miFieldops(L1);
	?miMedico(L2);
	?miSoldado(L3);
	.send([L1,L2,L3],tell,sigueme(A));
	.goto(A).

+patrulla(P): total_control_points(T) & P==T
	<-
	-patrulla(P);
	+patrulla(0).
  
+target_reached(T): patrulla(N) & not reponiendo
	<-
	.turn(1.57);
	.turn(1.57);
	.turn(1.57);
	.turn(1.57);
	-+patrulla(N+1);
	-target_reached(T).

/*Si ve a alguien, dispara*/	
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
	<-
	.look_at(Position);
	.shoot(1,Position).
	
+peligro_en(Position)[source(D)]
	<-
	?miFieldops(L1);
	?miMedico(L2);
	?miSoldado(L3);
	+miFieldops(L1);
	+miMedico(L2);
	+miSoldado(L3);
	.send([L1,L2,L3],tell,sigueme(Pos));
	.goto(Position).
    	
+todo_bien[source(D)]
	<-
	+crea_puntos.
		
/* Si le llega el mensaje "escuadron", quiere decir que es el soldado del equipo explorador*/
+escuadron([L1,L2,L3])[source(L)]
	<-
	+miFieldops(L1);
	+miMedico(L2);
	+miLider(L).
	
+sigueme(Pos)[source(L)]
	<-
	.wait(500);
	.goto(Pos).
	
+target_reached(T): not(patrulla(P))
	<-
	+check;
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	-target_reached(T).
	
+check:ammo(A) & health(H) & (H < 60 | A < 60)
    <-
    +reponiendo;
	-check.
	
+check:ammo(A) & health(H) & (H >= 70 & A >= 50)
	<-
	+patrulla(0);
	-check.
	
+reponiendo	
	<-
	?position(P);
	?miFieldops(F);
	?miMedico(M);
	.send([F,M],tell,sigueme(P));
	-reponiendo;
	+check.



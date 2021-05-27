
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.register_service("lider_patrulla");
	.wait(500);
	.get_service("comandante").

/*espera que le asigne su patrulla el comandante*/
+comandante([C])
	<-
	.print("pido mi escuadron");
	.send(C,tell,solPatrulla).
	
/*El comandante le manda su patrulla*/
+respPatrulla([L1,L2])[source(C)]
	<-
	.print("el comandante me da mi escuadron");
	+miFieldops(L1);
	.send(L1,tell,medico(L2));
	+miMedico(L2);
	.send(L2,tell,fieldop(L1));
	+crea_puntos;
	+pedir_seguimiento([L1,L2]).
	
+pedir_seguimiento([L1,L2])
	<-
	?control_points(C);
	.nth(0,C,Pos);
	.send(L1,tell,sigueme(Pos));
	.send(L2,tell,sigueme(Pos)).
	
/*Crea puntos de control*/
+crea_puntos
	<-
	?flag(Pos);
	.create_control_points(Pos,100,4,C);
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
	.send(L1,tell,sigueme(A));
	.send(L2,tell,sigueme(A));
	.goto(A).

+patrulla(P): total_control_points(T) & P==T
	<-
	-patrulla(P);
	+patrulla(0).
  
+target_reached(T)
	<-
	?patrulla(N);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	.turn(1.57);
	.wait(200);
	-+patrulla(N+1);
	-target_reached(T).
	


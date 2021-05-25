
/* Creencia que se dispara cuando se inicia la partida */
+flag(F): team(200)
	<-
	.wait(100)
	.register_service("lider_patrulla");
	.get_service("comandante").

/*espera que le asigne su patrulla el comandante*/
+comandante(G)
	<-
	.send(G,tell,solPatrulla).
	
/*El comandante le manda su patrulla*/
+respPatrulla([L1,L2])[source(G)]
	<-
	.send(L1,tell,sigueme);
	+miFieldOps(L1);
	.send(L2,tell,sigueme);
	+miMedico(L2);
	.wait(1000);
	.send(G,tell,solDestino);
	+crea_puntos.
	
/*Crea puntos de control*/
+crea_puntos
	<-
	?flag(Pos);
	.create_control_points(Pos,75,4,C);
	+control_points(C);
	.length(C,L);
	+total_control_points(L);
	+patrulla(0).
	


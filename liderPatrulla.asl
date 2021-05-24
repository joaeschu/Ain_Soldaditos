

/* Creencia que se dispara cuando se inicia la partida */
+flag(F): team(200)
	<-
	.wait(100)
	.register_service("lider_patrulla");
	.get_service("general").

/*espera que le asigne su patrulla el general*/
+general(G)
	<-
	.send(G,tell,solPatrulla).
	
/*El general le manda su patrulla*/
+respPatrulla(L)
	<-
	.send(L,tell,seguidme).


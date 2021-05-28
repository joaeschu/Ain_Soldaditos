
/* Creencia que se dispara cuando se inicia la partida */
+flag(F)
	<-
	.wait(500);
	.get_service("comandante").

+sigueme(Pos)[source(L)]
	<-
	.goto(Pos).
	
+fieldop(F)[source(L)]
	<-
	+miFieldop(F).
	
+target_reached(T)
	<-
	.turn(1.57);
	.wait(50);
	.turn(1.57);
	.wait(50);
	.turn(1.57);
	.wait(50);
	.turn(1.57);
	.wait(50);
	.cure;
	-target_reached(T).


/*Se dedica a colocar paquetes de vida en la base si hay peligro*/	
+curar: peligro
	<-
    ?flag(F);
	.pDefensiva(F, Po);
	.nth(0,Po,P1);
	._distMedia(P1,F,D1);
	.goto(D1);
	.cure;
    .print("Paquete curativo dejado en" D1);
	
	.nth(1,Po,P2);
	._distMedia(P2,F,D2);
	.goto(D2);
	.cure;
    .print("Paquete curativo dejado en" D2);
	
	.nth(2,Po,P3);
	._distMedia(P3,F,D3);
	.goto(D3);
	.cure;
    .print("Paquete curativo dejado en" D3);
	
	.nth(3,Po,P4);
	._distMedia(P4,F,D4);
	.goto(D4);
	.cure;
    .print("Paquete curativo dejado en" D4);
	
/*Si ve a alguien, dispara*/	
+enemies_in_fov(ID,Type,Angle,Distance,Health,Position): 
	<-
	.look_at(Position);
	.shoot(1,Position).
	
/*TODO Comprueba si tiene munición o vida bajas y va a reponer*/
+check:ammo(A) & health(H) & not recuperando & position(P) & peligro
    <-
    if(H < 40 | A < 20){
    .print("Reabasteciendo...");




	


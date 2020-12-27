//--------------Configuraciones----------------//
import processing.serial.*;
import processing.sound.*;
SoundFile file;

Serial myPort;

Obstaculo obstaculo;
Obstaculo2 obstaculo2;
Obstaculo3 obstaculo3;
Obstaculo4 obstaculo4;
Caballito caballito;
Caballito2 caballito2;
Caballito3 caballito3;
Fruta fruta;
Lechuga lechuga;
Zanahoria zanahoria;

PImage fondo,fondo2,fondo3; 
PImage inicio;
PImage Cara_caballo,Caballo,Caballo2,Caballo3;
PImage Cruz;
PImage Zandia;
PImage CajaMonedas;
PImage [] Moneda = new PImage [4];

private int puntaje, contador;
private int puntajeMaximo;
private int vida;
PFont press;

int pantalla =0;
int  cont = 0;
int control = 0;
int x = 10;
int y = 10;
int lf = 10;
int flagVideo = 0;
int flagsound = 1;
int s = second();

private int vidaglobal=0;
private int tiempo, velocidad = 4, i ;

boolean impacto, activado, masBateria, destruido,gameOver;
int tiempoInvencible, cantidadZandia;

//-------------------Inicio-----------------//
void setup() {
  //--------------Sonido de inicio-----------------//
    file = new SoundFile(this, "colombia.mp3");
    file.play();
  //--------------Conexion Arduino----------------//
  
  myPort = new Serial(this, "COM5", 9600);
  myPort.bufferUntil(lf); 
  
    //-------------Fondos Img----------------//
  pantalla = 0;
  inicio = loadImage("Inicio1.png");
  fondo = loadImage("Fondo_1.png");
  fondo2 = loadImage("Fondo_2.png");
  fondo3 = loadImage("Fondo_3.png");
 
  //---------------Panel Superior----------//
  
  Cara_caballo = loadImage("Cara de Caballo.png");
  Caballo = loadImage("CaraCaballo.png");
  Caballo2 = loadImage("CaraCaballoo.png");
  Caballo3 = loadImage("CaraCaballo3.png");
  Zandia = loadImage("Zandia.png");
  Moneda[0] = loadImage("Moneda.png");
  Moneda[1] = loadImage("Moneda2.png");
  Moneda[2] = loadImage("Moneda3.png");
  Moneda[3] = loadImage("Moneda4.png");
  Cruz  = loadImage("Cruz.png");
  CajaMonedas = loadImage("CajaMonedas.png");
  
    //--------------Tipo Texto ----------------//
  
   press = createFont("times new roman", 20);
   size(1000,500);
   fill(126);
   stroke (0); 
   
     //--------------Objetos----------------//
   
   obstaculo= new Obstaculo();
   obstaculo2= new Obstaculo2();
   obstaculo3= new Obstaculo3();
   obstaculo4= new Obstaculo4();
   caballito = new Caballito();
   caballito2 = new Caballito2();
   caballito3 = new Caballito3();
   fruta = new Fruta();
   zanahoria = new Zanahoria();
   lechuga = new Lechuga();
}
 
void draw() {
  
 //---------------------Control Arduino------------------------//
 
     if ( myPort.available() > 0) {  
       int temp  = myPort.read(); 
      if(temp >= 50) {
        control = temp; 
      }        
     } else
     {
        control = 0; 
     }
  
    //---------------Pausar juego-----------//
    
   if(control == 50){
     text("Pausa",450,250);
     print("Juego Pausado");
     noLoop();
   
   } 
  
  //-----------------------Vida del caballo--------//
  
   if(vidaglobal == 0){
       vidaglobal=1;
       caballito.setVida(100);
       caballito2.setVida2(100);
       caballito3.setVida3(100);   
   }
   
 //---------------------Pantalla Inicio------------------------//
  
  if (pantalla == 0) {
    
   image (inicio, 0,0);
   //image(myMovie, 0, 0,1000,600);
   textSize(32);
   text("¡Presiona un boton para empezar!",40,80);
   if (flagVideo == 0)
   {
   } 
   if (control==51 || control==52 || control==53) {
         pantalla = 1;
         flagsound = 1;
      }
  }

    //---------------------Pantallas nivel 1 ------------------------//
  
   if (pantalla == 1) {

   //---------------------Metodos------------------------//
   
    image(fondo, width/2, height/2, width, height)  ;
    translate(x, y);
    lechuga.mover();
    lechuga.display();
    obstaculo2.mover();
    obstaculo3.display();
    obstaculo3.mover();
    obstaculo2.display();
    caballito.mover();
    caballito.moverIzq();
    caballito.moverDer();
    caballito.salto();
    caballito.mostrar();
    masPuntaje();
    Bajarvida();
    Bajarvidaa();
    SumaPuntaje();
    Invencibilidad();
    setVida(caballito.getVida());
    setPuntaje(caballito.getPuntaje());
    
    image(Caballo,100,70,120,120);
    
 //---------------------Nacen Obstaculos ------------------------//  
    
     if (obstaculo3.nacer()) {
      obstaculo3= new  Obstaculo3();
    }
    
    if (obstaculo2.nacer()) {
      obstaculo2= new  Obstaculo2();
    }
   
   if (caballito.nacer()) {
      caballito= new  Caballito();
    }  
    
    if (lechuga.nacer()) {
      lechuga= new Lechuga();
    }  
   }

  //---------------------Pantalla Perder nivel 1 ------------------------//
    if(pantalla == 2) {   
      
     image(inicio, width/2, height/2, width, height)  ;
     textSize(45);
     text("Perdiste!",110,50);
     setPuntajeMaximo();
     setPuntaje(0);
     caballito.setVida(100); 
     caballito.setPuntaje(0);
     text("Puntaje maximo",110,100);
     text(this.puntajeMaximo,490,100);
       if (control==51 || control==52 || control==53) {
          pantalla = 1;
          flagsound = 1;     
    }
  }
  
//---------------------Pantalla Ganador nivel 1 ------------------------//
  
  if (pantalla == 3) {

   image(fondo, width/2, height/2, width, height)  ;
   textSize(43);
   text("! Pasate Nivel! 2",250,175);
   if (flagVideo == 0)
   {
     flagVideo =1;
   } 
   if (control==50 || control==51 || control==52 || control==53) {
        pantalla = 4;
        flagsound = 1;
    } 
  }
  
//--------------------- Nivel 2 ------------------------//

//----------------Metodos ---------------//
  
   if (pantalla == 4){
    image(fondo2, width/2, height/2, width, height)  ;
    fruta.mover();
    fruta.display();
    lechuga.mover();
    lechuga.display();
    zanahoria.mover();
    zanahoria.display();
    obstaculo.mover();
    obstaculo.display();
    obstaculo2.mover();
    obstaculo2.display();
    obstaculo3.mover();
    obstaculo3.display();
    obstaculo4.mover();
    obstaculo4.display();
    caballito2.mover();
    caballito2.mostrar();
    caballito2.moverIzqu();
    caballito2.moverDere();
    caballito2.salto();
    masPuntaje();
    Bajarvida2();
    Bajarvidaa2();
    Bajarvidaaa2();
    Bajarvidaaaa2();
    SumaPuntaje2();
    SumaPuntaje3();
    SumaPuntaje4();
    Invencibilidad();
    setVida(caballito2.getVida2());
    setPuntaje(caballito2.getPuntaje2());
     
    image(Caballo2,100,70,120,120); 
 
  //---------------------Nacen Obstaculos ------------------------// 
    
    if (obstaculo.nacer()) {
      obstaculo= new  Obstaculo();
    }
   
   if (obstaculo2.nacer()) {
      obstaculo2= new  Obstaculo2();
    }
    
    if (obstaculo3.nacer()) {
      obstaculo3= new  Obstaculo3();
    }
    
    if (obstaculo4.nacer()) {
      obstaculo4= new  Obstaculo4();
    }
   
   if (caballito2.nacer()) {
      caballito= new  Caballito();
    }  
    
    if (fruta.nacer()) {
      fruta= new  Fruta();
    } 
    
      if (lechuga.nacer()) {
      lechuga= new Lechuga();
    }  
    
     if (zanahoria.nacer()) {
      zanahoria= new Zanahoria();
    }   
  }
  
//---------------------Pantalla Game Over nivel 2 ------------------------//
  
  if(pantalla == 5) {

    //background(345);
    image(inicio, width/2, height/2, width, height)  ;
    textSize(45);
    text("Perdiste",110,50);
     setPuntajeMaximo();
     setPuntaje(0);
     caballito2.setVida2(100);
     caballito2.setPuntaje2(0);
     text("Puntaje maximo",110,100);
     text(this.puntajeMaximo,490,100);
   if (control==51 || control==52 || control==53) {
      pantalla = 4;
      flagsound = 4;
    }
  }
  
  //--------------------- Pantalla Ganaste nivel 2 ------------------------//
 
    if (pantalla == 6) {
   
   image(fondo, width/2, height/2, width, height)  ;
   textSize(43);
   text("! Pasaste al nivel 3 ! ",370,175);
   setPuntaje(0);
   caballito2.setVida2(100);
   caballito2.setPuntaje2(0);
   if (flagVideo == 0)
   {
     flagVideo =1;
   } 
   if (control==51 || control==52 || control==53) {
         pantalla = 7; 
         flagsound = 7;
      }
  }
  //--------------------- Pantalla Nivel 3 ------------------------//

//----------------Metodos ---------------//
  
   if (pantalla == 7){
    image(fondo3, width/2, height/2, width, height)  ;
    fruta.mover();
    fruta.display();
    lechuga.mover();
    lechuga.display();
    zanahoria.mover();
    zanahoria.display();
    obstaculo.mover();
    obstaculo.display();
    obstaculo2.mover();
    obstaculo2.display();
    obstaculo3.mover();
    obstaculo3.display();
    obstaculo4.mover();
    obstaculo4.display();
    caballito3.mover();
    caballito3.mostrar();
    caballito3.moverIzqu();
    caballito3.moverDere();
    caballito3.salto();
    masPuntaje();
    Bajarvida3();
    Bajarvidaa3();
    Bajarvidaaa3();
    Bajarvidaaaa3();
    SumaPuntaje5();
    SumaPuntaje6();
    SumaPuntaje7();
    Invencibilidad();
    setVida(caballito3.getVida3());
    setPuntaje(caballito3.getPuntaje3());
     
    image(Caballo3,100,70,120,120); 
 
  //---------------------Nacen Obstaculos ------------------------// 
    
    if (obstaculo.nacer()) {
      obstaculo= new  Obstaculo();
    }
   
   if (obstaculo2.nacer()) {
      obstaculo2= new  Obstaculo2();
    }
    
    if (obstaculo3.nacer()) {
      obstaculo3= new  Obstaculo3();
    }
    
    if (obstaculo4.nacer()) {
      obstaculo4= new  Obstaculo4();
    }
   
   if (caballito2.nacer()) {
      caballito= new  Caballito();
    }  
    
    if (fruta.nacer()) {
      fruta= new  Fruta();
    } 
    
      if (lechuga.nacer()) {
      lechuga= new Lechuga();
    }  
    
     if (zanahoria.nacer()) {
      zanahoria= new Zanahoria();
    }   
  }
  
//---------------------Pantalla Game Over nivel 3 ------------------------//
  
  if(pantalla == 8) {
    
    image(inicio, width/2, height/2, width, height)  ;
    textSize(45);
    text("Perdiste!",110,50);
     setPuntajeMaximo();
     setPuntaje(0);
     caballito3.setVida3(100);
     caballito3.setPuntaje3(0);
     text("Puntaje maximo",110,100);
     text(this.puntajeMaximo,490,100);
   if (control==51 || control==52 || control==53) {
      pantalla = 7;
      flagsound = 7;
    }
  }
  
  //---------------------Pantalla Ganaste nivel 3 ------------------------//
 
    if (pantalla == 9) {
   
   image(fondo, width/2, height/2, width, height)  ;
   textSize(43);
   text("! Ganaste ! ",370,175);
   setPuntaje(0);
   caballito3.setVida3(100);
   caballito3.setPuntaje3(0);
   if (flagVideo == 0)
   {
     flagVideo = 0;
   } 
   if (control == 51 || control == 52 || control == 53) {
        pantalla = 10;
         flagsound = 1;
      }
  }
    //--------------------- Pantalla Final ------------------------//
 
    if (pantalla == 10) {
   
   image(fondo, width/2, height/2, width, height)  ;
   textSize(43);
   text("! Felicidades pasaste el juego ! ",200,175);
   setPuntaje(0);
   caballito3.setVida3(100);
   caballito3.setPuntaje3(0);
  }
}
  
  //--------------------- Puntaje ------------------------//
  
  public void masPuntaje(){ 
  
   contador++;
   if(contador == 1)
   {
     contador = 0;
 }
   textSize(30);
   text(this.puntaje,230,80);
   text(this.puntajeMaximo,340,80);
   text(this.vida,470,80);
   image(Cara_caballo,420,70,50,50);
   image(Cruz,445,79,30,35);
   image(CajaMonedas,300,70,50,45);
    if(tiempo == velocidad)
  {
   i++;
  tiempo = 0;
    if(i == 4)
    {
      i =0;
    }   
   }
     tiempo ++; 
   
   pushMatrix();
   image(Moneda[i],200,70,50,45);
   popMatrix();
    
  } 

   public void setPuntaje(int puntaje)
   {
     this.puntaje = puntaje;
   }
   
   public int getPuntaje()
   {
    return this.puntaje; 
   }
   
  
  public void setPuntajeMaximo()
  {
   if(this.puntaje > this.puntajeMaximo)
   {
     this.puntajeMaximo = this.puntaje;
   }
     
  }
  
  public void setVida(int vida)
  {
  this.vida = vida;  
  }

//---------------------Bajar vida obstaculo1 nivel 1 ------------------------//

  void Bajarvida() {
    
    if (obstaculo2.getPosX() < caballito.x+50
     && obstaculo2.getPosX() > caballito.x-50
     && obstaculo2.getPosY() < caballito.y+50
     && obstaculo2.getPosY() > caballito.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito.BajarVida();
     obstaculo2= new  Obstaculo2();
    }  
    
    if(caballito.getVida() == 0)
      {
         print("Perdiste!");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 2;
    } 
   }
  }

//---------------------Bajar vida obstaculo2 nivel 1 ------------------------//

  void Bajarvidaa() {
    
    if (obstaculo3.getPosX() < caballito.x+50
     && obstaculo3.getPosX() > caballito.x-50
     && obstaculo3.getPosY() < caballito.y+50
     && obstaculo3.getPosY() > caballito.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
     
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito.BajarVida();
     obstaculo3= new  Obstaculo3();
  
    }    
    if(caballito.getVida() == 0)
      {
        print("Perdiste!");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 2;
    } 
   }
  }

//---------------------Sumar Puntaje nivel 1 ------------------------//
  
  void SumaPuntaje() {
    
     if (lechuga.getPosX() < caballito.x+50
     &&  lechuga.getPosX() > caballito.x-50
     &&  lechuga.getPosY() < caballito.y+50
     &&  lechuga.getPosY() > caballito.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
    
      file = new SoundFile(this, "moneda.mp3");
      file.play();
      println("Moneda");
      caballito.SubirPuntaje();
      lechuga= new  Lechuga();
    } 
    
     if(caballito.getPuntaje() == 6)
     {
        println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 3;
     } 
   }
  }

//---------------------Bajar vida obstaculo1 nivel 2 ------------------------//

  void Bajarvida2() {
    
    if (obstaculo.getPosX() < caballito2.x+100
     && obstaculo.getPosX() > caballito2.x-100
     && obstaculo.getPosY() < caballito2.y+50
     && obstaculo.getPosY() > caballito2.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
      file = new SoundFile(this, "golpe.mp3");
      file.play();
      println("Baja vida");
      caballito2.BajarVida2();
      obstaculo= new  Obstaculo();
    }  
    if(caballito2.getVida2() == 0)
      {
       print("Perdiste");
       file = new SoundFile(this, "gameOver.mp3");
       file.play();
       pantalla = 5;
    }  
   }
  }

//---------------------Bajar vida obstaculo2 nivel 2 ------------------------//
  
  void Bajarvidaa2() {
    
    if (obstaculo2.getPosX() < caballito2.x+100
     && obstaculo2.getPosX() > caballito2.x-100
     && obstaculo2.getPosY() < caballito2.y+50
     && obstaculo2.getPosY() > caballito2.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito2.BajarVida2();
     obstaculo2= new  Obstaculo2();
    }    
    if(caballito2.getVida2() == 0)
      {
        print("Perdiste");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 5; 
    } 
   }
  }

//---------------------Bajar vida obstaculo3 nivel 2 ------------------------//

  void Bajarvidaaa2() {
    
    if (obstaculo3.getPosX() < caballito2.x+100
     && obstaculo3.getPosX() > caballito2.x-100
     && obstaculo3.getPosY() < caballito2.y+50
     && obstaculo3.getPosY() > caballito2.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito2.BajarVida2();
     obstaculo3= new  Obstaculo3();
    }   
    if(caballito2.getVida2() == 0)
      {
        print("Perdiste!");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 5;
    } 
   }
  }
//---------------------Bajar vida obstaculo4 nivel 2 ------------------------//
  void Bajarvidaaaa2() {
    
    if (obstaculo4.getPosX() < caballito2.x+100
     && obstaculo4.getPosX() > caballito2.x-100
     && obstaculo4.getPosY() < caballito2.y+50
     && obstaculo4.getPosY() > caballito2.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   } else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito2.BajarVida2();
     obstaculo4= new  Obstaculo4();
    }   
    if(caballito2.getVida2() == 0)
      {
        print("Perdiste!");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 5; 
    } 
   }
  }

//---------------------Puntaje obstaculo1 nivel 2 ------------------------//
  void SumaPuntaje2() {
    
     if (fruta.getPosX() < caballito2.x+100
     &&  fruta.getPosX() > caballito2.x-100
     &&  fruta.getPosY() < caballito2.y+50
     &&  fruta.getPosY() > caballito2.y-50 
     ){  
   if(caballito2.getInvencible() == true)  {
       activado = false;
   } else {
      file = new SoundFile(this, "moneda.mp3");
      file.play();
      println("Moneda");
      caballito2.SubirPuntaje2();
      fruta= new  Fruta();
    }  
     if(caballito2.getPuntaje2() == 5)
     {
        println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 6;
     } 
    
   }
  }

//---------------------Puntaje obstaculo2 nivel 2 ------------------------//
  void SumaPuntaje3() {
    
     if (lechuga.getPosX() < caballito2.x+100
     &&  lechuga.getPosX() > caballito2.x-100
     &&  lechuga.getPosY() < caballito2.y+50
     &&  lechuga.getPosY() > caballito2.y-50 
     ){  
   if(caballito2.getInvencible() == true)  {
       activado = false;
   } else {
     file = new SoundFile(this, "moneda.mp3");
     file.play();
     println("Moneda");
     caballito2.SubirPuntaje2();
     lechuga= new  Lechuga();
    } 
     if(caballito2.getPuntaje2() == 5)
     {
       println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 6;
     } 
   }
  }
//---------------------Puntaje obstaculo3 nivel 2 ------------------------//
  void SumaPuntaje4() {
    
     if (zanahoria.getPosX() < caballito2.x+100
     &&  zanahoria.getPosX() > caballito2.x-100
     &&  zanahoria.getPosY() < caballito2.y+50
     &&  zanahoria.getPosY() > caballito2.y-50 
     ){  
   if(caballito2.getInvencible() == true)  {
       activado = false;
   }else {
     file = new SoundFile(this, "moneda.mp3");
      file.play(s,1);
       println("Moneda");
      caballito2.SubirPuntaje2();
    // setPuntaje(this.puntaje +=1);
     zanahoria= new  Zanahoria();
    } 
    
     if(caballito2.getPuntaje2() == 5)
     {
       println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 6;
     } 
    
   }
  }
  
  //---------------------Bajar vida obstaculo1 nivel 3 ------------------------//

  void Bajarvida3() {
    
    if (obstaculo.getPosX() < caballito3.x+100
     && obstaculo.getPosX() > caballito3.x-100
     && obstaculo.getPosY() < caballito3.y+50
     && obstaculo.getPosY() > caballito3.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   }else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito3.BajarVida3();
     obstaculo= new  Obstaculo();
    }  
    
    if(caballito3.getVida3() == 0)
      {
      print("Perdiste");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 8;
    }  
   }
  }

//---------------------Bajar vida obstaculo2 nivel 3 ------------------------//
  
  void Bajarvidaa3() {
    
    if (obstaculo2.getPosX() < caballito3.x+100
     && obstaculo2.getPosX() > caballito3.x-100
     && obstaculo2.getPosY() < caballito3.y+50
     && obstaculo2.getPosY() > caballito3.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   }else {
      file = new SoundFile(this, "golpe.mp3");
      file.play();
     println("Baja vida");
   
     //sonido_impacto.trigger();
     caballito3.BajarVida3();
     obstaculo2= new  Obstaculo2();
    }  
    
    if(caballito3.getVida3() == 0)
      {
         print("Perdiste");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 8;
      
    } 
   }
  }

//---------------------Bajar vida obstaculo3 nivel 3------------------------//

  void Bajarvidaaa3() {
    
    if (obstaculo3.getPosX() < caballito3.x+100
     && obstaculo3.getPosX() > caballito3.x-100
     && obstaculo3.getPosY() < caballito3.y+50
     && obstaculo3.getPosY() > caballito3.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   }else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito3.BajarVida3();
     obstaculo3= new  Obstaculo3();
    }  
    
    if(caballito3.getVida3() == 0)
      {
        print("Perdiste!");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 8;
    } 
   }
  }
//---------------------Bajar vida obstaculo4 nivel 3 ------------------------//
  void Bajarvidaaaa3() {
    
    if (obstaculo4.getPosX() < caballito3.x+100
     && obstaculo4.getPosX() > caballito3.x-100
     && obstaculo4.getPosY() < caballito3.y+50
     && obstaculo4.getPosY() > caballito3.y-50 
     ){  
   if(caballito.getInvencible() == true)  {
       activado = false;
   }else {
     file = new SoundFile(this, "golpe.mp3");
     file.play();
     println("Baja vida");
     caballito3.BajarVida3();
     obstaculo4= new  Obstaculo4();
    }  
    
    if(caballito3.getVida3() == 0)
      {
        print("Perdiste!");
        file = new SoundFile(this, "gameOver.mp3");
        file.play();
        pantalla = 8;
    } 
   }
  }

//---------------------Puntaje obstaculo1 nivel 3 ------------------------//
  void SumaPuntaje5() {
    
     if (fruta.getPosX() < caballito3.x+100
     &&  fruta.getPosX() > caballito3.x-100
     &&  fruta.getPosY() < caballito3.y+50
     &&  fruta.getPosY() > caballito3.y-50 
     ){  
   if(caballito3.getInvencible() == true)  {
       activado = false;
   }else {
      file = new SoundFile(this, "moneda.mp3");
      file.play();
      println("Moneda");
      caballito3.SubirPuntaje3();
      fruta= new  Fruta();
    } 
     if(caballito3.getPuntaje3() == 5)
     {
       println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 9;
     } 
   }
  }

//---------------------Puntaje obstaculo2 nivel 3 ------------------------//
  void SumaPuntaje6() {
    
     if (lechuga.getPosX() < caballito3.x+100
     &&  lechuga.getPosX() > caballito3.x-100
     &&  lechuga.getPosY() < caballito3.y+50
     &&  lechuga.getPosY() > caballito3.y-50 
     ){  
   if(caballito3.getInvencible() == true)  {
       activado = false;
   } else {
    file = new SoundFile(this, "moneda.mp3");
    file.play();
    println("Moneda");
    caballito3.SubirPuntaje3();
    lechuga= new  Lechuga();
    } 
     if(caballito3.getPuntaje3() == 5)
     {
       println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 9;
     } 
   }
  }
//---------------------Puntaje obstaculo3 nivel 3 ------------------------//
  void SumaPuntaje7() {
    
     if (zanahoria.getPosX() < caballito3.x+100
     &&  zanahoria.getPosX() > caballito3.x-100
     &&  zanahoria.getPosY() < caballito3.y+50
     &&  zanahoria.getPosY() > caballito3.y-50 
     ){  
   if(caballito3.getInvencible() == true)  {
       activado = false;
   }else {
     file = new SoundFile(this, "moneda.mp3");
      file.play();
       println("Moneda");
      caballito3.SubirPuntaje3();
    // setPuntaje(this.puntaje +=1);
     zanahoria= new  Zanahoria();
    } 
    
     if(caballito3.getPuntaje3() == 5)
     {
       println("Ganaste!");
       file = new SoundFile(this, "ganador.mp3");
       file.play();
       pantalla = 9;
     } 
    
   }
  }

//--------------------- Invencibilidad ------------------------//

void Invencibilidad()
{
 if(impacto)
 {
   caballito.BajarVida();
   caballito.setInvencible(true);
   tiempoInvencible++;
   if(tiempoInvencible > 200)
   {
   impacto = false;
   tiempoInvencible = 0;
   caballito.setInvencible(false);
   activado = false;
   }
 }
}  

  

class Obstaculo2 {

  PImage Arbusto;
  float posX;
  float posY;
  float desp;
  float tam;

  Obstaculo2() {
    
     posY = 00.73*height;
     posX = 1300;
     tam = random(70,100);
     desp = random(5.0, 3.0);
   
  }
  
  float getPosX() {
    return posX;
  }

  float  getPosY() {
    return posY;
  }
  
  void mover() {
 
   posX = posX - height/50;
  }

  void detener() {
    posX = height +800;
    posY = width +800;
  }
  
  void display() {
  
    imageMode(CENTER);
    Arbusto = loadImage("Arbusto1.png");
    image (Arbusto, posX, posY,tam, tam);
    
  }

boolean nacer () {

    if (posX == height/-10){
      return true;
    } else 
    return false;
  }
}

class Obstaculo {
 
  PImage Arbusto;
  float posX;
  float posY;
  float desp;
  float tam;

  Obstaculo() {
     posY = 00.73*height;
     posX = 1000;
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
    Arbusto = loadImage("PlantaMala.png");
    image (Arbusto, posX, posY,tam, tam);
    
  }

boolean nacer () {

    if (posX == height/-10){
      return true;
    } else 
    return false;
  } 
}

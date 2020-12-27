class Lechuga {

  PImage Lechuga;
  float posX;
  float posY;
  float desp;
  float tam;

  Lechuga() {
     posY = 00.77*height;
     posX = 1700;
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
    Lechuga = loadImage("Lechuga.png");
    image (Lechuga, posX, posY,50, 50);
    
  }

  boolean nacer () {
  
    if (posX == height/-10){
      return true;
    } else 
    return false;
  }
}

//--------------------------Clase-----------------------//

class Caballito {
   float x, y, grav, velo, P;
   float posX,posY;
   PImage [] Caballo;
   int pos;
   String nombre;
   private boolean invencible;
   private int vida, tiempo, velocidad = 4 ;
   private int  puntaje ;
   public Caballito() {
    x = 100;
    y = 100;
    grav = 10;
    velo = 10;
    pos = 0;
    Caballo = new PImage[8];
    nombre = "Caballo";
    Caballo[0] = loadImage("caballo1.png");
    Caballo[1] = loadImage("caballo2.png");
    Caballo[2] = loadImage("caballo3.png");
    Caballo[3] = loadImage("caballo4.png");
    Caballo[4] = loadImage("caballo5.png");
    Caballo[5] = loadImage("caballo6.png");
    Caballo[6] = loadImage("caballo7.png");
    Caballo[7] = loadImage("caballo8.png");
  }
  
  void mostrar() {
      
      if(tiempo == velocidad)
    {
       pos++;
       tiempo = 0;
      if(pos == 8)
      {
        pos =0;
      }   
    }
     tiempo ++;  
     
     pushMatrix(); 
     image(Caballo[pos], x, y, 200, 139);
     popMatrix(); 
  }
  
  //--------------------------Metodos Get y Set-------------------------//
  
  public float getX()
{
 return this.posX; 
}

public void setInvencible(boolean invencible)
{
  this.invencible = invencible;
}

public boolean getInvencible()
{
 return this.invencible;
}

public void setPuntaje(int puntaje)
{
 this.puntaje = puntaje; 
}

public int getPuntaje()
{
  return this.puntaje;
}

public void SubirPuntaje()
{
  this.puntaje +=1;
 }


public void setVida(int vida)
{
 this.vida = vida; 
}

public int getVida()
{
  return this.vida;
}

public void BajarVida()
{
 if(invencible == false){
  
  this.vida -=20;
 }
   
}

 void setPosX(float newX) {
    posX = newX;
  }

  void setPosY(float newY) {
    posY = newY;
  }

  
  void mover() {

 //---------------Se resta 10 al alto de la imagen--------------------//
    if (y+150<500) 
      y+= grav;
  }

  //---------------------- Movimientos horizontales-----------------// 

  void moverIzq() {
    if(control == 52){
        println("Izquierda");
    if (pos < 500) {
      x-= velo;
    }
   }
  }

  void moverDer() {
    if(control==53){
        println("Derecha");
    if (pos < 500) {
      x+= velo;
    }
    }
  }

  //--------------- Salto ------------------//
  void salto() {

 if (control==51)  {
    println("Salto");
    if (posX> width-60)
      // x+= velo;
      pos++;
    if (pos >60)
      pos = 1;
    if (pos > 60)
      x-= velo;
    if (pos <60)
    {
      pos = 0;
      y -= 60;
    }
  }
 }
   
  boolean nacer () {
  
    if (posX == height/-10){
      return true;
    } else 
    return false;
  }
}

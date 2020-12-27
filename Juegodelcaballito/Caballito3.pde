//--------------------------Clase-----------------------//

class Caballito3 {
  
  float x, y, grav, velo, P;
  float posX,posY;
  PImage [] Caballo3;
  int pos;
  String nombre;
  private boolean invencible;
  private int vida, tiempo, velocidad = 4 ;
  private int  puntaje ;
   
  public Caballito3() {
    x = 100;
    y = 100;
    grav = 10;
    velo = 10;
    pos = 0;
    Caballo3 = new PImage[7];
    nombre = "Caballo";
    Caballo3[0] = loadImage("ImgCaballo1.png");
    Caballo3[1] = loadImage("ImgCaballo2.png");
    Caballo3[2] = loadImage("ImgCaballo3.png");
    Caballo3[3] = loadImage("ImgCaballo4.png");
    Caballo3[4] = loadImage("ImgCaballo5.png");
    Caballo3[5] = loadImage("ImgCaballo6.png");
    Caballo3[6] = loadImage("ImgCaballo7.png");
  }
  void mostrar() {
    
      if(tiempo == velocidad)
  {
   pos++;
  tiempo = 0;
    if(pos == 7)
    {
      pos =0;
    }
      
   }
     tiempo ++;  
     
    pushMatrix(); 
    image(Caballo3[pos], x, y, 200, 139);
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

public void setPuntaje3(int puntaje)
{
 this.puntaje = puntaje; 
}

public int getPuntaje3()
{
  return this.puntaje;
}

public void SubirPuntaje3()
{
  this.puntaje +=1;
 }


public void setVida3(int vida)
{
 this.vida = vida; 
}

public int getVida3()
{
  return this.vida;
}

public void BajarVida3()
{
 if(invencible == false)
 {
  this.vida -=20;
 }
   
}

 void setPosX(float newX) {
    posX = newX;
  }

  void setPosY(float newY) {
    posY = newY;
  }

     //---------------Se resta 10 al alto de la imagen--------------------//
  void mover() {

    if (y+150<500) 
      y+= grav;
  }
  
  //---------------------- Movimientos horizontales-----------------// 

  void moverIzqu() {
    if(control == 52){
        println("Izquierda");
    if (pos < 500) {
      x-= velo;
    }
   }
  }

  void moverDere() {
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

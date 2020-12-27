//--------------------------Clase-----------------------//

class Caballito2 {
  
  float x, y, grav, velo, P;
  float posX,posY;
  PImage [] Caballo2;
  int pos;
  String nombre;
  private boolean invencible;
  private int vida, tiempo, velocidad = 4 ;
  private int  puntaje ;
   
  public Caballito2() {
    x = 100;
    y = 100;
    grav = 10;
    velo = 10;
    pos = 0;
    Caballo2 = new PImage[7];
    nombre = "Caballo";
    Caballo2[0] = loadImage("ImagenCaballo1.png");
    Caballo2[1] = loadImage("ImagenCaballo2.png");
    Caballo2[2] = loadImage("ImagenCaballo3.png");
    Caballo2[3] = loadImage("ImagenCaballo4.png");
    Caballo2[4] = loadImage("ImagenCaballo5.png");
    Caballo2[5] = loadImage("ImagenCaballo6.png");
    Caballo2[6] = loadImage("ImagenCaballo7.png");
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
   image(Caballo2[pos], x, y, 200, 139);
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

public void setPuntaje2(int puntaje)
{
 this.puntaje = puntaje; 
}

public int getPuntaje2()
{
  return this.puntaje;
}

public void SubirPuntaje2()
{
  this.puntaje +=1;
 }


public void setVida2(int vida)
{
 this.vida = vida; 
}

public int getVida2()
{
  return this.vida;
}

public void BajarVida2()
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
    if(keya == 52){
        println("Izquierda");
    if (pos < 500) {
      x-= velo;
    }
   }
  }

  void moverDere() {
    if(keya==53){
        println("Derecha");
    if (pos < 500) {
      x+= velo;
    }
    }
  }

  //--------------- Salto ------------------// 
  void salto() {

 if (keya==51)  {
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

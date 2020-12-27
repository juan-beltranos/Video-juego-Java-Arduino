// constants won't change. They're used here to 
char val; // Data received from the serial por
int ledPin = 13; // Set the pin to digital I/O 13
boolean ledState = LOW; //to toggle our LED
int enablePin = 10;
int in1Pin = 9;
int in2Pin = 8;
boolean reverse = true ;

// set pin numbers:
const int buttonPin2 = 2;     // the number of the pushbutton pin
const int buttonPin3 = 3;     // the number of the pushbutton pin
const int buttonPin4 = 4;     // the number of the pushbutton pin
const int buttonPin5 = 5;     // the number of the pushbutton pin


// variables will change:
int buttonState2 = 0;         // variable for reading the pushbutton status
int buttonState3 = 0;         // variable for reading the pushbutton status
int buttonState4 = 0;         // variable for reading the pushbutton status
int buttonState5 = 0;         // variable for reading the pushbutton status

void setup() {
  pinMode(in1Pin, OUTPUT);
  pinMode(in2Pin, OUTPUT);
  pinMode(enablePin, OUTPUT);
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);      
  // initialize the pushbutton pin as an input:
  pinMode(buttonPin2, INPUT);  
  pinMode(buttonPin3, INPUT);  
  pinMode(buttonPin4, INPUT);  
  pinMode(buttonPin5, INPUT);   
 
  Serial.begin(9600);  
}

void loop(){
  // read the state of the pushbutton value:
  buttonState2 = digitalRead(buttonPin2);
  buttonState3 = digitalRead(buttonPin3);
  buttonState4 = digitalRead(buttonPin4);  
  buttonState5 = digitalRead(buttonPin5);

    if (Serial.available() > 0) { // If data is available to read,
    val = Serial.read(); // read it and store it in val

    if (  val == '1')
    {
      int speed = 200 ;
      setMotor(speed, !reverse);
    }
    else
    {
      int speed = 0 ;
      setMotor(speed, reverse);
    }
  }
  
  switch (buttonState2) {
     case HIGH:     
        digitalWrite(ledPin, LOW); 
        Serial.println(2, DEC); 
        delay(1000);
     
       break;
     case LOW:    
         // turn LED off:
        digitalWrite(ledPin, LOW);
       break;
   }
 
   
  switch (buttonState3) {
     case HIGH:    
        digitalWrite(ledPin, HIGH);  
        delay(100);
        digitalWrite(ledPin, LOW); 
        Serial.println(3, DEC); 
        delay(1000);
      
       break;
     case LOW:    
         // turn LED off:
        digitalWrite(ledPin, LOW);
       break;
   }
 
   
  switch (buttonState4) {
     case HIGH:    
        digitalWrite(ledPin, HIGH);  
        delay(100);
        digitalWrite(ledPin, LOW); 
        Serial.println(4, DEC); 
        delay(1000);
    
       break;   
     case LOW:    
         // turn LED off:
        digitalWrite(ledPin, LOW);
       break;
   }
 
    
  switch (buttonState5) {
     case HIGH:    
        digitalWrite(ledPin, HIGH);  
        delay(100);
        digitalWrite(ledPin, LOW); 
        Serial.println(5, DEC); 
        delay(1000);
      
       break;
     case LOW:    
         // turn LED off:
        digitalWrite(ledPin, LOW);
       break;
   }
  
}
void setMotor(int speed, boolean reverse)
{
  analogWrite(enablePin, speed);
  digitalWrite(in1Pin, ! reverse);
  digitalWrite(in2Pin, reverse);
}

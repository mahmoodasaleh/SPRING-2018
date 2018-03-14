
int receive1;

#include <SoftwareSerial.h>


// Motors

int MW1 = 9;
int MW2 = 10;
int MW3 =3;
int Dir1 = 8;
int Dir2 = 11;
int Dir3 = 2;

void forward(){
  analogWrite(10, 250);
  analogWrite(9, 250);
  analogWrite(3, 0);
  digitalWrite(11, HIGH);
  digitalWrite(8, LOW);
  digitalWrite(2, LOW);

}
void back(){
  analogWrite(10, 250);
  analogWrite(9, 250);
  analogWrite(3, 0);
  digitalWrite(11, LOW);
  digitalWrite(8, HIGH);
  digitalWrite(2, LOW);

}

void right(){
  analogWrite(10, 250);
  analogWrite(9, 0);
  analogWrite(3, 0);
  digitalWrite(11, LOW);
  digitalWrite(8, LOW);
  digitalWrite(2, LOW);

}

void left(){
  analogWrite(10, 0);
  analogWrite(9, 250);
  analogWrite(3, 0);
  digitalWrite(11, LOW);
  digitalWrite(8, LOW);
  digitalWrite(2, LOW);

}

void rotate(){
  analogWrite(10, 250);
  analogWrite(9, 250);
  analogWrite(3, 250);
  digitalWrite(11, LOW);
  digitalWrite(8, LOW);
  digitalWrite(2, LOW);
}

void circle(){
  analogWrite(10, 250);
  analogWrite(9, 250);
  analogWrite(3, 0);
  digitalWrite(11, LOW);
  digitalWrite(8, LOW);
  digitalWrite(2, LOW);
}



SoftwareSerial OmniBlurtooth(A2, A3); //A2 Rx A3 Tx

void setup() {
    Serial.begin(9600);          // initiete the signal for blutooth moule:
  
    while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  OmniBlurtooth.begin(4800);
  OmniBlurtooth.println("Virtual Serial Pins Test");

    
}

/****************************************/
// loop()
void loop() {

  if(OmniBlurtooth.available())
  {
  receive1 =Serial.read();
 receive1 = OmniBlurtooth.read();
 OmniBlurtooth.println("Virtual Serial Pins Test");
 Serial.println(receive1);
 }

  if(receive1=='F')
  {
  forward();
 // Omni.setCarAdvance(100);
 //analogWrite(9, 250);
  Serial.println("Robot Moving Forward");
  }
 else if(receive1=='B')
  {  
    back();
    //analogWrite(3, 250);

    //Omni.setCarLeft(100);
  Serial.println("Robot Moving Backward");
  }
  else if(receive1=='R')
  {
    right();
    //analogWrite(10, 250);
   // Omni.setCarRight(100);

Serial.println("Robot Turning Right");
  }

 
  else if(receive1=='L')
  {
    left();
    Serial.println("Signal is L");

  
  }

   else if(receive1=='C')
  {
    Serial.println("Signal is Circule");

     circle();
  }
   else if(receive1=='T')
  {
    rotate();
    Serial.println("Signal is Rotating");

  
  }
//   else {
//
//    Serial.println("Signal is Off");
//    }
   //Omni.demoActions(100);
    
}


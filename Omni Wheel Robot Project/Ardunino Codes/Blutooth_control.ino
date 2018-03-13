
int receive1;

#include <SoftwareSerial.h>


// Motors

int MW1 = 9;
int MW2 = 10;
int MW3 =3;



SoftwareSerial OmniBlurtooth(12, 13);

void setup() {
    Serial.begin(9600);          // initiete the signal for blutooth moule:
    pinMode(3, OUTPUT);
     pinMode(9, OUTPUT);
      pinMode(10, OUTPUT);
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

 // Omni.setCarAdvance(100);
 analogWrite(9, 250);
  Serial.println("Robot Moving Forward");
  }
 else if(receive1=='B')
  {  
    analogWrite(3, 250);

    //Omni.setCarLeft(100);
  Serial.println("Robot Moving Backward");
  }
  else if(receive1=='R')
  {
    analogWrite(10, 250);
   // Omni.setCarRight(100);

Serial.println("Robot Turning Right");
  }

//  else {
//
//    Serial.println("Signal is Off");
//    }
//  if(receive1=='L')
//  {
// 
//  
//  }
   //Omni.demoActions(100);
    
}


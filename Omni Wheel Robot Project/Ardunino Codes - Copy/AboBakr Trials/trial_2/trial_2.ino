#include <TimerOne.h>

int M1_DIR=2; 
int M1_PWM=3; 
int M1_ENCA=4; 
int M1_ENCB=5;
volatile double counter = 0; 
int aState;
int aLastState;

void setup() {
  Timer1.initialize(50000);  
  Timer1.attachInterrupt(timerIsr);
  // put your setup code here, to run once:
  pinMode(M1_DIR,OUTPUT);  
  pinMode(M1_PWM,OUTPUT);
  pinMode(M1_ENCA,INPUT);  
  pinMode(M1_ENCB,INPUT);
  Serial.begin (9600);
  aLastState = digitalRead(M1_ENCA);
}

void loop() {
  // put your main code here, to run repeatedly:
    digitalWrite(M1_DIR,LOW); 
    analogWrite(M1_PWM,255); 
      
    aState = digitalRead(M1_ENCA); // Reads the "current" state of the M1_ENCA
    // If the previous and the current state of the outputA are different, that means a Pulse has occured
    
    if (aState != aLastState){     
      // If the M1_ENCB state is different to the outputA state, that means the encoder is rotating clockwise
      if (digitalRead(M1_ENCB) != aState) { 
      counter ++;
      } else {
        counter --;
      }        
    } 
    aLastState = aState;   
    //Serial.println(counter);        
}
void timerIsr()
  {      
    Serial.println(counter);
    counter=0;   
  }

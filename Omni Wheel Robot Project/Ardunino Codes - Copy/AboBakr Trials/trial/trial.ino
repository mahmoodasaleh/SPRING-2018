boolean flag=LOW; 

int M1_DIR=2; 
int M1_PWM=3; 
int M1_ENCA=4; 
int M1_ENCB=5;
int counter = 0; 
int aState;
int aLastState;
int time1; 
int time2;

void setup() {
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
  if (flag==LOW)
  {
    time1=millis();
    flag=HIGH;
  }
  if (flag==HIGH){
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
    
    time2=millis();
    
    if (time2-time1>1000){    
      flag=LOW;
      Serial.print("Position: ");
      Serial.println(counter);
      counter=0;    
    }
  }
}

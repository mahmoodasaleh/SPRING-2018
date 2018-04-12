#include <EEPROM.h>

#include <PinChangeInt.h>
#include <PinChangeIntConfig.h>
#include <MotorWheel.h>
#include <PID_Beta6.h>
#include <Omni3WD.h>
// Motors
irqISR(irq1,isr1);
MotorWheel wheel1(9,8,6,7,&irq1);        // Pin9:PWM, Pin8:DIR, Pin6:PhaseA, Pin7:PhaseB

irqISR(irq2,isr2);
MotorWheel wheel2(10,11,14,15,&irq2);    // Pin10:PWM, Pin11:DIR, Pin14:PhaseA, Pin15:PhaseB

irqISR(irq3,isr3);
MotorWheel wheel3(3,2,4,5,&irq3);        // Pin3:PWM, Pin2:DIR, Pin4:PhaseA, Pin5:PhaseB
Omni3WD Omni(&wheel1,&wheel2,&wheel3);
void setup() {
  // put your setup code here, to run once:
    TCCR1B=TCCR1B&0xf8|0x01;    // Pin9,Pin10 PWM 31250Hz
    TCCR2B=TCCR2B&0xf8|0x01;    // Pin3,Pin11 PWM 31250Hz
      Serial.begin(19200);
          Omni.PIDEnable(0.26,0.02,0,10);
     
   
}

void loop() {
Omni.PIDRegulate();
  // put your main code here, to run repeatedly:
Omni.wheelBackSetSpeedMMPS(200);
Omni.wheelRightSetSpeedMMPS(250);
Omni.wheelLeftSetSpeedMMPS(100);
//Omni.setCarAdvance(100);
Serial.print(Omni.wheelBackGetSpeedMMPS(),DEC);
Serial.print("&&");
Serial.print(Omni.wheelRightGetSpeedMMPS(),DEC);
Serial.print("&&");
Serial.println(Omni.wheelLeftGetSpeedMMPS(),DEC);
}

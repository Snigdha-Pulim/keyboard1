

#include <SoftwareSerial.h>

SoftwareSerial BTserial(0, 1);
const int FLEX_PIN1 = A7; 
const int FLEX_PIN2 = A6;
const int FLEX_PIN3 = A5;
const int FLEX_PIN4 = A4;

const float VCC = 4.98; 
const float R_DIV = 10000.0;

// Upload the code, then try to adjust these values to more
// accurately calculate bend degree.
const float STRAIGHT_RESISTANCE = 37300.0; // resistance when straight
const float BEND_RESISTANCE = 90000.0; // resistance at 90 deg
int n1, n2, n3, n4;
void setup() 
{
  Serial.begin(9600);
  BTserial.begin(9600);
  pinMode(FLEX_PIN1, INPUT);
  pinMode(FLEX_PIN2, INPUT);
  pinMode(FLEX_PIN3, INPUT);
  pinMode(FLEX_PIN4, INPUT);
}

void loop() 
{
  // Read the ADC, and calculate voltage and resistance from it
  int flexADC1 = analogRead(FLEX_PIN1);
  int flexADC2 = analogRead(FLEX_PIN2);
  int flexADC3 = analogRead(FLEX_PIN3);
  int flexADC4 = analogRead(FLEX_PIN4);
  
  float flexV1 = flexADC1 * VCC / 1023.0;
  float flexR1 = R_DIV * (VCC / flexV1 - 1.0);

  float flexV2 = flexADC2 * VCC / 1023.0;
  float flexR2 = R_DIV * (VCC / flexV2 - 1.0);
  
  float flexV3 = flexADC3 * VCC / 1023.0;
  float flexR3 = R_DIV * (VCC / flexV3 - 1.0);

  float flexV4 = flexADC4 * VCC / 1023.0;
  float flexR4 = R_DIV * (VCC / flexV4 - 1.0);
//  Serial.println("Resistance: " + String(flexR1) + " ohms");
//  Serial.println("Resistance: " + String(flexR2) + " ohms");
//  Serial.println("Resistance: " + String(flexR3) + " ohms");
 // Serial.println("Resistance: " + String(flexR4) + " ohms");
  // Use the calculated resistance to estimate the sensor's
  // bend angle:
  int angle1 = map(flexR1, STRAIGHT_RESISTANCE, BEND_RESISTANCE,
                   0, 90.0)+3;

  int angle2 = map(flexR2, STRAIGHT_RESISTANCE, BEND_RESISTANCE,
                   0, 90.0)+1;

  int angle3 = map(flexR3, STRAIGHT_RESISTANCE, BEND_RESISTANCE,
                   0, 90.0)+14;

  int angle4 = map(flexR4, STRAIGHT_RESISTANCE, BEND_RESISTANCE,
                   0, 90.0)+10;
    n1=map(angle1, 0, 30, 0, 2); 
    n2=map(angle2, 0, 30, 0, 2); 
    n3=map(angle3, 0, 35, 0, 2); 
    n4=map(angle4, 0, 18, 0, 2);                 

Serial.print(n1);
Serial.print("  ");
Serial.print(n2);
Serial.print("  ");
Serial.print(n3);
Serial.print("  ");
Serial.print(n4);
Serial.print("  ");

//  Serial.print("" + String(angle1) + " degrees  ");
//  Serial.print("" + String(angle2) + " degrees");
//  Serial.print("" + String(angle3) + " degrees");
//  Serial.print("" + String(angle4) + " degrees");
  Serial.println();

if(n1==2 && n2==2 && n3==2 &&n4==2){
  Serial.print("A");
}
else if(n1==0 && n2==0 && n3==0 &&n4==0){
  Serial.print("B");
}
else if(n1==1 && n2==1 && n3==1 &&n4==1){
  Serial.print("C");
}
else if(n1==0 && n2==2 && n3==2 &&n4==2){
  Serial.print("D");
}
else if(n1==2 && n2==0 && n3==0 &&n4==0){
  Serial.print("F");
}
else if(n1==0 && n2==0 && n3==2 &&n4==2){
  Serial.print("H");
}
else if(n1==2 && n2==2 && n3==2 &&n4==0){
  Serial.print("I");
}
else if(n1==1 && n2==1 && n3==1 &&n4==2){
  Serial.print("M");
}
else if(n1==1 && n2==1 && n3==2 &&n4==2){
  Serial.print("N");
}
else if(n1==0 && n2==0 && n3==1 &&n4==2){
  Serial.print("R");
}
else if(n1==1 && n2==0 && n3==0 &&n4==0){
  Serial.print("S");
}
else if(n1==0 && n2==2 && n3==2 &&n4==1){
  Serial.print("Y");
}
else{  
  Serial.print("E");

}
  delay(1000);
}


//Blutooth
#include <SoftwareSerial.h>

SoftwareSerial BTserial(0, 1); // RX | TX


void setup() {

BTserial.begin(9600); }

 
void loop() {


BTserial.print("1234");

BTserial.print(",");

BTserial.print("1234.0");

BTserial.print(",");


BTserial.print("1234 hPa");

//message to the receiving device

delay(20);

}



//MPU6050
#include <Wire.h>
#include <GY6050.h>
 
GY6050 mpu;
 
void setup()
{
Serial.begin(9600);
 
Serial.println("Initialize MPU6050");
while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
{
Serial.println("Error");
delay(1000);
}
pinMode(13, OUTPUT);
 
mpu.setThreshold(2);
}
 
void loop()
{
Vector rawGyro = mpu.readRawGyro();
Vector normGyro = mpu.readNormalizeGyro();
float normal_x = normGyro.XAxis;
float normal_y = normGyro.YAxis;
float normal_z = normGyro.ZAxis;
Serial.print(" Xnorm = ");
Serial.print(normal_x);
Serial.print(" Ynorm = ");
Serial.print(normal_y);
Serial.print(" Znorm = ");
Serial.println(normal_z);
 

delay(10);
}






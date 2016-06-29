/* 

  To be used with a MatLab script called "real_time_2_values.m" to visualize 2 analog sensors in 2 different graphs


  Made by: Luís Afonso
*/

#define SENSOR1_PIN A0
#define SENSOR2_PIN A2

void setup() {
  Serial.begin(115200);

}

void loop() {

  
  int value1 = analogRead(SENSOR1_PIN);
  int value2 = analogRead(SENSOR2_PIN);
    
  Serial.write(value1 & 0xFF);
  Serial.write(value1 >> 8);
  Serial.write(value2 & 0xFF);
  Serial.write(value2 >> 8);
  
  delay(100);
}

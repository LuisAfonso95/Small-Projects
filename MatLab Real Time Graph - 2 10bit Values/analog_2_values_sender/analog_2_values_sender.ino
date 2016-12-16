/* 
  To be used with a MatLab script called "real_time_2_values.m" to visualize 2 analog sensors in 2 different graphs


  Made by: Luís Afonso
*/

#define SENSOR1_PIN 2
#define SENSOR2_PIN 26

#define BUTTON_PIN 32

void setup() {
  Serial.begin(115200);

  pinMode(BUTTON_PIN, INPUT_PULLUP);
  while(digitalRead(BUTTON_PIN) == 1);
  while(digitalRead(BUTTON_PIN) == 0);
  delay(500);
}

void loop() {

  
  int value1 = analogRead(SENSOR1_PIN);
  int value2 = analogRead(SENSOR2_PIN);
  int button_state = 1-digitalRead(BUTTON_PIN);
  Serial.write(value1 & 0xFF);
  Serial.write(value1 >> 8);
  Serial.write(value2 & 0xFF);
  Serial.write(value2 >> 8);
  Serial.write(button_state);
  
  delay(100);
}

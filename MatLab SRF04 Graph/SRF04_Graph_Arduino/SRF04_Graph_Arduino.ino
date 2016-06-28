/*

  This is a code to send by serial the distance measured by a HC-SR04 or SRF04 to a MatLab program.
  MatLab program: "MatLab_SRF04_single_Plot.m"
  
  Made by Luís Afonso

*/


#define echoPin PB_2 //change pin to the number you want
#define trigPin PE_0 //change pin to the number you want

#define BUTTON_PIN PF_0 //change pin to the number you want

void setup()
{

  Serial.begin(115200);
  
  pinMode(BUTTON_PIN, INPUT_PULLUP);
  while(digitalRead(BUTTON_PIN) == HIGH);
  
  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);
}


void loop()
{
  /* Get the distance from the sensor like always */
  long duration, distance;
  digitalWrite(trigPin, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(trigPin, HIGH);
  //  delayMicroseconds(1000); - Removed this line
  delayMicroseconds(10); // Added this line
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = (duration) / 58;

  //for this example we just use 1 byte so we have to keep the value limited to 0-255
  if(distance > 255)
    distance = 255;
    
  //Send the distance in 1 byte (actually sends for example 156, not '1' '5' and '6')
  Serial.write(distance);
  
  
  delay(50);

}






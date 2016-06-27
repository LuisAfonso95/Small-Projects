

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(RED_LED, OUTPUT);
  pinMode(PF_0, INPUT_PULLUP);
  int state = 1;
  int i=0;
  while(digitalRead(PF_0) == 1){
    digitalWrite(RED_LED,state);
    i++;
    delay(10);

    if(i >= 50){
      state ^= 1;
      i = 0;
    }
  }
  digitalWrite(RED_LED,0);
}

void loop()
{
  Serial.write(48);
  // put your main code here, to run repeatedly:
  while(Serial.available() < 3);
  int red = Serial.read();  
  int green = Serial.read();
  int blue = Serial.read();

  analogWrite(RED_LED,red);
  analogWrite(GREEN_LED,green);
  analogWrite(BLUE_LED,blue);

  delay(10);

}




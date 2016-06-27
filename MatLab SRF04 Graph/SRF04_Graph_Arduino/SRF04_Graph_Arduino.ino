#define echoPin PB_2
#define trigPin PE_0

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(PF_0, INPUT_PULLUP);
  pinMode(echoPin, INPUT);
  pinMode(trigPin, OUTPUT);
}

int j;
void loop()
{
  long duration, distance;
  digitalWrite(trigPin, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(trigPin, HIGH);
  //  delayMicroseconds(1000); - Removed this line
  delayMicroseconds(10); // Added this line
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = (duration) / 58;

  Serial.write(distance);
  delay(50);

}






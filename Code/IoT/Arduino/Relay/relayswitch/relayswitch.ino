int pin1 = 7;

void setup() {
  pinMode(pin1, OUTPUT);
  digitalWrite(pin1, HIGH);
}

void loop() {
  digitalWrite(pin1, LOW);
  delay(3000);
  digitalWrite(pin1, HIGH);
  delay(3000);

}


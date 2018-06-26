int TANK = 2;

void setup() {
  pinMode(TANK, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(TANK, LOW);
}

void loop() {
  if (digitalRead(TANK) == HIGH){
    digitalWrite(LED_BUILTIN, HIGH);
  } else {
    digitalWrite(LED_BUILTIN, LOW);
  }
}

volatile int flow_frequency;
unsigned int l_hour;
unsigned int flowsensor_1 = 2;
unsigned long currentTime;
unsigned long cloopTime;

void flow(){
  flow_frequency++;
}

void setup() {
  pinMode(flowsensor_1, INPUT);
  digitalWrite(flowsensor_1, HIGH); // Optional Internal Pull-Up
  Serial.begin(9600);
  attachInterrupt(0, flow, RISING); // Setup Interrupt
  sei(); // Enable interrupts.
  currentTime = millis();
  cloopTime = currentTime;
}

void loop() {
  currentTime = millis();

  if (currentTime >= (cloopTime + 1000)){
    cloopTime = currentTime;
    // Pulse frequency (Hz) = 7.5Q, Q is flow rate in L/min
    l_hour = (flow_frequency * 60 /7.5); // (Pulse frequency * 60) / 7.5Q
    flow_frequency = 0; // Reset Counter
    Serial.print(l_hour, DEC); // Print liters/hour
    Serial.println(" L/hour");
  }
}

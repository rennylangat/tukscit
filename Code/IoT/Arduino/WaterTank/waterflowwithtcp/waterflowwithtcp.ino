/*
  Repeating Web client

 This sketch connects to a a web server and makes a request
 using a Wiznet Ethernet shield. You can use the Arduino Ethernet shield, or
 the Adafruit Ethernet shield, either one will work, as long as it's got
 a Wiznet Ethernet module on board.

 This example uses DNS, by assigning the Ethernet client with a MAC address,
 IP address, and DNS address.

 Circuit:
 * Ethernet shield attached to pins 10, 11, 12, 13

 created 19 Apr 2012
 by Tom Igoe
 modified 21 Jan 2014
 by Federico Vanzati

 http://arduino.cc/en/Tutorial/WebClientRepeating
 This code is in the public domain.

 */

#include <SPI.h>
#include <Ethernet2.h>
#include <stdio.h>
#include <string.h>
//#include <sstream>

// assign a MAC address for the ethernet controller.
// fill in your address here:
byte mac[] = {
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED
};
// fill in an available IP address on your network here,
// for manual configuration:
IPAddress ip(192, 168, 1, 177);

// fill in your Domain Name Server address here:
IPAddress myDns(1, 1, 1, 1);

// initialize the library instance:
EthernetClient client;

//char server[] = "www.arduino.cc";
IPAddress server(192,168,1,101);

unsigned long lastConnectionTime = 0;             // last time you connected to the server, in milliseconds
const unsigned long postingInterval = 10L * 1000L; // delay between updates, in milliseconds
// the "L" is needed to use long type numbers

// Room water use IoT code.
unsigned long currentTime;
unsigned long cloopTime;

// Holdout variables for checking change in flow.
unsigned int old_l_hour_1 = 0;
unsigned int old_l_hour_2 = 0;
unsigned int old_l_hour_3 = 0;
unsigned int old_l_hour_4 = 0;
unsigned int old_l_hour_5 = 0;
unsigned int old_l_hour_6 = 0;
unsigned int old_l_hour_7 = 0;
unsigned int old_l_hour_8 = 0;
unsigned int old_l_hour_9 = 0;
unsigned int old_l_hour_10 = 0;

volatile int flow_frequency_1;
volatile int flow_frequency_2;
volatile int flow_frequency_3;
volatile int flow_frequency_4;
volatile int flow_frequency_5;
volatile int flow_frequency_6;
volatile int flow_frequency_7;
volatile int flow_frequency_8;
volatile int flow_frequency_9;
volatile int flow_frequency_10;

unsigned int flow_sensor_1 = 22;
unsigned int flow_sensor_2 = 23;
unsigned int flow_sensor_3 = 24;
unsigned int flow_sensor_4 = 25;
unsigned int flow_sensor_5 = 26;
unsigned int flow_sensor_6 = 27;
unsigned int flow_sensor_7 = 28;
unsigned int flow_sensor_8 = 29;
unsigned int flow_sensor_9 = 30;
unsigned int flow_sensor_10 = 31;

unsigned int l_hour_1;
unsigned int l_hour_2;
unsigned int l_hour_3;
unsigned int l_hour_4;
unsigned int l_hour_5;
unsigned int l_hour_6;
unsigned int l_hour_7;
unsigned int l_hour_8;
unsigned int l_hour_9;
unsigned int l_hour_10;

void flow1(){
  flow_frequency_1++;
}

void flow2(){
  flow_frequency_2++;
}

void flow3(){
  flow_frequency_3++;
}

void flow4(){
  flow_frequency_4++;
}

void flow5(){
  flow_frequency_5++;
}

void flow6(){
  flow_frequency_6++;
}

void flow7(){
  flow_frequency_7++;
}

void flow8(){
  flow_frequency_8++;
}

void flow9(){
  flow_frequency_9++;
}

void flow10(){
  flow_frequency_10++;
}

void setup() {
  // start serial port:
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // give the ethernet module time to boot up:
  delay(1000);
  // start the Ethernet connection using a fixed IP address and DNS server:
  Ethernet.begin(mac, ip); //, myDns
  // print the Ethernet board/shield's IP address:
  Serial.print("My IP address: ");
  Serial.println(Ethernet.localIP());

  // Water sensors logics
  setPinModes();

  // Enable interrupts.
  //sei();

  currentTime = millis();
  cloopTime = currentTime;
}

void loop() {  
  
  currentTime = millis();

  if (currentTime >= (cloopTime + 1000)){
    flowFreq1();
    delay(1000);
    flowFreq2();
    delay(1000);
    flowFreq3();
    delay(1000);
    flowFreq4();
    delay(1000);
    flowFreq5();
    delay(1000);
    flowFreq6();
    delay(1000);
    flowFreq7();
    delay(1000);
    flowFreq8();
    delay(1000);
    flowFreq9();
    delay(1000);
    flowFreq10();
    delay(1000);
  }
}

// Workout the frequencies maths.
// Pulse frequency (Hz) = 7.5Q, Q is flow rate in L/min
// (Pulse frequency * 60) / 7.5Q
void flowFreq1(){  
  l_hour_1 = (flow_frequency_1 * 60 / 7.5); 
  flow_frequency_1 = 0; // Reset Counter
  Serial.print(l_hour_1, DEC); // Print liters/hour
  Serial.println(" L/hour for room 1");

  // If there is change in water flow, then report. 
  if (old_l_hour_1 != l_hour_1){
    old_l_hour_1 = l_hour_1;
    postRecord(flow_sensor_1, l_hour_1);
  }
}

void flowFreq2(){  
  l_hour_2 = (flow_frequency_2 * 60 / 7.5); 
  flow_frequency_2 = 0; // Reset Counter
  Serial.print(l_hour_2, DEC); // Print liters/hour
  Serial.println(" L/hour for room 2");

  // If there is change in water flow, then report. 
  if (old_l_hour_2 != l_hour_2){
    old_l_hour_2 = l_hour_2;
    postRecord(flow_sensor_2, l_hour_2);
  }
}

void flowFreq3(){  
  l_hour_3 = (flow_frequency_3 * 60 / 7.5); 
  flow_frequency_3 = 0; // Reset Counter
  Serial.print(l_hour_3, DEC); // Print liters/hour
  Serial.println(" L/hour for room 3");

  // If there is change in water flow, then report. 
  if (old_l_hour_3 != l_hour_3){
    old_l_hour_3 = l_hour_3;
    postRecord(flow_sensor_3, l_hour_3);
  }
}

void flowFreq4(){  
  l_hour_4 = (flow_frequency_4 * 60 / 7.5); 
  flow_frequency_4 = 0; // Reset Counter
  Serial.print(l_hour_4, DEC); // Print liters/hour
  Serial.println(" L/hour for room 4");

  // If there is change in water flow, then report. 
  if (old_l_hour_4 != l_hour_4){
    old_l_hour_4 = l_hour_4;
    postRecord(flow_sensor_4, l_hour_4);
  }
}

void flowFreq5(){  
  l_hour_5 = (flow_frequency_5 * 60 / 7.5); 
  flow_frequency_5 = 0; // Reset Counter
  Serial.print(l_hour_5, DEC); // Print liters/hour
  Serial.println(" L/hour for room 5");

  // If there is change in water flow, then report. 
  if (old_l_hour_5 != l_hour_5){
    old_l_hour_5 = l_hour_5;
    postRecord(flow_sensor_5, l_hour_5);
  }
}

void flowFreq6(){  
  l_hour_6 = (flow_frequency_6 * 60 / 7.5); 
  flow_frequency_6 = 0; // Reset Counter
  Serial.print(l_hour_6, DEC); // Print liters/hour
  Serial.println(" L/hour for room 6");

  // If there is change in water flow, then report. 
  if (old_l_hour_6 != l_hour_6){
    old_l_hour_6 = l_hour_6;
    postRecord(flow_sensor_6, l_hour_6);
  }
}

void flowFreq7(){  
  l_hour_7 = (flow_frequency_7 * 60 / 7.5); 
  flow_frequency_7 = 0; // Reset Counter
  Serial.print(l_hour_7, DEC); // Print liters/hour
  Serial.println(" L/hour for room 7");

  // If there is change in water flow, then report. 
  if (old_l_hour_7 != l_hour_7){
    old_l_hour_7 = l_hour_7;
    postRecord(flow_sensor_7, l_hour_7);
  }
}

void flowFreq8(){  
  l_hour_8 = (flow_frequency_8 * 60 / 7.5); 
  flow_frequency_8 = 0; // Reset Counter
  Serial.print(l_hour_8, DEC); // Print liters/hour
  Serial.println(" L/hour for room 8");

  // If there is change in water flow, then report. 
  if (old_l_hour_8 != l_hour_8){
    old_l_hour_8 = l_hour_8;
    postRecord(flow_sensor_8, l_hour_8);
  }
}

void flowFreq9(){  
  l_hour_9 = (flow_frequency_9 * 60 / 7.5); 
  flow_frequency_9 = 0; // Reset Counter
  Serial.print(l_hour_9, DEC); // Print liters/hour
  Serial.println(" L/hour for room 9");

  // If there is change in water flow, then report. 
  if (old_l_hour_9 != l_hour_9){
    old_l_hour_9 = l_hour_9;
    postRecord(flow_sensor_9, l_hour_9);
  }
}

void flowFreq10(){  
  l_hour_10 = (flow_frequency_10 * 60 / 7.5); 
  flow_frequency_10 = 0; // Reset Counter
  Serial.print(l_hour_10, DEC); // Print liters/hour
  Serial.println(" L/hour for room 10");

  // If there is change in water flow, then report. 
  if (old_l_hour_10 != l_hour_10){
    old_l_hour_10 = l_hour_10;
    postRecord(flow_sensor_10, l_hour_10);
  }
}

void postRecord(unsigned int id, unsigned int l_per_hr){
  // if there's incoming data from the net connection.
  // send it out the serial port.  This is for debugging
  // purposes only:  
  if (client.available()) {
    char c = client.read();    
    Serial.write(c);
  }

  String url = "GET /hotel/api/iot/shower/";  
  url += id;
  url += "/";
  url += l_per_hr;
  url += " HTTP/1.1";
  httpRequest(url);
}

void setPinModes(){
  pinMode(flow_sensor_1, INPUT);
  pinMode(flow_sensor_2, INPUT);  
  pinMode(flow_sensor_3, INPUT);  
  pinMode(flow_sensor_4, INPUT);  
  pinMode(flow_sensor_5, INPUT);  
  pinMode(flow_sensor_6, INPUT);  
  pinMode(flow_sensor_7, INPUT);  
  pinMode(flow_sensor_8, INPUT);  
  pinMode(flow_sensor_9, INPUT);  
  pinMode(flow_sensor_10, INPUT);

  // Optional Internal Pull-Up
  digitalWrite(flow_sensor_1, HIGH);
  digitalWrite(flow_sensor_2, HIGH);
  digitalWrite(flow_sensor_3, HIGH);
  digitalWrite(flow_sensor_4, HIGH);
  digitalWrite(flow_sensor_5, HIGH);
  digitalWrite(flow_sensor_6, HIGH);
  digitalWrite(flow_sensor_7, HIGH);
  digitalWrite(flow_sensor_8, HIGH);
  digitalWrite(flow_sensor_9, HIGH);
  digitalWrite(flow_sensor_10, HIGH);

  // Setup Interrupt
  attachInterrupt(digitalPinToInterrupt(flow_sensor_1), flow1, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_2), flow2, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_3), flow3, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_4), flow4, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_5), flow5, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_6), flow6, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_7), flow7, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_8), flow8, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_9), flow9, RISING);
  attachInterrupt(digitalPinToInterrupt(flow_sensor_10), flow10, RISING);

  // Enable interrupts.
  interrupts();
}

// this method makes a HTTP connection to the server:
void httpRequest(String url) {
  // Close any connection before send a new request.
  // This will free the socket on the WiFi shield
  client.stop();

  // if there's a successful connection:
  if (client.connect(server, 8080)) {
    Serial.println("connecting...");
    Serial.println(url);
    Serial.println(url);
    
    client.println(url);
    client.println("Host: 192.168.1.101");
    client.println("User-Agent: arduino-ethernet");
    // client.println("Content-Type: application/json");
    client.println("Connection: close");
    client.println();

    // note the time that the connection was made:
    lastConnectionTime = millis();
  }
  else {
    // if you couldn't make a connection:
    Serial.println("Connection failed");
  }
}

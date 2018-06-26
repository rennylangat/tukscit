#include <SPI.h>
#include <Ethernet2.h>
#include <stdio.h>
#include <string.h>

// assign a MAC address for the ethernet controller.
// fill in your address here:
byte mac[] = {
  0xBE, 0xAD, 0xDE, 0xEF, 0xFE, 0xED
};

// fill in an available IP address on your network here,
// for manual configuration:
IPAddress ip(192, 168, 1, 178);

// fill in your Domain Name Server address here:
IPAddress myDns(1, 1, 1, 1);

// initialize the library instance:
EthernetClient client;

//char server[] = "www.arduino.cc";
IPAddress server(192,168,1,101);

unsigned int room_1 = A0;
unsigned int room_2 = A1;
unsigned int room_3 = A2;
unsigned int room_4 = A3;
unsigned int room_5 = A4;
unsigned int room_6 = A5;

volatile int rawVal_1 = 0;
volatile int rawVal_2 = 0;
volatile int rawVal_3 = 0;
volatile int rawVal_4 = 0;
volatile int rawVal_5 = 0;
volatile int rawVal_6 = 0;

const int mVperAmp = 66; // 100 for 20A, 185 for 5A
const int acOffset = 2500;

volatile double volt_1 = 0;
volatile double volt_2 = 0;
volatile double volt_3 = 0;
volatile double volt_4 = 0;
volatile double volt_5 = 0;
volatile double volt_6 = 0;

volatile double amps_1 = 0;
volatile double amps_2 = 0;
volatile double amps_3 = 0;
volatile double amps_4 = 0;
volatile double amps_5 = 0;
volatile double amps_6 = 0;

volatile double old_amps_1 = 0;
volatile double old_amps_2 = 0;
volatile double old_amps_3 = 0;
volatile double old_amps_4 = 0;
volatile double old_amps_5 = 0;
volatile double old_amps_6 = 0;

volatile double old_volts_1 = 0;
volatile double old_volts_2 = 0;
volatile double old_volts_3 = 0;
volatile double old_volts_4 = 0;
volatile double old_volts_5 = 0;
volatile double old_volts_6 = 0;

void setup() {
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }

  // give the enthernet module time to boot up
  delay(1000);

  // Start the Ethernet connection using a fixed IP address and DNS server
  Ethernet.begin(mac, ip);

  // Print
  Serial.print("My IP address: ");
  Serial.println(Ethernet.localIP());

  //setPinModes();
}

void loop() {
  /*
   * PRESERVING THIS CODE
   * float AcsValue=0.0, Samples=0.0, AvgAcs=0.0, AcsValueF=0.0;
  for (int x = 0; x < 150; x++){ // Get 10 samples
    AcsValue = analogRead(A0); // Read current sensor value
    Samples = Samples + AcsValue; // Sum samples
    delay(3); // Let ADC settle before next sample 3ms
  }

  AvgAcs = Samples / 150.0; // Take average of samples

  AcsValueF = (2.5 - (AvgAcs * (5.0 / 1024.0))) / 0.185;

  Serial.print(AcsValueF);
  delay(50);*/

  getAmps1();
  //delay(3000);
  getAmps2();
  //delay(1000);
  getAmps3();
  //delay(1000);
  getAmps4();
  //delay(1000);
  getAmps5();
  //delay(1000);
  getAmps6();
  //delay(1000);*/
}

void setPinModes(){
  pinMode(room_1, INPUT);
  pinMode(room_2, INPUT);
  pinMode(room_3, INPUT);
  pinMode(room_4, INPUT);
  pinMode(room_5, INPUT);
  pinMode(room_6, INPUT);

  // Optional Internal Pull-Up
  //digitalWrite(room_1, LOW);
  //digitalWrite(room_2, LOW);
  //digitalWrite(room_3, LOW);
  //digitalWrite(room_4, LOW);
  //digitalWrite(room_5, LOW);
  //digitalWrite(room_6, LOW);
}

void getAmps1(){
  float avg = 0, acscurr = 0, acvolts;
  
  for (int i = 0; i < 330; i++){
    avg = avg + analogRead(room_1);
    delay(3);
  }

  avg = avg / 330.0;

  acscurr = (2.5 - (avg * (5.0 / 1024))) / 0.066;
  acvolts = (((avg / 1024) * 5000) / 1000) - 2.50;

  Serial.print("V: ");
  Serial.print(acvolts, 3);
  Serial.print(" C: ");
  Serial.println(acscurr, 3);

  if (old_amps_1 != acscurr || old_volts_1 != acvolts){
    old_volts_1 = acvolts;
    old_amps_1 = acscurr;

    postRecord(room_1, acvolts, acscurr);
  }
  
  /*rawVal_1 = analogRead(room_1);
  volt_1 = ((rawVal_1 / 1024.0) * 5000) / 1000; // Get the mV.
  amps_1 = ((volt_1 - acOffset) / mVperAmp);

  Serial.print("mV = ");
  Serial.print(volt_1, 3);
  Serial.print(" Amps = ");
  Serial.println(amps_1);

  if (old_amps_1 != amps_1 || old_volts_1 != volt_1){
    old_volts_1 = volt_1;
    old_amps_1 = amps_1;

    postRecord(room_1, volt_1, amps_1);
  }*/
}

void getAmps2(){
  float avg = 0, acscurr = 0, acvolts;
  
  for (int i = 0; i < 330; i++){
    avg = avg + analogRead(room_2);
    delay(3);
  }

  avg = avg / 330.0;

  acscurr = (2.5 - (avg * (5.0 / 1024))) / 0.066;
  acvolts = (((avg / 1024) * 5000) / 1000) - 2.50;

  Serial.print("V: ");
  Serial.print(acvolts, 3);
  Serial.print(" C: ");
  Serial.println(acscurr, 3);

  if (old_amps_2 != acscurr || old_volts_2 != acvolts){
    old_volts_2 = acvolts;
    old_amps_2 = acscurr;

    postRecord(room_2, acvolts, acscurr);
  }  
}

void getAmps3(){

  float avg = 0, acscurr = 0, acvolts;
  
  for (int i = 0; i < 330; i++){
    avg = avg + analogRead(room_3);
    delay(3);
  }

  avg = avg / 330.0;

  acscurr = (2.5 - (avg * (5.0 / 1024))) / 0.066;
  acvolts = (((avg / 1024) * 5000) / 1000) - 2.50;

  Serial.print("V: ");
  Serial.print(acvolts, 3);
  Serial.print(" C: ");
  Serial.println(acscurr, 3);

  if (old_amps_3 != acscurr || old_volts_3 != acvolts){
    old_volts_3 = acvolts;
    old_amps_3 = acscurr;

    postRecord(room_3, acvolts, acscurr);
  }  
}

void getAmps4(){
  float avg = 0, acscurr = 0, acvolts;
  
  for (int i = 0; i < 330; i++){
    avg = avg + analogRead(room_4);
    delay(3);
  }

  avg = avg / 330.0;

  acscurr = (2.5 - (avg * (5.0 / 1024))) / 0.066;
  acvolts = (((avg / 1024) * 5000) / 1000) - 2.50;

  Serial.print("V: ");
  Serial.print(acvolts, 3);
  Serial.print(" C: ");
  Serial.println(acscurr, 3);

  if (old_amps_4 != acscurr || old_volts_4 != acvolts){
    old_volts_4 = acvolts;
    old_amps_4 = acscurr;

    postRecord(room_4, acvolts, acscurr);
  }  
}

void getAmps5(){
  float avg = 0, acscurr = 0, acvolts;
  
  for (int i = 0; i < 330; i++){
    avg = avg + analogRead(room_5);
    delay(3);
  }

  avg = avg / 330.0;

  acscurr = (2.5 - (avg * (5.0 / 1024))) / 0.066;
  acvolts = (((avg / 1024) * 5000) / 1000) - 2.50;

  Serial.print("V: ");
  Serial.print(acvolts, 3);
  Serial.print(" C: ");
  Serial.println(acscurr, 3);

  if (old_amps_5 != acscurr || old_volts_5 != acvolts){
    old_volts_5 = acvolts;
    old_amps_5 = acscurr;

    postRecord(room_5, acvolts, acscurr);
  }  
}

void getAmps6(){
  float avg = 0, acscurr = 0, acvolts;
  
  for (int i = 0; i < 330; i++){
    avg = avg + analogRead(room_6);
    delay(3);
  }

  avg = avg / 330.0;

  acscurr = (2.5 - (avg * (5.0 / 1024))) / 0.066;
  acvolts = (((avg / 1024) * 5000) / 1000) - 2.50;

  Serial.print("V: ");
  Serial.print(acvolts, 3);
  Serial.print(" C: ");
  Serial.println(acscurr, 3);

  if (old_amps_6 != acscurr || old_volts_6 != acvolts){
    old_volts_6 = acvolts;
    old_amps_6 = acscurr;

    postRecord(room_6, acvolts, acscurr);
  }  
}

void postRecord(unsigned int id, double volts, double amps){
  // if there's incoming data from the net connection.
  // send it out the serial port.  This is for debugging
  // purposes only:  
  if (client.available()) {
    char c = client.read();    
    Serial.write(c);
  }

  String url = "GET /hotel/api/iot/power/";  
  url += id;
  url += "/";
  url += volts;
  url += "/";
  url += amps;
  url += " HTTP/1.1";
  httpRequest(url);
}

// This method makes a HTTP connection to the server.
void httpRequest(String url){
  // Close any connection before send a new request.
  // This will free the socket on the WiFi shield
  client.stop();

  // if there's a successful connection:
  if (client.connect(server, 8080)) {
    Serial.println("connecting...");  
    Serial.println(url);
    
    client.println(url);
    client.println("Host: 192.168.1.101");
    client.println("User-Agent: arduino-ethernet");
    // client.println("Content-Type: application/json");
    client.println("Connection: close");
    client.println();
  }
  else {
    // if you couldn't make a connection:
    Serial.println("Connection failed");
  }
}

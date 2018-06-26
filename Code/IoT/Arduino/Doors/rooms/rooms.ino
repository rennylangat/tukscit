#include <SPI.h>
#include <Ethernet2.h>
#include <stdio.h>
#include <string.h>

const int DOOR_1 = 2;
const int DOOR_2 = 4;
const int DOOR_3 = 7;
const int DOOR_4 = 8;

volatile int STTS_1 = -1;
volatile int STTS_2 = -1;
volatile int STTS_3 = -1;
volatile int STTS_4 = -1;

// assign a MAC address for the ethernet controller.
// fill in your address here:
byte mac[] = {
  0xBA, 0xAD, 0xDE, 0xEF, 0xFE, 0xED
};

// fill in an available IP address on your network here,
// for manual configuration:
IPAddress ip(192, 168, 8, 180);

// fill in your Domain Name Server address here:
IPAddress myDns(1, 1, 1, 1);

// initialize the library instance:
EthernetClient client;

IPAddress server(192,168,8,100);

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
  Serial.print("Door IoT IP address: ");
  Serial.println(Ethernet.localIP());
  
 pinMode(LED_BUILTIN, OUTPUT);
 pinMode(DOOR_1, INPUT_PULLUP);
 pinMode(DOOR_2, INPUT_PULLUP);
 pinMode(DOOR_3, INPUT_PULLUP);
 pinMode(DOOR_4, INPUT_PULLUP);
 
 digitalWrite(DOOR_1, HIGH);
 digitalWrite(DOOR_2, HIGH);
 digitalWrite(DOOR_3, HIGH);
 digitalWrite(DOOR_4, HIGH);
 digitalWrite(LED_BUILTIN, HIGH);
}

void loop() {  

  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);  
  getDoor1Stts();
  //digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  getDoor2Stts();
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  getDoor3Stts();
  //digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
  getDoor4Stts();  
  
}

void getDoor1Stts(){
  int curr = -1;

  if (digitalRead(DOOR_1) == LOW){
    //Serial.print("opened ");
    curr = 1;
  } else {
    curr = 0;
    //Serial.print("closed ");
  }

  if (STTS_1 != curr){
    STTS_1 = curr;
    postRecord(1, curr);
  }
}

void getDoor2Stts(){
  int curr = -1;

  if (digitalRead(DOOR_2) == LOW){
    //Serial.print("opened 2 ");
    curr = 1;
  } else {
    curr = 0;
    //Serial.print("closed 2 ");
  }

  if (STTS_2 != curr){
    STTS_2 = curr;
    postRecord(2, curr);
  }
}

void getDoor3Stts(){
  int curr = -1;

  if (digitalRead(DOOR_3) == LOW){
    //Serial.print("opened 3 ");
    curr = 1;
  } else {
    curr = 0;
    //Serial.print("closed 3 ");    
  }

  if (STTS_3 != curr){
    STTS_3 = curr;
    postRecord(3, curr);
  }
}

void getDoor4Stts(){
  int curr = -1;

  if (digitalRead(DOOR_4) == LOW){
    //Serial.print("opened 4 ");
    curr = 1;
  } else {
    curr = 0;
    //Serial.print("closed 4 ");    
  }

  if (STTS_4 != curr){
    STTS_4 = curr;
    postRecord(4, curr);
  }
}

void postRecord(unsigned int id, int stts){
  // if there's incoming data from the net connection.
  // send it out the serial port.  This is for debugging
  // purposes only:  
  if (client.available()) {
    char c = client.read();    
    Serial.write(c);
  }

  String url = "GET /hotel/api/iot/door/";  
  url += id;
  url += "/";
  url += stts;
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

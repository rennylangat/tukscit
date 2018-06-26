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
IPAddress ip(192, 168, 8, 181);

// fill in your Domain Name Server address here:
IPAddress myDns(1, 1, 1, 1);

// initialize the library instance:
EthernetClient client;

//char server[] = "www.arduino.cc";
IPAddress server(192,168,8,100);

const int c1 = A0;
const int c2 = A1;
const int c3 = A2;
const int c4 = A3;

int mVAmp = 66; // 185 = 5A, 100 = 20A, and 66 for 30A

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
}

void loop() {
  loopPower();  
}

void loopPower(){
  doCurrent(c1);
  doCurrent(c2);
  doCurrent(c3);
  doCurrent(c4);  
}

void doCurrent(int room){
  double volts = getVPP(room);

  // volts = volts - 0.01;

  double vRMS = (volts / 2.0) * 0.707;
  double ampsRMS = ((vRMS * 1000) / mVAmp) - 0.05;

  double effectiveVolts = volts * 10000;
  double effectiveAmps = ampsRMS * 100;  

  postRecord(room, effectiveVolts, effectiveAmps);
}

float getVPP(int room){
  float rst;

  int readValue = 0;
  int maxv = 0;
  int minv = 1024;

  uint32_t s_time = millis();
  while ((millis() - s_time) < 1000){ // loop for a second.
    readValue = analogRead(room);
    if (readValue > maxv){
      maxv = readValue; 
    }

    if (readValue < minv){
      minv = readValue;
    }
  }

  // Done sampling.
  rst = ((maxv - minv) * 5.0) / 1024.0;

  return rst;
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

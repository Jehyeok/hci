import processing.serial.*;     // import the Processing serial library
import processing.net.*;
import http.requests.*;

Server myServer;
Client myClient; 
String inString;
byte interesting = 10;
int val = 0;
Serial myPort;

PImage img_on;
PImage img_off;
int blue = 255;
int red = 0;
int speed = 5;

void setup() {
  size(640, 360);
  // Starts a myServer on port 5204
  myServer = new Server(this, 5204);
//  myClient = new Client(this, "127.0.0.1", 5204); 
  
  img_on = loadImage("on.png");
  img_off = loadImage("off.png");
  
  println(Serial.list());

  //Choose usb adapter
  String portName = Serial.list()[2];
  println("portName:" + portName);
  myPort = new Serial(this, "/dev/tty.AdafruitEZ-Link3f5a-SPP", 9600);

}

void draw() {
  
  background(red, 0, blue);
  
  if ( myPort.available() > 0) {
    String buffer = myPort.readStringUntil('\n');
   
    if (buffer != null) {
     String [] values = split(buffer,'\n');
     int value = parseInt(values[0].trim());
     println(value);
     
     GetRequest get = new GetRequest("http://127.0.0.1:3000/in" + "?a=" + value);
     get.send();
     println("Reponse Content: " + get.getContent());
     println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));

    if(value > 0) {      
      blue = 0;
      red = 255;            
    } else if (value == -1) {
      blue = 255;
      red = 0;
    } 
    }
  } 
  
}

void serverEvent(Server someServer, Client someClient) {
  println("We have a new client: " + someClient.ip());
  Client client = someClient;
  //  Client client = myServer.available();
  // If the client is not null, and says something, display what it said
  if (client !=null) {
    println("isAvailable?: " + client.available());
    String whatClientSaid = client.readString();
    println(client.ip() + "t" + whatClientSaid);
    if (whatClientSaid != null) {
      println(client.ip() + "t" + whatClientSaid);
    } 
    val = (val + 1) % 255;
    background(val);
    print("val: " + val);
  }
}

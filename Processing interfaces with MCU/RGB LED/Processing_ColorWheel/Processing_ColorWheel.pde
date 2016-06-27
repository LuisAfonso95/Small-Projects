/*
  Processing code to control a RGB LED by sending data to a microcontroller by serial
  
  Made by: Luís Afonso
*/

import controlP5.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
ControlP5 cp5;

void setup() {
  fullScreen();
 // size(800, 400);
  cp5 = new ControlP5( this );
  
  int wheel_size = height;
  if(width < height){
    wheel_size = width;
  }
  cp5.addColorWheel("c", width/2-wheel_size/2, height/2-wheel_size/2, wheel_size ).setRGB(color(128, 0, 255));  
  noStroke();

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

int red,green,blue;
void draw() {
  
  
  if(myPort.available() >= 1){
    int received = myPort.read();
    
    myPort.write(red);
    myPort.write(green);
    myPort.write(blue);
  }
  
  int value = cp5.get(ColorWheel.class, "c").getRGB(); 
  red = (value & 0xFF0000) >> 16;
  green = (value & 0xFF00) >> 8;
  blue = (value & 0xFF);
}
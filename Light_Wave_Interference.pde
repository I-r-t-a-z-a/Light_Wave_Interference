/*
  Keywords
    TODO
    DOUBT
    CHANGEABLE
  Questions
    How to set it up.
*/
import g4p_controls.*;
int type = 1; //1: single slit

float y = 0;
final float L = 2;
float wavelength = 380; // CHANGEABLE in nm.
final float yBisector = 400;
final float xBisector = 10;

//Single Slits
float w = 50; // width of slit in micrometers. 1 : 50. range: 1-3.

//Double Slits
float d = 0; // CHANGEABLE


void setup(){
  size(1200,800);
  background(0);
  noLoop(); // since it is more efficient to draw animation when it is changed instead of always doing so.
  
}

void draw(){
  drawSlits();
}

void drawSlits(){
  stroke(255);
  //line(0, 0, 0, height);
  switch (type){
    case 1: // if single slit
      beginShape(LINES);
      vertex(10, 0);
      vertex(xBisector, yBisector - (w/2));
      
      vertex(xBisector, yBisector + (w/2));
      vertex(10, height);
      endShape();
      break;
    default:
      
  }
}

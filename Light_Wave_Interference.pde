/*
  Keywords
    TODO
    DOUBT
    CHANGEABLE
    USELESS
  Questions
*/
// 1 micrometer = 80 px
import g4p_controls.*;
int type = 1; //1: single slit
//int scaleFactorY = 80;

// "LEGIT" values. used in equations
float y = 0; // To be calculated in setup. in micrometers
final float L = 10; // in micrometers
float wavelength = 400; // CHANGEABLE in nm.
final float yBisector = 400; // TODO capitalize since constant?
final float xBisector = 10; // USELESS
int n = 1; // DOUBT. Constructive Interference.

//Scaled values
//float scaledY = y * scaleFactorY;

//Single Slits
float w = 50; // width of slit in micrometers. 1 : 50. range: 1-3.

//Double Slits
float d = 0; // CHANGEABLE


void setup(){
  shapeMode(CENTER);
  size(1200,800);
  background(0);
  y = (L * n * wavelength) / w;
  noLoop(); // since it is more efficient to draw animation when it is changed instead of always doing so.
}

void draw(){
  drawSlits();
  drawRays();
}

void drawSlits(){
  stroke(255);
  switch (type){
    case 1: // if single slit
      beginShape(LINES);
      vertex(10, 0);
      vertex(10, yBisector - (w/2));
      
      vertex(10, yBisector + (w/2));
      vertex(10, height);
      endShape();
      break;
    default:
  }
}

void drawRays(){
  stroke(255);
  switch (type){
    case 1: // if single slit
    while ( !(n * y >= height ) ){ // while the rays are pointing within the screen
      line(xBisector, yBisector, L * 100, yBisector - (n/2)*y); // draws line above perpendicular bisector
      line(xBisector, yBisector, L * 100, (n/2)*y + yBisector); // draws line below perpendicular bisector
      //println("n", n);
      //println("y", y);
      //println("n*y", n*y);
      n++;
    }
    break;
    default:
  }
}

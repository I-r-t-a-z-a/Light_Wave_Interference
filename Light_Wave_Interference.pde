/*
  Keywords
    TODO
    DOUBT
    CHANGEABLE
    USELESS
  Questions
  draw dots at every pixel. see mandelbrot 
*/
import g4p_controls.*;
int type = 1; //1: single slit

int numClicks = 0;

int[] rgb = new int[3];
boolean showHistoryLines = false;

// "LEGIT" values. used in equations
float y = 0; // To be calculated in setup. in micrometers
float L = 10; // in micrometers
float wavelength = 740; // CHANGEABLE in nm.
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
  createGUI();
  size(1200,800);
  background(0);
  noLoop(); // since it is more efficient to draw animation when it is changed instead of always doing so.
}

void draw(){
  //wavelength = wavelengthSlider.getValueI();
  if (!showHistoryLines)
    background(0);
  n = 1;
  y = (L * n * wavelength) / w;
  rgb = wavelengthToRGB(wavelength);
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
  stroke(rgb[0], rgb[1], rgb[2]);
  switch (type){
    case 1: // if single slit
    while ( !(n * y >= height ) ){ // while the rays are pointing within the screen
      line(xBisector, yBisector, L * 100, yBisector - (n/2)*y); // draws line above perpendicular bisector
      line(xBisector, yBisector, L * 100, (n/2)*y + yBisector); // draws line below perpendicular bisector
      line(L * 100, 10, L * 100, height - 10); // draws the line of the detector screen.
      n++;
    }
    break;
    default:
  }
}



static private final double Gamma = 0.80;
static private final double IntensityMax = 255;

public static int[] wavelengthToRGB(double Wavelength) {
    double factor;
    double Red, Green, Blue;

    if((Wavelength >= 380) && (Wavelength < 440)) {
        Red = -(Wavelength - 440) / (440 - 380);
        Green = 0.0;
        Blue = 1.0;
    } else if((Wavelength >= 440) && (Wavelength < 490)) {
        Red = 0.0;
        Green = (Wavelength - 440) / (490 - 440);
        Blue = 1.0;
    } else if((Wavelength >= 490) && (Wavelength < 510)) {
        Red = 0.0;
        Green = 1.0;
        Blue = -(Wavelength - 510) / (510 - 490);
    } else if((Wavelength >= 510) && (Wavelength < 580)) {
        Red = (Wavelength - 510) / (580 - 510);
        Green = 1.0;
        Blue = 0.0;
    } else if((Wavelength >= 580) && (Wavelength < 645)) {
        Red = 1.0;
        Green = -(Wavelength - 645) / (645 - 580);
        Blue = 0.0;
    } else if((Wavelength >= 645) && (Wavelength < 781)) {
        Red = 1.0;
        Green = 0.0;
        Blue = 0.0;
    } else {
        Red = 0.0;
        Green = 0.0;
        Blue = 0.0;
    }

    // Let the intensity fall off near the vision limits

    if((Wavelength >= 380) && (Wavelength < 420)) {
        factor = 0.3 + 0.7 * (Wavelength - 380) / (420 - 380);
    } else if((Wavelength >= 420) && (Wavelength < 701)) {
        factor = 1.0;
    } else if((Wavelength >= 701) && (Wavelength < 781)) {
        factor = 0.3 + 0.7 * (780 - Wavelength) / (780 - 700);
    } else {
        factor = 0.0;
    }


    int[] rgb = new int[3];

    // Don't want 0^x = 1 for x <> 0
    rgb[0] = Red == 0.0 ? 0 : (int)Math.round(IntensityMax * Math.pow(Red * factor, Gamma));
    rgb[1] = Green == 0.0 ? 0 : (int)Math.round(IntensityMax * Math.pow(Green * factor, Gamma));
    rgb[2] = Blue == 0.0 ? 0 : (int)Math.round(IntensityMax * Math.pow(Blue * factor, Gamma));

    return rgb;
}

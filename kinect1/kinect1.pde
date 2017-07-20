//Gigi Miller
//Attempting to use kinect for windows with Open Kinect processing library on a mac
//Shiffman only documents for V1, V2 of regular kinect so idk if this will work

//using example for kinect v1 RGBDepthTest
//https://github.com/shiffman/OpenKinect-for-Processing/blob/master/OpenKinect-Processing/examples/Kinect_v1/RGBDepthTest/RGBDepthTest.pde

//import the kinect library
import org.openkinect.processing.*;
//import org.openkinect.freenecxt.*;

//create the kinect object
Kinect kinect;

float deg;
boolean ir = false;
boolean colorDepth = false;
boolean mirror = false;

void setup() {
  size(1280, 520);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
  kinect.enableColorDepth(colorDepth);

  deg = kinect.getTilt();
}


void draw() {
  background(0);
  image(kinect.getVideoImage(), 0, 0);
  //println(kinect.getDepthImage());
  image(kinect.getDepthImage(), 640, 0);
  fill(255);
  text( "Press 'i' to enable/disable between video image and IR image,  " +
    "Press 'c' to enable/disable between color depth and gray scale depth,  " +
    "Press 'm' to enable/diable mirror mode, "+
    "UP and DOWN to tilt camera   " +
    "Framerate: " + int(frameRate), 10, 515);
}

void keyPressed() {

  if (key == 'i') {
    ir = !ir;
    kinect.enableIR(ir);
  } else if (key =='c') {
    colorDepth = !colorDepth;
    kinect.enableColorDepth(colorDepth);
  } else if (key == 'm') {
    mirror = !mirror;
    kinect.enableMirror(mirror);
  } else if (key == CODED) {
    if (keyCode == UP) {
      deg++;
    } else if (keyCode == DOWN) {
      deg--;
    }
    deg = constrain(deg, 0, 30);
    kinect.setTilt(deg);
  }
}
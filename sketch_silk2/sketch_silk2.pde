// Gigi Miller
// Attempting to Recreate Silk (or make something better)
// June 20th 2017
// trying to connect the two noisy lines


// part one
// draw a noisy line from a point to a point

float p1x, p1y, p2x, p2y; //initialize the two points variables
float STEPS = 10;
float lastx, lasty;
float ynoise, y;
int LENGTH = 100;
int MAG = 60;
float JAGGYT = 4.0;
float JAGGYI = 0.01;
float JAGGYC = 0.5;
int LINE_COUNT = 100;
float current = 0;
float angle = 0;
int currentFrame = 0; 
float[] pp = new float[10];
int iter = 0;

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  ynoise = random(10);
  frameRate(10);
  noFill();

  stroke(255, 50);
}

void draw() {
  //LENGTH  = (int)random(100, 200);
  if (mousePressed) {
    p1x = mouseX;
    p1y = mouseY;
    //if (currentFrame%LINE_COUNT == 0) {
    // angle = random(TWO_PI);
    // } 
    angle = 0;
    pushMatrix();
    translate(p1x, p1y);
    rotate(angle);
    //for (int i = 0; i < LINE_COUNT; i++) {
    //LENGTH  = (int)random(100,200);
    //beginShape();
    //curveVertex(0, 0);
    for (int t = 0; t<STEPS; t++) {
      if (iter > 0) {
        float x = lerp(0, LENGTH, t/10.0);
        float y = MAG*(noise(t * JAGGYT, currentFrame%LINE_COUNT * JAGGYI, current)-0.5); 
        //curveVertex(x, y); //noisy line curve
        curve(x-10, y-10, x, y, pp[iter], pp[iter+1], pp[iter]-10, pp[iter+1]-10); //connecting curve 
        pp[iter] = x;
        pp[iter+1] = y;
        iter += 2;
      }else{
        //deal with the first case..   
      }
    }
    //curveVertex(LENGTH +10, 0);
    endShape();

    popMatrix();
    current = current + JAGGYC;
  }
  currentFrame ++;
}
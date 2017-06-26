// Gigi Miller
// Learning Processing
// Intelligent Agents
// From Generative Design Boook


int NORTH = 0;
int EAST = 1;
int SOUTH = 2;
int WEST = 3;

float posX, posY;
float posXcross, posYcross;

int direction = SOUTH;
float angleCount = 7;    //// 1 - ...
float angle = getRandomAngle(direction);
float stepSize = 3;
int minLength = 10;

// width and brightness of the stroke depend on line length
int dWeight = 50;
int dStroke = 4;

int drawMode = 3;


void setup(){
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100, 100);
  smooth();
  background(360);

  posX = int(random(0, width));
  posY = 5;
  posXcross = posX;
  posYcross = posY;
}


void draw(){
  for (int i=0; i<=mouseX; i++) {

    // ------ draw dot at current position ------
   
      strokeWeight(1);
      stroke(180);
      point(posX, posY);
    

    // ------ make step ------
    posX += cos(radians(angle)) * stepSize;
    posY += sin(radians(angle)) * stepSize;

    // ------ check if agent is near one of the display borders ------
    boolean reachedBorder = false;

    if (posY <= 5) {
      direction = SOUTH;
      reachedBorder = true;
    } 
    else if (posX >= width-5) {
      direction = WEST;
      reachedBorder = true;
    }
    else if (posY >= height-5) {
      direction = NORTH;
      reachedBorder = true;
    }
    else if (posX <= 5) {
      direction = EAST;
      reachedBorder = true;
    }

    // ------ if agent is crossing his path or border was reached ------
    int px = (int) posX;
    int py = (int) posY;
    if (get(px, py) != color(360) || reachedBorder) {
      angle = getRandomAngle(direction);
      float distance = dist(posX, posY, posXcross, posYcross);
      if (distance >= minLength) {
        strokeWeight(distance/dWeight);
        if (drawMode == 1) stroke(0);
        if (drawMode == 2) stroke(52, 100, distance/dStroke);
        if (drawMode == 3) stroke(192, 100, 64, distance/dStroke);
        line(posX, posY, posXcross, posYcross);
      }
      posXcross = posX;
      posYcross = posY;
    }
  }
}


float getRandomAngle(int theDirection) {
  float a = (floor(random(-angleCount, angleCount)) + 0.5) * 90.0/angleCount;

  if (theDirection == NORTH) return (a - 90);
  if (theDirection == EAST) return (a);
  if (theDirection == SOUTH) return (a + 90);
  if (theDirection == WEST) return (a + 180);

  return 0;
}



void keyReleased(){
  if (key == DELETE || key == BACKSPACE) background(360);

  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  if (key == '3') drawMode = 3;
  

  }  
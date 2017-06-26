// Gigi Miller
// Processing Messing around
// DUMB AGENTS 
// From Generative Art Book 


int NORTH = 0;
int NORTHEAST = 1;
int EAST = 2;
int SOUTHEAST = 3;
int SOUTH = 4;
int SOUTHWEST = 5;
int WEST = 6;
int NORTHWEST = 7; 

int stepSize = 2;
int diameter = 25;
int x;
int y;

void setup() {
  size(800,800);
  background(2);
  noStroke();
} 

void draw() {
  for (int i=0; i<=mouseX; i++){
    int direction = (int) random(0,8); 
    
    if (direction == NORTH) {
      y -= stepSize;
    }
    else if (direction == NORTHEAST){
      x += stepSize;
      y -= stepSize;
    }
    else if (direction == EAST){
      x += stepSize;
    }
    else if (direction == SOUTHEAST){
      x += stepSize;
      y +=stepSize;
    }
    else if (direction == SOUTH){
      y += stepSize;
    }
    else if (direction == SOUTHWEST){
      x -= stepSize;
      y += stepSize;
    }
    else if (direction == WEST){
      x -= stepSize;
    }
    else if (direction == NORTHWEST){
      x -= stepSize;
      y -= stepSize;
    }
  }
  
  if (x > width) x = 0;
  if (x < 0 ) x = width;
  if (y < 0) y = height;
  if (y > height) y = 0; 
  
  //int R = (int) random(0, 100);
  //int G = (int) random (0, 100);
  int B = (int) random (175, 255);
  fill( B, 75);
  ellipse(x + stepSize/2, y + stepSize/2, diameter, diameter); 
  
}
 
//gigi miller
//randomness and order


int actRandomSeed = 0;
int count = 150;

void setup(){
  size(800,800);
  cursor(CROSS);
  smooth();
}

void draw(){
  background(255);
  noStroke();
  float faderX = (float) mouseX/width;
  
  randomSeed(actRandomSeed);
  float angle = radians(360/float(count));
  for (int i=0; i<count; i++){
    float randomX = random(0, width);
    float randomY = random(0, height);
    float circleX = width/2 + cos(angle*i)*300;
    float circleY = height/2 + cos(angle*i)*300;
    
    float x = lerp(randomX, circleX, faderX);
    float y = lerp(randomY, circleY, faderX);
    
    fill(0, 130, 164);
    ellipse(x, y, 11, 11);
  }
}

void mouseReleased() {
  actRandomSeed = (int) random(100000);
}
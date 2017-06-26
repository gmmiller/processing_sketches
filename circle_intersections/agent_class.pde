//Gigi Miller
//Agent Class


class Agent { 
  float cx, cy, rad;
  boolean intersecting; 
  
  Agent() {
    cx = mouseX/random(1,20);
    cy = mouseY/random (1,10);
    rad = random(50, 250);  
  }
  
  void update(){
    ellipse(cx, cy, rad, rad); 
  }
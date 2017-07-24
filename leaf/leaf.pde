//leaf sketch

void setup() {
  size(400, 400);
  background(0);
}

void draw() {
  pushMatrix();
  translate(width/4, height/2);
  fill(111, 196, 113,50);
  noStroke();
  strokeWeight(3);

  beginShape();
  vertex(0, 0);
  bezierVertex(0, -50, 100, -25, 100, 0);
  bezierVertex(100, 25, 0, 50, 0, 0);
  endShape();
  stroke(37,66,39,50);
  //stem
  line(-10,0, 90,0);
  //toplines
  line(10,0,20,-15);
  line(30,0,39,-11);
  line(50,0,65,-15);
  line(70,0,77,-10);
  //bottom lines
  //stroke(19, 66, 23,50);
  line(10,0,20,15);
  line(30,0,45,15);
  line(50,0,59,11);
  line(70,0,80,10);
  
  popMatrix();
}
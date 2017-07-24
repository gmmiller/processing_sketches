//gigi miller
//flowers (sketching for final project)


void setup() {
  size(displayWidth, displayHeight);
  background(219,234,252);
  
  noStroke();
}


void draw() {
  fill(179,239,188,10);
  //rect(0,0,width,height);
  pushMatrix();
  translate(random(width),random(height));
  flour((int) random(4,12));
  popMatrix();
}


void flour(int P) {
  fill(199,random(200,252),210);
  ellipseMode(CENTER);
  ellipse(0,0,50,50);
  for (int i = 0; i<P; i++) { 
    pushMatrix();
    ellipseMode(CORNER);
    rotate(radians((360/P)*i));
    fill(random(219),183,226);
    ellipse(0,0, 100, 50);
    fill(252,random(200,245),199);
    ellipse(0,0, 80, 40);
    popMatrix();
  }   
  
}
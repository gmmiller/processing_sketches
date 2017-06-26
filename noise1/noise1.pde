
void setup(){
  size(1024,256);
  
  smooth();
}

void draw(){
  background(255);
  
  stroke(0,130,164);
  strokeWeight(1);
  strokeJoin(ROUND);
  noFill();
  
  int noiseXRange = mouseX/10;
  println("noiseXRange: 0-"+noiseXRange);
  
  beginShape();
  for (int x = 0; x < width; x+=10){
    float noiseX = map(x, 0,width, 0,noiseXRange);
    float y = noise(noiseX) * height;
    vertex(x,y);
  }
  endShape();
  
  
    // dots
  noStroke();
  fill(0);

  for (int x = 0; x < width; x+=10) {
    float noiseX = map(x, 0,width, 0,noiseXRange);
    float y = noise(noiseX) * height;   
    ellipse(x,y,3,3);
  }
}

void mouseReleased() {
  noiseSeed((int) random(100000));
}
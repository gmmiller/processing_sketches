// Gigi Miller
// Circle Intersections
// Phase 1 - programming intersection math for 2 circles that are growing



void setup(){
  size(1200,800);
  background(26,129,219);
  PFont f = createFont("Arial", 20, true);
  textFont(f);
}

void draw(){
  //variables
  int div = 2, intpt = 25;
  float a = 400, b = 400, c = 800, d = 400;
  float xDiff = c - a;
  float yDiff = d - b;
  float dist = dist(a,b,c,d);
  float r = mouseX/div;
  float s = mouseX/div;
  float k = (sq(dist) + sq(r) - sq(s))/(2*dist);
  float iH = sqrt(sq(r) - sq(k));
  float x1 = a + (xDiff*k + yDiff *iH)/dist;
  float y1 = b + (yDiff*k - xDiff *iH)/dist;
  float x2 = a + ((xDiff*k) - yDiff *iH)/dist;
  float y2 = b + ((yDiff*k) + xDiff *iH)/dist;
  
  println(dist, r, s, x1, x2, y1, y2);
  
  //init circles
  fill(26,129,219);
  rect(0, 0, width, height);
  strokeWeight(3);
  stroke(167);
  fill(15,46,73);
  ellipse(a,b, r*2, r*2);
  ellipse(c,d, s*2, s*2);
  
  //math illustrated
  if(dist > r + s){
    text("no Intersection", 600, 750);
  }
  else if(dist < abs(r-s)){
    text("no Intersection", 600, 750);
  }
  //the circles are intersecting
  else {
   text("INTERSECTING!", 600, 50); 
   if(iH == 0){
    text("1 interesection point", 600, 750); 
   }else{
     text("2 intersection points", 600, 750);
   }
   //draw red ellipses at the point of intersections
   fill(209,8,8);
   noStroke();
   ellipse(x1, y1, intpt, intpt);
   ellipse(x2, y2, intpt, intpt);
   
  }
  
  
}
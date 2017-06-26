//Gigi Miller
//Agent Class


class Agent { 
  float cx, cy, rad;
  boolean intersecting; 
  
  Agent() {
    cx =random(20, displayWidth-10);
    cy = random (10, displayHeight-10);
    rad = random(25,125);  
  }
  
  void update(){
   float stepSize = random(5,7);
    int growth = 20;

    
    //growing and shrinking - could be a bit smoother.. 
    rad = rad+ random(-growth, growth)*noise(cx,cy);
    
    //moving 
    cx = cx + stepSize;
    
    
    
    
    //going from one side to the other
    if (cx > width) cx = 0;
    if (cx < 0 ) cx = width;
    if (cy < 0) cy = height;
    if (cy > height) cy = 0; 
    
    
    //draw the circle
    
    ellipse(cx, cy, rad*2, rad*2); 
    
  }
  
  //checks if two circles are intersecting
  void intersectCheck(Agent circle2){
    float a = cx;
    float b = cy;
    float c = circle2.cx;
    float d = circle2.cy;
    float xDiff = c - a;
    float yDiff = d - b;
    float dist = dist(a,b,c,d);
    float r = rad;
    float s = circle2.rad;
    float k = (sq(dist) + sq(r) - sq(s))/(2*dist);
    float iH = sqrt(sq(r) - sq(k));
    float x1 = a + (xDiff*k + yDiff *iH)/dist;
    float y1 = b + (yDiff*k - xDiff *iH)/dist;
    float x2 = a + ((xDiff*k) - yDiff *iH)/dist;
    float y2 = b + ((yDiff*k) + xDiff *iH)/dist;

      
    if( dist > r + s) intersecting = false;
    else if( dist < abs(r-s)) intersecting = false;
    else intersecting = true;
      
    if (intersecting == true){
      if(iH == 0){
        fill(249,252,65);
        ellipse(x1, y1, 500,500);
      }else{
        fill(120,90,random(15,30));
        noStroke();
        //size of intersect based on intersect Height
        float size = iH*.75;
        ellipse(x1, y1, size, size);
        ellipse(x2, y2, size, size);
      }
    }
  }
}
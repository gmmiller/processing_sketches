//Gigi Miller
//Agent Class


class Agent { 
  float cx, cy, rad;
  boolean intersecting; 
  int num;
  
  Agent(int num) {
    cx =random(20, displayWidth-10);
    cy = random (10, displayHeight-10);
    rad = random(25,125);  
    this.num = num;
  }
  
  void update(){
    float stepSize = random(0,7);
    int growth = 5;

    
    //growing and shrinking - could be a bit smoother.. 
    rad = abs(rad + sin((cx+cy)/100)*random(growth));
    
    //moving 
    cx = cx + stepSize;
    
    
    
    
    //going from one side to the other
    if (cx > width) cx = 0;
    if (cx < 0 ) cx = width;
    if (cy < 0) cy = height;
    if (cy > height) cy = 0; 
    
    
    //draw the circle
    
    noStroke();
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

    //println(num, circle2.num);
    if( dist > r + s) {
      intersecting = false;
      //println("\t far", a,b,c,d, r,s, r+s, dist);
    }
    else if( dist < abs(r-s)) {
      intersecting = false;
      //println("\t inclosed");
    }
    else intersecting = true;
      
    if (intersecting == true){
      if(iH == 0){
        fill(249,252,65, 50);
        //ellipse(x1, y1, 500,500);
        //println("\t", x1, y1);
      }else{
        float noiseVal = (50*noise(iH)-1);
        fill(167, 176, 208, 50);
        
        //size of intersect based on intersect Height
        float size = iH;
        //ellipse(x1, y1, size, size/2);
        //ellipse(x2, y2, size, size/2);
        stroke(0);
        strokeWeight(4);
        line(x1,y1,cx,cy);
        line(x2,y2,cx,cy);
        stroke(0,200,0);
        line(x1,y1,circle2.cx,circle2.cy);
        line(x2,y2,circle2.cx,circle2.cy);
        //println("\t", x1, y1, x2, y2);
      }
    }
  }
}
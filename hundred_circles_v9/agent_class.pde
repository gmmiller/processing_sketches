//Gigi Miller
//Agent Class


class Agent { 
  float cx, cy, rad;
  boolean intersecting; 
  int num;
  ArrayList inters = new ArrayList(100);
  int decider = (int) random(0,2);
  

  
  Agent(int num) {
    cx =random(20, displayWidth-10);
    cy = random (10, displayHeight-10);
    rad = random(25,125);  
    this.num = num;
  }
  
  void update(){
    float stepSize = 10;
    int growth = 5;

    
    //growing and shrinking - could be a bit smoother.. 
    //rad = abs(rad + sin((cx+cy)/100)*random(growth));
    
    //moving 
    //int decider = (int) random(0,2);
    if(decider == 1){
      cx += stepSize;
      cy -= stepSize;
    }else{
      cx -= stepSize;
      cy += stepSize;
    }
    
    
    
    //going from one side to the other
    if (cx > width) cx = 0;
    if (cx < 0 ) cx = width;
    if (cy < 0) cy = height;
    if (cy > height) cy = 0; 
    
    
    //draw the circle
    //changing the circles to be blue copies of the image created above
    imageMode(CENTER);
    tint(255,50);
    image(img2, cx, cy); 
    //noStroke();
    //ellipse(cx, cy, rad*2, rad*2); 
    
 
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

    }else if( dist < abs(r-s)) {
      intersecting = false;

    }else {
      intersecting = true;
      //if (!inters.contains(circle2.num)) inters.add(circle2.num);
      println(num, inters.size(), inters);
    }
      
    if (intersecting == true){
      if(iH == 0){
        
      }else{
        //what happens during intersection
        xPS = x1;
        yPS = y1;
        if (!inters.contains(circle2.num)){
          inters.add(circle2.num);
          systems.add(new ParticleSystem(1, new PVector(xPS, yPS)));
        }
      }
    }
  }
}
//Gigi Miller
//One Hundred Circle Intersections
//Attempt One

//number of circles
Agent[] circles = new Agent[50];

void setup(){
  size(displayWidth, displayHeight);
  background(50);
  
  //init circles
  for(int i= 0; i<circles.length; i++) {
    circles[i] = new Agent();
  }
}

void draw(){
  fill(50); 
  rect(0,0, width, height);
  
  fill(127, 50);
  noStroke();
  
  for(int i=0; i<circles.length; i++){
    circles[i].update();
  }
  
  for(int z=0; z<circles.length-1; z++){
    for(int y=z+1; y<circles.length; y++){
      circles[z].intersectCheck(circles[y]);
    }
  }
  
 
}
//Gigi Miller
//One Hundred Circle Intersections
//Attempt One

import java.util.Calendar;

//number of circles
Agent[] circles = new Agent[100];

void setup(){
  size(displayWidth, displayHeight);
  background(126,115,147);
  
  //init circles
  for(int i= 0; i<circles.length; i++) {
    circles[i] = new Agent();
  }
}

void draw(){
  fill(126, 115, 147); 
  rect(0,0, width, height);
  
  fill(127, 50);
  
  for(int i=0; i<circles.length; i++){
    circles[i].update();
  }
  
  for(int z=0; z<circles.length-1; z++){
    for(int y=1; y<circles.length-z; y++){
      circles[z].intersectCheck(circles[z+y]);
    }
  }
  
 
}

void keyReleased() {
  if (key=='p' || key=='P') saveFrame(timestamp()+".png");
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
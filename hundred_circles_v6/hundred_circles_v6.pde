//Gigi Miller
//One Hundred Circle Intersections
//Attempt One

//number of circles
Agent[] circles = new Agent[100];

void setup(){
  size(displayWidth, displayHeight);
  background(7, 36, 55);
  
  //init circles
  for(int i= 0; i<circles.length; i++) {
    circles[i] = new Agent(i);
  }
}

void draw(){
  fill(7, 36, 55); 
  rect(0,0, width, height);
  

  
  for(int i=0; i<circles.length; i++){
    fill(28, 70, 94, 50);
    circles[i].update();
  }
  
  for(int z=0; z<circles.length-1; z++){
    for(int y=z+1; y<circles.length; y++){
      circles[z].intersectCheck(circles[y]);
    }
  }
  
 
}

void keyPressed(){
 if (key == 's'){
   noLoop();
   println("-----------------------------------------------------");
   for(int z=0; z<circles.length-1; z++){
    for(int y=z+1; y<circles.length; y++){
      circles[z].intersectCheck(circles[y]);
    }
  }
 }
 else if (key == 'a'){
   loop();
 }
}
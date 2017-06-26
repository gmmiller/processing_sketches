//Gigi Miller
//One Hundred Circle Intersections


ArrayList<ParticleSystem> systems;

//number of circles
Agent[] circles = new Agent[50];
float xPS, yPS;

    
void setup(){
  size(displayWidth, displayHeight);
  background(7, 36, 55);
  systems = new ArrayList<ParticleSystem>();
 
  //init circles
  for(int i= 0; i<circles.length; i++) {
    circles[i] = new Agent(i);
  }
}

void draw(){
  //background/overlay
  fill(7, 36, 55); 
  rect(0,0, width, height);
  for (ParticleSystem ps : systems) {
    ps.run();
    ps.addParticle();
  }

  //draws the circles
  for(int i=0; i<circles.length; i++){
    fill(28, 70, 94, 60);
    circles[i].update();
  }
  
  //checks for intersections in circles
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
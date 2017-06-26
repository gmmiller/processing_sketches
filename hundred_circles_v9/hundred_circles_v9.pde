//Gigi Miller
//One Hundred Circle Intersections


ArrayList<ParticleSystem> systems;

//number of circles
Agent[] circles = new Agent[20];
float xPS, yPS;
PImage img, img2;
    
void setup(){
  size(displayWidth, displayHeight);
  background(7, 36, 55);
  systems = new ArrayList<ParticleSystem>();
 
  //init circles
  for(int i= 0; i<circles.length; i++) {
    circles[i] = new Agent(i);
  }
    
  //add smoke image
  img = createImage(75,75, ARGB);
  img.loadPixels();
  for (int i=0; i < img.height; i++){
    for(int j=0; j<img.width; j++){
       int h = img.height, w = img.width;
       float distance = dist(w/2, h/2, j, i);
       float alpha = (w/2 - distance);
       if(alpha >= 240) alpha =240;
       img.pixels[i*w+j] = color(255,255,255, alpha);   
    }
  }
  img2 = createImage(200,200, ARGB);
  img2.loadPixels();
  for (int i=0; i < img2.height; i++){
    for(int j=0; j<img2.width; j++){
       int h = img2.height, w = img2.width;
       float distance = dist(w/2, h/2, j, i);
       float alpha = (w/2 - distance);
       if(alpha >= 240) alpha =240;
       img2.pixels[i*w+j] = color(22,105,156, alpha);   
    }
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
    fill(28, 70, 94, 0);
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
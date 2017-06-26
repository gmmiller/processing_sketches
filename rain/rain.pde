//agents 
Agent[] agents = new Agent[10000];


void setup(){
 size(displayWidth, displayHeight, P3D);
 smooth();
 
 //create the agents
 for(int i=0; i<agents.length; i++){
   agents[i] = new Agent();
 }
}

void draw(){
  fill(255, 50);
  noStroke();
  rect(0,0,width,height);
  
  //draw a box


  //color
  stroke(0, random(0,100), random(100,255));
   
  //draw agents
  for(int i=0; i<agents.length; i++) agents[i].update();
}
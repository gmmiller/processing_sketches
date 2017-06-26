import controlP5.*;

// ------ agents ------
Agent[] agents = new Agent[10000]; // create more ... to fit max slider agentsCount
int agentsCount = 4000;
float noiseScale = 300, noiseStrength = 10; 
float overlayAlpha = 3, agentsAlpha = 90, strokeWidth = 0.3;
int drawMode = 1;

// ------ ControlP5 ------
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;


void setup(){
  size(displayWidth,displayHeight,P2D);
  smooth();
  

  //makes all the agents
  for(int i=0; i<agents.length; i++) {
    agents[i] = new Agent();
  }

  setupGUI();
}


void draw(){
  fill(255, overlayAlpha);
  noStroke();
  rect(0,0,width,height);

  stroke(0, random(15,200),random(0,255), agentsAlpha);
  //draw agents
  if (drawMode == 1) {
    for(int i=0; i<agentsCount; i++) agents[i].update1();
  } 
  else {
    for(int i=0; i<agentsCount; i++) agents[i].update2();
  }
  drawGUI();
}


void keyReleased(){
  if(key=='m' || key=='M') {
    showGUI = controlP5.getGroup("menu").isOpen();
    showGUI = !showGUI;
  }
  if (showGUI) controlP5.getGroup("menu").open();
  else controlP5.getGroup("menu").close();

  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;

  if (key == ' ') {
    int newNoiseSeed = (int) random(100000);
    println("newNoiseSeed: "+newNoiseSeed);
    noiseSeed(newNoiseSeed);
  }
  if (key == DELETE || key == BACKSPACE) background(255);
}
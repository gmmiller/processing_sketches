import controlP5.*;
import java.util.Calendar;


// ------ agents ------
int agentsCount = 65;
Agent[] agents = new Agent[1000];
float noiseScale = 950, noiseStrength = 20, noiseSticking = 0.4; 
float minStroke = 1, maxStroke = 12;
int drawMode = 1;
int spaceSizeX = 600, spaceSizeY = 400, spaceSizeZ = 400;

// ------ ControlP5 ------
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;
Range[] ranges;


// ------ mouse interaction ------
int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0, zoom = -450;
float rotationX = 0, rotationY = 0, targetRotationX = 0, targetRotationY = 0, clickRotationX, clickRotationY; 

boolean freeze = false;


// ------ image output ------
boolean saveOneFrame = false;
int qualityFactor = 3;
TileSaver tiler;

void setup(){
  size(1280,800,P3D);
  setupGUI(); 
  colorMode(HSB,360,100,100);
  for(int i=0; i<agents.length; i++) agents[i]=new Agent();
  tiler=new TileSaver(this);
}

void draw(){
  hint(ENABLE_DEPTH_TEST);

  // for high quality output
  if(tiler==null) return; 
  tiler.pre();

  background(0,0,100);
  smooth();
  lights();

  pushMatrix(); 

  // ------ set view ------
  translate(width/2, height/2, zoom); 
  if (mousePressed && mouseButton==RIGHT) {
    offsetX = mouseX-clickX;
    offsetY = mouseY-clickY;
    targetRotationX = min(max(clickRotationX + offsetY/float(width) * TWO_PI, -HALF_PI), HALF_PI);
    targetRotationY = clickRotationY + offsetX/float(height) * TWO_PI;
  }
  rotationX += (targetRotationX-rotationX)*0.25; 
  rotationY += (targetRotationY-rotationY)*0.25;  
  rotateX(-rotationX);
  rotateY(rotationY); 

  noFill();
  stroke(192, 100, 64);
  strokeWeight(1); 
  box(spaceSizeX*2,spaceSizeY*2,spaceSizeZ*2);

  // ------ update and draw agents ------
  for(int i=0; i<agentsCount; i++) {
    if (freeze == false) {
      if (drawMode == 1) agents[i].update1();
      else agents[i].update2();
    } 
    agents[i].draw();
  }
  popMatrix();

  hint(DISABLE_DEPTH_TEST);
  noLights();
  drawGUI();

  // draw next tile for high quality output
  tiler.post();
}


// ------ interactions ------
void keyPressed() {
  if (keyCode == UP) zoom += 20;
  if (keyCode == DOWN) zoom -= 20;
}

void keyReleased() {
  if (key=='s' || key=='S') saveFrame(timestamp()+".png");
  if (key=='f' || key=='F') freeze = !freeze;
  if (key == '1') drawMode = 1;
  if (key == '2') drawMode = 2;
  if (key=='m' || key=='M') {
    showGUI = controlP5.getGroup("menu").isOpen();
    showGUI = !showGUI;
  }
  if (key=='p' || key=='P') tiler.init(timestamp()+".png",qualityFactor);
  if (key == ' ') {
    int newNoiseSeed = (int) random(100000);
    println("newNoiseSeed: "+newNoiseSeed);
    noiseSeed(newNoiseSeed);
  }

  if (showGUI) controlP5.getGroup("menu").open();
  else controlP5.getGroup("menu").close();
}

void mousePressed(){
  clickX = mouseX;
  clickY = mouseY;
  clickRotationX = rotationX;
  clickRotationY = rotationY;
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
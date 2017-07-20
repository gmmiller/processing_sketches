import java.net.SocketException;


final int PORT = 9763;
int TIME_INTERVAL = 1000*10; //in milliseconds
int NUM_OF_POSES = 10;
float ROTATION = 4; //what to rotate the camera by (starting slow)
int lastTime = -10;
int pose_num = 0;
float angle = 0;
float angle2 = 0;
//array of the random factors to start the jellyfish/dancers
float[] randx = new float[NUM_OF_POSES];
float[] randz = new float[NUM_OF_POSES];
//array of all the poses 
MocapPose[] poses = new MocapPose[NUM_OF_POSES];

class Body {
  final static  int PELVIS = 1, L5 = 2, L3 = 3, T12 = 4, T8 = 5;
  final static int NECK = 6, HEAD = 7;
  final static int RIGHT_SHOULDER = 8, RIGHT_UPPER_ARM = 9, RIGHT_FORE_ARM = 10, RIGHT_HAND = 11;
  final static int LEFT_SHOULDER = 12, LEFT_UPPER_ARM = 13, LEFT_FORE_ARM = 14, LEFT_HAND = 15;
  final static int RIGHT_UPPER_LEG = 16, RIGHT_LOWER_LEG = 17, RIGHT_FOOT = 18, RIGHT_TOE = 19;
  final static int LEFT_UPPER_LEG = 20, LEFT_LOWER_LEG = 21, LEFT_FOOT = 22, LEFT_TOE = 23;
}



MocapServer server;

void setup() {
  size(displayWidth, displayHeight, P3D);
  //background(0, 0, 0);
  perspective(PI/6, width/height, 0.5, 200);

  for (int i = 0; i < randx.length; i++) {
    randx[i] = random(-2, 2);
  }
  for (int i = 0; i < randz.length; i++) {
    randz[i] = random(-2, 2);
  }


  try {
    server = new MocapServer(PORT);
    server.start();
  } 
  catch(SocketException se) {
    se.printStackTrace();
  }
  noStroke();
}




void draw() {
  int time = millis();
  background(13, 30, 47+time%20,12); 
  lights();
  //ambientLight(3,44,76);
  //directionalLight(255,255,255,10,15,0);
  
  

  //adds the poses to an array
  if (server.pose != null) {     
    poses[pose_num] = server.pose;
    pose_num = (pose_num + 1) % NUM_OF_POSES;

    //attempt to rotate the camera around the x axis
    camera(0, -5, 10, 0, 0, 0, 0, 1.0, 0);
    translate(0, 0, 0);
    //rotateX(radians(angle2));
    //drawCoordSys(2);

    //println(poses[0]);
    for (int i = 0; i < NUM_OF_POSES; i=i+2) {
      int current = (i + pose_num) % NUM_OF_POSES;
      pushMatrix();
      translate(randx[i], -(i*0.5), randz[i]);
      if (poses[current] != null) {
        drawRotatedFigure(poses[current]);
      }
      popMatrix();
    }

    //draw the figures after rotating the display
    for (int i = 0; i<poses.length; i++) {
      //drawStick(poses[i]);
    }

    //rotate the angle by the rotation
    angle2 = angle2 + PI/ROTATION;
    //println(angle2);
  }
}


void drawRotatedFigure(MocapPose incomingPose) {
  //draws the current pose rotated around the head by 360 degrees
  for (float angle = 0; angle < TWO_PI; angle += 0.5) {
    QuaternionSegment head = incomingPose.segments[Body.HEAD];
    pushMatrix();
    translate(head.x, head.z, head.y);
    rotateY(angle);
    translate(-head.x, -head.z, -head.y);
    drawStick(incomingPose);
    popMatrix();
  }
}



void drawCoordSys(float len) {
  //draw the x coordinate red
  stroke(250, 0, 0);
  line(0, 0, 0, len, 0, 0);
  //draw the y coordinate green
  stroke(65, 173, 48);
  line(0, 0, 0, 0, len, 0);
  //draw the z coordinate blue
  stroke(0, 0, 250);
  line(0, 0, 0, 0, 0, len);
}

void drawConnection(MocapPose pose, int point1, int point2) {
  //println(point1, point2);
  QuaternionSegment segment1 = pose.segments[point1];
  QuaternionSegment segment2 = pose.segments[point2];
  //line(segment1.x, segment1.z, segment1.y, segment2.x, segment2.z, segment2.y);
  pushMatrix();
  translate(segment1.x, segment1.z, segment1.y);
  sphere(0.05);
  popMatrix();
}

void drawStick(MocapPose pose) {
  QuaternionSegment segment;

  //fill(255,0,0);

  // draw head
  noStroke();
  segment = pose.segments[Body.HEAD];
  pushMatrix();
  translate(segment.x, segment.z, segment.y);
  fill(231, 215, 242, 100);
  sphere(0.17);
  popMatrix();

  //draw shoulders
  segment = pose.segments[Body.RIGHT_SHOULDER];
  pushMatrix();
  translate(segment.x, segment.z, segment.y);
  fill(94, 68, 130, 100);
  sphere(0.05);
  popMatrix();
  /*
  segment = pose.segments[Body.LEFT_SHOULDER];
   pushMatrix();
   translate(segment.x, segment.z, segment.y);
   sphere(0.05);
   popMatrix();
   
   //draw upper arm
   segment = pose.segments[Body.RIGHT_UPPER_ARM];
   pushMatrix();
   translate(segment.x, segment.z, segment.y);
   fill(231,215,242,20);
   sphere(0.05);
   popMatrix();
   */

  line(0, segment.x, 0, segment.z, 0, segment.y);

  //right hand is red
  segment = pose.segments[Body.RIGHT_HAND];
  pushMatrix();
  translate(segment.x, segment.z, segment.y);
  fill(168, 11, 159);
  //particle system add here?
  sphere(0.05);
  popMatrix();

  //left hand is blue
  segment = pose.segments[Body.LEFT_HAND];
  pushMatrix();
  translate(segment.x, segment.z, segment.y);
  fill(168, 11, 159);    
  sphere(0.03);
  popMatrix();

  //right foot is green
  segment = pose.segments[Body.RIGHT_FOOT];
  pushMatrix();
  translate(segment.x, segment.z, segment.y);
  fill(94, 68, 130);
  sphere(0.035);
  popMatrix();

  //left foot is purple
  segment = pose.segments[Body.LEFT_FOOT];
  pushMatrix();
  translate(segment.x, segment.z, segment.y);
  fill(94, 68, 130);
  sphere(0.035);
  popMatrix();


  //draw the lines
  stroke(230, 192, 240, 50);
  strokeWeight(10);
  //draw shoulders
  drawConnection(pose, Body.RIGHT_SHOULDER, Body.LEFT_SHOULDER);

  //// draw right arm
  drawConnection(pose, Body.RIGHT_SHOULDER, Body.RIGHT_UPPER_ARM);
  drawConnection(pose, Body.RIGHT_UPPER_ARM, Body.RIGHT_FORE_ARM);
  drawConnection(pose, Body.RIGHT_FORE_ARM, Body.RIGHT_HAND);

  //// draw left arm
  drawConnection(pose, Body.LEFT_SHOULDER, Body.LEFT_UPPER_ARM);
  drawConnection(pose, Body.LEFT_UPPER_ARM, Body.LEFT_FORE_ARM);
  drawConnection(pose, Body.LEFT_FORE_ARM, Body.LEFT_HAND);

  // draw body
  /*
  drawConnection(pose, Body.HEAD, Body.NECK);
  drawConnection(pose, Body.NECK, Body.T8);
  drawConnection(pose, Body.T8, Body.T12);
  drawConnection(pose, Body.T12, Body.L3);
  drawConnection(pose, Body.L3, Body.L5);
  drawConnection(pose, Body.L5, Body.PELVIS);
  */
  stroke(147, 92, 175,160);
  // draw left leg
  drawConnection(pose, Body.PELVIS, Body.LEFT_UPPER_LEG);
  drawConnection(pose, Body.LEFT_UPPER_LEG, Body.LEFT_LOWER_LEG);
  drawConnection(pose, Body.LEFT_LOWER_LEG, Body.LEFT_FOOT);
  //drawConnection(pose, Body.LEFT_FOOT, Body.LEFT_TOE);

  // draw right leg
  drawConnection(pose, Body.PELVIS, Body.RIGHT_UPPER_LEG);
  drawConnection(pose, Body.RIGHT_UPPER_LEG, Body.RIGHT_LOWER_LEG);
  drawConnection(pose, Body.RIGHT_LOWER_LEG, Body.RIGHT_FOOT);
  //drawConnection(pose, Body.RIGHT_FOOT, Body.RIGHT_TOE);
}
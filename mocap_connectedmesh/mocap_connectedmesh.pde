import java.net.SocketException;
import com.hamoid.*;

VideoExport videoExport;

final int PORT = 9763;
int TIME_INTERVAL = 1000*10; //in milliseconds
int NUM_OF_POSES = 50;
float ROTATION = 4; //what to rotate the camera by (starting slow)
int lastTime = -10;
int pose_num = 0;

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
  background(73, 89, 103);
  perspective(PI/6, width/height, 0.5, 200);

  videoExport = new VideoExport(this);
  videoExport.startMovie();

  strokeCap(ROUND);

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

  //background(73,89,103);
  //lights();
  pushMatrix();
  fill(0, 10);
  noStroke();
  translate(-6, -5, 0);
  rotateY(radians(45));
  //rect is not all the way correctly allighned don't worry about it
  //rect(0, 0, 40, 40);
  popMatrix();
  ambientLight(3, 44, 76);
  directionalLight(255, 255, 255, 10, 15, 0);



  //adds the poses to an array
  if (server.pose != null) {     
    poses[pose_num] = server.pose;
    pose_num = (pose_num + 1) % NUM_OF_POSES;

    //attempt to rotate the camera around the x axis
    camera(8, 5.33, 1, 0, 0, 0, 0, -1.0, 0);
    translate(0, 0, 0);
    //rotateX(radians(angle2));
    //drawCoordSys(2);

    //println(poses[0]);
    //for (int i = 0; i < NUM_OF_POSES; i += (NUM_OF_POSES/5)) {
    int current = (pose_num - 1 + NUM_OF_POSES) % NUM_OF_POSES;     
    if (poses[current] != null && poses[(current+10)%NUM_OF_POSES] != null && poses[(current+20)%NUM_OF_POSES] != null && poses[(current+30)%NUM_OF_POSES] != null && poses[(current+40)%NUM_OF_POSES] != null) {

      //back etc.
      //connector(current, Body.HEAD);
      //connector(current, Body.L5);
      //connector(current, Body.L3);
      //connector(current, Body.T12);
      //connector(current, Body.T8);
      //connector(current, Body.NECK);
      //connector(current, Body.PELVIS);
      //right arm
      //connector(current, Body.RIGHT_SHOULDER);
      //connector(current, Body.RIGHT_UPPER_ARM);
      //connector(current, Body.RIGHT_FORE_ARM);
      connector(current, Body.RIGHT_HAND);
      //left arm
      //connector(current, Body.LEFT_SHOULDER);
      //connector(current, Body.LEFT_UPPER_ARM);
      //connector(current, Body.LEFT_FORE_ARM);
      //connector(current, Body.LEFT_HAND);
      //right leg
      //connector(current, Body.RIGHT_UPPER_LEG);
      //connector(current, Body.RIGHT_LOWER_LEG);
      //connector(current, Body.RIGHT_FOOT);
      //connector(current, Body.RIGHT_TOE);
      //left leg
      connector(current, Body.LEFT_UPPER_LEG);
      //connector(current, Body.LEFT_LOWER_LEG);
      //connector(current, Body.LEFT_FOOT);
      //connector(current, Body.LEFT_TOE);

      //stroke(200,10,20, 200);
      ////back etc.
      //connector(((current + 10)%NUM_OF_POSES), Body.HEAD);
      ////connector(((current + 10)%NUM_OF_POSES), Body.L5);
      ////connector(((current + 10)%NUM_OF_POSES), Body.L3);
      ////connector(((current + 10)%NUM_OF_POSES), Body.T12);
      ////connector(((current + 10)%NUM_OF_POSES), Body.T8);
      //connector(((current + 10)%NUM_OF_POSES), Body.NECK);
      //connector(((current + 10)%NUM_OF_POSES), Body.PELVIS);
      ////right arm
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_SHOULDER);
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_UPPER_ARM);
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_FORE_ARM);
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_HAND);
      ////left arm
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_SHOULDER);
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_UPPER_ARM);
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_FORE_ARM);
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_HAND);
      ////right leg
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_UPPER_LEG);
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_LOWER_LEG);
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_FOOT);
      //connector(((current + 10)%NUM_OF_POSES), Body.RIGHT_TOE);
      ////left leg
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_UPPER_LEG);
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_LOWER_LEG);
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_FOOT);
      //connector(((current + 10)%NUM_OF_POSES), Body.LEFT_TOE);
    }
  }
  videoExport.saveFrame();
}

//draws lines from each pose (starting at pose i) from the body part (BP) entered. 
void connector(int i, int BP) {

  QuaternionSegment c1 = poses[i].segments[BP]; 
  QuaternionSegment c2 = poses[((i+10)%NUM_OF_POSES)].segments[BP];
  QuaternionSegment c3 = poses[((i+20)%NUM_OF_POSES)].segments[BP];
  QuaternionSegment c4 = poses[(i+30)%NUM_OF_POSES].segments[BP];
  QuaternionSegment c5 = poses[(i+40)%NUM_OF_POSES].segments[BP];


  strokeWeight(1);
  stroke(155, 170, 185, 20);
  line(c1.x, c1.z, c1.y, c2.x, c2.z, c2.y);
  strokeWeight(1);
  stroke(237, 115, 101, 20);
  line(c2.x, c2.z, c2.y, c3.x, c3.z, c3.y);
  strokeWeight(1);
  stroke(241, 197, 112, 20);
  line(c3.x, c3.z, c3.y, c4.x, c4.z, c4.y);
  strokeWeight(1);
  stroke(161, 193, 187, 20);
  line(c4.x, c4.z, c4.y, c5.x, c5.z, c5.y);
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
  line(segment1.x, segment1.z, segment1.y, segment2.x, segment2.z, segment2.y);
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
  stroke(147, 92, 175, 160);
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


void keyPressed() {
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
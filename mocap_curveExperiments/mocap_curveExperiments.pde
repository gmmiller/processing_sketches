import java.net.SocketException;
import java.util.Calendar;

//to be used with the xsens video walking in a spiral with arm flapping for best results...


final int PORT = 9763;
int TIME_INTERVAL = 1000*10; //in milliseconds
int NUM_OF_POSES = 300;
float ROTATION = 4; //what to rotate the camera by (starting slow)
int CONS = 25; //number of connections to make 
int STEP = NUM_OF_POSES/CONS; //distance between poses to draw
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



  strokeCap(ROUND);

  try {
    server = new MocapServer(PORT);
    server.start();
  } 
  catch(SocketException se) {
    se.printStackTrace();
  }
  //noStroke();
}




void draw() {

  //background(73, 89, 103);
  //background(226, 200, 143, 50);
  background(105, 174, 206);
  lights();
  pushMatrix();
  //fill(0, 50);
  //noStroke();
  translate(-6, -5, 0);
  rotateY(radians(45));
  //rect is not all the way correctly allighned don't worry about it
  //rect(0, 0, 40, 40);
  popMatrix();
  //ambientLight(3, 44, 76);
  //directionalLight(255, 255, 255, 10, 15, 0);



  //adds the poses to an array
  if (server.pose != null) {     
    poses[pose_num] = server.pose;
    pose_num = (pose_num + 1) % NUM_OF_POSES;

    camera(10, 10, 1, 0, 0, 0, 0, -1.0, 0);
    translate(0, 0, 0);
    //rotateX(radians(angle2));
    //drawCoordSys(2);

    //println(poses[0]);
    //for (int i = 0; i < NUM_OF_POSES; i += (NUM_OF_POSES/5)) {
    int current = (pose_num + NUM_OF_POSES) % NUM_OF_POSES;     
    if (poses[(current+NUM_OF_POSES)%NUM_OF_POSES] != null) {
      //how to loop this part ^^^

      //back etc.
      connector(current, Body.HEAD);
      connector(current, Body.L5);
      //connector(current, Body.L3);
      connector(current, Body.T12);
      //connector(current, Body.T8);
      //connector(current, Body.NECK);
      connector(current, Body.PELVIS);
      //right arm
      connector(current, Body.RIGHT_SHOULDER);
      connector(current, Body.RIGHT_UPPER_ARM);
      connector(current, Body.RIGHT_FORE_ARM);
      connector(current, Body.RIGHT_HAND);
      //left arm
      connector(current, Body.LEFT_SHOULDER);
      connector(current, Body.LEFT_UPPER_ARM);
      connector(current, Body.LEFT_FORE_ARM);
      connector(current, Body.LEFT_HAND);
      //right leg

      connector(current, Body.RIGHT_UPPER_LEG);
      connector(current, Body.RIGHT_LOWER_LEG);
      connector(current, Body.RIGHT_FOOT);
      //connector(current, Body.RIGHT_TOE);
      //left leg
      connector(current, Body.LEFT_UPPER_LEG);
      connector(current, Body.LEFT_LOWER_LEG);
      connector(current, Body.LEFT_FOOT);
      //connector(current, Body.LEFT_TOE);
    }
  }
}

//draws lines from each pose (starting at pose i) from the body part (BP) entered. 
void connector(int i, int BP) {

  for (int x = 1; x <= CONS; x ++) {
    //in theory makes all the connections based on the numbers set at the top..
    QuaternionSegment c1 = poses[(i+x)%NUM_OF_POSES].segments[BP];
    QuaternionSegment c2 = poses[(i+STEP*x)%NUM_OF_POSES].segments[BP];

    stroke(215-(10*x), 13, 200-(3*x), 90);
    strokeWeight(CONS - x);
    //line(c1.x, c1.z, c1.y, c2.x, c2.z, c2.y);
    pushMatrix();
    noStroke();
    int a = 150;
    translate(c2.x, c2.z, c2.y);
    //if (x%2 == 0) {
    //  if ( x%3 == 0) {
    //    fill(45, 135, 109);
    //  } else if (x %3 == 1) {
    //    fill(186, 157, 99,25);
    //  } else {
    //    fill(157, 24, 19,25);
    //  }
    fill(247, 204, 49, 75);
    //sphere( 0.01*(CONS-x));
    box(0.01*(CONS-x));

    popMatrix();
  }
}
//QuaternionSegment c1 = poses[i].segments[BP]; 
//QuaternionSegment c2 = poses[((i+10)%NUM_OF_POSES)].segments[BP];
//QuaternionSegment c3 = poses[((i+20)%NUM_OF_POSES)].segments[BP];
//QuaternionSegment c4 = poses[(i+30)%NUM_OF_POSES].segments[BP];
//QuaternionSegment c5 = poses[(i+40)%NUM_OF_POSES].segments[BP];


//strokeWeight(9);
//stroke(155, 170, 185, 90);
//line(c1.x, c1.z, c1.y, c2.x, c2.z, c2.y);

//stroke(237, 115, 101, 90);
//line(c2.x, c2.z, c2.y, c3.x, c3.z, c3.y);
////strokeWeight(1);
//stroke(241, 197, 112, 90);
//line(c3.x, c3.z, c3.y, c4.x, c4.z, c4.y);
////strokeWeight(1);
//stroke(161, 193, 187, 90);
//line(c4.x, c4.z, c4.y, c5.x, c5.z, c5.y);


//pushMatrix();
//translate(c1.x, c1.z, c1.y);
//noStroke();
//fill(155, 170, 185, 90);
//sphere(0.065);
//popMatrix();
// pushMatrix();
//translate(c2.x, c2.z, c2.y);
//noStroke();
//fill(237, 115, 101,90);
//sphere(0.025);
//popMatrix();
// pushMatrix();
//translate(c3.x, c3.z, c3.y);
//noStroke();
//fill(241, 197, 112, 90);
//sphere(0.035);
//popMatrix();



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
  stroke(230, 192, 240, 20);
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
void keyReleased() {
  if (key=='s' || key=='S') saveFrame(timestamp()+".png");
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
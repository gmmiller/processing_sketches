import java.net.SocketException;


final int PORT = 9763;


class Body{
 final static  int PELVIS = 1, L5 = 2, L3 = 3, T12 = 4, T8 = 5;
 final static int NECK = 6, HEAD = 7;
 final static int RIGHT_SHOULDER = 8, RIGHT_UPPER_ARM = 9, RIGHT_FORE_ARM = 10, RIGHT_HAND = 11;
 final static int LEFT_SHOULDER = 12, LEFT_UPPER_ARM = 13, LEFT_FORE_ARM = 14, LEFT_HAND = 15;
 final static int RIGHT_UPPER_LEG = 16, RIGHT_LOWER_LEG = 17, RIGHT_FOOT = 18, RIGHT_TOE = 19;
 final static int LEFT_UPPER_LEG = 20, LEFT_LOWER_LEG = 21, LEFT_FOOT = 22, LEFT_TOE = 23;

 
 
 
}



MocapServer server;

void setup(){
  size(1024, 1024, P3D);

  try{
    server = new MocapServer(PORT);
    server.start();
  } catch(SocketException se){
    se.printStackTrace();
  }
  noStroke();
}



void draw(){
 background(0,0,0); 
 translate(width/2, height/2, 0);
 scale(200,-200,200);
 //change rotation and see character different ways 
 rotateY(-PI/2);
 lights();
 
  if (server.pose != null){
    //drawBalls(server.pose);
     drawStick(server.pose); 
  }
}


void drawConnection(MocapPose pose, int point1, int point2){
  println(point1, point2);
   QuaternionSegment segment1 = pose.segments[point1];
   QuaternionSegment segment2 = pose.segments[point2];
   line(segment1.x, segment1.z, segment1.y, segment2.x, segment2.z, segment2.y);
}

void drawStick(MocapPose pose){
    QuaternionSegment segment;
    
    fill(255,0,0);
   
    
    
    // draw head
    noStroke();
    segment = pose.segments[Body.HEAD];
    pushMatrix();
    translate(segment.x, segment.z, segment.y);
    
    sphere(0.05);
    popMatrix();
    
    line(0, segment.x, 0, segment.z, 0, segment.y);
    
    segment = pose.segments[Body.RIGHT_HAND];
    pushMatrix();
    translate(segment.x, segment.z, segment.y);
    
     sphere(0.05);
    popMatrix();
    
    segment = pose.segments[Body.LEFT_HAND];
    pushMatrix();
    translate(segment.x, segment.z, segment.y);
    
     sphere(0.05);
    popMatrix();
    
   
    
    
    // draw shoulders
    stroke(255);
    strokeWeight(0.01);
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
    drawConnection(pose, Body.HEAD, Body.NECK);
    drawConnection(pose, Body.NECK, Body.T8);
    drawConnection(pose, Body.T8, Body.T12);
    drawConnection(pose, Body.T12, Body.L3);
    drawConnection(pose, Body.L3, Body.L5);
    drawConnection(pose, Body.L5, Body.PELVIS);
    
    // draw left leg
    drawConnection(pose, Body.PELVIS, Body.LEFT_UPPER_LEG);
    drawConnection(pose, Body.LEFT_UPPER_LEG, Body.LEFT_LOWER_LEG);
    drawConnection(pose, Body.LEFT_LOWER_LEG, Body.LEFT_FOOT);
    drawConnection(pose, Body.LEFT_FOOT, Body.LEFT_TOE);
    
    // draw right leg
    drawConnection(pose, Body.PELVIS, Body.RIGHT_UPPER_LEG);
    drawConnection(pose, Body.RIGHT_UPPER_LEG, Body.RIGHT_LOWER_LEG);
    drawConnection(pose, Body.RIGHT_LOWER_LEG, Body.RIGHT_FOOT);
    drawConnection(pose, Body.RIGHT_FOOT, Body.RIGHT_TOE);
    
    
}


void drawBalls(MocapPose pose){
  noStroke();
  fill(255,255,255);
  for (QuaternionSegment segment:pose.segments){
      if (segment != null){
        float x = segment.x;
        float y = segment.y;
        float z = segment.z;

        pushMatrix();
        translate(x,z,y);
        sphere(.05);
        popMatrix();
      }
    }
}
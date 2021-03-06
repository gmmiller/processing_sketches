//Gigi Miller
//One Hundred Circle Intersections
//Attempt One
import java.util.Calendar;

//number of circles
Agent[] circles = new Agent[100];

void setup() {
  colorMode(HSB, 360, 100, 100);
  size(displayWidth, displayHeight);
  background(120, 90, 23);

  //init circles
  for (int i= 0; i<circles.length; i++) {
    circles[i] = new Agent();
  }
}

void draw() {

  fill(120, 90, 23, 20); 
  rect(0, 0, width, height);

  fill(127, 90, 20, 20);
  noStroke();

  for (int i=0; i<circles.length; i++) {
    circles[i].update();
  }

  //not all circles are being checked.. idk why -> do pretty things then come back to this
  for (int z=0; z<circles.length; z++) {
    for (int y=1; y<circles.length-(z+1); y++) {
      circles[z].intersectCheck(circles[z+y]);
    }
  }
}

void keyReleased() {
  if (key=='p' || key=='P') saveFrame(timestamp()+".png");
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
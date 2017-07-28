//Gigi Miller
//Vines between two pts
import java.util.Calendar;

Person p1 = new Person();
Person p2 = new Person();

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  frameRate(90);
}

void draw() {
  //background(0);
  p1.update();
  p2.update();
  stroke( p1.xpos/10, 185, p2.xpos/5.6, 15);
  line(p1.xpos, p1.ypos, p2.xpos, p2.ypos);
}


class Person {
  float xpos = width/2;
  float ypos = height/2;
  float xspeed = random(2, 5);
  float yspeed = random(1, 6);

  int r = 3;
  int xdir = 1;
  int ydir = 1;

  void update() {
    xpos = xpos + (xspeed * xdir);
    ypos = ypos + (yspeed * ydir);

    if (xpos > width-r || xpos < r) {
      xdir *= -1;
    }
    if (ypos > height-r || ypos < r) {
      ydir *= -1;
    }
    //fill(200, 27);
    //ellipse(xpos, ypos, r, r );
  }
}

void keyReleased() {
  if (key=='s' || key=='S') saveFrame(timestamp()+".png");
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
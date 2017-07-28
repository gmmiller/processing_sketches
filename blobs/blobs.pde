//Gigi Miller
//Vines between two pts

Person p1 = new Person();
Person p2 = new Person();

ArrayList<Connect> connects = new ArrayList<Connect>();

void setup() {
  size(displayWidth, displayHeight);
  background(0);
}

void draw() {
  background(0);
  p1.update();
  p2.update();
  noFill();

  //find the midpoint and the 2 quarter points

  float midx = (p1.xpos + p2.xpos)/2;
  float midy = (p1.ypos + p2.ypos)/2;
  float q1x = (p1.xpos + midx)/2;
  float q1y = (p1.ypos + midy)/2;
  float q2x = (p2.xpos + midx)/2;
  float q2y = (p2.ypos + midy)/2;
  stroke(247, 247, 49);
  ellipse(midx, midy, 50, 50);
  stroke(108, 226, 215);
  ellipse(q1x, q1y, 25, 25);
  ellipse(q2x, q2y, 25, 25);

  if (dist(p1.xpos, p1.ypos, p2.xpos, p2.ypos) < 500) {
    connects.add(new Connect(midx, midy));
    println(connects.size());
  }
  for (Connect con : connects) {
    con.display();
  }
}


class Person {
  float xpos = width/2;
  float ypos = height/2;
  float xspeed = random(2, 5);
  float yspeed = random(1, 6);

  int r = 50;
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
    noFill();
    stroke(111, 196, 113);
    ellipse(xpos, ypos, r, r );
  }
}

class Connect {
  float x;
  float y;

  Connect( float ex, float why) {
    x = ex;
    y = why;
  }

  void display() {
    noStroke();
    fill(204, x%255, 206, 30);
    rect(x, y, 30, 30);
  }
}
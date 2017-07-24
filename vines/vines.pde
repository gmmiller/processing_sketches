//Gigi Miller
//Vines between two pts

Person p1 = new Person();
Person p2 = new Person();

void setup() {
  size(displayWidth, displayHeight);
  background(0);
}

void draw() {
  background(0);
  p1.update();
  p2.update();
  noFill();
  stroke(111, 196, 113);
  //line(p1.xpos, p1.ypos, p2.xpos, p2.ypos);
  //beginShape();
  //curveVertex(p1.xpos, p1.ypos); // the first control point
  //curveVertex(p1.xpos, p1.ypos); // is also the start point of curve
  //curveVertex(p1.xpos+random(-10, p2.xpos), p1.ypos+random(-10, p2.ypos));
  //curveVertex(p1.xpos+random(10, 50), p1.ypos+random(10, 50));
  //curveVertex(p1.xpos+random(-20, p2.xpos), p1.ypos+random(-20, p2.ypos));
  //curveVertex(p2.xpos, p2.ypos); // the last point of curve
  //curveVertex(p2.xpos, p2.ypos); // is also the last control point
  //endShape();
  
  float x = (p1.xpos + p2.xpos)/2;
  float y = (p1.ypos + p2.ypos)/2;
  float CP = dist(p1.xpos, p1.ypos, p2.xpos, p2.ypos)/3;
  beginShape();
  vertex(p1.xpos, p1.ypos);
  bezierVertex(p1.xpos,p1.ypos+CP, x, y+CP, x,y);
  bezierVertex(x,y-CP, p2.xpos,p2.ypos-CP, p2.xpos,p2.ypos);
  endShape();
  leaf(x,y);
}

void leaf(float ex, float why){
    pushMatrix();
  translate(ex, why);
  fill(111, 196, 113,50);
  noStroke();
  strokeWeight(3);

  beginShape();
  vertex(0, 0);
  bezierVertex(0, -50, 100, -25, 100, 0);
  bezierVertex(100, 25, 0, 50, 0, 0);
  endShape();
  stroke(37,66,39,50);
  //stem
  line(-10,0, 90,0);
  //toplines
  line(10,0,20,-15);
  line(30,0,39,-11);
  line(50,0,65,-15);
  line(70,0,77,-10);
  //bottom lines
  //stroke(19, 66, 23,50);
  line(10,0,20,15);
  line(30,0,45,15);
  line(50,0,59,11);
  line(70,0,80,10);
  
  popMatrix();
  
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

    ellipse(xpos, ypos, r, r );
  }
}
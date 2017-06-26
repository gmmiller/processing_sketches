//Gigi Miller
//Fractal Art


int NUM_CHILDREN= 3;
int MAX_LEVELS = 4;

Branch trunk;

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  noFill();
  smooth();
  newTree();
}

/*void draw() {
 background(0);
 trunk.updateMe(width/2, height/2);
 trunk.drawMe();
 }*/

void newTree() {
  trunk = new Branch(1, 0, width/2, 2*(height/3)); //length and place to draw trunk
  trunk.drawMe();
}

class Branch {
  float level, index;
  float x, y;
  float endx, endy;
  float strokeW, alph;
  float len, lenChange;
  float rot, rotChange;

  Branch[] children = new Branch[0];

  Branch(float lev, float ind, float ex, float why) {
    level = lev;
    index = ind;
    strokeW = (1/level)*30;
    alph = 255/level;
    len = level*10;
    rot = level+270;
    //println(level);
    //lenChange = random(10)-5;
    rotChange = random(-100,100)-5;
    updateMe(ex, why);

    if (level < MAX_LEVELS) {
      children = new Branch[NUM_CHILDREN];
      for (int x = 0; x < NUM_CHILDREN; x++) {
        children[x] = new Branch(level+1, x, endx, endy);
      }
    }
  }

  void updateMe(float ex, float why) {
    //phonetical spellings of x and y 
    x = ex;
    y = why;

    rot+= rotChange;
    if (rot>360) {
      rot = 0;
    } else if (rot<0) {
      rot = 360;
    }

    float radian = radians(rot);
    endx = x + (len*cos(radian));
    endy = y + (len * sin(radian));

    for (int i = 0; i <children.length; i++) {
      children[i].updateMe(endx, endy);
    }
  }

  void drawMe() {
    strokeWeight(strokeW);
    stroke(56, 205-level*20, 68);
    fill(255, alph);
    line(x, y, endx, endy);
    //strokeWeight(strokeW);
    noStroke();
    ellipse(endx, endy, len/15, len/15);
    for (int i = 0; i<children.length; i ++) {
      children[i].drawMe();
    }
  }
}
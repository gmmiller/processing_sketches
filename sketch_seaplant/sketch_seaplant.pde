// Gigi Miller
// Sea Plant
// attempt to replicate https://www.openprocessing.org/sketch/158347

//fibonacci sequence 
int fib(int n) {
  if (n == 0 | n == 1) {
    return 1;
  } else {
    return fib(n-1) + fib(n-2);
  }
}
int ratio(int n) {
  return n * 4;
}

//an array of tentacles
Tentacle[] tents;


void setup() {
  size(800, 500);
  background(0);
  stroke(255);

  tents = new Tentacle[70];
  for (int i = 0; i < tents.length; i++) {
    tents[i] = new Tentacle((int)random(5, 13));
  }
}

void draw() {
  fill(0);
  rect(0, 0, width, height);
  translate(width/2, height-50);
  for (Tentacle tentacle : tents) {
    tentacle.display();
  }
  //tent.display();
}


class Tentacle {
  int LENGTH;
  float x, y;
  float angle; 
  PVector[] j_pos;
  float amp, phi;

  Tentacle(int L) {
    LENGTH = L;
    x = 0;
    y = 0;
    angle = random(-180, 0);
    amp = random(.25,1);
    phi = random(TWO_PI);
    j_pos = new PVector[14];
    for (int g = 0; g <= 13; g ++) {      
      j_pos[g] = new PVector(0, 0);
    }
  }

  void display() {
    pushMatrix();
    rotate(radians(angle));
    //println(angle);
    //LENGTH = (int) random(5,13);
    // draw the joints of the tentacle 
    for (int i =0; i < LENGTH; i++) {
      float circle_stroke = 6;
      float w = 0.75*(LENGTH - i);
      int len = ratio(LENGTH - i);
      float Y = (sin(radians(frameCount)+phi)+1)*amp;
      //draw the little flowers at the end
      if (i == LENGTH-1) {
        strokeWeight(0.75);
        stroke(0, 143, 242, 100);
        float ex = j_pos[i].x;
        float why = j_pos[i].y;
        line(ex-10, why, ex+10, why);
        line(ex, why-10, ex, why+10);
        line(ex-8.6, why-5, ex+8.6, why+5);
        line(ex-8.6, why+5, ex+8.6, why-5);
        line(ex-5, why+8.6, ex+5, why-8.6);
        line(ex+5, why+8.6, ex-5, why-8.6);
        
      }
      //draw the circles
      stroke(0, 143, 242, 50);
      strokeWeight(circle_stroke);
      fill(255);
      ellipse(j_pos[i].x, j_pos[i].y, w, w);
      
      //draw the connecting lines
      stroke(0, 143, 242, 70);
      strokeWeight(w);
      //println("x", j_pos[i].x, "y", j_pos[i].y);
      if (angle > -90) {
        line(j_pos[i].x, j_pos[i].y, j_pos[i].x+len, j_pos[i].y - i*Y);
        j_pos[i+1].x = j_pos[i].x + len;
        j_pos[i+1].y = j_pos[i].y - i*Y;
      } else {
        line(j_pos[i].x, j_pos[i].y, j_pos[i].x+len, j_pos[i].y + i*Y);
        j_pos[i+1].x = j_pos[i].x + len;
        j_pos[i+1].y = j_pos[i].y + i*Y;
      }
      circle_stroke -= 0.5;
    }

    popMatrix();
  }
}


/*class Joint {
 int len;
 float x, y;
 
 Joint(x, y, int index) {
 len = fib(index) * 20;
 }
 }*/
//Gigi Miller
//Shells
//June 21st 2017
//stylized shell

int iter = 20;

void setup() {
  size(700, 700);
  background(7);
  translate(width/2, height/2);
}

void draw() {
  fill(237, 217, 173, 35);
  noStroke();
  
  translate(width/2, height/2);
  while (iter < 200) {
    rect(0, 0, iter, iter);
    iter += 10;
    rotate(PI/4);
  }
}
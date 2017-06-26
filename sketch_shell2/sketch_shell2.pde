//Gigi Miller
//Shells
//June 21st 2017
//stylized shell

int iter = 200;

void setup() {
  size(700, 700);
  background(7);
  translate(width/2, height/2);
}

void draw() {
  fill(237, 217, 173, 50);
  stroke(204,152,132,50);
  strokeWeight(4);

  translate(width/2, height/2);
  while (iter > 0) {
    rect(0, 0, iter, iter);
    iter -= 5;
    rotate(PI/6);
  }
}
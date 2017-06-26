//Gigi Miller
//Shells
//June 21st 2017
//stylized shell

float iter = 600;

void setup() {
  size(700, 700);
  background(7);
  translate(width/2, height/2);
}

void draw() {
  //fill(237, 217, 173, 50);
  stroke(204,152,132,50);
  //noStroke();
  strokeWeight(4);
  noFill();

  translate(width/2, height/2);
  while (iter > 0) {
    arc(0.0, 0.0, iter, iter, 0.0, PI/4);
    //ellipse(iter-50, iter-50, 20,20);
    point(iter/2, iter/2);
    iter -= 5;
    rotate(PI/6);
  }
}
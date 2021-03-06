//Gigi Miller
//Shells
//June 21st 2017
//stylized shell

import java.util.Calendar;

float iter = 400;

void setup() {
  size(700, 700);
  background(7);
  translate(width/2, height/2);
}

void draw() {
  fill(237, 217, 173, 50);
  //stroke(204,152,132,50);
  noStroke();
  strokeWeight(4);

  translate(width/2, height/2);
  while (iter > 0) {
    arc(0.0, 0.0, iter, iter, 0.0, PI/4);
    iter -= 13;
    rotate(PI/6);
  }
}

void keyReleased() {
  if (key=='s' || key=='S') saveFrame(timestamp()+".png");
}

String timestamp() {
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", Calendar.getInstance());
}
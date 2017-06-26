int size;
void setup() {
  size(400, 400);
  background(2);
  fill(250);
  stroke(255);
}

void draw() {
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < 100; i++) {
    rotate(PI/2);
    translate(fib(i - 2), 0);
    //fill(5*i);
    size = (i /2)*25;
    arc(0, 0, size, size, 0, PI/2);
  }
  popMatrix();
}

int fib(int n) {
  if (n == 0 | n == 1) {
    return n;
  } else if (n <0) {
    return 0;
  } else {
    return fib(n-1) + fib (n-2);
  }
}
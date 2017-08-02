//gigi miller and maya reich //<>//
//evolving a pool of images

//take one - circles only 
// to do - move drawing function
// make pool bigger

//Global Constants
int POP = 84; 
PGraphics image;
Goat[] pool = new Goat[POP];

int widthOfGoat = 200;
int heightOfGoat = 200;

void setup() {
  size(2400, 1400);
  background(35);
  colorMode(HSB, 360, 100, 100);
  frameRate(50);

  noStroke();
  //noLoop();

  image = createGraphics(widthOfGoat, heightOfGoat);

  initializePool();
}


void initializePool() {
  //initialize the population randomly
  for (int i = 0; i < POP; i++) {
    Goat myGoat;
    myGoat = new Goat();
    pool[i] = myGoat;
    pool[i].birth();
  }
  int j = 0;
  //assigns origin for each box
  for (int ex = 0; ex<width; ex += widthOfGoat) {
    for (int why = 0; why<height; why += heightOfGoat) {
      pool[j].x = ex;
      pool[j].y = why;
      j++;
    }
  }
}
void draw() {
  //drawing the GOATS
  for (int k = 0; k < pool.length; k++) {
    pool[k].drawGoat();
  }
  for (int i = 0; i < pool.length; i++){
    pool[i] = pool[i].breed();
  }
}




//breed the goats



void keyPressed() {
  if (key == 'r' || key == 'R') {
    initializePool();
    redraw();
  }
  if (key == 'b' || key == 'B') {
    //breed();
    redraw();
  }
}


//Basic Algorithm
//1. create a randomized pool

//2. rank population using a fitness function that includes location

//3. breed a new pool - many ways to do 

//4. randomly mutate the new pool 

//5. back to step 2, repeat
//gigi miller and maya reich //<>//
//evolving a current of images

//take four - breed locally 


//Global Constants
int POP = 1344; 
int count = 0;
int steps = 20;
PGraphics image;

//current population
Goat[] current = new Goat[POP];

//future population we are interpolating to from current
Goat[] future = new Goat[POP];

int widthOfGoat = 50;
int heightOfGoat = 50;

void setup() {
  size(2400, 1400);
  background(35);
  colorMode(HSB, 360, 100, 100);
  frameRate(40);

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
    current[i] = myGoat;
    current[i].birth();
  }
  int j = 0;
  //assigns origin for each box
  for (int ex = 0; ex<width; ex += widthOfGoat) {
    for (int why = 0; why<height; why += heightOfGoat) {
      current[j].id = j;
      current[j].x = ex;
      current[j].y = why;
      j++;
    }
  }
  //ad goats to the neighbors pool of each goat 
  for (int id = 0; id < POP; id++) {
    int h = height/heightOfGoat;
    int w = width/widthOfGoat;
    current[id].neighbors.add(current[id]);
    //LEFT NEIGHBORS
    if (id > h) {
      //add the left neighbor
      current[id].neighbors.add(current[id-h]);
      if (id % h != 0) {
        //add the top left 
        current[id].neighbors.add(current[id-h - 1]);
      }
      if (id % h != h - 1) {
        //add the bottom left 
        current[id].neighbors.add(current[id-h + 1]);
      }
    }
    //RIGHT NEIGHBORS
    if (id< h*(w-1)) {
      //add the right neighbor
      current[id].neighbors.add(current[id+h]);
      if (id%h!=0) {
        //add top right 
        current[id].neighbors.add(current[id+h-1]);
      }
      if ( id%h != h-1) {
        //add bottom right
        current[id].neighbors.add(current[id+h+1]);
      }
    }
    //CENTER NEIGHBORS
    if (id %h != 0) {
      //add the top center 
      current[id].neighbors.add(current[id-1]);
    }
    if (id%h != h-1) {
      //add the bottom center
      current[id].neighbors.add(current[id+1]);
    }
  }
  //breed the goats
  for (int k = 0; k < POP; k++) {
    future[k] = current[k].breed();
  }
}


void draw() {
  //drawing the GOATS
  //start with current pop- draw it

  //draw current population
  for (int i=0; i < POP; i++) {
    current[i].drawGoat(future[i], count/float(steps));
  }

  count++;

  //when fully interpolated to futurePop
  if (count == steps) {
    count = 0;
    Goat tempGoats[] = current;
    current = future;
    future = tempGoats;

    //breed the goats
    for (int j = 0; j < POP; j++) {
      future[j] = current[j].breed();
    }
  }
}



void keyPressed() {
  if (key == 'r' || key == 'R') {
    initializePool();
    redraw();
  }
  if (key == 'b' || key == 'B') {

    int nG = int (random(0, POP));
    //Goat superGoat = new Goat();
    //superGoat.birth();
    future[nG].birth();
  }
}


//Basic Algorithm
//1. create a randomized current

//2. rank population using a fitness function that includes location

//3. breed a new current - many ways to do 

//4. randomly mutate the new current 

//5. back to step 2, repeat
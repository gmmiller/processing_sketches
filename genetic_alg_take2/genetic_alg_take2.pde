//gigi miller and maya reich //<>//
//evolving a current of images

//take one - circles only 
// to do - move drawing function
// make current bigger


//Global Constants
int POP = 84; 
int count = 0;
int steps = 20;
PGraphics image;

//current population
Goat[] current = new Goat[POP];

//future population we are interpolating to from current
Goat[] future = new Goat[POP];

int widthOfGoat = 200;
int heightOfGoat = 200;

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
      current[j].x = ex;
      current[j].y = why;
      j++;
    }
  }
  breed();
}


void draw() {
  //drawing the GOATS
  //start with current pop- draw it

  //breeds the future generation - stores in array future
  //does not make any changes to the array current
  //for (int j=0; j < POP; j++) {
  //  future[j] = current[j].breed();
  //}

  //interpolate from current to future to get to future
  //for (int k=0; k < POP; k++) {
  //  for (int c=0; c < chromLength; c++) {
  //    current[k].chromosome[c] = lerp(current[k].chromosome[c], future[k].chromosome[c], count/steps);
  //  }
  //}


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

    breed();
  }
}

//breed the goats 
void breed() { 
  ArrayList<Goat> BP = new ArrayList<Goat>(); 
  for (Goat g : current) { 
    //append the number of goats into the breeding pool based on the fitness score 

    int breeders = int( g.getFitness() * 100); 
    for (int i = 0; i < breeders; i++) { 
      BP.add(g);
    }
  } 
  //breed and mutate 25 new goats to build the population 
  for (int k = 0; k < POP; k++) { 
    Goat child = new Goat(); 
    child.x = current[k].x; 
    child.y = current[k].y; 
    future[k] = child; 
    //parent 1 index 
    Goat p1 = BP.get(int (random(0, BP.size()))); 
    //parent 2 index 
    Goat p2 = BP.get(int (random(0, BP.size()))); 

    //index at which we crossover genes from parent 1 to parent 2 
    int crossOverPt = int(random(0, chromLength-1)); 

    for (int i = 0; i < chromLength; i++) { 
      //get new genes from parent 1 up to crossover 
      if (i < crossOverPt) { 
        future[k].chromosome[i] = p1.chromosome[i];
      } 
      //get new genes from parent 2 after crossover 
      else { 
        future[k].chromosome[i] = p2.chromosome[i];
      }
    } 
    //float chanceSG = random(0, 5); //chance of there being a supergoat generated this breeding
    //if ( chanceSG <= 1) {
    //  int nG = int (random(0, POP));
    //  Goat superGoat = new Goat();
    //  superGoat.birth();
    //  future[nG] = superGoat;
    //}
    future[k].mutate();
  }
} 


void keyPressed() {
  if (key == 'r' || key == 'R') {
    initializePool();
    redraw();
  }
  if (key == 'b' || key == 'B') {

  
  }
}


//Basic Algorithm
//1. create a randomized current

//2. rank population using a fitness function that includes location

//3. breed a new current - many ways to do 

//4. randomly mutate the new current 

//5. back to step 2, repeat
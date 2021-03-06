//gigi miller and maya reich //<>//
//evolving a pool of images

//take one - circles only 
// to do - move drawing function
// make pool bigger

//Global Constants
int POP = 1344; 
PGraphics image;
Goat[] pool = new Goat[POP];

int widthOfGoat = 50;
int heightOfGoat = 50;

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
  breed();
}


//breed the goats 
void breed() { 
  ArrayList<Goat> BP = new ArrayList<Goat>(); 
  for (Goat g : pool) { 
    //append the number of goats into the breeding pool based on the fitness score 

    int breeders = int( g.getFitness() * 100); 
    for (int i = 0; i < breeders; i++) { 
      BP.add(g);
    }
  } 
  //breed and mutate 25 new goats to build the population 
  for (int k = 0; k < POP; k++) { 
    Goat child = new Goat(); 
    child.x = pool[k].x; 
    child.y = pool[k].y; 
    pool[k] = child; 
    //parent 1 index 
    Goat p1 = BP.get(int (random(0, BP.size()))); 
    //parent 2 index 
    Goat p2 = BP.get(int (random(0, BP.size()))); 

    //index at which we crossover genes from parent 1 to parent 2 
    int crossOverPt = int(random(0, chromLength-1)); 

    for (int i = 0; i < chromLength; i++) { 
      //get new genes from parent 1 up to crossover 
      if (i < crossOverPt) { 
        pool[k].chromosome[i] = p1.chromosome[i];
      } 
      //get new genes from parent 2 after crossover 
      else { 
        pool[k].chromosome[i] = p2.chromosome[i];
      }
    } 
    pool[k].mutate();

    //float chanceSG = random(0, 5); //chance of there being a supergoat generated this breeding
    //if ( chanceSG <= 1) {
    //  int nG = int (random(0, POP));
    //  Goat superGoat = new Goat();
    //  superGoat.birth();
    //  pool[nG] = superGoat;
    //}
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
//1. create a randomized pool

//2. rank population using a fitness function that includes location

//3. breed a new pool - many ways to do 

//4. randomly mutate the new pool 

//5. back to step 2, repeat
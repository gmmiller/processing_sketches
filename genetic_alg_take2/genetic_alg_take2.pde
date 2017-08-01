//gigi miller and maya reich
//evolving a pool of images

//take two - adding complexity 

//Global Constants
int POP = 25; 
PGraphics image;
Goat[] pool = new Goat[25];


void setup() {
  size(1000, 1000);
  background(35);
  colorMode(HSB, 360, 100, 100);
  frameRate(10);

  noStroke();
  //noLoop();

  image = createGraphics(200, 200);

  initializePool();
}


void initializePool() {
  //initialize the population randomly
  for (int i = 0; i < POP; i++) {
    Goat myGoat;
    myGoat = new Goat();
    pool[i] = myGoat;
    pool[i].birth();
    //println("goat", i, pool[i].chromosome[73]);
  }
  int j = 0;
  //assigns origin for each box
  for (int ex = 0; ex<width; ex += 200) {
    for (int why = 0; why<height; why +=200) {
      pool[j].x = ex;
      pool[j].y = why;
      j++;
    }
  }
}
void draw() {

  //drawing the GOATS
  for (int k = 0; k < pool.length; k++) {
    image.beginDraw();
    image.colorMode(HSB, 360, 100, 100);
    image.noStroke();
    //gets the background RGB values from the goats chromosome
    float bgH = pool[k].chromosome[0] * 360;
    float bgS = pool[k].chromosome[1] * 150;
    float bgB = pool[k].chromosome[2] * 200;
    image.background(bgH, bgS, bgB);
    //draws the background of each goat
    //rect(pool[k].x, pool[k].y, 200,200);

    //draw the ellipses
    int num_Ell =int( pool[k].chromosome[3] * 10);
    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) {
      float eH = pool[k].chromosome[(i*7)+4] * 360;
      float eS = pool[k].chromosome[(i*7)+5] * 150;
      float eB = pool[k].chromosome[(i*7)+6] * 200;
      float eA = pool[k].chromosome[(i*7)+7] * 255;
      float eX = pool[k].chromosome[(i*7)+8] * 200;
      float eY = pool[k].chromosome[(i*7)+9] * 200;
      float eRad = pool[k].chromosome[(i*7)+10] * 100;
      image.fill(eH, eS, eB, eA);
      image.ellipse(eX, eY, eRad, eRad);
    }
    image.endDraw();

    image(image, pool[k].x, pool[k].y);
  }
  
  //for (int j = 0; j < BP.size(); j++) {
  //  println(BP.get(j));
  //}
  //println("goat", k, pool[k].x, pool[k].y);]
  println("#################################################################################");
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
  for (int k = 0; k < pool.length; k++) {
    Goat child = new Goat();
    child.x = pool[k].x;
    child.y = pool[k].y;
    pool[k] = child;
    //parent 1 index
    Goat p1 = BP.get(int (random(0, BP.size())));
    //parent 2 index
    Goat p2 = BP.get(int (random(0, BP.size())));

    //index at which we crossover genes from parent 1 to parent 2
    int crossOverPt = int(random(0, pool[k].chromLength-1));

    for (int i = 0; i < pool[k].chromLength; i++) {
      //get new genes from parent 1 up to crossover
      if (i < crossOverPt) {
        pool[k].chromosome[i] = p1.chromosome[i];
      }
      //get new genes from parent 2 after crossover
      else {
        pool[k].chromosome[i] = p2.chromosome[i];
      }
    }
    
    pool[k].mutate(); //<>//
  }
}


void keyPressed() {
  if (key == 'r' || key == 'R') {
    initializePool();
    redraw();
  }
  if (key == 'b' || key == 'B') {
    breed();
    redraw();
  }
}


//Basic Algorithm
//1. create a randomized pool

//2. rank population using a fitness function that includes location

//3. breed a new pool - many ways to do 

//4. randomly mutate the new pool 

//5. back to step 2, repeat
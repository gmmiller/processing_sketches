//goats are the individual images we are creating
//greatest of all time

//Chromosome positions
int HEADER_LENGTH = 4;
int SHAPE_LENGTH = 7;
int MAX_SHAPES = 10;
int BG_HUE = 0; //header
int BG_SAT = 1; //header
int BG_BRI = 2; //header
int NUM_SHAPE = 3; //header
int HUE = 0;
int SAT = 1;
int BRI = 2;
int ALPH = 3;
int EX = 4;
int WHY = 5;
int RAD = 6;

int chromLength = HEADER_LENGTH + (SHAPE_LENGTH * MAX_SHAPES);

int degrees = 360;
int satMax = 100;
int brightMax = 100;
int alphaMax = 100;
int maxRad = 100;

int currentGoat = 0 ;

class Goat {
  int id = currentGoat++;
  int x, y; //location of each goat in the grid
  float FS; //fitness score out of 1 max

  float[] chromosome = new float[chromLength];
  //r, b, g, # of ellipses, 
  //each ellipse has - r, g, b, a, x, y, r (7)
  //ten circles

  void birth() {
    // randomly assigns values to the chromosome array
    for ( int i =0; i < chromosome.length; i++) {
      chromosome[i] = random(0, 1);
    }
  }


  void drawGoat(Goat goat, float t) {
    //println("drawing");
    PGraphics image;  //<>//
    image = createGraphics(widthOfGoat, heightOfGoat);

    image.beginDraw();
    image.colorMode(HSB, degrees, satMax, brightMax, alphaMax);
    image.noStroke();
    //gets the background RGB values from the goats chromosome
    float bgH = chromeLerp(goat, t, BG_HUE) * degrees;
    float bgS = chromeLerp(goat, t, BG_SAT) * satMax;
    float bgB = chromeLerp(goat, t, BG_BRI) * brightMax;
    image.background(bgH, bgS, bgB);
    //draws the background of each goat

    //draw the ellipses
    int ogNumEll = int (chromosome[NUM_SHAPE] * MAX_SHAPES);
    int newNumEll = int(goat.chromosome[NUM_SHAPE] * MAX_SHAPES);
    int num_Ell = max(ogNumEll, newNumEll);
    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) {
      float eH = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + HUE)  * degrees;
      float eS = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + SAT) * (satMax + 50); //skews circles to be more saturated
      float eB = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + BRI) * (brightMax + 100); //skews circles to be brighter
      float eA = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH) * alphaMax;
      float eX = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + EX) * widthOfGoat;
      float eY = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + WHY) * heightOfGoat;
      float eRad = chromeLerp(goat, t, HEADER_LENGTH + (i*SHAPE_LENGTH) + RAD) * maxRad;

      if (i >= ogNumEll ) {
        eA = lerp(0, goat.chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH], t) * alphaMax;
        //println("fade in", i, chromosome[NUM_SHAPE], goat.chromosome[NUM_SHAPE] );
      } else if (i >= newNumEll) {
        eA = lerp(chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH], 0, t) * alphaMax;
        //println("fade out" , i , chromosome[NUM_SHAPE], goat.chromosome[NUM_SHAPE] );
      }

      image.fill(eH, eS, eB, eA);
      image.ellipse(eX, eY, eRad, eRad);
    }
    image.endDraw();

    image(image, x, y);
  }


  float chromeLerp(Goat fgoat, float t, int i) {
    return lerp(chromosome[i], fgoat.chromosome[i], t);
  }
  //fitness test - color scheme and # of circles
  //complementary colors -- fitness function creates the breeding pool which is an array
  float getFitness() {
    float fitness;
    float radRatio;
    float radiusScore  = 0;
    float colorFitScore = 0;
    //gets the background HSB values from the goats chromosome
    float bgH = chromosome[BG_HUE] * degrees;
    //ideal complementary color
    float bgComp = (bgH + degrees/2) % degrees;
    float num_Ell =int( chromosome[3] * MAX_SHAPES);

    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) { 
      float eH = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + HUE] * degrees;
      float eRad = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + RAD] * maxRad;
      radRatio = eRad/maxRad;
      //if fitness score is in between range of 50 around complementary color, it is ideal
      //weighted by the ratio of the radius to the maximum radius
      radiusScore += radRatio;
      colorFitScore += ((1 - cos(bgComp - eH))/2)*radRatio;
    }
    //updates the fitness score of the goat based on the color fit score and the number of ellipses
    //we favor complementary colors and more circles
    if (num_Ell > 0) {
      fitness = (colorFitScore/num_Ell)*0.4 + (num_Ell/MAX_SHAPES)*0.4 + (radiusScore/num_Ell) * 0.2;
    } else {
      //if no ellipses, assign score of 0.1
      fitness = 0.1;
    }

    return fitness;
  }



  //Goat breed() {
  //  ArrayList<Goat> BP = new ArrayList<Goat>();
  //  for (Goat g : current) {
  //    //append the number of goats into the breeding pool based on the fitness score
  //    int breeders = int( g.getFitness() * 100);
  //    for (int i = 0; i < breeders; i++) {
  //      BP.add(g);
  //    }
  //  }
  //  //breed and mutate new goats to build the population

  //  Goat child = new Goat();
  //  child.x = x;
  //  child.y = y;
  //  //this = child;
  //  //parent 1 index
  //  Goat p1 = BP.get(int (random(0, BP.size())));
  //  //parent 2 index
  //  Goat p2 = BP.get(int (random(0, BP.size())));

  //  //index at which we crossover genes from parent 1 to parent 2
  //  int crossOverPt = int(random(0, chromLength-1));

  //  for (int i = 0; i < chromLength; i++) {
  //    //get new genes from parent 1 up to crossover
  //    if (i < crossOverPt) {
  //      child.chromosome[i] = p1.chromosome[i];
  //    }
  //    //get new genes from parent 2 after crossover
  //    else {
  //      child.chromosome[i] = p2.chromosome[i];
  //    }
  //  }
  //  child.mutate();
  //  return child;
  //}



  //mutate all genes of the children by a small amount
  void mutate() {
    for (int i = 0; i < chromosome.length; i++) {
      float gene = chromosome[i];
      float mutation = random(-0.1, 0.1);
      float rate = random(0, 1);
      if (rate < 1.0/chromosome.length) {
        //println(gene);
        gene += mutation;
        gene = max(min(gene, 1), 0);
        chromosome[i] = gene;
      }
    }
  }
}
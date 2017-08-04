// goat class - goats are the individual images we create //<>//
// each goat has 2 chromosomes, an x and y location, an id and a list of "neighbors"

//drawGoat() - draws the goat by reading in the chromosome 
//chromeLerp() - interpolates between the current chromosome and the future chromosome
//getFitness() - determines the fitness of the goat - returns this value
//breed() - breeds the goat based on it's localized breeding pool
//swap() - swaps the current and future chromosome 
//mutate() - mutates the chromosome
//superMutate() - creates an inverse of the goat to throw some spontaneity in the mix 


//greatest of all time

//----------------------------------------------------------------------------------------------//

//Chromosome positions
int HEADER_LENGTH = 4;
int SHAPE_LENGTH = 7;
int MAX_SHAPES = 7;
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

//length of the chromosome is determined by the number of shapes and the header
int chromLength = HEADER_LENGTH + (SHAPE_LENGTH * MAX_SHAPES);

// things we multiply the genes with to get drawable data
int hue = 360;
int satMax = 100;
int brightMax = 100;
int alphaMax = 100;
int maxRad = 25;


//***************************************************************************************************//
class Goat {
  int id;
  ArrayList<Goat> neighbors = new ArrayList<Goat>(); //list of neighbors to breed from 
  int x, y; //location of each goat in the grid
  float FS; //fitness score out of 1 max

  float[] chromosome = new float[chromLength];
  float[] Fchromosome = new float[chromLength]; //future chromosome 
  //r, b, g, # of ellipses, 
  //each ellipse has - r, g, b, a, x, y, r (7)

  //the birth of the first generation of goats, used to initialize the chromosome by randomly generating it. 
  void birth() {
    // randomly assigns values to the chromosome array
    for ( int i =0; i < chromosome.length; i++) {
      chromosome[i] = random(0, 1);
    }
  }

  //***************************************************************************************************//

  //initializes values for each gene in goat chromosome and draws resulting goat
  void drawGoat(float t) {

    PGraphics image; 
    image = createGraphics(widthOfGoat, heightOfGoat);

    image.beginDraw();
    image.colorMode(HSB, hue, satMax, brightMax, alphaMax);
    image.noStroke();

    //gets the background RGB values from the goats chromosome
    float bgH = chromeLerp( t, BG_HUE) * hue;
    float bgS = chromeLerp( t, BG_SAT) * satMax;
    float bgB = chromeLerp( t, BG_BRI) * brightMax;
    image.background(bgH, bgS, bgB);
    //draws the background of each goat

    //draw the ellipses
    int ogNumEll = int (chromosome[NUM_SHAPE] * MAX_SHAPES);
    int newNumEll = int(Fchromosome[NUM_SHAPE] * MAX_SHAPES);
    int num_Ell = max(ogNumEll, newNumEll);

    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) {
      float eH = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + HUE)  * hue;
      float eS = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + SAT) * (satMax + 50); //skews circles to be more saturated
      float eB = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + BRI) * (brightMax + 100); //skews circles to be brighter
      float eA = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH) * alphaMax;
      float eX = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + EX) * widthOfGoat;
      float eY = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + WHY) * heightOfGoat;
      float eRad = chromeLerp( t, HEADER_LENGTH + (i*SHAPE_LENGTH) + RAD) * maxRad;

      if (i >= ogNumEll ) {
        eA = lerp(0, Fchromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH], t) * alphaMax;
      } else if (i >= newNumEll) {
        eA = lerp(chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH], 0, t) * alphaMax;
      }

      image.fill(eH, eS, eB, eA);
      image.ellipse(eX, eY, eRad, eRad);
    }
    image.endDraw();

    image(image, x, y);
  }

  //***************************************************************************************************//

  // lerps between the genes in the chromosome
  float chromeLerp(float t, int i) {
    //println("chrosome lerp", chromosome[i], "Fchromosome lerp", Fchromosome[i]);
    return lerp(chromosome[i], Fchromosome[i], t);
  }

  //***************************************************************************************************//

  //fitness test - based on complementary colors weighted by size of circle and # of circles
  float getFitness() {
    float fitness;
    float radRatio;
    float radiusScore  = 0;
    float colorFitScore = 0;
    float satScore = 0;
    float nHueScore = 0; //total of all the neighbors hues
    //gets the background HSB values from the goats chromosome
    float bgH = chromosome[BG_HUE] * hue;
    //ideal complementary color
    float bgComp = (bgH + hue/2) % hue;
    float num_Ell =int( chromosome[3] * MAX_SHAPES);

    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) { 
      float eH = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + HUE] * hue;
      float eRad = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + RAD] * maxRad;
      radRatio = eRad/maxRad;

      //if fitness score is in between range of 50 around complementary color, it is ideal
      //weighted by the ratio of the radius to the maximum radius
      radiusScore += radRatio;
      colorFitScore += ((1 - cos(bgComp - eH))/2)*radRatio;
    }
    
    //iterate through all the neighbors and get their hue
    for (Goat j : neighbors){
     nHueScore += j.chromosome[BG_HUE];  
    }
    nHueScore = nHueScore/neighbors.size();
    nHueScore = abs(nHueScore - chromosome[BG_HUE]);
    
    //standard deviation of the averages 
    satScore = 1 - chromosome[BG_SAT]/satMax; 
    //updates the fitness score of the goat based on the color fit score and the number of ellipses
    //we favor complementary colors and more circles
    if (num_Ell > 0) {
      fitness = (colorFitScore/num_Ell) * 0.3 + (num_Ell/MAX_SHAPES)*0.2 + (radiusScore/num_Ell) * 0.2 + satScore * 0.2 + nHueScore * 0.5;
    } else {
      //if no ellipses, assign score of 0.1
      fitness = 0.1;
    }
    //println(fitness);
    return fitness;
  }

  //***************************************************************************************************//

  //breed the goats, store result in future chromosome 
  void breed() { 
    //BP is only made of Goats in immediate location of given Goat
    ArrayList<Goat> BP = new ArrayList<Goat>(); 
    for (Goat g : neighbors) { 
      //append the number of goats into the breeding pool based on the fitness score 
      int breeders = int( g.getFitness() * 100); 
      for (int i = 0; i < breeders; i++) { 
        BP.add(g);
      }
    } 

    //parent 1 index 
    Goat p1 = BP.get(int (random(0, BP.size()))); 
    //parent 2 index 
    Goat p2 = BP.get(int (random(0, BP.size()))); 

    for (int i = 0; i < chromLength; i++) { 
      float chance = random(0, 1);
      //get new genes from parent 1 up to crossover (50% chance)
      if (chance < 0.5) { 
        Fchromosome[i] = p1.chromosome[i];
      } 
      //get new genes from parent 2 after crossover (50% chance)
      else { 
        Fchromosome[i] = p2.chromosome[i];
      }
    } 
    mutate();
  } 

  //***************************************************************************************************//

  //put the future chromosome in the current spot once interpolation is done
  void swap() {
    float tempChromo[] = chromosome;
    chromosome = Fchromosome;
    Fchromosome = tempChromo;
  }

  //***************************************************************************************************//

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

  //***************************************************************************************************//

  //adds a "super goat" which is a mutant that is the inverse of the current goat's genes
  void superMutate() {
    for (int i = 0; i < chromosome.length; i++) {
      float gene = Fchromosome[i];
      //float mutation = random(-0.3, 0.3);
      //float rate = random(0, 1);
      //if (rate < 10/chromosome.length) {
      //println(gene);
      //gene += mutation;
      //gene = max(min(gene, 1), 0);
      Fchromosome[i] = 1 -  gene;
      Fchromosome[NUM_SHAPE] = 1.0;
      Fchromosome[BG_HUE] = random(0, 1);
    }
  }
}


// IDEAS
// color scheme
// based on neighbors (kind of done with hue )
// different shapes- lines to rectanagles or using our own shapes
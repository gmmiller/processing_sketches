//goats are the individual images we are creating
//greatest of all time

//Chromosome positions
int HEADER_LENGTH = 4;
int SHAPE_LENGTH = 7;
int MAX_SHAPES = 5;
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
int maxRad = 20;

class Goat {
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


  void drawGoat() {

    PGraphics image; 
    image = createGraphics(200, 200);

    image.beginDraw();
    image.colorMode(HSB, degrees, satMax, brightMax, alphaMax);
    image.noStroke();
    //gets the background RGB values from the goats chromosome
    float bgH = chromosome[BG_HUE] * degrees;
    float bgS = chromosome[BG_SAT] * satMax;
    float bgB = chromosome[BG_BRI] * brightMax;
    image.background(bgH, bgS, bgB);
    //draws the background of each goat

    //draw the ellipses
    int num_Ell =int( chromosome[NUM_SHAPE] * MAX_SHAPES);
    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) {
      float eH = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + HUE] * degrees;
      float eS = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + SAT] * (satMax + 50); //skews circles to be more saturated
      float eB = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + BRI] * (brightMax + 100); //skews circles to be brighter
      float eA = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + ALPH] * alphaMax;
      float eX = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + EX] * widthOfGoat;
      float eY = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + WHY] * heightOfGoat;
      float eRad = chromosome[HEADER_LENGTH + (i*SHAPE_LENGTH) + RAD] * maxRad;
      image.fill(eH, eS, eB, eA);
      image.ellipse(eX, eY, eRad, eRad);
    }
    image.endDraw();

    image(image, x, y);
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
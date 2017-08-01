//goats are the individual images we are creating
//greatest of all time

class Goat {
  int x, y; //location of each goat in the grid
  float FS; //fitness score out of 1 max
  int chromLength = 74;
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
  //fitness test - color scheme and # of circles
  //complementary colors -- fitness function creates the breeding pool which is an array
  float getFitness() {
    float fitness;
    float radRatio;
    float radiusScore  = 0;
    float colorFitScore = 0;
    //gets the background HSB values from the goats chromosome
    float bgH = chromosome[0] * 360;
    //ideal complementary color
    float bgComp = (bgH +180) % 360;
    float num_Ell =int( chromosome[3] * 10);
    
    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) { 
      float eH = chromosome[(i*7)+5] * 360;
      float eRad = chromosome[(i*7)+10] * 100;
      radRatio = eRad/100;
      //if fitness score is in between range of 50 around complementary color, it is ideal
      //weighted by the ratio of the radius to the maximum radius
      radiusScore += radRatio;
      colorFitScore += ((1 - cos(bgComp - eH))/2)*radRatio;
    }
    //updates the fitness score of the goat based on the color fit score and the number of ellipses
    //we favor complementary colors and more circles
    if (num_Ell > 0) {
      fitness = (colorFitScore/num_Ell)*0.33 + (num_Ell/10)*0.33 + (radiusScore/num_Ell) * 0.33;
    } else {
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
        println(gene);
        gene += mutation;
        gene = max(min(gene, 1), 0);
        chromosome[i] = gene;
      }
    }
  }
}
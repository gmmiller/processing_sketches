//goats are the individual images we are creating
//greatest of all time

class Goat {
  int x, y; //location of each goat in the grid
  float[] chromosome = new float[74];
  //r, b, g, # of ellipses, 
  //each ellipse has - r, g, b, a, x, y, r (7)
  //ten circles

  void birth() {
    // randomly assigns values to the chromosome array
    for( int i =0; i < chromosome.length; i++){
      chromosome[i] = random(0,1); 
    }
  }
}
//gigi miller and maya reich
//evolving a pool of images

//Global Constants
int POP = 25; 
PGraphics image;
Goat[] pool = new Goat[25];

void setup() {
  size(1000, 1000);
  background(35);
  colorMode(HSB, 360, 100, 100);

  noStroke();
  noLoop();
  
  image = createGraphics(200,200);
  
  initializePool();
}


void initializePool(){
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
    image.colorMode(HSB,360,100,100);
    image.noStroke();
    //gets the background RGB values from the goats chromosome
    float bgR = pool[k].chromosome[0] * 360;
    float bgG = pool[k].chromosome[1] * 150;
    float bgB = pool[k].chromosome[2] * 200;
    image.background(bgR, bgG, bgB);
    //draws the background of each goat
    //rect(pool[k].x, pool[k].y, 200,200);

    //draw the ellipses
    int num_Ell =int( pool[k].chromosome[3] * 10);
    //iterates through the number of ellipses in the goat 
    for (int i = 0; i < num_Ell; i++) {
      float eH = pool[k].chromosome[(i*7)+5] * 360;
      float eS = pool[k].chromosome[(i*7)+6] * 150;
      float eB = pool[k].chromosome[(i*7)+7] * 200;
      float eA = pool[k].chromosome[(i*7)+8] * 255;
      float eX = pool[k].chromosome[(i*7)+9] * 200;
      float eY = pool[k].chromosome[(i*7)+10] * 200;
      float eRad = pool[k].chromosome[(i*7)+11] * 50;
      image.fill(eH, eS, eB, eA);
      image.ellipse(eX, eY, eRad, eRad);
    }
    image.endDraw();

    image(image, pool[k].x, pool[k].y);
  }

  //println("goat", k, pool[k].x, pool[k].y);
}

//fitness test - color scheme and # of circles
//complementary colors 



void keyPressed(){
 if (key == 'r' || key == 'R'){
  initializePool();
  redraw(); 
 }
}


//Basic Algorithm
//1. create a randomized pool

//2. rank population using a fitness function that includes location

//3. breed a new pool - many ways to do 

//4. randomly mutate the new pool 

//5. back to step 2, repeat
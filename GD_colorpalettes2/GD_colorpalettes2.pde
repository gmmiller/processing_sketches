//Gigi Miller
//Learning Processing
// from Generative Design Book 



int colorCount = 20;
int[] hueValues = new int[colorCount];
int[] saturationValues = new int[colorCount];
int[] brightnessValues = new int[colorCount];
int alphaValue = 27;

int actRandomSeed = 0;

void setup() {
  size(800,800,P3D); 
  colorMode(HSB,360,100,100,100);
  noStroke();
}

void draw() { 
  background(0,0,0);
  randomSeed(actRandomSeed);

  // ------ colors ------
  // create palette
  for (int i=0; i<colorCount; i++) {
    if (i%2 == 0) {
      hueValues[i] = (int) random(0,360);
      saturationValues[i] = 100;
      brightnessValues[i] = (int) random(0,100);
    } 
    else {
      hueValues[i] = 195;
      saturationValues[i] = (int) random(0,100);
      brightnessValues[i] = 100;
    }
  }

  // ------ area tiling ------
  // count tiles
  int counter = 0;
  // row count and row height
  int rowCount = (int)random(5,30);
  float rowHeight = (float)height/(float)rowCount;

  // seperate each line in parts  
  for(int i=rowCount; i>=0; i--) {
    // how many fragments
    int partCount = i+1;
    float[] parts = new float[0];

    for(int ii=0; ii<partCount; ii++) {
      // sub fragments or not?
      if (random(1.0) < 0.075) {
        // take care of big values     
        int fragments = (int)random(2,20);
        partCount = partCount + fragments; 
        for(int iii=0; iii<fragments; iii++) {
          parts = append(parts, random(2));
        }              
      }  
      else {
        parts = append(parts, random(2,20));   
      }
    }

    // add all subparts
    float sumPartsTotal = 0;
    for(int ii=0; ii<partCount; ii++) sumPartsTotal += parts[ii];

    // draw rects
    float sumPartsNow = 0;
    for(int ii=0; ii<parts.length; ii++) {
      sumPartsNow += parts[ii];

      float x = map(sumPartsNow, 0,sumPartsTotal, 0,width);
      float y = rowHeight*i;
      float w = map(parts[ii], 0,sumPartsTotal, 0,width)*-1;
      float h = rowHeight*1.5;

      beginShape();  
      fill(0,0,0);
      vertex(x,y);
      vertex(x+w,y);
      // get component color values + aplha
      int index = counter % colorCount;
      fill(hueValues[index],saturationValues[index],brightnessValues[index],alphaValue);
      vertex(x+w,y+h);
      vertex(x,y+h);
      endShape(CLOSE);

      counter++;
    }
  }  
} 

void mouseReleased() {
  actRandomSeed = (int) random(100000);
}
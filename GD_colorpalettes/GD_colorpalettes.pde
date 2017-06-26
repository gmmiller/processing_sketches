//Gigi Miller
// Learning Processing
// From Book Generative Design P1.2.3 



int tileCountX = 50; 
int tileCountY = 10; 

int[] hueValues = new int[tileCountX];
int[] saturationValues = new int[tileCountX];
int[] brightnessValues = new int[tileCountX];


void setup() {
  size (2500, 1500);
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  
  // initiate arrays with random values
  for (int i=0; i<tileCountX; i++) {
    hueValues[i] = (int) random(0,360);
    saturationValues[i] = (int) random(0,100);
    brightnessValues[i] = (int) random(0,100);
  }
}


void draw() {
  // white back
  background(0,0,100);

  // count every tile
  int counter = 0;

  // map mouse to grid resolution
  int currentTileCountX = (int) map(mouseX, 0,width, 1,tileCountX);
  int currentTileCountY = (int) map(mouseY, 0,height, 1,tileCountY);
  float tileWidth = width / (float) currentTileCountX;
  float tileHeight = height / (float) currentTileCountY;

  for (int gridY=0; gridY< tileCountY; gridY++) {
    for (int gridX=0; gridX< tileCountX; gridX++) {  
      float posX = tileWidth*gridX;
      float posY = tileHeight*gridY;
      int index = counter % currentTileCountX;

      // get component color values
      fill(hueValues[index],saturationValues[index],brightnessValues[index]);
      rect(posX, posY, tileWidth, tileHeight);
      counter++;
    }
  }

}


void keyReleased() {
  // when 1 is pressed arrays are filled with random values, therefore any color may appear in the palette 
  if (key == '1') {
    for (int i=0; i<tileCountX; i++){
      hueValues[i] = (int) random(0,360);
      saturationValues[i] = (int) random(0, 100); 
      brightnessValues[i] = (int) random(0, 100); 
    }
  }
  // if 2 is pressed pallette is full of bright colors 
  if (key == '2') {
        for (int i=0; i<tileCountX; i++){
          hueValues[i] = (int) random(0,360);
          saturationValues[i] = (int) random(0, 100); 
          brightnessValues[i] = 100; 
    }
  }
  // saturation is set to 100 so a darker palette is created (no pastels)
    if (key == '3') {
        for (int i=0; i<tileCountX; i++){
          hueValues[i] = (int) random(0,360);
          saturationValues[i] = 100; 
          brightnessValues[i] = (int) random(0,100); 
    }
  }
  // saturation is set to 0 so a gray scale palette is produced 
  if (key == '4') {
    for (int i=0; i<tileCountX; i++){
      hueValues[i] = 00;
      saturationValues[i] = 0; 
      brightnessValues[i] = (int) random(0,100); 
    }
  }
  // hue is set to 195 and sat to 100 meaning a palette of full blue tones is created
    if (key == '5') {  
    for (int i=0; i<tileCountX; i++) {
      hueValues[i] = 195;
      saturationValues[i] = 100;
      brightnessValues[i] = (int) random(0,100);
    }
  }
  // because saturation is random but brightness and hue are set a very light blue palette is created
    if (key == '6') {  
    for (int i=0; i<tileCountX; i++) {
      hueValues[i] = 195;
      saturationValues[i] = (int) random(0,100);
      brightnessValues[i] = 100;
    }
  }
    //color ranges restricted only warmer colors (sorta green is a cool color)
    if (key == '7') {  
    for (int i=0; i<tileCountX; i++) {
      hueValues[i] = (int) random(0,180);
      saturationValues[i] = (int) random(80,100);
      brightnessValues[i] = (int) random(50,90);
    }
  }
  // other half of hue values -- purples and red palette
    if (key == '8') {  
      for (int i=0; i<tileCountX; i++) {
        hueValues[i] = (int) random(180,360);
        saturationValues[i] = (int) random(80,100);
        brightnessValues[i] = (int) random(50,90);
      }
    }
    // mixing palettes every other number is either a fixed saturation or a blue hue 
    if (key == '9') {
      for (int i=0; i<tileCountX; i++) {
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
    }
    // mixing palettes, every other number is either a purple hue or a blue hue of random sat/bright1
    if (key == '0') {  
      for (int i=0; i<tileCountX; i++) {
        if (i%2 == 0) {
          hueValues[i] = (int) 192;
          saturationValues[i] = (int) random(0,100);
          brightnessValues[i] = (int) random(10,100);
        } 
        else {
          hueValues[i] = 273;
          saturationValues[i] = (int) random(0,100);
          brightnessValues[i] = (int) random(10,90);
        }
      }
    }
    
  }
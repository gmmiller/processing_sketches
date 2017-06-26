int octaves = 4;
float falloff = 0.5;

int noiseMode = 1;

void setup() {
  size(800,800); 
  smooth();
  cursor(CROSS);
}

void draw() {
  background(0);

  noiseDetail(octaves,falloff);

  int noiseXRange = mouseX/10;
  int noiseYRange = mouseY/10;

  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float noiseX = map(x, 0,width, 0,noiseXRange);
      float noiseY = map(y, 0,height, 0,noiseYRange);

      float noiseValue = 0;
      if (noiseMode == 1) { 
        noiseValue = noise(noiseX,noiseY) * 255;
      } 
      else if (noiseMode == 2) {
        float n = noise(noiseX,noiseY) * 24;
        noiseValue = (n-(int)n) * 255;
      }

      pixels[x+y*width] = color(noiseValue);
    }
  }
  updatePixels();

  println("octaves: "+octaves+" falloff: "+falloff+" noiseXRange: 0-"+noiseXRange+" noiseYRange: 0-"+noiseYRange); 
}
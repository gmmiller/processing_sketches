void setup(){
  size(800,800);
}
  
void draw(){
randomSeed(50);
loadPixels();
for (int x = 0; x < width; x++){
  for (int y = 0; y< height; y++){
    float randomValue = random(255);
    pixels[x+y*width] = color(randomValue);
  }
}
updatePixels();
}
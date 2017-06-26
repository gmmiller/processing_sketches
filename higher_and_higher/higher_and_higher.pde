// Gigi Miller
// Experiments with Sound

//Import Minim Library
import ddf.minim.*;

Minim minim;
AudioPlayer song;



void setup() {
  size(400, 400);
  background(0);

  minim = new Minim(this);
  song = minim.loadFile("higher.mp3");
  song.cue(8690); //starts the song at the beginning of actual music
  song.play();
  println(song.length());
}

void draw() {
  background(0);
  stroke(255);
  // we draw the waveform by connecting neighbor values with a line
  // we multiply each of the values by 50 
  // because the values in the buffers are normalized
  // this means that they have values between -1 and 1. 
  // If we don't scale them up our waveform 
  // will look more or less like a straight line.
  for (int i = 0; i < song.bufferSize() - 1; i++)
  {
    line(i, 50 + song.left.get(i)*50, i+1, 50 + song.left.get(i+1)*50);
    line(i, 150 + song.right.get(i)*50, i+1, 150 + song.right.get(i+1)*50);
  }
}
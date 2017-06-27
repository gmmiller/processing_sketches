// Gigi Miller
// Experiments with Sound

//Import Minim Library
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
FFT fft;



void setup() {
  size(512, 200);
  background(0);

  minim = new Minim(this);
  song = minim.loadFile("higher.mp3", 512);
  song.cue(8690); //starts the song at the beginning of actual music
  song.play();

  //setup the FFT
  fft = new FFT(song.bufferSize(), song.sampleRate());
}

void draw() {
  background(0);
  fft.forward(song.mix);
  stroke(255, 0, 0, 128);
  //draw the spectrum as a series of vertical lines
  //notice here the fft.getband(i) is multiplied by 4 to make it more noticable
  for (int i = 0; i < fft.specSize(); i++) {
    line(i, height-20, i, height - 20 - fft.getBand(i)*4);
    println(fft.getBand(i));
  }

  //now draw the waveform

  stroke(255);
  for (int i = 0; i < song.left.size() - 1; i++) {
    line(i, 50 + song.left.get(i)*50, i +1, 50 + song.left.get(i+1)*50);
    line(i, 150 + song.right.get(i)*50, i + 1, 150 + song.right.get(i+1)*50);
  }
}
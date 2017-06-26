
ParticleSystem ps;
PImage img;

void setup() {
  size(640, 1200);
  ps = new ParticleSystem(new PVector(width/2, height-50));
  img = createImage(100,100, ARGB);
  img.loadPixels();
  for (int i=0; i < img.height; i++){
    for(int j=0; j<img.width; j++){
       int h = img.height, w = img.width;
       float distance = dist(w/2, h/2, j, i);
       float alpha = (w/2 - distance);
       if(alpha >= 240) alpha =240;
       img.pixels[i*w+j] = color(255,255,255, alpha);   
    }
  }
}

void draw() {
  background(0);
  ps.addParticle();
  ps.run();
}


// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle() {
    particles.add(new Particle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple Particle class

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, -0.005);
    velocity = new PVector(random(-1, 1), random(-8, 0));
    position = l.copy();
    lifespan = 400.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
  }

  // Method to display
  void display() {
    imageMode(CENTER);
    tint(255, lifespan);
    image(img, position.x, position.y);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
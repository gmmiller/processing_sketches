//Gigi Miller
//Using agent class from Generative Design book M.1.5.02

float noiseScale = 0.02;

class Agent {
  PVector p, pOld;
  float stepSize, angle;
  boolean isOutside = false;


  Agent() {
    p = new PVector(random(width),random(height));
    pOld = new PVector(p.x,p.y);
    stepSize = random(1,7)*noise(1,1.5);
    println(stepSize);
  }

  void update(){
    angle = 0;

    p.x += sin(angle) * stepSize;
    p.y += cos(angle) * stepSize;

    if(p.x<-10) isOutside = true;
    else if(p.x>width+10) isOutside = true;
    else if(p.y<-10) isOutside = true;
    else if(p.y>height+10) isOutside = true;

    if (isOutside) {
      p.x = random(width);
      p.y = random(height/4);
      pOld.set(p);
    }

    strokeWeight(3);
    line(pOld.x,pOld.y, p.x,p.y);

    pOld.set(p);

    isOutside = false;
  }


}
class Ribbon3d {
  int count; // how many points has the ribbon
  PVector[] p;
  boolean[] isGap;

  Ribbon3d (PVector theP, int theCount) {
    count = theCount; 
    p = new PVector[count];
    isGap = new boolean[count];
    for(int i=0; i<count; i++) {
      p[i] = new PVector(theP.x,theP.y,theP.z);
      isGap[i] = false;
    }
  }

  void update(PVector theP, boolean theIsWraped){
    // shift the values to the right side
    for(int i=count-1; i>0; i--) {
      p[i].set(p[i-1]);
      isGap[i] = isGap[i-1];
    }
    p[0].set(theP);
    isGap[0] = theIsWraped;
  }

  void drawMeshRibbon(color theMeshCol, float theWidth) {
    // draw the ribbons with meshes
    fill(theMeshCol);
    noStroke();

    beginShape(QUAD_STRIP);
    for(int i=0; i<count-1; i++) {
      // if the point was wraped -> finish the mesh an start a new one
      if (isGap[i] == true) {
        vertex(p[i].x, p[i].y, p[i].z);
        vertex(p[i].x, p[i].y, p[i].z);
        endShape();
        beginShape(QUAD_STRIP);
      } 
      else {        
        PVector v1 = PVector.sub(p[i],p[i+1]);
        PVector v2 = PVector.add(p[i+1],p[i]);
        PVector v3 = v1.cross(v2);      
        v2 = v1.cross(v3);
        //v1.normalize();
        v2.normalize();
        //v3.normalize();
        //v1.mult(theWidth);
        v2.mult(theWidth);
        //v3.mult(theWidth);
        vertex(p[i].x+v2.x,p[i].y+v2.y,p[i].z+v2.z);
        vertex(p[i].x-v2.x,p[i].y-v2.y,p[i].z-v2.z);
/*
        // arrow mesh
        if (i%5==0) {
          vertex(p[i].x, p[i].y, p[i].z);
          vertex(p[i].x, p[i].y, p[i].z);
        } 
*/
      }

    }
    endShape();
  }


  void drawLineRibbon(color theStrokeCol, float theWidth) {
    // draw the ribbons with lines
    noFill();
    strokeWeight(theWidth);
    stroke(theStrokeCol);
    beginShape();
    for(int i=0; i<count; i++) {
      vertex(p[i].x, p[i].y, p[i].z);
      // if the point was wraped -> finish the line an start a new one
      if (isGap[i] == true) {
        endShape();
        beginShape();
      } 
    }
    endShape();
  }
}
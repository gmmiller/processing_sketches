//Gigi Miller
//Learning Transformations 
//Reflections


void setup(){
 size(600,400); 
 background(0,18,50);
 cursor(CROSS);

}

void draw(){
  fill(0,18,50);
  rect(0,0,width,height);
  stroke(200);
  strokeWeight(3);
  line(0,height/2, width, height/2);
  mirror(mouseX, mouseY, 50);
}

//draws rectangles mirrored around horizon line
void mirror(float x, float y, int size){
   noStroke();
   //draws the first rect above horizon line
   if (y < height/2- size){
     //draws the first rectangle in white
     pushMatrix();
     translate(x,y);
     fill(255);
     rect(0,0, size, size);
     popMatrix();
   }else{ 
     //draws the first rectangle in white
     pushMatrix();
     translate(x, height/2-size);
     fill(255);
     rect(0,0, size, size);
     popMatrix();
   }
   
  //draws the second rectangle in gray
  pushMatrix();
  translate(x, );
  scale(1,-1);
  fill(190);
  rect(0,0,size, size);
  popMatrix();
}
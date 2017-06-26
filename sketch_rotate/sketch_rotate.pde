int r,g,b,size,alpha,bg;


void setup(){
  size(1000,1000);
  size = 10;
  alpha = 0;
  cursor(CROSS);
  bg = 90;
  
  //writes key
  textSize(10);
  fill(100);
  text("colors - r = red, b = blue, g = green, x = black, p = purple" , 0, height-30);
  text("up/down = size+/-    s = save image     left Click = toggle draw/not draw", 0, height-20);
}

void draw(){
  fill(190);
  //rect(0,0,width, height);
  fill(r,g,b,alpha);
  noStroke();
  ellipse(mouseX, mouseY,size,size);
  pushMatrix();
  translate(width, height);
  rotate(radians(180));
  ellipse(mouseX,mouseY,size,size); 
  popMatrix();
}

void keyPressed(){
  //change the color
  if (key == 'r'){
    r = 142;
    g = 11;
    b = 11;
  }
  else if (key == 'g'){
    r = 38;
    g = 119;
    b = 31;
  }
  else if (key == 'b'){
    r = 11;
    g = 33;
    b = 142;
  }else if (key == 'p'){
    r = 82;
    g = 7;
    b = 109;
  }else if (key == 'x'){
    r = 0;
    g = 0;
    b = 0;
  }
  
  //adjust the size
  else if (keyCode == UP){
   size += 10; 
  }else if (keyCode == DOWN){
   size -= 10; 
  }
  //start over and change the color of the background
  else if (keyCode == ENTER){
    fill(bg);
    rect(0,0 ,width, height);
  }
  else if (keyCode == RIGHT){
   bg += 10; 
  }
  else if (keyCode == LEFT){
   bg -= 10; 
  }
    
  
  //save the image
  else if (key == 's'){
    save("drawing.png");
  }
}

void mousePressed(){
 if (alpha == 0){
   alpha = 255;
 }else{
   alpha = 0;
 }
}
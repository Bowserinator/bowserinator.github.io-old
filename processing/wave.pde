
int sizeX, sizeY;

void setup(){
 // size(window.innerWidth,window.innerHeight);
  size(window.innerWidth, window.innerHeight);
  sizeX = window.innerWidth;
  sizeY = window.innerHeight;

  frameRate(30);
}

void drawRing(float x, float y, float w1, float w2, int segments){
    float deltaA=(1.0/(float)segments)*TWO_PI;
    beginShape(QUADS);
    for(int i=0;i<segments;i++)
    {
      vertex(x+w1*cos(i*deltaA),y+w1*sin(i*deltaA));
      vertex(x+w2*cos(i*deltaA),y+w2*sin(i*deltaA));
      vertex(x+w2*cos((i+1)*deltaA),y+w2*sin((i+1)*deltaA));
      vertex(x+w1*cos((i+1)*deltaA),y+w1*sin((i+1)*deltaA));
    }
    endShape();
 } 
 
void drawLotsRings(float x,float y){
  for(float j=0.4;j>0;j -= 0.02){
    drawRing(x,y,sizeX*j,sizeX*(j-0.01),50);
  }
}

float angle = 0;
int mode = 0;

void draw(){
  background(245); //30
 
  //drawRing(sizeX/2,sizeY/2,sizeX*0.4,sizeX*0.37,100);
  //drawLotsRings(sizeX/2,sizeY/2);
  
  if (mode == 1){
    fill(0,0,255,150); stroke(0,0,255,150);
    //drawLotsRings(mouseX,mouseY);
    drawLotsRings(sizeX/2 + cos(angle)*100, sizeY/2 + sin(angle) * 100);
    
    fill(255,0,0,150); textSize(72); stroke(255,0,0,150);
    drawLotsRings(sizeX/2 + cos(-angle+3.1415)*100, sizeY/2 + sin(-angle+3.1415) * 100);
    angle += 0.1;
  }else{
    fill(0,0,255,150); stroke(0,0,255,150);
    drawLotsRings(sizeX/2,sizeY/2);
    fill(255,0,0,150); textSize(72); stroke(255,0,0,150);
    drawLotsRings(mouseX,mouseY);
  }
  fill(0); textAlign(LEFT,TOP); textSize(sizeX/50);
  text("CLICK THE MOUSE TO SWITCH BETWEEN MODES",0,0);
}

void mousePressed(){
  mode = mode*-1 + 1;
}


PImage warpLetter;
int startHeight, startWidth;
int angleForWarp = 0;

int minimumHeight = 100;
int minimumWidth = 100;

void setup(){
  size(800, 800);
  warpLetter = loadImage("data/R.png");
  startHeight = warpLetter.height;
  startWidth = warpLetter.width;
  imageMode(CENTER);
  
  
}


void draw(){
  
  
  background(255);
  
  float tempWidth = warpLetter.width * cos(angleForWarp) + minimumHeight;
  float tempHeight = warpLetter.height * sin(angleForWarp) + minimumWidth;
  
  
  
  image(warpLetter, width/2, height/2, tempWidth, tempHeight);
  
  angleForWarp += 1.12;
  
  
  
  
}

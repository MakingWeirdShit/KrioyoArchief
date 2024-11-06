
PImage warpLetter;
int startHeight, startWidth;
float angleForWarp = 0; //NOTE, using an int here(would be wrong) but it gives us weird resultsx




int minimumHeight = 59;
int minimumWidth = 50;

int maximumHeight = 200;
int maximumWidth = 200;

void setup() {
  size(800, 800);
  warpLetter = loadImage("data/R.png");
  startHeight = warpLetter.height;
  startWidth = warpLetter.width;

  imageMode(CENTER);
}


void draw() {


  simpleWarpIntendedEffect();
  
  
}

//under this we will put code for iterations in order, this to keep older code


//simple warps where it seems we are only flipping the image
void simpleGoofyWarp() {
  background(255);

  float tempWidth = warpLetter.width * cos(angleForWarp) + minimumHeight;
  float tempHeight = warpLetter.height * sin(angleForWarp) + minimumWidth;



  image(warpLetter, width/2, height/2, tempWidth, tempHeight);

  angleForWarp += 1.12;
}

void simpleGoofyWarpInX() {
  background(255);

  float tempWidth = warpLetter.width * cos(angleForWarp) + minimumHeight;
  float tempHeight = warpLetter.height ;



  image(warpLetter, width/2, height/2, tempWidth, tempHeight);

  angleForWarp += 0.003;
}


void simpleGoofyWarpInY() {

  background(255);

  float tempWidth = warpLetter.width;
  float tempHeight = warpLetter.height * sin(angleForWarp) + minimumWidth;


  image(warpLetter, width/2, height/2, tempWidth, tempHeight);

  angleForWarp += 1.0077;
}


void simpleWarpIntendedEffect(){ //actual intended warp i wanted to make
  background(255);

  //i want sum code that will warp my letter back and forth bigger and smaller but only on the y axis or x axis or both depending on what i decide

  //store the warp letters its width and height in a variable
  float tempWidth = warpLetter.width ;
  float tempHeight = warpLetter.height ;


  //warp in x based on cos.

  float warpFactor = 5;
  tempWidth = warpLetter.width * cos(angleForWarp) * warpFactor + minimumHeight;

  image(warpLetter, width/2, height/2, tempWidth, tempHeight);

  angleForWarp += 0.03;
  
  
  
}

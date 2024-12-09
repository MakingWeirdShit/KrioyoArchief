import processing.sound.*;

FFT fft;
SoundFile soundFile;
AudioIn in;

int bands = 256;
float[] spectrum = new float[bands];
PImage warpLetter;
int startHeight, startWidth;
float angleForWarp = 0; //NOTE, using an int here(would be wrong) but it gives us weird resultsx
PImage[] letters;



int minimumHeight = 59;
int minimumWidth = 50;

int maximumHeight = 200;
int maximumWidth = 200;
String textToDisplay = "RONCHI MATTHEW"; // The text you want to visualize.

float spinAngleStart = 0;
int radius = 241;
float angleStep;

int letterIndex = 0;
void setup() {
  fullScreen();
  warpLetter = loadImage("data/R.png");
  startHeight = warpLetter.height;
  startWidth = warpLetter.width;

  letters = new PImage[26]; // 26 letters in the alphabet
  for (int i = 0; i < textToDisplay.length(); i++) {
    char letter = textToDisplay.charAt(i);
    if (letter != ' ' && letter >= 'A' && letter <= 'Z') { // Only load valid uppercase letters
      int index = letter - 'A';
      String imagePath = "data/" + letter + ".png";
      letters[index] = loadImage(imagePath);

      if (letters[index] == null) {
        println("Image for letter '" + letter + "' not found at: " + imagePath);
      }
    }
  }



  imageMode(CENTER);

  
  angleStep = 360.0 / (textToDisplay.length() - countSpaces(textToDisplay));
  
  
  //audio
  soundFile = new SoundFile(this, "Ronchi1Stereo.mp3"); // Load your audio file
  fft = new FFT(this, bands);
  fft.input(soundFile); // Set the input for the FFT
  
  soundFile.loop(); // Play the sound in a loop
}


void draw() {

  minimumWidth = 6;
  spiralWarp();
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


void simpleWarpIntendedEffect() { //actual intended warp i wanted to make
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

void spiralWarp() {
  background(255);

  translate(width / 2, height / 2); // Center the visualization

  fft.analyze(spectrum);
  // Count the valid letters (non-space, A-Z)
  int validLetterCount = 0;
  for (int i = 0; i < textToDisplay.length(); i++) {
    char currentChar = textToDisplay.charAt(i);
    if (currentChar != ' ' && currentChar >= 'A' && currentChar <= 'Z') {
      validLetterCount++;
    }
  }

  // Calculate the angle step based on the number of valid letters
  angleStep = 360.0 / validLetterCount;

  //store the warp letters its width and height in a variable

  float tempHeight = 158;


  //warp in x based on cos.

  float warpFactor = 2;
  float tempWidth = warpLetter.width * cos(angleForWarp) * warpFactor + minimumWidth;

  // Loop to draw letters on the circle
  int validLetterIndex = 0;  // To keep track of valid letters only
  for (float angle = spinAngleStart; angle < spinAngleStart + 360; angle += angleStep) {
    float x = cos(radians(angle)) * radius;
    float y = sin(radians(angle)) * radius;

    if (validLetterIndex < textToDisplay.length()) {
      //println("letter length: " + letters.length + "index " + validLetterIndex);
      char currentChar = textToDisplay.charAt(validLetterIndex);

      if (currentChar != ' ' && currentChar >= 'A' && currentChar <= 'Z') { // Only process valid letters
        int letterIndexASCII = currentChar - 'A'; // Calculate index inside the valid range
        PImage currentLetter = letters[letterIndexASCII];

        if (currentLetter != null) { // Ensure the image is loaded
        //audio analysis
        
        // Map the frequency data to the letter size fluctuation
          float lowFreq = spectrum[10] * 5;  // Low-frequency band (bass)
          float midFreq = spectrum[50] * 5;  // Mid-frequency band
          float highFreq = spectrum[100] * 5; // High-frequency band (treble)

          println("lowFreq " + lowFreq + " midFreg: " + midFreq + " highFreq: " + highFreq);
          // Map frequencies to scaling factors (adjust scale ranges as needed)
          float scaleFactorAudio = map(lowFreq, 0, 1, 0.9, 1.2); // Adjust scaling range
          //float warpFactorAudio = map(midFreq, 0, 1, 0.5, 2); // Adjust warp range

          // Apply these factors to the letter size
           tempWidth  *= scaleFactorAudio;
           tempHeight  *= scaleFactorAudio;

          // Apply additional distortion with high-frequency
          tempWidth *= (1 + highFreq * 0.5);  // Adding high frequency influence
        
        
        
          push();
          translate(x, y);
          rotate(radians(angle));
          image(currentLetter, 0, 0, tempWidth, tempHeight);  // Draw the letter at the correct position
          pop();


          push();
          float radiusMultiplier = 1.8;
          x = cos(radians(angle)) * radius * radiusMultiplier;
          y = sin(radians(angle)) * radius * radiusMultiplier ;
          translate(x, y);

          image(currentLetter, 0, 0, tempWidth, tempHeight);
          pop();
        } else {
          println("Image not loaded for letter: " + currentChar);
        }
        //println(currentChar, validLetterIndex);
        //validLetterIndex++;  // Increment valid letter index
      } else {
        // Skip invalid characters (spaces)
        println("Skipping invalid character: " + currentChar + " " + validLetterIndex);
        //validLetterIndex++;


        angle -= angleStep; //we want to increment the valid letter index so we bruhs over the space but then spatially we cant go forward so we go back
      }
      validLetterIndex++;
    }
  }





  angleForWarp += 0.03;
  spinAngleStart += 0.69;
}


// Utility function to count spaces in the string
int countSpaces(String str) {
  int count = 0;
  for (int i = 0; i < str.length(); i++) {
    if (str.charAt(i) == ' ') {
      count++;
    }
  }
  return count;
}

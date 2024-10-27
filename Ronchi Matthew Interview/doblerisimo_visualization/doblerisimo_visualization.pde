import processing.sound.*; // Importing the Sound library for audio input.

SoundFile audioFile; // Declare the SoundFile object to play an audio file.
Amplitude amplitude; // Amplitude object to measure the loudness of the audio.

ArrayList<Letter> letters = new ArrayList<Letter>(); // ArrayList to store letters.
String textToDisplay = "RONCHI MATTHEW"; // The text you want to visualize.

float easingFactor = 0.1; // Easing factor for smooth transitions.
float minSizeRatio = 0.2; // Minimum size ratio for letters.

void setup() {
    size(800, 800);
    background(255);
    
    // Initialize the audio input.
    audioFile = new SoundFile(this, "Ronchi1StereoResampled32.mp3"); // Load the audio file.
    audioFile.loop(); // Play the audio file on loop.
    amplitude = new Amplitude(this); // Create a new Amplitude object.
    amplitude.input(audioFile); // Set the audio file as the input.
    
    // Split the text into individual letters.
    char[] chars = textToDisplay.toCharArray();
    int gridCols = chars.length; // Number of columns in the grid (one per letter).
    float letterWidth = width / gridCols; // Each letter's grid width.
    float letterHeight = height / 2; // Divide the screen height in half for two rows.
    
    // Create Letter objects for each character in the text.
    for (int i = 0; i < chars.length; i++) {
        // Determine the position of each letter in the grid.
        float x = i * letterWidth;
        float y = (i < textToDisplay.indexOf(' ')) ? 0 : letterHeight; // Switch rows for letters after space.
        letters.add(new Letter(chars[i], x, y, letterWidth, letterHeight));
    }
}

void draw() {
    background(255); // Clear the screen to white.
    
    // Get the current amplitude of the audio.
    float audioAmplitude = amplitude.analyze(); // Returns a value between 0 and 1.
    
    // Update and display each letter.
    for (Letter letter : letters) {
        letter.update(audioAmplitude); // Update the letter's state based on audio amplitude.
        letter.display(); // Draw the letter to the screen.
    }
}

// Letter class to represent each letter and handle its properties and behavior.
class Letter {
    char c;
    float x, y;
    float targetWidth, targetHeight;
    float currentWidth, currentHeight;
    
    Letter(char c, float x, float y, float targetWidth, float targetHeight) {
        this.c = c;
        this.x = x;
        this.y = y;
        this.targetWidth = targetWidth;
        this.targetHeight = targetHeight;
        this.currentWidth = targetWidth * minSizeRatio;
        this.currentHeight = targetHeight * minSizeRatio;
    }
    
    void update(float audioAmplitude) {
        // Determine target size based on audio amplitude.
        float newTargetWidth = targetWidth * (minSizeRatio + audioAmplitude);
        float newTargetHeight = targetHeight * (minSizeRatio + audioAmplitude);
        
        // Easing towards the new target size for smooth transitions.
        currentWidth += (newTargetWidth - currentWidth) * easingFactor;
        currentHeight += (newTargetHeight - currentHeight) * easingFactor;
        
        // Prevent the text from moving off-screen.
        currentWidth = constrain(currentWidth, targetWidth * minSizeRatio, targetWidth);
        currentHeight = constrain(currentHeight, targetHeight * minSizeRatio, targetHeight);
    }
    
    void display() {
        // Set text properties and display the letter.
        textSize(currentHeight * 0.8); // Adjust text size based on the current height.
        textAlign(CENTER, CENTER);
        fill(0);
        
        // Draw the letter centered within its grid section.
        float centerX = x + targetWidth / 2;
        float centerY = y + targetHeight / 2;
        text(c, centerX, centerY);
    }
}

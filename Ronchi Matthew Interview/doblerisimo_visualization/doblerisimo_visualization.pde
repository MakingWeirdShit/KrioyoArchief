import processing.sound.*; // Importing the Sound library for audio input.

SoundFile audioFile; // Declare the SoundFile object to play an audio file.
Amplitude amplitude; // Amplitude object to measure the loudness of the audio.

ArrayList<Letter> letters = new ArrayList<Letter>(); // ArrayList to store letters.
String textToDisplay = "RONCHI MATTHEW"; // The text you want to visualize.

void setup() {
    size(800, 800);
    background(255);
    
    // Initialize the audio input.
    audioFile = new SoundFile(this, "Ronchi1StereoResampled.mp3"); // Load the audio file.
    audioFile.loop(); // Play the audio file on loop.
    amplitude = new Amplitude(this); // Create a new Amplitude object.
    amplitude.input(audioFile); // Set the audio file as the input.
    
    // Create Letter objects for each character in the text.
    float x = 100, y = 200; // Starting position for the first letter.
    float letterWidth = 40, letterHeight = 60; // Dimensions for each letter.
    for (char c : textToDisplay.toCharArray()) {
        letters.add(new Letter(c, x, y, letterWidth, letterHeight));
        x += letterWidth + 5; // Move the x position for the next letter.
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

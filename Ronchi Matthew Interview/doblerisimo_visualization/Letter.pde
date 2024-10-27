class Letter {
    char character; // The character to be displayed.
    PVector position; // Position of the letter.
    float originalWidth, originalHeight; // The original size of the letter.
    float currentWidth, currentHeight; // The current (possibly warped) size.
    float amplitudeInfluence; // How much the audio affects the letter.
    
    // Constructor: initializes the letter's properties.
    Letter(char character, float x, float y, float width, float height) {
        this.character = character;
        position = new PVector(x, y); // Create a vector for the letter's position.
        originalWidth = width; // Set the original width.
        originalHeight = height; // Set the original height.
        currentWidth = width; // Start with the original width.
        currentHeight = height; // Start with the original height.
        amplitudeInfluence = 0; // Initial influence from audio is zero.
    }
    
    // Update method: changes the letter's size based on audio amplitude.
    void update(float audioAmplitude) {
        // Set amplitude influence based on the current audio amplitude.
        amplitudeInfluence = audioAmplitude;
        // Update current size to make it react to the audio amplitude.
        currentWidth = originalWidth + amplitudeInfluence * 50; // Scale width.
        currentHeight = originalHeight + amplitudeInfluence * 50; // Scale height.
    }
    
    // Display method: draws the letter on the screen with current properties.
    void display() {
        pushMatrix(); // Save the current transformation state.
        translate(position.x, position.y); // Move to the letter's position.
        fill(0);
        textSize(currentHeight); // Set the text size based on current height.
        text(character, 0, 0); // Draw the character.
        popMatrix(); // Restore the previous transformation state.
    }
}

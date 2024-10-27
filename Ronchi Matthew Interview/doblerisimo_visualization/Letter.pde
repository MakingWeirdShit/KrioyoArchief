//class Letter {
//    char c;
//    float x, y;
//    float targetWidth, targetHeight;
//    float currentWidth, currentHeight;
    
//    Letter(char c, float x, float y, float targetWidth, float targetHeight) {
//        this.c = c;
//        this.x = x;
//        this.y = y;
//        this.targetWidth = targetWidth;
//        this.targetHeight = targetHeight;
//        this.currentWidth = targetWidth * minSizeRatio;
//        this.currentHeight = targetHeight * minSizeRatio;
//    }
    
//    void update(float audioAmplitude) {
//        // Determine target size based on audio amplitude.
//        float newTargetWidth = targetWidth * (minSizeRatio + audioAmplitude);
//        float newTargetHeight = targetHeight * (minSizeRatio + audioAmplitude);
        
//        // Easing towards the new target size for smooth transitions.
//        currentWidth += (newTargetWidth - currentWidth) * easingFactor;
//        currentHeight += (newTargetHeight - currentHeight) * easingFactor;
        
//        // Prevent the text from moving off-screen.
//        currentWidth = constrain(currentWidth, targetWidth * minSizeRatio, targetWidth);
//        currentHeight = constrain(currentHeight, targetHeight * minSizeRatio, targetHeight);
//    }
    
//    void display() {
//        // Set text properties and display the letter.
//        textSize(currentHeight * 0.8); // Adjust text size based on the current height.
//        textAlign(CENTER, CENTER);
//        fill(0);
        
//        // Draw the letter centered within its grid section.
//        float centerX = x + targetWidth / 2;
//        float centerY = y + targetHeight / 2;
//        text(c, centerX, centerY);
//    }
//}

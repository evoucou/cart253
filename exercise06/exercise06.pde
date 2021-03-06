 //<>//
// Exercise 06
//
// Using the webcam as input to play with Bouncers.

// Import the video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;


// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[10];

// New value which allows to change the bouncers' speed
float newSpeed;

// Set the text
String text = "THEIR FAVORITE COLOR IS RED BUT THEY'RE SCARED OF BLUE";
String line = "";

// setup()
//
// Creates the bouncers and starts the webcam

void setup() {
  size(640, 480);

  // Set the text
  line = text;
  fill(255);

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values 
    bouncers[i] = new Bouncer(random(0, width), random(0, height), random(-5, 5), random(-5, 5), random(20, 50), color(255));
  }

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
}

// draw()
//
// Processes the frame of video, draws the video to the screen, updates the Bouncers
// and then just draws an ellipse at the brightest pixel location. You code should
// do something much more interesting in order to actually interact with the Bouncers.

void draw() {
  // A function that processes the current frame of video
  handleVideoInput();

  // Draw the background
  background(0);

  // Draw the text
  text(line, width/2 - textWidth(line)/2, height/2);

  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bouncers.
  // If the brightness (or other video property) is going to interact with all the
  // Bouncers, it will need to happen in here.
  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i].setSpeed(newSpeed);
    bouncers[i].update();
    bouncers[i].display();
  }
}

// handleVideoInput
//
// Checks for available video, reads the frame, and then finds the reddest pixel
// in that frame and stores its location in reddestPixel.

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  float record = 1000;

  newSpeed = 2;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the level of red of the pixel we're looking at
      float pixelRedness = dist(255, 0, 0, red(pixelColor), green(pixelColor), blue(pixelColor));
      // Check if this pixel is the reddest we've seen so far
      if (pixelRedness < record) {
        // If it is, change the record value
        record = pixelRedness;
        // Bouncers' speed correlates with levels of red
        if (red(pixelColor) > 55 && green(pixelColor) < 45 && blue(pixelColor) < 45) {
          newSpeed = 10;
        }
        // Bouncers' speed correlates with levels of blue (stops)
        if (red(pixelColor) < 45 && green(pixelColor) < 45 && blue(pixelColor) > 55) {
          newSpeed = 0;
        }
      }
    }
  }
}
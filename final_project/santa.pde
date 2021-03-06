// Santa
//
// A class that defines Santa, whom acts a bit like a paddle


class Santa {

  ///////// Properties //////////

  int speed = 8;
  int SIZE = 45;

  int x;
  int y;
  int vx;
  int vy;
  
  PImage img;


  ///////// Constructor //////////

  Santa(int tempX, int tempY, PImage tempImg) {

    x = tempX;
    y = tempY;
    img = tempImg;
    vx = 0;
    vy = 0;
  }

  ///////// Methods //////////

  // update()
  //
  // Updates position based on velocity and constraints Santa to the window

  void update() {
    x += vx;
    y += vy;

    x = constrain(x, 0 + SIZE/2, width - SIZE/2);
  }

  // display()
  //
  // Displays Santa at its location

  void display() {
    rectMode(CENTER);

  }


  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    if (key == CODED) {
      if (keyCode == LEFT) {
        vx = -speed;
      } else if (keyCode == RIGHT) {
        vx = speed;
      }
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    if (key == CODED) {
      if (keyCode == LEFT && vx < 0) {
        vx = 0;
      } else if (keyCode == RIGHT && vx > 0) {
        vx = 0;
      }
    }
  }
}
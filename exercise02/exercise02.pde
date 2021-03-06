int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

int lineSpacing = 10;
int lineY = 100;
int lineX;
int lineLenght = 100;
color lineColor = color(255); //ADDED: these values have been added for the lines loop. They center them in the screen.

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
int ballColor;

color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

color regularBallColor = color(255); //ADDED: because we want the ball to change color, we added a new variable, newBallColor, and added a new integer, ballColor, which allows us to change the color any time.
color newBallColor;

// properties


void setup() {
  size(640, 480);
 
  drawLine(); //ADDED: for the lines to appear and always be there
  setupPaddle();
  setupBall();
  ballColor = regularBallColor;//ADDED: defining that at the beginning, the ball has its regular color.

}

//defining the beginning of the animation

void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

//defining the position of the paddle at the beginning

void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

//defining the position of ball at the beginning 

void draw() {
  
  background(backgroundColor);
  
  drawLine();//ADDED: so the lines get drawn over and over again and are visible.

  newBallColor = color(random(255),random(255),random(255)); //ADDED: we are defining the value of newBallColor here, in the void draw, so that every time the ball
  //touches the paddle, the value is recalculated again, therefore giving it a new color each time.


  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}

//static for the background

void drawLine() {
  stroke(lineColor);
  fill(lineColor);
  int lineX = 0;
  while (lineX >= 0 && lineX <= width) {
    rect(lineX, lineY, 7, lineLenght);
    lineX += lineSpacing;
  }
}
  
//ADDED: The colors of the lines are defined. We only draw one, but the loop option draws a whole range from left to right. 

void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

//allows the paddle to move, and also tells it that it cannot go further than the screen limits


void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
  handleBallSpeed();//ADDED FUNCTION
}

//allows the ball to move + its functions in order

void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

//paddle properties

void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor); //ADDED: this tells the program that the value of ballColor is always the fill for the ball.
  rect(ballX, ballY, ballSize, ballSize);
}

//ball properties

void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
    ballColor = newBallColor;//ADDED: this tells the program that everytime the ball hits the paddle, the fill (which is related to ballColor as we've seen before) is going to take the value of newBallColor.
  }
}

//meaning that if the ball touches the paddle, it has to bounce back in the opposite direction. This only defines how the ball reacts.

boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}


void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}

boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

 //this tells the ball to bounce off the paddle when it touches it (it is telling it when). The first boolean tells us that, everytime the ball
 //has the same x position as the paddle, it bounces off. BUT, the Y position also has to be true: so then, it checks the Y position of
 //the paddle. If it is true, then it bounces back. If not, then it does not. The void handleBallOffBottom tells the program that the ball
 //always has to reappear in the center of the screen if return is true.
 
 
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
     
  }
  
  
 //this tells the ball to bounce back when it touches either the right or the left side of the screen.
  
  if (ballY - ballSize/2 < lineY + lineLenght/2) { //CHANGED: the ball now bounces back when it touches the edge of the line loop.
    ballY = (lineY + lineLenght/2) + ballSize/2;
    ballVY = -ballVY;
  }
}

//this tells the ball to boune back when it touches the top of the screen.


void handleBallSpeed() {
  if (ballX - ballSize/2 < width/2 && ballY - ballSize/2 <= height) {
    println("true");
 if(ballVX < 0) 
 {ballVX=-10; }
 else {
   ballVX=10; }
   
    if(ballVY < 0) 
 {ballVY=-10; }
 else {
   ballVY=10; }
  }
  else {
     if(ballVX < 0) 
 {ballVX=-ballSpeed; }
 else {
   ballVX=ballSpeed; }
   
    if(ballVY < 0) 
 {ballVY=-ballSpeed; }
 else {
   ballVY=ballSpeed; }
  }
} //ADDED: New fonction that tells the ball that when it's in the left half of the screen, it has to go faster.

void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

//this allows us to move the paddle with right/left arrows on the keyboard

void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}

//this tells the program that when the key is released, the paddle has to stop moving.
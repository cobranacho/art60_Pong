import ddf.minim.*;
Minim minim;
AudioPlayer out;
AudioPlayer beep;

boolean gameInPlay;

Paddle leftPaddle, rightPaddle;
boolean p1Up, p1Dn, p2Up, p2Dn;
Numbers p1Score, p2Score;
Net net;
Ball ball;

Ball b;
int distFromEdge;
int w;
int h;

void setup() {
  // fullScreen();
  size(800, 600);
  noCursor();
  minim = new Minim(this);
  out = minim.loadFile("out.mp3");
  beep = minim.loadFile("beep.mp3");

  distFromEdge = width / 20;
  w = width / 85;
  h = height / 7;
  leftPaddle = new Paddle(distFromEdge, height / 2 - h / 2, w, h, color(0, 0, 255));
  rightPaddle = new Paddle(width - distFromEdge - w, height / 2 - h / 2, w, h, color(255, 0, 0)); 

  p1Score = new Numbers(width / 4, height / 16, 1 * width / 1000.0);
  p2Score = new Numbers(width - (width / 4 + int(20 * width / 1000.0)), height / 16, 1 * width / 1000.0);
  net = new Net(30);

  ball = new Ball(height / 80, color( 23, 100, 28));
  gameInPlay = true;
}

void draw() {
  background(0);
  p1Score.display();
  p2Score.display();

  if (gameInPlay) {
    leftPaddle.update();
    rightPaddle.update();
    net.display();
    ball.updatePosition();
    ball.drawBall();
    checkGameState();
  } else {
    // net.display();
    leftPaddle.drawPaddle();
    rightPaddle.drawPaddle();
    displayGameOver();
  }
}

void displayGameOver() {
  fill(255);
  textSize(width / 14);
  textAlign(CENTER);
  text("GAME OVER", width / 2, height / 2.5);

  textSize(width / 22);
  if (p1Score.getScore() > p2Score.getScore()) {
    text("PLAYER 1 WINS!", width / 2, height / 2 + height / 8);
  } else {
    text("PLAYER 2 WINS!", width / 2, height / 2 + height / 8);
  }
  fill(255, (frameCount % 125) * 2);
  text("PRESS ANY KEY TO PLAY AGAIN", width / 2, height / 2 + height / 3.5);
}


void playOutOfBoundSound() {
  if (out.position() == out.length()) {
   out.rewind();
   out.play();
  } else {
   out.play();
  }
}

void checkGameState() {

  if (ball.getPosition().x > width + ball.r || ball.getPosition().x < 0 - ball.r) {
    playOutOfBoundSound();
  }

  if (ball.getPosition().x > width + width / 3) {
    p1Score.plus();
    if ((p1Score.theNumber + p2Score.theNumber) % 2 == 0) {
      leftPaddle.reducePaddleHeight();
      rightPaddle.reducePaddleHeight();
    }
    out.pause();
    ball.resetBall(1);
  } else if (ball.getPosition().x < 0 - width / 3) {
    p2Score.plus();
    if ((p1Score.theNumber + p2Score.theNumber) % 2 == 0) {
      leftPaddle.reducePaddleHeight();
      rightPaddle.reducePaddleHeight();
    }
    out.pause();
    ball.resetBall(-1);
  }
}

void resetGame() {
  p1Score.theNumber = 0;
  p2Score.theNumber = 0;
  leftPaddle.h = h;
  leftPaddle.w = w;
  leftPaddle.updatePosition(height / 2 - h / 2);
  rightPaddle.h = h;
  rightPaddle.w = w;
  rightPaddle.updatePosition(height / 2 - h / 2);
  gameInPlay = !gameInPlay;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      p2Up = true;
      p2Dn = false;
    } else if (keyCode == DOWN) {
      p2Dn = true;
      p2Up = false;
    }
  } else if (key == 'a' || key == 'A') {
    p1Up = true;
    p1Dn = false;
  } else if (key == 'z' || key == 'Z') {
    p1Dn = true;
    p1Up = false;
  } else if (!gameInPlay) {
    resetGame();
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      p2Up = false;
    } else if (keyCode == DOWN) {
      p2Dn = false;
    }
  } else if (key == 'a' || key == 'A') {
    p1Up = false;
  } else if (key == 'z' || key == 'Z') {
    p1Dn = false;
  }
}
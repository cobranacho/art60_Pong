boolean gameOver;

Paddle leftPaddle, rightPaddle;
boolean p1Up, p1Dn, p2Up, p2Dn;
Numbers p1Score, p2Score;
Net net;
int xIncrement, yIncrement;
Ball ball;

Ball b;
int distFromEdge = 150;
int w = 16;
int h = 120;

void setup() {
  fullScreen();
  leftPaddle = new Paddle(distFromEdge, height / 2 - h / 2, w, h, color(0, 0, 255));
  rightPaddle = new Paddle(width - distFromEdge - w, height / 2 - h / 2, w, h, color(255, 0, 0)); 
  //leftPaddle = new Paddle(50);
  //rightPaddle = new Paddle(width - (50 + 10));
  p1Score = new Numbers(240, 40);
  p2Score = new Numbers(width - (240 + 20), 40);
  net = new Net(24);

  while (xIncrement > -2 && xIncrement < 2 ) {
    xIncrement = int(random(-7, 7));
  }
  while (yIncrement == 0) {
    yIncrement = int(random(-4, 4));
  }
  PVector vel = new PVector (xIncrement, yIncrement);
  ball = new Ball(width / 2, height / 2, 10, color( 23, 100, 28), vel);
}

void draw() {
  background(0);
  p1Score.display();
  p2Score.display();

  leftPaddle.update();
  rightPaddle.update();
  net.display();
  ball.updatePosition();
  ball.draw();
  checkGameState();
}

void checkGameState() {
  if (ball.getPosition().x > width) {
    p1Score.plus();
    ball.resetBall(1);
  } else if (ball.getPosition().x < 0) {
    p2Score.plus();
    ball.resetBall(-1);
  }
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
  }
  if (key == 'a' || key == 'A') {
    p1Up = true;
    p1Dn = false;
  } else if (key == 'z' || key == 'Z') {
    p1Dn = true;
    p1Up = false;
  } else if (key == 'b') {
    p1Score.plus();
  
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      p2Up = false;
    } else if (keyCode == DOWN) {
      p2Dn = false;
    }
  }

  if (key == 'a' || key == 'A') {
    p1Up = false;
  } else if (key == 'z' || key == 'Z') {
    p1Dn = false;
  }
}

class Net {
  int n;
  int h;
  int w;
  Net (int n_) {
    n = n_;
    h = (height - 120) / (2 * n);
    w = 4;
  }

  void display() {
    fill(255);
    noStroke();
    for (int i = 0; i < n * 2; i = i + 2) {
      rect(width / 2 - w / 2, h * i + 60 + h / 2, w, h);
    }
  }
}


//class Paddle {
//  // Number of positions for streak effect
//  int streakFrames = 15;

//  // List of previous y-positions for streak effect
//  int[] positions = new int[streakFrames];
//  // Index of the oldest/newest positions
//  int newestPosition = 0, oldestPosition = 0;
//  // Size and axis location of the paddle
//  color streakColor;
  
//  int xPos, yPos;
 
//  int paddleHeight;
//  int paddleWidth;

//  Paddle(int x_) {
// //   positions[newestPosition++] = yPos;
//    paddleHeight = 80;
//    paddleWidth = 10;
//    xPos = x_;
//    yPos = height / 2 - paddleHeight / 2;
//  }  

//  void reducePaddle() {
//    paddleHeight -= 4;
//    if (paddleHeight < 30) {
//      paddleHeight = 30;
//    }
//  }

//  void update() {
//    if (xPos > width / 2) {
//      if (p2Up) {
//        yPos -= 5;
//      } else if (p2Dn) {
//        yPos += 5;
//      }
//    } else {
//      if (p1Up) {
//        yPos -= 5;
//      } else if (p1Dn) {
//        yPos += 5;
//      }
//    }

//    yPos = constrain(yPos, 0, height - paddleHeight);
//    display();
//  }

//  void display() {
//    fill(255);
//    noStroke();
//    rect(xPos, yPos, paddleWidth, paddleHeight);
//  }
//}



class Numbers {
  int theNumber; 
  int xPos, yPos;
  Numbers(int xPos_, int yPos_) {
    xPos = xPos_;
    yPos = yPos_;
    theNumber = 0;
  }

  void plus() {
    theNumber++;
    if (theNumber == 12) {
      theNumber = 0;
    }
  }

  int getScore() {
    return theNumber;
  }

  void display() {
    stroke(255);
    strokeWeight(8);
    strokeJoin(MITER);
    strokeCap(SQUARE);
    noFill();
    pushMatrix();
    translate(xPos, yPos);
    switch(theNumber) {
    case 0: 
      beginShape();
      vertex(0, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(0, 60);
      endShape(CLOSE);
      break;
    case 1:
      line(20, -3, 20, 63);
      break;
    case 2:
      beginShape();
      vertex(-6, 0);
      vertex(20, 0);
      vertex(20, 26);
      vertex(0, 26);
      vertex(0, 60);
      vertex(26, 60);
      endShape();
      break;
    case 3:
      beginShape();
      vertex(-6, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(-6, 60);
      endShape();
      line(-6, 26, 20, 26);
      break;
    case 4:
      beginShape();
      vertex(0, -3);
      vertex(0, 26);
      vertex(20, 26);
      endShape();
      line(20, -3, 20, 63);
      break;
    case 5:
      beginShape();
      vertex(26, 0);
      vertex(0, 0);
      vertex(0, 26);
      vertex(20, 26);
      vertex(20, 60);
      vertex(-6, 60);
      endShape();
      break;
    case 6:
      beginShape();
      vertex(0, -3);
      vertex(0, 60);
      vertex(20, 60);
      vertex(20, 26);
      vertex(0, 26);
      endShape();
      break;
    case 7:
      beginShape();
      vertex(-6, 0);
      vertex(20, 0);
      vertex(20, 60);
      endShape();
      break;
    case 8:
      beginShape();
      vertex(0, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(0, 60);
      endShape(CLOSE);
      line(0, 26, 20, 26);
      break;
    case 9:
      beginShape();
      vertex(20, 63);
      vertex(20, 0);
      vertex(0, 0);
      vertex(0, 26);
      vertex(20, 26);
      endShape();
      break;
    case 10:
      beginShape();
      vertex(0, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(0, 60);
      endShape(CLOSE);
      line(-30, -3, -30, 63);
      break;
    case 11:
      line(20, -3, 20, 63);
      line(-30, -3, -30, 63);
      break;
    }
    popMatrix();
  }
}
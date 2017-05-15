/*
*  Project: Pong group project
*  Student:  James Hu, Sergio Hidalgo, Moo Kyung Sohn
*  Pasadena  City  College,  Spring  2017  
*  Instructor  Masood  Kamandy  
*    
*  Project  Description:  This is a clone of the classic video
*  game that combines 70's Atari and 80's era Nintendo elements
*
*  Last  Modified:  May  15,  2017  
*    
*/

import ddf.minim.*;
Minim minim;
AudioPlayer out;
AudioPlayer beep;
AudioPlayer win;
AudioPlayer intro;

// game state (true or false) to detect game over condition (one of the score reaches 11)
boolean gameInPlay;

//scale transform
int s;

Paddle leftPaddle, rightPaddle;
boolean p1Up, p1Dn, p2Up, p2Dn;
Number p1Score, p2Score;
Net net;
// Add 2nd Ball Object
Ball ball, ball2;

// Paddle width and height and 
int distFromEdge;
int w;
int h;
PFont font;

void setup() {
  fullScreen();
  //size(800, 600);
  noCursor();
  minim = new Minim(this);
  out = minim.loadFile("out.mp3");
  beep = minim.loadFile("beep.mp3");
  win= minim.loadFile("magical8bittour.mp3");
  intro= minim.loadFile("Fanfare.mp3");

  // Initialize all game objects with sizes and positions relative to sketch screen size
  distFromEdge = width / 20;
  w = width / 85;
  h = height / 7;
  leftPaddle = new Paddle(distFromEdge, height / 2 - h / 2, w, h, color(0, 0, 255));
  rightPaddle = new Paddle(width - distFromEdge - w, height / 2 - h / 2, w, h, color(255, 0, 0)); 

  p1Score = new Number(width / 4, height / 16, 1 * width / 1200.0);
  p2Score = new Number(width - (width / 4 + int(20 * width / 1200.0)), height / 16, 1 * width / 1200.0);
  net = new Net(30);

  ball = new Ball(height / 80, color( 23, 100, 28));
  gameInPlay = true;
}

void draw() {
  background(0);

  if (millis() < 17000)//in milliseconds
  {
    displayIntro();
  } else { 
    intro.pause();
    intro.rewind();
    p1Score.display();
    p2Score.display();
    if (gameInPlay) {
      // normal game play update

      leftPaddle.update();
      rightPaddle.update();
      net.display(); 
      ball.updatePosition();
      ball.drawBall() ; 
      checkGameState();
      win.pause() ;
      win.rewind();
    } else {
      // display when gameIsOver == true
      leftPaddle.drawPaddle();
      rightPaddle.drawPaddle();
      displayGameOver();
      win.play();
    }
  }
}

void displayIntro() {
  intro.play();
  //textSize(width / 16-s);
  textAlign(CENTER);
  font= createFont("8-BIT WONDER.TTF", 110);


  textFont(font);
  fill(0, 255,0);
  textSize(110 +.45*s);
  text("PONG", width / 2, height / 2.5);
  s+=1;

  textSize(50+.2*.2*s);
  fill(250, 33, 232);
  text("created by", width / 2, height - height/2*5/6);
  fill(33, 100, 250);
  text("Sergio Hidalgo", width / 2, height - height/2*3/5);
  fill(33, 250, 217);
  text("James Hu", width / 2, height - height/2*2/5);
  fill(255, 240, 2);
  text("Mookyung Sohn", width / 2, height - height/2*1/5 );
}
// method to draw the game over text 
void displayGameOver() {
  textSize(width / 16);
  textAlign(CENTER);
  font= createFont("8-BIT WONDER.TTF", 110);
  textFont(font);
  fill(255, 0, 0);//back color
  text("GAME OVER", width / 2, height / 2.5);
  fill(250, 33, 232, (frameCount % 150) * 2);
  text("GAME OVER", width / 2, height / 2.5);

  textSize(width / 24);
  if (p1Score.getScore() > p2Score.getScore()) {
    fill(0, 0, 255);
    text("PLAYER 1 WINS", width / 2, height / 2 + height / 8);
  } else {
    fill(255, 0, 0);
    text("PLAYER 2 WINS", width / 2, height / 2 + height / 8);
  }
  fill(255, (frameCount % 125) * 2);

  textSize(width /28);
  text("PRESS ANY KEY TO PLAY AGAIN", width / 2, height / 2 + height / 3.5);
}

// play the out audio when ball is out of bound
void playOutOfBoundSound() {
  if (out.position() == out.length()) {
    out.rewind();
    out.play();
  } else {
    out.play();
  }
}

void checkGameState() {

  // check if the ball reaches the left or right edge of the screen
  if (ball.getPosition().x > width + ball.r || ball.getPosition().x < 0 - ball.r) {
    playOutOfBoundSound();
  }

  // play the out audio until the ball progresses further out of bound, effectively creating 
  // a pause of game play before a new ball position if generated
  if (ball.getPosition().x > width + width / 3) {
    p1Score.plus();

    // for every 2 score points reduced the paddle height to increase game difficulty
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

// reset Game state when the players decide to play again
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
// player2 (rightPaddle) controls up and down movement with UP and DOWN arrow keys
// Player1 (leftPaddle) controls up and down movement with 'a', 'A', and 'z', 'Z' keys
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
  } else if (!gameInPlay) {  // if game is over any key will restart the game
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
  class Ball { //<>//
  // List of previous positions for streak effect
  ArrayList<PVector> positions = new ArrayList<PVector>();
  // Velocity of the ball 
  PVector velocity;
  // Index of the oldest position
  int oldestPosition = 0;
  // Number of positions for streak effect
  int streakFrames = 10;
  // Radius of the ball
  int r;
  // Color of the streak
  color streakColor;
  // Counter to track current number of frame current ball is in play
  int counter;
  // small increment to add to the y component of velocity vector based on paddle speed at time of ball contact
  float spin;

  Ball(int r, color col) {
    this.r = r;
    streakColor = col;
    resetBall(round(random(-1, 1))); // -1 and 1 represent direction for x component of the velocity vector
  }

  PVector getPosition() {
    PVector pos;
    if (positions.size() < streakFrames) {
      pos = positions.get(positions.size() - 1);
    } else {
      pos = positions.get((streakFrames + oldestPosition - 1) % streakFrames);
    }
    return new PVector(pos.x, pos.y);
  }

  void resetBall(int direction) {
    float xIncrement, yIncrement;
    
    // generate the x component of the velocity vector for direction and speed
    if (direction >= 0) {
      xIncrement = width / 240.0;
    } else {
      xIncrement = width / -240.0;
    }
    
    // generate the y component of the velocity vector for angle
    yIncrement = random(-5, 5) * width / 1200.0;
    if (yIncrement == 0) {
      yIncrement = 3;
    }
    velocity = new PVector(xIncrement, yIncrement);
    
    // start the ball position at the center of the screen
    updatePosition(width/2, height/2);
  }

  void updatePosition() {
    counter++;
    PVector pos = getPosition();

    // Top and bottom screen collision
    if ((pos.y + r) > height && pos.x + r < width && pos.x - r > 0) {
      playBeep();
      velocity.y = -1*velocity.y;
    }
    if ((pos.y - r) < 0 && pos.x + r < width && pos.x - r > 0) {
      playBeep();
      velocity.y = -1*velocity.y;
    }
    // Paddle collision
    if (pos.x + r > rightPaddle.x && pos.y + r > rightPaddle.getY() && pos.y - r < rightPaddle.getY() + h
      && velocity.x > 0  && pos.x - r < rightPaddle.x + rightPaddle.w) {
      playBeep();
      velocity.x = -1 * velocity.x;  // reverse ball x direction
      velocity.y += spin;            // add a bit the y of velocity to alter the angle of ball
    } else if (pos.x - r < leftPaddle.x + leftPaddle.w && pos.y + r > leftPaddle.getY() && pos.y - r < leftPaddle.getY() + h 
      && velocity.x < 0 && pos.x + r > leftPaddle.x) {
      playBeep();
      velocity.x = -1 * velocity.x;  // reverse ball x direction
      velocity.y += spin;            // add a bit the y of velocity to alter the angle of ball
    }
    updatePosition(pos.x + velocity.x, pos.y + velocity.y);

    // for every 360 frame count increase the ball velocity by 20 percent until it reaches a threshold based on screen width
    if (counter % 360 == 0) {
      if ((velocity.x < width / 100 && velocity.x > -width / 100) && (velocity.y < width / 100 && velocity.y > -width / 100)) {  
        velocity.mult(1.2);
      }
    }
  }

  void playBeep() {
    if (beep.position() == beep.length()) {
      beep.rewind();
      beep.play();
    } else {
      beep.play();
    }
  }

  void setSpin(float paddleSpeed) {
    if (paddleSpeed != 0) {
      spin = paddleSpeed / 40.0; 
    }
  }

  void updatePosition(float x, float y) {
    // If we do not have the max number of frames
    if (positions.size() < streakFrames) {
      positions.add(new PVector(x, y));
    } else {
      // Replace the oldest position with newest
      positions.set(oldestPosition++, new PVector(x, y));
      // Update the value of oldest position 
      oldestPosition %= streakFrames;
    }
  }

  void drawBall() {

    PVector pos;
    int frames = min(positions.size(), streakFrames);
    float step = 1.0/(frames - 1);
    noStroke();
    for (int i = 1; i <= frames; i++) {
      pos = positions.get((i + oldestPosition - 1) % streakFrames);
      // fill depends on whether it is the newest position or not
      if (i != frames)
        fill(lerpColor(0, streakColor, i*step));
      else
        fill(255);
      ellipse(pos.x, pos.y, 2*r, 2*r);
    }
  }
}
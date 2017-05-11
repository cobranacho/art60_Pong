class Ball {
  // List of previous positions for streak effect
  ArrayList<PVector> positions = new ArrayList<PVector>();
  // Velocity of the ball 
  PVector velocity;
  // Index of the oldest position
  int oldestPosition = 0;
  // Number of positions for streak effect
  int streakFrames = 10;
  // Size of the ball
  int r;
  // Color of the streak
  color streakColor;

  Ball(int x0, int y0, int r, color col, PVector vel) {
    positions.add(new PVector(x0, y0));
    this.r = r;
    streakColor = col;
    velocity = new PVector(vel.x, vel.y);
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
    int xIncrement = 0, yIncrement = 0;

    xIncrement = int(random(5, 7)) * direction;

    while (yIncrement == 0) {
      yIncrement = int(random(-4, 4));
    }
    velocity = new PVector (xIncrement, yIncrement);
    updatePosition(width/2, height/2);
  }

  void updatePosition() {
    PVector pos = getPosition();

    //if ((pos.x + velocity.x) > width)
    //  velocity.x = -1*velocity.x;
    //if ((pos.x + velocity.x) < 0)
    //  velocity.x = -1*velocity.x;    
    if ((pos.y + velocity.y) > height)
      velocity.y = -1*velocity.y;    
    if ((pos.y + velocity.y) < 0)
      velocity.y = -1*velocity.y;

    if (pos.x + r > rightPaddle.x && pos.y + r > rightPaddle.getY() && pos.y - r < rightPaddle.getY() + h
      && velocity.x > 0  && pos.x < rightPaddle.x + rightPaddle.h) {
      velocity.x = -1 * velocity.x;
    } else if (pos.x - r < leftPaddle.x + leftPaddle.w && pos.y + r > leftPaddle.getY() && pos.y - r < leftPaddle.getY() + h 
    && velocity.x < 0 ) {
      velocity.x = -1 * velocity.x;
    }
    updatePosition(pos.x + velocity.x, pos.y + velocity.y);
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

  void draw() {
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
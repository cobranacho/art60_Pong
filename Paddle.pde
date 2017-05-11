class Paddle {
  // Number of positions for streak effect
  int streakFrames = 15;

  // List of previous y-positions for streak effect
  int[] positions = new int[streakFrames];
  // Index of the oldest/newest positions
  int newestPosition = 0, oldestPosition = 0;
  // Size and axis location of the paddle
  int x, w, h;
  // Color of the streak
  color streakColor;

  private Paddle() {
  }

  Paddle(int x, int y, int w, int h, color col) {
    positions[newestPosition++] = y;
    this.x = x;
    this.w = w;
    this.h = h;
    streakColor = col;
  }

  void reducePaddleHeight() {
      h -= 10;
  }
  void update(){
    int y = getY();
   if (x > width / 2) {
     if (p2Up) {
       y -= 7;
     } else if (p2Dn) {
       y += 7;
     }
   } else {
     if (p1Up) {
       y -= 7;
     } else if (p1Dn) {
       y += 7;
     }
   }

   y = constrain(y, 0, height - h);
  updatePosition(y);
  draw();
  }

  int getY(){  
    if(newestPosition < streakFrames){
     return positions[newestPosition - 1];
    }
    return positions[(streakFrames + oldestPosition - 1) % streakFrames];    
  }

  void updatePosition(int y) {
    // If we do not have the max number of frames
    if (newestPosition < streakFrames) {
      positions[newestPosition++] = y;
    } else {
      // Replace the oldest position with newest
      positions[oldestPosition++] = y;
      // Update the value of oldest position 
      oldestPosition %= streakFrames;
    }
  }

  void draw() {
    int frames = min(newestPosition, streakFrames);
    float step = 1.0/(newestPosition - 1);
    noStroke();
    for (int i = 1; i <= frames; i++) {
      // fill depends on whether it is the newest position or not
      if (i != frames)
        fill(lerpColor(0, streakColor, i*step));
      else
        fill(255);
      rect(x, positions[(i + oldestPosition - 1) % streakFrames], w, h);
    }
  }
}
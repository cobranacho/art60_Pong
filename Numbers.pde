
class Numbers {
  int theNumber; 
  int xPos, yPos;
  float scale;
  Numbers(int xPos_, int yPos_, float scale_) {
    xPos = xPos_;
    yPos = yPos_;
    scale = scale_;
    theNumber = 0;
  }

  // class method to add 1 to the score and to detect when the score reaches 11, then set the global gameInPlay to false
  void plus() {
    theNumber++;
    if (theNumber == 11) {
      gameInPlay = false;
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
    scale(scale);
    
    switch(theNumber) {
    case 0: 
      beginShape();
      vertex(0, 0);
      vertex(24, 0);
      vertex(24, 60);
      vertex(0, 60);
      endShape(CLOSE);
      break;
    case 1:
      line(24, -3, 24, 63);
      break;
    case 2:
      beginShape();
      vertex(-6, 0);
      vertex(24, 0);
      vertex(24, 30);
      vertex(0, 30);
      vertex(0, 60);
      vertex(30, 60);
      endShape();
      break;
    case 3:
      beginShape();
      vertex(-6, 0);
      vertex(24, 0);
      vertex(24, 60);
      vertex(-6, 60);
      endShape();
      line(-6, 30, 20, 30);
      break;
    case 4:
      beginShape();
      vertex(0, -3);
      vertex(0, 30);
      vertex(24, 30);
      endShape();
      line(24, -3, 24, 63);
      break;
    case 5:
      beginShape();
      vertex(30, 0);
      vertex(0, 0);
      vertex(0, 30);
      vertex(24, 30);
      vertex(24, 60);
      vertex(-6, 60);
      endShape();
      break;
    case 6:
      beginShape();
      vertex(0, -3);
      vertex(0, 60);
      vertex(24, 60);
      vertex(24, 30);
      vertex(0, 30);
      endShape();
      break;
    case 7:
      beginShape();
      vertex(-6, 0);
      vertex(24, 0);
      vertex(24, 60);
      endShape();
      break;
    case 8:
      beginShape();
      vertex(0, 0);
      vertex(24, 0);
      vertex(24, 60);
      vertex(0, 60);
      endShape(CLOSE);
      line(0, 30, 24, 30);
      break;
    case 9:
      beginShape();
      vertex(24, 63);
      vertex(24, 0);
      vertex(0, 0);
      vertex(0, 30);
      vertex(24, 30);
      endShape();
      break;
    case 10:
      beginShape();
      vertex(0, 0);
      vertex(24, 0);
      vertex(24, 60);
      vertex(0, 60);
      endShape(CLOSE);
      line(-30, -3, -30, 63);
      break;
    case 11:
      line(24, -3, 24, 63);
      line(-30, -3, -30, 63);
      break;
    }
    popMatrix();
  }
}
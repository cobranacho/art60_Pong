
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
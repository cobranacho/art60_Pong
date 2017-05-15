
class Number {
  int theNumber; 
  int xPos, yPos;
  float scale;
  Number(int xPos_, int yPos_, float scale_) {
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
      stroke(255, 255,255);
      beginShape();
      vertex(0, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(0, 60);
      endShape(CLOSE);
      break;
    case 1:
      stroke (255, 127, 0);
      line(20, -3, 20, 63);
      break;
    case 2:
      stroke(255, 255, 0);
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
      stroke (0, 255, 0);
      beginShape();
      vertex(-6, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(-6, 60);
      endShape();
      line(-6, 26, 20, 26);
      break;
    case 4:
      stroke(0, 255, 255);
      beginShape();
      vertex(0, -3);
      vertex(0, 26);
      vertex(20, 26);
      endShape();
      line(20, -3, 20, 63);
      break;
    case 5:
      stroke(0, 127, 255);
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
      stroke(0, 0, 255);
      beginShape();
      vertex(0, -3);
      vertex(0, 60);
      vertex(20, 60);
      vertex(20, 26);
      vertex(0, 26);
      endShape();
      break;
    case 7:
      stroke(127, 0, 255);
      beginShape();
      vertex(-6, 0);
      vertex(20, 0);
      vertex(20, 60);
      endShape();
      break;
    case 8:
      stroke (255, 0, 255);
      beginShape();
      vertex(0, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(0, 60);
      endShape(CLOSE);
      line(0, 26, 20, 26);
      break;
    case 9:
      stroke (255, 0, 127);
      beginShape();
      vertex(20, 63);
      vertex(20, 0);
      vertex(0, 0);
      vertex(0, 26);
      vertex(20, 26);
      endShape();
      break;
    case 10:
      stroke (238, 139, 238);
      beginShape();
      vertex(0, 0);
      vertex(20, 0);
      vertex(20, 60);
      vertex(0, 60);
      endShape(CLOSE);
      line(-30, -3, -30, 63);
      break;
    case 11:
      stroke(255, 0, 0);
      line(20, -3, 20, 63);
      line(-30, -3, -30, 63);
      break;
    }
    popMatrix();
  }
}

void lostGame() {
  push();
  //once again this makes it look like i put effort into this
  fill(26, 125);
  rect( 0, 0, width, height);
  fill(255);

  //draws buttons
  b1.drawButton((width/2)-150, height-(height/3 + (120)), 1, Screen.PLAY);
  b2.drawButton((width/2)-150, height-(height/3), 1, Screen.MENU);
  b3.drawButton(0, 0, 0, Screen.NONE);
  pop();

  //effort-innator 2000
  looping = false;
  score = 0;
  resetPlayBalls = true;
}

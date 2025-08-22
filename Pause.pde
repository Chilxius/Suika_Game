/*Paused game Screen
 
 This takes advantage of the fact that things are layered over one another in
 proccessing, this just stops the loop and draws over it.
 giving the illision that I put effort into it.*/

void pauseGame() {
  push();
  //once again this makes it look like i put effort into this
  fill(26, 125);
  rect( 0, 0, width, height);
  fill(255);

  //draws buttons
  b1.drawButton((width/2)-150, height-(height/3 + (120*2)), 1, Screen.PLAY);
  b2.drawButton((width/2)-150, height-(height/3 + (120)), 1, Screen.SAVE);
  b3.drawButton((width/2)-150, height-(height/3), 1, Screen.MENU);


  image(btnImgs[1], (width/2), height-(height/3 + (95*2)));
  image(btnImgs[4], (width/2), height-(height/3 + (75)));
  image(btnImgs[2], (width/2), height-(height/3) + 50);

  pop();

  //effort-innator 2000
  looping = false;
}

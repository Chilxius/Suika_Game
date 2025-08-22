//Main Menu
//Uses 2 buttons
//Has its own Array for the balls that appears
void mainMenu()
{

  push();
  ///BACKGROUND FOR MAIN MENU
  background(0);

  //how long until the next ball is spawned. Hint: its random.
  if (menuTimer < millis())
  {
    spawnBall(Screen.MENU);
    menuTimer = millis() + int(random(500, 3000));
  }

  //Draw ma Balls
  for (int i = 0; i < menuBalls.size(); i++)
  {
    menuBalls.get(i).drawBall();
    menuBalls.get(i).moveBall();
  }

  //Remove ma balls
  for (int i = 0; i < menuBalls.size(); i++)
    for (int ballNum = i+1; ballNum < menuBalls.size(); ballNum++)
      if (i!=ballNum)
        if ((menuBalls.get(i).whatBall(menuBalls.get(ballNum))))
          menuBalls.remove(ballNum);

  //this is so the background actually looks like the background
  fill(255, 125);
  rect( 0, 0, width, height);
  fill(255);

  //draws the buttons
  b1.drawButton((width/2)-150, height-(height/3 + 120), 1, Screen.PLAY);
  b2.drawButton((width/2)-150, height-(height/3), 1, Screen.LOAD);
  b3.drawButton(0, 0, 0, Screen.NONE);

  fill(255, 150);
  rect( (width/2)-(width-250)/2, height/12, width-250, 200, 10);
  
  //button images
  image(btnImgs[0], (width/2), height/4);
  image(btnImgs[1], (width/2), height-(height/3)- 70);
  image(btnImgs[5], (width/2), height-(height/3)+ 50);

  pop();

  if (playBalls.size() > 0)
    resetPlayBalls = true;
}

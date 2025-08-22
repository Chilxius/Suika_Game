//ACTUAL GAME
//This has its own ball array lists so that the menu one does not interfere with it
void playGame()
{
  push();
  background(230);

  //Basic
  //High Score Containers / High Combo
  fill(255);
  rect(20, 80, 160, 200, 10);



  b1.drawButton(20, height-(height/3 + 110), 2, Screen.SAVE);
  image(btnImgs[4], 100, height-(height/3 + 70));

  b2.drawButton(20, 10, 3, Screen.PAUSE);
  //dashes for button2
  strokeWeight(8);
  line(40, 25, 40, 55);
  line(60, 25, 60, 55);
  strokeWeight(1);
  b3.drawButton(0, 0, 0, Screen.NONE);

  //Next Food
  fill(255);
  rect(width - 180, 80, 160, 200, 10);
  fill(0);
  textSize(32);
  text("Next Ball", width- 158, 120);

  //scores
  text("High Score", 30, 120);
  text("Score", 30, 210);
  textSize(29);
  text(highscore, 30, 155);
  text(score, 30, 245);

  if (highscore < score)
    highscore = score;

  //Container
  fill(0);
  line((width/2 - width/containerWidth), 80, (width/2 - width/containerWidth), height - 20);
  line((width/2 + width/containerWidth), 80, (width/2 + width/containerWidth), height - 20);
  line((width/2 - width/containerWidth), height - 20, (width/2 + width/containerWidth), height - 20);


  //Draw ma Balls
  for (int i = 0; i < playBalls.size(); i++)
  {
    //balls.get(i).moveThreat();
    playBalls.get(i).drawBall();
    playBalls.get(i).moveBall();
  }

  //Ball / Physics Handler
  //I might have to make a for loop within one to check for everyball :(
  for (int i = 0; i < playBalls.size(); i++)
    for (int ballNum = i+1; ballNum < playBalls.size(); ballNum++)
      if (i!=ballNum)
        if ((playBalls.get(i).whatBall(playBalls.get(ballNum))))
          playBalls.remove(ballNum);

  //Lose condition
  for (int i = 0; i < playBalls.size(); i++)
    if (canLose)
      if (playBalls.get(i).pos.y < 80 && dropperTimer < millis())
        currentScreen = Screen.LOST;

  //Dropper
  dropperX = mouseX;

  if (mouseX < 250)
  {
    dropperX = 250;
  }
  if (mouseX > 550)
  {
    dropperX = 550;
  }

  //dropper timer
  if (dropperTimer > millis())
    fill(200);
  else
    fill(255);

  //dropper
  ellipse(dropperX, 25, 100, 50);

  pop();
}

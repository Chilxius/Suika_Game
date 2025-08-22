class Button
{
  //attributes
  int type, x, y, w, h, fill;

  Screen whereTake;

  public Button()
  {
    whereTake = Screen.NONE; //buffer WhereTake;
    x = 0; //buffer x;
    y = 0; //buffer y;
    type = 0; //Buffer type;
    fill = int(random(2));
  }

  void drawButton(int bx, int by, int Btype, Screen bWhereTake)
  {
    push();
    if (fill == 0) {
      fill(#FFAB5D);
    }
    else {
      fill(#FF9F46);
    }

    whereTake = bWhereTake;
    x = bx;
    y = by;
    type = Btype;

    if (type == 0)
    {
      w = 0;
      h = 0;
      rect(x, y, w, h);
    }

    //what button looks like
    if (type == 1)
    {
      w = 300;
      h = 100;
      rect(x, y, w, h, 10);
    }

    //what button looks like
    if (type == 2)
    {
      w = 160;
      h = 80;
      rect(x, y, w, h, 10);
    }
    
    //what looks like
    if (type == 3)
    {
      w = 60;
      h = 60;
      rect(x, y, w, h, 10);
    }

    pop();
  }

  void underMouse()
  {
    if (x < mouseX && mouseX < (x + w))
      if (y < mouseY && mouseY < (y + h))
      {
        for (int i = 0; i < menuBalls.size(); i++)
          menuBalls.remove(i);

        if (!looping)
        {
          looping = true;
          loop();
        }

        currentScreen = whereTake;
      }
  }
}

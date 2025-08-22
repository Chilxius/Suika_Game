class Ball
{
  //attributes
  int type;
  int bounces;
  int value;
  PVector pos;
  PVector spd;
  int radius;
  float rotation;


  //Box Properties
  int boxLeft;
  int boxRight;
  int boxBottom;

  public Ball(float x, float y, int type1)
  {
    type = type1; //defines types of ball
    pos = new PVector(x, y); //Position 
    spd = new PVector(0, 0); // Speed
  }

  void drawBall()
  {

    //THIS DRAWS THE BALL IN THE "NEXT BALL" BOX
    if (currentScreen == Screen.PLAY) {
      image(ballImgs[currentNextBall[1]], width- 100, 190);
    }


    // 2 arrays that determin the color and size of the balls

    //makes the ball proper radius
    radius = ballSizes[type];
    //makes the ball have the proper value
    value = ballValue[type];
    //make the ball its color
    push();
    translate(pos.x, pos.y);
    rotate(rotation);
    image(ballImgs[type], 0, 0);
    pop();
    //resets color
    fill(0);
  }

  void moveBall()
  {

    //gives speed
    pos.x += spd.x;
    pos.y += spd.y;
    rotation += spd.x/50;

    //drag / friction
    spd.y *= 0.90 + (type/100);
    spd.x *= 0.97 + (type/50);

    //the container bounds
    if (currentScreen == Screen.PLAY)
    {
      boxLeft = (width/2 - width/containerWidth);
      boxRight = (width/2 + width/containerWidth);
      boxBottom = (height - 20);
    }

    //sets boundries to window size
    if (currentScreen == Screen.MENU)
    {
      boxLeft = 0;
      boxRight = width;
      boxBottom = height;
    }

    //this is what pushes / teleports the balls into the container.
    if (pos.y >= boxBottom - radius)
    {
      if (bounces < 2)
      {
        spd.y *= -1;
        bounces+=1;
      } else
      {
        spd.y = 0;
        if (pos.y > boxBottom - radius )
          pos.y = (boxBottom) - radius;
      }
    } else if (pos.y <= boxBottom - radius)
      spd.y += 1;

    //keeps within box horrizontally
    if ((pos.x + radius) >= boxRight)
    {
      spd.x = 0;
      pos.x = boxRight - radius;
    } else if ((pos.x - radius) <= boxLeft)
    {
      spd.x = 0;
      pos.x = boxLeft + radius;
    }
  }


  //whatBall... DIES, this is what determines if physics *Happens*
  boolean whatBall(Ball other)
  { // Get distances between the balls components
    PVector distanceVect = PVector.sub(other.pos, pos);
    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = radius + other.radius + 1;


    //If within touching distance then the ball will be affected by the following
    if (distanceVectMag < minDistance)
    {
      if (type == 7) {
        //this makes it so it skips :P and prevents them from merging and crashing the game
      } else if (type == other.type)
      {
        //adds to score before changing
        if (currentScreen == Screen.PLAY)
          score += type;

        //resets bounces
        bounces = 2;
        type+=1;
        
        //adds to score after changing
        if (currentScreen == Screen.PLAY)
          score += value;

        spd.set(0, 0);
        pos.x = (pos.x  + other.pos.x)/2;
        pos.y = (pos.y  + other.pos.y)/2;
        spd.set(0, 0);
        return true;
      }

      //Ask someone else about this
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);

      //makes them not bounce too much
      other.spd.add(correctionVector);
      spd.sub(correctionVector);
      //stablelizes
      other.pos.add(correctionVector);
      pos.sub(correctionVector);

      //self explained
      int maxBounces = 2;
      int elasticity = 14;

      // This is what determines how the balls jump off one another.
      if (other.pos.y > pos.y && bounces < maxBounces)
      {
        spd.y *= -1;

        if (pos.x < other.pos.x)
        {
          spd.x = (((other.pos.x - pos.x)*spd.y)/elasticity)/(type+1);
          other.spd.x = (-1*((other.pos.x - pos.x)/elasticity))/(other.type+1);
        } else
        {
          spd.x = (((-1*(pos.x - other.pos.x))*spd.y)/elasticity)/(type+1);
          other.spd.x = ((pos.x - other.pos.x)/elasticity)/(other.type+1);
        }

        bounces+=1;
      } else if (other.pos.y < pos.y && other.bounces < maxBounces)
      {
        other.spd.y *= -1;

        if (pos.x < other.pos.x)
        {
          other.spd.x = (((other.pos.x - pos.x)*spd.y)/elasticity)/(other.type+1);
          spd.x = (-1*((other.pos.x - pos.x)/elasticity))/(type+1);
        } else
        {
          other.spd.x = (((-1*(pos.x - other.pos.x))*spd.y)/elasticity)/(other.type+1);
          spd.x = ((pos.x - other.pos.x)/elasticity)/(type+1);
        }

        other.bounces+=1;
      }
      return false;
    }
    return false;
  }
}

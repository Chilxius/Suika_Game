ArrayList<Ball> playBalls = new ArrayList<Ball>();
ArrayList<Ball> menuBalls = new ArrayList<Ball>();
ArrayList<Button> buttons = new ArrayList<Button>();
//Button Atributes
PImage[] btnImgs = new PImage[6];

//what defines balls attributes
PImage[] ballImgs = new PImage[8];
int[] ballSizes = new int[9];
int[] ballValue = new int[9];

//CONTAINER
int containerWidth;
int[] currentNextBall = new int[2];
//DROPPER
int dropperTimer;
int dropperX;

//Menu auto-drop
int menuTimer;

//for Pausing
boolean looping;
//for reseting
boolean resetPlayBalls;
//for Losing
boolean canLose;

//for reading files
BufferedReader reader;
String line;

//for writing files
PrintWriter output;

//score
int highscore;
int score;


//SCREEN STATES
Screen currentScreen;

//my Buttons
Button b1, b2, b3;


void setup()
{
  size(800, 600);

  //for reading files
  reader = createReader("positions.txt");

  //for writing files
  if (!fileExsist())
    output = createWriter("positions.txt");

  //menu timer
  menuTimer = 0;

  //current Screen tracker
  currentScreen = Screen.MENU;

  //container
  containerWidth = 4;

  ///Ball Buffer
  currentNextBall[0] = int(random(5));
  currentNextBall[1] = int(random(5));

  //buttons
  b1 = new Button();
  b2 = new Button();
  b3 = new Button();

  //stop looping
  looping = true;

  //stop resetting
  resetPlayBalls = false;

  //stopLosing
  canLose = true;

  //button Images
  btnImgs[0] = loadImage("titleCard.png");
  btnImgs[1] = loadImage("Play.png");
  btnImgs[2] = loadImage("Menu.png");
  btnImgs[3] = loadImage("Paused.png");
  btnImgs[4] = loadImage("Save.png");
  btnImgs[5] = loadImage("Load.png");

  //Ball Images
  ballImgs[0] = loadImage("Pookie.png");
  ballImgs[1] = loadImage("Nermal.png");
  ballImgs[2] = loadImage("Odie.png");
  ballImgs[3] = loadImage("Marleen.png");
  ballImgs[4] = loadImage("Girlfriend.png");
  ballImgs[5] = loadImage("Mom.png");
  ballImgs[6] = loadImage("John.png");
  ballImgs[7] = loadImage("Garfield.png");

  //ball Sizes
  ballSizes[0] = 15;
  ballSizes[1] = 18;
  ballSizes[2] = 21;
  ballSizes[3] = 30;
  ballSizes[4] = 40;
  ballSizes[5] = 60;
  ballSizes[6] = 80;
  ballSizes[7] = 100;
  ballSizes[8] = 120;

  //ballValues
  ballValue[0] = 1;
  ballValue[1] = 3;
  ballValue[2] = 6;
  ballValue[3] = 10;
  ballValue[4] = 15;
  ballValue[5] = 21;
  ballValue[6] = 28;
  ballValue[7] = 36;
  ballValue[8] = 45;

  //Resize Balls
  for (int i = 0; i < ballImgs.length; i++)
  {
    ballImgs[i].resize(ballSizes[i]*2, ballSizes[i]*2);
  }
  
  //Resize Button Images
  for (int i = 0; i < btnImgs.length; i++)
  {
    if ( i == 0)
      btnImgs[i].resize(255, 0);
    else
    btnImgs[i].resize(125, 0);
  }

  imageMode(CENTER);
}

void draw()
{
  
  //Pause and Play Looping
  if (!looping)
    noLoop();
  else
    loop();

  //Completely reset balls
  if (resetPlayBalls) {
    while (playBalls.size() > 0)
      for (int i = 0; i < playBalls.size(); i++)
        playBalls.remove(i);
    resetPlayBalls = false;
  }


  //The different screens
  if (currentScreen == Screen.MENU)
    mainMenu();

  if (currentScreen == Screen.PLAY)
    playGame();

  if (currentScreen == Screen.PAUSE)
    pauseGame();

  if (currentScreen == Screen.LOST)
    lostGame();

  if (currentScreen == Screen.SAVE) {
    saveGame();
  }

  if (currentScreen == Screen.LOAD) {
    loadGame();
    currentScreen = Screen.PLAY;
  }
}

//mouse pressed and stuff
void mousePressed() {
  //Create Ball Handler
  if (currentScreen == Screen.PLAY)
    if (dropperTimer < millis())
      if (mouseX > 200 && mouseX < 600)
        spawnBall(Screen.PLAY);

  //check were the buttons are and if the mouse is above button
  checkButtons();

  //get X and Y
  println(mouseX + ", " + mouseY);
}

//checks if the mouse is over the buttons and changes the screen
void checkButtons()
{
  b1.underMouse();
  b2.underMouse();
  b3.underMouse();
}

//actually randomly spawns the balls for the menu and game
void spawnBall(Screen whatKind)
{
  currentNextBall[0] = currentNextBall[1];
  currentNextBall[1] = int(random(5));

  if (whatKind == Screen.PLAY)
    playBalls.add( new Ball(dropperX, 25, currentNextBall[0]) );
  else
    menuBalls.add( new Ball(random(width), 25, int(random(5))) );

  dropperTimer = millis() + 500;
}

//spawns ball with specific attributes
void spawnBall(float x, float y, int type)
{
  playBalls.add( new Ball(x, y, type) );
}


//this is so i can keep track of all the screens
public enum Screen {
  MENU, PLAY, PAUSE, LOST, SAVE, LOAD, NONE
}

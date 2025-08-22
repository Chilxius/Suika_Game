void loadGame() {
  //makes each line its own string
  String[] lines = loadStrings("positions.txt");

  //loads scores
  highscore = int(lines[0]);
  score = int(lines[1]);

  //loads balls
  for (int ball = 1; ball < int(lines[2])+1; ball++) {
    int getLine = 4*ball;

    spawnBall(float(lines[getLine]), float(lines[getLine+1]), int(lines[getLine+2]));
  }
}

//check if files exsists
boolean fileExsist() {
  try {
    line = reader.readLine();
  }
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    // Stop reading because of an error or file is empty
    return false;
  } else {
    return true;
  }
}

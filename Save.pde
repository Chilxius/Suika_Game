//i was up at 2:30 AM      :/

void saveGame() {
  //over-writes / creates file to output to
  output = createWriter("positions.txt");

  //saves score and amount of balls on screen
  output.println(highscore);
  output.println(score);
  output.println(playBalls.size());

  //saves ball attributes
  for (int ballNum = 0; ballNum < playBalls.size(); ballNum++) {
    output.println();

    output.println(playBalls.get(ballNum).pos.x);
    output.println(playBalls.get(ballNum).pos.y);
    output.println(playBalls.get(ballNum).type);
  }

  output.flush(); // Writes the remaining data to the file
  output.close(); 
}

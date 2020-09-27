/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */

import java.util.Random;

Game game = new Game(30, 20, 5, 5);
PFont font;
int screen = 0;

public void settings() {
  size(1201, 801);
}

void setup()
{
  frameRate(10);
  font = createFont("Arial", 16, true);
  textFont(font, 16);
}
// Søren tisser på Kristian.
// Næ jeg gør ikke 
void keyReleased()
{
  game.onKeyReleased(key);
}

void keyPressed()
{
  game.onKeyPressed(key);
}

void draw()
{
  if (screen == 0)
  {
    background(255);
    textAlign(CENTER);
    textSize(100);
    fill(0);
    text("Name of the game", width/2, height/2-50);
    textSize(50);
    text("Press any key to start", width/2, height/2+50);
    //game.reset();
    if (keyPressed) {
      game.reset();
      screen = 1;
    }
  }

  if (screen == 2) 
  {
    //Player wins
    background(0);
    textAlign(CENTER);
    textSize(100);
    fill(0, 0, 255);
    text("BLUE WINS!", width/2, height/2);
    fill(255);
    textSize(40);
    
    text("Press any key to start again", width/2, height/2+100);
    if (keyPressed) {
      game.reset();
      screen = 1;
    }
  }

  if (screen == 3) 
  {
    //Player2 wins
    background(0);
    textAlign(CENTER);
    textSize(100);
    fill(255, 255, 0);
    text("YELLOW WINS!", width/2, height/2);
    fill(255);
    textSize(40);
    game.reset();
    text("Press any key to start again", width/2, height/2+100);
    if (keyPressed) {
      screen = 1;
    }
  }

  if (screen == 1)
  {
    game.update();
    background(0); //Black
    // This embedded loop skips over values in the arrays based on
    // the spacer variable, so there are more values in the array
    // than are drawn here. Change the value of the spacer variable
    // to change the density of the points
    int[][] board = game.getBoard();
    for (int y = 0; y < game.getHeight(); y++)
    {
      for (int x = 0; x < game.getWidth(); x++)
      {
        if (board[x][y] == 0)
        {
          fill(0, 0, 0);
        } else if (board[x][y] == 1)
        {
          fill(0, 0, 255);
        } else if (board[x][y] == 2)
        {
          fill(255, 0, 0);
        } else if (board[x][y] == 3)
        {
          fill(0, 255, 0);
        } else if (board[x][y] == 4)
        {
          fill(255, 255, 0);
        }

        stroke(100, 100, 100);
        rect(x*40, y*40, 40, 40);
      }
    }
    fill(255);
    textSize(16);
    textAlign(LEFT);
    text("Lifes: "+game.getPlayerLife(), 25, 25);
    text("Lifes: "+game.getPlayer2Life(), width-100, 25);
    text("Points: "+game.getPlayerPoints(), 25, 50);
    text("Points: "+game.getPlayer2Points(), width-100, 50);
    println(game.getPlayer2Life());
    if (game.getPlayerPoints() >= 100 || game.getPlayer2Life() <= 0) {
      screen = 2;
    } else if (game.getPlayer2Points() >= 100 || game.getPlayerLife() <= 0) {
      screen = 3;
    } else {
      screen = 1;
    }
  }
<<<<<<< Updated upstream
  fill(255);
  text("Lifes: "+game.getPlayerLife(), 25,25);
=======
  println(screen);
>>>>>>> Stashed changes
}

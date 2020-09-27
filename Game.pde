import java.util.Random;

class Game
{
  private Random rnd;
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private int player2Life;
  private int playerPoints;
  private int player2Points;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] greenies;


  Game(int width, int height, int numberOfEnemies, int numberOfGreenies)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
<<<<<<< Updated upstream
    player = new Dot(0,0,width-1, height-1);
    player2 = new Dot(width,0,width-1, height-1);
=======
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(width-1, 0, width-1, height-1);

>>>>>>> Stashed changes
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width/2-1, height-1, width/2-1, height-1);
    }

    greenies = new Dot[numberOfGreenies];
    for (int i = 0; i < numberOfGreenies; ++i)
    {
      greenies[i] = new Dot(width/2, height/2, width/2, height/2);
    }

    this.playerLife = 100;
    this.player2Life = 100;
    this.playerPoints = 0;
    this.player2Points = 0;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }
  public int getPlayer2Life()
  {
    return player2Life;
  }
  
  public int getPlayerPoints()
  {
    return playerPoints;
  }
  public int getPlayer2Points()
  {
    return player2Points;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
    keys.onKeyPressed();
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
    keys.onKeyReleased();
  }

  public void update()
  {
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    updateGreenies();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }

  public void reset() 
  {
    playerLife = 100;
    player2Life = 100;
    playerPoints = 0;
    player2Points = 0; 
    for (int i = 0; i < 5; ++i)
    {
      greenies[i] = new Dot(width/2, height/2, width/2, height/2);
    }
     for (int i = 0; i < 5; ++i)
    {
      enemies[i] = new Dot(width/2, height-1, width/2, height/2);
    }
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(width-1, 0, width-1, height-1);
  }

  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }

  private void updatePlayer2()
  {
    //Update player2
    if (keys.arrowsUDown() && !keys.arrowsDDown())
    {
      player2.moveUp();
    }
    if (keys.arrowsLDown() && !keys.arrowsRDown())
    {
      player2.moveLeft();
    }
    if (keys.arrowsDDown() && !keys.arrowsUDown())
    {
      player2.moveDown();
    }
    if (keys.arrowsRDown() && !keys.arrowsLDown())
    {
      player2.moveRight();
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int dx2 = player2.getX() - enemies[i].getX();
        int dy2 = player2.getY() - enemies[i].getY();
        if (Math.min(abs(dx), abs(dy)) < Math.min(abs(dx2), abs(dy2)))
        {
        //  //chase player
          if (abs(dx) > abs(dy))
          {
            if (dx > 0)
            {
              //Player is to the right
              enemies[i].moveRight();
            } else
            {
              //Player is to the left
              enemies[i].moveLeft();
            }
          } else if (dy > 0)
          {
            //Player is down;
            enemies[i].moveDown();
          } else
          {//Player is up;
            enemies[i].moveUp();
          }
        }

        //Chase player2
        if (Math.min(abs(dx), abs(dy)) > Math.min(abs(dx2), abs(dy2)))
        {
          if (abs(dx2) > abs(dy2))
          {
            if (dx2 > 0)
            {
              //Player is to the right
              enemies[i].moveRight();
            } else
            {
              //Player is to the left
              enemies[i].moveLeft();
            }
          } else if (dy2 > 0)
          {
            //Player is down;
            enemies[i].moveDown();
          } else
          {//Player is up;
            enemies[i].moveUp();
          }
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void updateGreenies()
  {
    for (int i = 0; i < greenies.length; ++i)
    {
      //Should we flee or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We flee
        int dx = player.getX() - greenies[i].getX();
        int dy = player.getY() - greenies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            greenies[i].moveLeft();
          } else
          {
            //Player is to the left
            greenies[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is down;
          greenies[i].moveUp();
        } else
        {
          //Player is up;
          greenies[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          greenies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          greenies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          greenies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          greenies[i].moveDown();
        }
      }
    }

    //update for player2
    for (int i = 0; i < greenies.length; ++i)
    {
      //Should we flee or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We flee
        int dx = player2.getX() - greenies[i].getX();
        int dy = player2.getY() - greenies[i].getY();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            greenies[i].moveLeft();
          } else
          {
            //Player is to the left
            greenies[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is down;
          greenies[i].moveUp();
        } else
        {
          //Player is up;
          greenies[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          greenies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          greenies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          greenies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          greenies[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert greenies
    for (int i = 0; i < greenies.length; ++i)
    {
      board[greenies[i].getX()][greenies[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      }
      if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a collision
        --player2Life;
      }
    }
    //Check greeny collisions
    for (int i = 0; i < greenies.length; ++i)
    {
      if (greenies[i].getX() == player.getX() && greenies[i].getY() == player.getY())
      {
        //We have a collision
        playerPoints = playerPoints + 10;
      }
      if (greenies[i].getX() == player2.getX() && greenies[i].getY() == player2.getY())
      {
        //We have a collision
        player2Points = player2Points + 10;
      }
    }
  }
}

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
  private Dot[] reverse;
  private Dot[] stealths;
  private int gamespeed = 0;
  


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



    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(width-1, 0, width-1, height-1);


    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }

    greenies = new Dot[numberOfGreenies];
    for (int i = 0; i < numberOfGreenies; ++i)
    {
      greenies[i] = new Dot(width-1, height-1, width-1, height-1);
    }

    
    reverse = new Dot[1];

    reverse[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    
    stealths = new Dot[1];

    stealths[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);


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
        if (frameCount%100 == 0) {
      frames = frames+gamespeed;
      frameRate(frames);
    } 
  }

  public void reset() 
  {
    //game.update();
    playerLife = 100;
    player2Life = 100;
    playerPoints = 0;
    player2Points = 0;
    keys.playerReverse=false;
    keys.player2Reverse=false;
    for (int i = 0; i < greenies.length; ++i)
    {
      greenies[i] = new Dot((width-1)/2, (height-1)/2, width-1, height-1);
    }
    for (int i = 0; i < enemies.length; ++i)
    {
      enemies[i] = new Dot((width-1)/2, height-1, width-1, height-1);
    }
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(width-1, 0, width-1, height-1);
    reverse[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    stealths[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    frames = 10;
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
    if(player.getStealth())
    {
      player.stealthTimer();
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
    if(player2.getStealth())
    {
      player2.stealthTimer();
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
  
      //We follow
      int dx1 = player.getX() - enemies[i].getX();
      int dy1 = player.getY() - enemies[i].getY();
      int dx2 = player2.getX() - enemies[i].getX();
      int dy2 = player2.getY() - enemies[i].getY();
      int dist1=(int)Math.sqrt(Math.pow(abs(dx1),2)+Math.pow(abs(dy1),2));
      int dist2=(int)Math.sqrt(Math.pow(abs(dx2),2)+Math.pow(abs(dy2),2));
      int dx;
      int dy;
      
      // it stopped allowing dx and dy to be initialised empty after I added stealth.
      
      //technically I think you can run into some bad roundings where player2 would be targeted unfairly
      //if the rounded distances are the same, then they target player2.

      if(player.getStealth())
      {
        dx=dx2;
        dy=dy2;
      }
      else if(player2.getStealth())
      {
        dx=dx1;
        dy=dy1;
      }
      else if (dist1<dist2)
      {
        dx=dx1;
        dy=dy1;
      } else
      {
        dx=dx2;
        dy=dy2;
      }
      if(!(player.getStealth()&&player2.getStealth()))
      {
        if (rnd.nextInt(3) < 2)
        {
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
        else
        {
          moveRandom(enemies[i]);
        }
      }
      else
      {
        moveRandom(enemies[i]);
      }
    }
  }

  private void updateGreenies()
  {
    for (int i = 0; i < greenies.length; ++i)
    {
      int dx1 = player.getX() - greenies[i].getX();
      int dy1 = player.getY() - greenies[i].getY();
      int dx2 = player2.getX() - greenies[i].getX();
      int dy2 = player2.getY() - greenies[i].getY();
      int dist1=(int)Math.sqrt(Math.pow(abs(dx1),2)+Math.pow(abs(dy1),2));
      int dist2=(int)Math.sqrt(Math.pow(abs(dx2),2)+Math.pow(abs(dy2),2));
      int dx;
      int dy;
      int dist;
      

      if(player.getStealth())
      {
        dx=dx2;
        dy=dy2;
        dist=dist2;
      }
      else if(player2.getStealth())
      {
        dx=dx1;
        dy=dy1;
        dist=dist1;
      }
      else if (dist1<dist2)
      {
        dx=dx1;
        dy=dy1;
        dist=dist1;
      } else
      {
        dx=dx2;
        dy=dy2;
        dist=dist2;
      }
    
      // if within distance, they'll flee with random movement thrown in, like the enemies.
      if(dist<=5&!(player.getStealth()&&player2.getStealth()))
      {
        //Should we flee or move randomly?
        //2 out of 3 we will follow..
        if (rnd.nextInt(3) < 2)
        {
          //We flee
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
          moveRandom(greenies[i]);
        }
      }
      // if outside distance, they'll stand around with random movement thrown in. numbers can be changed to taste.
      else if(rnd.nextInt(10)<1)
      {
        moveRandom(greenies[i]);
      }
    }
  }
  
  private void moveRandom(Dot object)
  {
   //We move randomly
    int move = rnd.nextInt(4);
    if (move == 0)
    {
      //Move right
      object.moveRight();
    } else if (move == 1)
    {
      //Move left
      object.moveLeft();
    } else if (move == 2)
    {
      //Move up
      object.moveUp();
    } else if (move == 3)
    {
      //Move down
      object.moveDown();
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
    
    board[stealths[0].getX()][stealths[0].getY()]=5;
    board[reverse[0].getX()][reverse[0].getY()] = 6;
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
        greenies[i] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
      }
      if (greenies[i].getX() == player2.getX() && greenies[i].getY() == player2.getY())
      {
        //We have a collision
        player2Points = player2Points + 10;
        greenies[i] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
      }
      if (game.getPlayerPoints() >= 1000 || game.getPlayer2Life() <= 0) {
        screen = 2;
      } else if (game.getPlayer2Points() >= 1000 || game.getPlayerLife() <= 0) {
        screen = 3;
      } else {
        screen = 1;
      }
    }
    
    //Check Stealth collision.
    if(stealths[0].getX()==player.getX()&&stealths[0].getY()==player.getY())
    {
      player.stealth();
      stealths[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    }
    if(stealths[0].getX()==player2.getX()&&stealths[0].getY()==player2.getY())
    {
      player2.stealth();
      stealths[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    }
  
    
    //Check reverse collision
    if (reverse[0].getX() == player.getX() && reverse[0].getY() == player.getY() && keys.playerReverse == false) 
    {
      keys.player2Reverse = true;
      keys.playerReverse = false;
      keys.allKeysUp2();
      reverse[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    }
    if(reverse[0].getX() == player2.getX() && reverse[0].getY() == player2.getY() && keys.player2Reverse == false) {
      keys.player2Reverse = false;
      keys.playerReverse = true;
      keys.allKeysUp1();
      reverse[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    }
  if (reverse[0].getX() == player.getX() && reverse[0].getY() == player.getY() && keys.playerReverse == true) 
    {
      keys.player2Reverse = false;
      keys.playerReverse = false;
      keys.allKeysUp1();
      reverse[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    }
    if (reverse[0].getX() == player2.getX() && reverse[0].getY() == player2.getY() && keys.player2Reverse == true) 
    {
      keys.player2Reverse = false;
      keys.playerReverse = false;
      keys.allKeysUp2();
      reverse[0] = new Dot(int(random(0, width-1)), int(random(0, height-1)), width-1, height-1);
    }
  }
}

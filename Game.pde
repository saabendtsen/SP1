import java.util.Random;

class Game
{
  private Random rnd;
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  
   
  Game(int width, int height, int numberOfEnemies)
  {
    if(width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if(numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0,0,width-1, height-1);
    player2 = new Dot(width-1,0,width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    for(int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
  }
  
  public int getWidth()
  {
    return width;
  }
  
  public int getHeight()
  {
    return height;
    
    //Sut diller
  }
  
  public int getPlayerLife()
  {
    return playerLife;
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
    checkForCollisions();
    clearBoard();
    populateBoard();
  }
  
  
  
  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }
  
  private void clearBoard()
  {
    for(int y = 0; y < height; ++y)
    {
      for(int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }
  
  private void updatePlayer()
  {
    //Update player
    if(keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if(keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if(keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if(keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }  
  }
  
  private void updatePlayer2()
  {
    //Update player2
    if(keys.arrowsUDown() && !keys.arrowsDDown())
    {
      player2.moveUp();
    }
    if(keys.arrowsLDown() && !keys.arrowsRDown())
    {
      player2.moveLeft();
    }
    if(keys.arrowsDDown() && !keys.arrowsUDown())
    {
      player2.moveDown();
    }
    if(keys.arrowsRDown() && !keys.arrowsLDown())
    {
      player2.moveRight();
    }  
  }
  
  private void updateEnemies()
  {
    for(int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if(rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        if(abs(dx) > abs(dy))
        {
          if(dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          }
          else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        }
        else if(dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        }
        else
        {//Player is up;
          enemies[i].moveUp();
        }
      }
      else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if(move == 0)
        {
          //Move right
          enemies[i].moveRight();
        }
        else if(move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        }
        else if(move == 2)
        {
          //Move up
          enemies[i].moveUp();
        }
        else if(move == 3)
        {
          //Move down
          enemies[i].moveDown();
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
    for(int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
  }
   
  private void checkForCollisions()
  {
    //Check enemy collisions
    for(int i = 0; i < enemies.length; ++i)
    {
      if(enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      }
    }
  }
}

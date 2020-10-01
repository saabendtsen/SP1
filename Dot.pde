class Dot
{
  private int x;
  private int y;
  private final int maxX;
  private final int maxY;
  private boolean stealth=false;
  private boolean transparent=false;
  private float timer;
  private int timerStep=0;
  private int timerCycle=0;

  public Dot(int x, int y, int maxX, int maxY)
  {
    this.x = x;
    this.y = y;
    this.maxX = maxX;
    this.maxY = maxY;
  }

  public int getX()
  {
    return x;
  }

  public int getY()
  {
    return y;
  }

  public boolean getStealth()
  {
    return stealth;
  }
  
  public boolean getTransparent()
  {
    return transparent;
  }

  public void stealth()
  {
    timer=frameCount+10*0.5;
    timerStep=1;
    this.stealth=true;
    this.transparent=true;
  }

  public void stealthTimer()
  {
    if(timerStep==1)
    {
      if(frameCount>timer)
      {
        timer=frameCount+10*0.25;
        this.transparent=!this.transparent;
        timerCycle++;
        if(timerCycle==4)
        {
          timer=frameCount+10*0.25;
          timerCycle=0;
          timerStep=2;
        }
      }
    }
    if(timerStep==2)
    {
      if(frameCount>timer)
      {
        timer=frameCount+10*0.125;
        this.transparent=!this.transparent;
        timerCycle++;
        if(timerCycle==8)
        {
          timer=frameCount+10*0.125;
          timerCycle=0;
          timerStep=3;
        }
      }
    }
    if(timerStep==3)
    {
      if(frameCount>timer)
      {
        this.transparent=false;
        this.stealth=false;
      }
    }
  }

  public void moveLeft()
  {
    --x;
    if (x < 0)
    {
      x = 0;
    }
  }

  public void moveRight()
  {
    ++x;
    if (x > maxX)
    {
      x = maxX;
    }
  }

  public void moveUp()
  {
    --y;
    if (y < 0)
    {
      y = 0;
    }
  }

  public void moveDown()
  {
    ++y;
    if (y > maxY)
    {
      y = maxY;
    }
  }
}

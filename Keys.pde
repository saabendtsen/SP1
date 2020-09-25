class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  private boolean arrowsUDown = false;
  private boolean arrowsRDown = false;
  private boolean arrowsLDown = false;
  private boolean arrowsDDown = false;
  
  public Keys(){}
  
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
   public boolean arrowsUDown()
  {
    return arrowsUDown;
  }
  
  public boolean arrowsLDown()
  {
    return arrowsLDown;
  }
  
  public boolean arrowsRDown()
  {
    return arrowsRDown;
  }
  
  public boolean arrowsDDown()
  {
    return arrowsDDown;
  }
  
  
  void onKeyPressed(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = true;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = true;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = true;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = true;
    }
    
  }
  
  void onKeyReleased(char ch)
  {
    if(ch == 'W' || ch == 'w')
    {
      wDown = false;
    }
    else if (ch == 'A' || ch == 'a')
    {
      aDown = false;
    }
    else if(ch == 'S' || ch == 's')
    {
      sDown = false;
    }
    else if(ch == 'D' || ch == 'd')
    {
      dDown = false;
    }
  }



 void onKeyPressed()
  {
    if(keyCode == UP)
    {
      arrowsUDown = true;
    }
    if(keyCode == DOWN)
    {
      arrowsDDown = true;
    }
    if(keyCode == LEFT)
    {
      arrowsLDown = true;
    }
    if(keyCode == RIGHT)
    {
      arrowsRDown = true;
    }
  }
  
  void onKeyReleased()
  {
    if(keyCode == UP)
    {
      arrowsUDown = false;
    }
    if(keyCode == DOWN)
    {
      arrowsDDown = false;
    }
    if(keyCode == LEFT)
    {
      arrowsLDown = false;
    }
    if(keyCode == RIGHT)
    {
      arrowsRDown = false;
    }
  }
}

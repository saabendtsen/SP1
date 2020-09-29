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
  public boolean playerReverse = false;
  public boolean player2Reverse = false;
  
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
    if(playerReverse == false){
    
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
     if(playerReverse == true){
    
    if(ch == 'W' || ch == 'w')
    {
      sDown = true;
    }
    else if (ch == 'A' || ch == 'a')
    {
      dDown = true;
    }
    else if(ch == 'S' || ch == 's')
    {
      wDown = true;
    }
    else if(ch == 'D' || ch == 'd')
    {
      aDown = true;
    }
    }
    
  }
  
  void onKeyReleased(char ch)
  {
   if(playerReverse == false){
    
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
     if(playerReverse == true){
    
    if(ch == 'W' || ch == 'w')
    {
      sDown = false;
    }
    else if (ch == 'A' || ch == 'a')
    {
      dDown = false;
    }
    else if(ch == 'S' || ch == 's')
    {
      wDown = false;
    }
    else if(ch == 'D' || ch == 'd')
    {
      aDown = false;
    }
    }
  }



 void onKeyPressed()
  {
    if(player2Reverse == false) {
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
    
    else {
     if(keyCode == UP) {
      arrowsDDown = true;
    }
    if(keyCode == DOWN)
    {
      arrowsUDown = true;
    }
    if(keyCode == LEFT)
    {
      arrowsRDown = true;
    }
    if(keyCode == RIGHT)
    {
      arrowsLDown = true;
    }
    }
  }
  
  void onKeyReleased()
  {
        if(player2Reverse == false) {
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
    
    else {
     if(keyCode == UP) {
      arrowsDDown = false;
    }
    if(keyCode == DOWN)
    {
      arrowsUDown = false;
    }
    if(keyCode == LEFT)
    {
      arrowsRDown = false;
    }
    if(keyCode == RIGHT)
    {
      arrowsLDown = false;
    }
    }
  }
}

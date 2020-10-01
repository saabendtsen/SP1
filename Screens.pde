class Screens {
  
 Screens() {
   
 
   
   
   
   
 }


void screenChange()
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
    fill(96,96,255);
    text("BOY WINS!", width/2,height/2);
    fill(255);
    textSize(40);

    text("Press SPACEBAR to start again", width/2, height/2+100);
    if (key == ' ') {
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
    fill(255, 96, 255);
    text("GIRL WINS!",width/2,height/2);
    fill(255);
    textSize(40);

    text("Press SPACEBAR to start again", width/2, height/2+100);
    if (key == ' ') {
      game.reset();
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
          fill(0, 0, 255,0);
          if(game.player.getTransparent())
          {
            tint(255,127);
          }
          else
          {
            tint(255);
          }
          image(img,(game.player.getX()*40),(game.player.getY()*40));
        } else if (board[x][y] == 2)
        {
          fill(255, 0, 0);
        } else if (board[x][y] == 3)
        {
          fill(0, 255, 0);
        } else if (board[x][y] == 4)
        {
          fill(255, 255, 0,0);
          if(game.player2.getTransparent())
          {
            tint(255,127);
          }
          else
          {
            tint(255);
          }
          image(img2,(game.player2.getX()*40),(game.player2.getY()*40));
        } else if (board[x][y] == 5)
        {
          fill(96, 0, 96);
        } else if (board[x][y] == 6)
        {
          fill(255, 255, 255);
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
    
    //images moved to the above section because I needed them to be drawn immediately after their tint is set by getStealth();
    //otherwise they would inconsistently have each other's tint. 
    //it also means that they're drawn underneath the rects
    //which I think is more fun. you can't see shit when you're being swarmed.
    //but we can fix that buy just drawing the rects right after the fills are set.
    //come to think of it, we don't need to have the tints up there since they are pulled directly from the objects, not from the array,
    //which is how the imgs were down here in the first place.
    
    //println(frames + " " + frameCount) ;
  } 
  
}
}

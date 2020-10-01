/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */

import java.util.Random;
import ddf.minim.*;

Minim minim;
AudioPlayer player;

Game game = new Game(30, 20, 5, 5);
PFont font;
int screen = 0;
public int frames = 10;
PImage img;
PImage img2;
Screens scr = new Screens();

public void settings() {
  size(1201, 801);
}

void setup()
{
  frameRate(frames);
  font = createFont("Arial", 16, true);
  textFont(font, 16);
  img = loadImage("sprite1_alpha_resize2.png");
  img.resize(40,40);
  img2 = loadImage("sprite2_alpha_resize2.png");
  img2.resize(40,40);
  
  minim=new Minim(this);
  player=minim.loadFile("music.mp3");
  player.setGain(-12);
  player.loop();
}

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
  scr.screenChange();
}

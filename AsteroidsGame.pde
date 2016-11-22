//your variable declarations here
SpaceShip bob = new SpaceShip();
Stars [] backgroundStars = new Stars[150];
ArrayList<Asteroids> asteroidsList = new ArrayList<Asteroids>();
ArrayList<SmallAsteroids> smallAsteroidsList = new ArrayList<SmallAsteroids>();
ArrayList<EvenSmallerAsteroids> evenSmallerAsteroidsList = new ArrayList<EvenSmallerAsteroids>();

int score = 0;
int numberOfAsteroids = 3;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

public void setup() 
{
  size(600, 600);
  background(0);
  for (int i = 0; i<backgroundStars.length; i++)
  {
    backgroundStars[i]=new Stars();
  }

  for (int i=0; i<numberOfAsteroids; i++)
  {
    asteroidsList.add(new Asteroids());
  }
}


public void draw() 
{
  //your code here

  fill(0,0,0,50);
  rect(0,0,width,height);
  background(0);
  for (int i = 0; i<backgroundStars.length; i++)
  {
    backgroundStars[i].show();
  }

  bob.move();
  bob.show();

  for(int i = 0; i < bullets.size(); i++)
  {
    bullets.get(i).move();
    bullets.get(i).show();
    if (bullets.get(i).getX() >= width || bullets.get(i).getX() <= 0 || bullets.get(i).getY() >= height || bullets.get(i).getY() <= 0)
    {
      bullets.remove(i);
    }
  }

  for (int i = 0; i<asteroidsList.size(); i++)
  {
    asteroidsList.get(i).turn(asteroidsList.get(i).getRotationSpeed());
    asteroidsList.get(i).move();
    asteroidsList.get(i).show();

    text("size:" + asteroidsList.size(),20,20);
  }

  for(SmallAsteroids smallAst : smallAsteroidsList)
  {
    smallAst.move();
    smallAst.show();
  }

  for(EvenSmallerAsteroids evenSmallAst : evenSmallerAsteroidsList)
  {
    evenSmallAst.move();
    evenSmallAst.show();
  }

  for (int i = 0; i<asteroidsList.size(); i++)
  {
    for (int j = 0; j<bullets.size(); j++)
    {
      float distance1 = dist(asteroidsList.get(i).getX(), asteroidsList.get(i).getY(), bullets.get(j).getX(), bullets.get(j).getY());
      if (distance1<20)
      {
        
        smallAsteroidsList.add(new SmallAsteroids(asteroidsList.get(i)));
        smallAsteroidsList.add(new SmallAsteroids(asteroidsList.get(i)));
        asteroidsList.remove(i);
        bullets.remove(j);
        break;
      }
    }
  }

  for (int i = 0; i<smallAsteroidsList.size(); i++)
  {
    for (int j = 0; j<bullets.size(); j++)
    {
      float distance2 = dist(smallAsteroidsList.get(i).getX(), smallAsteroidsList.get(i).getY(), bullets.get(j).getX(), bullets.get(j).getY());
      if (distance2<10)
      {
        
        evenSmallerAsteroidsList.add(new EvenSmallerAsteroids(smallAsteroidsList.get(i)));
        evenSmallerAsteroidsList.add(new EvenSmallerAsteroids(smallAsteroidsList.get(i)));
        evenSmallerAsteroidsList.remove(i);
        bullets.remove(j);
        break;
      }
    }
  }
    
}

public void keyPressed()
{         
  if (key==CODED)
  {
    if (keyCode == UP)
    {
      bob.accelerate(1);
    }
    if (keyCode == DOWN)
    {
      bob.accelerate(-1);
    }
    if (keyCode == LEFT)
    {
      bob.turn(-15);
    }
    if (keyCode == RIGHT)
    {
      bob.turn(15);
    }
  }
  
  if (key == 's')
  {
    bob.setDirectionX(0);
    bob.setDirectionY(0);
  }
}

public void keyTyped()
{
  if (key == 'r')
  {
    bob.setX((int)(Math.random()*width));
    bob.setY((int)(Math.random()*height));
    bob.setDirectionX(0);
    bob.setDirectionY(0);
  }

  if (key == ' ')
  {
    bullets.add(new Bullet(bob));
  }

}

class SpaceShip extends Floater  
{   
  SpaceShip()
  {
    corners = 10;
    int [] xS = {14,1,-10,-4,-6,-8,-8,-4,-10,1};
    int [] yS = {0,18,18,9,6,6,-6,-9,-18,-18};
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners = xS;
    yCorners = yS;
    myColor = 255;
    myCenterX = 300;
    myCenterY = 300;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }

    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int)myCenterX;} 
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x) { myDirectionX = x;}
    public double getDirectionX(){ return (double)myDirectionX;} 
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY(){return (double)myDirectionY;}
    public void setPointDirection(int degrees) { myPointDirection = degrees; }
    public double getPointDirection() { return (double)myPointDirection;}

    public int getDirectionItIsPointing(){
      double radiansDirection = Math.atan(myDirectionY/myDirectionX);
      double degreeDirection = radiansDirection * (180/Math.PI);
      return (int)degreeDirection;
    }
}

class Asteroids extends Floater
{
  protected int rotationSpeed;
  Asteroids()
  {
    corners = 4;
    int [] xS = {34,6, -24, -10,28};
    int [] yS = {0,36,-2,-16,-18};
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners = xS;
    yCorners = yS;
    myColor = 100;
    myCenterX = (Math.random()*width);
    myCenterY = (Math.random()*height);
    myDirectionX = Math.random()*5-2;
    myDirectionY = Math.random()*5-2;
    myPointDirection = 0;
    if (Math.random() < 0.5)
    {
      rotationSpeed = (int)(Math.random()*3)+1;
    }
    else{
       rotationSpeed = (int)(Math.random()*3)-3;
    }
  }
  public void setX(int x) { myCenterX = x;}
  public int getX() {return (int)myCenterX;} 
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX(){ return (double)myDirectionX;} 
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY(){return (double)myDirectionY;}
  public void setPointDirection(int degrees) { myPointDirection = degrees; }
  public double getPointDirection() { return (double)myPointDirection;}
  public int getRotationSpeed() {return rotationSpeed;}
}

class SmallAsteroids extends Asteroids
{
  SmallAsteroids(Asteroids dadAsteroid)
  {
    corners = 4;
    int [] xS = {17,3, -12, -5,14};
    int [] yS = {0,18,-1,-8,-9};
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners = xS;
    yCorners = yS;
    myColor = 100;
    myCenterX = dadAsteroid.getX();
    myCenterY = dadAsteroid.getY();
    myDirectionX = Math.random()*5-2;
    myDirectionY = Math.random()*5-2;
    myPointDirection = 0;
    if (Math.random() < 0.5)
    {
      rotationSpeed = (int)(Math.random()*3)+1;
    }
    else{
       rotationSpeed = (int)(Math.random()*3)-3;
    }
  }
}

class EvenSmallerAsteroids extends Asteroids
{
  EvenSmallerAsteroids(SmallAsteroids dadAsteroid)
  {
    corners = 4;
    int [] xS = {8,1, -6, -2,7};
    int [] yS = {0,9,-1,-4,-4};
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners = xS;
    yCorners = yS;
    myColor = 100;
    myCenterX = dadAsteroid.getX();
    myCenterY = dadAsteroid.getY();
    myDirectionX = Math.random()*5-2;
    myDirectionY = Math.random()*5-2;
    myPointDirection = 0;
    if (Math.random() < 0.5)
    {
      rotationSpeed = (int)(Math.random()*3)+1;
    }
    else{
       rotationSpeed = (int)(Math.random()*3)-3;
    }
  }
}

class Bullet extends Floater
{
  Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
  }

  public void setX(int x) { myCenterX = x;}
  public int getX() {return (int)myCenterX;} 
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x) { myDirectionX = x;}
  public double getDirectionX(){ return (double)myDirectionX;} 
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY(){return (double)myDirectionY;}
  public void setPointDirection(int degrees) { myPointDirection = degrees; }
  public double getPointDirection() { return (double)myPointDirection;}

  public void show()
  {
    fill(25,100,6);
    noStroke();
    ellipse((float)myCenterX, (float)myCenterY, 10, 10);
  }

  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;        
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the Spaceship class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void turn (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    } 
    
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    
    //translate the (x,y) center of the ship to the correct position
    translate((float)myCenterX, (float)myCenterY);

    //convert degrees to radians for rotate()     
    float dRadians = (float)(myPointDirection*(Math.PI/180));
    
    //rotate so that the polygon will be drawn in the correct direction
    rotate(dRadians);
    
    //draw the polygon
    beginShape();
    for (int nI = 0; nI < corners; nI++)
    {
      vertex(xCorners[nI], yCorners[nI]);
    }
    endShape(CLOSE);

    //"unrotate" and "untranslate" in reverse order
    rotate(-1*dRadians);
    translate(-1*(float)myCenterX, -1*(float)myCenterY);
  }  


} 

class Stars
{
  private int myX, myY, mySize, myOpacity;
  Stars ()
  {
    myX = (int)(Math.random()*width);
    myY = (int)(Math.random()*height);
    mySize = (int)(Math.random()*8+2);
    myOpacity = (int)(Math.random()*200);
  }
  public void show()
  {
    noStroke();
    fill(255,255,153, myOpacity);
    ellipse(myX, myY, mySize, mySize);
  }
} 


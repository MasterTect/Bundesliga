ArrayList<Goals> goals = new ArrayList<Goals>();
ArrayList<Integer> totalgoals = new ArrayList<Integer>();
ArrayList<Integer> totalHomeGoals = new ArrayList<Integer>();
ArrayList<Integer> totalAwayGoals = new ArrayList<Integer>();

int year = 2000;
int homeGoals;
int awayGoals;
int totalGoals;
float border;

float x1, x2, y1, y2;
float xrange, yrange;
int marginError = 5;
int biggest;

void setup()
{
  size(700, 500);
  fill(0);
  
  loadData();
  getBiggest();
  
  border = width*.1f;
  xrange = width - (border*2);
  yrange = height - (border*2);
}

void loadData()
{
  String[] lines = loadStrings("Bundesliga.csv");
  
  homeGoals = 0;
  awayGoals = 0;
  totalGoals = 0;
  
  for (int i = 2000; i <= 2008; i++)
  {
    homeGoals = 0;
    awayGoals = 0;
    
    for (String line:lines)
    {
      String[] elements = line.split(",");
      Goals dataElements = new Goals(Integer.parseInt(elements[3]), Integer.parseInt(elements[4]), Integer.parseInt(elements[6]) );
      //goals.add(dataElements);
      
      // If the year is equal to 'i', add the elements their respective arrays.
      if (Integer.parseInt(elements[6]) == i )
      {
        homeGoals += Integer.parseInt(elements[3]);
        awayGoals += Integer.parseInt(elements[4]);
         
        totalGoals = (homeGoals + awayGoals);
      }  
  
    } // end string loop
  
    totalgoals.add(totalGoals);
    totalHomeGoals.add(homeGoals);
    totalAwayGoals.add(awayGoals);
 } 

}// end loadData()

// Finds the biggest number in the array, totalgoals.
// It is used when calculating the range or scaleFactor.
void getBiggest()
{
  biggest = totalgoals.get(0);
  
  for(int i=0; i<totalgoals.size(); i++)
  {
    if(biggest<totalgoals.get(i))
    {
      biggest = totalgoals.get(i);
    }
    
  }
}

/*Draws both Horizontal and Vertical Axes,
  the ticks and the relevant data corresponding to the ticks.
  i.e. 'Goals scored' Vs 'Year'*/
  void drawAxis()
{
  stroke(255);
  line(border, border, border, height-border);
  line(border, height-border, width-border, height-border);
  
  float lineWidth = xrange/(totalgoals.size() );
  
// Draw ticks on horizontal axis with the year printed beneath.
  for (int i = 0; i < totalgoals.size(); i++)
  {
    lineWidth = xrange/(totalgoals.size() - 1);
    
    float x = border + (i * lineWidth);
    float y = height - border;
    float tick = border * 0.1f;
    
    fill(255);
    line(x, y, x, y + tick);
    textAlign(CENTER, CENTER);
    text(year + i, x, y + (border * 0.5f));
  }
  
  /*Draw ticks on vertical axis with the
    amount of goals scored printed adjacent.*/
  for (int i = 0; i < (totalgoals.size() + 1); i++)
  {
    lineWidth = yrange/totalgoals.size() ;
    
    float x = border;
    float y = border + (i * lineWidth);
    float tick = border * 0.1f;
    int m = (int)biggest / totalgoals.size();
    line(x, y, x - tick, y);
    text( biggest - (m*i), x - (border * 0.5f), y );
  }
}

/*Draws all trend lines according to the totalgoals, totalHomeGoals and totalAwayGoals arrays.
  'Total Goals' in light Blue.
  'Home Goals' in Green.
  'Away Goals in Red.
*/
void drawLineGraph()
{
  fill(255); 
  textAlign(CENTER, CENTER);   
  float textY = (border * 0.5f); 
  text("Goals Scored in Bundesliga: 2000 - 2008", width * 0.5f, textY);
  
  border = width * 0.1f;;
  
  for(int i=1; i< totalgoals.size(); i++)
  {
    stroke(0, 204, 255);
    x1 = map(i - 1, 0, totalgoals.size(), border, width);
    x2 = map(i, 0, totalgoals.size(), border, width);
    y1 = map(totalgoals.get(i - 1), 0, biggest, height - border, (height - border) - yrange);
    y2 = map(totalgoals.get(i), 0, biggest, height - border, (height - border) - yrange);
    line(x1, y1, x2, y2);
    
    if(mouseX > x1 - marginError && mouseX < x1 + marginError && mouseY > border && mouseY < height - border )
    {
      stroke(255, 255, 0);
      fill(255, 255, 0);
      ellipse(x1, y1, 10, 10);
      stroke(0, 204, 255);
      
      fill(255);
      textAlign(LEFT);
      text("Total Goals: " + (totalgoals.get(i-1)), x1 + 10, y1 - 5);
      
    }
    
  }
  
  // HOME GOALS
  for(int i=1; i< totalHomeGoals.size(); i++)
  {
    stroke(0, 255, 0);
    x1 = map(i - 1, 0, totalHomeGoals.size(), border, width);
    x2 = map(i, 0, totalHomeGoals.size(), border, width);
    y1 = map(totalHomeGoals.get(i - 1), 0, biggest, height - border, (height - border) - yrange);
    y2 = map(totalHomeGoals.get(i), 0, biggest, height - border, (height - border) - yrange);
    line(x1, y1, x2, y2);
    
    if(mouseX > x1-marginError && mouseX < x1+marginError && mouseY > border && mouseY < height - border)
    {
      stroke(255, 255, 0);
      fill(255, 255,0);
      ellipse(x1, y1, 10, 10); 
      
      fill(255);
      text("Home Goals: " + (totalHomeGoals.get(i-1)), x1 + 10, y1 - 5);
      
    }
    
  }
  
  // AWAY GOALS
  for(int i=1; i< totalAwayGoals.size(); i++)
  {
    stroke(255, 0, 0);
    x1 = map(i - 1, 0, totalAwayGoals.size(), border, width);
    x2 = map(i, 0, totalAwayGoals.size(), border, width);
    y1 = map(totalAwayGoals.get(i - 1), 0, biggest, height - border, (height - border) - yrange);
    y2 = map(totalAwayGoals.get(i), 0, biggest, height - border, (height - border) - yrange);
    line(x1, y1, x2, y2);
    
    if(mouseX > x1-marginError && mouseX < x1+marginError && mouseY > border && mouseY < height - border)
    {
      stroke(255, 255, 0);
      fill(255, 255, 0);
      ellipse(x1, y1, 10, 10); 
      
      fill(255);
      text("Away Goals: " + (totalAwayGoals.get(i-1)), x1 + 10, y1 - 5);
    }
   
  }
  
}

void draw()
{
  background(0);
  drawLineGraph();
  drawAxis();
  mouseline();
}

void mouseline()
{
  stroke(255, 255, 0);
  
  if(mouseX > border && mouseX < width-border)
  {
    if(mouseY > border && mouseY < height-border)
    {
      line(mouseX, border, mouseX, height-border);
    }
  }
  
}

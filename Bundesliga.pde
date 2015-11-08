void setup()
{
  size(500, 500);
  
  loadData();  
}

ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();

void loadData()
{
  String[] strings = loadStrings("Bundesliga.csv");
  
  for(String s:strings)
  {
    println(s);
    String[] line = s.split(",");
    
    ArrayList<String> lineData = new ArrayList<String>();
    
    // Start at 1, so we skip the first one 
    for (int i = 1 ; i < line.length ; i ++)
    {
      lineData.add(line[i]);              
    }
    data.add(lineData);
  }
}


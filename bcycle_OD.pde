float mapGeoLeft   = -97.774259;          
float mapGeoRight  =  -97.706961;          
float mapGeoTop    =  30.2876025;         
float mapGeoBottom =  30.2470675;          //bounds of map +10% to each side
                         
float mapScreenWidth,mapScreenHeight;  // Dimension of map in pixels.
int selectedID;
PImage map;

Table locations,trips;

roundButton [] loc_buttons;

float [] circleSizes;
float maxCircleSize = 70;

void setup()
{
  
  map = loadImage("map.png");
  
  
  selectedID = 2537;
  size(1000,600);
  smooth();
  mapScreenWidth  = width;
  mapScreenHeight = height;
  locations = loadTable("bcycle_locations.csv", "header");
  trips=loadTable("pairs.csv");
  loc_buttons = new roundButton[locations.getRowCount()];
  circleSizes = new float[locations.getRowCount()];
  
  fill(180,120,120);
  strokeWeight(0.5);
  
  PVector p = geoToPixel(new PVector(-97.74739,30.27595));  // Rio Grande & 12th
  //ellipse(p.x,p.y,5,5);
  
  for (int i = 1;i<locations.getRowCount();i++)
  {
    p = geoToPixel(new PVector(locations.getFloat(i,4),locations.getFloat(i,3))); 
    //ellipse(p.x,p.y,10,10);
    loc_buttons[i-1] = new roundButton(p.x,p.y,10);
    //text(locations.getString(i,1),p.x,p.y);
  }
}

void draw()
{
  map.resize(1000,600);
  background(200);
  image(map,0,0);
  fill(0);
  rect(0,0,1000,10);
  rect(0,0,10,1000);
  rect(990,0,10,1000);
  rect(0,590,1000,10);
  
  fill(180,120,120);
  strokeWeight(1);
  PVector w;
  for (int i = 1;i<locations.getRowCount();i++)
  {
    w = geoToPixel(new PVector(locations.getFloat(i,4),locations.getFloat(i,3)));
    fill(190,190,190,250);
    ellipse(w.x,w.y,5,5);
  }
  
  
  
  
  PVector m;
  for (int p = 0; p<trips.getRowCount();p++){
    if (selectedID == trips.getInt(p,0)){
      for (int z = 1; z<locations.getRowCount();z++){
        if (trips.getInt(p,1) == locations.getInt(z,0)){
          m = geoToPixel(new PVector(locations.getFloat(z,4),locations.getFloat(z,3))); 
          
          if (trips.getInt(p,0) == trips.getInt(p,1)){
            
            fill(255,235,46,200);
            
          }
          else{
            fill(180,120,120,200);
          }
          
          ellipse(m.x,m.y,maxCircleSize*trips.getFloat(p,2)/135 + 7 ,maxCircleSize*trips.getFloat(p,2)/135 + 7);
          
          if (trips.getInt(p,0) == trips.getInt(p,1)){
            fill(0);
            text(locations.getString(z,1),m.x,m.y);
          }
          
          
          
        }
      }
    }
  }
  
  
}

void mousePressed(){
  background(0);
  for (int i =1;i<locations.getRowCount();i++){
    if (loc_buttons[i-1].checkPress()){
      selectedID = locations.getInt(i,0);
      println(selectedID);
    }
  }
  
  
  
  
}

// Converts screen coordinates into geographical coordinates. 
// Useful for interpreting mouse position.
public PVector pixelToGeo(PVector screenLocation)
{
    return new PVector(mapGeoLeft + (mapGeoRight-mapGeoLeft)*(screenLocation.x)/mapScreenWidth,
                       mapGeoTop - (mapGeoTop-mapGeoBottom)*(screenLocation.y)/mapScreenHeight);
}

// Converts geographical coordinates into screen coordinates.
// Useful for drawing geographically referenced items on screen.
public PVector geoToPixel(PVector geoLocation)
{ 
  return new PVector(mapScreenWidth*(geoLocation.x-mapGeoLeft)/(mapGeoRight-mapGeoLeft),
                       mapScreenHeight - mapScreenHeight*(geoLocation.y-mapGeoBottom)/(mapGeoTop-mapGeoBottom));
}
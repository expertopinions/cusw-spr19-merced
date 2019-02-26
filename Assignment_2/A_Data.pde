JSONObject example;
JSONArray features;
JSONObject berriUQAM;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("data/map.png");
  background.resize(width, height);
  
  berriUQAM = loadJSONObject("data/berriuqam.geojson");
  features = berriUQAM.getJSONArray("features");
  
  println("There are " + features.size() + " features.");
}

String transitType(JSONObject properties) {
  String stmType = "";
  try {
    stmType = properties.getJSONArray("relations").getJSONObject(1)
                               .getJSONObject("reltags").getString("route");
  }
  catch (RuntimeException e) {
    stmType = "";
  }
  finally {
    if (stmType == null) stmType = "";
  }
  
  if (stmType.equals("subway")) {
    // the capitalization of the line names is inconsistent in the data in both english AND french.
    // and it's inconsistent in different ways in each language.
    // so i'm just setting it to all lowercase here so i don't have to worry about it.
    stmType = properties.getJSONObject("tags").getString("name:en").toLowerCase();
  }
    
  return stmType;
}

void parseData(){
  for (int i = 0; i < features.size(); i++) {
    // identify properties, geometry & type
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties = features.getJSONObject(i).getJSONObject("properties");
    
    // make POIs
    if (type.equals("Point")) {
      // longitude is first for some reason
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      
      POI poi = new POI(lat, lon);
      pois.add(poi);
    }
    
    if (type.equals("Polygon")) {
      ArrayList<PVector> coords = new ArrayList<PVector>();
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for (int j = 0; j < coordinates.size(); j++) {
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      Polygon poly = new Polygon(coords);
      polygons.add(poly);
    }
    
    if (type.equals("LineString")) {
      ArrayList<PVector> coords = new ArrayList<PVector>();
      String stmType = transitType(properties);
      JSONArray coordinates = geometry.getJSONArray("coordinates");
      for (int j = 0; j < coordinates.size(); j++) {
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);
        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      Way way = new Way(coords, stmType);
      ways.add(way);
    }
  }
}

JSONObject cookCounty;
JSONArray features;

void loadData() {
  cookCounty = loadJSONObject("data/partial_cook_truncated.json");
  features = cookCounty.getJSONArray("features");
  println(features.size() + " features loaded");
}

void parseData() {
  for (int i = 0; i < features.size(); i++) {
    JSONObject attributes = features.getJSONObject(i).getJSONObject("attributes");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    float score = attributes.getFloat("B08301e2") / attributes.getFloat("B08301e1");
    ArrayList<PVector> coords = new ArrayList<PVector>();
    JSONArray points = geometry.getJSONArray("rings").getJSONArray(0);
    for (int j = 0; j < points.size(); j++) {
      float lat = points.getJSONArray(j).getFloat(1);
      float lon = points.getJSONArray(j).getFloat(0);
      PVector coordinate = new PVector(lat, lon);
      coords.add(coordinate);
    }
    Polygon poly = new Polygon(coords, score);
    blockGroupPolygons.add(poly);
  }
}

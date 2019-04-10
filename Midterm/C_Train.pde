class Train {
  private ArrayList<PVector> points;
  private PVector upperLeft;
  private PVector lowerRight;
  
  /**
   * Constructs a Train object.
   * @param upperLeft the upper left corner of the train car; must have integral dimensions
   * @param lowerRight the lower right corner of the train car; must have integral dimensions
   * @param openings the openings where someone can enter; each entry must have a ∆x of 0
   *        or a ∆y of 0 (but not both), have integral dimensions, and be in ascending order
   */
  Train(PVector upperLeft, PVector lowerRight, ArrayList<ArrayList<PVector>> openings) {
    this.upperLeft = upperLeft;
    this.lowerRight = lowerRight;
    
    int x1 = (int) this.upperLeft.x;
    int x2 = (int) this.lowerRight.x;
    // (0, 0) is top left, x+ axis goes right, y+ axis goes down
    int y1 = (int) this.upperLeft.y;
    int y2 = (int) this.lowerRight.y;
    
    HashSet<PVector> allOpeningPoints = getAllOpeningPoints(openings);
    this.points = new ArrayList<PVector>();
    
    // top of the train
    getHorizPoints(x1, x2, y1, allOpeningPoints);
    // bottom of the train
    getHorizPoints(x1, x2, y2, allOpeningPoints);
    // left of the train
    getVertPoints(y1, y2, x1, allOpeningPoints);
    // right of the train
    getVertPoints(y1, y2, x2, allOpeningPoints);
  }
  
  /**
   * Mutates this.points to include all the non-opening points of a horizontal side
   */
  private void getHorizPoints(int minX, int maxX, int y,
                                                HashSet<PVector> openingPoints) {
    for (int i = minX; i <= maxX; i++) {
      PVector point = new PVector(i, y);
      if (! openingPoints.contains(point)) {
        this.points.add(point);
      }
    }
  }
  
  /**
   * Mutates this.points to include all the non-opening points of a horizontal side
   */
  private void getVertPoints(int minY, int maxY, int x,
                                                HashSet<PVector> openingPoints) {
    for (int j = minY; j <= maxY; j++) {
      PVector point = new PVector(x, j);
      if (! openingPoints.contains(point)) {
        this.points.add(point);
      }
    }
  }
  
  private HashSet<PVector> getAllOpeningPoints(ArrayList<ArrayList<PVector>> openings) {
    HashSet<PVector> allOpeningPoints = new HashSet<PVector>();
    
    for (ArrayList<PVector> opening : openings) {
      allOpeningPoints.addAll(getOpeningPoints(opening));
    }
    
    return allOpeningPoints;
  }
  
  private HashSet<PVector> getOpeningPoints(ArrayList<PVector> opening) {
    int x1 = (int) opening.get(0).x;
    int x2 = (int) opening.get(1).x;
    int y1 = (int) opening.get(0).y;
    int y2 = (int) opening.get(1).y;
    int deltaX = x2 - x1;
    int deltaY = y2 - y1;
    HashSet<PVector> openingPoints = new HashSet<PVector>();
    
    if (deltaX == 0) {
      for (int j = y1; j <= y2; j++) {
        openingPoints.add(new PVector(x1, j));
      }
    }
    else if (deltaY == 0) {
      for (int i = x1; i <= x2; i++) {
        openingPoints.add(new PVector(i, y1));
      }
    }
    
    return openingPoints;
  }
  
  ArrayList<PVector> getPoints() {
    return points;
  }
  
  boolean contains(PVector that) {
    return (that.x > upperLeft.x && that.x < lowerRight.x
         && that.y > upperLeft.y && that.y < lowerRight.y);
  }
  
  /**
   * Returns a random location inside the train. Used for spawning Person agents
   */
  PVector getRandomLocation(float radius) {
    float x1 = upperLeft.x + radius;
    float x2 = lowerRight.x - radius;
    float y1 = upperLeft.y + radius;
    float y2 = lowerRight.y - radius;
    
    return new PVector(random(x1, x2+1), random(y1, y2+1));
  }
  
  /**
   * Finds the nearest point on the train from some other point
   * This is super bad and slow
   */
  PVector nearestPointOnTrain(PVector point) {
    float smallestDistance = Float.POSITIVE_INFINITY;
    PVector closestPoint = points.get(0);
    PVector result;
    
    for (PVector p : points) {
      float distance = point.dist(p);
      if (distance < smallestDistance) {
        smallestDistance = distance;
        closestPoint = p;
      }
    }
    
    result = new PVector(closestPoint.x, closestPoint.y);
    return result;
  }
  
  void draw() {
    strokeWeight(2);
    stroke(255);
    for (PVector p : points) {
      point(p.x, p.y);
    }
  }
}

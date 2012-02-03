//variables
Road r;
int minLength = 10;
int maxLength = 50;
int finishState = 3;
int counter = 0;
int roadWidth = 2;

//arrays
ArrayList<Road> roads;

void setup() {
  size(600, 600, P2D);
  background(0);
  smooth();

  roads = new ArrayList<Road>();

  for (int i=0; i<4; i++) {
    int x = width/2;
    int y = height/2;
    int direction = i;
    int distance = int(random(minLength, maxLength));
  
    r = new Road(x, y, direction, distance);
    roads.add(r);
  }
}

void draw() {
  loadPixels();
  for (int i=0; i<roads.size(); i++) {
    Road r = roads.get(i);
    r.update();
    //println("Frame " + counter++ + " : Road # " + i + " : State = " + r.state);
    r.display();
    if (r.state >= finishState) {
      roads.remove(i);
    }
  }
  if (roads.size() == 0) {
    noLoop();
    println("=== Sketch Complete ===");
  }
}


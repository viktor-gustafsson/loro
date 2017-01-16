import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

float x = 0.1;
float y = 0;
float z = 0;

float a = 0;
float b = 0;
float c = 0;
PVector[] cons = new PVector[3];

float hu=0;
ArrayList<PVector> points = new ArrayList<PVector>();

boolean redraw = false;
boolean randomize = false;

PeasyCam cam;

void setup() {
  
  size(800, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 200);

  cons[0] = new PVector(10, 28, 8/3);
  cons[1] = new PVector(28, 46.92, 4);
  cons[2] = new PVector(12, 22, 8/3);
  a = cons[0].x;
  b = cons[0].y;
  c = cons[0].z;
}

void draw() {
  println(points.size());
  background(0);
  if (points.size() > random(300, 2000)) {
    redraw = true;
  } 
  if (points.size()==0 && redraw==true) {
    redraw=false;
    randomize = true;
  }
  if (randomize)
  {
    PVector vect = cons[int(random(cons.length))];
    a = vect.x;
    b = vect.y;
    c = vect.z;

    randomize = false;
  }


  if (!redraw) {
    float dt = random(0.005, 0.01);
    float dx = a*(y-x)*dt;
    float dy = (x*(b-z)-y)*dt;
    float dz = (x*y-c*z)*dt;
    x=x+dx;
    y = y+dy;
    z = z+dz;

    points.add(new PVector(x, y, z));

    scale(2);
    noFill();
    beginShape();
    hu=0; 
    for (PVector v : points) {
      stroke(hu, 255, 255);
      vertex(v.x, v.y, v.z);
      hu+= 0.1;
      if (hu>255) {
        hu=0;
      }
    }
    endShape();
  } else if (redraw) {
    scale(2);
    noFill();
    beginShape();
    hu = 0;
    for (PVector v : points) {
      stroke(hu, 255, 255);
      vertex(v.x, v.y, v.z);
      hu+=0.1;
    }

    endShape();
    int val = points.size()-1;
    points.remove(val);
    if (points.size()==0) {
      hu=0;      
      x=random(0.1, 0.9);
      y=0;
      z=0;
    }
  }
}
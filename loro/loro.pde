import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

float x = 0.01;
float y = 0;
float z = 0;

float a = 10;
float b = 28;
float c = 8/5;

float hu=0;
ArrayList<PVector> points = new ArrayList<PVector>();

boolean redraw = false;

PeasyCam cam;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  if (points.size() > 1200) {
    redraw = true;
  } 
  if (points.size()==0 && redraw==true) {
    redraw=false;
  }


  if (!redraw) {
    float dt = 0.01;
    float dx = a*(y-x)*dt;
    float dy = (x*(b-z)-y)*dt;
    float dz = (x*y-c*z)*dt;
    x=x+dx;
    y = y+dy;
    z = z+dz;

    points.add(new PVector(x, y, z));

    scale(5);
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
    println(hu);
  } 

else if (redraw) {
  println(hu);
    scale(5);
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
      x=0.01;
      y=0;
      z=0;
    }
  }
}
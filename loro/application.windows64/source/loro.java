import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import peasy.org.apache.commons.math.*; 
import peasy.org.apache.commons.math.geometry.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class loro extends PApplet {





float x = 0.1f;
float y = 0;
float z = 0;

float a = 0;
float b = 0;
float c = 0;
PVector[] cons = new PVector[6];
PVector randVect;

float hu=0;
ArrayList<PVector> points = new ArrayList<PVector>();

boolean redraw = false;
boolean randomize = false;

PeasyCam cam;

public void setup() {

  
  colorMode(HSB);
  cam = new PeasyCam(this, 300);

  //drawing constants
  cons[0]=new PVector(10, 28, 8/3);
  cons[1]=new PVector(28, 46.92f, 4);
  cons[2]=new PVector(12, 22, 8/3);
  cons[3]=new PVector(7, 25, 1.5f);
  cons[4]=new PVector(15, 32, 1);
  cons[5]=new PVector(16.5f, 37.5f, 5.2f);
  //set random vector to start drawing
  //randVect = cons[int(random(cons.size))];
  randVect = cons[PApplet.parseInt(random(cons.length))];
  a = randVect.x;
  b = randVect.y;
  c = randVect.z;
}

public void draw() {
  background(0);
  //determine if redrawing is to be done
  if (points.size() > random(700, 2000)) {
    redraw = true;
  }
  //redrawign complete start new drawing cycle
  if (points.size()==0 && redraw==true) {
    redraw=false;
    randomize = true;
  }
  //random new vector to set new drawing pattern
  if (randomize)
  {
    randVect = cons[PApplet.parseInt(random(cons.length))];
    a = randVect.x;
    b = randVect.y;
    c = randVect.z;

    randomize = false;
  }


  if (!redraw) {
    float dt = random(0.005f, 0.01f);
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
      hu+= 0.1f;
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
      hu+=0.1f;
    }

    endShape();
    int val = points.size()-1;
    points.remove(val);
    if (points.size()==0) {
      hu=0;      
      x=random(0.1f, 0.9f);
      y=0;
      z=0;
    }
  }
}
  public void settings() {  size(1024, 768, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "loro" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

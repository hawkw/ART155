int sphere_size = 100;
float orbital_period = 0;

final float MOON_DIST = 150;
final float Z_PLANE   = 0;

void setup() {
  size(840, 680, P3D);
}

void draw() {
  background(0);
  lights();
  noStroke();
  if (frameCount % 60 < 5) {
    fill(255,0,0);
  } else {
    fill(125,0,0);
  }
  
  pushMatrix();
    translate(width/2, height/2, 0);
    sphere(sphere_size);
    draw_moon(radians(orbital_period));
  popMatrix();
  
    
  stroke(0,255,0,100);
  noFill();
  
  pushMatrix();
    translate(width/2, height/2);
    sphere(500);
  popMatrix();
  
  
  //sphere_size = frameCount % 60 == 0 ? 
  //  100 : sphere_size - 1;
    
  orbital_period = (orbital_period + 1) % 360;

}

void draw_moon(float theta) {
  pushMatrix();
    translate( MOON_DIST * cos(theta)
             , 50 * sin(theta)
             , MOON_DIST*sin(theta));
    fill(255);
    sphere(30);
    // Water molecule
    pushMatrix();
      translate( 50 * cos(theta)
               , 50 * sin(theta)
               , 0);
      water_molecule();
    popMatrix();
    pushMatrix();
          translate( 50 * -cos(theta)
         , 50 * -sin(theta)
         , 0);
      water_molecule();
      popMatrix();
  popMatrix();
}

void water_molecule() {
  rotateX(radians(frameCount * 2));
  
  fill(0,0,255);
  sphere(10);
  fill(255);
  pushMatrix();
    translate(0,10,0);
    rotateY(radians(frameCount * 4));
    sphere(5);
  popMatrix();
  pushMatrix();
    translate(0,-10,0);
    rotateY(radians(frameCount * 4));
    sphere(5);
  popMatrix();
}
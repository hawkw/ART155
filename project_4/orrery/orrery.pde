int sphere_size = 100;
float orbital_period = 0;
float light_intensity = 0;

final float MOON_DIST        = 150;
final float Z_PLANE          = 0;

final float ATOM_SCALE = 7;
// Van der Waals radii of atoms (Angstroms^3)
final float HYDROGEN_RW = 1.2;
final float OXYGEN_RW   = 1.52;
final float SODIUM_RW   = 2.27;
final float CHLORIDE_RW = 1.75;
// Diameters of spheres for atoms
final float HYDROGEN_DIAM = HYDROGEN_RW  * ATOM_SCALE;
final float OXYGEN_DIAM   = OXYGEN_RW * ATOM_SCALE;
final float SODIUM_DIAM   = SODIUM_RW * ATOM_SCALE;
final float CHLORIDE_DIAM = CHLORIDE_RW * ATOM_SCALE;
// CPK colors for elements
final color HYDROGEN_COLOR = color(255,255,255);
final color OXYGEN_COLOR   = color(250,0,0);
final color CHLORINE_COLOR = color(0,255,0);
final color SODIUM_COLOR   = color(0,0,255);

void setup() {
  size(840, 680, P3D);
}

void draw() {
  background(0);
  lights();
  noStroke();
  
  light_intensity = (frameCount % 60 < 5) ?
    255 : light_intensity - 5;
                   
  fill(light_intensity,0,0);
  pointLight( light_intensity, 10, 10
            , width/2, height/2, 0
            );
  
  pushMatrix();
    translate(width/2, height/2, 0);
    sphere(sphere_size);

    draw_moon(radians(orbital_period));
  popMatrix();
  
  //pointLight( 255, 255, 255
  //          , (MOON_DIST - 50) * 2 * -cos(radians(orbital_period))
  //          , (MOON_DIST - 50) * 2 * sin(radians(orbital_period))
  //          , (MOON_DIST - 50) * 2 * sin(radians(orbital_period))
  //          );
            
  pushMatrix();
    translate(width/2, height/2, 0);

    translate( MOON_DIST * 2 * -cos(radians(orbital_period))
             , MOON_DIST * 2 * sin(radians(orbital_period))
             , MOON_DIST * 2 * sin(radians(orbital_period))
             );
    sphere(50);
    pushMatrix();
      translate( 80 * cos(radians(frameCount))
               , 80 * sin(radians(frameCount))
               , 0);
      halite_molecule();
    popMatrix();
    pushMatrix();
      translate( 80 * -cos(radians(frameCount))
               , 80 * -sin(radians(frameCount))
               , 0);
      rotate(180);
      halite_molecule();
    popMatrix();
    //pushMatrix();
    //  translate( 80 * cos(radians(frameCount))
    //           , 80 * -sin(radians(frameCount))
    //           , 0);
    //  rotate(180);
    //  halite_molecule();
    //popMatrix();
  popMatrix();
  
  noFill();
  stroke(0,255,0,70);
  
  pushMatrix();
    translate(width/2, height/2);
    rotateX(map(millis(), 0, 60000, 0, TWO_PI));
    rotateY(map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI));
    rotateZ(map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2));
    sphere(220);
  popMatrix();
  
  
  //sphere_size = frameCount % 60 == 0 ? 
  //  100 : sphere_size - 1;
    
  orbital_period = (orbital_period + 1) % 360;

}

void draw_moon(float theta) {
  //pointLight( 255, 255, 255
  //          , (MOON_DIST - 50) * cos(theta)
  //          , 50 * sin(theta)
  //          , (MOON_DIST - 50) *sin(theta)
  //          );
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
  
  fill(OXYGEN_COLOR);
  sphere(OXYGEN_DIAM);
  fill(HYDROGEN_COLOR);
  pushMatrix();
    translate(0,OXYGEN_DIAM,0);
    rotateY(radians(frameCount * 4));
    sphere(HYDROGEN_DIAM);
  popMatrix();
  pushMatrix();
    translate(0,-OXYGEN_DIAM,0);
    rotateY(radians(frameCount * 4));
    sphere(HYDROGEN_DIAM);
  popMatrix();
}

void halite_molecule() {
  pushMatrix();
    rotateX(radians(frameCount));
    fill(SODIUM_COLOR);
    sphere(SODIUM_DIAM);
    translate(0,SODIUM_DIAM,0);
    fill(CHLORINE_COLOR);
    sphere(CHLORIDE_DIAM);
  popMatrix();

}
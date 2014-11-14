int width, height;  
float degrees = 0.0;
Flower flower;
void setup() {
    width = 600;
    height = 600;
    size(width, height);
    noStroke();
    smooth();
    background(0);
    flower = new Flower(width / 2.0, height / 2.0);  
};

void draw() {
  if(degrees >= 360) { degrees = 0; }
  background(0);
  translate(width / 2, height / 2);
  rotate(radians(degrees));
  flower.render();
  degrees += 0.5;
}

class Flower {
  float x, y;
  int totalPetals = 300;
  float angle = 137.5077640844293;
  float radiusGrowth = 1.0049;
  float radius = 60;
  float rotation = 0.0;
  Petal[] petals;
  
  Flower(float _x, float _y) {
    x = _x;
    y = _y;
    petals = new Petal[totalPetals];     
    for (int i = 0; i < totalPetals; i++) {     
      rotation += angle;
      radius *= radiusGrowth;
      petals[i] = new Petal(this, i);
    }
  }
  
  void render() {
    for(Petal petal : petals) {
      petal.render();
    }
  }

}  
  
class Petal {
  float x = 0.0;
  float y = 0.0;
  float rotation = 0.0;
  float scaleVar = 1;
  color baseColor = color(0, 255, 255, 150);   
  color detailColor = color(255, 255, 255, 160);
  color trimColor = color(0, 0, 0);
  Flower flower;
  
  Petal(Flower _flower, int i) {
      flower = _flower;
      x = cos(radians(flower.rotation)) * flower.radius;
      y = sin(radians(flower.rotation)) * flower.radius;
      rotation = radians(flower.rotation);
      scaleVar += (i * 2) / flower.totalPetals;
  }
  
  void render() {
    pushMatrix();
      translate(this.x, this.y);
      fill(this.baseColor);
      rotate(this.rotation);
      scale(this.scaleVar, this.scaleVar);
      rect(-10, -1, 20, 2);
      ellipse(0, 0, 10, 10);
      fill(this.detailColor);
      ellipse(0, 0, 8, 8);
      fill(this.trimColor);
      ellipse(0, 0, 5, 5);
    popMatrix();
  }
}

int width, height;  
float degrees = 0.0;
ArrayList<Flower> flowers;
void setup() {
    flowers = new ArrayList<Flower>();
    width = 1280;
    height = 800;
    size(width, height);
    noStroke();
    smooth();
    background(0);
    frameRate(30);
    for(int i = 0; i < 11; i++) {
      flowers.add(new Flower(140 * i, height / 2.0));
    }
  };

void draw() {
  background(0);
  for(Flower flower : flowers) {
    flower.draw();
  }
}

class Flower {
  float x, y;
  int totalPetals = 30;
  int size = 600;
  float angle = 137.5077640844293;
  float radiusGrowth = 1.0049;
  float radius = 60;
  float rotation = 0.0;
  float degrees = 0.0;
  Petal[] petals;
  PGraphics image;
    
  
  Flower(float _x, float _y) {
    x = _x;
    y = _y;
    
    petals = new Petal[totalPetals];     
    image = createGraphics(size, size);
    for (int i = 0; i < totalPetals; i++) {     
      rotation += angle;
      radius *= radiusGrowth;
      petals[i] = new Petal(this, i);
    }
    render();
  }
 
  void render() {
    
    image.beginDraw();
      image.smooth();
      image.noStroke();
      image.pushMatrix();
        image.translate(size / 2 , size / 2);
        //image.rotate(radians(degrees));
        for(Petal petal : petals) {
          petal.render();
        }
      image.popMatrix();
    image.endDraw();
    
  }
  
  void draw() {
    if(degrees >= 360) { degrees = 0; }
    pushMatrix();
      translate(x, y);
      rotate(radians(degrees));
      image(image, - size / 2, - size / 2);
    popMatrix();
    degrees += 0.5;
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
    flower.image.pushMatrix();
      flower.image.translate(this.x, this.y);
      flower.image.fill(this.baseColor);
      flower.image.rotate(this.rotation);
      flower.image.scale(this.scaleVar, this.scaleVar);
      flower.image.rect(-10, -1, 20, 2);
      flower.image.ellipse(0, 0, 10, 10);
      flower.image.fill(this.detailColor);
      flower.image.ellipse(0, 0, 8, 8);
      flower.image.fill(this.trimColor);
      flower.image.ellipse(0, 0, 5, 5);
    flower.image.popMatrix();
  }
}

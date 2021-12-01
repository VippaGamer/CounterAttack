class World {

    private PImage bg;

    private World() {
        bg = loadImage("./img/bg04.jpg");
    }

    private void draw() {
        image(bg, 0, 0, 750, 1000);
    }

}
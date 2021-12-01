class Player {

    private float x;
    private float y;
    private boolean Up, Down, Left, Right, Space;
    private PImage img;
    
    private Player(float x, float y) {
        this.x = x;
        this.y = y;
        this.img = loadImage("./img/CP02.png");
    }

    private void Move() {
        
        if (this.Left) {
            this.x -= 10;
        }
        else if (this.Right) {
            this.x += 10;
        }
        if (this.Up) {
            this.y -= 7;
        }
        else if (this.Down) {
            this.y += 7;
        }

        if (this.x < -40) {
            this.x = -40;
        } else if (this.x > 570) { 
            this.x = 570;
        }
        if (this.y < -20) {
            this.y = -20;
        } else if (this.y > 730) { 
            this.y = 730;
        }

        if (this.Space) {
            PlayerBulletCreate();
            this.Space = false;
        }

        image(this.img, this.x, this.y);
    }

    private float x() {
        return this.x; 
    }

    private float y() {
        return this.y; 
    }


}

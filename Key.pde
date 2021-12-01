void keyPressed() {
    if (key == 'A' || key == 'a') {
        p.Left = true;
    }
    else if (key == 'D' || key == 'd') {
        p.Right = true;
    }
    if (key == 'W' || key == 'w') {
        p.Up = true;
    }
    else if (key == 'S' || key == 's') {
        p.Down = true;
    }
}

void keyReleased() {
    if (key == 'A' || key == 'a') {
        p.Left = false;
    }
    else if (key == 'D' || key == 'd') {
        p.Right = false;
    }
    if (key == 'W' || key == 'w') {
        p.Up = false;
    }
    else if (key == 'S' || key == 's') {
        p.Down = false;
    }
    if (key == ' ') {
        p.Space = true;
    } 
}

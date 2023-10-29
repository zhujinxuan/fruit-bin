module concave() {
    uXY = xyUnit/2-2;
    uZ =  hUnit/2;
    thickness = adapterConcaveThickness;

    module concaveItem(x, y, edges) {
         cuboid([ x ? uXY : thickness, y ? uXY : thickness, uZ], chamfer=thickness, edges = edges);
    }

    for (l2= [LEFT, RIGHT]) {
        for (l1 =[FWD, BACK]) {
            corner = l1+l2;
            align(corner+BOTTOM, inside=true) concaveItem(1,0,edges=[ -corner, -corner + TOP]);
            align(corner+BOTTOM, inside=true) concaveItem(0,1,edges=[ -corner, -corner + TOP]);
        }
    }
}

module bulge() {
    uXY = xyUnit/2-2;
    uZ = hUnit/2;
    thickness = adapterConcaveThickness;

    module bulgeItem(x, y, edges) {
        cuboid([ (x ? uXY : thickness) -0.5, (y ? uXY : thickness) -0.5, uZ -0.5], chamfer=thickness-1, edges = edges);
    }

    for (l2= [LEFT, RIGHT]) {
        for (l1 =[BACK, FWD]) {
            corner = l1+l2;
            align(corner+TOP, inside=false) bulgeItem(1,0,edges=[ -corner, -corner+TOP]);
            align(corner+TOP, inside=false) bulgeItem(0,1,edges=[ -corner, -corner+TOP]);
        }
    }
}


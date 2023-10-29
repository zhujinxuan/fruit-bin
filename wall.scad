module sideWall(nL, nH, thick = wallThickness, holeD = hUnit /2, padL = xyUnit * 0.75, spin=0) {
    length = nL * xyUnit;
    height = nH * hUnit;
    numH = floor(height / holeD) -1;
    numX = floor((length - padL*2) /holeD);
    h0 =   - numH*holeD /2 - holeD/2;
    x0 =  - numX*holeD /2 - holeD/2;
    holeCube = (holeD-2) /sqrt(2);
    diff("rem")
        cuboid([length,height,thick], spin=spin, anchor=CENTER, $tag="intersect") {
        for (iH = [1: numH]) {
            for (iX = [1:numX]) {
                tag("rem") back(h0 + iH* holeD) right(x0 + iX*holeD) cube([holeCube, holeCube, thick+2], spin = 45, center = true);
                if (iH!= numH && iX != numX) {
                    tag("rem") back(h0 + iH* holeD + holeD/2) right(x0 + iX*holeD + holeD/2) cube([holeCube, holeCube, thick+2], spin = 45, center = true);
                }
            }
        }
    }
}

module basketWall(nx,ny,nz) {
    h = hUnit * nz;
    ly = xyUnit*ny;
    lx = xyUnit*nx;
    thick = wallThickness;
    align(LEFT+FWD, inside=true)
        cube([xyUnit/2, thick, h]);
    align(RIGHT+FWD, inside=true)
        cube([xyUnit/2, thick, h]);
    align(LEFT+FWD +TOP, inside = true)
         yrot(-90) sideWall(ny, nz, spin=90);
    align(RIGHT+FWD +TOP, inside = true)
         yrot(90) sideWall(ny, nz, spin=-90);
    align(BACK+TOP)
         xrot(90) sideWall(nx, nz);
    align(BOTTOM+FWD, inside=true)
        cube([lx,thick, hUnit]);
    align(BOTTOM, inside=true)
        cube([lx, ly, thick]);
}

module basket(nx, ny, nz) {
    h = hUnit * nz;
    ly = xyUnit*ny;
    lx = xyUnit*nx;
    hide("hide")
        diff()
        cuboid([lx, ly, h], $tag="hide") {
        tag("intersect") basketWall(nx,ny,nz);
        tag("remove") concave();
        tag("keep") bulge();
    };
}

module gapWall(nx,ny,nz) {
    h = hUnit * nz;
    ly = xyUnit*ny;
    lx = xyUnit*nx;
    thick = wallThickness;
    align(LEFT+FWD, inside=true)
        cube([xyUnit/2, thick, h]);
    align(RIGHT+FWD, inside=true)
        cube([xyUnit/2, thick, h]);
    align(LEFT+FWD +TOP, inside = true)
         yrot(-90) sideWall(ny, nz, spin=90);
    align(RIGHT+FWD +TOP, inside = true)
         yrot(90) sideWall(ny, nz, spin=-90);
    align(BACK+TOP)
         xrot(90) sideWall(nx, nz);
}

module gap(nx, ny,nz) {
    h = hUnit * nz;
    ly = xyUnit*ny;
    lx = xyUnit*nx;
    hide("hide")
        diff()
        cuboid([lx, ly, h], $tag="hide") {
        tag("intersect") gapWall(nx,ny,nz);
        tag("remove") concave();
        tag("keep") bulge();
    };
}



module base(nx,ny,nz) {
    h = hUnit * nz;
    ly = xyUnit*ny;
    lx = xyUnit*nx;
        diff()
        cuboid([lx, ly, h]) {
        tag("remove") concave();
        tag("keep") bulge();
    };
}


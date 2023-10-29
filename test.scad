include <BOSL2/std.scad>
$fn=32;
intersect("keep","fullkeep")
  diff(keep="fullkeep keep")
    cuboid(10){
      tag("remove")cyl(r=4,h=11);
      tag("keep") position(RIGHT)cyl(r=8,h=12);
      tag("fullkeep")cyl(r=1,h=12);
  }

include<params.scad>;

module railend(depth, height) {
	sphere(d=depth, $fn=cylres30);
	translate([0,0,-height/4])
		cylinder(h=height/2, d=depth, center=true, $fn=cylres30);
}

module roundedRail(width,depth,height) {
	rad = depth/2;
	tolerance5 = 0.5;  // tolerance=0.1 * 5 (params)
	translate([-width/2,0,0])
	hull() {
		translate([width/2,0,0])
			cube([width-rad*3,depth,height], center = true);
		translate([rad, 0, height/2 - rad])
			railend(depth, height);
		translate([width - rad,0,0])
			railend(depth, height);
	}
}


// Testing
roundedRail(60, 8, 8);
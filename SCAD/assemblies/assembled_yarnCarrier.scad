include<../modules/params.scad>;
use<../parts/stripperPlate.scad>;
use<../parts/yarnCarrierCover.scad>;
use<../parts/yarnFeeder.scad>;
use<../modules/carriageScrews.scad>;

/* 
Full yarn carrier (fairing) assembly for layout and debugging
See individual files to export models
*/

/* [Parameters] */
// Show Yarn Feeder
Show_yarn_feeder = true;
// Show Stripper Plate
Show_stripper_plate = true;
// Show Yarn Carrier Cover
Show_carrier_cover = true;
// Show Screws
Show_screws = false;
// Show screws cutaway
Show_cutaway = false;
/* [Hidden] */

module assembled_carrier() {
    if (Show_yarn_feeder)
        build_yarn_feeder();
    if (Show_stripper_plate)
        build_stripper_plate();
    if (Show_carrier_cover)
        build_yarn_carrier_cover();
    if (Show_screws)
        carriageScrews();
}



// Show assembly
if (Show_cutaway) {
difference() {
    assembled_carrier();
    color("Red") {
        translate([-21,-200,-14])
            cube([30,30,60]);
        translate([-20,-140,-14])
            cube([30,220,60]);
        }
    }
} else
    assembled_carrier();


color("red")
translate([0,40,0])
rotate([00,0,0]) {
    text("Do not print from this file.", size=5);
    translate([0,-15,0])
    text("Assembly Visualisation.");
    }
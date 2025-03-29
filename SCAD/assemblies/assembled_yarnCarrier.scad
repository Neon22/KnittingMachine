include<../modules/params.scad>;
use<../parts/stripperPlate.scad>;
use<../parts/yarnCarrierCover.scad>;
use<../parts/yarnFeeder.scad>;

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

/* [Hidden] */


// Show assembly
if (Show_yarn_feeder)
    build_yarn_feeder();
if (Show_stripper_plate)
    build_stripper_plate();
if (Show_carrier_cover)
    build_yarn_carrier_cover();

color("red")
translate([0,40,0])
rotate([00,0,0]) {
    text("Do not print from this file.", size=5);
    translate([0,-15,0])
    text("Assembly Visualisation.");
    }
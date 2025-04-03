include<../modules/params.scad>;
use<../parts/needleBed.scad>;
use<../parts/backCover.scad>;
use<../parts/spongeBar.scad>;
use<../parts/carriageRest.scad>;

/* 
Full bed assembly for layout and debugging
See individual files to export models
*/

/* [Parameters] */
Show_needle_bed = true;
Show_back_cover = true;
// Round/Square backcover ends
back_cover_rounded = true;
Show_spongebar = true;
Show_carriage_rests = true;
Show_clamps = true;

/* [Hidden] */




// Show assembly
if (Show_needle_bed)
    build_needle_bed();
if (Show_back_cover) {
    color("lightblue")
        build_backCover(back_cover_rounded);
}
if (Show_spongebar) {
    color("orange")
        build_spongeBar();
}
if (Show_carriage_rests)
    build_carriage_rest();

if (Show_clamps)
    translate([-gauge,0,0])
        clampUnit();

color("red")
translate([0,40,0])
rotate([00,0,0]) {
    text("Do not print from this file.", size=5);
    translate([0,-15,0])
    text("Assembly Visualisation.");
    }
    
// Note:
// - Need to mod a few files to pass gauge,numNeedles through for this to work.
// - Will also need to calc widths to space if allow multiple needle beds (for small printers/large beds)
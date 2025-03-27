include<../modules/params.scad>;
include<../modules/camplate_coords_mk2.scad>;
include<../modules/utils.scad>;
use<../parts/backCover.scad>;
use<../parts/backPlate.scad>;
use<../parts/spongeBar.scad>;
use<../parts/tCam.scad>;
use<../parts/tPointer.scad>;
use<../modules/carriageScrews.scad>;



/* 
Full camplate assembly for layout and debugging
See individual files to export models
*/

/* [Parameters] */

Show_backplate = true;
Show_back_cover = true;
Show_cams = true;
Show_pointers = true;
Show_spongebar = true;
Show_screws = true;

/* [Hidden] */

if (Show_backplate)
	build_back_plate();   // mk2
if (Show_back_cover)
	build_backCover();
if (Show_cams)
	build_tCams();
if (Show_pointers)
	build_pointers();
if (Show_spongebar)
	build_spongeBar();
if (Show_screws)
	carriageScrews();

color("red")
translate([0,40,0])
rotate([00,0,0]) {
	text("Do not print from this file.", size=5);
	translate([0,-15,0])
	text("Assembly Visualisation.");
	}
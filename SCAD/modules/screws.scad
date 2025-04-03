
// We distinguish between:
// - Screws - which do not have a nut
// - Bolts - which have a nut or an insert (heat installed)
//    (These are naming conventions only.)
// Each object describes a negative volume. So needs to be a bit larger than actual object.

// Screw factors:
// Screw tolerance:
// - all measured dimensions of circles will shrink by an amount when printed.
//   screws need to bite into the plastic. Bolts need to go through cleanly.
//   This accounts for that difference.
/* [Parameters] */
screw_thread_tol = 0.04;  // for screws smaller than bolts which need more space
bolt_thread_tol = 0.4;    // for bolts (larger so clean fit)
screw_res = 16;   // for a printer this is probably enough
thread_res = 25;  // for a printer this is probably enough
nut_res = 8;      // assuming all nuts are trad 8 sided

Show_screws = true;
// print Block
Clearance_testing = false;
show_cutaway = true;
/* [Hidden] */
Delta = 0.01;  // tiny overlaps for better viewer display


// Screws:


// 4-40 pan head  machine screws
// - M3 should also work where these are used (but check length)
module screw_4_40_A(extra_cap=0 ,extra_length=0) {
    // 3/4in long - 14.5mm long 2.79mm wide, pan head
    thread_dia = 2.79;
    thread_height = 14.62;
    head_dia = 5.21;
    head_height = 2.41;
    //
    screw(thread_dia+screw_thread_tol, thread_height+extra_length,
          head_dia+bolt_thread_tol, head_height+extra_cap);
}

// 4-40 but shorter 1/2in
module screw_4_40_B(extra_cap=0 ,extra_length=0) {
    // 1/2in long - 13mm long 2.79mm wide, pan head
    thread_dia = 2.79;
    thread_height = 13.0;
    head_dia = 5.21;
    head_height = 2.41;
    //
    screw(thread_dia+screw_thread_tol, thread_height+extra_length,
          head_dia+bolt_thread_tol, head_height+extra_cap);
}

// 4-40 but shorter 1/4in
module screw_4_40_C(extra_cap=0 ,extra_length=0) {
    // 1/2in long - 6.5mm long 2.79mm wide, pan head
    thread_dia = 2.79;
    thread_height = 6.4;
    head_dia = 5.21;
    head_height = 2.41;
    //
    screw(thread_dia+screw_thread_tol, thread_height+extra_length,
          head_dia+bolt_thread_tol, head_height+extra_cap);
}


// 6-32 pan head machine screws
module screw_6_32_A(extra_cap=0 ,extra_length=0) {
    // 1/2 long - 13mm long 3.34mm wide, pan head
    thread_dia = 3.45;
    thread_height = 13;
    head_dia = 6.75;
    head_height = 6.75;
    //
    screw(thread_dia+screw_thread_tol, thread_height+extra_length,
          head_dia+screw_thread_tol, head_height+extra_cap);
}




// Other Screw/Bolt/Insert Examples:

// Bolt version of screw
module bolt_6_32_B(nut_dist=10, extra_cap=0 ,extra_length=0) {
    // 5/8 long - 18mm long 3.34mm wide, pan head with Nut (8mm)
    thread_dia = 3.45;
    thread_height = 18;
    head_dia = 6.75;
    head_height = 6.75;
    nut_width = 7.9;
    nut_height = 2.8;
    //
    screw(thread_dia+bolt_thread_tol, thread_height+extra_length,
          head_dia+bolt_thread_tol, head_height+extra_cap,
          nut_width+screw_thread_tol, nut_height+extra_cap, nut_dist);
}

module bolt_4_40_A(nut_dist=10, extra_cap=0 ,extra_length=0) {
    // 1/2 long - 14.5mm long 2.79mm wide, hex head with nut
    thread_dia = 2.79;
    thread_height = 14.62;
    head_dia = 5.21;
    head_height = 2.41;
    nut_width = 7.9;
    nut_height = 2.8;
    //
    screw(thread_dia+bolt_thread_tol, thread_height+extra_length,
          head_dia+bolt_thread_tol, head_height+extra_cap,
          nut_width+screw_thread_tol, nut_height+extra_cap, nut_dist);
}

// M3 bolt with nut
module bolt_M3_A(nut_dist=10, extra_cap=0 ,extra_length=0) {
    bolt_4_40_A(nut_dist, extra_cap, extra_length);
}
// M3 with Insert instead of Nut
module bolt_M3_B(nut_dist=6, extra_cap=0 ,extra_length=0) {
    // 14.5mm long 2.79mm wide, Insert
    thread_dia = 2.79;
    thread_height = 14.62;
    head_dia = 5.21;
    head_height = 2.41;
    nut_width = 8;
    nut_height = 6;
    //
    screw(thread_dia+bolt_thread_tol, thread_height+extra_length,
          head_dia+bolt_thread_tol, head_height+extra_cap,
          nut_width+screw_thread_tol, nut_height+extra_cap, nut_dist);
}


module screw(dia, length, head_dia, head_height, nut_width=0, nut_height=0, nut_dist=0) {
    //
    translate([0, 0, -length/2])
        cylinder(h=length, d=dia, center=true, $fn=screw_res); 
    translate([0,0,head_height/2-Delta]) 
        cylinder(h=head_height, d=head_dia, center=true, $fn=screw_res);
    // do we have a nut/insert?
    if (nut_width != 0) {
        // expecting to find the three nut values
        translate([0, 0, -nut_height/2-nut_dist])
            cylinder(h=nut_height, d=nut_width, center=true, $fn=nut_res); 
    }
}



// Testing
module test_screws() {
    translate([0,0,0]) {
        screw_4_40_A();
        rotate([0,0,90])
        translate([10,-2,0])
            text("4-40 x 3/4in machine screw (14.5mm long 2.79mm wide), pan head",size=4);
    }

    translate([10,0,0]) {
        screw_4_40_B();
        rotate([0,0,90])
        translate([10,-2,0])
            text("4-40 x 1/2in machine screw (13mm long 2.79mm wide), pan head",size=4);
    }

    translate([20,0,0]) {
        screw_4_40_C();
        rotate([0,0,90])
        translate([10,-2,0])
            text("4-40 x 1/4in machine bolt (6.5mm long 2.79mm wide), pan head",size=4);
    }

    translate([30,0,0]) {
        screw_6_32_A();
        rotate([0,0,90])
        translate([10,-2,0])
            text("6/32 x 1/2in screw (13mm long 3.34mm wide), pan head",size=4);
    }

    translate([40,0,0]) {
        bolt_6_32_B(14);
        rotate([0,0,90])
        translate([10,-2,0])
            text("6/32 5/8in bolt (18mm long 3.34mm wide), pan head w/nut",size=4);
    }

    translate([50,0.0]) {
        bolt_M3_A(nut_dist=12);
        rotate([0,0,90])
        translate([10,-2,0])
            text("M3 bolt 15mm long 3mm wide, hex head w/nut",size=4);
    }
    translate([60,0.0]) {
        bolt_M3_B(nut_dist=8);
        rotate([0,0,90])
        translate([10,-2,0])
            text("M3 bolt 15mm long 3mm wide, hex head w/insert",size=4);
    }
}

// Testing
module test_screw_block() {
	block_length = 90;
    difference() {
        translate([-10,10,-15])
            cube([block_length,10,16]);  // length of the test block
        translate([0,15,0.1])
            test_screws();
        }
}

//
if (Show_screws)
    test_screws();

if (Clearance_testing)
    if (show_cutaway)
        translate([0,-50,0])
        difference() {
            test_screw_block();
            color("red")
            translate([-11,5,-18])
                cube([170,10,20]);
        }
    else
        translate([0,-50,0])
            test_screw_block();

color("Red")
translate([-30,0,0])
rotate([0,0,90]) {
    text("Dynamic edits to screw parameters will", size=4);
    translate([0,-8,0])
        text("need to be manually transferred to the file", size=4);
    translate([0,-16,0])
        text("for correct part printing.", size=4);
    }
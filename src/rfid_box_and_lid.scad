
include <dimensions.scad>
include <posts.scad>
include <lcd_mount.scad>

//    <  lcd   >
// --------------
// --          -- ^
// --          -- 
// -------------- v
// --          -- 
// --          -- ^
// --          -- 
// --          -- v
// --------------
//    < keypad  >


module boxLid () {
	hull()
	posts(
			x=box_x - radius - lid_lip,
			y=box_y - radius - lid_lip,
			h=lid_thickness,
			z=lid_bottom,
			r=radius
			);
}

module box_holes (r=2.5) {
	posts(
			x=(box_x -radius * 2) - r,
			y=(box_y -radius * 2) - r,
			z=lid_bottom,
			h=box_z,
			r=r
		);
}

//box
*union () {

	//enclosure
	difference() {
		posts(
			x=box_x -radius,
			y=box_y -radius,
			h=lid_bottom,
			r=radius
		);
		translate([0,0,-8])
		box_holes(5); // threaded insert m3

	}
	
	//mounting posts
	difference(){	
		hull()
		posts(
			x=box_x -radius,
			y=box_y -radius, 
			h=box_z,
			r=radius
			);

		hull()
		posts(
			x=box_x -radius - wall_thickness,
			y=box_y -radius - wall_thickness, 
			h=box_z+0.1,
			r=radius
			);
		boxLid(); 	//lip cut
	}


}


lcd_origin  = [0, lcd_y + space / 2, lid_bottom  ];

// lid
union() {
        difference() {
            boxLid();
			//lcd cut
			translate(lcd_origin)
			hull()
			posts(x=lcd_x, y=lcd_y, r=1, h=lid_thickness);
            //keypad cut
            translate([0, -keypad_y/2 + 20 , 0])
            hull()
			posts(
                x = keypad_x ,
                y = keypad_y ,
                z = lid_bottom + lid_thickness - keypad_z + 0.1,
                r = keypad_radius,
                h= keypad_z
            );
			box_holes(1.5);
			translate([0,-55,lid_bottom])
			hull()
			posts(x=20, y=4, h=lid_thickness, r=2); // keypad cable cut

        }

		mounting_post_exterior_r = 4;
		self_threaded_m3_r = 2.5 / 2;
		lcd_post_h = 4;

		translate([0,0,-lcd_post_h])
		translate(lcd_origin)
		difference() {
		posts(
			x=lcd_holes_x  - 5,
			y=lcd_holes_y -5,
			h=mounting_post_exterior_r,
			r=mounting_post_exterior_r,
			center=true
		);
		translate([0,0,lcd_post_h]);
			posts(
			x=lcd_holes_x  - mounting_post_exterior_r,
			y=lcd_holes_y - mounting_post_exterior_r,
			h=lcd_post_h,
			r= 2.5 / 2, 
			center=true
		);
		hull()
		posts(x=lcd_x, y=lcd_y, r=1, h=lid_thickness);
		}


        rfid_post_h = 6;
        translate([0, (-keypad_x + space) / 2 ,lid_bottom - rfid_post_h])
        difference() {
            posts(
                    x=rfid_s ,
                    y=rfid_s ,
                    h=rfid_post_h,
                    r=mounting_post_exterior_r,
					center=true

            );
            posts(
                    x=rfid_s,
                    y=rfid_s,
                    h=rfid_post_h,
                    r=self_threaded_m3_r,
					center=true
            );
        }
}

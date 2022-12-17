
include <dimensions.scad>
include <posts.scad>
include <lcd_mount.scad>

module postsHoles () {
	posts(
		x=(box_x /2) -radius,
		y=(box_y /2) -radius,
		z=wall_thickness,
		h=box_z,
		r=3
	);
}


module boxLid () {
	hull()
	posts(
			x=(box_x /2) -radius - lid_lip,
			y=(box_y /2) -radius - lid_lip,
			z= lid_bottom,
			h= lid_thickness,
			r= radius
			);
}


//box
*union () {

		posts(
			x=(box_x /2) -radius ,
			y=(box_y /2) -radius ,
			z=0,
			h=lid_bottom,
			r=radius
		);
	
	difference(){	
		hull()
		posts(
			x=(box_x /2) -radius,
			y=(box_y /2) -radius, 
			z=0,
			h=box_z,
			r=radius
			);

		hull()
		posts(
			x=(box_x /2)-radius - wall_thickness,
			y=(box_y /2 )-radius - wall_thickness, 
			z=wall_thickness,
			h=box_z,
			r=radius
			);
		boxLid(); 	//lip cut
		// postsHoles();
	}


}





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

// lid
	
	lcd_origin  = [0, lcd_y + space / 2, lid_bottom ];

 union() {
        difference() {
            boxLid();
            postsHoles();

			//lcd cut
			translate(lcd_origin)
			cube([lcd_x,lcd_y,15], center=true);

            //keypad cut
            translate([0, -keypad_y/2 + space , 0])
            hull()
			posts(
                x = keypad_x / 2,
                y = keypad_y / 2,
                z = lid_bottom + lid_thickness - keypad_z + 0.1,
                r = keypad_radius,
                h= keypad_z
            );

			
            //keypad cable cut
            translate([-keypad_x+10,0,lid_bottom])
            cube([3,22,15], center=true);
			
        }

		 lcd_post_h = 4;

		translate([0,0,-lcd_post_h])
		translate(lcd_origin)
		difference() {
		posts(
			x=lcd_holes_x /2 - 5,
			y=lcd_holes_y/2 -5,
			z=0,
			h=lcd_post_h,
			r=5,
			center=true
		);
		translate([0,0,lcd_post_h]);
			posts(
			x=lcd_holes_x /2 - 5,
			y=lcd_holes_y/2 - 5,
			z=0,
			h=lcd_post_h,
			r=2.5,
			center=true
		);
		}


        rfid_post_h = 6;
        translate([0, -(keypad_x / 2) +space,lid_bottom - rfid_post_h])
        difference() {
            posts(
                    x=(rfid_s / 2),
                    y=(rfid_s / 2),
                    z=0,
                    h=rfid_post_h,
                    r=rfid_post_h
            );
            posts(
                    x=(rfid_s / 2),
                    y=(rfid_s / 2),
                    z=0,
                    h=rfid_post_h,
                    r=3
            );
        }

    }

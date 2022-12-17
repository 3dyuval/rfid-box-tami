
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


module box (x,y,z,h,r) {
	hull()  posts(x,y,z,h,r);
}

module boxLid () {
	box(
			x=(box_x /2) -radius - lid_lip,
			y=(box_y /2) -radius - lid_lip,
			z= lid_bottom,
			h= lid_thickness,
			r= radius
			);
}


//box
union () {

//posts
		posts(
			x=(box_x /2) -radius ,
			y=(box_y /2) -radius ,
			z=0,
			h=lid_bottom,
			r=radius
		);
	
	difference(){	
		box(
			x=(box_x /2) -radius,
			y=(box_y /2) -radius, 
			z=0,
			h=box_z,
			r=radius
			);

		box(
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
* union() {
        difference() {
            boxLid();
            postsHoles();
			rotate(90)

            //keypad cut
            translate([-space + 5, 0, 0])
            box(
                x = keypad_x / 2,
                y = keypad_y / 2,
                z = lid_bottom + lid_thickness - keypad_z + 0.1,
                r = keypad_radius,
                h= keypad_z
            );
            //keypad cable cut
            translate([-keypad_x,0,lid_bottom])
            cube([3,15,15], center=true);
        }

        // posts for rfid interior mount
            mount_posts_h = 6;
            translate([-(keypad_x / 2), 0,lid_bottom - mount_posts_h])
        difference() {
            posts(
                    x=(rfid_s / 2),
                    y=(rfid_s / 2),
                    z=0,
                    h=mount_posts_h,
                    r=mount_posts_h
            );
            posts(
                    x=(rfid_s / 2),
                    y=(rfid_s / 2),
                    z=0,
                    h=mount_posts_h,
                    r=3

            );
        }
    }

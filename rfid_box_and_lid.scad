keypad_x = 69.2;
keypad_y = 76.9;
keypad_z = 2;
keypad_radius = 10;

lcd_x = 60;
lcd_y = 25.2;
lcd_z = 2;
lcd_holex_x = 75;
lcd_holes_y = 31;

rfid_s = 41;

space = 30;
box_x = keypad_x + lcd_x + space;
box_y = keypad_y + lcd_y + space;
box_z =  50;
wall_thickness = 5;
radius = 7.5;
lid_thickness = 5;
lid_lip = 3;
lid_bottom = box_z - lid_thickness;


module posts (x,y,z,h,r) {
			translate([x, -y , z])
			cylinder(h=h,r=r);
			translate([-x, -y , z])
			cylinder(h=h,r=r);
			translate([-x, y ,z])
			cylinder(h=h,r=r);
			translate([x, y ,z])
			cylinder(h=h,r=r);
}

module postsHoles () {
	posts(
		x=(box_x /2) -radius,
		y=(box_y /2) -radius,
		z=wall_thickness,
		h=box_z,
		r=3
	);
}



module box (x,y,z,h,r, hull = false) {
	hull() { posts(x,y,z,h,r);}
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
	difference() {
		posts(
			x=(box_x /2) -radius ,
			y=(box_y /2) -radius ,
			z=0,
			h=lid_bottom,
			r=radius
		);
		postsHoles();
	}
	
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
		postsHoles();
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
*union() {
	difference() {
		boxLid();
		postsHoles();
		//lcd cut
		translate([lcd_x / 2 + space / 2, 0, box_z - wall_thickness])
		rotate(90)
		cube([ lcd_x, lcd_y, box_z ], center = true);
		//lcd holes
		translate([lcd_x / 2 + space / 2, 0, 0])
		rotate(90)
		posts(
			x =  lcd_holex_x / 2,
			y = lcd_holes_y /2 ,
			z = lid_bottom,
			h = box_z + 1,
			r = 2.5
		);
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

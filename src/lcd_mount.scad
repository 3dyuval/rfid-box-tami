include <dimensions.scad>
include <posts.scad>

module lcd_cut() {
        difference() {
        children()
		cube([ lcd_x, lcd_y, box_z ], center = true); 
    }
}


module lcd_posts (
            x =  lcd_holex_x / 2,
			y = lcd_holes_y /2 ,
			z = lid_bottom,
			h,
            r,
            center
			) {
			posts(
            x=x, y=y, z=z, h=h, r=r,
			center=center
		);
}

module lcd_mount() {

    module lcd_cut() {
        hull()
        lcd_posts(r=1, h=50, center=true);
    }
    
	difference(){
		rotate(90)
		hull()
		lcd_posts(
		x= lcd_x,
		y= lcd_y,
		z = box_z,
		h=5,
		r= 2,
        center=false
		);
		lcd_cut();
	}
        lcd_posts(r=2, h=5, center=true);
        difference() {
        //mounting posts
        lcd_posts(r=5, h=5, center=true);
		lcd_cut();
        //mounting holes
        }
  }

  *lcd_mount();
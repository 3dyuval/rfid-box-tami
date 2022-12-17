include <dimensions.scad>
include <posts.scad>

    hull()
	posts2(
			x= box_x - radius - lid_lip,
			y= box_y - radius - lid_lip,
			h= lid_thickness,
			r= radius
		)
        ;
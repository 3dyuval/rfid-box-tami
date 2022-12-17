

//	   A	
//  |-----|
//D |     | B
//  |-----|
//	   C

//usage:
//posts(x=100, y=50, z=50, h=25, r=10, center=true);


module posts (x,y,z = 0,h,r, center=false) {

	xd = x / 2;
	yd = y / 2;

	a = center ? [-xd, yd, z ] : [-xd+r,  yd-r ,z ];
	b = center ? [ xd, yd, z ] : [ xd-r,  yd-r ,z ];
	c = center ? [ xd,-yd, z ] : [ xd-r, -yd+r, z ];
	d = center ? [-xd,-yd, z ] : [-xd+r, -yd+r ,z ];
	
			translate(a)
			cylinder(h=h,r=r);
			translate(b)
			cylinder(h=h,r=r);
			translate(c)
			cylinder(h=h,r=r);
			translate(d)
			cylinder(h=h,r=r);
}



//	   A	
//  |-----|
//D |     | B
//  |-----|
//	   C

//usage:
//posts(x=100, y=50, z=50, h=25, r=10, center=true);


module posts (x,y,z,h,r, center=false) {

	a = center ? [x, -y, z] : [x-r, -y+r, z];
	b = center ? [-x, -y, z] :  [-x+r, -y+r , z];
	c = center ? [-x, y, z] : [-x+r, y-r ,z];
	d = center ?  [x, y, z] : [x-r, y-r ,z];
	
			translate(a)
			cylinder(h=h,r=r);
			translate(b)
			cylinder(h=h,r=r);
			translate(c)
			cylinder(h=h,r=r);
			translate(d)
			cylinder(h=h,r=r);
}


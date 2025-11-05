let
	key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQChyLWhoNId4RlMjRyBv7dhImswmI9BAo4QHyr4wJhynPTknovtuVjg5CaAnG9v8mhLm9Nn/pCJH0zjXjF0PvolzuDng7dOtiZFdXWUU+A+6P/Xnwtm3vPqMRbLSe3arBKre0aaOpJFvxTzn09hd3i//tF2DJDi/wPaFBX5hbHLJIqQmuyh+tB7M7QxGNtsEtiYFa+CtEjQygSPmFp8FmOhW2KNifjjs3G+JXluYOl4Q+dRpmWrVGdn2yrymILvgax2xT7VFPa/Ij9+VJ5q0d9tFqKm2K7KcpsRn5hl1RHsI3po4m37oft/5IRXh8TTZS8iW4sF6vCzP0qnqT2VtEpcMmAw3mJJwc5Z5R01RVs09B53lot6mTPQDMNG9j1O1KDkByfpxJ9cwp9Bzts/rR181B8v6LpivvkjquSdBEMN1g9Lm04Af28DGI9EVSfuPTGnWhLdmwh2HEFmgSddRo4/JzrubSs0BpvMn7mLjJWq/54e7acGUAvP5cX4CwIhLw0= root@snd-tp";
in
{
	"wg-laptop.age".publicKeys = [ key ];
	"wg-pc.age".publicKeys = [ key ];
	"wg-server.age".publicKeys = [ key ];
	"password.age".publicKeys = [ key ];
	"wakasalt.age".publicKeys = [ key ];
	"pssh.age".publicKeys = [ key ];
}

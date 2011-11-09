//POVRay-File created by 3d41.ulp v1.05
//C:/Users/Jeremy Blum/Dropbox/JeremyBlum.com/new CONTENT/header/header.brd
//7/25/2011 10:54:14 PM

#version 3.5;

//Set to on if the file should be used as .inc
#local use_file_as_inc = off;
#if(use_file_as_inc=off)


//changes the apperance of resistors (1 Blob / 0 real)
#declare global_res_shape = 1;
//randomize color of resistors 1=random 0=same color
#declare global_res_colselect = 0;
//Number of the color for the resistors
//0=Green, 1="normal color" 2=Blue 3=Brown
#declare global_res_col = 1;
//Set to on if you want to render the PCB upside-down
#declare pcb_upsidedown = off;
//Set to x or z to rotate around the corresponding axis (referring to pcb_upsidedown)
#declare pcb_rotdir = x;
//Set the length off short pins over the PCB
#declare pin_length = 2.5;
#declare global_diode_bend_radius = 1;
#declare global_res_bend_radius = 1;
#declare global_solder = on;

#declare global_show_screws = on;
#declare global_show_washers = on;
#declare global_show_nuts = on;

//Animation
#declare global_anim = off;
#local global_anim_showcampath = no;

#declare global_fast_mode = off;

#declare col_preset = 0;
#declare pin_short = on;

#declare environment = on;

#local cam_x = 0;
#local cam_y = 511;
#local cam_z = -116;
#local cam_a = 20;
#local cam_look_x = 0;
#local cam_look_y = -5;
#local cam_look_z = 0;

#local pcb_rotate_x = 10;
#local pcb_rotate_y = 0;
#local pcb_rotate_z = 0;

#local pcb_board = on;
#local pcb_parts = on;
#if(global_fast_mode=off)
	#local pcb_polygons = on;
	#local pcb_silkscreen = on;
	#local pcb_wires = on;
	#local pcb_pads_smds = on;
#else
	#local pcb_polygons = off;
	#local pcb_silkscreen = off;
	#local pcb_wires = off;
	#local pcb_pads_smds = off;
#end

#local lgt1_pos_x = 60;
#local lgt1_pos_y = 91;
#local lgt1_pos_z = 26;
#local lgt1_intense = 0.815863;
#local lgt2_pos_x = -60;
#local lgt2_pos_y = 91;
#local lgt2_pos_z = 26;
#local lgt2_intense = 0.815863;
#local lgt3_pos_x = 60;
#local lgt3_pos_y = 91;
#local lgt3_pos_z = -18;
#local lgt3_intense = 0.815863;
#local lgt4_pos_x = -60;
#local lgt4_pos_y = 91;
#local lgt4_pos_z = -18;
#local lgt4_intense = 0.815863;

//Do not change these values
#declare pcb_height = 1.500000;
#declare pcb_cuheight = 0.035000;
#declare pcb_x_size = 159.893000;
#declare pcb_y_size = 50.724000;
#declare pcb_layer1_used = 1;
#declare pcb_layer16_used = 1;
#declare inc_testmode = off;
#declare global_seed=seed(119);
#declare global_pcb_layer_dis = array[16]
{
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	0.000000,
	1.535000,
}
#declare global_pcb_real_hole = 2.000000;

#include "tools.inc"
#include "user.inc"

global_settings{charset utf8}

#declare col_brd = texture{pigment{DarkGreen}}
#declare col_wrs = texture{pigment{Gray10}}
#declare col_pds = texture{T_Silver_5A}
#declare col_hls = texture{pigment{Gray50}}
#declare myGRAY = rgb <223/255,223/255,223/255>;
#declare col_bgr = myGRAY;
#declare col_slk = texture{pigment{White}}
#declare col_thl = texture{pigment{Gray70}}
#declare col_pol = texture{pigment{Gray10}}

#if(environment=on)
sky_sphere {pigment {Navy}
pigment {bozo turbulence 0.65 octaves 7 omega 0.7 lambda 2
color_map {
[0.0 0.1 color rgb <0.85, 0.85, 0.85> color rgb <0.75, 0.75, 0.75>]
[0.1 0.5 color rgb <0.75, 0.75, 0.75> color rgbt <1, 1, 1, 1>]
[0.5 1.0 color rgbt <1, 1, 1, 1> color rgbt <1, 1, 1, 1>]}
scale <0.1, 0.5, 0.1>} rotate -90*x}
plane{y, -10.0-max(pcb_x_size,pcb_y_size)*abs(max(sin((pcb_rotate_x/180)*pi),sin((pcb_rotate_z/180)*pi)))
texture{T_Chrome_2D
normal{waves 0.1 frequency 3000.0 scale 3000.0}} translate<0,0,0>}
#end

//Animation data
#if(global_anim=on)
#declare global_anim_showcampath = no;
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_flight=0;
#warning "No/not enough Animation Data available (min. 3 points) (Flight path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#declare global_anim_npoints_cam_view=0;
#warning "No/not enough Animation Data available (min. 3 points) (View path)"
#end

#if((global_anim=on)|(global_anim_showcampath=yes))
#end

#if((global_anim_showcampath=yes)&(global_anim=off))
#end
#if(global_anim=on)
camera
{
	location global_anim_spline_cam_flight(clock)
	#if(global_anim_npoints_cam_view>2)
		look_at global_anim_spline_cam_view(clock)
	#else
		look_at global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	angle 45
}
light_source
{
	global_anim_spline_cam_flight(clock)
	color rgb <1,1,1>
	spotlight point_at 
	#if(global_anim_npoints_cam_view>2)
		global_anim_spline_cam_view(clock)
	#else
		global_anim_spline_cam_flight(clock+0.01)-<0,-0.01,0>
	#end
	radius 35 falloff  40
}
#else
camera
{
	location <cam_x,cam_y,cam_z>
	look_at <cam_look_x,cam_look_y,cam_look_z>
	angle cam_a
	//translates the camera that <0,0,0> is over the Eagle <0,0>
	//translate<-79.946500,0,-25.362000>
}
#end

background{col_bgr}


//Axis uncomment to activate
//object{TOOLS_AXIS_XYZ(100,100,100 //texture{ pigment{rgb<1,0,0>} finish{diffuse 0.8 phong 1}}, //texture{ pigment{rgb<1,1,1>} finish{diffuse 0.8 phong 1}})}

light_source{<lgt1_pos_x,lgt1_pos_y,lgt1_pos_z> White*lgt1_intense}
light_source{<lgt2_pos_x,lgt2_pos_y,lgt2_pos_z> White*lgt2_intense}
light_source{<lgt3_pos_x,lgt3_pos_y,lgt3_pos_z> White*lgt3_intense}
light_source{<lgt4_pos_x,lgt4_pos_y,lgt4_pos_z> White*lgt4_intense}
#end


#macro HEADER(mac_x_ver,mac_y_ver,mac_z_ver,mac_x_rot,mac_y_rot,mac_z_rot)
union{
#if(pcb_board = on)
difference{
union{
//Board
prism{-1.500000,0.000000,10
<0.000000,0.000000><156.210000,0.000000>
<156.210000,0.000000><159.873000,0.020000>
<159.893000,0.000000><159.893000,50.724000>
<159.893000,50.724000><0.000000,50.724000>
<0.000000,50.724000><0.000000,0.000000>
texture{col_brd}}
}//End union(Platine)
//Holes(real)/Parts
cylinder{<3.810000,1,3.810000><3.810000,-5,3.810000>1.400000 texture{col_hls}}
cylinder{<3.810000,1,34.730000><3.810000,-5,34.730000>1.400000 texture{col_hls}}
cylinder{<78.730000,1,34.730000><78.730000,-5,34.730000>1.400000 texture{col_hls}}
cylinder{<78.730000,1,3.810000><78.730000,-5,3.810000>1.400000 texture{col_hls}}
//Holes(real)/Board
//Holes(real)/Vias
}//End difference(reale Bohrungen/Durchbrüche)
#end
#if(pcb_parts=on)//Parts
union{
#ifndef(pack_IC1) #declare global_pack_IC1=yes; object {IC_DIS_DIP28("MEGA8-P","ATMEL",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-270.000000,0> rotate<0,0,0> translate<92.710000,0.000000,27.940000>}#end		//DIP28 300mil IC1 MEGA8-P DIL28-3
#ifndef(pack_ISP1) #declare global_pack_ISP1=yes; object {PH_2MM_2X3("AVRISP-6",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<74.930000,0.000000,43.815000>}#end		// ISP1 AVRISP-6 AVRISP
#ifndef(pack_LED1) #declare global_pack_LED1=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<12.700000,0.000000,45.720000>}#end		//Diskrete 5MM LED LED1  LED5MM
#ifndef(pack_LED2) #declare global_pack_LED2=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<119.380000,0.000000,45.720000>}#end		//Diskrete 5MM LED LED2  LED5MM
#ifndef(pack_LED3) #declare global_pack_LED3=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<130.810000,0.000000,45.720000>}#end		//Diskrete 5MM LED LED3  LED5MM
#ifndef(pack_LED4) #declare global_pack_LED4=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<142.240000,0.000000,45.720000>}#end		//Diskrete 5MM LED LED4  LED5MM
#ifndef(pack_LED5) #declare global_pack_LED5=yes; object {DIODE_DIS_LED_5MM(White,0.500000,0.000000,)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<153.670000,0.000000,45.720000>}#end		//Diskrete 5MM LED LED5  LED5MM
#ifndef(pack_PWR) #declare global_pack_PWR=yes; object {PHW_1X2()translate<0,0,-3.8> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<156.845000,0.000000,1.270000>}#end		//Header 2,54MM Grid 90deg (con-lstb.lib) PWR  1X02/90
#ifndef(pack_R1) #declare global_pack_R1=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<6.350000,0.000000,40.640000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R1 10k 0207/7
#ifndef(pack_R2) #declare global_pack_R2=yes; object {RES_DIS_0207_075MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<17.780000,0.000000,40.640000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R2 220 0207/7
#ifndef(pack_R3) #declare global_pack_R3=yes; object {RES_DIS_0207_075MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<119.380000,0.000000,40.640000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R3 220 0207/7
#ifndef(pack_R4) #declare global_pack_R4=yes; object {RES_DIS_0207_075MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<130.810000,0.000000,40.640000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R4 220 0207/7
#ifndef(pack_R5) #declare global_pack_R5=yes; object {RES_DIS_0207_075MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<142.240000,0.000000,40.640000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R5 220 0207/7
#ifndef(pack_R6) #declare global_pack_R6=yes; object {RES_DIS_0207_075MM(texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{Red*0.7}finish{phong 0.2}},texture{pigment{DarkBrown}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-180.000000,0> rotate<0,0,0> translate<153.670000,0.000000,40.640000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R6 220 0207/7
#ifndef(pack_R7) #declare global_pack_R7=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<119.380000,0.000000,30.480000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R7 10k 0207/7
#ifndef(pack_R8) #declare global_pack_R8=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<130.810000,0.000000,30.480000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R8 10k 0207/7
#ifndef(pack_R9) #declare global_pack_R9=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<142.240000,0.000000,30.480000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R9 10k 0207/7
#ifndef(pack_R10) #declare global_pack_R10=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<153.670000,0.000000,30.480000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R10 10k 0207/7
#ifndef(pack_R11) #declare global_pack_R11=yes; object {RES_DIS_TRIM_72_PT("10k",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<59.055000,0.000000,43.815000>}#end		// R11 10k RS3
#ifndef(pack_R13) #declare global_pack_R13=yes; object {RES_DIS_0207_075MM(texture{pigment{DarkBrown}finish{phong 0.2}},texture{pigment{Black}finish{phong 0.2}},texture{pigment{Orange}finish{phong 0.2}},texture {T_Gold_5C finish{reflection 0.1}},)translate<0,0,0> rotate<0,0.000000,0>rotate<0,-90.000000,0> rotate<0,0,0> translate<82.550000,0.000000,43.815000>}#end		//Discrete Resistor 0,3W 7,5MM Grid R13 10k 0207/7
#ifndef(pack_S1) #declare global_pack_S1=yes; object {SWITCH_PUSH_BUTTON_LSH43("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<5.080000,0.000000,45.720000>}#end		// S1  TACTILE_SWITCH_SMD
#ifndef(pack_S2) #declare global_pack_S2=yes; object {SWITCH_PUSH_BUTTON_LSH43("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<119.380000,0.000000,35.560000>}#end		// S2  TACTILE_SWITCH_SMD
#ifndef(pack_S3) #declare global_pack_S3=yes; object {SWITCH_PUSH_BUTTON_LSH43("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<130.810000,0.000000,35.560000>}#end		// S3  TACTILE_SWITCH_SMD
#ifndef(pack_S4) #declare global_pack_S4=yes; object {SWITCH_PUSH_BUTTON_LSH43("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<142.240000,0.000000,35.560000>}#end		// S4  TACTILE_SWITCH_SMD
#ifndef(pack_S5) #declare global_pack_S5=yes; object {SWITCH_PUSH_BUTTON_LSH43("",)translate<0,0,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<153.670000,0.000000,35.560000>}#end		// S5  TACTILE_SWITCH_SMD
#ifndef(pack_X1) #declare global_pack_X1=yes; object {USER_LCD_16X2()translate<0,10,0> rotate<0,0.000000,0>rotate<0,0.000000,0> rotate<0,0,0> translate<1.270000,0.000000,1.270000>}#end		//USER_LCD_16X2     X1  LCD1602
}//End union
#end
#if(pcb_pads_smds=on)
//Pads&SMD/Parts
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<88.900000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,11.430000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,13.970000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,16.510000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,19.050000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,21.590000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,24.130000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,26.670000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,29.210000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,31.750000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,34.290000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,36.830000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,39.370000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,41.910000> texture{col_thl}}
#ifndef(global_pack_IC1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-0.000000,0>translate<96.520000,0,44.450000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<73.660000,0,46.355000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<76.200000,0,46.355000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<73.660000,0,43.815000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<76.200000,0,43.815000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<73.660000,0,41.275000> texture{col_thl}}
#ifndef(global_pack_ISP1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.625600,0.900000,1,16,1+global_tmp,0) rotate<0,-0.000000,0>translate<76.200000,0,41.275000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<11.430000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<118.110000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<120.650000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<129.540000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<132.080000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<140.970000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<143.510000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<152.400000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_LED5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.676400,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<154.940000,0,45.720000> texture{col_thl}}
#ifndef(global_pack_PWR) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<158.115000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_PWR) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.524000,1.016000,1,16,3+global_tmp,100) rotate<0,-270.000000,0>translate<155.575000,0,5.080000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<10.160000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<2.540000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<21.590000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R2) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<13.970000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<123.190000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R3) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<115.570000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<134.620000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R4) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<127.000000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<146.050000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R5) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<138.430000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<157.480000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R6) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-180.000000,0>translate<149.860000,0,40.640000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<115.570000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R7) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<123.190000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<127.000000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R8) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<134.620000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<138.430000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R9) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<146.050000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<149.860000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R10) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-0.000000,0>translate<157.480000,0,30.480000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<56.515000,0,46.355000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<61.595000,0,46.355000> texture{col_thl}}
#ifndef(global_pack_R11) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<59.055000,0,41.275000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<82.550000,0,40.005000> texture{col_thl}}
#ifndef(global_pack_R13) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.320800,0.812800,1,16,2+global_tmp,0) rotate<0,-90.000000,0>translate<82.550000,0,47.625000> texture{col_thl}}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<2.540000,0.000000,47.625000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<7.620000,0.000000,47.625000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<2.540000,0.000000,43.815000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<7.620000,0.000000,43.815000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<116.840000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<121.920000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<116.840000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<121.920000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<128.270000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<133.350000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<128.270000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<133.350000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<139.700000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<144.780000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<139.700000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<144.780000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<151.130000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<156.210000,0.000000,37.465000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<151.130000,0.000000,33.655000>}
object{TOOLS_PCB_SMD(0.762000,1.524000,0.037000,0) rotate<0,-90.000000,0> texture{col_pds} translate<156.210000,0.000000,33.655000>}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<9.270000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<11.810000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<14.350000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<16.890000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<19.430000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<21.970000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<24.510000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<27.050000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<29.590000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<32.130000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<34.670000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<37.210000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<39.750000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<42.290000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<44.830000,0,34.730000> texture{col_thl}}
#ifndef(global_pack_X1) #local global_tmp=0; #else #local global_tmp=100; #end object{TOOLS_PCB_VIA(1.308000,0.800000,1,16,3+global_tmp,100) rotate<0,-90.000000,0>translate<47.370000,0,34.730000> texture{col_thl}}
//Pads/Vias
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<157.480000,0,35.560000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<113.030000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<110.490000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<107.950000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<105.410000,0,33.020000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<74.930000,0,30.480000> texture{col_thl}}
object{TOOLS_PCB_VIA(0.914400,0.508000,1,16,1,0) translate<68.580000,0,46.355000> texture{col_thl}}
#end
#if(pcb_wires=on)
union{
//Signals
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<0.635000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<0.635000,0.000000,48.260000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,90.000000,0> translate<0.635000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<0.635000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.905000,0.000000,43.815000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<0.635000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<0.635000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.905000,0.000000,49.530000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<0.635000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.905000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,0.000000,43.815000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,0.000000,0> translate<1.905000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,0.000000,43.815000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,90.000000,0> translate<2.540000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,0.000000,43.815000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<2.540000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<2.540000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,0.000000,47.625000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<2.540000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<7.620000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,0.000000,47.625000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<7.620000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.270000,-1.535000,30.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.270000,-1.535000,34.730000>}
box{<0,0,-0.254000><4.630000,0.035000,0.254000> rotate<0,90.000000,0> translate<9.270000,-1.535000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<8.890000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.525000,0.000000,46.990000>}
box{<0,0,-0.254000><0.898026,0.035000,0.254000> rotate<0,44.997030,0> translate<8.890000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.525000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.525000,0.000000,46.990000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,90.000000,0> translate<9.525000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.270000,-1.535000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,35.620000>}
box{<0,0,-0.254000><1.258650,0.035000,0.254000> rotate<0,-44.997030,0> translate<9.270000,-1.535000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,35.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,40.640000>}
box{<0,0,-0.254000><5.020000,0.035000,0.254000> rotate<0,90.000000,0> translate<10.160000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.270000,-1.535000,30.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.795000,-1.535000,28.575000>}
box{<0,0,-0.254000><2.156676,0.035000,0.254000> rotate<0,44.997030,0> translate<9.270000,-1.535000,30.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.160000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,41.910000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<10.160000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.430000,-1.535000,45.720000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,90.000000,0> translate<11.430000,-1.535000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<9.525000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.810000,0.000000,42.800000>}
box{<0,0,-0.254000><3.231478,0.035000,0.254000> rotate<0,44.997030,0> translate<9.525000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.810000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.810000,0.000000,42.800000>}
box{<0,0,-0.254000><8.070000,0.035000,0.254000> rotate<0,90.000000,0> translate<11.810000,0.000000,42.800000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<13.970000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<13.970000,0.000000,40.640000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,-90.000000,0> translate<13.970000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<14.350000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<14.350000,0.000000,35.940000>}
box{<0,0,-0.254000><1.210000,0.035000,0.254000> rotate<0,90.000000,0> translate<14.350000,0.000000,35.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<11.810000,-1.535000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.180000,-1.535000,38.100000>}
box{<0,0,-0.254000><4.765900,0.035000,0.254000> rotate<0,-44.997030,0> translate<11.810000,-1.535000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<14.350000,0.000000,35.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.875000,0.000000,37.465000>}
box{<0,0,-0.254000><2.156676,0.035000,0.254000> rotate<0,-44.997030,0> translate<14.350000,0.000000,35.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.890000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.890000,0.000000,25.655000>}
box{<0,0,-0.254000><9.075000,0.035000,0.254000> rotate<0,-90.000000,0> translate<16.890000,0.000000,25.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<10.795000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,28.575000>}
box{<0,0,-0.254000><6.985000,0.035000,0.254000> rotate<0,0.000000,0> translate<10.795000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<17.780000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.430000,-1.535000,30.225000>}
box{<0,0,-0.254000><2.333452,0.035000,0.254000> rotate<0,-44.997030,0> translate<17.780000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.430000,-1.535000,30.225000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.430000,-1.535000,34.730000>}
box{<0,0,-0.254000><4.505000,0.035000,0.254000> rotate<0,90.000000,0> translate<19.430000,-1.535000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<19.430000,-1.535000,30.225000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.080000,-1.535000,28.575000>}
box{<0,0,-0.254000><2.333452,0.035000,0.254000> rotate<0,44.997030,0> translate<19.430000,-1.535000,30.225000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.970000,0.000000,22.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.970000,0.000000,34.730000>}
box{<0,0,-0.254000><12.250000,0.035000,0.254000> rotate<0,90.000000,0> translate<21.970000,0.000000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.670000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.670000,0.000000,23.115000>}
box{<0,0,-0.254000><11.615000,0.035000,0.254000> rotate<0,-90.000000,0> translate<34.670000,0.000000,23.115000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<16.890000,0.000000,25.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.925000,0.000000,7.620000>}
box{<0,0,-0.254000><25.505342,0.035000,0.254000> rotate<0,44.997030,0> translate<16.890000,0.000000,25.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.970000,0.000000,22.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,0.000000,8.890000>}
box{<0,0,-0.254000><19.219162,0.035000,0.254000> rotate<0,44.997030,0> translate<21.970000,0.000000,22.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.210000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.210000,0.000000,25.020000>}
box{<0,0,-0.254000><9.710000,0.035000,0.254000> rotate<0,-90.000000,0> translate<37.210000,0.000000,25.020000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.750000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.750000,0.000000,25.655000>}
box{<0,0,-0.254000><9.075000,0.035000,0.254000> rotate<0,-90.000000,0> translate<39.750000,0.000000,25.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.180000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,38.100000>}
box{<0,0,-0.254000><26.730000,0.035000,0.254000> rotate<0,0.000000,0> translate<15.180000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<42.290000,0.000000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<42.290000,0.000000,26.925000>}
box{<0,0,-0.254000><7.805000,0.035000,0.254000> rotate<0,-90.000000,0> translate<42.290000,0.000000,26.925000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.830000,-1.535000,35.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.830000,-1.535000,34.730000>}
box{<0,0,-0.254000><0.450000,0.035000,0.254000> rotate<0,-90.000000,0> translate<44.830000,-1.535000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<41.910000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.830000,-1.535000,35.180000>}
box{<0,0,-0.254000><4.129504,0.035000,0.254000> rotate<0,44.997030,0> translate<41.910000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.830000,-1.535000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.830000,-1.535000,46.735000>}
box{<0,0,-0.254000><12.005000,0.035000,0.254000> rotate<0,90.000000,0> translate<44.830000,-1.535000,46.735000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.080000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<45.720000,-1.535000,28.575000>}
box{<0,0,-0.254000><24.640000,0.035000,0.254000> rotate<0,0.000000,0> translate<21.080000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.670000,0.000000,23.115000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.355000,0.000000,11.430000>}
box{<0,0,-0.254000><16.525085,0.035000,0.254000> rotate<0,44.997030,0> translate<34.670000,0.000000,23.115000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<44.830000,-1.535000,46.735000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.990000,-1.535000,48.895000>}
box{<0,0,-0.254000><3.054701,0.035000,0.254000> rotate<0,-44.997030,0> translate<44.830000,-1.535000,46.735000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<45.720000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.370000,-1.535000,30.225000>}
box{<0,0,-0.254000><2.333452,0.035000,0.254000> rotate<0,-44.997030,0> translate<45.720000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.370000,-1.535000,30.225000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.370000,-1.535000,34.730000>}
box{<0,0,-0.254000><4.505000,0.035000,0.254000> rotate<0,90.000000,0> translate<47.370000,-1.535000,34.730000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.370000,-1.535000,34.730000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.370000,-1.535000,43.560000>}
box{<0,0,-0.254000><8.830000,0.035000,0.254000> rotate<0,90.000000,0> translate<47.370000,-1.535000,43.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<37.210000,0.000000,25.020000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.260000,0.000000,13.970000>}
box{<0,0,-0.254000><15.627060,0.035000,0.254000> rotate<0,44.997030,0> translate<37.210000,0.000000,25.020000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<39.750000,0.000000,25.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.895000,0.000000,16.510000>}
box{<0,0,-0.254000><12.932983,0.035000,0.254000> rotate<0,44.997030,0> translate<39.750000,0.000000,25.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<42.290000,0.000000,26.925000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.165000,0.000000,19.050000>}
box{<0,0,-0.254000><11.136932,0.035000,0.254000> rotate<0,44.997030,0> translate<42.290000,0.000000,26.925000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<21.590000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.165000,0.000000,40.640000>}
box{<0,0,-0.254000><28.575000,0.035000,0.254000> rotate<0,0.000000,0> translate<21.590000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<47.370000,-1.535000,43.560000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.165000,-1.535000,46.355000>}
box{<0,0,-0.254000><3.952727,0.035000,0.254000> rotate<0,-44.997030,0> translate<47.370000,-1.535000,43.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.165000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,0.000000,43.815000>}
box{<0,0,-0.254000><4.490128,0.035000,0.254000> rotate<0,-44.997030,0> translate<50.165000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<15.875000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<55.245000,0.000000,37.465000>}
box{<0,0,-0.254000><39.370000,0.035000,0.254000> rotate<0,0.000000,0> translate<15.875000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.165000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<56.515000,-1.535000,46.355000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<50.165000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<56.515000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.785000,-1.535000,46.355000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<56.515000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<55.245000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.055000,0.000000,41.275000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<55.245000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.990000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.055000,-1.535000,48.895000>}
box{<0,0,-0.254000><12.065000,0.035000,0.254000> rotate<0,0.000000,0> translate<46.990000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<53.340000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<61.595000,0.000000,43.815000>}
box{<0,0,-0.254000><8.255000,0.035000,0.254000> rotate<0,0.000000,0> translate<53.340000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<59.055000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<61.595000,-1.535000,46.355000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<59.055000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<61.595000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.135000,-1.535000,48.895000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<61.595000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<57.785000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<65.405000,-1.535000,38.735000>}
box{<0,0,-0.254000><10.776307,0.035000,0.254000> rotate<0,44.997030,0> translate<57.785000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,0.000000,42.545000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<67.310000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,43.180000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,-90.000000,0> translate<68.580000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.215000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.215000,0.000000,40.005000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,-90.000000,0> translate<69.215000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<70.485000,-1.535000,41.275000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,44.997030,0> translate<68.580000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<68.580000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<70.485000,0.000000,48.260000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,-44.997030,0> translate<68.580000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,0.000000,39.370000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,-90.000000,0> translate<71.120000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,0.000000,46.355000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,-44.997030,0> translate<67.310000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.215000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,0.000000,45.085000>}
box{<0,0,-0.254000><4.490128,0.035000,0.254000> rotate<0,-44.997030,0> translate<69.215000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<70.485000,-1.535000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<73.660000,-1.535000,41.275000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,0.000000,0> translate<70.485000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<73.660000,0.000000,43.815000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<71.120000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<73.660000,0.000000,46.355000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<71.120000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<61.595000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,0.000000,30.480000>}
box{<0,0,-0.254000><18.858538,0.035000,0.254000> rotate<0,44.997030,0> translate<61.595000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<72.390000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,0.000000,45.085000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<72.390000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<64.135000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,-1.535000,48.895000>}
box{<0,0,-0.254000><10.795000,0.035000,0.254000> rotate<0,0.000000,0> translate<64.135000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<65.405000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<75.565000,-1.535000,38.735000>}
box{<0,0,-0.254000><10.160000,0.035000,0.254000> rotate<0,0.000000,0> translate<65.405000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<75.565000,-1.535000,38.735000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,39.370000>}
box{<0,0,-0.254000><0.898026,0.035000,0.254000> rotate<0,-44.997030,0> translate<75.565000,-1.535000,38.735000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,41.275000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,90.000000,0> translate<76.200000,-1.535000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,0.000000,43.815000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<74.930000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,46.355000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<76.200000,-1.535000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,-1.535000,48.895000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,-1.535000,47.625000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<74.930000,-1.535000,48.895000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<70.485000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<78.740000,0.000000,48.260000>}
box{<0,0,-0.254000><8.255000,0.035000,0.254000> rotate<0,0.000000,0> translate<70.485000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<79.375000,0.000000,46.355000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,0.000000,0> translate<76.200000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<78.740000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<79.375000,0.000000,47.625000>}
box{<0,0,-0.254000><0.898026,0.035000,0.254000> rotate<0,44.997030,0> translate<78.740000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.645000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.645000,0.000000,41.275000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,-90.000000,0> translate<80.645000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<79.375000,0.000000,46.355000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.645000,0.000000,45.085000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<79.375000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<80.645000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.915000,0.000000,40.005000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<80.645000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<81.915000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<82.550000,0.000000,40.005000>}
box{<0,0,-0.254000><0.635000,0.035000,0.254000> rotate<0,0.000000,0> translate<81.915000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<79.375000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<82.550000,0.000000,47.625000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,0.000000,0> translate<79.375000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<82.550000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<83.820000,0.000000,40.005000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<82.550000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<84.455000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<84.455000,0.000000,27.940000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,-90.000000,0> translate<84.455000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<76.200000,0.000000,41.275000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<84.455000,0.000000,33.020000>}
box{<0,0,-0.254000><11.674333,0.035000,0.254000> rotate<0,44.997030,0> translate<76.200000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<71.120000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.090000,0.000000,25.400000>}
box{<0,0,-0.254000><19.756563,0.035000,0.254000> rotate<0,44.997030,0> translate<71.120000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<84.455000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,26.670000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<84.455000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,30.480000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,-90.000000,0> translate<85.725000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<83.820000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,38.100000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,44.997030,0> translate<83.820000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<82.550000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,47.625000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,0.000000,0> translate<82.550000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<69.215000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.360000,0.000000,22.860000>}
box{<0,0,-0.254000><24.246692,0.035000,0.254000> rotate<0,44.997030,0> translate<69.215000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<67.310000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.995000,0.000000,20.320000>}
box{<0,0,-0.254000><27.838794,0.035000,0.254000> rotate<0,44.997030,0> translate<67.310000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.995000,0.000000,29.210000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<85.725000,0.000000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<46.355000,0.000000,11.430000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,11.430000>}
box{<0,0,-0.254000><42.545000,0.035000,0.254000> rotate<0,0.000000,0> translate<46.355000,0.000000,11.430000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.260000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,13.970000>}
box{<0,0,-0.254000><40.640000,0.035000,0.254000> rotate<0,0.000000,0> translate<48.260000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<48.895000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,16.510000>}
box{<0,0,-0.254000><40.005000,0.035000,0.254000> rotate<0,0.000000,0> translate<48.895000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<50.165000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,19.050000>}
box{<0,0,-0.254000><38.735000,0.035000,0.254000> rotate<0,0.000000,0> translate<50.165000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,26.670000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,0.000000,0> translate<85.725000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.995000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,29.210000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,0.000000,0> translate<86.995000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.725000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,44.450000>}
box{<0,0,-0.254000><4.490128,0.035000,0.254000> rotate<0,44.997030,0> translate<85.725000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<1.905000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<89.535000,0.000000,49.530000>}
box{<0,0,-0.254000><87.630000,0.035000,0.254000> rotate<0,0.000000,0> translate<1.905000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.900000,-1.535000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,33.020000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<88.900000,-1.535000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.900000,-1.535000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,35.560000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<88.900000,-1.535000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.900000,-1.535000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,38.100000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<88.900000,-1.535000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<88.900000,-1.535000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,40.640000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,-44.997030,0> translate<88.900000,-1.535000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<90.805000,0.000000,41.910000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,0.000000,0> translate<88.900000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<85.090000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,0.000000,25.400000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<85.090000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,26.670000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<88.900000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<88.900000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,0.000000,29.210000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<88.900000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.360000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.075000,0.000000,22.860000>}
box{<0,0,-0.254000><5.715000,0.035000,0.254000> rotate<0,0.000000,0> translate<86.360000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<90.805000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.075000,0.000000,43.180000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<90.805000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.075000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.075000,0.000000,43.180000>}
box{<0,0,-0.254000><3.810000,0.035000,0.254000> rotate<0,-90.000000,0> translate<92.075000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<89.535000,0.000000,49.530000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.075000,0.000000,46.990000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<89.535000,0.000000,49.530000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<86.995000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.710000,0.000000,20.320000>}
box{<0,0,-0.254000><5.715000,0.035000,0.254000> rotate<0,0.000000,0> translate<86.995000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<35.560000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,0.000000,8.890000>}
box{<0,0,-0.254000><58.420000,0.035000,0.254000> rotate<0,0.000000,0> translate<35.560000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.710000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,0.000000,19.050000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<92.710000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,0.000000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,0.000000,26.670000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<91.440000,0.000000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,-1.535000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,29.210000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<91.440000,-1.535000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<92.075000,0.000000,22.860000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<94.615000,0.000000,20.320000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<92.075000,0.000000,22.860000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<91.440000,0.000000,25.400000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<95.250000,0.000000,21.590000>}
box{<0,0,-0.254000><5.388154,0.035000,0.254000> rotate<0,44.997030,0> translate<91.440000,0.000000,25.400000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<74.930000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<95.250000,-1.535000,30.480000>}
box{<0,0,-0.254000><20.320000,0.035000,0.254000> rotate<0,0.000000,0> translate<74.930000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,0.000000,8.890000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,11.430000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<93.980000,0.000000,8.890000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,0.000000,19.050000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,19.050000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<93.980000,0.000000,19.050000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<95.250000,0.000000,21.590000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,21.590000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,0.000000,0> translate<95.250000,0.000000,21.590000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,26.670000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<93.980000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<93.980000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,-1.535000,29.210000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<93.980000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<95.250000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,-1.535000,31.750000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<95.250000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<34.925000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<97.155000,0.000000,7.620000>}
box{<0,0,-0.254000><62.230000,0.035000,0.254000> rotate<0,0.000000,0> translate<34.925000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,0.000000,16.510000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<96.520000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<94.615000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,0.000000,20.320000>}
box{<0,0,-0.254000><4.445000,0.035000,0.254000> rotate<0,0.000000,0> translate<94.615000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,-1.535000,29.210000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,0.000000,0> translate<96.520000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.520000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,34.290000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<96.520000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.520000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,36.830000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<96.520000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.520000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,39.370000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<96.520000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<96.520000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,41.910000>}
box{<0,0,-0.203200><2.540000,0.035000,0.203200> rotate<0,0.000000,0> translate<96.520000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.695000,0.000000,13.970000>}
box{<0,0,-0.254000><3.175000,0.035000,0.254000> rotate<0,0.000000,0> translate<96.520000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,0.000000,16.510000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.695000,0.000000,17.145000>}
box{<0,0,-0.254000><0.898026,0.035000,0.254000> rotate<0,-44.997030,0> translate<99.060000,0.000000,16.510000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.695000,0.000000,19.685000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.695000,0.000000,17.145000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,-90.000000,0> translate<99.695000,0.000000,17.145000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,0.000000,20.320000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.695000,0.000000,19.685000>}
box{<0,0,-0.254000><0.898026,0.035000,0.254000> rotate<0,44.997030,0> translate<99.060000,0.000000,20.320000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<97.155000,0.000000,7.620000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<100.330000,0.000000,10.795000>}
box{<0,0,-0.254000><4.490128,0.035000,0.254000> rotate<0,-44.997030,0> translate<97.155000,0.000000,7.620000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.695000,0.000000,13.970000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<100.330000,0.000000,13.335000>}
box{<0,0,-0.254000><0.898026,0.035000,0.254000> rotate<0,44.997030,0> translate<99.695000,0.000000,13.970000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<100.330000,0.000000,10.795000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<100.330000,0.000000,13.335000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<100.330000,0.000000,13.335000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<99.060000,-1.535000,29.210000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<100.330000,-1.535000,30.480000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<99.060000,-1.535000,29.210000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,41.910000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,0.000000,44.450000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,-44.997030,0> translate<99.060000,0.000000,41.910000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,39.370000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<103.505000,0.000000,43.815000>}
box{<0,0,-0.203200><6.286179,0.035000,0.203200> rotate<0,-44.997030,0> translate<99.060000,0.000000,39.370000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,33.020000>}
box{<0,0,-0.203200><15.240000,0.035000,0.203200> rotate<0,0.000000,0> translate<90.170000,-1.535000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,35.560000>}
box{<0,0,-0.203200><15.240000,0.035000,0.203200> rotate<0,0.000000,0> translate<90.170000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,38.100000>}
box{<0,0,-0.203200><15.240000,0.035000,0.203200> rotate<0,0.000000,0> translate<90.170000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<90.170000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,40.640000>}
box{<0,0,-0.203200><15.240000,0.035000,0.203200> rotate<0,0.000000,0> translate<90.170000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,0.000000,43.180000>}
box{<0,0,-0.203200><8.980256,0.035000,0.203200> rotate<0,-44.997030,0> translate<99.060000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<96.520000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<107.315000,0.000000,37.465000>}
box{<0,0,-0.254000><15.266435,0.035000,0.254000> rotate<0,-44.997030,0> translate<96.520000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<99.060000,0.000000,34.290000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<107.315000,0.000000,42.545000>}
box{<0,0,-0.203200><11.674333,0.035000,0.203200> rotate<0,-44.997030,0> translate<99.060000,0.000000,34.290000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<107.950000,-1.535000,33.020000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<105.410000,-1.535000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<108.585000,0.000000,36.195000>}
box{<0,0,-0.203200><4.490128,0.035000,0.203200> rotate<0,-44.997030,0> translate<105.410000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,38.100000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<110.490000,-1.535000,33.020000>}
box{<0,0,-0.203200><7.184205,0.035000,0.203200> rotate<0,44.997030,0> translate<105.410000,-1.535000,38.100000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<107.950000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<110.490000,0.000000,35.560000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,-44.997030,0> translate<107.950000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<110.490000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<112.395000,0.000000,34.925000>}
box{<0,0,-0.203200><2.694077,0.035000,0.203200> rotate<0,-44.997030,0> translate<110.490000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<113.030000,-1.535000,33.020000>}
box{<0,0,-0.203200><10.776307,0.035000,0.203200> rotate<0,44.997030,0> translate<105.410000,-1.535000,40.640000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<113.030000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<113.665000,0.000000,33.655000>}
box{<0,0,-0.203200><0.898026,0.035000,0.203200> rotate<0,-44.997030,0> translate<113.030000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<100.330000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<115.570000,-1.535000,30.480000>}
box{<0,0,-0.254000><15.240000,0.035000,0.254000> rotate<0,0.000000,0> translate<100.330000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<115.570000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<115.570000,-1.535000,43.180000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<115.570000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<113.665000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<116.840000,0.000000,33.655000>}
box{<0,0,-0.203200><3.175000,0.035000,0.203200> rotate<0,0.000000,0> translate<113.665000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<107.315000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<116.840000,0.000000,37.465000>}
box{<0,0,-0.254000><9.525000,0.035000,0.254000> rotate<0,0.000000,0> translate<107.315000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<115.570000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<117.475000,-1.535000,28.575000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,44.997030,0> translate<115.570000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<115.570000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<118.110000,-1.535000,45.720000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<115.570000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<120.650000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<120.650000,0.000000,45.720000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<120.650000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<107.315000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<121.285000,0.000000,42.545000>}
box{<0,0,-0.203200><13.970000,0.035000,0.203200> rotate<0,0.000000,0> translate<107.315000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,31.750000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,-90.000000,0> translate<121.920000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<116.840000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,33.655000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<116.840000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<116.840000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,37.465000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<116.840000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<120.650000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,48.260000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<120.650000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<123.190000,0.000000,30.480000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<121.920000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<121.285000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<123.190000,0.000000,40.640000>}
box{<0,0,-0.203200><2.694077,0.035000,0.203200> rotate<0,44.997030,0> translate<121.285000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<117.475000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<125.095000,-1.535000,28.575000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,0.000000,0> translate<117.475000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<125.095000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<127.000000,-1.535000,30.480000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,-44.997030,0> translate<125.095000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<112.395000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<127.000000,0.000000,34.925000>}
box{<0,0,-0.203200><14.605000,0.035000,0.203200> rotate<0,0.000000,0> translate<112.395000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<127.000000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<127.000000,-1.535000,43.180000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<127.000000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<127.000000,0.000000,34.925000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<128.270000,0.000000,33.655000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<127.000000,0.000000,34.925000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<128.270000,0.000000,37.465000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<121.920000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<127.000000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<128.905000,-1.535000,28.575000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,44.997030,0> translate<127.000000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<127.000000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<129.540000,-1.535000,45.720000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<127.000000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<121.920000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<130.810000,0.000000,48.260000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<121.920000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<105.410000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<132.080000,0.000000,43.180000>}
box{<0,0,-0.203200><26.670000,0.035000,0.203200> rotate<0,0.000000,0> translate<105.410000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<132.080000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<132.080000,0.000000,45.720000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<132.080000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<130.810000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<132.080000,0.000000,46.990000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<130.810000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,31.750000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,-90.000000,0> translate<133.350000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<128.270000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,33.655000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<128.270000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<128.270000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,37.465000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<128.270000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<132.080000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,48.260000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<132.080000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<134.620000,0.000000,30.480000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<133.350000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<132.080000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<134.620000,0.000000,40.640000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<132.080000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<128.905000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<136.525000,-1.535000,28.575000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,0.000000,0> translate<128.905000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<110.490000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<137.795000,0.000000,35.560000>}
box{<0,0,-0.203200><27.305000,0.035000,0.203200> rotate<0,0.000000,0> translate<110.490000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<136.525000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<138.430000,-1.535000,30.480000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,-44.997030,0> translate<136.525000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<138.430000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<138.430000,-1.535000,43.180000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<138.430000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<137.795000,0.000000,35.560000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<139.700000,0.000000,33.655000>}
box{<0,0,-0.203200><2.694077,0.035000,0.203200> rotate<0,44.997030,0> translate<137.795000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<139.700000,0.000000,37.465000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<133.350000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<138.430000,-1.535000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<140.335000,-1.535000,28.575000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,44.997030,0> translate<138.430000,-1.535000,30.480000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<138.430000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<140.970000,-1.535000,45.720000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<138.430000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<133.350000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<142.240000,0.000000,48.260000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<133.350000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<103.505000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<142.875000,0.000000,43.815000>}
box{<0,0,-0.203200><39.370000,0.035000,0.203200> rotate<0,0.000000,0> translate<103.505000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<143.510000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<143.510000,0.000000,45.720000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,-90.000000,0> translate<143.510000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<142.240000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<143.510000,0.000000,46.990000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<142.240000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,31.750000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,-90.000000,0> translate<144.780000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<139.700000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,33.655000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<139.700000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<139.700000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,37.465000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<139.700000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<143.510000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,48.260000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<143.510000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<146.050000,0.000000,30.480000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<144.780000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<142.875000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<146.050000,0.000000,40.640000>}
box{<0,0,-0.203200><4.490128,0.035000,0.203200> rotate<0,44.997030,0> translate<142.875000,0.000000,43.815000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<140.335000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<147.955000,-1.535000,28.575000>}
box{<0,0,-0.254000><7.620000,0.035000,0.254000> rotate<0,0.000000,0> translate<140.335000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<108.585000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<148.590000,0.000000,36.195000>}
box{<0,0,-0.203200><40.005000,0.035000,0.203200> rotate<0,0.000000,0> translate<108.585000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,0.000000,27.940000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,-90.000000,0> translate<149.860000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<147.955000,-1.535000,28.575000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,-1.535000,30.480000>}
box{<0,0,-0.254000><2.694077,0.035000,0.254000> rotate<0,-44.997030,0> translate<147.955000,-1.535000,28.575000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,-1.535000,40.640000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,-1.535000,43.180000>}
box{<0,0,-0.254000><2.540000,0.035000,0.254000> rotate<0,90.000000,0> translate<149.860000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<151.130000,0.000000,26.670000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<149.860000,0.000000,27.940000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<148.590000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<151.130000,0.000000,33.655000>}
box{<0,0,-0.203200><3.592102,0.035000,0.203200> rotate<0,44.997030,0> translate<148.590000,0.000000,36.195000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<151.130000,0.000000,37.465000>}
box{<0,0,-0.254000><6.350000,0.035000,0.254000> rotate<0,0.000000,0> translate<144.780000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<149.860000,-1.535000,43.180000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<152.400000,-1.535000,45.720000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,-44.997030,0> translate<149.860000,-1.535000,43.180000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<101.600000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<153.670000,0.000000,44.450000>}
box{<0,0,-0.203200><52.070000,0.035000,0.203200> rotate<0,0.000000,0> translate<101.600000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<144.780000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<153.670000,0.000000,48.260000>}
box{<0,0,-0.254000><8.890000,0.035000,0.254000> rotate<0,0.000000,0> translate<144.780000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<153.670000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<154.940000,0.000000,46.990000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<153.670000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<154.940000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<154.940000,0.000000,46.990000>}
box{<0,0,-0.254000><1.270000,0.035000,0.254000> rotate<0,90.000000,0> translate<154.940000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<155.575000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<155.575000,-1.535000,5.080000>}
box{<0,0,-0.203200><28.575000,0.035000,0.203200> rotate<0,-90.000000,0> translate<155.575000,-1.535000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.210000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.210000,0.000000,31.750000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,-90.000000,0> translate<156.210000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<151.130000,0.000000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.210000,0.000000,33.655000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<151.130000,0.000000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<151.130000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.210000,0.000000,37.465000>}
box{<0,0,-0.254000><5.080000,0.035000,0.254000> rotate<0,0.000000,0> translate<151.130000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<154.940000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.845000,0.000000,45.720000>}
box{<0,0,-0.254000><1.905000,0.035000,0.254000> rotate<0,0.000000,0> translate<154.940000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.210000,0.000000,31.750000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<157.480000,0.000000,30.480000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,44.997030,0> translate<156.210000,0.000000,31.750000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<155.575000,-1.535000,33.655000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<157.480000,-1.535000,35.560000>}
box{<0,0,-0.203200><2.694077,0.035000,0.203200> rotate<0,-44.997030,0> translate<155.575000,-1.535000,33.655000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<157.480000,0.000000,36.195000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<157.480000,0.000000,35.560000>}
box{<0,0,-0.203200><0.635000,0.035000,0.203200> rotate<0,-90.000000,0> translate<157.480000,0.000000,35.560000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<156.210000,0.000000,37.465000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<157.480000,0.000000,36.195000>}
box{<0,0,-0.203200><1.796051,0.035000,0.203200> rotate<0,44.997030,0> translate<156.210000,0.000000,37.465000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<153.670000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<157.480000,0.000000,40.640000>}
box{<0,0,-0.203200><5.388154,0.035000,0.203200> rotate<0,44.997030,0> translate<153.670000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<158.115000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.203200 translate<158.115000,0.000000,5.080000>}
box{<0,0,-0.203200><21.590000,0.035000,0.203200> rotate<0,-90.000000,0> translate<158.115000,0.000000,5.080000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<151.130000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<158.115000,0.000000,26.670000>}
box{<0,0,-0.254000><6.985000,0.035000,0.254000> rotate<0,0.000000,0> translate<151.130000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<158.115000,0.000000,26.670000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<159.385000,0.000000,27.940000>}
box{<0,0,-0.254000><1.796051,0.035000,0.254000> rotate<0,-44.997030,0> translate<158.115000,0.000000,26.670000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<156.845000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<159.385000,0.000000,43.180000>}
box{<0,0,-0.254000><3.592102,0.035000,0.254000> rotate<0,44.997030,0> translate<156.845000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<159.385000,0.000000,27.940000>}
cylinder{<0,0,0><0,0.035000,0>0.254000 translate<159.385000,0.000000,43.180000>}
box{<0,0,-0.254000><15.240000,0.035000,0.254000> rotate<0,90.000000,0> translate<159.385000,0.000000,43.180000> }
//Text
//Rect
union{
texture{col_pds}
}
texture{col_wrs}
}
#end
#if(pcb_polygons=on)
union{
//Polygons
texture{col_pol}
}
#end
union{
cylinder{<88.900000,0.038000,44.450000><88.900000,-1.538000,44.450000>0.406400}
cylinder{<88.900000,0.038000,41.910000><88.900000,-1.538000,41.910000>0.406400}
cylinder{<88.900000,0.038000,39.370000><88.900000,-1.538000,39.370000>0.406400}
cylinder{<88.900000,0.038000,36.830000><88.900000,-1.538000,36.830000>0.406400}
cylinder{<88.900000,0.038000,34.290000><88.900000,-1.538000,34.290000>0.406400}
cylinder{<88.900000,0.038000,31.750000><88.900000,-1.538000,31.750000>0.406400}
cylinder{<88.900000,0.038000,29.210000><88.900000,-1.538000,29.210000>0.406400}
cylinder{<88.900000,0.038000,26.670000><88.900000,-1.538000,26.670000>0.406400}
cylinder{<88.900000,0.038000,24.130000><88.900000,-1.538000,24.130000>0.406400}
cylinder{<88.900000,0.038000,21.590000><88.900000,-1.538000,21.590000>0.406400}
cylinder{<88.900000,0.038000,19.050000><88.900000,-1.538000,19.050000>0.406400}
cylinder{<88.900000,0.038000,16.510000><88.900000,-1.538000,16.510000>0.406400}
cylinder{<88.900000,0.038000,13.970000><88.900000,-1.538000,13.970000>0.406400}
cylinder{<88.900000,0.038000,11.430000><88.900000,-1.538000,11.430000>0.406400}
cylinder{<96.520000,0.038000,11.430000><96.520000,-1.538000,11.430000>0.406400}
cylinder{<96.520000,0.038000,13.970000><96.520000,-1.538000,13.970000>0.406400}
cylinder{<96.520000,0.038000,16.510000><96.520000,-1.538000,16.510000>0.406400}
cylinder{<96.520000,0.038000,19.050000><96.520000,-1.538000,19.050000>0.406400}
cylinder{<96.520000,0.038000,21.590000><96.520000,-1.538000,21.590000>0.406400}
cylinder{<96.520000,0.038000,24.130000><96.520000,-1.538000,24.130000>0.406400}
cylinder{<96.520000,0.038000,26.670000><96.520000,-1.538000,26.670000>0.406400}
cylinder{<96.520000,0.038000,29.210000><96.520000,-1.538000,29.210000>0.406400}
cylinder{<96.520000,0.038000,31.750000><96.520000,-1.538000,31.750000>0.406400}
cylinder{<96.520000,0.038000,34.290000><96.520000,-1.538000,34.290000>0.406400}
cylinder{<96.520000,0.038000,36.830000><96.520000,-1.538000,36.830000>0.406400}
cylinder{<96.520000,0.038000,39.370000><96.520000,-1.538000,39.370000>0.406400}
cylinder{<96.520000,0.038000,41.910000><96.520000,-1.538000,41.910000>0.406400}
cylinder{<96.520000,0.038000,44.450000><96.520000,-1.538000,44.450000>0.406400}
cylinder{<73.660000,0.038000,46.355000><73.660000,-1.538000,46.355000>0.450000}
cylinder{<76.200000,0.038000,46.355000><76.200000,-1.538000,46.355000>0.450000}
cylinder{<73.660000,0.038000,43.815000><73.660000,-1.538000,43.815000>0.450000}
cylinder{<76.200000,0.038000,43.815000><76.200000,-1.538000,43.815000>0.450000}
cylinder{<73.660000,0.038000,41.275000><73.660000,-1.538000,41.275000>0.450000}
cylinder{<76.200000,0.038000,41.275000><76.200000,-1.538000,41.275000>0.450000}
cylinder{<13.970000,0.038000,45.720000><13.970000,-1.538000,45.720000>0.406400}
cylinder{<11.430000,0.038000,45.720000><11.430000,-1.538000,45.720000>0.406400}
cylinder{<118.110000,0.038000,45.720000><118.110000,-1.538000,45.720000>0.406400}
cylinder{<120.650000,0.038000,45.720000><120.650000,-1.538000,45.720000>0.406400}
cylinder{<129.540000,0.038000,45.720000><129.540000,-1.538000,45.720000>0.406400}
cylinder{<132.080000,0.038000,45.720000><132.080000,-1.538000,45.720000>0.406400}
cylinder{<140.970000,0.038000,45.720000><140.970000,-1.538000,45.720000>0.406400}
cylinder{<143.510000,0.038000,45.720000><143.510000,-1.538000,45.720000>0.406400}
cylinder{<152.400000,0.038000,45.720000><152.400000,-1.538000,45.720000>0.406400}
cylinder{<154.940000,0.038000,45.720000><154.940000,-1.538000,45.720000>0.406400}
cylinder{<158.115000,0.038000,5.080000><158.115000,-1.538000,5.080000>0.508000}
cylinder{<155.575000,0.038000,5.080000><155.575000,-1.538000,5.080000>0.508000}
cylinder{<10.160000,0.038000,40.640000><10.160000,-1.538000,40.640000>0.406400}
cylinder{<2.540000,0.038000,40.640000><2.540000,-1.538000,40.640000>0.406400}
cylinder{<21.590000,0.038000,40.640000><21.590000,-1.538000,40.640000>0.406400}
cylinder{<13.970000,0.038000,40.640000><13.970000,-1.538000,40.640000>0.406400}
cylinder{<123.190000,0.038000,40.640000><123.190000,-1.538000,40.640000>0.406400}
cylinder{<115.570000,0.038000,40.640000><115.570000,-1.538000,40.640000>0.406400}
cylinder{<134.620000,0.038000,40.640000><134.620000,-1.538000,40.640000>0.406400}
cylinder{<127.000000,0.038000,40.640000><127.000000,-1.538000,40.640000>0.406400}
cylinder{<146.050000,0.038000,40.640000><146.050000,-1.538000,40.640000>0.406400}
cylinder{<138.430000,0.038000,40.640000><138.430000,-1.538000,40.640000>0.406400}
cylinder{<157.480000,0.038000,40.640000><157.480000,-1.538000,40.640000>0.406400}
cylinder{<149.860000,0.038000,40.640000><149.860000,-1.538000,40.640000>0.406400}
cylinder{<115.570000,0.038000,30.480000><115.570000,-1.538000,30.480000>0.406400}
cylinder{<123.190000,0.038000,30.480000><123.190000,-1.538000,30.480000>0.406400}
cylinder{<127.000000,0.038000,30.480000><127.000000,-1.538000,30.480000>0.406400}
cylinder{<134.620000,0.038000,30.480000><134.620000,-1.538000,30.480000>0.406400}
cylinder{<138.430000,0.038000,30.480000><138.430000,-1.538000,30.480000>0.406400}
cylinder{<146.050000,0.038000,30.480000><146.050000,-1.538000,30.480000>0.406400}
cylinder{<149.860000,0.038000,30.480000><149.860000,-1.538000,30.480000>0.406400}
cylinder{<157.480000,0.038000,30.480000><157.480000,-1.538000,30.480000>0.406400}
cylinder{<56.515000,0.038000,46.355000><56.515000,-1.538000,46.355000>0.406400}
cylinder{<61.595000,0.038000,46.355000><61.595000,-1.538000,46.355000>0.406400}
cylinder{<59.055000,0.038000,41.275000><59.055000,-1.538000,41.275000>0.406400}
cylinder{<82.550000,0.038000,40.005000><82.550000,-1.538000,40.005000>0.406400}
cylinder{<82.550000,0.038000,47.625000><82.550000,-1.538000,47.625000>0.406400}
cylinder{<9.270000,0.038000,34.730000><9.270000,-1.538000,34.730000>0.400000}
cylinder{<11.810000,0.038000,34.730000><11.810000,-1.538000,34.730000>0.400000}
cylinder{<14.350000,0.038000,34.730000><14.350000,-1.538000,34.730000>0.400000}
cylinder{<16.890000,0.038000,34.730000><16.890000,-1.538000,34.730000>0.400000}
cylinder{<19.430000,0.038000,34.730000><19.430000,-1.538000,34.730000>0.400000}
cylinder{<21.970000,0.038000,34.730000><21.970000,-1.538000,34.730000>0.400000}
cylinder{<24.510000,0.038000,34.730000><24.510000,-1.538000,34.730000>0.400000}
cylinder{<27.050000,0.038000,34.730000><27.050000,-1.538000,34.730000>0.400000}
cylinder{<29.590000,0.038000,34.730000><29.590000,-1.538000,34.730000>0.400000}
cylinder{<32.130000,0.038000,34.730000><32.130000,-1.538000,34.730000>0.400000}
cylinder{<34.670000,0.038000,34.730000><34.670000,-1.538000,34.730000>0.400000}
cylinder{<37.210000,0.038000,34.730000><37.210000,-1.538000,34.730000>0.400000}
cylinder{<39.750000,0.038000,34.730000><39.750000,-1.538000,34.730000>0.400000}
cylinder{<42.290000,0.038000,34.730000><42.290000,-1.538000,34.730000>0.400000}
cylinder{<44.830000,0.038000,34.730000><44.830000,-1.538000,34.730000>0.400000}
cylinder{<47.370000,0.038000,34.730000><47.370000,-1.538000,34.730000>0.400000}
//Holes(fast)/Vias
cylinder{<157.480000,0.038000,35.560000><157.480000,-1.538000,35.560000>0.254000 }
cylinder{<113.030000,0.038000,33.020000><113.030000,-1.538000,33.020000>0.254000 }
cylinder{<110.490000,0.038000,33.020000><110.490000,-1.538000,33.020000>0.254000 }
cylinder{<107.950000,0.038000,33.020000><107.950000,-1.538000,33.020000>0.254000 }
cylinder{<105.410000,0.038000,33.020000><105.410000,-1.538000,33.020000>0.254000 }
cylinder{<74.930000,0.038000,30.480000><74.930000,-1.538000,30.480000>0.254000 }
cylinder{<68.580000,0.038000,46.355000><68.580000,-1.538000,46.355000>0.254000 }
//Holes(fast)/Board
texture{col_hls}
}
#if(pcb_silkscreen=on)
//Silk Screen
union{
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.885700,0.000000,8.354300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,8.176300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<157.707700,0.000000,8.176300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,8.176300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,7.820400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<157.707700,0.000000,7.820400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,7.820400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.885700,0.000000,7.642500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,44.980932,0> translate<157.707700,0.000000,7.820400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.885700,0.000000,7.642500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597500,0.000000,7.642500>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<157.885700,0.000000,7.642500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597500,0.000000,7.642500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,7.820400>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,-44.997030,0> translate<158.597500,0.000000,7.642500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,7.820400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,8.176300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,90.000000,0> translate<158.775400,0.000000,8.176300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,8.176300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597500,0.000000,8.354300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<158.597500,0.000000,8.354300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597500,0.000000,8.354300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.241600,0.000000,8.354300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<158.241600,0.000000,8.354300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.241600,0.000000,8.354300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.241600,0.000000,7.998400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<158.241600,0.000000,7.998400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,8.811800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,8.811800>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<157.707700,0.000000,8.811800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,8.811800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,9.523600>}
box{<0,0,-0.101600><1.283216,0.036000,0.101600> rotate<0,-33.687844,0> translate<157.707700,0.000000,8.811800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,9.523600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,9.523600>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<157.707700,0.000000,9.523600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,9.981100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,9.981100>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<157.707700,0.000000,9.981100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,9.981100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,10.514900>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,90.000000,0> translate<158.775400,0.000000,10.514900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775400,0.000000,10.514900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597500,0.000000,10.692900>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<158.597500,0.000000,10.692900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597500,0.000000,10.692900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.885700,0.000000,10.692900>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<157.885700,0.000000,10.692900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.885700,0.000000,10.692900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,10.514900>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<157.707700,0.000000,10.514900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,10.514900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.707700,0.000000,9.981100>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,-90.000000,0> translate<157.707700,0.000000,9.981100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.828600,0.000000,7.515500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.828600,0.000000,8.227300>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,90.000000,0> translate<155.828600,0.000000,8.227300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.472700,0.000000,7.871400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.184500,0.000000,7.871400>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<155.472700,0.000000,7.871400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.294700,0.000000,9.396600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.294700,0.000000,8.684800>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,-90.000000,0> translate<155.294700,0.000000,8.684800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.294700,0.000000,8.684800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.828600,0.000000,8.684800>}
box{<0,0,-0.101600><0.533900,0.036000,0.101600> rotate<0,0.000000,0> translate<155.294700,0.000000,8.684800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.828600,0.000000,8.684800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.650600,0.000000,9.040700>}
box{<0,0,-0.101600><0.397931,0.036000,0.101600> rotate<0,63.424324,0> translate<155.650600,0.000000,9.040700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.650600,0.000000,9.040700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.650600,0.000000,9.218600>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,90.000000,0> translate<155.650600,0.000000,9.218600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.650600,0.000000,9.218600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.828600,0.000000,9.396600>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<155.650600,0.000000,9.218600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.828600,0.000000,9.396600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.184500,0.000000,9.396600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<155.828600,0.000000,9.396600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.184500,0.000000,9.396600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.362400,0.000000,9.218600>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<156.184500,0.000000,9.396600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.362400,0.000000,9.218600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.362400,0.000000,8.862700>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<156.362400,0.000000,8.862700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.362400,0.000000,8.862700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.184500,0.000000,8.684800>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,-44.997030,0> translate<156.184500,0.000000,8.684800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.294700,0.000000,9.854100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.006500,0.000000,9.854100>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<155.294700,0.000000,9.854100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.006500,0.000000,9.854100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.362400,0.000000,10.210000>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<156.006500,0.000000,9.854100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.362400,0.000000,10.210000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.006500,0.000000,10.565900>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<156.006500,0.000000,10.565900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.006500,0.000000,10.565900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.294700,0.000000,10.565900>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<155.294700,0.000000,10.565900> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350200,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638300,0.000000,38.176200>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<24.350200,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638300,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.782400,0.000000,38.320200>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-44.977144,0> translate<24.638300,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.782400,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.782400,0.000000,38.608300>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,90.000000,0> translate<24.782400,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.782400,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638300,0.000000,38.752400>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<24.638300,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.638300,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350200,0.000000,38.752400>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<24.350200,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350200,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.206200,0.000000,38.608300>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<24.206200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.206200,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.206200,0.000000,38.320200>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,-90.000000,0> translate<24.206200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.206200,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<24.350200,0.000000,38.176200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<24.206200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.141700,0.000000,37.888100>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.141700,0.000000,38.752400>}
box{<0,0,-0.076200><0.864300,0.036000,0.076200> rotate<0,90.000000,0> translate<25.141700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.141700,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.573800,0.000000,38.752400>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,0.000000,0> translate<25.141700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.573800,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717900,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<25.573800,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717900,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717900,0.000000,38.320200>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,-90.000000,0> translate<25.717900,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.717900,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.573800,0.000000,38.176200>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-44.977144,0> translate<25.573800,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.573800,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<25.141700,0.000000,38.176200>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,0.000000,0> translate<25.141700,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.509300,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.221200,0.000000,38.176200>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<26.221200,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.221200,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.077200,0.000000,38.320200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<26.077200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.077200,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.077200,0.000000,38.608300>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,90.000000,0> translate<26.077200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.077200,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.221200,0.000000,38.752400>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<26.077200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.221200,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.509300,0.000000,38.752400>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<26.221200,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.509300,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.653400,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<26.509300,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.653400,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.653400,0.000000,38.464300>}
box{<0,0,-0.076200><0.144000,0.036000,0.076200> rotate<0,-90.000000,0> translate<26.653400,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.653400,0.000000,38.464300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<26.077200,0.000000,38.464300>}
box{<0,0,-0.076200><0.576200,0.036000,0.076200> rotate<0,0.000000,0> translate<26.077200,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.012700,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.012700,0.000000,38.752400>}
box{<0,0,-0.076200><0.576200,0.036000,0.076200> rotate<0,90.000000,0> translate<27.012700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.012700,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.444800,0.000000,38.752400>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,0.000000,0> translate<27.012700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.444800,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.588900,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<27.444800,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.588900,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<27.588900,0.000000,38.176200>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,-90.000000,0> translate<27.588900,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.883700,0.000000,39.040500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.883700,0.000000,38.176200>}
box{<0,0,-0.076200><0.864300,0.036000,0.076200> rotate<0,-90.000000,0> translate<28.883700,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<28.883700,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.027700,0.000000,38.752400>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<28.883700,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.027700,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.315800,0.000000,38.752400>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<29.027700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.315800,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.459900,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<29.315800,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.459900,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.459900,0.000000,38.176200>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,-90.000000,0> translate<29.459900,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.963200,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.251300,0.000000,38.752400>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<29.963200,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.251300,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.395400,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<30.251300,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.395400,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.395400,0.000000,38.176200>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,-90.000000,0> translate<30.395400,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.395400,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.963200,0.000000,38.176200>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,0.000000,0> translate<29.963200,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.963200,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.819200,0.000000,38.320200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<29.819200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.819200,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.963200,0.000000,38.464300>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<29.819200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<29.963200,0.000000,38.464300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.395400,0.000000,38.464300>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,0.000000,0> translate<29.963200,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.754700,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.754700,0.000000,38.752400>}
box{<0,0,-0.076200><0.576200,0.036000,0.076200> rotate<0,90.000000,0> translate<30.754700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<30.754700,0.000000,38.464300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.042800,0.000000,38.752400>}
box{<0,0,-0.076200><0.407435,0.036000,0.076200> rotate<0,-44.997030,0> translate<30.754700,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.042800,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.186800,0.000000,38.752400>}
box{<0,0,-0.076200><0.144000,0.036000,0.076200> rotate<0,0.000000,0> translate<31.042800,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.110400,0.000000,39.040500>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.110400,0.000000,38.176200>}
box{<0,0,-0.076200><0.864300,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.110400,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.110400,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.678200,0.000000,38.176200>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,0.000000,0> translate<31.678200,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.678200,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.534200,0.000000,38.320200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<31.534200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.534200,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.534200,0.000000,38.608300>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,90.000000,0> translate<31.534200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.534200,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.678200,0.000000,38.752400>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<31.534200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<31.678200,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.110400,0.000000,38.752400>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,0.000000,0> translate<31.678200,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.469700,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.469700,0.000000,38.320200>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,-90.000000,0> translate<32.469700,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.469700,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.613700,0.000000,38.176200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<32.469700,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.613700,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.757800,0.000000,38.320200>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-44.977144,0> translate<32.613700,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.757800,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.901800,0.000000,38.176200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<32.757800,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<32.901800,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.045900,0.000000,38.320200>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-44.977144,0> translate<32.901800,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.045900,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.045900,0.000000,38.752400>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,90.000000,0> translate<33.045900,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.549200,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.837300,0.000000,38.752400>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<33.549200,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.837300,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.981400,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<33.837300,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.981400,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.981400,0.000000,38.176200>}
box{<0,0,-0.076200><0.432100,0.036000,0.076200> rotate<0,-90.000000,0> translate<33.981400,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.981400,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.549200,0.000000,38.176200>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,0.000000,0> translate<33.549200,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.549200,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.405200,0.000000,38.320200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<33.405200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.405200,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.549200,0.000000,38.464300>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<33.405200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.549200,0.000000,38.464300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<33.981400,0.000000,38.464300>}
box{<0,0,-0.076200><0.432200,0.036000,0.076200> rotate<0,0.000000,0> translate<33.549200,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.340700,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.340700,0.000000,38.752400>}
box{<0,0,-0.076200><0.576200,0.036000,0.076200> rotate<0,90.000000,0> translate<34.340700,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.340700,0.000000,38.464300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.628800,0.000000,38.752400>}
box{<0,0,-0.076200><0.407435,0.036000,0.076200> rotate<0,-44.997030,0> translate<34.340700,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.628800,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<34.772800,0.000000,38.752400>}
box{<0,0,-0.076200><0.144000,0.036000,0.076200> rotate<0,0.000000,0> translate<34.628800,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.552300,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.264200,0.000000,38.176200>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<35.264200,0.000000,38.176200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.264200,0.000000,38.176200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.120200,0.000000,38.320200>}
box{<0,0,-0.076200><0.203647,0.036000,0.076200> rotate<0,44.997030,0> translate<35.120200,0.000000,38.320200> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.120200,0.000000,38.320200>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.120200,0.000000,38.608300>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,90.000000,0> translate<35.120200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.120200,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.264200,0.000000,38.752400>}
box{<0,0,-0.076200><0.203717,0.036000,0.076200> rotate<0,-45.016916,0> translate<35.120200,0.000000,38.608300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.264200,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.552300,0.000000,38.752400>}
box{<0,0,-0.076200><0.288100,0.036000,0.076200> rotate<0,0.000000,0> translate<35.264200,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.552300,0.000000,38.752400>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.696400,0.000000,38.608300>}
box{<0,0,-0.076200><0.203788,0.036000,0.076200> rotate<0,44.997030,0> translate<35.552300,0.000000,38.752400> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.696400,0.000000,38.608300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.696400,0.000000,38.464300>}
box{<0,0,-0.076200><0.144000,0.036000,0.076200> rotate<0,-90.000000,0> translate<35.696400,0.000000,38.464300> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.696400,0.000000,38.464300>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<35.120200,0.000000,38.464300>}
box{<0,0,-0.076200><0.576200,0.036000,0.076200> rotate<0,0.000000,0> translate<35.120200,0.000000,38.464300> }
//IC1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<92.075000,0.000000,46.482000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,46.482000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.916000,0.000000,46.482000> }
object{ARC(0.635000,0.152400,180.000000,360.000000,0.036000) translate<92.710000,0.000000,46.482000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,46.482000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,9.398000>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,-90.000000,0> translate<89.916000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.504000,0.000000,46.482000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<93.345000,0.000000,46.482000>}
box{<0,0,-0.076200><2.159000,0.036000,0.076200> rotate<0,0.000000,0> translate<93.345000,0.000000,46.482000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.504000,0.000000,46.482000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.504000,0.000000,9.398000>}
box{<0,0,-0.076200><37.084000,0.036000,0.076200> rotate<0,-90.000000,0> translate<95.504000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<95.504000,0.000000,9.398000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<89.916000,0.000000,9.398000>}
box{<0,0,-0.076200><5.588000,0.036000,0.076200> rotate<0,0.000000,0> translate<89.916000,0.000000,9.398000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.271600,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.678300,0.000000,47.244000>}
box{<0,0,-0.101600><0.406700,0.036000,0.101600> rotate<0,0.000000,0> translate<90.271600,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.474900,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.474900,0.000000,48.464200>}
box{<0,0,-0.101600><1.220200,0.036000,0.101600> rotate<0,90.000000,0> translate<90.474900,0.000000,48.464200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.271600,0.000000,48.464200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<90.678300,0.000000,48.464200>}
box{<0,0,-0.101600><0.406700,0.036000,0.101600> rotate<0,0.000000,0> translate<90.271600,0.000000,48.464200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.958100,0.000000,48.260800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.754800,0.000000,48.464200>}
box{<0,0,-0.101600><0.287580,0.036000,0.101600> rotate<0,45.011117,0> translate<91.754800,0.000000,48.464200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.754800,0.000000,48.464200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.348000,0.000000,48.464200>}
box{<0,0,-0.101600><0.406800,0.036000,0.101600> rotate<0,0.000000,0> translate<91.348000,0.000000,48.464200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.348000,0.000000,48.464200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.144700,0.000000,48.260800>}
box{<0,0,-0.101600><0.287580,0.036000,0.101600> rotate<0,-45.011117,0> translate<91.144700,0.000000,48.260800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.144700,0.000000,48.260800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.144700,0.000000,47.447300>}
box{<0,0,-0.101600><0.813500,0.036000,0.101600> rotate<0,-90.000000,0> translate<91.144700,0.000000,47.447300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.144700,0.000000,47.447300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.348000,0.000000,47.244000>}
box{<0,0,-0.101600><0.287510,0.036000,0.101600> rotate<0,44.997030,0> translate<91.144700,0.000000,47.447300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.348000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.754800,0.000000,47.244000>}
box{<0,0,-0.101600><0.406800,0.036000,0.101600> rotate<0,0.000000,0> translate<91.348000,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.754800,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<91.958100,0.000000,47.447300>}
box{<0,0,-0.101600><0.287510,0.036000,0.101600> rotate<0,-44.997030,0> translate<91.754800,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<92.454400,0.000000,48.057400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<92.861100,0.000000,48.464200>}
box{<0,0,-0.101600><0.575231,0.036000,0.101600> rotate<0,-45.004073,0> translate<92.454400,0.000000,48.057400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<92.861100,0.000000,48.464200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<92.861100,0.000000,47.244000>}
box{<0,0,-0.101600><1.220200,0.036000,0.101600> rotate<0,-90.000000,0> translate<92.861100,0.000000,47.244000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<92.454400,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<93.267800,0.000000,47.244000>}
box{<0,0,-0.101600><0.813400,0.036000,0.101600> rotate<0,0.000000,0> translate<92.454400,0.000000,47.244000> }
//ISP1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.152000,0.000000,47.625000>}
box{<0,0,-0.063500><1.077631,0.036000,0.063500> rotate<0,-44.997030,0> translate<72.390000,0.000000,46.863000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.152000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.708000,0.000000,47.625000>}
box{<0,0,-0.063500><3.556000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.152000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.708000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,46.863000>}
box{<0,0,-0.063500><1.077631,0.036000,0.063500> rotate<0,44.997030,0> translate<76.708000,0.000000,47.625000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,46.863000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,45.593000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<77.470000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.962000,0.000000,45.085000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,-44.997030,0> translate<76.962000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.962000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,44.577000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,44.997030,0> translate<76.962000,0.000000,45.085000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,43.053000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,-90.000000,0> translate<77.470000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.962000,0.000000,42.545000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,-44.997030,0> translate<76.962000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.962000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,42.037000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,44.997030,0> translate<76.962000,0.000000,42.545000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,42.037000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,40.767000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,-90.000000,0> translate<77.470000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.470000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.708000,0.000000,40.005000>}
box{<0,0,-0.063500><1.077631,0.036000,0.063500> rotate<0,-44.997030,0> translate<76.708000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<76.708000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.152000,0.000000,40.005000>}
box{<0,0,-0.063500><3.556000,0.036000,0.063500> rotate<0,0.000000,0> translate<73.152000,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.152000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,40.767000>}
box{<0,0,-0.063500><1.077631,0.036000,0.063500> rotate<0,44.997030,0> translate<72.390000,0.000000,40.767000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,40.767000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,42.037000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<72.390000,0.000000,42.037000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,42.037000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.898000,0.000000,42.545000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,-44.997030,0> translate<72.390000,0.000000,42.037000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.898000,0.000000,42.545000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,43.053000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,44.997030,0> translate<72.390000,0.000000,43.053000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,43.053000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,44.577000>}
box{<0,0,-0.063500><1.524000,0.036000,0.063500> rotate<0,90.000000,0> translate<72.390000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,44.577000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.898000,0.000000,45.085000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,-44.997030,0> translate<72.390000,0.000000,44.577000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.898000,0.000000,45.085000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,45.593000>}
box{<0,0,-0.063500><0.718420,0.036000,0.063500> rotate<0,44.997030,0> translate<72.390000,0.000000,45.593000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,45.593000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<72.390000,0.000000,46.863000>}
box{<0,0,-0.063500><1.270000,0.036000,0.063500> rotate<0,90.000000,0> translate<72.390000,0.000000,46.863000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,41.025900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,41.381800>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,90.000000,0> translate<79.400400,0.000000,41.381800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,41.203800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,41.203800>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<78.332700,0.000000,41.203800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,41.025900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,41.381800>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,90.000000,0> translate<78.332700,0.000000,41.381800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.510700,0.000000,42.517200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,42.339200>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<78.332700,0.000000,42.339200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,42.339200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,41.983300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<78.332700,0.000000,41.983300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,41.983300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.510700,0.000000,41.805400>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,44.980932,0> translate<78.332700,0.000000,41.983300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.510700,0.000000,41.805400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.688600,0.000000,41.805400>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,0.000000,0> translate<78.510700,0.000000,41.805400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.688600,0.000000,41.805400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.866600,0.000000,41.983300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<78.688600,0.000000,41.805400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.866600,0.000000,41.983300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.866600,0.000000,42.339200>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,90.000000,0> translate<78.866600,0.000000,42.339200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.866600,0.000000,42.339200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.044500,0.000000,42.517200>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<78.866600,0.000000,42.339200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.044500,0.000000,42.517200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.222500,0.000000,42.517200>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,0.000000,0> translate<79.044500,0.000000,42.517200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.222500,0.000000,42.517200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,42.339200>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<79.222500,0.000000,42.517200> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,42.339200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,41.983300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<79.400400,0.000000,41.983300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,41.983300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.222500,0.000000,41.805400>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,-44.997030,0> translate<79.222500,0.000000,41.805400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,42.974700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,42.974700>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<78.332700,0.000000,42.974700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,42.974700>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,43.508500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,90.000000,0> translate<78.332700,0.000000,43.508500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,43.508500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.510700,0.000000,43.686500>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<78.332700,0.000000,43.508500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.510700,0.000000,43.686500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.866600,0.000000,43.686500>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<78.510700,0.000000,43.686500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.866600,0.000000,43.686500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.044500,0.000000,43.508500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<78.866600,0.000000,43.686500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.044500,0.000000,43.508500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.044500,0.000000,42.974700>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,-90.000000,0> translate<79.044500,0.000000,42.974700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.688600,0.000000,44.144000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,44.499900>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<78.332700,0.000000,44.499900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<78.332700,0.000000,44.499900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,44.499900>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<78.332700,0.000000,44.499900> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,44.144000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.400400,0.000000,44.855800>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,90.000000,0> translate<79.400400,0.000000,44.855800> }
//LED1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.160000,0.000000,47.625000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<10.160000,0.000000,43.815000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,-90.000000,0> translate<10.160000,0.000000,43.815000> }
object{ARC(3.175000,0.254000,216.869898,503.130102,0.036000) translate<12.700000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<12.700000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<12.700000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<12.700000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<12.700000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<12.700000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<12.700000,0.000000,45.720000>}
difference{
cylinder{<12.700000,0,45.720000><12.700000,0.036000,45.720000>2.616200 translate<0,0.000000,0>}
cylinder{<12.700000,-0.1,45.720000><12.700000,0.135000,45.720000>2.463800 translate<0,0.000000,0>}}
//LED2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<121.920000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<121.920000,0.000000,47.625000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<121.920000,0.000000,47.625000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<119.380000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<119.380000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<119.380000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<119.380000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<119.380000,0.000000,45.720000>}
difference{
cylinder{<119.380000,0,45.720000><119.380000,0.036000,45.720000>2.616200 translate<0,0.000000,0>}
cylinder{<119.380000,-0.1,45.720000><119.380000,0.135000,45.720000>2.463800 translate<0,0.000000,0>}}
//LED3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.350000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.350000,0.000000,47.625000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<133.350000,0.000000,47.625000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<130.810000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<130.810000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<130.810000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<130.810000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<130.810000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<130.810000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<130.810000,0.000000,45.720000>}
difference{
cylinder{<130.810000,0,45.720000><130.810000,0.036000,45.720000>2.616200 translate<0,0.000000,0>}
cylinder{<130.810000,-0.1,45.720000><130.810000,0.135000,45.720000>2.463800 translate<0,0.000000,0>}}
//LED4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<144.780000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<144.780000,0.000000,47.625000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<144.780000,0.000000,47.625000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<142.240000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<142.240000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<142.240000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<142.240000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<142.240000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<142.240000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<142.240000,0.000000,45.720000>}
difference{
cylinder{<142.240000,0,45.720000><142.240000,0.036000,45.720000>2.616200 translate<0,0.000000,0>}
cylinder{<142.240000,-0.1,45.720000><142.240000,0.135000,45.720000>2.463800 translate<0,0.000000,0>}}
//LED5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.210000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.210000,0.000000,47.625000>}
box{<0,0,-0.101600><3.810000,0.036000,0.101600> rotate<0,90.000000,0> translate<156.210000,0.000000,47.625000> }
object{ARC(3.175000,0.254000,36.869898,323.130102,0.036000) translate<153.670000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,90.000000,180.000000,0.036000) translate<153.670000,0.000000,45.720000>}
object{ARC(1.143000,0.152400,270.000000,360.000000,0.036000) translate<153.670000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,90.000000,180.000000,0.036000) translate<153.670000,0.000000,45.720000>}
object{ARC(1.651000,0.152400,270.000000,360.000000,0.036000) translate<153.670000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,90.000000,180.000000,0.036000) translate<153.670000,0.000000,45.720000>}
object{ARC(2.159000,0.152400,270.000000,360.000000,0.036000) translate<153.670000,0.000000,45.720000>}
difference{
cylinder{<153.670000,0,45.720000><153.670000,0.036000,45.720000>2.616200 translate<0,0.000000,0>}
cylinder{<153.670000,-0.1,45.720000><153.670000,0.135000,45.720000>2.463800 translate<0,0.000000,0>}}
//LOGO1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<29.006800,0.000000,42.519600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<28.168600,0.000000,40.487600>}
box{<0,0,-0.127000><2.198091,0.036000,0.127000> rotate<0,-67.579392,0> translate<28.168600,0.000000,40.487600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<28.168600,0.000000,40.487600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<27.711400,0.000000,40.741600>}
box{<0,0,-0.127000><0.523018,0.036000,0.127000> rotate<0,29.052687,0> translate<27.711400,0.000000,40.741600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<27.711400,0.000000,40.741600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.644600,0.000000,40.005000>}
box{<0,0,-0.127000><1.296396,0.036000,0.127000> rotate<0,-34.621870,0> translate<26.644600,0.000000,40.005000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.644600,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<25.806400,0.000000,40.843200>}
box{<0,0,-0.127000><1.185394,0.036000,0.127000> rotate<0,44.997030,0> translate<25.806400,0.000000,40.843200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<25.806400,0.000000,40.843200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.568400,0.000000,41.935400>}
box{<0,0,-0.127000><1.331745,0.036000,0.127000> rotate<0,-55.093868,0> translate<25.806400,0.000000,40.843200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.085800,0.000000,43.103800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.765000,0.000000,43.357800>}
box{<0,0,-0.127000><1.345001,0.036000,0.127000> rotate<0,10.884809,0> translate<24.765000,0.000000,43.357800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.765000,0.000000,43.357800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.765000,0.000000,44.500800>}
box{<0,0,-0.127000><1.143000,0.036000,0.127000> rotate<0,90.000000,0> translate<24.765000,0.000000,44.500800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<24.765000,0.000000,44.500800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.111200,0.000000,44.754800>}
box{<0,0,-0.127000><1.369953,0.036000,0.127000> rotate<0,-10.684207,0> translate<24.765000,0.000000,44.500800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.593800,0.000000,45.872400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<25.806400,0.000000,47.015400>}
box{<0,0,-0.127000><1.387965,0.036000,0.127000> rotate<0,55.433817,0> translate<25.806400,0.000000,47.015400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<25.806400,0.000000,47.015400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.644600,0.000000,47.828200>}
box{<0,0,-0.127000><1.167571,0.036000,0.127000> rotate<0,-44.115684,0> translate<25.806400,0.000000,47.015400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<26.644600,0.000000,47.828200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<27.787600,0.000000,47.040800>}
box{<0,0,-0.127000><1.387965,0.036000,0.127000> rotate<0,34.560244,0> translate<26.644600,0.000000,47.828200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<28.879800,0.000000,47.498000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<29.133800,0.000000,48.869600>}
box{<0,0,-0.127000><1.394920,0.036000,0.127000> rotate<0,-79.503276,0> translate<28.879800,0.000000,47.498000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<29.133800,0.000000,48.869600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<30.302200,0.000000,48.869600>}
box{<0,0,-0.127000><1.168400,0.036000,0.127000> rotate<0,0.000000,0> translate<29.133800,0.000000,48.869600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<30.302200,0.000000,48.869600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<30.556200,0.000000,47.498000>}
box{<0,0,-0.127000><1.394920,0.036000,0.127000> rotate<0,79.503276,0> translate<30.302200,0.000000,48.869600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.648400,0.000000,47.040800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.816800,0.000000,47.828200>}
box{<0,0,-0.127000><1.408956,0.036000,0.127000> rotate<0,-33.974302,0> translate<31.648400,0.000000,47.040800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.816800,0.000000,47.828200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.629600,0.000000,47.015400>}
box{<0,0,-0.127000><1.149473,0.036000,0.127000> rotate<0,44.997030,0> translate<32.816800,0.000000,47.828200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.629600,0.000000,47.015400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.842200,0.000000,45.872400>}
box{<0,0,-0.127000><1.387965,0.036000,0.127000> rotate<0,-55.433817,0> translate<32.842200,0.000000,45.872400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.324800,0.000000,44.754800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.671000,0.000000,44.500800>}
box{<0,0,-0.127000><1.369953,0.036000,0.127000> rotate<0,10.684207,0> translate<33.324800,0.000000,44.754800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.671000,0.000000,44.500800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.671000,0.000000,43.357800>}
box{<0,0,-0.127000><1.143000,0.036000,0.127000> rotate<0,-90.000000,0> translate<34.671000,0.000000,43.357800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<34.671000,0.000000,43.357800>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.350200,0.000000,43.103800>}
box{<0,0,-0.127000><1.345001,0.036000,0.127000> rotate<0,-10.884809,0> translate<33.350200,0.000000,43.103800> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.893000,0.000000,41.935400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.629600,0.000000,40.843200>}
box{<0,0,-0.127000><1.317376,0.036000,0.127000> rotate<0,55.999845,0> translate<32.893000,0.000000,41.935400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<33.629600,0.000000,40.843200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.816800,0.000000,40.030400>}
box{<0,0,-0.127000><1.149473,0.036000,0.127000> rotate<0,-44.997030,0> translate<32.816800,0.000000,40.030400> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<32.816800,0.000000,40.030400>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.750000,0.000000,40.741600>}
box{<0,0,-0.127000><1.282134,0.036000,0.127000> rotate<0,33.687844,0> translate<31.750000,0.000000,40.741600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.750000,0.000000,40.741600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.292800,0.000000,40.487600>}
box{<0,0,-0.127000><0.523018,0.036000,0.127000> rotate<0,-29.052687,0> translate<31.292800,0.000000,40.487600> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<31.292800,0.000000,40.487600>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<30.454600,0.000000,42.519600>}
box{<0,0,-0.127000><2.198091,0.036000,0.127000> rotate<0,67.579392,0> translate<30.454600,0.000000,42.519600> }
object{ARC(3.694900,0.254000,191.595798,211.146189,0.036000) translate<29.730700,0.000000,43.846500>}
object{ARC(3.702400,0.254000,147.182113,166.106757,0.036000) translate<29.705300,0.000000,43.865800>}
object{ARC(3.720200,0.254000,102.488883,120.652876,0.036000) translate<29.684300,0.000000,43.840400>}
object{ARC(3.703100,0.254000,59.024303,76.903446,0.036000) translate<29.717100,0.000000,43.865800>}
object{ARC(3.716100,0.254000,13.928545,32.783029,0.036000) translate<29.718000,0.000000,43.860300>}
object{ARC(3.694900,0.254000,328.853811,348.404202,0.036000) translate<29.730700,0.000000,43.846500>}
object{ARC(1.528500,0.254000,298.268513,601.731487,0.036000) translate<29.730700,0.000000,43.865800>}
//PWR silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<159.385000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,3.175000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.845000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,0.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<156.845000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<159.385000,0.000000,0.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.845000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<159.385000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<159.385000,0.000000,3.175000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,90.000000,0> translate<159.385000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,3.175000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.305000,0.000000,3.175000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,3.175000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,0.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,-90.000000,0> translate<154.305000,0.000000,0.635000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<154.305000,0.000000,0.635000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,0.635000>}
box{<0,0,-0.076200><2.540000,0.036000,0.076200> rotate<0,0.000000,0> translate<154.305000,0.000000,0.635000> }
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<158.115000,0.000000,0.381000>}
box{<-0.381000,0,-0.254000><0.381000,0.036000,0.254000> rotate<0,-180.000000,0> translate<155.575000,0.000000,0.381000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<158.115000,0.000000,3.683000>}
box{<-0.381000,0,-0.508000><0.381000,0.036000,0.508000> rotate<0,-180.000000,0> translate<155.575000,0.000000,3.683000>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<154.952700,0.000000,12.458700>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<154.952700,0.000000,13.958500>}
box{<0,0,-0.139700><1.499800,0.036000,0.139700> rotate<0,90.000000,0> translate<154.952700,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<154.952700,0.000000,13.958500>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.702600,0.000000,13.958500>}
box{<0,0,-0.139700><0.749900,0.036000,0.139700> rotate<0,0.000000,0> translate<154.952700,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.702600,0.000000,13.958500>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.952600,0.000000,13.708600>}
box{<0,0,-0.139700><0.353483,0.036000,0.139700> rotate<0,44.985569,0> translate<155.702600,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.952600,0.000000,13.708600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.952600,0.000000,13.208600>}
box{<0,0,-0.139700><0.500000,0.036000,0.139700> rotate<0,-90.000000,0> translate<155.952600,0.000000,13.208600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.952600,0.000000,13.208600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.702600,0.000000,12.958600>}
box{<0,0,-0.139700><0.353553,0.036000,0.139700> rotate<0,-44.997030,0> translate<155.702600,0.000000,12.958600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<155.702600,0.000000,12.958600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<154.952700,0.000000,12.958600>}
box{<0,0,-0.139700><0.749900,0.036000,0.139700> rotate<0,0.000000,0> translate<154.952700,0.000000,12.958600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<156.589800,0.000000,13.958500>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<156.589800,0.000000,12.458700>}
box{<0,0,-0.139700><1.499800,0.036000,0.139700> rotate<0,-90.000000,0> translate<156.589800,0.000000,12.458700> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<156.589800,0.000000,12.458700>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<157.089700,0.000000,12.958600>}
box{<0,0,-0.139700><0.706965,0.036000,0.139700> rotate<0,-44.997030,0> translate<156.589800,0.000000,12.458700> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<157.089700,0.000000,12.958600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<157.589700,0.000000,12.458700>}
box{<0,0,-0.139700><0.707036,0.036000,0.139700> rotate<0,44.991300,0> translate<157.089700,0.000000,12.958600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<157.589700,0.000000,12.458700>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<157.589700,0.000000,13.958500>}
box{<0,0,-0.139700><1.499800,0.036000,0.139700> rotate<0,90.000000,0> translate<157.589700,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.226900,0.000000,12.458700>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.226900,0.000000,13.958500>}
box{<0,0,-0.139700><1.499800,0.036000,0.139700> rotate<0,90.000000,0> translate<158.226900,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.226900,0.000000,13.958500>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.976800,0.000000,13.958500>}
box{<0,0,-0.139700><0.749900,0.036000,0.139700> rotate<0,0.000000,0> translate<158.226900,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.976800,0.000000,13.958500>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<159.226800,0.000000,13.708600>}
box{<0,0,-0.139700><0.353483,0.036000,0.139700> rotate<0,44.985569,0> translate<158.976800,0.000000,13.958500> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<159.226800,0.000000,13.708600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<159.226800,0.000000,13.208600>}
box{<0,0,-0.139700><0.500000,0.036000,0.139700> rotate<0,-90.000000,0> translate<159.226800,0.000000,13.208600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<159.226800,0.000000,13.208600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.976800,0.000000,12.958600>}
box{<0,0,-0.139700><0.353553,0.036000,0.139700> rotate<0,-44.997030,0> translate<158.976800,0.000000,12.958600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.976800,0.000000,12.958600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.226900,0.000000,12.958600>}
box{<0,0,-0.139700><0.749900,0.036000,0.139700> rotate<0,0.000000,0> translate<158.226900,0.000000,12.958600> }
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<158.726800,0.000000,12.958600>}
cylinder{<0,0,0><0,0.036000,0>0.139700 translate<159.226800,0.000000,12.458700>}
box{<0,0,-0.139700><0.707036,0.036000,0.139700> rotate<0,44.991300,0> translate<158.726800,0.000000,12.958600> }
//R1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<10.160000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<9.779000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<9.779000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<9.271000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<9.271000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<3.429000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<3.429000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.525000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<9.525000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<8.763000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<9.271000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<8.890000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.890000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<8.763000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<3.810000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.937000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<3.810000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.937000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<8.763000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.937000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.429000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.429000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.429000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.810000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<3.429000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<3.175000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<3.175000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.921000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<2.540000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<2.540000,0.000000,40.640000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<9.652000,0.000000,40.640000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<3.048000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.636900,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.636900,0.000000,39.269300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<5.636900,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.636900,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.170700,0.000000,39.269300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<5.636900,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.170700,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.348700,0.000000,39.091300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<6.170700,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.348700,0.000000,39.091300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.348700,0.000000,38.735400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<6.348700,0.000000,38.735400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.348700,0.000000,38.735400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.170700,0.000000,38.557500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<6.170700,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.170700,0.000000,38.557500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.636900,0.000000,38.557500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<5.636900,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<5.992800,0.000000,38.557500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.348700,0.000000,38.201600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<5.992800,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.806200,0.000000,38.913400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162100,0.000000,39.269300>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<6.806200,0.000000,38.913400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162100,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.162100,0.000000,38.201600>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,-90.000000,0> translate<7.162100,0.000000,38.201600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.806200,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.518000,0.000000,38.201600>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<6.806200,0.000000,38.201600> }
//R2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.590000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<21.209000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<21.209000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<20.701000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<20.701000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<14.859000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<14.859000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.955000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<20.955000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<20.193000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.701000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<20.320000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.320000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<20.193000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<15.240000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<15.240000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.367000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<20.193000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<15.367000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.859000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<15.240000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<14.859000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<14.605000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<14.605000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<14.351000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<13.970000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<13.970000,0.000000,40.640000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<21.082000,0.000000,40.640000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<14.478000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.066900,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.066900,0.000000,39.269300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<17.066900,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.066900,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.600700,0.000000,39.269300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<17.066900,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.600700,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.778700,0.000000,39.091300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<17.600700,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.778700,0.000000,39.091300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.778700,0.000000,38.735400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<17.778700,0.000000,38.735400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.778700,0.000000,38.735400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.600700,0.000000,38.557500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<17.600700,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.600700,0.000000,38.557500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.066900,0.000000,38.557500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<17.066900,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.422800,0.000000,38.557500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<17.778700,0.000000,38.201600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<17.422800,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.948000,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.236200,0.000000,38.201600>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<18.236200,0.000000,38.201600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.236200,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.948000,0.000000,38.913400>}
box{<0,0,-0.101600><1.006637,0.036000,0.101600> rotate<0,-44.997030,0> translate<18.236200,0.000000,38.201600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.948000,0.000000,38.913400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.948000,0.000000,39.091300>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,90.000000,0> translate<18.948000,0.000000,39.091300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.948000,0.000000,39.091300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.770000,0.000000,39.269300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<18.770000,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.770000,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.414100,0.000000,39.269300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<18.414100,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.414100,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<18.236200,0.000000,39.091300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<18.236200,0.000000,39.091300> }
//R3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<123.190000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<122.809000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<122.809000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<122.301000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<122.301000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<116.459000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<116.459000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<122.555000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.301000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.920000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<121.793000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.301000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.920000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<121.793000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<116.840000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.967000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<116.840000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.967000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.459000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.459000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.459000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.459000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.205000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.205000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<116.205000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<115.951000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<115.570000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<115.570000,0.000000,40.640000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<122.682000,0.000000,40.640000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<116.078000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<122.476900,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<122.476900,0.000000,43.206300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<122.476900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<122.476900,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.010700,0.000000,43.206300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<122.476900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.010700,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.188700,0.000000,43.028300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<123.010700,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.188700,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.188700,0.000000,42.672400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<123.188700,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.188700,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.010700,0.000000,42.494500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<123.010700,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.010700,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<122.476900,0.000000,42.494500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<122.476900,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<122.832800,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.188700,0.000000,42.138600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<122.832800,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.646200,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.824100,0.000000,43.206300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<123.646200,0.000000,43.028300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.824100,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,43.206300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<123.824100,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,43.028300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<124.180000,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,42.850400>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,-90.000000,0> translate<124.358000,0.000000,42.850400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,42.850400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,42.672400>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<124.180000,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.002100,0.000000,42.672400>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,0.000000,0> translate<124.002100,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,42.494500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,44.980932,0> translate<124.180000,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,42.316500>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,-90.000000,0> translate<124.358000,0.000000,42.316500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.358000,0.000000,42.316500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,42.138600>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<124.180000,0.000000,42.138600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<124.180000,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.824100,0.000000,42.138600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<123.824100,0.000000,42.138600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.824100,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<123.646200,0.000000,42.316500>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,44.997030,0> translate<123.646200,0.000000,42.316500> }
//R4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<134.620000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<134.239000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<134.239000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<133.731000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<133.731000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<127.889000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<127.889000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.985000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.985000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<133.985000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.731000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.350000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<133.223000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.731000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.350000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<133.223000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<128.270000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.397000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<128.270000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.397000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.889000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<127.889000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.889000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<127.889000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.635000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.635000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<127.635000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<127.381000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<127.000000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<127.000000,0.000000,40.640000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<134.112000,0.000000,40.640000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<127.508000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.906900,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.906900,0.000000,43.206300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<133.906900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.906900,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.440700,0.000000,43.206300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<133.906900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.440700,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.618700,0.000000,43.028300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<134.440700,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.618700,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.618700,0.000000,42.672400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<134.618700,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.618700,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.440700,0.000000,42.494500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<134.440700,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.440700,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.906900,0.000000,42.494500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<133.906900,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.262800,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<134.618700,0.000000,42.138600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<134.262800,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<135.610000,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<135.610000,0.000000,43.206300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<135.610000,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<135.610000,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<135.076200,0.000000,42.672400>}
box{<0,0,-0.101600><0.754978,0.036000,0.101600> rotate<0,-45.002396,0> translate<135.076200,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<135.076200,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<135.788000,0.000000,42.672400>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<135.076200,0.000000,42.672400> }
//R5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<146.050000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<145.669000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<145.669000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<145.161000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<145.161000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<139.319000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<139.319000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<145.415000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<144.653000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<144.653000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<139.700000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.827000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<139.700000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.827000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.319000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.319000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.319000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.319000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<139.065000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<138.811000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<138.430000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<138.430000,0.000000,40.640000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<145.542000,0.000000,40.640000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<138.938000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.463900,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.463900,0.000000,43.206300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<145.463900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.463900,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.997700,0.000000,43.206300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<145.463900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.997700,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.175700,0.000000,43.028300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<145.997700,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.175700,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.175700,0.000000,42.672400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<146.175700,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.175700,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.997700,0.000000,42.494500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<145.997700,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.997700,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.463900,0.000000,42.494500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<145.463900,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<145.819800,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.175700,0.000000,42.138600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<145.819800,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.345000,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.633200,0.000000,43.206300>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<146.633200,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.633200,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.633200,0.000000,42.672400>}
box{<0,0,-0.101600><0.533900,0.036000,0.101600> rotate<0,-90.000000,0> translate<146.633200,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.633200,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.989100,0.000000,42.850400>}
box{<0,0,-0.101600><0.397931,0.036000,0.101600> rotate<0,-26.569737,0> translate<146.633200,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.989100,0.000000,42.850400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.167000,0.000000,42.850400>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,0.000000,0> translate<146.989100,0.000000,42.850400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.167000,0.000000,42.850400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.345000,0.000000,42.672400>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<147.167000,0.000000,42.850400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.345000,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.345000,0.000000,42.316500>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<147.345000,0.000000,42.316500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.345000,0.000000,42.316500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.167000,0.000000,42.138600>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<147.167000,0.000000,42.138600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<147.167000,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.811100,0.000000,42.138600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<146.811100,0.000000,42.138600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.811100,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<146.633200,0.000000,42.316500>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,44.997030,0> translate<146.633200,0.000000,42.316500> }
//R6 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<157.480000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<157.099000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<157.099000,0.000000,40.640000> }
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<156.591000,0.000000,39.751000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<156.591000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<150.749000,0.000000,41.529000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<150.749000,0.000000,39.751000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<156.845000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.591000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.210000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<156.083000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.591000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.210000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<156.083000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,39.497000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<151.130000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,39.624000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,39.624000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.257000,0.000000,39.624000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,41.783000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<151.130000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,41.656000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,41.656000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.257000,0.000000,41.656000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,39.497000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,39.497000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,39.497000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,41.783000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,41.783000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,41.783000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,41.529000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,39.751000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,-90.000000,0> translate<150.495000,0.000000,39.751000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<150.241000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<149.860000,0.000000,40.640000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<149.860000,0.000000,40.640000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<156.972000,0.000000,40.640000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-180.000000,0> translate<150.368000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.893900,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.893900,0.000000,43.206300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<156.893900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.893900,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.427700,0.000000,43.206300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<156.893900,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.427700,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.605700,0.000000,43.028300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<157.427700,0.000000,43.206300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.605700,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.605700,0.000000,42.672400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<157.605700,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.605700,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.427700,0.000000,42.494500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<157.427700,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.427700,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.893900,0.000000,42.494500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<156.893900,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.249800,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<157.605700,0.000000,42.138600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<157.249800,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775000,0.000000,43.206300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.419100,0.000000,43.028300>}
box{<0,0,-0.101600><0.397931,0.036000,0.101600> rotate<0,-26.569737,0> translate<158.419100,0.000000,43.028300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.419100,0.000000,43.028300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.063200,0.000000,42.672400>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<158.063200,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.063200,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.063200,0.000000,42.316500>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<158.063200,0.000000,42.316500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.063200,0.000000,42.316500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.241100,0.000000,42.138600>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,44.997030,0> translate<158.063200,0.000000,42.316500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.241100,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597000,0.000000,42.138600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<158.241100,0.000000,42.138600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597000,0.000000,42.138600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775000,0.000000,42.316500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<158.597000,0.000000,42.138600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775000,0.000000,42.316500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775000,0.000000,42.494500>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,90.000000,0> translate<158.775000,0.000000,42.494500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.775000,0.000000,42.494500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597000,0.000000,42.672400>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,44.980932,0> translate<158.597000,0.000000,42.672400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.597000,0.000000,42.672400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<158.063200,0.000000,42.672400>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<158.063200,0.000000,42.672400> }
//R7 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<115.570000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<115.951000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<115.570000,0.000000,30.480000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<116.459000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<116.459000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<122.301000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<122.301000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.205000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.205000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<116.205000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.459000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.459000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<116.840000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.459000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.459000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.840000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<116.840000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<121.793000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,31.496000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.967000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<121.793000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.793000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<116.967000,0.000000,29.464000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<116.967000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.301000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.920000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.301000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<121.920000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<121.920000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<122.555000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<122.555000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<122.809000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<123.190000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<122.809000,0.000000,30.480000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<116.078000,0.000000,30.480000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<122.682000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.465600,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.465600,0.000000,29.109300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<118.465600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.465600,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.999400,0.000000,29.109300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<118.465600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.999400,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.177400,0.000000,28.931300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<118.999400,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.177400,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.177400,0.000000,28.575400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<119.177400,0.000000,28.575400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.177400,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.999400,0.000000,28.397500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<118.999400,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.999400,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.465600,0.000000,28.397500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<118.465600,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<118.821500,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.177400,0.000000,28.041600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<118.821500,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.634900,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.346700,0.000000,29.109300>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<119.634900,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.346700,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.346700,0.000000,28.931300>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,-90.000000,0> translate<120.346700,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.346700,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.634900,0.000000,28.219500>}
box{<0,0,-0.101600><1.006637,0.036000,0.101600> rotate<0,-44.997030,0> translate<119.634900,0.000000,28.219500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.634900,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<119.634900,0.000000,28.041600>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,-90.000000,0> translate<119.634900,0.000000,28.041600> }
//R8 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<127.000000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<127.381000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<127.000000,0.000000,30.480000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<127.889000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<127.889000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<133.731000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<133.731000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.635000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.635000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<127.635000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.889000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<127.889000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<128.270000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<127.889000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<127.889000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.270000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<128.270000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<133.223000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,31.496000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.397000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<133.223000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.223000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<128.397000,0.000000,29.464000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<128.397000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.731000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.350000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.731000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.350000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<133.350000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.985000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<133.985000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<133.985000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<134.239000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<134.620000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<134.239000,0.000000,30.480000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<127.508000,0.000000,30.480000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<134.112000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.022600,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.022600,0.000000,29.109300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<130.022600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.022600,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.556400,0.000000,29.109300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<130.022600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.556400,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.734400,0.000000,28.931300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<130.556400,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.734400,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.734400,0.000000,28.575400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<130.734400,0.000000,28.575400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.734400,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.556400,0.000000,28.397500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<130.556400,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.556400,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.022600,0.000000,28.397500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<130.022600,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.378500,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<130.734400,0.000000,28.041600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<130.378500,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,29.109300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<131.191900,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,29.109300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<131.369800,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.931300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<131.725700,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.753400>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,-90.000000,0> translate<131.903700,0.000000,28.753400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.753400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,28.575400>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<131.725700,0.000000,28.575400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.397500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,44.980932,0> translate<131.725700,0.000000,28.575400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.219500>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,-90.000000,0> translate<131.903700,0.000000,28.219500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.903700,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,28.041600>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<131.725700,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,28.041600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<131.369800,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.219500>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,44.997030,0> translate<131.191900,0.000000,28.219500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.397500>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,90.000000,0> translate<131.191900,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,28.575400>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,-44.997030,0> translate<131.191900,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.753400>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<131.191900,0.000000,28.753400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.753400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.191900,0.000000,28.931300>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,90.000000,0> translate<131.191900,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.369800,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<131.725700,0.000000,28.575400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<131.369800,0.000000,28.575400> }
//R9 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<138.430000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<138.811000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<138.430000,0.000000,30.480000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<139.319000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<139.319000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<145.161000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<145.161000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.065000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<139.065000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.319000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.319000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<139.700000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.319000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.319000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.700000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<139.700000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<144.653000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,31.496000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.827000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<144.653000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.653000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<139.827000,0.000000,29.464000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<139.827000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.161000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<144.780000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<144.780000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<145.415000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<145.415000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<145.669000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<146.050000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<145.669000,0.000000,30.480000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<138.938000,0.000000,30.480000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<145.542000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.452600,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.452600,0.000000,29.109300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<141.452600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.452600,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.986400,0.000000,29.109300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<141.452600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.986400,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.164400,0.000000,28.931300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<141.986400,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.164400,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.164400,0.000000,28.575400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<142.164400,0.000000,28.575400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.164400,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.986400,0.000000,28.397500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<141.986400,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.986400,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.452600,0.000000,28.397500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<141.452600,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<141.808500,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.164400,0.000000,28.041600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<141.808500,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.621900,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.799800,0.000000,28.041600>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,44.997030,0> translate<142.621900,0.000000,28.219500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.799800,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.155700,0.000000,28.041600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<142.799800,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.155700,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.333700,0.000000,28.219500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<143.155700,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.333700,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.333700,0.000000,28.931300>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,90.000000,0> translate<143.333700,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.333700,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.155700,0.000000,29.109300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<143.155700,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.155700,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.799800,0.000000,29.109300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<142.799800,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.799800,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.621900,0.000000,28.931300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<142.621900,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.621900,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.621900,0.000000,28.753400>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,-90.000000,0> translate<142.621900,0.000000,28.753400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.621900,0.000000,28.753400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.799800,0.000000,28.575400>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<142.621900,0.000000,28.753400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<142.799800,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.333700,0.000000,28.575400>}
box{<0,0,-0.101600><0.533900,0.036000,0.101600> rotate<0,0.000000,0> translate<142.799800,0.000000,28.575400> }
//R10 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<149.860000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<150.241000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<149.860000,0.000000,30.480000> }
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<150.749000,0.000000,31.369000>}
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<150.749000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<156.591000,0.000000,29.591000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<156.591000,0.000000,31.369000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.495000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<150.495000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<151.130000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<150.749000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<150.749000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.130000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<151.130000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,31.623000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<156.083000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,31.496000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,31.496000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.257000,0.000000,31.496000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,29.337000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<156.083000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.083000,0.000000,29.464000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<151.257000,0.000000,29.464000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,0.000000,0> translate<151.257000,0.000000,29.464000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.591000,0.000000,31.623000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,31.623000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.210000,0.000000,31.623000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.591000,0.000000,29.337000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.210000,0.000000,29.337000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,0.000000,0> translate<156.210000,0.000000,29.337000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,29.591000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<156.845000,0.000000,31.369000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,90.000000,0> translate<156.845000,0.000000,31.369000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<157.099000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<157.480000,0.000000,30.480000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,0.000000,0> translate<157.099000,0.000000,30.480000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<150.368000,0.000000,30.480000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-0.000000,0> translate<156.972000,0.000000,30.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.755600,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.755600,0.000000,29.109300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<152.755600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.755600,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.289400,0.000000,29.109300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<152.755600,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.289400,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.467400,0.000000,28.931300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<153.289400,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.467400,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.467400,0.000000,28.575400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<153.467400,0.000000,28.575400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.467400,0.000000,28.575400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.289400,0.000000,28.397500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<153.289400,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.289400,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.755600,0.000000,28.397500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<152.755600,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.111500,0.000000,28.397500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.467400,0.000000,28.041600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<153.111500,0.000000,28.397500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.924900,0.000000,28.753400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<154.280800,0.000000,29.109300>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<153.924900,0.000000,28.753400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<154.280800,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<154.280800,0.000000,28.041600>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,-90.000000,0> translate<154.280800,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<153.924900,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<154.636700,0.000000,28.041600>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<153.924900,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.094200,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.094200,0.000000,28.931300>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,90.000000,0> translate<155.094200,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.094200,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.272100,0.000000,29.109300>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<155.094200,0.000000,28.931300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.272100,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.628000,0.000000,29.109300>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<155.272100,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.628000,0.000000,29.109300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.806000,0.000000,28.931300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<155.628000,0.000000,29.109300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.806000,0.000000,28.931300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.806000,0.000000,28.219500>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,-90.000000,0> translate<155.806000,0.000000,28.219500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.806000,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.628000,0.000000,28.041600>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<155.628000,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.628000,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.272100,0.000000,28.041600>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<155.272100,0.000000,28.041600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.272100,0.000000,28.041600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.094200,0.000000,28.219500>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,44.997030,0> translate<155.094200,0.000000,28.219500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.094200,0.000000,28.219500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.806000,0.000000,28.931300>}
box{<0,0,-0.101600><1.006637,0.036000,0.101600> rotate<0,-44.997030,0> translate<155.094200,0.000000,28.219500> }
//R11 silk screen
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.881000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.881000,0.000000,48.615600>}
box{<0,0,-0.076200><9.626600,0.036000,0.076200> rotate<0,90.000000,0> translate<63.881000,0.000000,48.615600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.881000,0.000000,48.615600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.229000,0.000000,48.615600>}
box{<0,0,-0.076200><9.652000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.229000,0.000000,48.615600> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.229000,0.000000,48.615600>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.229000,0.000000,38.989000>}
box{<0,0,-0.076200><9.626600,0.036000,0.076200> rotate<0,-90.000000,0> translate<54.229000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.724800,0.000000,42.240200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.359800,0.000000,42.240200>}
box{<0,0,-0.127000><0.635000,0.036000,0.127000> rotate<0,0.000000,0> translate<58.724800,0.000000,42.240200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.359800,0.000000,42.240200>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.359800,0.000000,44.450000>}
box{<0,0,-0.127000><2.209800,0.036000,0.127000> rotate<0,90.000000,0> translate<59.359800,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.359800,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.436000,0.000000,44.450000>}
box{<0,0,-0.127000><0.076200,0.036000,0.127000> rotate<0,0.000000,0> translate<59.359800,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.690000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.055000,0.000000,45.720000>}
box{<0,0,-0.127000><1.419903,0.036000,0.127000> rotate<0,63.430762,0> translate<59.055000,0.000000,45.720000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.055000,0.000000,45.720000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.420000,0.000000,44.450000>}
box{<0,0,-0.127000><1.419903,0.036000,0.127000> rotate<0,-63.430762,0> translate<58.420000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.724800,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.724800,0.000000,42.240200>}
box{<0,0,-0.127000><2.209800,0.036000,0.127000> rotate<0,-90.000000,0> translate<58.724800,0.000000,42.240200> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.055000,0.000000,42.291000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.928000,0.000000,42.291000>}
box{<0,0,-0.127000><0.127000,0.036000,0.127000> rotate<0,0.000000,0> translate<58.928000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.928000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.928000,0.000000,42.291000>}
box{<0,0,-0.127000><3.048000,0.036000,0.127000> rotate<0,-90.000000,0> translate<58.928000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.928000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.182000,0.000000,45.339000>}
box{<0,0,-0.127000><0.254000,0.036000,0.127000> rotate<0,0.000000,0> translate<58.928000,0.000000,45.339000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.182000,0.000000,45.339000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.182000,0.000000,42.291000>}
box{<0,0,-0.127000><3.048000,0.036000,0.127000> rotate<0,-90.000000,0> translate<59.182000,0.000000,42.291000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.309000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.359800,0.000000,44.450000>}
box{<0,0,-0.127000><0.050800,0.036000,0.127000> rotate<0,0.000000,0> translate<59.309000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.436000,0.000000,44.831000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.436000,0.000000,44.450000>}
box{<0,0,-0.127000><0.381000,0.036000,0.127000> rotate<0,-90.000000,0> translate<59.436000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.436000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<59.690000,0.000000,44.450000>}
box{<0,0,-0.127000><0.254000,0.036000,0.127000> rotate<0,0.000000,0> translate<59.436000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.420000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.674000,0.000000,44.450000>}
box{<0,0,-0.127000><0.254000,0.036000,0.127000> rotate<0,0.000000,0> translate<58.420000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.724800,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.801000,0.000000,44.450000>}
box{<0,0,-0.127000><0.076200,0.036000,0.127000> rotate<0,0.000000,0> translate<58.724800,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.674000,0.000000,44.831000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.674000,0.000000,44.450000>}
box{<0,0,-0.127000><0.381000,0.036000,0.127000> rotate<0,-90.000000,0> translate<58.674000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.674000,0.000000,44.450000>}
cylinder{<0,0,0><0,0.036000,0>0.127000 translate<58.724800,0.000000,44.450000>}
box{<0,0,-0.127000><0.050800,0.036000,0.127000> rotate<0,0.000000,0> translate<58.674000,0.000000,44.450000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<54.229000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,38.989000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<54.229000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,39.878000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,38.989000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<55.245000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<63.881000,0.000000,38.989000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,38.989000>}
box{<0,0,-0.076200><1.016000,0.036000,0.076200> rotate<0,0.000000,0> translate<62.865000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,39.878000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,38.989000>}
box{<0,0,-0.076200><0.889000,0.036000,0.076200> rotate<0,-90.000000,0> translate<62.865000,0.000000,38.989000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<62.865000,0.000000,39.878000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<55.245000,0.000000,39.878000>}
box{<0,0,-0.076200><7.620000,0.036000,0.076200> rotate<0,0.000000,0> translate<55.245000,0.000000,39.878000> }
object{ARC(2.159000,0.254000,90.000000,249.443023,0.036000) translate<59.055000,0.000000,43.815000>}
object{ARC(2.159000,0.254000,290.556977,450.000000,0.036000) translate<59.055000,0.000000,43.815000>}
object{ARC(3.556000,0.152400,58.571733,90.001611,0.036000) translate<59.055100,0.000000,43.815000>}
object{ARC(3.556000,0.152400,90.001611,120.964862,0.036000) translate<59.055100,0.000000,43.815000>}
object{ARC(3.556000,0.152400,270.000000,390.962651,0.036000) translate<59.055000,0.000000,43.815000>}
object{ARC(3.556000,0.152400,150.256318,270.000000,0.036000) translate<59.055000,0.000000,43.815100>}
object{ARC(2.159000,0.254000,245.226157,270.000000,0.036000) translate<59.055000,0.000000,43.815000>}
object{ARC(2.159000,0.254000,270.000000,296.563864,0.036000) translate<59.055000,0.000000,43.815000>}
object{ARC(3.556000,0.152400,118.443932,180.001611,0.036000) translate<59.055000,0.000000,43.815100>}
object{ARC(3.556000,0.152400,0.000000,63.434949,0.036000) translate<59.055000,0.000000,43.815000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.727600,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.727600,0.000000,39.269300>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,90.000000,0> translate<55.727600,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.727600,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.261400,0.000000,39.269300>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<55.727600,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.261400,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.439400,0.000000,39.091300>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<56.261400,0.000000,39.269300> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.439400,0.000000,39.091300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.439400,0.000000,38.735400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<56.439400,0.000000,38.735400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.439400,0.000000,38.735400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.261400,0.000000,38.557500>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-44.980932,0> translate<56.261400,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.261400,0.000000,38.557500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<55.727600,0.000000,38.557500>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,0.000000,0> translate<55.727600,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.083500,0.000000,38.557500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.439400,0.000000,38.201600>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<56.083500,0.000000,38.557500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.896900,0.000000,38.913400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.252800,0.000000,39.269300>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<56.896900,0.000000,38.913400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.252800,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.252800,0.000000,38.201600>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,-90.000000,0> translate<57.252800,0.000000,38.201600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<56.896900,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<57.608700,0.000000,38.201600>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<56.896900,0.000000,38.201600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.066200,0.000000,38.913400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.422100,0.000000,39.269300>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<58.066200,0.000000,38.913400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.422100,0.000000,39.269300>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.422100,0.000000,38.201600>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,-90.000000,0> translate<58.422100,0.000000,38.201600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.066200,0.000000,38.201600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<58.778000,0.000000,38.201600>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,0.000000,0> translate<58.066200,0.000000,38.201600> }
//R13 silk screen
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<82.550000,0.000000,40.005000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<82.550000,0.000000,40.386000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<82.550000,0.000000,40.386000> }
object{ARC(0.254000,0.152400,180.000000,270.000000,0.036000) translate<81.661000,0.000000,40.894000>}
object{ARC(0.254000,0.152400,270.000000,360.000000,0.036000) translate<83.439000,0.000000,40.894000>}
object{ARC(0.254000,0.152400,0.000000,90.000000,0.036000) translate<83.439000,0.000000,46.736000>}
object{ARC(0.254000,0.152400,90.000000,180.000000,0.036000) translate<81.661000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,40.640000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.661000,0.000000,40.640000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.661000,0.000000,40.640000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,41.275000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<81.407000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,41.402000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,41.275000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<81.407000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,40.894000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,41.275000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,90.000000,0> translate<83.693000,0.000000,41.275000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,41.402000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,41.275000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<83.566000,0.000000,41.402000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,46.228000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,46.355000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,44.997030,0> translate<81.407000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,46.228000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.534000,0.000000,41.402000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<81.534000,0.000000,41.402000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,46.228000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,46.355000>}
box{<0,0,-0.076200><0.179605,0.036000,0.076200> rotate<0,-44.997030,0> translate<83.566000,0.000000,46.228000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,46.228000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.566000,0.000000,41.402000>}
box{<0,0,-0.076200><4.826000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.566000,0.000000,41.402000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.407000,0.000000,46.355000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<81.407000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,46.736000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.693000,0.000000,46.355000>}
box{<0,0,-0.076200><0.381000,0.036000,0.076200> rotate<0,-90.000000,0> translate<83.693000,0.000000,46.355000> }
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<83.439000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.076200 translate<81.661000,0.000000,46.990000>}
box{<0,0,-0.076200><1.778000,0.036000,0.076200> rotate<0,0.000000,0> translate<81.661000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<82.550000,0.000000,47.244000>}
cylinder{<0,0,0><0,0.036000,0>0.304800 translate<82.550000,0.000000,47.625000>}
box{<0,0,-0.304800><0.381000,0.036000,0.304800> rotate<0,90.000000,0> translate<82.550000,0.000000,47.625000> }
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<82.550000,0.000000,40.513000>}
box{<-0.127000,0,-0.304800><0.127000,0.036000,0.304800> rotate<0,-90.000000,0> translate<82.550000,0.000000,47.117000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,41.376600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,41.376600>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<79.983700,0.000000,41.376600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,41.376600>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,41.910400>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,90.000000,0> translate<79.983700,0.000000,41.910400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,41.910400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.161700,0.000000,42.088400>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<79.983700,0.000000,41.910400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.161700,0.000000,42.088400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.517600,0.000000,42.088400>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,0.000000,0> translate<80.161700,0.000000,42.088400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.517600,0.000000,42.088400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.695500,0.000000,41.910400>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<80.517600,0.000000,42.088400> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.695500,0.000000,41.910400>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.695500,0.000000,41.376600>}
box{<0,0,-0.101600><0.533800,0.036000,0.101600> rotate<0,-90.000000,0> translate<80.695500,0.000000,41.376600> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.695500,0.000000,41.732500>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,42.088400>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,-44.997030,0> translate<80.695500,0.000000,41.732500> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.339600,0.000000,42.545900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,42.901800>}
box{<0,0,-0.101600><0.503319,0.036000,0.101600> rotate<0,44.997030,0> translate<79.983700,0.000000,42.901800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,42.901800>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,42.901800>}
box{<0,0,-0.101600><1.067700,0.036000,0.101600> rotate<0,0.000000,0> translate<79.983700,0.000000,42.901800> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,42.545900>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,43.257700>}
box{<0,0,-0.101600><0.711800,0.036000,0.101600> rotate<0,90.000000,0> translate<81.051400,0.000000,43.257700> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.161700,0.000000,43.715200>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,43.893100>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,44.980932,0> translate<79.983700,0.000000,43.893100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,43.893100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,44.249000>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,90.000000,0> translate<79.983700,0.000000,44.249000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<79.983700,0.000000,44.249000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.161700,0.000000,44.427000>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,-44.997030,0> translate<79.983700,0.000000,44.249000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.161700,0.000000,44.427000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.339600,0.000000,44.427000>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,0.000000,0> translate<80.161700,0.000000,44.427000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.339600,0.000000,44.427000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.517600,0.000000,44.249000>}
box{<0,0,-0.101600><0.251730,0.036000,0.101600> rotate<0,44.997030,0> translate<80.339600,0.000000,44.427000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.517600,0.000000,44.249000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.517600,0.000000,44.071100>}
box{<0,0,-0.101600><0.177900,0.036000,0.101600> rotate<0,-90.000000,0> translate<80.517600,0.000000,44.071100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.517600,0.000000,44.249000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.695500,0.000000,44.427000>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,-45.013128,0> translate<80.517600,0.000000,44.249000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.695500,0.000000,44.427000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.873500,0.000000,44.427000>}
box{<0,0,-0.101600><0.178000,0.036000,0.101600> rotate<0,0.000000,0> translate<80.695500,0.000000,44.427000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.873500,0.000000,44.427000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,44.249000>}
box{<0,0,-0.101600><0.251659,0.036000,0.101600> rotate<0,45.013128,0> translate<80.873500,0.000000,44.427000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,44.249000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,43.893100>}
box{<0,0,-0.101600><0.355900,0.036000,0.101600> rotate<0,-90.000000,0> translate<81.051400,0.000000,43.893100> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<81.051400,0.000000,43.893100>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<80.873500,0.000000,43.715200>}
box{<0,0,-0.101600><0.251589,0.036000,0.101600> rotate<0,-44.997030,0> translate<80.873500,0.000000,43.715200> }
//S1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.540000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.540000,0.000000,44.180000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<2.540000,0.000000,44.180000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.540000,0.000000,44.480000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.540000,0.000000,46.990000>}
box{<0,0,-0.101600><2.510000,0.036000,0.101600> rotate<0,90.000000,0> translate<2.540000,0.000000,46.990000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<2.540000,0.000000,47.260000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.540000,0.000000,48.260000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<2.540000,0.000000,47.260000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.540000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.620000,0.000000,48.260000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.540000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.620000,0.000000,48.260000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,47.260000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<6.620000,0.000000,48.260000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,46.960000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,44.480000>}
box{<0,0,-0.101600><2.480000,0.036000,0.101600> rotate<0,-90.000000,0> translate<7.620000,0.000000,44.480000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<7.620000,0.000000,44.180000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.620000,0.000000,43.180000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<6.620000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<6.620000,0.000000,43.180000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<3.540000,0.000000,43.180000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<3.540000,0.000000,43.180000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.985000,0.000000,46.990000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.985000,0.000000,46.165000>}
box{<0,0,-0.063500><0.825000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.985000,0.000000,46.165000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.985000,0.000000,46.165000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.240000,0.000000,45.710000>}
box{<0,0,-0.063500><0.521584,0.036000,0.063500> rotate<0,60.727997,0> translate<6.985000,0.000000,46.165000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.985000,0.000000,45.490000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<6.985000,0.000000,44.605000>}
box{<0,0,-0.063500><0.885000,0.036000,0.063500> rotate<0,-90.000000,0> translate<6.985000,0.000000,44.605000> }
difference{
cylinder{<5.080000,0,45.720000><5.080000,0.036000,45.720000>1.371600 translate<0,0.000000,0>}
cylinder{<5.080000,-0.1,45.720000><5.080000,0.135000,45.720000>1.168400 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.457900,0.000000,47.828400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.394300,0.000000,47.892000>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<4.394300,0.000000,47.892000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.394300,0.000000,47.892000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.267200,0.000000,47.892000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<4.267200,0.000000,47.892000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.267200,0.000000,47.892000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.203700,0.000000,47.828400>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<4.203700,0.000000,47.828400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.203700,0.000000,47.828400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.203700,0.000000,47.764900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,-90.000000,0> translate<4.203700,0.000000,47.764900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.203700,0.000000,47.764900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.267200,0.000000,47.701300>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,45.042106,0> translate<4.203700,0.000000,47.764900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.267200,0.000000,47.701300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.394300,0.000000,47.701300>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<4.267200,0.000000,47.701300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.394300,0.000000,47.701300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.457900,0.000000,47.637800>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,44.951954,0> translate<4.394300,0.000000,47.701300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.457900,0.000000,47.637800>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.457900,0.000000,47.574200>}
box{<0,0,-0.012700><0.063600,0.036000,0.012700> rotate<0,-90.000000,0> translate<4.457900,0.000000,47.574200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.457900,0.000000,47.574200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.394300,0.000000,47.510700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<4.394300,0.000000,47.510700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.394300,0.000000,47.510700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.267200,0.000000,47.510700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<4.267200,0.000000,47.510700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.267200,0.000000,47.510700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.203700,0.000000,47.574200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<4.203700,0.000000,47.574200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.577900,0.000000,47.764900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.705000,0.000000,47.892000>}
box{<0,0,-0.012700><0.179747,0.036000,0.012700> rotate<0,-44.997030,0> translate<4.577900,0.000000,47.764900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.705000,0.000000,47.892000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.705000,0.000000,47.510700>}
box{<0,0,-0.012700><0.381300,0.036000,0.012700> rotate<0,-90.000000,0> translate<4.705000,0.000000,47.510700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.577900,0.000000,47.510700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<4.832100,0.000000,47.510700>}
box{<0,0,-0.012700><0.254200,0.036000,0.012700> rotate<0,0.000000,0> translate<4.577900,0.000000,47.510700> }
//S2 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<117.840000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<116.840000,0.000000,34.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<116.840000,0.000000,34.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<116.840000,0.000000,34.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<116.840000,0.000000,36.830000>}
box{<0,0,-0.101600><2.510000,0.036000,0.101600> rotate<0,90.000000,0> translate<116.840000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<116.840000,0.000000,37.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<117.840000,0.000000,38.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<116.840000,0.000000,37.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<117.840000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.920000,0.000000,38.100000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<117.840000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.920000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<121.920000,0.000000,37.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<120.920000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<121.920000,0.000000,36.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<121.920000,0.000000,34.320000>}
box{<0,0,-0.101600><2.480000,0.036000,0.101600> rotate<0,-90.000000,0> translate<121.920000,0.000000,34.320000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<121.920000,0.000000,34.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.920000,0.000000,33.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<120.920000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<120.920000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<117.840000,0.000000,33.020000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<117.840000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.285000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.285000,0.000000,36.005000>}
box{<0,0,-0.063500><0.825000,0.036000,0.063500> rotate<0,-90.000000,0> translate<121.285000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.285000,0.000000,36.005000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.540000,0.000000,35.550000>}
box{<0,0,-0.063500><0.521584,0.036000,0.063500> rotate<0,60.727997,0> translate<121.285000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.285000,0.000000,35.330000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<121.285000,0.000000,34.445000>}
box{<0,0,-0.063500><0.885000,0.036000,0.063500> rotate<0,-90.000000,0> translate<121.285000,0.000000,34.445000> }
difference{
cylinder{<119.380000,0,35.560000><119.380000,0.036000,35.560000>1.371600 translate<0,0.000000,0>}
cylinder{<119.380000,-0.1,35.560000><119.380000,0.135000,35.560000>1.168400 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.757900,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.694300,0.000000,37.732000>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<118.694300,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.694300,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.567200,0.000000,37.732000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<118.567200,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.567200,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.503700,0.000000,37.668400>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<118.503700,0.000000,37.668400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.503700,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.503700,0.000000,37.604900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,-90.000000,0> translate<118.503700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.503700,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.567200,0.000000,37.541300>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,45.042106,0> translate<118.503700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.567200,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.694300,0.000000,37.541300>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<118.567200,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.694300,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.757900,0.000000,37.477800>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,44.951954,0> translate<118.694300,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.757900,0.000000,37.477800>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.757900,0.000000,37.414200>}
box{<0,0,-0.012700><0.063600,0.036000,0.012700> rotate<0,-90.000000,0> translate<118.757900,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.757900,0.000000,37.414200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.694300,0.000000,37.350700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<118.694300,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.694300,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.567200,0.000000,37.350700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<118.567200,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.567200,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.503700,0.000000,37.414200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<118.503700,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.132100,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.877900,0.000000,37.350700>}
box{<0,0,-0.012700><0.254200,0.036000,0.012700> rotate<0,0.000000,0> translate<118.877900,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.877900,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.132100,0.000000,37.604900>}
box{<0,0,-0.012700><0.359493,0.036000,0.012700> rotate<0,-44.997030,0> translate<118.877900,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.132100,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.132100,0.000000,37.668400>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,90.000000,0> translate<119.132100,0.000000,37.668400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.132100,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.068500,0.000000,37.732000>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<119.068500,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<119.068500,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.941400,0.000000,37.732000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<118.941400,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.941400,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<118.877900,0.000000,37.668400>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<118.877900,0.000000,37.668400> }
//S3 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<129.270000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<128.270000,0.000000,34.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<128.270000,0.000000,34.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<128.270000,0.000000,34.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<128.270000,0.000000,36.830000>}
box{<0,0,-0.101600><2.510000,0.036000,0.101600> rotate<0,90.000000,0> translate<128.270000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<128.270000,0.000000,37.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<129.270000,0.000000,38.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<128.270000,0.000000,37.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<129.270000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<132.350000,0.000000,38.100000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<129.270000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<132.350000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.350000,0.000000,37.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<132.350000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.350000,0.000000,36.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.350000,0.000000,34.320000>}
box{<0,0,-0.101600><2.480000,0.036000,0.101600> rotate<0,-90.000000,0> translate<133.350000,0.000000,34.320000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<133.350000,0.000000,34.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<132.350000,0.000000,33.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<132.350000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<132.350000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<129.270000,0.000000,33.020000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<129.270000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<132.715000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<132.715000,0.000000,36.005000>}
box{<0,0,-0.063500><0.825000,0.036000,0.063500> rotate<0,-90.000000,0> translate<132.715000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<132.715000,0.000000,36.005000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<132.970000,0.000000,35.550000>}
box{<0,0,-0.063500><0.521584,0.036000,0.063500> rotate<0,60.727997,0> translate<132.715000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<132.715000,0.000000,35.330000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<132.715000,0.000000,34.445000>}
box{<0,0,-0.063500><0.885000,0.036000,0.063500> rotate<0,-90.000000,0> translate<132.715000,0.000000,34.445000> }
difference{
cylinder{<130.810000,0,35.560000><130.810000,0.036000,35.560000>1.371600 translate<0,0.000000,0>}
cylinder{<130.810000,-0.1,35.560000><130.810000,0.135000,35.560000>1.168400 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.187900,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.124300,0.000000,37.732000>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<130.124300,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.124300,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.997200,0.000000,37.732000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<129.997200,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.997200,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.933700,0.000000,37.668400>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<129.933700,0.000000,37.668400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.933700,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.933700,0.000000,37.604900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,-90.000000,0> translate<129.933700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.933700,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.997200,0.000000,37.541300>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,45.042106,0> translate<129.933700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.997200,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.124300,0.000000,37.541300>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<129.997200,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.124300,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.187900,0.000000,37.477800>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,44.951954,0> translate<130.124300,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.187900,0.000000,37.477800>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.187900,0.000000,37.414200>}
box{<0,0,-0.012700><0.063600,0.036000,0.012700> rotate<0,-90.000000,0> translate<130.187900,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.187900,0.000000,37.414200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.124300,0.000000,37.350700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<130.124300,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.124300,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.997200,0.000000,37.350700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<129.997200,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.997200,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<129.933700,0.000000,37.414200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<129.933700,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.307900,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.371400,0.000000,37.732000>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<130.307900,0.000000,37.668400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.371400,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.732000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<130.371400,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.668400>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<130.498500,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.604900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,-90.000000,0> translate<130.562100,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.541300>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,-44.997030,0> translate<130.498500,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.435000,0.000000,37.541300>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,0.000000,0> translate<130.435000,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.477800>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,44.951954,0> translate<130.498500,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.477800>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.414200>}
box{<0,0,-0.012700><0.063600,0.036000,0.012700> rotate<0,-90.000000,0> translate<130.562100,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.562100,0.000000,37.414200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.350700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<130.498500,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.498500,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.371400,0.000000,37.350700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<130.371400,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.371400,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<130.307900,0.000000,37.414200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<130.307900,0.000000,37.414200> }
//S4 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<140.700000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<139.700000,0.000000,34.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<139.700000,0.000000,34.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<139.700000,0.000000,34.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<139.700000,0.000000,36.830000>}
box{<0,0,-0.101600><2.510000,0.036000,0.101600> rotate<0,90.000000,0> translate<139.700000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<139.700000,0.000000,37.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<140.700000,0.000000,38.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<139.700000,0.000000,37.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<140.700000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.780000,0.000000,38.100000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<140.700000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.780000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<144.780000,0.000000,37.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<143.780000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<144.780000,0.000000,36.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<144.780000,0.000000,34.320000>}
box{<0,0,-0.101600><2.480000,0.036000,0.101600> rotate<0,-90.000000,0> translate<144.780000,0.000000,34.320000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<144.780000,0.000000,34.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.780000,0.000000,33.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<143.780000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<143.780000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<140.700000,0.000000,33.020000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<140.700000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<144.145000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<144.145000,0.000000,36.005000>}
box{<0,0,-0.063500><0.825000,0.036000,0.063500> rotate<0,-90.000000,0> translate<144.145000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<144.145000,0.000000,36.005000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<144.400000,0.000000,35.550000>}
box{<0,0,-0.063500><0.521584,0.036000,0.063500> rotate<0,60.727997,0> translate<144.145000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<144.145000,0.000000,35.330000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<144.145000,0.000000,34.445000>}
box{<0,0,-0.063500><0.885000,0.036000,0.063500> rotate<0,-90.000000,0> translate<144.145000,0.000000,34.445000> }
difference{
cylinder{<142.240000,0,35.560000><142.240000,0.036000,35.560000>1.371600 translate<0,0.000000,0>}
cylinder{<142.240000,-0.1,35.560000><142.240000,0.135000,35.560000>1.168400 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.617900,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.554300,0.000000,37.732000>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<141.554300,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.554300,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.427200,0.000000,37.732000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<141.427200,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.427200,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.363700,0.000000,37.668400>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<141.363700,0.000000,37.668400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.363700,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.363700,0.000000,37.604900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,-90.000000,0> translate<141.363700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.363700,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.427200,0.000000,37.541300>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,45.042106,0> translate<141.363700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.427200,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.554300,0.000000,37.541300>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<141.427200,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.554300,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.617900,0.000000,37.477800>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,44.951954,0> translate<141.554300,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.617900,0.000000,37.477800>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.617900,0.000000,37.414200>}
box{<0,0,-0.012700><0.063600,0.036000,0.012700> rotate<0,-90.000000,0> translate<141.617900,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.617900,0.000000,37.414200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.554300,0.000000,37.350700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<141.554300,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.554300,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.427200,0.000000,37.350700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<141.427200,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.427200,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.363700,0.000000,37.414200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<141.363700,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.928500,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.928500,0.000000,37.732000>}
box{<0,0,-0.012700><0.381300,0.036000,0.012700> rotate<0,90.000000,0> translate<141.928500,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.928500,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.737900,0.000000,37.541300>}
box{<0,0,-0.012700><0.269620,0.036000,0.012700> rotate<0,-45.012056,0> translate<141.737900,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.737900,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<141.992100,0.000000,37.541300>}
box{<0,0,-0.012700><0.254200,0.036000,0.012700> rotate<0,0.000000,0> translate<141.737900,0.000000,37.541300> }
//S5 silk screen
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.130000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<151.130000,0.000000,34.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<151.130000,0.000000,34.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<151.130000,0.000000,34.320000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<151.130000,0.000000,36.830000>}
box{<0,0,-0.101600><2.510000,0.036000,0.101600> rotate<0,90.000000,0> translate<151.130000,0.000000,36.830000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<151.130000,0.000000,37.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.130000,0.000000,38.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<151.130000,0.000000,37.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.130000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.210000,0.000000,38.100000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<152.130000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.210000,0.000000,38.100000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.210000,0.000000,37.100000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,44.997030,0> translate<155.210000,0.000000,38.100000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.210000,0.000000,36.800000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.210000,0.000000,34.320000>}
box{<0,0,-0.101600><2.480000,0.036000,0.101600> rotate<0,-90.000000,0> translate<156.210000,0.000000,34.320000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<156.210000,0.000000,34.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.210000,0.000000,33.020000>}
box{<0,0,-0.101600><1.414214,0.036000,0.101600> rotate<0,-44.997030,0> translate<155.210000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<155.210000,0.000000,33.020000>}
cylinder{<0,0,0><0,0.036000,0>0.101600 translate<152.130000,0.000000,33.020000>}
box{<0,0,-0.101600><3.080000,0.036000,0.101600> rotate<0,0.000000,0> translate<152.130000,0.000000,33.020000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<155.575000,0.000000,36.830000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<155.575000,0.000000,36.005000>}
box{<0,0,-0.063500><0.825000,0.036000,0.063500> rotate<0,-90.000000,0> translate<155.575000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<155.575000,0.000000,36.005000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<155.830000,0.000000,35.550000>}
box{<0,0,-0.063500><0.521584,0.036000,0.063500> rotate<0,60.727997,0> translate<155.575000,0.000000,36.005000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<155.575000,0.000000,35.330000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<155.575000,0.000000,34.445000>}
box{<0,0,-0.063500><0.885000,0.036000,0.063500> rotate<0,-90.000000,0> translate<155.575000,0.000000,34.445000> }
difference{
cylinder{<153.670000,0,35.560000><153.670000,0.036000,35.560000>1.371600 translate<0,0.000000,0>}
cylinder{<153.670000,-0.1,35.560000><153.670000,0.135000,35.560000>1.168400 translate<0,0.000000,0>}}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.047900,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.984300,0.000000,37.732000>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<152.984300,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.984300,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.857200,0.000000,37.732000>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<152.857200,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.857200,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.793700,0.000000,37.668400>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-45.042106,0> translate<152.793700,0.000000,37.668400> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.793700,0.000000,37.668400>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.793700,0.000000,37.604900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,-90.000000,0> translate<152.793700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.793700,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.857200,0.000000,37.541300>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,45.042106,0> translate<152.793700,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.857200,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.984300,0.000000,37.541300>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<152.857200,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.984300,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.047900,0.000000,37.477800>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,44.951954,0> translate<152.984300,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.047900,0.000000,37.477800>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.047900,0.000000,37.414200>}
box{<0,0,-0.012700><0.063600,0.036000,0.012700> rotate<0,-90.000000,0> translate<153.047900,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.047900,0.000000,37.414200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.984300,0.000000,37.350700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<152.984300,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.984300,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.857200,0.000000,37.350700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<152.857200,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.857200,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<152.793700,0.000000,37.414200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<152.793700,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.422100,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.167900,0.000000,37.732000>}
box{<0,0,-0.012700><0.254200,0.036000,0.012700> rotate<0,0.000000,0> translate<153.167900,0.000000,37.732000> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.167900,0.000000,37.732000>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.167900,0.000000,37.541300>}
box{<0,0,-0.012700><0.190700,0.036000,0.012700> rotate<0,-90.000000,0> translate<153.167900,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.167900,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.295000,0.000000,37.604900>}
box{<0,0,-0.012700><0.142124,0.036000,0.012700> rotate<0,-26.581326,0> translate<153.167900,0.000000,37.541300> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.295000,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.358500,0.000000,37.604900>}
box{<0,0,-0.012700><0.063500,0.036000,0.012700> rotate<0,0.000000,0> translate<153.295000,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.358500,0.000000,37.604900>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.422100,0.000000,37.541300>}
box{<0,0,-0.012700><0.089944,0.036000,0.012700> rotate<0,44.997030,0> translate<153.358500,0.000000,37.604900> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.422100,0.000000,37.541300>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.422100,0.000000,37.414200>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,-90.000000,0> translate<153.422100,0.000000,37.414200> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.422100,0.000000,37.414200>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.358500,0.000000,37.350700>}
box{<0,0,-0.012700><0.089873,0.036000,0.012700> rotate<0,-44.951954,0> translate<153.358500,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.358500,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.231400,0.000000,37.350700>}
box{<0,0,-0.012700><0.127100,0.036000,0.012700> rotate<0,0.000000,0> translate<153.231400,0.000000,37.350700> }
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.231400,0.000000,37.350700>}
cylinder{<0,0,0><0,0.036000,0>0.012700 translate<153.167900,0.000000,37.414200>}
box{<0,0,-0.012700><0.089803,0.036000,0.012700> rotate<0,44.997030,0> translate<153.167900,0.000000,37.414200> }
//X1 silk screen
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.270000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.270000,0.000000,1.270000>}
box{<0,0,-0.063500><80.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<1.270000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.270000,0.000000,1.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.270000,0.000000,37.270000>}
box{<0,0,-0.063500><36.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<81.270000,0.000000,37.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<81.270000,0.000000,37.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.270000,0.000000,37.270000>}
box{<0,0,-0.063500><80.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<1.270000,0.000000,37.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.270000,0.000000,37.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<1.270000,0.000000,1.270000>}
box{<0,0,-0.063500><36.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<1.270000,0.000000,1.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.270000,0.000000,31.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.270000,0.000000,31.270000>}
box{<0,0,-0.063500><72.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<5.270000,0.000000,31.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.270000,0.000000,31.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.270000,0.000000,7.270000>}
box{<0,0,-0.063500><24.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<77.270000,0.000000,7.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<77.270000,0.000000,7.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.270000,0.000000,7.270000>}
box{<0,0,-0.063500><72.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<5.270000,0.000000,7.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.270000,0.000000,7.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<5.270000,0.000000,31.270000>}
box{<0,0,-0.063500><24.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<5.270000,0.000000,31.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,29.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,29.270000>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<7.270000,0.000000,29.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,29.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,28.270000>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<75.270000,0.000000,28.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,28.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,28.270000>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<7.270000,0.000000,28.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,28.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,29.270000>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<7.270000,0.000000,29.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,9.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,9.270000>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<7.270000,0.000000,9.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,9.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,10.270000>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<75.270000,0.000000,10.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<75.270000,0.000000,10.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,10.270000>}
box{<0,0,-0.063500><68.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<7.270000,0.000000,10.270000> }
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,10.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<7.270000,0.000000,9.270000>}
box{<0,0,-0.063500><1.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<7.270000,0.000000,9.270000> }
object{ARC(3.000000,0.127000,90.000000,180.000000,0.036000) translate<12.270000,0.000000,23.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.270000,0.000000,23.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<9.270000,0.000000,15.270000>}
box{<0,0,-0.063500><8.000000,0.036000,0.063500> rotate<0,-90.000000,0> translate<9.270000,0.000000,15.270000> }
object{ARC(3.000000,0.127000,180.000000,270.000000,0.036000) translate<12.270000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.270000,0.000000,12.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<70.270000,0.000000,12.270000>}
box{<0,0,-0.063500><58.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.270000,0.000000,12.270000> }
object{ARC(3.000000,0.127000,270.000000,360.000000,0.036000) translate<70.270000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.270000,0.000000,15.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<73.270000,0.000000,23.270000>}
box{<0,0,-0.063500><8.000000,0.036000,0.063500> rotate<0,90.000000,0> translate<73.270000,0.000000,23.270000> }
object{ARC(3.000000,0.127000,0.000000,90.000000,0.036000) translate<70.270000,0.000000,23.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<70.270000,0.000000,26.270000>}
cylinder{<0,0,0><0,0.036000,0>0.063500 translate<12.270000,0.000000,26.270000>}
box{<0,0,-0.063500><58.000000,0.036000,0.063500> rotate<0,0.000000,0> translate<12.270000,0.000000,26.270000> }
texture{col_slk}
}
#end
translate<mac_x_ver,mac_y_ver,mac_z_ver>
rotate<mac_x_rot,mac_y_rot,mac_z_rot>
}//End union
#end

#if(use_file_as_inc=off)
object{  HEADER(-79.946500,0,-25.362000,pcb_rotate_x,pcb_rotate_y,pcb_rotate_z)
#if(pcb_upsidedown=on)
rotate pcb_rotdir*180
#end
}
#end


//Parts not found in 3dpack.dat or 3dusrpac.dat are:
//LOGO1	OSHW_LOGO_10MILX0350-NT	OSHW_10X350_NOTEXT

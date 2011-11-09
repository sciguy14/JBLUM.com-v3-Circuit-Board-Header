#ifndef(__local_lcd_inc)
#declare __local_lcd_inc = true;

//grid spacing in mm
#declare USER_GRID = 2.54;

#declare USER_PCB_THICKNESS = 1.68;

//#declare USER_LCD_FONT = "lcd5x8.ttf";
#declare USER_LCD_FONT = "alphalcd.ttf";

#ifndef(USER_LCD_MESSAGE_1)
#declare USER_LCD_MESSAGE_1 = "16x2 LCD Module";
#end
#ifndef(USER_LCD_MESSAGE_2)
#declare USER_LCD_MESSAGE_2 = "0123456789012345";
#end
#ifndef(USER_LCD_MESSAGE_3)
#declare USER_LCD_MESSAGE_3 = "0123456789012345";
#end
#ifndef(USER_LCD_MESSAGE_4)
#declare USER_LCD_MESSAGE_4 = "0123456789012345";
#end

#ifndef(col_lcd_bg)
#declare col_lcd_bg =
texture {
	pigment {
		color rgb <0.55, 0.55, 0.55>
	}
	finish {
		ambient 0.30
		brilliance 3
		diffuse 0.4
		metallic
		specular 0.70
		roughness 1/60
		reflection 0.25
	}
}
// finish {
// 	ambient 0.35
// 	brilliance 2
// 	diffuse 0.3
// 	metallic
// 	specular 0.80
// 	roughness 1/20
// 	reflection 0.1
// }

#end
#ifndef(col_lcd_fg)
#declare col_lcd_fg =
texture {
	pigment {
		color rgb <0, 0, 0>             //.15
	}
	finish {
		ambient 0.30
		brilliance 3
		diffuse 0.4
		metallic
		specular 0.70
		roughness 1/60
		reflection 0.25
	}
}
#end

//#declare USER_LCD_PAD =
#macro USER_LCD_PAD(n)
difference {
	union {
		box { <-1, 0.01, 0>, <1, 0, 2> }
		cylinder { <0, 0.01, 0>, <0, 0, 0>, 1 }
	}
	cylinder { <0, 0.1, 0>, <0, -0.1, 0>, 0.5 }
	translate <(USER_GRID*n),0,0>
}
#end


#macro USER_LCD_16X2()
	union {

//	prism{
//		-1.500000,0.000000,8
//		<-0.470000,-0.630000><43.650000,-0.630000>
//		<43.650000,-0.630000><43.650000,64.130000>
//		<43.650000,64.130000><-0.470000,64.130000>
//		<-0.470000,64.130000><-0.470000,-0.630000>
//		texture{col_brd}}
//	}

		/////////////
		// LCD module circuit board begin
		//
		difference {
			union{
				prism{
					0.00, -USER_PCB_THICKNESS, 8
					< -2.5,  2.5>< 78.5,  2.5>
					< 78.5,  2.5>< 78.5,-33.5>
					< 78.5,-33.5>< -2.5,-33.5>
					< -2.5,-33.5>< -2.5,  2.5>
					texture{pigment{rgbf<0.25,0.25,0.25,0>}}
				}
			}
/*			union {
				//board
				box {
					<-2.5, 0, 2.5>, <78.5, -USER_PCB_THICKNESS, -33.5>
					texture{col_brd}
				}
			}*/
			//mounting holes
/*			cylinder { <  2.5,  5, -2.5>, <  2.5, -5, -2.5> 1.25 texture{col_hls} }
			cylinder { < 77.5,  5, -2.5>, < 77.5, -5, -2.5> 1.25 texture{col_hls} }
			cylinder { <  2.5,  5,-33.5>, <  2.5, -5,-33.5> 1.25 texture{col_hls} }
			cylinder { < 77.5,  5,-33.5>, < 77.5, -5,-33.5> 1.25 texture{col_hls} }*/
/*			union { */
				cylinder { <  0,  2,  0>, <  0, -2,  0> 1.25 texture{col_hls} }
				cylinder { < 75,  2,  0>, < 75, -2,  0> 1.25 texture{col_hls} }
				cylinder { <  0,  2,-31>, <  0, -2,-31> 1.25 texture{col_hls} }
				cylinder { < 75,  2,-31>, < 75, -2,-31> 1.25 texture{col_hls} }
// 				translate< 2.5, 0, -2.5 >
/*			}*/
// 			translate< -2.5, 0, 2.5 >
		}
		//
		// LCD module circuit board begin
		/////////////

		/////////////
		// LCD module case begin
		//
		difference {
			box { <   2.10,   0.50,  -3.70>, <  73.40,   5.50,  -27.98> }
			union {
				//remove areas under the case
				union {
					box { <   0.00,   1.50, -30.00>, <   5.10,  -2.00,   0.00> }
					box { <   8.10,   1.50, -30.00>, <  36.25,  -2.00,   0.00> }
					box { <  39.25,   1.50, -30.00>, <  67.40,  -2.00,   0.00> }
					box { <  70.40,   1.50, -30.00>, <  75.00,  -2.00,   0.00> }
				}
				//remove corners from the case
				union {
					box { <   0.00,   6.00,   0.00>, <   3.60,  -2.00,  -5.20> }
					box { <  71.90,   6.00,   0.00>, <  75.00,  -2.00,  -5.20> }
					box { <   0.00,   6.00, -26.28>, <   3.60,  -2.00, -30.00> }
					box { <  71.90,   6.00, -26.28>, <  75.00,  -2.00, -30.00> }
				}
				box { <   5.50,   6.00,  -23.80>, <  70.00,   4.00,  -7.80> }
			}
			//translate <   2.10,   0.50,  -3.70>
			texture {pigment{Gray10}}
		}
		//
		// LCD module case end
		/////////////

		/////////////
		// LCD module screen begin
		//
		//*PMRawBegin
		#local message_string_1 = text {
			ttf USER_LCD_FONT, USER_LCD_MESSAGE_1, 1, 0
			rotate < 90, 0, 0 >
			scale < 4.6, 0.1, 4.6 >
			texture {col_lcd_fg}
		}
		#local message_string_2 = text {
			ttf USER_LCD_FONT, USER_LCD_MESSAGE_2, 1, 0
			rotate < 90, 0, 0 >
			scale < 4.6, 0.1, 4.6 >
			texture {col_lcd_fg}
		}

		#local message_extent_1=max_extent(message_string_1);
		#local message_extent_2=max_extent(message_string_2);
		//*PMRawEnd

		union
		{
			//screen
			box {
				< 0.00, 1.00, -16.00>, < 64.50, 0.00, 0.00>
				texture {col_lcd_bg}
			}

			/////////////
			// LCD module screen message begin
			//

			union
			{
				object{
					message_string_1
 					translate < 0, 0,      -message_extent_1.z>
				}
				object{
					message_string_2
					translate < 0, 0, -5.25-message_extent_2.z>
				}
				// what it should be: translate < 4.15, 1.01, -2.25>
				translate < 6.0, 1.01, -3.0>
			}

			//
			// LCD module screen message end
			/////////////

			translate<5.5,4,-7.8>
		}

		//
		// LCD module screen end
		/////////////

		//pad loop
		//*PMRawBegin
		union
		{
			#local it=0;
			#while (it<16)
				object {
					USER_LCD_PAD(it)
					//translate <2.46*it,0,0>
					//translate < USER_GRID*it, 0, 0 >
				}
				#local it=it+1;
			#end
			//translate< 5.5, 0, 0 >
			translate< USER_GRID*2, 0, 0 >
			texture{col_silver}
		}
		//*PMRawEnd

		//overall union adjustments
		translate< -USER_GRID*2, 0.1, 0 >     
		
		translate<7.6, -9.5, 33.4> 
		//x,z,y
		
	}
#end

#end

#macro SWITCH_PUSH_BUTTON_LSH43(value)
union{
object{SWITCH_PUSH_BUTTON_LSH(4.3, 3.4) scale 0.75}   //WAS 5.0 and LSH50      OR LSH43 and 4.3
}
#end

#macro RES_DIS_TRIM_72_PT(value)                   //was Value instead of 0 and 0.   Last 0 remains
union{
object{RES_DIS_TRIM_72_GRND(value,0)} 
}
#end               

#macro ARK_5MM_2(value)
union{                              
object{ARK_5MM_GRND(2) scale <1.5,0.9,1.2>} 
}
#end           

#macro PH_2MM_2X3(value)
union{
object{PH_GRND(2,3,0,2.00)}
rotate <0,90,0> 
}
#end           


#ifndef(__user_inc)
#declare __user_inc = true;

#include "user_colors.inc"
#include "user_lcd.inc"     

#declare USER_LCD_MESSAGE_1 = " JeremyBlum.com ";
#declare USER_LCD_MESSAGE_2 = "  My Portfolio  ";

#declare environment = off;
#declare col_wrs = texture{pigment{color rgb<0,173,0>}} 





#end

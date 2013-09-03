
/* 
  Example of using the SparkSoftLCD library for the Arduino
  
  2010 C. A. Church 
     http://openmoco.org/    
*/

  

#include "SparkSoftLCD.h"

  // LCD transmit pin
#define LCD_TX 2

SparkSoftLCD lcd = SparkSoftLCD(LCD_TX);

void setup() { 

   // setup lcd
   
 pinMode(LCD_TX, OUTPUT);
 lcd.begin(9600);
 lcd.clear();
 
   // hidden cursor
 lcd.cursor(0);
 
 show_setup();
 
 delay(1000);
 
}

void loop() {

    lcd.clear();
    
      // block-style blinking cursor
    lcd.cursor(2);
    
    lcd.print("Arming");
    delay(1500);
    
    lcd.clear();
    
      // hidden cursor
    lcd.cursor(0);
    
    lcd.print("16");
    lcd.cursorTo(2,1);
    lcd.print("---------------*");
    
    delay(1000);
    
    for( byte i = 15; i >= 1; i-- ) {
        
        lcd.scroll(false);
        
        // as we scroll left, we need to move our cursor to
        // the right to continue to show our countdown
        //
        // in this way, we achieve the sense that a fuse is getting
        // shorter...
        lcd.cursorTo(1,1 + (16 - i) );
        lcd.print(i, DEC);
        
        delay(1000);
     }
    
      // make last bit disappear
    lcd.scroll(false);
    delay(500);
    lcd.clear();
    lcd.cursorTo(2, 10);
    lcd.print("(boom)");
    
    delay(2000);
    
}



void show_setup() {
  
 lcd.print("I am setting up!");
 
   // send cursor to 2nd row, first column
 lcd.cursorTo(2,1);
 
 delay(500);
 
 for (byte i = 0; i <= 15; i++ ) {
     delay(150);
       // scroll display to the right
     lcd.scroll(true);
 }
 
 delay(1500);
 lcd.print("One more moment");
 
 
 for (byte i = 0; i <= 15; i++ ) {
     delay(150);
       // scroll back to the left, revealing our new text
     lcd.scroll(false);
 }
 
}
   





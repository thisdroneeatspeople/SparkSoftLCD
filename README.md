SparkSoftLCD
============

SparkSoftLCD is an easy-to-use library for controlling the Serial LCDs sold by
SparkFun on the Arduino platform.

SparkSoftLCD is a library that provides all necessary methods to use your Sparkfun 
Serial-Enabled LCD easily.  It is based on the SoftwareSerial library provided with 
the Arduino core, by David Mellis.  This version removes unnecessary functions to
save memory, and adds extra methods to access the core functionality of the LCD 
with a minimum amount of effort.

The LCD can be controlled with a single pin from your Arduino, freeing up plenty
for other work.  Of course, having to load SoftwareSerial, NewSoftSerial, etc. 
and then sending all the different commands manually is a pain.  So, this 
library provides easy methods for each of the common functions of the LCD.

## Differences between SoftwareSerial and SparkSoftLCD

The SparkSoftLCD library is based on the SoftwareSerial Library included in the 
Arduino core, and therefore works very similarly, in that you begin a connection 
by specifying the baud rate, and then can print() to the LCD.  However, as our 
goal is to simply control the LCD, there is no read() function, nor is println()
supported.

### Methods not included from SoftwareSerial:

    read()
    println()

In addtion, the constructor does not take an RX pin argument, so where you 
would normally say:

    SoftwareSerial my_serial = SoftwareSerial(TX_PIN, RX_PIN);
    
You would, instead, say:

    SparkSoftLCD my_lcd = SparkSoftLCD(LCD_TX_PIN, LCD_WIDTH);

_LCD_WIDTH is the width of the LCD, either 16 or 20 characters_

## Using the Library

	#include "SparkSoftLCD.h"
	
	#define LCD_TX   2
	#define LCD_WIDTH 16
	
	SparkSoftLCD lcd = SparkSoftLCD(LCD_TX, LCD_WIDTH);
	
	void setup()  {
	
	   pinMode(LCD_TX, OUTPUT);
	
	     // leave at 9600 unless you change the baud rate of the lcd
	   lcd.begin(9600);
	   lcd.clear();
	
	}
	
	void loop() {
	
	  lcd.print("Testing 1 2 3");
	  delay(1000);
	  lcd.clear();
	
	  float x = 5.14;
	
	    // print a floating point number with two decimals
	
	  lcd.print(x, 2);
	  delay(1000);
	  lcd.clear();
	
	}
	

## Methods

On top of the `print()` and `begin()` methods, the following new methods are provided:

__clear()__

Clears the LCD, sets cursor back at (1,1)

__backlight( byte level )__

Sets the backlight level.
Valid levels are 0-29

__enable( boolean on )__

Enable/disable the LCD.  An argument of true turns it on, false off

 

__scroll( boolean dir )__

Scrolls the display one position left or right.  An argument of false goes left, true right.

__cursor( byte type )__

Sets the cursor type.  The following types are valid:

    0 : not displayed
    1 : visible underline
    2 : blinking block

__cursorTo( byte row, byte col )__

Moves the cursor to the given position, rows and columns start at 1.  Up to four rows and twenty columns supported, based on LCD type.

__moveCursor( boolean dir )__

Moves the cursor one position left or right.  An argument of false moves left, true right.

__sendControl( byte value )__

Send an extended command to the LCD by specifying the extended command value.

## Notes

This library has been moved over from its original repo on SourceForge.  The only
change made during the move was to replace WProgram.h to Arduino.h to support
Arduino 1.0+ IDE.


## Example Sketch

	/*
	
	  Example of using the SparkSoftLCD library for the Arduino
	 
	  2010 C. A. Church
	  
	*/
	
	 
	
	#include "SparkSoftLCD.h"
	
	
	  // LCD transmit pin
	#define LCD_TX 2
	
	  // must specify width - 16 or 20 characters
	#define LCD_WIDTH 16
	
	byte          cur_bkl  = 30;
	boolean       upd_disp = true;
	
	SparkSoftLCD lcd = SparkSoftLCD(LCD_TX, LCD_WIDTH);
	
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

 

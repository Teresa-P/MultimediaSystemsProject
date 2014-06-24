//Multimedia Systems Spring 2014 - Device for the visually impaired
//Teresa Paulino
//06-06-2014
//v.1.0

import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
int[] VibratorPins = {2,3,4};
int[] ButtonPins = {8,9,10};
int[] VibratorValues = {0,0,0};
int[] ButtonValues = {1,1,1};
int evento = 0;

void setup()
{
  frameRate(30);
  size(100,100);
  background(255);
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[1], 57600);
  
  //the two following cycles fill the arrays that will store Pins info of the buttons and vibration motors connected to the arduino
  for (int i = 0; i < 3; i++)
  {
  arduino.pinMode(VibratorPins[i], Arduino.OUTPUT);
  }
  
  for (int i = 0; i < 3; i++)
  {
  arduino.pinMode(ButtonPins[i], Arduino.INPUT);
  }
}

void draw()
{
  
  //vibration motors are initiated as "off"
  for (int i = 0; i < 3; i++)
  {
    arduino.digitalWrite(VibratorPins[i], Arduino.LOW);
  }
  
  
  //Vibrations motors will be controled by keyboard, if pressed, vibration motors are activated
  for (int i = 0; i < 3; i++)
  {
    if (VibratorValues[i] == 0)
    {
      arduino.digitalWrite(VibratorPins[i], Arduino.LOW);
    }
    else
    {
      arduino.digitalWrite(VibratorPins[i], Arduino.HIGH);
    }
  }
  
  //function that determines what is printed on the console
  eventos();
  
  //if a certain button is pressed, variable evento changes according to pressed button
  for (int r = 0; r < 3; r++)
  {
    ButtonValues[r] = arduino.digitalRead(ButtonPins[r]);
    //println("botão " + r + " " + ButtonValues[r]);
    //println(evento);
  }
  if (ButtonValues[2] == 0)
  {
    evento = 1;
  }
  else if (ButtonValues[1] == 0)
  {
    evento = 2;
  }
  else if (ButtonValues[0] == 0)
  {
    evento = 3;
  }
  else if (ButtonValues[2] == 0 && ButtonValues[0] == 0 )
  {
    evento = 4;
  }
  
  
}

//keys that controls vibration motors (A, S, D, Q)
void keyPressed()
{
  if (keyPressed)
  {      
    if (key=='a' || key=='A')
    {
      VibratorValues[0] = 1;
    }
    
    if (key=='s' || key=='S')
    {
      VibratorValues[1] = 1;
    }
    
    if (key=='d' || key=='D')
    {
      VibratorValues[2] = 1;
    }
    
    if (key=='q' || key=='Q')
    {
      VibratorValues[2] = 1;
      VibratorValues[0] = 1;
    }
    
    
  }
}

//when a keys is not being pressed... then vibration motors are off
void keyReleased()
{
  evento = 0;
  for (int i = 0; i < 3; i++)
  {
    if (VibratorValues[i] == 1)
    {
      VibratorValues[i] =0;
    }
  }
}


/*This prototype was developed and tested with real blind people. We made a wizard of Oz evaluation
with 2 computers we were able to control  vibration motors, and when the user would press the button
we could see on the console and so we could activate through the other computer the desired function
*/
void eventos()
{
  if (evento == 1)
  {
    println("GOSTO ALT+G");
    evento = 0;
  }
  if (evento == 2)
  {
    println("COMENTÀRIO ALT +C");
    evento = 0;
  }
  if (evento == 3)
  {
    println("PARTILHA ALT+P");
    evento = 0;
  }
  if (evento == 4)
  {
    println("LINK ALT+L");
    evento = 0;
  }
}

const int ledPin =  13;
const int buttonPin = 2;
int buttonFlag = 0;

void setup()
{ 
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT);     
  Serial.begin(9600);

}

void loop()
{
  if (digitalRead(buttonPin) == HIGH)
  {
    if (buttonFlag == 0) {
      buttonFlag = 1; 
    } 
    else {
      buttonFlag = 0;
    }
    Serial.println(buttonFlag);
    delay(20);
  } else {
    Serial.println(buttonFlag);
    delay(20);
  }
  
   if( Serial.available() > 0 )
   {
     char inByte = Serial.read();
     if( inByte == 'A' )
     {
       digitalWrite(ledPin, HIGH);
       delay(100);
     }  
   }
   else {
     digitalWrite(ledPin, LOW);
     delay(100);
   }

}


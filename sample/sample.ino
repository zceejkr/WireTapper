//global constants
const int trigger = 1000;  // enter as int in mV
const int offset = 2000;   // enter as int in mV
const int intOffset = offset/(5000/1023);
const int intTrigger = trigger/(5000/1023);
const int nsamples = 3000;
const int sampleDelayTime = 80;
const int sampleTime = 120 + sampleDelayTime;
unsigned int analogueIn[nsamples];
int re=500;


void setup() {   
  
  Serial.begin(9600);
  pinMode(13, OUTPUT);   
  digitalWrite(13, HIGH);
  establishContact();
  digitalWrite(13, LOW);
  
  Serial.println(nsamples, DEC);
  Serial.println(sampleTime, DEC);

}
  
void loop() {
  while (re>(offset-trigger) && re<(offset+trigger)){
    re=analogRead(A0);
  }
 if (Serial.available() > 0) {
    int inByte = Serial.read();
   
    switch (inByte) {
    case 'a':    
      daq();
      sendData();
      break;
    }
 }
}

//Method to acquire data
void daq(){
  int count = 0;
   while(count <= (nsamples-1)){
   analogueIn[count] = analogRead(A0);
   count++;
   delayMicroseconds(sampleDelayTime); //delay appropriately
   }
}

//Method to write data to the serial buffer
void sendData(){
  int count = 0;
   while(count <= (nsamples-1)){
   Serial.println(analogueIn[count], DEC);
   count++;
   }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println(0);   // send a 0
    delay(300);
  }
  char input = Serial.read();
  Serial.println(input);
}


#define CLOCK 2
#define RW 3
const char ADDR[] = {22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52};
//const char ADDR[] = {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35};
const char DATA[] = {39, 41, 43, 45, 47, 49, 51, 53};
//const char DATA[] = {35, 37, 38, 39, 40, 41, 42, 43};

void setup() {
    // configure address lines
    for (int i = 0; i < 16; i++) {
        pinMode(ADDR[i], INPUT);
    }
    //configure data lines
    for (int i = 0; i < 8; i++) {
        pinMode(DATA[i], INPUT);
    }


    pinMode(CLOCK, INPUT);
    pinMode(RW, INPUT);
    attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);

    Serial.begin(57600);
}

void onClock() {
    char output[30];
    unsigned int address = 0;
    for (int i = 0; i < 16; i++) {
        int bit = digitalRead(ADDR[i]) ? 1 : 0;
        Serial.print(bit);
        address = (address << 1) + bit;
    }

    Serial.print("    ");
    unsigned int data = 0;
    for (int i = 0; i < 8; i++) {
        int bit = digitalRead(DATA[i]) ? 1 : 0;
        Serial.print(bit);
        data = (data << 1) + bit;
    }
    
    sprintf(output, "    %04x  %c %02x", address, digitalRead(RW) ? 'r' : 'W', data);
    Serial.println(output);
}

void loop() {

}

// Includes for ethernet thing
#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>
#include <EthernetUdp.h> // UDP library from: bjoern@cs.stanford.edu

// Includes for accelerometer
#include <I2Cdev.h>
#include <MPU6050.h>

// Arduino Wire library is required if I2Cdev I2CDEV_ARDUINO_WIRE implementation
// is used in I2Cdev.h
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include <Wire.h>
#endif

//-- vars for LEDs -----------------------------------------------------------
const int LED_R = 9
        , LED_G = 10
        , LED_B = 11

int r, g, b;

//-- accelerometry stuff ------------------------------------------------------
MPU6050 accel;
uint16_t ax, ay, az,
       , gx, gy, gz;

//-- networking stuff ---------------------------------------------------------
byte mac_addr[]; // figure this out

IPAddress ip(192, 168, 1, 177);

unsigned int localPort = 666; // chosen because I think it's hilarious
char rx_buf[UDP_RX_PACKET_MAX_SIZE];
char tx_buf[UDP_TX_PACKET_MAX_SIZE];
EthernetUDP Udp;

void setup() {
    // join I2C bus (I2Cdev library doesn't do this automatically)
    #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
    #endif

    pinMode(LED_R, OUTPUT);
    pinMode(LED_G, OUTPUT);
    pinMode(LED_B, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:

}

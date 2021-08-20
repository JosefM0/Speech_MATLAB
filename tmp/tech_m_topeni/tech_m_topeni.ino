#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <OneWire.h>
#include <DallasTemperature.h>

#define MQTT_VERSION MQTT_VERSION_3_1_1
#define ONE_WIRE_BUS 5

OneWire oneWire(ONE_WIRE_BUS);

DallasTemperature sensors(&oneWire);

// Wifi: SSID and password
const char* WIFI_SSID = "SSID";
const char* WIFI_PASSWORD = "heslo";

// MQTT: ID, server IP, port, username and password
const PROGMEM char* MQTT_CLIENT_ID = "MQTT Broker";
const PROGMEM char* MQTT_SERVER_IP = "192.168.0.165";
const PROGMEM uint16_t MQTT_SERVER_PORT = 1883;
const PROGMEM char* MQTT_USER = "mqtt user";
const PROGMEM char* MQTT_PASSWORD = "heslopico";

// MQTT: topics
const char* MQTT_STATE_TOPIC_1 = "topeni/status/Battery/Warning";
const char* MQTT_STATE_TOPIC_2 = "topeni/status/Termostat";
const char* MQTT_COMMAND_TOPIC_2 = "topeni/switch/Termostat";
const char* MQTT_STATE_TOPIC_3 = "topeni/status/Pump";
const char* MQTT_COMMAND_TOPIC_3 = "topeni/switch/Pump";
const char* MQTT_STATE_TOPIC_4 = "topeni/status/TUV";
const char* MQTT_COMMAND_TOPIC_4 = "topeni/switch/TUV";
const char* MQTT_TEMP_TUV_STATE_TOPIC_0 = "topeni/temp/TUV";
const char* MQTT_TEMP_TUV_STATE_TOPIC_1 = "topeni/temp/IN";
const char* MQTT_TEMP_TUV_STATE_TOPIC_2 = "topeni/temp/AKU_up";
const char* MQTT_TEMP_TUV_STATE_TOPIC_3 = "topeni/temp/AKU_low";
const char* MQTT_TEMP_TUV_STATE_TOPIC_4 = "topeni/temp/IN_1";

// payloads by default (on/off)
const char* ON = "ON";
const char* OFF = "OFF";

const PROGMEM uint8_t TUV_PIN = 16; // Prepinani bojleru topeni
boolean m_tuv_state = false; // TUV off by default

const PROGMEM uint8_t PUMP_PIN = 14; //Zapinani cerpadla
boolean m_pump_state = false; // PUMP off by default

WiFiClient wifiClient;
PubSubClient client(wifiClient);

long lastMsg = 0;
float temp = 0;
int inPin = 5;



// function called to publish the state of the light (on/off)
void publishTuvState() {
  if (m_tuv_state) {
    client.publish(MQTT_STATE_TOPIC_4, ON, true);
  } else {
    client.publish(MQTT_STATE_TOPIC_4, OFF, true);
   }
 }
 
void publishPumpState() {
if (m_pump_state) {
    client.publish(MQTT_STATE_TOPIC_3, ON, true);
  } else {
    client.publish(MQTT_STATE_TOPIC_3, OFF, true);
  }  
}


// function called to turn on/off the light
void setTuvState() {
  if (m_tuv_state) {
    digitalWrite(TUV_PIN, HIGH);
    Serial.println("INFO: TUV on...");
  } else {
    digitalWrite(TUV_PIN, LOW);
    Serial.println("INFO: TUV off...");
  }
 } 
void setPumpState() {
  if (m_pump_state) {
    digitalWrite(PUMP_PIN, HIGH);
    Serial.println("INFO: PUMP on...");
  } else {
    digitalWrite(PUMP_PIN, LOW);
    Serial.println("INFO: PUMP off...");
  }  
}

// function called when a MQTT message arrived
void callback(char* p_topic, byte* p_payload, unsigned int p_length) {
  // concat the payload into a string
  String payload;
  for (uint8_t i = 0; i < p_length; i++) {
    payload.concat((char)p_payload[i]);
  }
  Serial.println(p_topic);
  Serial.println(payload);
  // handle message topic
  if (String(MQTT_COMMAND_TOPIC_4).equals(p_topic)) {
    // test if the payload is equal to "ON" or "OFF"
    if (payload.equals(String(ON))) {
      if (m_tuv_state != true) {
        m_tuv_state = true;
        setTuvState();
        publishTuvState();
      }
    } else if (payload.equals(String(OFF))) {
      if (m_tuv_state != false) {
        m_tuv_state = false;
        setTuvState();
        publishTuvState();
      }
    }
  }
  if (String(MQTT_COMMAND_TOPIC_3).equals(p_topic)) {
    // test if the payload is equal to "ON" or "OFF"
    if (payload.equals(String(ON))) {
      if (m_pump_state != true) {
        m_pump_state = true;
        setPumpState();
        publishPumpState();
      }
    } else if (payload.equals(String(OFF))) {
      if (m_pump_state != false) {
        m_pump_state = false;
        setPumpState();
        publishPumpState();
      }
    }
  }
  
}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.println("INFO: Attempting MQTT connection...");
    // Attempt to connect
    if (client.connect(MQTT_CLIENT_ID, MQTT_USER, MQTT_PASSWORD)) {
      Serial.println("INFO: connected");
      // Once connected, publish an announcement...
      publishTuvState();
      publishPumpState();
      // ... and resubscribe
      client.subscribe(MQTT_COMMAND_TOPIC_4);
      client.subscribe(MQTT_COMMAND_TOPIC_3);
      
    } else {
      Serial.print("ERROR: failed, rc=");
      Serial.print(client.state());
      Serial.println("DEBUG: try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void setup() {
  // init the serial
  Serial.begin(57600);

  // init the led
  pinMode(TUV_PIN, OUTPUT);
  pinMode(PUMP_PIN, OUTPUT);
  
 // analogWriteRange(1023);
  setTuvState();
  setPumpState();

  // init the WiFi connection
  Serial.println();
  Serial.println();
  Serial.print("INFO: Connecting to ");
  WiFi.mode(WIFI_STA);
  Serial.println(WIFI_SSID);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("INFO: WiFi connected");
  Serial.print("INFO: IP address: ");
  Serial.println(WiFi.localIP());

  // init the MQTT connection
  client.setServer(MQTT_SERVER_IP, MQTT_SERVER_PORT);
  client.setCallback(callback);
  
  pinMode(inPin, INPUT);
  sensors.begin();
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  
  long now = millis();
  if (now - lastMsg > 5000) {
    lastMsg = now;
    sensors.setResolution(10);
    sensors.requestTemperatures(); // Send the command to get temperatures
    
    temp = sensors.getTempCByIndex(0);
    Serial.println(temp);
    if((temp > 0) && (temp <84))
      {
      client.publish(MQTT_TEMP_TUV_STATE_TOPIC_0, String(temp).c_str(),true);
      }
      
     temp = sensors.getTempCByIndex(1);
    Serial.println(temp);
        if((temp > 0) && (temp <84))
      {
      client.publish(MQTT_TEMP_TUV_STATE_TOPIC_1, String(temp).c_str(),true);
      }
      
      temp = sensors.getTempCByIndex(2);
       Serial.println(temp);
       if((temp > 0) && (temp <84))
      {
      client.publish(MQTT_TEMP_TUV_STATE_TOPIC_2, String(temp).c_str(),true);
      }

      temp = sensors.getTempCByIndex(3);
       Serial.println(temp);
       if((temp > 0) && (temp <84))
      {
      client.publish(MQTT_TEMP_TUV_STATE_TOPIC_3, String(temp).c_str(),true);
      }

      temp = sensors.getTempCByIndex(4);
       Serial.println(temp);
       if((temp > 0) && (temp <84))
      {
      client.publish(MQTT_TEMP_TUV_STATE_TOPIC_4, String(temp).c_str(),true);
      }
    
 // Temporary read state of external Temp control  
 if(digitalRead,TermPin == HIGH){
      m_TERM_state = true;
      publishTermState();
      } 
  else{m_TERM_state = false;
      publishTermState();
      } 
// Backup battery low voltage warning
if(digitalRead,BATT_PIN == HIGH){
      m_BATT_state = true;
      publishBattState();
      } 
  else{m_BATT_state = false;
      publishBattState();
      } 
    }     
 }

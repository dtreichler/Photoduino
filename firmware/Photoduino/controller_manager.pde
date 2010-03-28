/**
 *
 * - Photoduino
 * - http://code.google.com/p/photoduino/
 *
 * This file is part of Photoduino.
 *
 * Photoduino is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Photoduino is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Photoduino.  If not, see <http://www.gnu.org/licenses/>.
 */

// Runs the controller
void controller_run(){
   lcd.clear();
   lcd.print(MSG_PHOTODUINO_V);
   lcd.print(CODE_MAYOR_VERSION,10);
   lcd.print(".");
   lcd.print(CODE_MINOR_VERSION,10);
   lcd.setCursor(0,1);
   lcd.print(MSG_READY);
   buzzer_beep(200);
   keyboard_waitForAnyKey();
   controller_showMainMenu();
}

// Main Menu View
void controller_showMainMenu(){
  
  byte currentOption = 0;
  
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_MAIN_MENU);

    if(currentOption==0) display_printEnumeration(0, MSG_SYSTEM_CONFIG); 
    if(currentOption==1) display_printEnumeration(1, MSG_INTERVAL_MODE); 
    if(currentOption==2) display_printEnumeration(2, MSG_AUDIO_TRIGGER); 
    if(currentOption==3) display_printEnumeration(3, MSG_BARRIER_MODE);  
    if(currentOption==4) display_printEnumeration(4, MSG_SHOCK_TRIGGER); 
    if(currentOption==5) display_printEnumeration(5, MSG_FLASH_SLAVE); 
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 5);   
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 5);        
    if(lastKey==KEY_AH) exit = true;
    if(lastKey==KEY_BH) {
                        
          if(currentOption==0) controller_showSystemConfig(); 
          if(currentOption==1) controller_showIntervalMenu(); 
          if(currentOption==2) controller_showAudioTriggerMenu();
          if(currentOption==3) controller_showBarrierMenu();
          if(currentOption==4) controller_showShockTriggerMenu();
          if(currentOption==5) controller_showFlashSlaveMenu();
    }
  }
}

// Interval Menu View
void controller_showIntervalMenu(){
  
  byte currentOption = 0;
 
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_INTERVAL_MODE);

    // Show menu option
    if(currentOption==0) lcd.print(MSG_CONFIG);
    if(currentOption==1) lcd.print(MSG_RUN);
    if(currentOption==2) lcd.print(MSG_RESET_CONFIG);
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 2);        
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 2);   
    if(lastKey==KEY_AH) exit = true;
    if(lastKey==KEY_BH) {
                    
         if(currentOption==0)  { controller_showIntervalConfig(); } 
         if(currentOption==1)  { runAs_interval(); }
         if(currentOption==2)  { config_loadDefaults_intervalMode(); config_saveBackup_intervalMode(); display_printResetting(); }
    }
  }
}


// Audio trigger menu view
void controller_showAudioTriggerMenu(){
  
  byte currentOption = 0;
 
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_AUDIO_TRIGGER);

    // Show menu option
    if(currentOption==0) lcd.print(MSG_CONFIG);
    if(currentOption==1) lcd.print(MSG_RUN);
    if(currentOption==2) lcd.print(MSG_RESET_CONFIG);
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 2);
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 2);
    if(lastKey==KEY_AH) exit = true;
    if(lastKey==KEY_BH) {
                    
           if(currentOption==0) { controller_showAudioTriggerConfig(); } 
           if(currentOption==1) { runAs_audioTrigger(); }
           if(currentOption==2) { config_loadDefaults_audioTriggerMode(); config_saveBackup_audioTriggerMode(); display_printResetting(); }
    }
  }
}

// Shock trigger menu view
void controller_showShockTriggerMenu(){
  
  byte currentOption = 0;
 
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_SHOCK_TRIGGER);

    // Show menu option
    if(currentOption==0) lcd.print(MSG_CONFIG);
    if(currentOption==1) lcd.print(MSG_RUN);
    if(currentOption==2) lcd.print(MSG_RESET_CONFIG);
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 2);
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 2);
    if(lastKey==KEY_AH) exit = true;
    if(lastKey==KEY_BH) {
                    
           if(currentOption==0)  { controller_showShockTriggerConfig(); } 
           if(currentOption==1)  { runAs_shockTrigger(); }
           if(currentOption==2)  { config_loadDefaults_shockTriggerMode(); config_saveBackup_shockTriggerMode(); display_printResetting();}
    }
  }
}

// Flash slave menu view
void controller_showFlashSlaveMenu(){
  
  byte currentOption = 0;
 
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_FLASH_SLAVE);

    // Show menu option
    if(currentOption==0) lcd.print(MSG_CONFIG);
    if(currentOption==1) lcd.print(MSG_RUN);
    if(currentOption==2) lcd.print(MSG_RESET_CONFIG);
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 2);
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 2);
    if(lastKey==KEY_AH) exit = true;
    if(lastKey==KEY_BH) {
                    
           if(currentOption==0)  { controller_showFlashSlaveConfig(); } 
           if(currentOption==1)  { runAs_flashSlave(); }
           if(currentOption==2)  { config_loadDefaults_flashSlave(); config_saveBackup_flashSlave(); display_printResetting();}
    }
  }
}

// Barrier menu view
void controller_showBarrierMenu(){
  
  byte currentOption = 0;
  
  laser_turnOn();
  
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_BARRIER_MODE);

    // Show menu option
    if(currentOption==0) lcd.print(MSG_CONFIG);
    if(currentOption==1) lcd.print(MSG_RUN);
    if(currentOption==2) lcd.print(MSG_RESET_CONFIG);
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 2);
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 2);
    if(lastKey==KEY_AH) exit = true;
    if(lastKey==KEY_BH) {
                    
          if(currentOption==0)  { controller_showBarrierConfig(); } 
          if(currentOption==1)  { runAs_barrierMode(); }
          if(currentOption==2)  { config_loadDefaults_barrierMode(); config_saveBackup_barrierMode(); display_printResetting(); }
    }
  }
  
  laser_turnOff();
}

// Interval Config view
void controller_showIntervalConfig(){
  
  byte currentOption = 0;
  
  for(boolean exit = false;!exit;){
     
      display_printTitle(MSG_INTERVAL_MODE);
     
      // Show menu options
      if(currentOption==0) { lcd.print(MSG_AUTOFOCUS_TIME);  }
      if(currentOption==1) { lcd.print(MSG_SHUTTERLAG_TIME); }     
      if(currentOption==2) { lcd.print(MSG_USE_FLASH1); display_printBoolean(intervalMode_useFlash1); }
      if(currentOption==3) { lcd.print(MSG_FLASH1_PRETIME); }
      if(currentOption==4) { lcd.print(MSG_USE_FLASH2); display_printBoolean(intervalMode_useFlash2); }
      if(currentOption==5) { lcd.print(MSG_FLASH2_PRETIME); }
      if(currentOption==6) { lcd.print(MSG_CLOSE_PRETIME); }
      if(currentOption==7) { lcd.print(MSG_INTERVAL_UNITS); }
      if(currentOption==8) { lcd.print(MSG_INTERVAL_VALUE); }
      if(currentOption==9) { lcd.print(MSG_CICLES); }

      keyboard_waitForAnyKey();
      
      if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 9); 
      if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 9);  
      if(lastKey==KEY_AH) { config_saveBackup_intervalMode(); exit = true; }
      if(lastKey==KEY_BH) {          

             if(currentOption==0)  controller_setIntegerValue(&intervalMode_autofocusTime, MSG_AUTOFOCUS_TIME,UNITS_MS);
             if(currentOption==1)  controller_setIntegerValue(&intervalMode_shutterLagTime, MSG_SHUTTERLAG_TIME,UNITS_MS);
             if(currentOption==2)  intervalMode_useFlash1 = !intervalMode_useFlash1;
             if(currentOption==3)  controller_setIntegerValue(&intervalMode_preFlash1Time, MSG_FLASH1_PRETIME,UNITS_MS);
             if(currentOption==4)  intervalMode_useFlash2 = !intervalMode_useFlash2;
             if(currentOption==5)  controller_setIntegerValue(&intervalMode_preFlash2Time, MSG_FLASH2_PRETIME,UNITS_MS);
             if(currentOption==6)  controller_setIntegerValue(&intervalMode_preCloseTime, MSG_CLOSE_PRETIME,UNITS_MS);
             if(currentOption==7)  controller_setUnits(&intervalMode_intervalUnits, MSG_INTERVAL_UNITS); 
             if(currentOption==8)  controller_setIntegerValue(&intervalMode_intervalValue, MSG_INTERVAL_VALUE,intervalMode_intervalUnits);
             if(currentOption==9)  controller_setIntegerValue(&intervalMode_numCicles, MSG_CICLES,UNITS_CICLES);     
      } 
   }
}

// Audio Trigger Config view
void controller_showAudioTriggerConfig(){
  
   byte currentOption = 0;
  
   for(boolean exit = false;!exit;){
     
      display_printTitle(MSG_AUDIO_CONFIG);
         
      // Show menu options
      if(currentOption==0) { lcd.print(MSG_SENSOR_LIMIT); }
      if(currentOption==1) { lcd.print(MSG_PRE_BULB); display_printBoolean(audioTriggerMode_preBulbMode); }
      if(currentOption==2) { lcd.print(MSG_AUTOFOCUS_TIME);  }
      if(currentOption==3) { lcd.print(MSG_SHUTTERLAG_TIME); }     
      if(currentOption==4) { lcd.print(MSG_USE_FLASH1); display_printBoolean(audioTriggerMode_useFlash1); }
      if(currentOption==5) { lcd.print(MSG_FLASH1_PRETIME); }
      if(currentOption==6) { lcd.print(MSG_USE_FLASH2); display_printBoolean(audioTriggerMode_useFlash2); }
      if(currentOption==7) { lcd.print(MSG_FLASH2_PRETIME); }
      if(currentOption==8) { lcd.print(MSG_CLOSE_PRETIME); }
      if(currentOption==9) { lcd.print(MSG_CICLES); }
      if(currentOption==10) { lcd.print(MSG_INTERCICLE_TIME); }
  
      keyboard_waitForAnyKey();
      
      if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 10); 
      if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 10); 
      if(lastKey==KEY_AH) { config_saveBackup_audioTriggerMode(); exit = true; }
      if(lastKey==KEY_BH) {          
          
             if(currentOption==0)  controller_setSensorLimit(&audioTriggerMode_sensorLimit, PINS_SENSOR_MIC, SENSOR_MODE_HIGHER, MSG_AUDIO_LIMIT);
             if(currentOption==1)  audioTriggerMode_preBulbMode = !audioTriggerMode_preBulbMode;
             if(currentOption==2)  controller_setIntegerValue(&audioTriggerMode_autofocusTime, MSG_AUTOFOCUS_TIME,UNITS_MS);
             if(currentOption==3)  controller_setIntegerValue(&audioTriggerMode_shutterLagTime, MSG_SHUTTERLAG_TIME,UNITS_MS);
             if(currentOption==4)  audioTriggerMode_useFlash1 = !audioTriggerMode_useFlash1;
             if(currentOption==5)  controller_setIntegerValue(&audioTriggerMode_preFlash1Time, MSG_FLASH1_PRETIME,UNITS_MS);
             if(currentOption==6)  audioTriggerMode_useFlash2 = !audioTriggerMode_useFlash2;
             if(currentOption==7)  controller_setIntegerValue(&audioTriggerMode_preFlash2Time, MSG_FLASH2_PRETIME,UNITS_MS);
             if(currentOption==8)  controller_setIntegerValue(&audioTriggerMode_preCloseTime, MSG_CLOSE_PRETIME,UNITS_MS);
             if(currentOption==9)  controller_setIntegerValue(&audioTriggerMode_numCicles, MSG_CICLES,UNITS_CICLES);
             if(currentOption==10)  controller_setIntegerValue(&audioTriggerMode_interCicleTime, MSG_INTERCICLE_TIME,UNITS_MS);
                      
      } 
   }
}

// Shock Trigger Config view
void controller_showShockTriggerConfig(){
  
   byte currentOption = 0;
  
   for(boolean exit = false;!exit;){
     
      display_printTitle(MSG_SHOCK_CONFIG);
         
      // Show menu options
      if(currentOption==0) { lcd.print(MSG_SENSOR_LIMIT); }
      if(currentOption==1) { lcd.print(MSG_PRE_BULB); display_printBoolean(shockTriggerMode_preBulbMode); }
      if(currentOption==2) { lcd.print(MSG_AUTOFOCUS_TIME);  }
      if(currentOption==3) { lcd.print(MSG_SHUTTERLAG_TIME); }     
      if(currentOption==4) { lcd.print(MSG_USE_FLASH1); display_printBoolean(shockTriggerMode_useFlash1); }
      if(currentOption==5) { lcd.print(MSG_FLASH1_PRETIME); }
      if(currentOption==6) { lcd.print(MSG_USE_FLASH2); display_printBoolean(shockTriggerMode_useFlash2); }
      if(currentOption==7) { lcd.print(MSG_FLASH2_PRETIME); }
      if(currentOption==8) { lcd.print(MSG_CLOSE_PRETIME); }
      if(currentOption==9) { lcd.print(MSG_CICLES); }
      if(currentOption==10) { lcd.print(MSG_INTERCICLE_TIME); }

      keyboard_waitForAnyKey();
      
      if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 10); 
      if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 10); 
      if(lastKey==KEY_AH) { config_saveBackup_shockTriggerMode(); exit = true; }
      if(lastKey==KEY_BH) {          
          
             if(currentOption==0)  controller_setSensorLimit(&shockTriggerMode_sensorLimit, PINS_SENSOR_SHOCK, SENSOR_MODE_HIGHER, MSG_SHOCK_LIMIT);
             if(currentOption==1)  shockTriggerMode_preBulbMode = !shockTriggerMode_preBulbMode;
             if(currentOption==2)  controller_setIntegerValue(&shockTriggerMode_autofocusTime, MSG_AUTOFOCUS_TIME,UNITS_MS);
             if(currentOption==3)  controller_setIntegerValue(&shockTriggerMode_shutterLagTime, MSG_SHUTTERLAG_TIME,UNITS_MS);
             if(currentOption==4)  shockTriggerMode_useFlash1 = !shockTriggerMode_useFlash1;
             if(currentOption==5)  controller_setIntegerValue(&shockTriggerMode_preFlash1Time, MSG_FLASH1_PRETIME,UNITS_MS);
             if(currentOption==6)  shockTriggerMode_useFlash2 = !shockTriggerMode_useFlash2;
             if(currentOption==7)  controller_setIntegerValue(&shockTriggerMode_preFlash2Time, MSG_FLASH2_PRETIME,UNITS_MS);
             if(currentOption==8)  controller_setIntegerValue(&shockTriggerMode_preCloseTime, MSG_CLOSE_PRETIME,UNITS_MS);
             if(currentOption==9)  controller_setIntegerValue(&shockTriggerMode_numCicles, MSG_CICLES,UNITS_CICLES);
             if(currentOption==10)  controller_setIntegerValue(&shockTriggerMode_interCicleTime, MSG_INTERCICLE_TIME,UNITS_MS);
                      
      } 
   }
}

// Barrier Config view
void controller_showBarrierConfig(){
  
   byte currentOption = 0;
   
   for(boolean exit = false;!exit;){
     
      display_printTitle(MSG_BARRIER_CONFIG);
         
      // Show menu options
      if(currentOption==0) { lcd.print(MSG_SENSOR_LIMIT); }
      if(currentOption==1) { lcd.print(MSG_PRE_BULB); display_printBoolean(barrierMode_preBulbMode); }
      if(currentOption==2) { lcd.print(MSG_AUTOFOCUS_TIME);  }
      if(currentOption==3) { lcd.print(MSG_SHUTTERLAG_TIME); }     
      if(currentOption==4) { lcd.print(MSG_USE_FLASH1); display_printBoolean(barrierMode_useFlash1); }
      if(currentOption==5) { lcd.print(MSG_FLASH1_PRETIME); }
      if(currentOption==6) { lcd.print(MSG_USE_FLASH2); display_printBoolean(barrierMode_useFlash2); }
      if(currentOption==7) { lcd.print(MSG_FLASH2_PRETIME); }
      if(currentOption==8) { lcd.print(MSG_CLOSE_PRETIME); }
      if(currentOption==9) { lcd.print(MSG_CICLES); }
      if(currentOption==10) { lcd.print(MSG_INTERCICLE_TIME); }

      keyboard_waitForAnyKey();
      
      if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 10); 
      if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 10);  
      if(lastKey==KEY_AH) { config_saveBackup_barrierMode(); exit = true; }
      if(lastKey==KEY_BH) {          
          
             if(currentOption==0) controller_setSensorLimit(&barrierMode_sensorLimit, PINS_SENSOR_BARRIER, SENSOR_MODE_LOWER, MSG_BARRIER_LIMIT);
             if(currentOption==1) barrierMode_preBulbMode = !barrierMode_preBulbMode;
             if(currentOption==2) controller_setIntegerValue(&barrierMode_autofocusTime, MSG_AUTOFOCUS_TIME,UNITS_MS);
             if(currentOption==3) controller_setIntegerValue(&barrierMode_shutterLagTime, MSG_SHUTTERLAG_TIME,UNITS_MS);
             if(currentOption==4) barrierMode_useFlash1 = !barrierMode_useFlash1;
             if(currentOption==5) controller_setIntegerValue(&barrierMode_preFlash1Time, MSG_FLASH1_PRETIME,UNITS_MS);
             if(currentOption==6) barrierMode_useFlash2 = !barrierMode_useFlash2;
             if(currentOption==7) controller_setIntegerValue(&barrierMode_preFlash2Time, MSG_FLASH2_PRETIME,UNITS_MS);
             if(currentOption==8) controller_setIntegerValue(&barrierMode_preCloseTime, MSG_CLOSE_PRETIME,UNITS_MS);
             if(currentOption==9) controller_setIntegerValue(&barrierMode_numCicles, MSG_CICLES,UNITS_CICLES);     
             if(currentOption==10) controller_setIntegerValue(&barrierMode_interCicleTime, MSG_INTERCICLE_TIME,UNITS_MS);     
      } 
   }
}

// Flash slave Config view
void controller_showFlashSlaveConfig(){
  
  byte currentOption = 0;
  
  for(boolean exit = false;!exit;){
     
      display_printTitle(MSG_FLASH_SLAVE);
     
      // Show menu options
      if(currentOption==0) { lcd.print(MSG_SENSOR_LIMIT); }
      if(currentOption==1) { lcd.print(MSG_USE_FLASH1); display_printBoolean(flashSlave_useFlash1); }
      if(currentOption==2) { lcd.print(MSG_FLASH1_PRETIME); }
      if(currentOption==3) { lcd.print(MSG_USE_FLASH2); display_printBoolean(flashSlave_useFlash2); }
      if(currentOption==4) { lcd.print(MSG_FLASH2_PRETIME); }
 
      keyboard_waitForAnyKey();
      
      if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 4); 
      if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 4);  
      if(lastKey==KEY_AH) { config_saveBackup_flashSlave(); exit = true; }
      if(lastKey==KEY_BH) {          

             if(currentOption==0) controller_setSensorLimit(&flashSlave_sensorLimit, PINS_SENSOR_BARRIER, SENSOR_MODE_HIGHER, MSG_SENSOR_LIMIT);
             if(currentOption==1) flashSlave_useFlash1 = !flashSlave_useFlash1;
             if(currentOption==2) controller_setIntegerValue(&flashSlave_preFlash1Time, MSG_FLASH1_PRETIME,UNITS_MS);
             if(currentOption==3) flashSlave_useFlash2 = !flashSlave_useFlash2;
             if(currentOption==4) controller_setIntegerValue(&flashSlave_preFlash2Time, MSG_FLASH2_PRETIME,UNITS_MS);
      } 
   }
}

// System config View
void controller_showSystemConfig(){
  
  byte currentOption = 0;
 
  for(boolean exit = false;!exit;){
      
    display_printTitle(MSG_SYSTEM_CONFIG);

    // Show menu option
    if (currentOption==0) { lcd.print(MSG_BACKLIGHT); display_printBoolean(system_useBacklight); }
    if (currentOption==1) { lcd.print(MSG_SPEAKER); display_printBoolean(system_useSpeaker); }
    
    keyboard_waitForAnyKey();
    
    if(lastKey==KEY_A) circularList_decrement(&currentOption, 0, 1);
    if(lastKey==KEY_B) circularList_increment(&currentOption, 0, 1);
    if(lastKey==KEY_AH) { config_saveBackup_system(); exit = true; } 
    if(lastKey==KEY_BH) {

          if(currentOption==0) backlight_toggle(); 
          if(currentOption==1) system_useSpeaker = !system_useSpeaker;
    }
  }
}



// set of sensorlimit
void controller_setSensorLimit(byte *value, byte readPin, byte mode, char *msg){

     byte sensorValue;
     
     display_printTitle(msg);

     do { 
          sensorValue = sensor_read(readPin);
                    
          lcd.setCursor(0,1);
          
          for (byte i=0; i<16; i++) {
              if(i==*value){
                 if (mode==SENSOR_MODE_HIGHER){
                     if (sensorValue>=*value) buzzer_beep(100); 
                     lcd.write(SYMBOL_UP);
                 } 
                 else                  
                 if (mode==SENSOR_MODE_LOWER){
                     if (sensorValue<=*value) buzzer_beep(100); 
                     lcd.write(SYMBOL_DOWN);
                 }
              }
              if(i<sensorValue) lcd.write(SYMBOL_BOX); else lcd.print(" ");
          }
          
          keyboard_scan();
          
          if (lastKey==KEY_A) circularList_increment(value, 0, 15);
          if (lastKey==KEY_B) circularList_decrement(value, 0, 15);
          
     } while (lastKey!=KEY_AH);
}

// set of interval units
void controller_setUnits(byte *variable, char *msg){
  
     do { 
       
      display_printTitle(msg);
      display_printUnits(*variable);
      
      keyboard_waitForAnyKey();
      
      if (lastKey==KEY_A) circularList_decrement(variable, 0, 4);
      if (lastKey==KEY_B) circularList_increment(variable, 0, 4);
   
     } while (lastKey!=KEY_AH);     
}

// set of integer value
void controller_setIntegerValue(unsigned int *value, char *msg, byte units){
     
     byte values[5];
     byte currentPos = 0;
  
     lcd.clear();
     lcd.print(">");
     lcd.print(msg);
     lcd.setCursor(6,1);
     display_printUnits(units);
     
     lcd.setCursor(0,1);

     values[0] = *value/10000;
     values[1] = (*value%10000)/1000;
     values[2] = (*value%1000)/100;
     values[3] = (*value%100)/10;
     values[4] = *value%10;

     lcd.print(values[0],10);
     lcd.print(values[1],10);
     lcd.print(values[2],10);
     lcd.print(values[3],10);
     lcd.print(values[4],10);   
               
     lcd.blink();
     
     do { 
         lcd.setCursor(currentPos,1);
         lcd.print(values[currentPos],10);
         lcd.setCursor(currentPos,1);

          keyboard_waitForAnyKey();
         
         if (lastKey==KEY_A) {
             if (currentPos == 0) circularList_increment(&values[currentPos],0,5);
             else circularList_increment(&values[currentPos],0,9); 
         }
         if (lastKey==KEY_B) {
             if (currentPos == 0) circularList_decrement(&values[currentPos],0,5);
             else circularList_decrement(&values[currentPos],0,9);
         }
         if (lastKey==KEY_BH) circularList_increment(&currentPos,0,4);             
          
     } while (lastKey!=KEY_AH);

     lcd.noBlink();
     *value = values[0]*10000+
              values[1]*1000+
              values[2]*100+
              values[3]*10+
              values[4];
}


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
 
 // Run barrier mode
void runAs_barrierMode() { 
     
   boolean exit = false;
    
   display_printTitle(MSG_RUN_BARRIER);
   
   keyboard_waitForNokey();
   
   attachInterrupt(0, keyboard_interrupts, CHANGE);
   attachInterrupt(1, keyboard_interrupts, CHANGE);
   
   for(unsigned int ciclesCounter = 0; (cancelFlag==false && exit==false && !(barrierMode_numCicles>0 && ciclesCounter >= barrierMode_numCicles));ciclesCounter++) { 
     
     if (barrierMode_preBulbMode) {
      
       // With prebulb
       camera_autofocusBegin(barrierMode_autofocusTime);
       camera_shutterBegin(barrierMode_shutterLagTime); 
       laser_turnOn();
       sensor_waitFor(PINS_SENSOR_BARRIER, SENSOR_MODE_LOWER, barrierMode_sensorLimit);
       laser_turnOff();
       
       if(!cancelFlag) {
         if (barrierMode_useFlash1) flash_shoot(barrierMode_preFlash1Time, PINS_FLASH1);
         if (barrierMode_useFlash2) flash_shoot(barrierMode_preFlash2Time, PINS_FLASH2); 
       }
          
     } else {
       
       // Without brebulb
       laser_turnOn();
       sensor_waitFor(PINS_SENSOR_BARRIER, SENSOR_MODE_LOWER, barrierMode_sensorLimit);
       laser_turnOff();
       
       if(!cancelFlag) {
         
         camera_autofocusBegin(barrierMode_autofocusTime); 
         camera_shutterBegin(barrierMode_shutterLagTime); 
          
         if (barrierMode_useFlash1) flash_shoot(barrierMode_preFlash1Time, PINS_FLASH1);
         if (barrierMode_useFlash2) flash_shoot(barrierMode_preFlash2Time, PINS_FLASH2); 
       }
     }
     camera_shutterEnd(barrierMode_preCloseTime); 
     camera_autofocusEnd(); 
     delay(barrierMode_interCicleTime);     
   }
   laser_turnOn();
   display_printAborting();
   keyboard_waitForNokey();
   
   detachInterrupt(0);
   detachInterrupt(1);
}

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
  
 // Run audio trigger mode
void runAs_audioTrigger() { 
     
   boolean exit = false;
    
   display_printTitle(MSG_RUN_AUDIO);
   
   keyboard_waitForNokey();
   
   attachInterrupt(0, keyboard_interrupts, CHANGE);
   attachInterrupt(1, keyboard_interrupts, CHANGE);
   
   for(unsigned int ciclesCounter = 0; (cancelFlag==false && exit==false && !(audioTriggerMode_numCicles>0 && ciclesCounter >= audioTriggerMode_numCicles));ciclesCounter++) { 
     
     if (audioTriggerMode_preBulbMode) {
      
       // With prebulb
       camera_autofocusBegin(audioTriggerMode_autofocusTime);
       camera_shutterBegin(audioTriggerMode_shutterLagTime); 
       
       sensor_waitFor(PINS_SENSOR_MIC, SENSOR_MODE_HIGHER, audioTriggerMode_sensorLimit);
       
       if(!cancelFlag) {
         if (audioTriggerMode_useFlash1) flash_shoot(audioTriggerMode_preFlash1Time, PINS_FLASH1);
         if (audioTriggerMode_useFlash2) flash_shoot(audioTriggerMode_preFlash2Time, PINS_FLASH2);     
       }
           
     } else {
       
       // Without brebulb
       sensor_waitFor(PINS_SENSOR_MIC, SENSOR_MODE_HIGHER, audioTriggerMode_sensorLimit);
       
       if(!cancelFlag) {
         
         camera_autofocusBegin(audioTriggerMode_autofocusTime); 
         camera_shutterBegin(audioTriggerMode_shutterLagTime); 
          
         if (audioTriggerMode_useFlash1) flash_shoot(audioTriggerMode_preFlash1Time, PINS_FLASH1);
         if (audioTriggerMode_useFlash2) flash_shoot(audioTriggerMode_preFlash2Time, PINS_FLASH2); 

       }
     }   
     camera_shutterEnd(audioTriggerMode_preCloseTime); 
     camera_autofocusEnd();  
     delay(audioTriggerMode_interCicleTime);
   } 
     
   display_printAborting();
   keyboard_waitForNokey();
   
   detachInterrupt(0);
   detachInterrupt(1);
}


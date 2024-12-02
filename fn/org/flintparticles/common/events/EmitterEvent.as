package org.flintparticles.common.events
{
   import flash.events.Event;
   
   public class EmitterEvent extends Event
   {
      
      public static var COUNTER_COMPLETE:String = "counterComplete";
      
      public static var EMITTER_UPDATED:String = "emitterUpdated";
      
      public static var EMITTER_EMPTY:String = "emitterEmpty";
       
      
      public function EmitterEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

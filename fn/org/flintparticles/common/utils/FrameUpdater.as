package org.flintparticles.common.utils
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import org.flintparticles.common.events.UpdateEvent;
   
   public class FrameUpdater extends EventDispatcher
   {
      
      private static var _instance:FrameUpdater;
       
      
      private var _shape:Shape;
      
      private var _time:Number;
      
      private var _running:Boolean = false;
      
      public function FrameUpdater()
      {
         _running = false;
         super();
         _shape = new Shape();
      }
      
      public static function get instance() : FrameUpdater
      {
         if(_instance == null)
         {
            _instance = new FrameUpdater();
         }
         return _instance;
      }
      
      private function stopTimer() : void
      {
         _shape.removeEventListener(Event.ENTER_FRAME,frameUpdate);
         _running = false;
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         super.removeEventListener(param1,param2,param3);
         if(_running && !hasEventListener(UpdateEvent.UPDATE))
         {
            stopTimer();
         }
      }
      
      private function startTimer() : void
      {
         _shape.addEventListener(Event.ENTER_FRAME,frameUpdate,false,0,true);
         _time = getTimer();
         _running = true;
      }
      
      private function frameUpdate(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         _loc2_ = _time;
         _time = getTimer();
         _loc3_ = (_time - _loc2_) * 0.001;
         dispatchEvent(new UpdateEvent(UpdateEvent.UPDATE,_loc3_));
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         super.addEventListener(param1,param2,param3,param4,param5);
         if(!_running && hasEventListener(UpdateEvent.UPDATE))
         {
            startTimer();
         }
      }
   }
}

package org.flintparticles.common.counters
{
   import org.flintparticles.common.emitters.Emitter;
   
   public class Blast implements Counter
   {
       
      
      private var _done:Boolean = false;
      
      private var _startCount:uint;
      
      public function Blast(param1:uint = 0)
      {
         _done = false;
         super();
         _startCount = param1;
      }
      
      public function updateEmitter(param1:Emitter, param2:Number) : uint
      {
         return 0;
      }
      
      public function get startCount() : Number
      {
         return _startCount;
      }
      
      public function stop() : void
      {
      }
      
      public function resume() : void
      {
      }
      
      public function get complete() : Boolean
      {
         return _done;
      }
      
      public function set startCount(param1:Number) : void
      {
         _startCount = param1;
      }
      
      public function startEmitter(param1:Emitter) : uint
      {
         param1.dispatchCounterComplete();
         return _startCount;
      }
   }
}

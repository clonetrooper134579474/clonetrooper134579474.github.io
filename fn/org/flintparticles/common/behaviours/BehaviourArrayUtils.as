package org.flintparticles.common.behaviours
{
   public class BehaviourArrayUtils
   {
       
      
      public function BehaviourArrayUtils()
      {
         super();
      }
      
      public static function add(param1:Array, param2:Behaviour) : uint
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(Behaviour(param1[_loc4_]).priority < param2.priority)
            {
               break;
            }
            _loc4_++;
         }
         param1.splice(_loc4_,0,param2);
         return _loc3_ + 1;
      }
      
      public static function remove(param1:Array, param2:Behaviour) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = param1.indexOf(param2);
         if(_loc3_ != -1)
         {
            param1.splice(_loc3_,1);
            return true;
         }
         return false;
      }
      
      public static function removeAt(param1:Array, param2:uint) : Behaviour
      {
         var _loc3_:Behaviour = null;
         _loc3_ = param1[param2] as Behaviour;
         param1.splice(param2,1);
         return _loc3_;
      }
      
      public static function containsType(param1:Array, param2:Class) : Boolean
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc3_ = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(param1[_loc4_] is param2)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public static function sortArray(param1:Array) : void
      {
         param1.sortOn("priority",Array.NUMERIC);
      }
      
      public static function clear(param1:Array) : void
      {
         param1.length = 0;
      }
      
      public static function contains(param1:Array, param2:Behaviour) : Boolean
      {
         return param1.indexOf(param2) != -1;
      }
   }
}

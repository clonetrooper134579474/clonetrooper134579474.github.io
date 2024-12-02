package com.exileetiquette.loader.events
{
   import flash.events.ProgressEvent;
   
   public class LoadManagerProgressEvent extends ProgressEvent
   {
      
      public static const PROGRESS:String = "loadManagerProgress";
       
      
      private var _fileId:String;
      
      public function LoadManagerProgressEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:uint = 0, param5:uint = 0, param6:String = null)
      {
         super(param1,param2,param3,param4,param5);
         _fileId = param6;
      }
      
      public function get fileId() : String
      {
         return _fileId;
      }
   }
}

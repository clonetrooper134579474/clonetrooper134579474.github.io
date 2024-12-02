package com.exileetiquette.loader.events
{
   import flash.events.Event;
   
   public class LoadManagerEvent extends Event
   {
      
      public static const QUEUE_COMPLETE:String = "loadManagerQueueComplete";
      
      public static const LIST_COMPLETE:String = "loadManagerListComplete";
      
      public static const FILE_COMPLETE:String = "loadManagerFileComplete";
      
      public static const LIST_ADDED_TO_QUEUE:String = "loadManagerListAddedToQueue";
       
      
      private var _data:Object;
      
      private var _fileId:String;
      
      public function LoadManagerEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Object = null)
      {
         super(param1,param2,param3);
         _fileId = param4;
         _data = param5;
      }
      
      public function get fileId() : String
      {
         return _fileId;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

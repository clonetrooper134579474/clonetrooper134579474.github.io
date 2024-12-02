package com.exileetiquette.loader.formats
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class GenericHandler extends EventDispatcher implements IFormatHandler
   {
       
      
      private var _loaded:Boolean;
      
      protected var _loader:URLLoader;
      
      public function GenericHandler()
      {
         super();
         _loader = new URLLoader();
         _loader.addEventListener(Event.COMPLETE,onLoadComplete,false,0,true);
         _loader.addEventListener(ProgressEvent.PROGRESS,onLoadProgress,false,0,true);
         _loader.addEventListener(IOErrorEvent.IO_ERROR,onLoadIOError,false,0,true);
      }
      
      public function getContent() : *
      {
         if(!_loaded)
         {
            return null;
         }
         return _loader.data;
      }
      
      public function get loaded() : Boolean
      {
         return _loaded;
      }
      
      public function destroy() : void
      {
         try
         {
            _loader.close();
         }
         catch(e:Error)
         {
         }
         _loader = null;
         _loaded = false;
      }
      
      public function load(param1:String, param2:* = null) : void
      {
         _loaded = false;
         _loader.load(new URLRequest(param1));
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      public function pauseLoad() : void
      {
         try
         {
            _loader.close();
         }
         catch(e:Error)
         {
         }
      }
      
      private function onLoadIOError(param1:IOErrorEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         _loaded = true;
         dispatchEvent(param1.clone());
      }
   }
}

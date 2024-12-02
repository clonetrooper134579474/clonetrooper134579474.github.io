package com.exileetiquette.loader.formats
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class SWFHandler extends EventDispatcher implements IFormatHandler
   {
       
      
      private var _loaded:Boolean;
      
      protected var _loader:Loader;
      
      public function SWFHandler()
      {
         super();
         _loader = new Loader();
         _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadComplete,false,0,true);
         _loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onLoadProgress,false,0,true);
         _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadIOError,false,0,true);
      }
      
      public function getContent() : *
      {
         if(!_loaded)
         {
            return null;
         }
         return _loader.content;
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
         try
         {
            _loader.unload();
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
         _loader.load(new URLRequest(param1),LoaderContext(param2));
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

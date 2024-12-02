package com.exileetiquette.loader.formats
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.media.Sound;
   import flash.media.SoundLoaderContext;
   import flash.net.URLRequest;
   
   public class SoundHandler extends EventDispatcher implements IFormatHandler
   {
       
      
      private var _sound:Sound;
      
      private var _loaded:Boolean;
      
      public function SoundHandler()
      {
         super();
         _sound = new Sound();
         _sound.addEventListener(Event.COMPLETE,onLoadComplete,false,0,true);
         _sound.addEventListener(ProgressEvent.PROGRESS,onLoadProgress,false,0,true);
         _sound.addEventListener(IOErrorEvent.IO_ERROR,onLoadIOError,false,0,true);
      }
      
      public function getContent() : *
      {
         if(!_loaded)
         {
            return null;
         }
         return _sound;
      }
      
      public function get loaded() : Boolean
      {
         return _loaded;
      }
      
      public function destroy() : void
      {
         try
         {
            _sound.close();
         }
         catch(e:Error)
         {
         }
         _sound = null;
         _loaded = false;
      }
      
      public function load(param1:String, param2:* = null) : void
      {
         _loaded = false;
         _sound.load(new URLRequest(param1),SoundLoaderContext(param2));
      }
      
      private function onLoadProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1.clone());
      }
      
      public function pauseLoad() : void
      {
         try
         {
            _sound.close();
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

package com.exileetiquette.loader
{
   import com.exileetiquette.loader.events.LoadManagerEvent;
   import com.exileetiquette.loader.events.LoadManagerProgressEvent;
   import com.exileetiquette.loader.formats.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class LoadManager extends EventDispatcher
   {
      
      private static var _formatExtensions:Dictionary = new Dictionary();
      
      private static var _global:LoadManager;
      
      private static var _local:Dictionary = new Dictionary();
      
      private static var _formats:Dictionary = new Dictionary();
      
      {
         registerFileFormat("binary",BinaryHandler);
         registerFileFormat("image",ImageHandler,["jpg","jpeg","png","gif"]);
         registerFileFormat("sound",SoundHandler,["mp3"]);
         registerFileFormat("swf",SWFHandler,["swf"]);
         registerFileFormat("text",GenericHandler,["txt"]);
         registerFileFormat("xml",XMLHandler,["xml","htm","html"]);
      }
      
      private var _queue:Array;
      
      private var _baseURL:String = "";
      
      private var _nextFileId:int = 0;
      
      private var _id:String;
      
      private var _loadingXML:Boolean;
      
      private var _dispatchProgressEvents:Boolean;
      
      private var _filesById:Dictionary;
      
      private var _files:Array;
      
      private var _loading:Boolean = true;
      
      public function LoadManager(param1:LoadManagerSingletonEnforcer, param2:String)
      {
         _baseURL = "";
         _nextFileId = 0;
         _loading = true;
         super();
         if(!param1)
         {
            throw new Error("LoadManager is a Multiton and cannot be directly instantiated. Use LoadManager.getInstance().");
         }
         _id = param2;
         _queue = [];
         _files = [];
         _filesById = new Dictionary();
      }
      
      public static function listRegisteredFileFormats() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         _loc1_ = "LoadManager registered file formats: ";
         for(_loc2_ in _formats)
         {
            _loc1_ += "\r\t" + _loc2_ + " (handler: " + _formats[_loc2_] + ")";
         }
      }
      
      public static function getInstance(param1:String = null) : LoadManager
      {
         var _loc2_:LoadManager = null;
         if(!_global)
         {
            _global = new LoadManager(new LoadManagerSingletonEnforcer(),"$_global");
         }
         if(!param1 || param1 == "$_global")
         {
            return _global;
         }
         _loc2_ = _local[param1];
         if(!_local[param1])
         {
            _loc2_ = new LoadManager(new LoadManagerSingletonEnforcer(),param1);
         }
         return _loc2_;
      }
      
      public static function registerFileFormat(param1:String, param2:Class, param3:Array = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _formats[param1] = param2;
         if(param3)
         {
            _loc4_ = int(param3.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _formatExtensions[param3[_loc5_]] = param1;
               _loc5_++;
            }
         }
      }
      
      private function getNextFileId() : String
      {
         return "_file" + _nextFileId++;
      }
      
      public function get loading() : Boolean
      {
         return _loading;
      }
      
      public function destroy() : void
      {
         purge();
         _local[_id] = null;
         if(_id != "$_global")
         {
            _global.loadQueue();
         }
      }
      
      private function onXMLComplete(param1:Event) : void
      {
         var _loc2_:XML = null;
         _loc2_ = XML(param1.currentTarget.data);
         _loadingXML = false;
         dispatchEvent(new LoadManagerEvent(LoadManagerEvent.LIST_COMPLETE,false,false,null,_loc2_));
         addToQueueFromXML(_loc2_);
         loadQueue();
      }
      
      public function get filesTotal() : uint
      {
         return _queue.length + _files.length;
      }
      
      private function getHandlerIdFromURL(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc2_ = param1.substr(param1.lastIndexOf(".") + 1);
         _loc3_ = String(_formatExtensions[_loc2_]);
         return !!_loc3_ ? _loc3_ : "binary";
      }
      
      public function set dispatchProgressEvents(param1:Boolean) : void
      {
         setDispatchProgressEvents(param1);
      }
      
      public function getQueueList() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = [];
         _loc2_ = int(_queue.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(LoadManagerFile(_queue[_loc3_]).id);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function getFileInQueue(param1:String) : LoadManagerFile
      {
         var _loc2_:uint = 0;
         var _loc3_:LoadManagerFile = null;
         var _loc4_:int = 0;
         _loc2_ = _queue.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _queue[_loc4_];
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      private function setBaseURL(param1:String) : void
      {
         _baseURL = param1;
         if(_baseURL.substr(_baseURL.length - 1) != "/")
         {
            _baseURL += "/";
         }
      }
      
      public function getFileURL(param1:String) : String
      {
         if(!_filesById[param1])
         {
            return null;
         }
         return LoadManagerFile(_filesById[param1]).url;
      }
      
      private function onFileIOError(param1:IOErrorEvent) : void
      {
         _loading = false;
         removeFromQueue(LoadManagerFile(_queue[0]).id);
         dispatchEvent(param1.clone());
      }
      
      public function purge() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:LoadManagerFile = null;
         var _loc4_:int = 0;
         _loc1_ = _files.concat(_queue);
         _loc2_ = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            _loc3_.destroy();
            _loc4_++;
         }
         _queue = [];
         _files = [];
         _filesById = new Dictionary();
      }
      
      public function getFileList() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = [];
         _loc2_ = int(_files.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_.push(LoadManagerFile(_files[_loc3_]).id);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function onXMLError(param1:IOErrorEvent) : void
      {
         _loadingXML = false;
         dispatchEvent(param1.clone());
      }
      
      public function pauseQueue() : void
      {
         var _loc1_:LoadManagerFile = null;
         _loading = false;
         _loc1_ = _queue[0];
         if(!_loc1_)
         {
            return;
         }
         _loc1_.handler.pauseLoad();
      }
      
      public function getFileData(param1:String) : *
      {
         if(!_filesById[param1])
         {
            return null;
         }
         return LoadManagerFile(_filesById[param1]).data;
      }
      
      public function loadQueueFromXML(param1:String) : void
      {
         var _loc2_:URLLoader = null;
         if(_loading)
         {
            pauseQueue();
         }
         _loadingXML = true;
         _loc2_ = new URLLoader();
         _loc2_.addEventListener(Event.COMPLETE,onXMLComplete,false,0,true);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,onXMLError,false,0,true);
         _loc2_.load(new URLRequest(_baseURL + param1));
      }
      
      public function set baseURL(param1:String) : void
      {
         setBaseURL(param1);
      }
      
      private function onFileProgress(param1:ProgressEvent) : void
      {
         var _loc2_:LoadManagerFile = null;
         _loc2_ = LoadManagerFile(_queue[0]);
         dispatchEvent(new LoadManagerProgressEvent(LoadManagerProgressEvent.PROGRESS,false,false,param1.bytesLoaded,param1.bytesTotal,_loc2_.id));
      }
      
      private function setDispatchProgressEvents(param1:Boolean) : void
      {
         var _loc2_:LoadManagerFile = null;
         var _loc3_:IEventDispatcher = null;
         _dispatchProgressEvents = param1;
         _loc2_ = LoadManagerFile(_queue[0]);
         _loc3_ = IEventDispatcher(_loc2_.handler);
         _loc3_.removeEventListener(ProgressEvent.PROGRESS,onFileProgress);
         if(_dispatchProgressEvents)
         {
            _loc3_.addEventListener(ProgressEvent.PROGRESS,onFileProgress);
         }
      }
      
      public function loadQueue() : void
      {
         var _loc1_:LoadManagerFile = null;
         var _loc2_:IEventDispatcher = null;
         if(_loadingXML || _queue.length == 0)
         {
            return;
         }
         _loc1_ = _queue[0];
         _loc2_ = IEventDispatcher(_loc1_.handler);
         _loc2_.addEventListener(Event.COMPLETE,onFileLoadComplete,false,0,true);
         _loc2_.addEventListener(IOErrorEvent.IO_ERROR,onFileIOError,false,0,true);
         if(_dispatchProgressEvents)
         {
            _loc2_.addEventListener(ProgressEvent.PROGRESS,onFileProgress,false,0,true);
         }
         if(_id != "$_global")
         {
            _global.pauseQueue();
         }
         _loading = true;
         _loc1_.handler.load(_baseURL + _loc1_.url,_loc1_.context);
      }
      
      public function getFileType(param1:String) : String
      {
         if(!_filesById[param1])
         {
            return null;
         }
         return getHandlerIdFromURL(LoadManagerFile(_filesById[param1]).url);
      }
      
      public function purgeFile(param1:String) : void
      {
         var _loc2_:LoadManagerFile = null;
         var _loc3_:int = 0;
         removeFromQueue(param1);
         _loc2_ = _filesById[param1];
         if(!_loc2_)
         {
            return;
         }
         _loc3_ = _files.indexOf(_loc2_);
         if(_loc3_ > -1)
         {
            _files.splice(_loc3_,1);
         }
         _loc2_.destroy();
         delete _filesById[param1];
      }
      
      public function get dispatchProgressEvents() : Boolean
      {
         return _dispatchProgressEvents;
      }
      
      public function addToQueueFromXML(param1:XML) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:XML = null;
         _loc2_ = uint(param1.file.length());
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.file[_loc3_];
            addToQueue(_loc4_.toString(),_loc4_.hasOwnProperty("@priority") ? uint(int(_loc4_.@priority.toString())) : 0,_loc4_.@id.toString(),_loc4_.@type.toString(),null,_loc4_);
            _loc3_++;
         }
         dispatchEvent(new LoadManagerEvent(LoadManagerEvent.LIST_ADDED_TO_QUEUE,false,false,null,param1));
      }
      
      public function get filesQueued() : uint
      {
         return _queue.length;
      }
      
      public function get baseURL() : String
      {
         return _baseURL;
      }
      
      public function setLoaderContext(param1:String, param2:*) : void
      {
         var _loc3_:LoadManagerFile = null;
         _loc3_ = getFileInQueue(param1);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.context = param2;
      }
      
      public function removeFromQueue(param1:String) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:LoadManagerFile = null;
         var _loc4_:int = 0;
         _loc2_ = _queue.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _queue[_loc4_];
            if(_loc3_.id == param1)
            {
               _queue.splice(_loc4_,1);
               break;
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            _loc3_.destroy();
         }
         if(_loc4_ == 0 && _loading)
         {
            loadQueue();
         }
      }
      
      private function onFileLoadComplete(param1:Event) : void
      {
         var _loc2_:LoadManagerFile = null;
         var _loc3_:* = undefined;
         _loc2_ = LoadManagerFile(_queue.shift());
         _loc3_ = _loc2_.handler.getContent();
         _files.push(_loc2_);
         _filesById[_loc2_.id] = _loc2_;
         dispatchEvent(new LoadManagerEvent(LoadManagerEvent.FILE_COMPLETE,false,false,_loc2_.id));
         if(_queue.length == 0)
         {
            dispatchEvent(new LoadManagerEvent(LoadManagerEvent.QUEUE_COMPLETE));
            if(_id != "$_global")
            {
               _global.loadQueue();
            }
         }
         else
         {
            loadQueue();
         }
      }
      
      public function get filesLoaded() : uint
      {
         return _files.length;
      }
      
      public function getFile(param1:String) : *
      {
         if(!_filesById[param1])
         {
            return null;
         }
         return LoadManagerFile(_filesById[param1]).handler.getContent();
      }
      
      public function addToQueue(param1:String, param2:uint = 0, param3:String = null, param4:String = null, param5:* = null, param6:* = null) : String
      {
         var _loc7_:Class = null;
         var _loc8_:LoadManagerFile = null;
         var _loc9_:LoadManagerFile = null;
         var _loc10_:int = 0;
         if(!param4)
         {
            param4 = getHandlerIdFromURL(param1);
         }
         if(!(_loc7_ = _formats[param4]))
         {
            throw new Error("No format handler with the type \'" + param4 + "\' has been registered. Use LoadManager.registerFileFormat() to register new file formats.");
         }
         (_loc8_ = new LoadManagerFile()).handler = new _loc7_();
         _loc8_.id = !!param3 ? param3 : getNextFileId();
         _loc8_.priority = param2;
         _loc8_.url = param1;
         _loc8_.context = param5;
         _loc8_.data = param6;
         if(_queue.length > 0 && param2 > 0)
         {
            _loc9_ = LoadManagerFile(_queue[0]);
            if(param2 > _loc9_.priority)
            {
               _loc9_.handler.pauseLoad();
               _queue.unshift(_loc8_);
               if(_loading)
               {
                  loadQueue();
               }
               return _loc8_.id;
            }
            while(_loc9_.priority >= param2)
            {
               _loc10_++;
               if(_loc10_ == _queue.length)
               {
                  break;
               }
               _loc9_ = LoadManagerFile(_queue[_loc10_]);
            }
            if(_loc10_ == _queue.length)
            {
               _queue.push(_loc8_);
            }
            else
            {
               _queue.splice(_loc10_,0,_loc8_);
            }
         }
         else
         {
            _queue.push(_loc8_);
         }
         if(_loading && _queue.length == 1)
         {
            loadQueue();
         }
         return _loc8_.id;
      }
   }
}

class LoadManagerSingletonEnforcer
{
    
   
   public function LoadManagerSingletonEnforcer()
   {
      super();
   }
}

import com.exileetiquette.loader.formats.IFormatHandler;

class LoadManagerFile
{
    
   
   public var id:String;
   
   public var priority:uint = 0;
   
   public var handler:IFormatHandler;
   
   public var data:*;
   
   public var url:String;
   
   public var context:*;
   
   public function LoadManagerFile()
   {
      priority = 0;
      super();
   }
   
   public function destroy() : void
   {
      if(handler)
      {
         handler.destroy();
      }
      data = null;
      handler = null;
      context = null;
      url = id = null;
      priority = 0;
   }
}

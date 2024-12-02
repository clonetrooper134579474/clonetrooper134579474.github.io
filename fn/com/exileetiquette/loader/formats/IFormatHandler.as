package com.exileetiquette.loader.formats
{
   public interface IFormatHandler
   {
       
      
      function getContent() : *;
      
      function load(param1:String, param2:* = null) : void;
      
      function destroy() : void;
      
      function pauseLoad() : void;
   }
}

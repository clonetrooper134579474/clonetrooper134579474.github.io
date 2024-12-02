package org.flintparticles.common.utils
{
   public function interpolateColors(param1:uint, param2:uint, param3:Number) : uint
   {
      var _loc4_:Number = NaN;
      var _loc5_:uint = 0;
      var _loc6_:uint = 0;
      var _loc7_:uint = 0;
      var _loc8_:uint = 0;
      _loc4_ = 1 - param3;
      _loc5_ = Math.round((param1 >>> 16 & 255) * param3 + (param2 >>> 16 & 255) * _loc4_);
      _loc6_ = Math.round((param1 >>> 8 & 255) * param3 + (param2 >>> 8 & 255) * _loc4_);
      _loc7_ = Math.round((param1 & 255) * param3 + (param2 & 255) * _loc4_);
      return (_loc8_ = Math.round((param1 >>> 24 & 255) * param3 + (param2 >>> 24 & 255) * _loc4_)) << 24 | _loc5_ << 16 | _loc6_ << 8 | _loc7_;
   }
}

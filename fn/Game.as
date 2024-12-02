package
{
   import com.exileetiquette.loader.LoadManager;
   import com.exileetiquette.loader.events.LoadManagerEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import fn.*;
   import org.flintparticles.common.events.*;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.renderers.*;
   
   public class Game extends MovieClip
   {
       
      
      internal var timer01:Number;
      
      internal var timer02:Number;
      
      internal var timer03:Number;
      
      internal var bombs:Array;
      
      internal var fruit:Array;
      
      internal var fragments:Array;
      
      internal const LINE_FADEOUT_TIME:Number = 500;
      
      internal var missDisplay:MissDisplay;
      
      internal const FRUIT_SPAWN_MAX_X:Number = 380;
      
      internal var bombs_mc:Sprite;
      
      internal const SWIPE_MAX_LENGTH:Number = 320;
      
      internal var currentState:GameState = null;
      
      internal var currentScore:Number;
      
      internal var gameStates:Array;
      
      internal var oldState:GameState = null;
      
      internal var swipe_mc:Sprite;
      
      internal var fruitTypes:Array;
      
      internal var swipeLength:Number = 0;
      
      internal var failScreen_mc:Sprite;
      
      internal const FRUIT_MAX_VEL_X:Number = 10;
      
      internal const FRUIT_MAX_VEL_Y:Number = 13;
      
      internal var splatRenderer:BitmapRenderer;
      
      internal const FRUIT_SPAWN_Y:Number = 400;
      
      internal var paused:Boolean;
      
      internal var fragments_mc:Sprite;
      
      internal const FRUIT_MIN_VEL_Y:Number = 9;
      
      internal var particleRenderer:BitmapRenderer;
      
      internal const SWIPE_UPDATE_DELAY:Number = 0;
      
      internal var currentLevel:Number;
      
      internal var fruit_mc:Sprite;
      
      internal var lineTimes:Array;
      
      internal const FRUIT_SPAWN_DELAY:Number = 90;
      
      internal const LINE_COLLISION_POINT_DIST:Number = 16;
      
      internal var scoreDisplay:ScoreDisplay;
      
      internal var gameover:Boolean;
      
      internal var bg_mc:Loader;
      
      internal const FRUIT_SPAWN_MIN_X:Number = 100;
      
      internal var mouseIsDown:Boolean = false;
      
      internal var effects_mc:Sprite;
      
      internal var linePoints:Array;
      
      internal var currentMissCount:Number;
      
      internal const LINE_TIMEOUT:Number = 200;
      
      public function Game()
      {
         var _loc1_:* = undefined;
         currentState = null;
         oldState = null;
         mouseIsDown = false;
         swipeLength = 0;
         super();
         _loc1_ = LoadManager.getInstance();
         _loc1_.addToQueue("images/watermelon.png",0,"Watermelon.png");
         _loc1_.addToQueue("images/watermelon_half.png",0,"Watermelon_half.png");
         _loc1_.addToQueue("images/orange.png",0,"Orange.png");
         _loc1_.addToQueue("images/orange_half.png",0,"Orange_half.png");
         _loc1_.addToQueue("images/coconut.png",0,"Coconut.png");
         _loc1_.addToQueue("images/coconut_half.png",0,"Coconut_half.png");
         _loc1_.addToQueue("images/splat01.png",0,"splat01.png");
         _loc1_.addToQueue("images/particle01.png",0,"particle01.png");
         _loc1_.addToQueue("images/bomb.png",0,"bomb.png");
         _loc1_.addToQueue("images/bomb_explode.png",0,"bomb_explode.png");
         _loc1_.addToQueue("images/cross.png",0,"cross.png");
         _loc1_.addToQueue("images/fail_screen.png",0,"fail_screen.png");
         _loc1_.addEventListener(LoadManagerEvent.QUEUE_COMPLETE,LoadingComplete);
         fruitTypes = new Array();
         fruitTypes.push(new FruitType("Watermelon","Watermelon.png","Watermelon_half.png",60,1,16711734));
         fruitTypes.push(new FruitType("Orange","Orange.png","Orange_half.png",32,2,16740390));
         fruitTypes.push(new FruitType("Coconut","Coconut.png","Coconut_half.png",32,2,16777215));
         fruit = new Array();
         fragments = new Array();
         bombs = new Array();
         scoreDisplay = null;
         missDisplay = null;
         failScreen_mc = null;
         effects_mc = null;
         fruit_mc = new Sprite();
         fragments_mc = new Sprite();
         swipe_mc = new Sprite();
         bombs_mc = new Sprite();
         bg_mc = new Loader();
         bg_mc.load(new URLRequest("images/bg01.png"));
         splatRenderer = new BitmapRenderer(new Rectangle(0,0,480,320));
         splatRenderer.smoothing = true;
         addChild(bg_mc);
         addChild(splatRenderer);
         addChild(fragments_mc);
         addChild(fruit_mc);
         addChild(bombs_mc);
         addChild(swipe_mc);
         addEventListener(Event.ENTER_FRAME,EnterFrameEvent);
         gameStates = new Array();
         gameStates.push(new GameState("MainGame",EnterGameState,UpdateGameState,ExitGameState));
      }
      
      public function EnterFrameEvent(param1:Event) : *
      {
         if(currentState != null && currentState.UpdateState != null)
         {
            currentState.UpdateState();
         }
      }
      
      public function MouseDownEvent(param1:MouseEvent) : *
      {
      }
      
      public function AddFruit(param1:Fruit) : *
      {
         fruit_mc.addChild(param1);
         fruit.push(param1);
      }
      
      public function ExitGameState() : *
      {
         removeEventListener(MouseEvent.MOUSE_UP,GameMouseUpEvent,true);
         removeEventListener(MouseEvent.MOUSE_DOWN,GameMouseDownEvent,true);
         removeEventListener(MouseEvent.MOUSE_MOVE,GameMouseMoveEvent,true);
      }
      
      public function randRange(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      public function MouseMoveEvent(param1:MouseEvent) : *
      {
      }
      
      public function LoadingComplete(param1:Event) : *
      {
         SetGameState("MainGame");
      }
      
      private function ExplosionFinished(param1:Event) : *
      {
         particleRenderer.removeEmitter(Emitter2D(param1.target));
         Emitter2D(param1.target).removeEventListener(EmitterEvent.EMITTER_EMPTY,ExplosionFinished);
      }
      
      private function SplatFinished(param1:Event) : *
      {
         splatRenderer.removeEmitter(Emitter2D(param1.target));
         Emitter2D(param1.target).removeEventListener(EmitterEvent.EMITTER_EMPTY,SplatFinished);
      }
      
      public function SpawnBomb(param1:Number, param2:Number = 0) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Bomb = null;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = FRUIT_SPAWN_MIN_X + Math.random() * (FRUIT_SPAWN_MAX_X - FRUIT_SPAWN_MIN_X);
            _loc5_ = FRUIT_SPAWN_Y;
            _loc6_ = (_loc4_ - FRUIT_SPAWN_MIN_X - (FRUIT_SPAWN_MAX_X - FRUIT_SPAWN_MIN_X) / 2) / (FRUIT_SPAWN_MAX_X - FRUIT_SPAWN_MIN_X) / 2;
            if((_loc7_ = Math.random() * -_loc6_ * FRUIT_MAX_VEL_X) < 0)
            {
               if(_loc7_ > -2)
               {
                  _loc7_ = -2;
               }
            }
            else if(_loc7_ < 2)
            {
               _loc7_ = 2;
            }
            _loc8_ = Math.random() * (FRUIT_MAX_VEL_Y - FRUIT_MIN_VEL_Y) + FRUIT_MIN_VEL_Y;
            _loc9_ = Math.round(Math.random() * (fruitTypes.length - 1));
            (_loc10_ = new Bomb(_loc4_,_loc5_,new Point(_loc7_,-_loc8_))).mouseEnabled = false;
            bombs.push(_loc10_);
            bombs_mc.addChild(_loc10_);
            _loc3_++;
         }
      }
      
      public function GameMouseDownEvent(param1:MouseEvent) : *
      {
         if(gameover)
         {
            mouseIsDown = true;
         }
         else if(!paused || gameover)
         {
            mouseIsDown = true;
            linePoints = new Array();
            lineTimes = new Array();
            linePoints.push(new Point(param1.stageX,param1.stageY));
            lineTimes.push(new Date().valueOf());
            swipeLength = 0;
            timer02 = 0;
         }
      }
      
      public function MouseUpEvent(param1:MouseEvent) : *
      {
      }
      
      public function UpdateGameState() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Fruit = null;
         var _loc6_:Number = NaN;
         var _loc7_:Fragment = null;
         var _loc8_:Number = NaN;
         var _loc9_:Bomb = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:* = undefined;
         if(!paused)
         {
            _loc2_ = new Array();
            if(fruit.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < fruit.length)
               {
                  (_loc5_ = fruit[_loc1_]).velocity.y = _loc5_.velocity.y + 0.2;
                  _loc5_.x += _loc5_.velocity.x;
                  _loc5_.y += _loc5_.velocity.y;
                  _loc5_.rotation += _loc5_.rotationSpeed;
                  if(_loc5_.y > 360 && _loc5_.velocity.y > 0)
                  {
                     _loc2_.push(_loc1_);
                     ++currentMissCount;
                     missDisplay.AddMiss();
                     if(currentMissCount >= 3)
                     {
                        paused = true;
                        gameover = true;
                        timer03 = 90;
                     }
                  }
                  _loc1_++;
               }
            }
            if(_loc2_.length > 0)
            {
               _loc1_ = _loc2_.length - 1;
               while(_loc1_ >= 0)
               {
                  _loc6_ = Number(_loc2_[_loc1_]);
                  if(fruit_mc.contains(fruit[_loc6_]))
                  {
                     fruit_mc.removeChild(fruit[_loc6_]);
                  }
                  if(_loc6_ < fruit.length - 1)
                  {
                     fruit[_loc6_] = fruit[fruit.length - 1];
                  }
                  fruit.pop();
                  _loc1_--;
               }
               if(fruit.length == 0)
               {
                  timer01 = FRUIT_SPAWN_DELAY;
               }
            }
            _loc3_ = new Array();
            if(fragments.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < fragments.length)
               {
                  (_loc7_ = fragments[_loc1_]).velocity.y = _loc7_.velocity.y + 0.2;
                  _loc7_.x += _loc7_.velocity.x;
                  _loc7_.y += _loc7_.velocity.y;
                  _loc7_.rotation += _loc7_.rotationSpeed;
                  if(_loc7_.y > 500)
                  {
                     _loc3_.push(_loc1_);
                  }
                  _loc1_++;
               }
            }
            if(_loc3_.length > 0)
            {
               _loc1_ = _loc3_.length - 1;
               while(_loc1_ >= 0)
               {
                  _loc8_ = Number(_loc3_[_loc1_]);
                  if(fragments_mc.contains(fragments[_loc8_]))
                  {
                     fragments_mc.removeChild(fragments[_loc8_]);
                  }
                  if(_loc8_ < fragments.length - 1)
                  {
                     fragments[_loc8_] = fragments[fragments.length - 1];
                  }
                  fragments.pop();
                  _loc1_--;
               }
            }
            _loc4_ = new Array();
            if(bombs.length > 0)
            {
               _loc1_ = 0;
               while(_loc1_ < bombs.length)
               {
                  (_loc9_ = bombs[_loc1_]).velocity.y = _loc9_.velocity.y + 0.2;
                  _loc9_.x += _loc9_.velocity.x;
                  _loc9_.y += _loc9_.velocity.y;
                  _loc9_.rotation += _loc9_.rotationSpeed;
                  if(_loc9_.y > 500)
                  {
                     _loc4_.push(_loc1_);
                  }
                  _loc1_++;
               }
            }
            if(_loc4_.length > 0)
            {
               _loc1_ = _loc4_.length - 1;
               while(_loc1_ >= 0)
               {
                  _loc10_ = Number(_loc4_[_loc1_]);
                  if(bombs_mc.contains(bombs[_loc10_]))
                  {
                     bombs_mc.removeChild(bombs[_loc10_]);
                  }
                  if(_loc10_ < bombs.length - 1)
                  {
                     bombs[_loc10_] = bombs[bombs.length - 1];
                  }
                  bombs.pop();
                  _loc1_--;
               }
            }
            if(fruit.length == 0 && bombs.length == 0)
            {
               if(timer01-- <= 0)
               {
                  ++currentLevel;
                  _loc11_ = Math.max(1,Math.floor(currentLevel / 4));
                  _loc12_ = Math.floor(currentLevel / 3);
                  _loc13_ = randRange(_loc11_,_loc12_);
                  _loc14_ = Math.floor(Math.random() * currentLevel / 6);
                  if(currentLevel < 3)
                  {
                     _loc13_ = 1;
                     _loc14_ = 0;
                  }
                  else if(currentLevel < 5)
                  {
                     _loc13_ = 2;
                     _loc14_ = 0;
                  }
                  else if(currentLevel < 6)
                  {
                     _loc13_ = 3;
                     _loc14_ = 0;
                  }
                  else if(currentLevel < 8)
                  {
                     _loc13_ = 1;
                     _loc14_ = 1;
                  }
                  else if(currentLevel < 9)
                  {
                     _loc13_ = 2;
                     _loc14_ = 1;
                  }
                  else if(currentLevel < 10)
                  {
                     _loc13_ = 0;
                     _loc14_ = 2;
                  }
                  else if(currentLevel < 11)
                  {
                     _loc13_ = 1;
                     _loc14_ = 2;
                  }
                  SpawnFruit(_loc13_);
                  SpawnBomb(_loc14_);
               }
            }
            --timer02;
         }
         if(linePoints != null && linePoints.length > 0)
         {
            swipe_mc.graphics.clear();
            swipe_mc.graphics.moveTo(linePoints[0].x,linePoints[0].y);
            _loc15_ = new Date().valueOf();
            _loc1_ = 1;
            while(_loc1_ < linePoints.length)
            {
               _loc16_ = Math.max(0,1 - (_loc15_ - lineTimes[_loc1_]) / LINE_FADEOUT_TIME);
               swipe_mc.graphics.lineStyle(_loc16_ * 8,16777215,_loc16_);
               swipe_mc.graphics.lineTo(linePoints[_loc1_].x,linePoints[_loc1_].y);
               _loc1_++;
            }
         }
         if(gameover && timer03 > 0)
         {
            --timer03;
            if(timer03 <= 0)
            {
               if(failScreen_mc == null)
               {
                  failScreen_mc = new Sprite();
                  (_loc17_ = new Bitmap(BitmapData(LoadManager.getInstance().getFile("fail_screen.png")))).x = 0;
                  _loc17_.y = 0;
                  _loc17_.smoothing = true;
                  failScreen_mc.addChild(_loc17_);
                  failScreen_mc.mouseEnabled = false;
                  addChild(failScreen_mc);
               }
               failScreen_mc.visible = true;
            }
         }
      }
      
      public function GameMouseMoveEvent(param1:MouseEvent) : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Point = null;
         var _loc4_:Number = NaN;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Point = null;
         var _loc9_:Array = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = undefined;
         var _loc13_:FruitSplat = null;
         var _loc14_:FruitExplosion = null;
         var _loc15_:Number = NaN;
         var _loc16_:* = undefined;
         bg_mc.alpha = 1;
         if(mouseIsDown)
         {
            _loc2_ = new Date().valueOf();
            if(swipeLength < SWIPE_MAX_LENGTH)
            {
               _loc3_ = new Point(param1.stageX - linePoints[linePoints.length - 1].x,param1.stageY - linePoints[linePoints.length - 1].y);
               _loc4_ = Math.max(1,Math.floor(_loc3_.length / LINE_COLLISION_POINT_DIST));
               _loc5_ = new Point(_loc3_.x / _loc4_,_loc3_.y / _loc4_);
               _loc6_ = new Point(linePoints[linePoints.length - 1].x,linePoints[linePoints.length - 1].y);
            }
            if(timer02 <= 0 && !paused && !gameover)
            {
               if(swipeLength < SWIPE_MAX_LENGTH)
               {
                  _loc3_ = new Point(param1.stageX - linePoints[linePoints.length - 1].x,param1.stageY - linePoints[linePoints.length - 1].y);
                  _loc4_ = Math.max(1,Math.floor(_loc3_.length / LINE_COLLISION_POINT_DIST));
                  _loc5_ = new Point(_loc3_.x / _loc4_,_loc3_.y / _loc4_);
                  _loc6_ = new Point(linePoints[linePoints.length - 1].x,linePoints[linePoints.length - 1].y);
                  _loc7_ = 0;
                  while(_loc7_ < _loc4_)
                  {
                     _loc8_ = new Point(_loc6_.x + (_loc5_.x * _loc7_ + 1),_loc6_.y + (_loc5_.y * _loc7_ + 1));
                     _loc9_ = new Array();
                     _loc10_ = 0;
                     while(_loc10_ < fruit.length)
                     {
                        if((_loc12_ = new Point(_loc8_.x - fruit[_loc10_].x,_loc8_.y - fruit[_loc10_].y)).length < fruit[_loc10_].type.radius)
                        {
                           _loc3_.normalize(_loc3_.length * 10);
                           (_loc13_ = new FruitSplat(10,_loc3_,fruit[_loc10_].type.colour)).x = fruit[_loc10_].x;
                           _loc13_.y = fruit[_loc10_].y;
                           _loc13_.start();
                           _loc13_.addEventListener(EmitterEvent.EMITTER_EMPTY,SplatFinished);
                           splatRenderer.addEmitter(_loc13_);
                           (_loc14_ = new FruitExplosion(10,_loc3_,fruit[_loc10_].type.radius,fruit[_loc10_].type.colour)).x = fruit[_loc10_].x;
                           _loc14_.y = fruit[_loc10_].y;
                           _loc14_.start();
                           _loc13_.addEventListener(EmitterEvent.EMITTER_EMPTY,SplatFinished);
                           splatRenderer.addEmitter(_loc14_);
                           _loc3_.normalize(Math.max(5,Math.min(_loc3_.length / 10,10)));
                           SpawnFragments(fruit[_loc10_],_loc3_);
                           currentScore += fruit[_loc10_].type.points;
                           scoreDisplay.SetScore(currentScore);
                           _loc9_.push(_loc10_);
                        }
                        _loc10_++;
                     }
                     if(_loc9_.length > 0)
                     {
                        _loc7_ = _loc9_.length - 1;
                        while(_loc7_ >= 0)
                        {
                           _loc15_ = Number(_loc9_[_loc7_]);
                           if(fruit_mc.contains(fruit[_loc15_]))
                           {
                              fruit_mc.removeChild(fruit[_loc15_]);
                           }
                           if(_loc15_ < fruit.length - 1)
                           {
                              fruit[_loc15_] = fruit[fruit.length - 1];
                           }
                           fruit.pop();
                           _loc7_--;
                        }
                        if(fruit.length == 0)
                        {
                           timer01 = FRUIT_SPAWN_DELAY;
                        }
                     }
                     _loc11_ = 0;
                     while(_loc11_ < bombs.length)
                     {
                        if((_loc12_ = new Point(_loc8_.x - bombs[_loc11_].x,_loc8_.y - bombs[_loc11_].y)).length < bombs[_loc11_].radius)
                        {
                           _loc3_.normalize(_loc3_.length * 10);
                           if(effects_mc != null && contains(effects_mc))
                           {
                              removeChild(effects_mc);
                           }
                           effects_mc = new Sprite();
                           addChild(effects_mc);
                           (_loc16_ = new Bitmap(BitmapData(LoadManager.getInstance().getFile("bomb_explode.png")))).x = bombs[_loc11_].x - _loc16_.width / 2;
                           _loc16_.y = bombs[_loc11_].y - _loc16_.height / 2;
                           _loc16_.smoothing = true;
                           effects_mc.addChild(_loc16_);
                           paused = true;
                           gameover = true;
                           timer03 = 90;
                        }
                        _loc11_++;
                     }
                     _loc7_++;
                  }
               }
               timer02 = SWIPE_UPDATE_DELAY;
            }
            else if(mouseIsDown && gameover && timer03 <= 0)
            {
               if(swipeLength > 50)
               {
                  ResetGame();
               }
            }
            if(swipeLength < SWIPE_MAX_LENGTH)
            {
               linePoints.push(new Point(param1.stageX,param1.stageY));
               lineTimes.push(_loc2_);
               swipeLength += new Point(linePoints[linePoints.length - 2].x - param1.stageX,linePoints[linePoints.length - 2].y - param1.stageY).length;
            }
         }
      }
      
      private function SpawnFragments(param1:Fruit, param2:Point) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         _loc3_ = Math.atan2(param2.y,param2.x);
         _loc4_ = param2.length;
         _loc5_ = new Point(Math.cos(_loc3_ + 0.5) * _loc4_,Math.sin(_loc3_ + 0.5) * _loc4_);
         _loc6_ = new Point(Math.cos(_loc3_ - 0.5) * _loc4_,Math.sin(_loc3_ - 0.5) * _loc4_);
         AddFragment(new Fragment(param1.type.fragmentSrc,param1.x,param1.y,_loc5_,_loc3_ * 180 / Math.PI,Math.random() * 5));
         AddFragment(new Fragment(param1.type.fragmentSrc,param1.x,param1.y,_loc6_,_loc3_ * 180 / Math.PI + 180,Math.random() * -5));
      }
      
      public function SpawnFruit(param1:Number, param2:Number = 0) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Fruit = null;
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc4_ = FRUIT_SPAWN_MIN_X + Math.random() * (FRUIT_SPAWN_MAX_X - FRUIT_SPAWN_MIN_X);
            _loc5_ = FRUIT_SPAWN_Y;
            _loc6_ = (_loc4_ - FRUIT_SPAWN_MIN_X - (FRUIT_SPAWN_MAX_X - FRUIT_SPAWN_MIN_X) / 2) / (FRUIT_SPAWN_MAX_X - FRUIT_SPAWN_MIN_X) / 2;
            _loc7_ = Math.random() * -_loc6_ * FRUIT_MAX_VEL_X;
            _loc8_ = Math.random() * (FRUIT_MAX_VEL_Y - FRUIT_MIN_VEL_Y) + FRUIT_MIN_VEL_Y;
            _loc9_ = Math.round(Math.random() * (fruitTypes.length - 1));
            (_loc10_ = new Fruit(fruitTypes[_loc9_],_loc4_,_loc5_,new Point(_loc7_,-_loc8_))).mouseEnabled = false;
            fruit.push(_loc10_);
            fruit_mc.addChild(_loc10_);
            _loc3_++;
         }
      }
      
      public function GameMouseUpEvent(param1:MouseEvent) : *
      {
         mouseIsDown = false;
      }
      
      public function SetGameState(param1:String) : *
      {
         var _loc2_:Number = NaN;
         _loc2_ = 0;
         while(_loc2_ < gameStates.length)
         {
            if(gameStates[_loc2_].id == param1)
            {
               oldState = currentState;
               currentState = gameStates[_loc2_];
               if(oldState != null && oldState.ExitState != null)
               {
                  oldState.ExitState();
               }
               if(currentState != null && currentState.EnterState != null)
               {
                  currentState.EnterState();
               }
               return;
            }
            _loc2_++;
         }
      }
      
      public function ResetGame() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         currentLevel = 0;
         currentScore = 0;
         currentMissCount = 0;
         scoreDisplay.SetScore(currentScore);
         missDisplay.Reset();
         _loc1_ = 0;
         while(_loc1_ < fruit.length)
         {
            if(fruit_mc.contains(fruit[_loc1_]))
            {
               fruit_mc.removeChild(fruit[_loc1_]);
            }
            _loc1_++;
         }
         fruit = new Array();
         _loc2_ = 0;
         while(_loc2_ < bombs.length)
         {
            if(bombs_mc.contains(bombs[_loc2_]))
            {
               bombs_mc.removeChild(bombs[_loc2_]);
            }
            _loc2_++;
         }
         bombs = new Array();
         timer01 = FRUIT_SPAWN_DELAY;
         timer02 = SWIPE_UPDATE_DELAY;
         paused = false;
         gameover = false;
         mouseIsDown = false;
         if(Boolean(failScreen_mc) && contains(failScreen_mc))
         {
            removeChild(failScreen_mc);
            failScreen_mc = null;
         }
         if(effects_mc != null && contains(effects_mc))
         {
            removeChild(effects_mc);
            effects_mc = null;
         }
      }
      
      public function EnterGameState() : *
      {
         addEventListener(MouseEvent.MOUSE_UP,GameMouseUpEvent,true);
         addEventListener(MouseEvent.MOUSE_DOWN,GameMouseDownEvent,true);
         addEventListener(MouseEvent.MOUSE_MOVE,GameMouseMoveEvent,true);
         if(scoreDisplay == null)
         {
            scoreDisplay = new ScoreDisplay();
            addChild(scoreDisplay);
         }
         if(missDisplay == null)
         {
            missDisplay = new MissDisplay(3);
            addChild(missDisplay);
         }
         ResetGame();
      }
      
      public function AddFragment(param1:Fragment) : *
      {
         fragments_mc.addChild(param1);
         fragments.push(param1);
      }
   }
}

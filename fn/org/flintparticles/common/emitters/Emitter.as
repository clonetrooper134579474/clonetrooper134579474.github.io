package org.flintparticles.common.emitters
{
   import flash.events.EventDispatcher;
   import org.flintparticles.common.actions.Action;
   import org.flintparticles.common.activities.Activity;
   import org.flintparticles.common.behaviours.BehaviourArrayUtils;
   import org.flintparticles.common.counters.Counter;
   import org.flintparticles.common.counters.ZeroCounter;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.events.ParticleEvent;
   import org.flintparticles.common.events.UpdateEvent;
   import org.flintparticles.common.initializers.Initializer;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.common.particles.ParticleFactory;
   import org.flintparticles.common.utils.FrameUpdater;
   
   public class Emitter extends EventDispatcher
   {
       
      
      protected var _running:Boolean = false;
      
      protected var _activities:Array;
      
      protected var _particles:Array;
      
      protected var _initializers:Array;
      
      protected var _dispatchCounterComplete:Boolean = false;
      
      protected var _counter:Counter;
      
      protected var _started:Boolean = false;
      
      protected var _actions:Array;
      
      protected var _useInternalTick:Boolean = true;
      
      protected var _fixedFrameTime:Number = 0;
      
      protected var _particleFactory:ParticleFactory;
      
      protected var _maximumFrameTime:Number = 0.1;
      
      public function Emitter()
      {
         _useInternalTick = true;
         _fixedFrameTime = 0;
         _running = false;
         _started = false;
         _maximumFrameTime = 0.1;
         _dispatchCounterComplete = false;
         super();
         _particles = new Array();
         _actions = new Array();
         _initializers = new Array();
         _activities = new Array();
         _counter = new ZeroCounter();
      }
      
      public function dispatchCounterComplete() : void
      {
         _dispatchCounterComplete = true;
      }
      
      public function get counter() : Counter
      {
         return _counter;
      }
      
      public function runAhead(param1:Number, param2:Number = 10) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         _loc3_ = _maximumFrameTime;
         _loc4_ = 1 / param2;
         _maximumFrameTime = _loc4_;
         while(param1 > 0)
         {
            param1 -= _loc4_;
            update(_loc4_);
         }
         _maximumFrameTime = _loc3_;
      }
      
      public function addInitializer(param1:Initializer) : void
      {
         BehaviourArrayUtils.add(_initializers,param1);
         param1.addedToEmitter(this);
      }
      
      public function killAllParticles() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = int(_particles.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,_particles[_loc2_]));
            _particleFactory.disposeParticle(_particles[_loc2_]);
            _loc2_++;
         }
         _particles.length = 0;
      }
      
      public function stop() : void
      {
         if(_useInternalTick)
         {
            FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,updateEventListener);
         }
         _started = false;
         killAllParticles();
      }
      
      public function set fixedFrameTime(param1:Number) : void
      {
         _fixedFrameTime = param1;
      }
      
      public function get maximumFrameTime() : Number
      {
         return _maximumFrameTime;
      }
      
      public function set particles(param1:Array) : void
      {
         killAllParticles();
         addExistingParticles(param1,false);
      }
      
      public function get useInternalTick() : Boolean
      {
         return _useInternalTick;
      }
      
      public function set initializers(param1:Array) : void
      {
         var _loc2_:Initializer = null;
         for each(_loc2_ in _initializers)
         {
            _loc2_.removedFromEmitter(this);
         }
         _initializers = param1.slice();
         BehaviourArrayUtils.sortArray(_initializers);
         for each(_loc2_ in param1)
         {
            _loc2_.addedToEmitter(this);
         }
      }
      
      public function get particleFactory() : ParticleFactory
      {
         return _particleFactory;
      }
      
      private function updateEventListener(param1:UpdateEvent) : void
      {
         if(_fixedFrameTime)
         {
            update(_fixedFrameTime);
         }
         else
         {
            update(param1.time);
         }
      }
      
      protected function createParticle() : Particle
      {
         var _loc1_:Particle = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc1_ = _particleFactory.createParticle();
         _loc2_ = int(_initializers.length);
         initParticle(_loc1_);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            Initializer(_initializers[_loc3_]).initialize(this,_loc1_);
            _loc3_++;
         }
         _particles.push(_loc1_);
         dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_CREATED,_loc1_));
         return _loc1_;
      }
      
      protected function sortParticles() : void
      {
      }
      
      public function set maximumFrameTime(param1:Number) : void
      {
         _maximumFrameTime = param1;
      }
      
      protected function initParticle(param1:Particle) : void
      {
      }
      
      public function addAction(param1:Action) : void
      {
         BehaviourArrayUtils.add(_actions,param1);
         param1.addedToEmitter(this);
      }
      
      public function hasInitializerOfType(param1:Class) : Boolean
      {
         return BehaviourArrayUtils.containsType(_initializers,param1);
      }
      
      public function removeActivity(param1:Activity) : void
      {
         if(BehaviourArrayUtils.remove(_activities,param1))
         {
            param1.removedFromEmitter(this);
         }
      }
      
      public function removeInitializer(param1:Initializer) : void
      {
         if(BehaviourArrayUtils.remove(_initializers,param1))
         {
            param1.removedFromEmitter(this);
         }
      }
      
      public function get running() : Boolean
      {
         return _running;
      }
      
      public function hasActionOfType(param1:Class) : Boolean
      {
         return BehaviourArrayUtils.containsType(_actions,param1);
      }
      
      public function get fixedFrameTime() : Number
      {
         return _fixedFrameTime;
      }
      
      public function set particleFactory(param1:ParticleFactory) : void
      {
         _particleFactory = param1;
      }
      
      public function hasActivity(param1:Activity) : Boolean
      {
         return BehaviourArrayUtils.contains(_activities,param1);
      }
      
      public function get particles() : Array
      {
         return _particles;
      }
      
      public function addActivity(param1:Activity) : void
      {
         BehaviourArrayUtils.add(_activities,param1);
         param1.addedToEmitter(this);
      }
      
      public function get initializers() : Array
      {
         return _initializers;
      }
      
      public function removeAction(param1:Action) : void
      {
         if(BehaviourArrayUtils.remove(_actions,param1))
         {
            param1.removedFromEmitter(this);
         }
      }
      
      public function set activities(param1:Array) : void
      {
         var _loc2_:Activity = null;
         for each(_loc2_ in _activities)
         {
            _loc2_.removedFromEmitter(this);
         }
         _activities = param1.slice();
         BehaviourArrayUtils.sortArray(_activities);
         for each(_loc2_ in _activities)
         {
            _loc2_.addedToEmitter(this);
         }
      }
      
      public function addExistingParticles(param1:Array, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = int(param1.length);
         if(param2)
         {
            _loc5_ = int(_initializers.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  Initializer(_initializers[_loc6_]).initialize(this,param1[_loc4_]);
                  _loc4_++;
               }
               _loc6_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _particles.push(param1[_loc4_]);
            dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_ADDED,param1[_loc4_]));
            _loc4_++;
         }
      }
      
      public function set useInternalTick(param1:Boolean) : void
      {
         if(_useInternalTick != param1)
         {
            _useInternalTick = param1;
            if(_started)
            {
               if(_useInternalTick)
               {
                  FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,updateEventListener,false,0,true);
               }
               else
               {
                  FrameUpdater.instance.removeEventListener(UpdateEvent.UPDATE,updateEventListener);
               }
            }
         }
      }
      
      public function resume() : void
      {
         _running = true;
      }
      
      public function hasInitializer(param1:Initializer) : Boolean
      {
         return BehaviourArrayUtils.contains(_initializers,param1);
      }
      
      public function hasActivityOfType(param1:Class) : Boolean
      {
         return BehaviourArrayUtils.containsType(_activities,param1);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Particle = null;
         var _loc4_:int = 0;
         var _loc5_:Action = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(!_running)
         {
            return;
         }
         if(param1 > _maximumFrameTime)
         {
            param1 = _maximumFrameTime;
         }
         _loc4_ = int(_counter.updateEmitter(this,param1));
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            createParticle();
            _loc2_++;
         }
         sortParticles();
         _loc4_ = int(_activities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            Activity(_activities[_loc2_]).update(this,param1);
            _loc2_++;
         }
         if(_particles.length > 0)
         {
            _loc4_ = int(_actions.length);
            _loc6_ = int(_particles.length);
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
               _loc5_ = _actions[_loc7_];
               _loc2_ = 0;
               while(_loc2_ < _loc6_)
               {
                  _loc3_ = _particles[_loc2_];
                  _loc5_.update(this,_loc3_,param1);
                  _loc2_++;
               }
               _loc7_++;
            }
            _loc2_ = _loc6_;
            while(_loc2_--)
            {
               _loc3_ = _particles[_loc2_];
               if(_loc3_.isDead)
               {
                  dispatchEvent(new ParticleEvent(ParticleEvent.PARTICLE_DEAD,_loc3_));
                  _particleFactory.disposeParticle(_loc3_);
                  _particles.splice(_loc2_,1);
               }
            }
         }
         else
         {
            dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_EMPTY));
         }
         dispatchEvent(new EmitterEvent(EmitterEvent.EMITTER_UPDATED));
         if(_dispatchCounterComplete)
         {
            _dispatchCounterComplete = false;
            dispatchEvent(new EmitterEvent(EmitterEvent.COUNTER_COMPLETE));
         }
      }
      
      public function get activities() : Array
      {
         return _activities;
      }
      
      public function hasAction(param1:Action) : Boolean
      {
         return BehaviourArrayUtils.contains(_actions,param1);
      }
      
      public function start() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_useInternalTick)
         {
            FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE,updateEventListener,false,0,true);
         }
         _started = true;
         _running = true;
         _loc1_ = int(_activities.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            Activity(_activities[_loc2_]).initialize(this);
            _loc2_++;
         }
         _loc1_ = int(_counter.startEmitter(this));
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            createParticle();
            _loc2_++;
         }
      }
      
      public function pause() : void
      {
         _running = false;
      }
      
      public function set actions(param1:Array) : void
      {
         var _loc2_:Action = null;
         for each(_loc2_ in _actions)
         {
            _loc2_.removedFromEmitter(this);
         }
         _actions = param1.slice();
         BehaviourArrayUtils.sortArray(_actions);
         for each(_loc2_ in param1)
         {
            _loc2_.addedToEmitter(this);
         }
      }
      
      public function get actions() : Array
      {
         return _actions;
      }
      
      public function set counter(param1:Counter) : void
      {
         _counter = param1;
         if(running)
         {
            _counter.startEmitter(this);
         }
      }
   }
}

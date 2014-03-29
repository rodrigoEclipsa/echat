package com.controller
{
	import com.model.MainModel;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import util.classes.Agent;
	import util.classes.User;
	import util.classes.DomainWorkSpace;

	public class TimerController
	{
		
		
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		
		public var timer:Timer
		
		//public var dateStamp:Date = new Date();
		
		[PostConstruct]
		public function postContruct_timerController():void
		{
			
			
			
		}
		
		[EventHandler(event="LoginEvent.loginSuccess")]
		public function loginEvent_loginSuccess():void
		{
		
			timer = new Timer(6000);
			
			timer.addEventListener(TimerEvent.TIMER,timer_timerHandler);
			
			timer.start();
			
			
		}
		
		
		
		
		private function timer_timerHandler(event:TimerEvent):void
		{
			
			
		
			updateTimer();
			
			
			
		}
		
		
		
		public function updateTimer():void
		{
			
			//dateStamp = new Date();
			var date:Date = new Date();
		
			var timeStamp:Number = date.time;
			
			
			for each(var userItem:User in mainModel.currentDomainWorkSpace.arrayCollection_users)
			{
				
				date.time =timeStamp - userItem.createAt;
				
				userItem.secondConnect =date.seconds;
				
				
				
			}
			
			
			for each(var agentItem:Agent in mainModel.arrayCollection_agent)
			{
				date.time = timeStamp - agentItem.createAt;
				
				agentItem.secondConnect = date.seconds;
				
			}
			
			
		
		}
		
		
		
		
		
	}
}
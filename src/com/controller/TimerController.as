package com.controller
{
	import com.model.MainModel;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import util.classes.Agent;
	import util.classes.User;
	import util.classes.WorkSpaceDomain;

	public class TimerController
	{
		
		
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		
		public var timer:Timer
		
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
			
			var date:Date = new Date();
			var epochTimer:Number = date.time;
			
			
			for each(var userItem:User in mainModel.currentWorkSpaceDomain.arrayCollection_users)
			{
				
				date.time = epochTimer - userItem.createAt;
				
				userItem.secondConnect =date.seconds;
				
				
				
			}
			
			
			for each(var agentItem:Agent in mainModel.currentWorkSpaceDomain.arrayCollection_agent)
			{
				date.time = epochTimer - userItem.createAt;
				
				agentItem.secondConnect = date.seconds;
				
			}
			
			
		
		}
		
		
		
		
		
	}
}
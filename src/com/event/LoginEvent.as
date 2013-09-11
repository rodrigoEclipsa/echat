package com.event
{
	import flash.events.Event;
	
	
	
	public class LoginEvent extends Event
	{
		
		
	

		
		public static const loginSuccess:String = "LoginEvent.loginSuccess";
		public static const setRegister:String = "LoginEvent.setRegister";
		public static const loginError:String = "LoginEvent.loginError";
		
	//	public static const loginAnonymousChat:String = "LoginEvent.loginAnonymousChat";
		
		public static const loginChat:String="LoginEvent.loginChat";
		
		
		
		
		public static const logout:String="LoginEvent.logout";
		
		
		
		
		
		
		public var isAgentAvailable:Boolean = false;
		
		
		public var username:String;
		public var password:String;
		
		public function LoginEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
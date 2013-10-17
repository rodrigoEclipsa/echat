package com.event
{
	import flash.events.Event;
	
	public class AgentListEvent extends Event
	{
		public function AgentListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
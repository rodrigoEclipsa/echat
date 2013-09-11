package com.event
{
	
	
	import flash.events.Event;
	import flash.events.StatusEvent;
	
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.data.Message;
	

	import util.vo.QueueChatVO;
	
	
	public class MainEvent extends Event
	{
		
		
		
	
		
		
		
		
		public static const applicationComplete:String = "MainEvent.applicationComplete";
		
		
	
		
		public static const sendMessage:String = "MainEvent.sendMessage";
		
		public static const message:String = "MainEvent.message";
	
		
		public static const chatMessage:String = "MainEvent.stanzaMessage";
		
		//---------------------------------------------------------------------
		
		//--------------renderer
		public static const closeQueueChat:String = "MainEvent.closeQueueChat";
		

		public static const requestAttended:String = "MainEvent.requestAttended";
		
		public static const selectedChat:String = "MainEvent.selectedChat";
		
		//--------------------------
		
		
		public static const command_meet:String = "MainEvent.command_meet";
		public static const command_writing:String = "MainEvent.command_writing";
		public static const command_checkedMessage:String = "MainEvent.command_checkedMessage";
		
	
		
		
		public var message:Message;
	
		
		public var queueChatVO:QueueChatVO;
		
		
		public var to:EscapedJID;


		
		
		public function MainEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
		
	}
}
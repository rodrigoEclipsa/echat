package com.event
{
	import flash.events.Event;
	
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.Message;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.igniterealtime.xiff.events.ConnectionSuccessEvent;
	import org.igniterealtime.xiff.events.DisconnectionEvent;
	import org.igniterealtime.xiff.events.MessageEvent;
	import org.igniterealtime.xiff.events.RoomEvent;
	import org.igniterealtime.xiff.events.RosterEvent;
	import org.igniterealtime.xiff.events.XIFFErrorEvent;
	import org.igniterealtime.xiff.im.Roster;
	
	
	

	public class ChatManagerEvent extends Event
	{



		
		//events connection
		
		
		public static const connect_success:String="ChatManagerEvent.connect_success";
		public static const disconnect:String="ChatManagerEvent.disconnect";
		public static const reconnect:String="ChatManagerEvent.reconnect";
		public static const login:String="ChatManagerEvent.login";
		public static const loginAnonymous:String="ChatManagerEvent.loginAnonymous";
		public static const xiff_error:String="ChatManagerEvent.xiff_error";
		public static const message:String="ChatManagerEvent.message";
		
	//	public static const messageSystem:String="ChatManagerEvent.messageSystem";
		
	
		
		
		///eventos de comandos
		public static const command_sos:String="ChatManagerEvent.command_sos";
		public static const command_state:String="ChatManagerEvent.command_state";
		
		
		
		//roomEvent
		public static const room_userDeparture:String="ChatManagerEvent.room_userDeparture";
		public static const room_join:String="ChatManagerEvent.room_join";
		
		public static const roomUser_join:String="ChatManagerEvent.roomUser_join";
		
		//other events
		public static const addContact:String="ChatManagerEvent.addContact";
		
		
		public static const addedContact:String="ChatManagerEvent.addedContact";
		
		public static const subscriptionRequest:String="ChatManagerEvent.subscriptionRequest";
		
		public static const presenceUpdate:String="ChatManagerEvent.presenceUpdate";
		
		
		
		//----roster
		public static const rosterLoaded:String="ChatManagerEvent.rosterLoaded";

		
		
		
		//---type event
		public var xIFFErrorEvent:XIFFErrorEvent;
		public var connectionSuccessEvent:ConnectionSuccessEvent;
		public var rosterEvent:RosterEvent;
		public var roomEvent:RoomEvent;
		
		
		public var username:String;
		
		public var password:String;
		
		
		
		public var nickName:String;
		
		
		public var roster:Roster;
		
		
		public var message:Message;
		
		
		
		
		
		public var rosterItemVO:RosterItemVO;
		
		
		public var disconnectionEvent:DisconnectionEvent;
		
		
		public var comment_id:int;
		
		
		
		
		public function ChatManagerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}



	}
}
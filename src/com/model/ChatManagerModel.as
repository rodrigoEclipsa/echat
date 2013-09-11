package com.model
{
	import org.igniterealtime.xiff.conference.InviteListener;
	import org.igniterealtime.xiff.conference.Room;
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.XMPPConnection;
	import org.igniterealtime.xiff.core.XMPPTLSConnection;
	import org.igniterealtime.xiff.im.Roster;

	[Bindable]
	public class ChatManagerModel
	{
		
		
		
		public var connection:XMPPTLSConnection;
		public var inviteListener:InviteListener;
		

		
		public var room:Room;
		
		
		
		
		public var isDisconnect:Boolean = false;
		
		
		
		
		
		
		public function disconnect():void
		{
			isDisconnect = true;
			
			connection.disconnect();
		}
		
		
		
		
		
		

		
		
		
		
		
		
		
		
	}
	
	
}
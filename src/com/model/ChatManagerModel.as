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
		public var roster:Roster;

	
		
		public var isDisconnect:Boolean = false;
		
		
		
		
		
		
		
	///--------------------------------------------------mensages xml	
		
		public function xml_ex_chat_presence(name:String,email:String):XML
		{
			
			
			var xml:XML = <ex_echat_presence id="agent">
									<name>{name}</name>	
									 <email>{email}</email>
									
									  </ex_echat_presence>;
			
			
			
			return xml;
			
		}
		
		
		
		
		
	//-----------------------------------------------------------------------------------------------------------------------	
		
		
		public function disconnect():void
		{
			isDisconnect = true;
			
			connection.disconnect();
		}
		
		
		
		
		
		

		
		
		
		
		
		
		
		
	}
	
	
}
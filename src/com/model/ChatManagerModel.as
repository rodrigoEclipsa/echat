package com.model
{
	import mx.collections.ArrayCollection;
	
	import org.igniterealtime.xiff.conference.InviteListener;
	import org.igniterealtime.xiff.conference.Room;
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.core.XMPPConnection;
	import org.igniterealtime.xiff.core.XMPPTLSConnection;
	import org.igniterealtime.xiff.im.Roster;
	
	import util.classes.Contact;

	[Bindable]
	public class ChatManagerModel
	{
		
		
		
		public var connection:XMPPTLSConnection;
		public var inviteListener:InviteListener;
		public var roster:Roster;

	
		
		public var isDisconnect:Boolean = false;
		
		
		
		/**
		 * 
		 * contiene los contact de todo el roster
		 *   
		 * 
		 * */
		public var arrayCollection_contact:ArrayCollection = new ArrayCollection();
		
		
		
		
	///--------------------------------------------------mensages xml	
		
		public function getExtensionPresence(name:String,email:String):XML
		{
			
			
			var xml:XML = <echat >
				              <root>
									<name>{name}</name>	
									 <email>{email}</email>
									
			
			                        </root>
			                  </echat>
									;
			
			
			
			return xml;
			
		}
		
		
		
		
		
	//-----------------------------------------------------------------------------------------------------------------------	
		
		
		public function disconnect():void
		{
			isDisconnect = true;
			
			connection.disconnect();
		}
		
		
		
		
		
		
		
		
		
		
		public function destroy():void
		{
			connection = null;
			roster = null;
			
		}
		
		
		
		
	}
	
	
}
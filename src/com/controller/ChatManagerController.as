package com.controller
{
	import com.adobe.crypto.SHA1;
	import com.event.ChatManagerEvent;
	import com.hurlant.crypto.tls.TLSConfig;
	import com.hurlant.crypto.tls.TLSEngine;
	import com.model.ChatManagerModel;
	import com.model.MainModel;
	import com.wirelust.as3zlib.System;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.core.FlexGlobals;
	import mx.utils.ObjectUtil;
	
	import org.igniterealtime.xiff.auth.External;
	import org.igniterealtime.xiff.auth.Plain;
	import org.igniterealtime.xiff.conference.InviteListener;
	import org.igniterealtime.xiff.conference.Room;
	import org.igniterealtime.xiff.conference.RoomOccupant;
	import org.igniterealtime.xiff.core.AbstractJID;
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.core.XMPPConnection;
	import org.igniterealtime.xiff.core.XMPPTLSConnection;
	import org.igniterealtime.xiff.data.IQ;
	import org.igniterealtime.xiff.data.Message;
	import org.igniterealtime.xiff.data.Presence;
	import org.igniterealtime.xiff.data.XMPPStanza;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.igniterealtime.xiff.data.muc.MUC;
	import org.igniterealtime.xiff.data.muc.MUCStatus;
	import org.igniterealtime.xiff.events.ConnectionSuccessEvent;
	import org.igniterealtime.xiff.events.DisconnectionEvent;
	import org.igniterealtime.xiff.events.IQEvent;
	import org.igniterealtime.xiff.events.IncomingDataEvent;
	import org.igniterealtime.xiff.events.InviteEvent;
	import org.igniterealtime.xiff.events.LoginEvent;
	import org.igniterealtime.xiff.events.MessageEvent;
	import org.igniterealtime.xiff.events.OutgoingDataEvent;
	import org.igniterealtime.xiff.events.PresenceEvent;
	import org.igniterealtime.xiff.events.RegistrationFieldsEvent;
	import org.igniterealtime.xiff.events.RegistrationSuccessEvent;
	import org.igniterealtime.xiff.events.RoomEvent;
	import org.igniterealtime.xiff.events.RosterEvent;
	import org.igniterealtime.xiff.events.XIFFErrorEvent;
	import org.igniterealtime.xiff.im.Roster;
	
	import util.ArrayCollectionUtil;
	import util.DateManager;
	import util.NetUtil;
	import util.app.ConfigParameters;
	
	
	
	
	

	public class ChatManagerController
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
	
		private var timerKeepAlive:Timer;
		
	
		
		[PostConstruct]
		public function post_chatManagerController():void
		{
			
			Security.loadPolicyFile("xmlsocket://"+ConfigParameters.server+":5229");
			
		
			
			timerKeepAlive = new Timer(60000);
			
			timerKeepAlive.addEventListener(TimerEvent.TIMER,timerKeepAlive_timerHandler);
			
		
			
			
		}
		

		
	
		
		private function timerKeepAlive_timerHandler(event:TimerEvent):void
		{
			
			if(chatManagerModel.connection.loggedIn)
			chatManagerModel.connection.sendKeepAlive();
			
		
			
		}
		
		
		

		[EventHandler(event="ChatManagerEvent.login",properties="username,password")]
		public function login(username:String,password:String ):void
		{
			
			setupConnection();
			setupRoom();
			
			
			
			chatManagerModel.connection.username = username;
			chatManagerModel.connection.password = password;
			chatManagerModel.connection.server = ConfigParameters.server;
			
		
			chatManagerModel.connection.resource = "echat/agent/";
			
			chatManagerModel.connection.connect(XMPPConnection.STREAM_TYPE_STANDARD);
		
			
			
		}
	
		
		
		public function disconnect():void
		{
			
			
			chatManagerModel.connection.disconnect();
		}
		
		
		
		
		
		
		
		
		private function setupConnection():void
		{
			
			/*
			
			_connection.enableSASLMechanism( "X-FACEBOOK-PLATFORM", XFacebookPlatform );
			+			// By default only ANONYMOUS and DIGEST-MD5 enabled.
			+			_connection.enableSASLMechanism( External.MECHANISM, External );
			+			_connection.enableSASLMechanism( Plain.MECHANISM, Plain );
			+			_connection.enableSASLMechanism( XFacebookPlatform.MECHANISM, XFacebookPlatform );
			+			//_connection.enableSASLMechanism( XGoogleToken.MECHANISM, XGoogleToken );
			}
			
			*/
			
			
			chatManagerModel.connection = new XMPPTLSConnection();
			
			chatManagerModel.connection.tls =true;	
			
			var config:TLSConfig = new TLSConfig( TLSEngine.CLIENT );
			
			config.ignoreCommonNameMismatch = true;
			
			chatManagerModel.connection.config = config;
		
			chatManagerModel.connection.config.trustSelfSignedCertificates=true;
		
			chatManagerModel.connection.addEventListener( ConnectionSuccessEvent.CONNECT_SUCCESS, onConnectSuccess );
			chatManagerModel.connection.addEventListener( DisconnectionEvent.DISCONNECT, onDisconnect );
			chatManagerModel.connection.addEventListener( LoginEvent.LOGIN, onLogin );
			chatManagerModel.connection.addEventListener( XIFFErrorEvent.XIFF_ERROR, onXIFFError );
			chatManagerModel.connection.addEventListener( OutgoingDataEvent.OUTGOING_DATA, onOutgoingData )
			chatManagerModel.connection.addEventListener( IncomingDataEvent.INCOMING_DATA, onIncomingData );
		
			chatManagerModel.connection.addEventListener( PresenceEvent.PRESENCE, onPresence );
		
			
			chatManagerModel.connection.addEventListener( MessageEvent.MESSAGE, onMessage );
			
			
			
		}
		
		
		
		
		
		private function setupRoom():void
		{
			
			chatManagerModel.room = new Room(chatManagerModel.connection);
			
			chatManagerModel.room.addEventListener(RoomEvent.USER_PRESENCE_CHANGE,room_userPreseceChangeHandler);	
			
			chatManagerModel.room.addEventListener(RoomEvent.DECLINED,room_declinedHandler);	
			
			chatManagerModel.room.addEventListener(RoomEvent.USER_DEPARTURE,room_userDepartureHandler);	
			
			chatManagerModel.room.addEventListener(RoomEvent.ROOM_JOIN, room_joinHandler);
			
		//	chatManagerModel.room.addEventListener(RoomEvent.PRIVATE_MESSAGE,room_privateMessageHandler);
			
			chatManagerModel.room.addEventListener(RoomEvent.USER_JOIN,room_userJoinHandler);
				
		
			
		//	chatManagerModel.room.addEventListener(RoomEvent.,room_userJoinHandler);
			
		}
		
		
		
		private function onMessage( event:MessageEvent ):void
		{
			
			
			var message:Message = event.data as Message;
			
			
			
			
			
			if( message.type == Message.TYPE_ERROR )
			{
				var xiffErrorEvent:XIFFErrorEvent = new XIFFErrorEvent();
				xiffErrorEvent.errorCode = message.errorCode;
				xiffErrorEvent.errorCondition = message.errorCondition;
				xiffErrorEvent.errorMessage = message.errorMessage;
				xiffErrorEvent.errorType = message.errorType;
				onXIFFError( xiffErrorEvent );
				
				
			}
			else 
			{
				
				var chatManagerEvent_message:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.message,true);
				
				
				
				chatManagerEvent_message.message = message;
				
				dispatcher.dispatchEvent(chatManagerEvent_message);
				
				
			}
			
			
			
		}
		
		
		
		private function room_userDepartureHandler(event:RoomEvent):void
		{
			
			
			var chatManagerEvent:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.room_userDeparture,true);
			
			chatManagerEvent.roomEvent = event;
			
			dispatcher.dispatchEvent(chatManagerEvent);
		
		}
		
		
		
		private function room_userJoinHandler(event:RoomEvent):void
		{
			
			
			
			var chatManagerEvent:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.roomUser_join,true);
			
			chatManagerEvent.roomEvent = event;
			
			dispatcher.dispatchEvent(chatManagerEvent);
			
			
		}
		
		private function room_leaveHandler(event:RoomEvent):void
		{
			
			trace("room_leave: " + event.data);
			
		}
		
		private function room_userPreseceChangeHandler(event:RoomEvent):void
		{
			
			trace("room precence change : " + event.data);
			
			
		}
		
		
		private function room_declinedHandler(event:RoomEvent):void
		{
			
			trace("room_declined : " + event.data);
			
		}
		
		
		
		
		
		
		private function enterRoom():void
		{
			
				
			
		
		
		chatManagerModel.room.roomJID = new UnescapedJID(ConfigParameters.roomName+"@conference."+ConfigParameters.server);
		
	
		chatManagerModel.room.password = ConfigParameters.roomPassword;
	
		
		
		chatManagerModel.room.join();
		
		
		
		}
		
		
		
		
		
		private function room_joinHandler(event:RoomEvent):void
		{
			
			var chatManagerEvent:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.room_join);
			
			chatManagerEvent.roomEvent = event;
			
			dispatcher.dispatchEvent(chatManagerEvent);
	
			
		
			
		  //Room(e.target).sendMessage("entre en la sala");
		}
		
		
		
		

		private function onConnectSuccess( event:ConnectionSuccessEvent ):void
		{
			
			chatManagerModel.isDisconnect = false;
			
			timerKeepAlive.start();
	
			
		
			var chatManagerEvent_connect_success:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.connect_success,true);
			
			chatManagerEvent_connect_success.connectionSuccessEvent = event;
			
			dispatcher.dispatchEvent(chatManagerEvent_connect_success);
			
			
		}
		
		
		
		private function onDisconnect( event:DisconnectionEvent ):void
		{
			
			
			
			var chatManagerEvent_disconnect:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.disconnect,true);
			
			chatManagerEvent_disconnect.disconnectionEvent = event;
			
			dispatcher.dispatchEvent(chatManagerEvent_disconnect);
			
			
			timerKeepAlive.stop();
			
		///	Alert.show("se desconecto de openfire .......");
			
		}
		
		
		
		private function onLogin( event:LoginEvent ):void
		{
		
			var presence:Presence = new Presence(null,chatManagerModel.connection.jid.escaped,null,Presence.SHOW_CHAT);
			
			chatManagerModel.connection.send(presence);
			
			enterRoom();
			
			
	
			
		}
		
		
		private function onXIFFError( event:XIFFErrorEvent ):void
		{
			
			
		//	trace("error xiff : " + event.errorCondition + " " + event.errorCode)
			
		
			
			var chatManagerEvent_xiff_error:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.xiff_error,true);
			
			chatManagerEvent_xiff_error.xIFFErrorEvent = event;
			
			dispatcher.dispatchEvent(chatManagerEvent_xiff_error);
			
			
		}
		
		
		
		
		
		private function onOutgoingData( event:OutgoingDataEvent ):void
		{
			
		//	trace("outcomingData ...... :" +event.data.toString());
			if(timerKeepAlive.running)
			{
				timerKeepAlive.reset();
				timerKeepAlive.start();
				
			}
			
		}
		
		private function onIncomingData( event:IncomingDataEvent ):void
		{
			
		//	trace("incomingData ...... :" +  String(event.data).toString());
			
		}
		

		
		private function onPresence( event:PresenceEvent ):void
		{
			var presence:Presence = event.data[ 0 ] as Presence;
			
			if( presence.type == Presence.TYPE_ERROR )
			{
				var xiffErrorEvent:XIFFErrorEvent = new XIFFErrorEvent();
				xiffErrorEvent.errorCode = presence.errorCode;
				xiffErrorEvent.errorCondition = presence.errorCondition;
				xiffErrorEvent.errorMessage = presence.errorMessage;
				xiffErrorEvent.errorType = presence.errorType;
				onXIFFError( xiffErrorEvent );
			}
			else
			{
				
				dispatcher.dispatchEvent( event );
			}
		}
		
		
		

	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}





package com.controller
{
	import com.adobe.crypto.SHA1;
	import com.event.ChatManagerEvent;
	import com.hurlant.crypto.tls.TLSConfig;
	import com.hurlant.crypto.tls.TLSEngine;
	import com.model.ChatManagerModel;
	import com.model.LoginModel;
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
	import util.ExtensionsXiff.EchatExtension;
	import util.NetUtil;
	import util.XmlFuncUtil;
	import util.app.ConfigParameters;
	import util.classes.User;
	import util.classes.WorkSpaceDomain;
	import util.vo.entities.AgentVO;
	import util.vo.entities.UserVO;
	import util.vo.entities.WebVO;
	
	
	
	
	

	public class ChatManagerController
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
	
		private var timerKeepAlive:Timer;
		
	
		[Bindable]
		[Inject]
		public var loginModel:LoginModel;
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		namespace space = "http://www.eclipsait.com/echat";
		
		[PostConstruct]
		public function ChatManagerController_postContruct():void
		{
			
			Security.loadPolicyFile("xmlsocket://"+ConfigParameters.server+":5229");
		
			
			setupConnection();
			setupRoster();
			
			timerKeepAlive = new Timer(60000);
			
			timerKeepAlive.addEventListener(TimerEvent.TIMER,timerKeepAlive_timerHandler);
			
		}
		

		
	
		
		private function timerKeepAlive_timerHandler(event:TimerEvent):void
		{
			
			if(chatManagerModel.connection.loggedIn)
			chatManagerModel.connection.sendKeepAlive();
			
		
			
		}
		
		
		

		
		public function login(username:String,password:String ):void
		{
			
			chatManagerModel.connection.username = username;
			chatManagerModel.connection.password = password;
			chatManagerModel.connection.server = ConfigParameters.server;
			
			chatManagerModel.connection.resource = "echat/panel/";
			
			chatManagerModel.connection.connect(XMPPConnection.STREAM_TYPE_STANDARD);
		
			
			
		}
	
		
		
		public function disconnect():void
		{
			
			
			chatManagerModel.connection.disconnect();
		}
		
		
		
		
		
		
		
		
		private function setupConnection():void
		{
			
		
			
			
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
		
		
		private function setupRoster():void
		{
			
		
			chatManagerModel.roster = new Roster();
			chatManagerModel.roster.addEventListener( RosterEvent.ROSTER_LOADED, onRosterLoaded );
			chatManagerModel.roster.addEventListener( RosterEvent.SUBSCRIPTION_DENIAL, onSubscriptionDenial );
			chatManagerModel.roster.addEventListener( RosterEvent.SUBSCRIPTION_REQUEST, onSubscriptionRequest );
			chatManagerModel.roster.addEventListener( RosterEvent.SUBSCRIPTION_REVOCATION, onSubscriptionRevocation );
			chatManagerModel.roster.addEventListener( RosterEvent.USER_ADDED, onUserAdded );
			chatManagerModel.roster.addEventListener( RosterEvent.USER_AVAILABLE, onUserAvailable );
			chatManagerModel.roster.addEventListener( RosterEvent.USER_PRESENCE_UPDATED, onUserPresenceUpdated );
			chatManagerModel.roster.addEventListener( RosterEvent.USER_REMOVED, onUserRemoved );
			chatManagerModel.roster.addEventListener( RosterEvent.USER_SUBSCRIPTION_UPDATED, onUserSubscriptionUpdated );
			chatManagerModel.roster.addEventListener( RosterEvent.USER_UNAVAILABLE, onUserUnavailable );
			
			
			
			
			
		}
		
		
		
		
		private function onRosterLoaded( event:RosterEvent ):void
		{
			
		
			
			
		}
		
		private function onSubscriptionDenial( event:RosterEvent ):void
		{
			
		}
		
		private function onSubscriptionRequest( event:RosterEvent ):void
		{
			
		}
		
		private function onSubscriptionRevocation( event:RosterEvent ):void
		{
			
		}
		
		private function onUserAdded( event:RosterEvent ):void
		{
			
		trace("added....................")
		
		}
		
		private function onUserAvailable( event:RosterEvent ):void
		{
			
		    
			use namespace space;
			
			var presence:Presence = event.data as Presence;
			
			var extension:XML = XML(presence.xml.echat.ex_echat_presence);
			var workSpaceDomain:WorkSpaceDomain;
			
			
			
			
			var splitNode:Array =  presence.from.node.split("_");
			
			
			var prefix:String = splitNode[0];
			var id:int = splitNode[1];
			
			
			
		
			
		    //seguen el prefix se si es un agente o un usuario
		    if(prefix =="agent")
			{
				
				
			}
			else if(prefix == "user")
			{
			
		       workSpaceDomain = mainModel.getWorkSpacedomainById(extension.group);
			   
			  
		
			   
			   if(workSpaceDomain)
			   {
				   
				
				   
				   var userVO:UserVO = new UserVO();
				   userVO.email = extension.email;
				   userVO.name = extension.name;
				   userVO.id = id;
				   
				   var webVO:WebVO = new WebVO();
				   webVO.title = extension.web.title;
				   webVO.url = extension.web.url;
				   
				   var user:User = new User();
				   user.userVO = userVO;
				   user.arrayList_webVO.addItem(webVO);
				   
				   
				  
				   
				   workSpaceDomain.arrayCollection_users.addItem(user);
			   
			
				   
				   
			   }
			 
				
			}
				
			
		
		

		}
		
		private function onUserPresenceUpdated( event:RosterEvent ):void
		{
			
			//var precence:Presence = event.data as Presence;
		
			
		//	trace("precenseUpdated : " + precence.presence)
			
			
			
			
			
		}
		
		private function onUserRemoved( event:RosterEvent ):void
		{
			
		}
		
		private function onUserSubscriptionUpdated( event:RosterEvent ):void
		{
			
		}
		
		private function onUserUnavailable( event:RosterEvent ):void
		{
			
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
		
		
		
	
		
		
		
		
		
	

		private function onConnectSuccess( event:ConnectionSuccessEvent ):void
		{
			
			chatManagerModel.isDisconnect = false;
			
			timerKeepAlive.start();
	
			
		
			var chatManagerEvent_connect_success:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.connectSuccess,true);
			
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
		
			//una ves logueado envio mensage de presencia con una extencion y asigno la conexion a roster
			var xml:XML =chatManagerModel.xml_ex_chat_presence(loginModel.agentVO.name,loginModel.agentVO.email);
			
			
			var presence:Presence = new Presence(null,chatManagerModel.connection.jid.escaped,Presence.SHOW_CHAT,Presence.SHOW_CHAT);
			
			var echatExtension:EchatExtension = new EchatExtension();
			
			echatExtension.setDataExtension(xml);
			
		
			presence.addExtension(echatExtension);
			
			
			chatManagerModel.connection.send(presence);
			
			
			
			
			chatManagerModel.roster.connection = chatManagerModel.connection;
			
			
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
			
			trace("incomingData ...... :" +  String(event.data).toString());
			
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





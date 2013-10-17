package com.controller
{
	import com.event.ChatManagerEvent;
	import com.event.MainEvent;
	import com.model.ChatManagerModel;
	import com.model.LoginModel;
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.chatWindow.ChatWindowView;
	
	import flash.events.IEventDispatcher;
	import flash.xml.XMLDocument;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ObjectUtil;
	
	import org.igniterealtime.xiff.conference.IRoomOccupant;
	import org.igniterealtime.xiff.conference.Room;
	import org.igniterealtime.xiff.conference.RoomOccupant;
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.data.Extension;
	import org.igniterealtime.xiff.data.IExtension;
	import org.igniterealtime.xiff.data.Message;
	import org.igniterealtime.xiff.data.Presence;
	import org.igniterealtime.xiff.data.im.RosterItem;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.igniterealtime.xiff.data.muc.MUCItem;
	import org.igniterealtime.xiff.events.ConnectionSuccessEvent;
	import org.igniterealtime.xiff.events.DisconnectionEvent;
	import org.igniterealtime.xiff.events.RoomEvent;
	
	import renderer.ChatRenderer;
	
	import service.ServiceEchat;
	
	import util.ArrayCollectionUtil;
	import util.DateManager;
	import util.app.ConfigParameters;
	import util.classes.Chat;
	import util.classes.Domain;
	import util.classes.QueueChat;
	import util.classes.User;
	import util.classes.WorkSpaceDomain;
	import util.vo.ResultVO;
	import util.vo.entities.DomainVO;


	
	
	public class MainController 
	{
		
		[Bindable]
		[ViewAdded]
		public var mainView:MainView;
		
		
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		[Bindable]
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
	
		[Bindable]
	    [Inject]
		public var loginModel:LoginModel;
		
	
		
		[Bindable]
		[Inject]
		public var loginController:LoginController;
		
		[Bindable]
		[ViewAdded]
		public var chatWindowView:ChatWindowView;
		
		
		//namespace ns = "http://www.eclipsait.com/echat";
		
		[PostConstruct]
		public function postConstruct():void
		{
			
		
			//default xml namespace =ns; 
			
		}
			
		
	
		
		
		
		public function openChatWindow(user:User):void
		{
			
			//pregunto si el usuario esta en la cola de chat, si no la agrego
			if(!mainModel.isQueueChat(user))
				mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.addItem(user);
			
				
		        
			// si no esta activo lo pongo activo y lo selecciono en el tab
			if(mainModel.currentWorkSpaceDomain.currentActiveUser != user )
			{
				
				
				mainModel.currentWorkSpaceDomain.currentActiveUser = user;
				mainView.tabBar_queueChat.selectedItem = mainModel.currentWorkSpaceDomain.currentActiveUser;
				
				
				
				
					chatWindowView.isVisible = true;
				
				
			}
			
		}
		
		
		public function closeChatWindow(user:User):void
		{
			
		
		
			
			var userIndex:int = mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.getItemIndex(user);
			
			//	trace("user: " + mainModel.currentWorkSpaceDomain.currentActiveUser)
			
			if(mainModel.currentWorkSpaceDomain.currentActiveUser == user)
			{
				
				mainModel.currentWorkSpaceDomain.currentActiveUser = null;
				chatWindowView.isVisible = false;
				
				
			}
			
			
			mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.removeItemAt(userIndex);
			
		
				
			
		}
		
		
		
		
		
		[EventHandler(event="LoginEvent.loginSuccess")]
		public function loginEvent_loginSuccess():void
		{
			
		
			for each(var domainVOItem:DomainVO in loginModel.arrayList_domainsVO.source)
			{
				
				var domain:Domain = new Domain(domainVOItem);
				
				var workSpaceDomain:WorkSpaceDomain = new WorkSpaceDomain();
				
				workSpaceDomain.domain = domain;
				
				mainModel.arrayCollection_workSpacedomains.addItem(workSpaceDomain);
				
				
			}
			
			mainView.currentState="Logged";
			
			
			//selecciono el primer domino por defecto
			if(mainModel.arrayCollection_workSpacedomains.source.length)
			{
				
				
				mainModel.currentWorkSpaceDomain = mainModel.arrayCollection_workSpacedomains.getItemAt(0) as WorkSpaceDomain;
				mainView.list_domains.selectedItem = mainModel.currentWorkSpaceDomain;
				
			}
			
			
			
			
			
			
		}

		
		
	
			
		
		[EventHandler(event="ChatManagerEvent.message",properties="message")]
		public function onMessage( message:Message ):void
		{
		
		///	Alert.show("message: " + " type : " +message.type + "body : "+  message.body + "from : " + message.from.bareJID)	
	          //si el type es command es un comando enviado desde un cliente , si el id es command es un comando enviado desde el server
			
			
			/*
			if(message.type == "command" || message.id == "command" )
			{
              
				
				
				message_command(message);
				
			}
			else if(message.type == Message.TYPE_CHAT)
			{
				
				message_chat(message);
	
			}
			 */
			 
			
		   }
		  
			
		   
		
		private function message_command(message:Message):void
		{
			//Alert.show("message_command")
			var messageXML:XML = XML(message.body);
			
			switch(String(messageXML.@id))
			{
				
				
			
					
				case "writing":
					//informe de escritura
					
					break;
				
				
				case "checkedMessage" :
					
					//chequeo el mensage que llega
				
					
					break;
				
				
				
				case "responseMeet":
					
					//se envio la confirmacion de meet , entonces envio mensage de bienvenida
				
					
				
					break;
				
				
				case "attended":
					//un agente atendio al usuario
				
					
					
					break;
				
				
			}

	}
		
		
		
		
		
		
		
		
		
		
		
		
}
	
}
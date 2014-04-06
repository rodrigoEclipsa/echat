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
	import util.Interface.IContact;
	import util.app.ConfigParameters;
	import util.classes.Domain;
	import util.classes.DomainWorkSpace;

	import util.classes.QueueChat;
	import util.classes.Agent;
	import util.classes.User;
	import util.classes.functionReturn.UserDomain;
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
		
		
		[Bindable]
		[Inject]
		public var chatWindowController:ChatWindowController;
		
		//namespace ns = "http://www.eclipsait.com/echat";
		
		[PostConstruct]
		public function postConstruct():void
		{
			
		
			//default xml namespace =ns; 
			
		}
			
		
	
		
		
		
		
		
		
		
		
		[EventHandler(event="LoginEvent.loginSuccess")]
		public function loginEvent_loginSuccess():void
		{
			
		
			for each(var domainVOItem:DomainVO in loginModel.arrayList_domainsVO.source)
			{
				
				var domain:Domain = new Domain(domainVOItem);
				
				var workSpaceDomain:DomainWorkSpace = new DomainWorkSpace();
				
				workSpaceDomain.domain = domain;
				
				mainModel.arrayCollection_domainWorkSpace.addItem(workSpaceDomain);
				
				
			}
			
			mainView.currentState="Logged";
			
			
			//selecciono el primer domino por defecto
			if(mainModel.arrayCollection_domainWorkSpace.source.length)
			{
				
				
				mainModel.currentDomainWorkSpace = mainModel.arrayCollection_domainWorkSpace.getItemAt(0) as DomainWorkSpace;
				mainView.list_domains.selectedItem = mainModel.currentDomainWorkSpace;
				
			}
			
			
			
			
			
			
		}

		
		
		[EventHandler(event="ChatManagerEvent.message",properties="message")]
		public function ChatManagerEvent_messageHandler(message:Message):void
		{
			
			var splitName:Array=message.from.node.split("_");
			
			var prefix:String=splitName[0];
			var contactId:String=splitName[1];
			var domainId:String = splitName[2];

		    var iContact:IContact;
			var domainWorkSpace:DomainWorkSpace;
			
			var textHead:String;

			
			
			
			
			if(prefix == "user")
			{
				
				domainWorkSpace = mainModel.getDomaintWorkSpaceById(int(domainId));
				
				
				iContact = mainModel.getUserById(domainWorkSpace,int(contactId));
				
				
				
			}
			else if(prefix == "agent")
			{
				
				iContact = mainModel.getAgentById(int(contactId));
			
				
			}
			
			
		

				
			
			//pregunto si el usuario tiene una pestaña
			if(!mainModel.isQueueChat(iContact))
			{
				trace("se genera tab")
				mainModel.currentDomainWorkSpace.arrayCollection_queueChat.addItem(iContact);
			}
		
			
			
			
			
			chatWindowView.appendFormatTextChat(message.body,iContact,message.id,false);
				
				
			
		}
	
		
		
		
		public function sendMesage(message:Message):void
		{
			
			
			chatManagerModel.connection.send(message);
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
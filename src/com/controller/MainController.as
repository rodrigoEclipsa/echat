package com.controller
{
	import com.event.ChatManagerEvent;
	import com.event.MainEvent;
	import com.model.ChatManagerModel;
	import com.model.LoginModel;
	import com.model.MainModel;
	import com.view.chatWindow.ChatWindowView;
	import com.view.MainView;
	
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
	import util.classes.WorkSpaceDomain;
	import util.classes.QueueChat;
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
		[Inject]
		public var mainController:MainController;
		
		//namespace ns = "http://www.eclipsait.com/echat";
		
		[PostConstruct]
		public function postConstruct():void
		{
			
			
			//default xml namespace =ns; 
			
		}
			
		
		
		[EventHandler(event="LoginEvent.loginSuccess")]
		public function loginEvent_loginSuccess():void
		{
			
			
			for each(var domainVOItem:DomainVO in loginModel.domainsVO)
			{
				
				var domain:WorkSpaceDomain = new WorkSpaceDomain();
				domain.domainVO = domainVOItem;
				
				mainModel.arrayCollection_workSpacedomains.addItem(domain);
				
				
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
					writingFunc();
					
					break;
				
				
				case "checkedMessage" :
					
					//chequeo el mensage que llega
					checkedMessageFunc();
					
					break;
				
				
				
				case "responseMeet":
					
					//se envio la confirmacion de meet , entonces envio mensage de bienvenida
				
					
					responseMeetFunc();
					
					
					break;
				
				
				case "attended":
					//un agente atendio al usuario
					attended();
					
					
					break;
				
				
			}
			
			
			
			function attended():void
			{
				
				
			
				
				
			}
			
			
			function writingFunc():void
			{
				
				var queueChatVO:QueueChat = mainModel.getQueueChatVO(message.from.node);
				
				if(queueChatVO)
				{
				  
					   
					queueChatVO.isWriting = messageXML.state;
				   
				}
				
				
				
			}
			
			function responseMeetFunc():void
			{
				
			
				
				
				
				
				
			}
			
			
			
		
			
			
			
			function checkedMessageFunc():void
			{
				
				
				var queueChatVO:QueueChat = mainModel.getQueueChatVO(message.from.node);
				
				if(queueChatVO)
				{
					
				var chatVO:Chat = mainModel.getChatVO(queueChatVO,messageXML.uid);
				
				if(chatVO)
				{
				chatVO.checkedMessage = true;	
					
				}
				
				}
				
				
				
			}
			
			
			
			
		}
		
		
		//escribo y envio el mensage
		public function writeAndSendMessage(body:String, queueChatVO:QueueChat):void
		{
			
			
			
			var message:Message = new Message();
			
			///trace("message id : " + message.)
			
			message.type = Message.TYPE_CHAT;
			message.to = queueChatVO.jid;
			message.body = body;
			
			
			
			var chatVO:Chat;
			
			
			chatVO=new Chat();
			
			chatVO.body=body;
			
			chatVO.hs=DateManager.epochHSMIN();
			
			
			
			chatVO.uid=message.id;
			
			chatVO.state=ChatRenderer.state_my;
			
			
			
			queueChatVO.arrayList_historyChat.addItem(chatVO);
			
			
			
			
			
			
			mainController.sendMessage(message);
			
			
		}
	
		//escribo mensage de chat enviados
		private function message_chat(message:Message):void
		{
			
		
			var chatVO:Chat;
			
			
			
			
			var queueChatVO:QueueChat = mainModel.getQueueChatVO(message.from.node);
			
			
			
			if(queueChatVO)
			{
				
				
				chatVO = new Chat();
				
				chatVO.body = message.body;
				
				chatVO.hs = DateManager.epochHSMIN();
				
				chatVO.state = ChatRenderer.state_other;
				
				
				queueChatVO.arrayList_historyChat.addItem(chatVO);
				
				
				//activo la alarma
				if(mainModel.currentQueueChatVO != queueChatVO && !queueChatVO.showAlarm)
				{
				queueChatVO.showAlarm = true;
			
				}
				
				
			
				//envio el check
				
				command_checkedMessage(message.from,message.id);
			
				
			}
			
			
		}
		
		
		
	
		
		
		
//--------------------------------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
		
		[EventHandler(event="MainEvent.closeQueueChat",properties="queueChatVO")]
		public function closeQueueChat(queueChatVO:QueueChat):void
		{
			
			var queueChatVOIndex:int = mainModel.arrayCollection_queueChat.getItemIndex(queueChatVO);

			if(queueChatVOIndex >= 0)
			mainModel.arrayCollection_queueChat.removeItemAt(queueChatVOIndex);
			
			
			if(mainModel.currentQueueChatVO == queueChatVO)
			{
				
				mainModel.currentQueueChatVO = null;
			
				
			}
			
			command_endChat(queueChatVO.jid);
			
		}
		
		
		
		
		[EventHandler(event="ChatManagerEvent.roomUser_join",properties="roomEvent")]
		public function roomUser_join(roomEvent:RoomEvent):void
		{
		     /*
		    var presence:Presence = roomEvent.data as Presence;
		
			
			//creo queueChatVO ante la visita
			
			
			var queueChatVO:QueueChatVO = new QueueChatVO();
			
		
			queueChatVO.browser = presence.xml.ns::echat.data.browser;
			queueChatVO.city = presence.xml.ns::echat.data.city;
			queueChatVO.country = presence.xml.ns::echat.data.country;
			queueChatVO.hostName = presence.xml.ns::echat.data.hostName;
			queueChatVO.ip = presence.xml.ns::echat.data.ip;
			queueChatVO.is_popUp = presence.xml.ns::echat.data.is_popUp;
			queueChatVO.jid = presence.from;
			queueChatVO.online = true;
			queueChatVO.state = presence.xml.ns::echat.data.state;
		
			
			mainModel.arrayCollection_visitor.addItem(queueChatVO);
			
			*/
		
			
		}
		
		
	  
		
		
		[EventHandler(event="ChatManagerEvent.room_userDeparture",properties="roomEvent")]
		public function room_userDeparture(roomEvent:RoomEvent):void
		{
			///nota quitar agentes online !!!!!!!!!!!!
			trace("deperture: " + roomEvent.nickname)
			var queueChatVO:QueueChat;
		
		
		     queueChatVO = mainModel.getQueueChatVO(roomEvent.nickname);
			
			//se va un user que estaba en chat
			if(queueChatVO)
			{
				
			queueChatVO.online = false;
			queueChatVO.isWriting = 0;
			//mainModel.arrayList_queueChat.removeItemAt(queueChatVOindex);
			
			
			}
		
			
			
		}
		
		
		
		[EventHandler(event="MainEvent.requestAttended",properties="queueChatVO")]
		public  function requestAttended(queueChatVO:QueueChat):void
		{
		
			var service_echat:ServiceEchat = new ServiceEchat();
			
			service_echat.requestAttended(service_echat_requestAttended,queueChatVO.jid.node);
		
			
			
			function service_echat_requestAttended(result:Object):void
			{
				
				if(result is FaultEvent)
				{
					
					Alert.show("Se produjo un error","Error");
					mainView.removeLoad();
				}
				else
				{
					
					var resultVO:ResultVO= result as ResultVO;
						trace("requestAttended : " + ObjectUtil.toString(resultVO.data))
					if(resultVO.success)
					{
						
						
						if(resultVO.data.is_attended)
						{
							
							var queueChatVOIndex:int = mainModel.arrayCollection_queueChat.getItemIndex(queueChatVO);
							
							if(queueChatVOIndex >= 0)
							mainModel.arrayCollection_queueCall.removeItemAt(queueChatVOIndex);
							
						}
						else
						{
							
							//broadCastAttendedAgent(queueCallVO.jid.node);
							command_meet(queueChatVO.jid);
							
						}
						
						
					}
					
					
				}
			
		}
		
		
		 
		}
		
		
		
		
		
		[EventHandler(event="ChatManagerEvent.disconnect",properties="disconnectionEvent")]
		public function chatDisconnect(disconnectionEvent:DisconnectionEvent):void
		{
			//error  xiff 502 , server no disponible
			
			if(!chatManagerModel.isDisconnect)
			{
			
			
		
			
		
			}	
				
		

		}
		
		
		
		
		
		
		//------------------------------------------------------------------------------
		
		[EventHandler("MainEvent.sendMessage",properties="message")]
		public function sendMessage(message:Message):void
		{
			
		
			
			chatManagerModel.connection.send(message);
			
			
		}
		
		
	
		
		
		//---------------------------------------------------------------------command xml method
		
		
		
		
		[EventHandler(event="MainEvent.command_meet",properties="to")]
		public  function command_meet(to:EscapedJID):void
		{
			
			var xml:XML=<command id="meet">
	
					<name></name>
				
					</command>
			
			
			
			var message:Message = new Message();
			
			message.type = "command";
			message.to = to;
			message.body = xml.toXMLString();
			
			
			sendMessage(message);
			
			
		}
		
		
		
		
		public  function command_writing(to:EscapedJID,state:int):void
		{
			
			var xml:XML=<command id="writing">
  
				
  
					<state>{state}</state>
  
				</command>;
			
			var message:Message = new Message();
			
			message.type = "command";
			message.to = to;
			message.body = xml.toXMLString();
			
			
			sendMessage(message);
			
			
		}
		
		
		
		public  function command_endChat(to:EscapedJID):void
		{
			
			var xml:XML=<command id="endChat"/>;
					
			
			var message:Message = new Message();
			
			message.type = "command";
			message.to = to;
			message.body = xml.toXMLString();
			
			
			sendMessage(message);
			
			
		}
		
		
		public  function command_checkedMessage(to:EscapedJID,uid:String):void
		{
			
			
			var xml:XML=<command id="checkedMessage">
	
					 <uid>{uid}</uid>
				
			  </command>;
			
			
			var message:Message = new Message();
			
			message.type = "command";
			message.to = to;
			message.body = xml.toXMLString();
			
			
			sendMessage(message);
			
			
		}
		
		
		public  function command_attended(to:EscapedJID,userAttended:String):void
		{
			
			
			var xml:XML=<command id="attended">
								<user>{userAttended}</user>
								 </command>;
			
			
		
			
			var message:Message = new Message();
			
			message.type = "command";
			message.to = to;
			message.body = xml.toXMLString();
			
		
			
			sendMessage(message);
			
			
		}
		
	  

		
		
		
		
	}
}
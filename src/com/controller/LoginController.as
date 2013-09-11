package com.controller
{
	import com.event.ChatManagerEvent;
	import com.event.LoginEvent;
	import com.model.ChatManagerModel;
	import com.model.LoginModel;
	import com.model.MainModel;
	import com.view.MainView;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.utils.ObjectUtil;
	
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.events.RoomEvent;
	import org.igniterealtime.xiff.events.XIFFErrorEvent;
	
	import service.ErrorServiceEvent;
	import service.Service_echat;
	
	import util.app.ConfigParameters;
	import util.vo.ResultVO;
	
	public class LoginController
	{
		
		
		[Bindable]
		[ViewAdded]
		public var mainView:MainView;
		
		
		[Bindable]
		[Inject]
		public var loginModel:LoginModel;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		
		[Bindable]
		[Inject]
		public var chatManagerModel:ChatManagerModel;;
		
		
		public function LoginController()
		{
		}
		
		
		
		
		[EventHandler(event="LoginEvent.loginChat",properties="username,password")]
		public function login(username:String,password:String):void
		{
			
			
			mainView.showLoad();
	
	     loginModel.username = username;
		 loginModel.password =password;
			
		var service_echat:Service_echat = new Service_echat();
		
		service_echat.login(service_chat_loginHandler,username,password);
			
			
			
		function service_chat_loginHandler(result:Object):void
		{
			
			
			if(result is ErrorServiceEvent)
			{
				
				//Alert.show("Se produjo un error","Error");
				mainView.removeLoad();
			}
			else
			{
				
				var resultVO:ResultVO= result as ResultVO;
				//	trace(ObjectUtil.toString(resultVO.data))
				if(resultVO.success)
				{
					
					
					if(resultVO.data)
					{
						
						
						ConfigParameters.roomName =resultVO.data.conference.id;
						
						ConfigParameters.agent_name = resultVO.data.agent.agent_name;
						
						
						var chatManagerEvent:ChatManagerEvent = new ChatManagerEvent(ChatManagerEvent.login,true);
						
						chatManagerEvent.username = resultVO.data.agent.id;
						chatManagerEvent.password = loginModel.password;
						
						
						
						dispatcher.dispatchEvent(chatManagerEvent);
						
					}
					else
					{
						Alert.show("Usuario o Contraseña incorrecto","Atencion");
						mainView.removeLoad();
					}
					
					
				}
				
				
			}
			
			
			
		}
			
			
		}
		
		
		
		
		
		
		[EventHandler(event="ChatManagerEvent.room_join",properties="roomEvent")]
		public function loginSuccess(roomEvent:RoomEvent):void
		{
			
			//	trace("jid : " + chatManagerModel.connection)
			trace("jin room")
			
			
			mainView.removeLoad();
			
		
			loginModel.currentUserJID = new EscapedJID(loginModel.username+"@"+ConfigParameters.server);
			
			var loginEvent:LoginEvent = new LoginEvent(LoginEvent.loginSuccess,true);
			
		
			
			dispatcher.dispatchEvent(loginEvent);
			
		
			
		}
		
		
		
		[EventHandler(event="ChatManagerEvent.xiff_error",properties="xIFFErrorEvent")]
		public function loginError (xIFFErrorEvent:XIFFErrorEvent):void
		{
		
			
			trace("error xiff : " +xIFFErrorEvent.errorCode)
			
			if(xIFFErrorEvent.errorCode == 401)
			{
				
				mainView.removeLoad();
				
				Alert.show("Contactese con eclipsait.com","Error");
				
			}
			
		
			
		}
		
		[EventHandler(event="LoginEvent.logout")]
		public function logout():void
		{
			
			if(chatManagerModel.connection)
			{
				
				chatManagerModel.disconnect();
				
				mainView.currentState = "Login";
			}
		}
		
		
	}
}
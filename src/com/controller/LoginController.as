package com.controller
{
	
	import com.event.LoginEvent;
	import com.model.ChatManagerModel;
	import com.model.LoginModel;
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.login.LoginView;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.rpc.Fault;
	
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.events.RosterEvent;
	import org.igniterealtime.xiff.events.XIFFErrorEvent;
	
	import service.ServiceEchat;
	
	import util.vo.ResultVO;
	import util.vo.entities.AgentVO;
	import util.vo.entities.DomainVO;
	
	public class LoginController
	{
		
		
		[Bindable]
		[ViewAdded]
		public var mainView:MainView;
		
		
		[Bindable]
		[ViewAdded]
		public var loginView:LoginView;
		
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
		
		[Bindable]
		[Inject]
		public var chatManagerController:ChatManagerController;
		
		
		public function LoginController()
		{
		}
		
		
		
		
	
		public function login(email:String,password:String):void
		{
			
		
			loginView.showLoad();
	
			
		chatManagerController.login(email,password); 
						
						
						
				
			
			
		}
		
		
		
		
		
		
		
		[EventHandler("ChatManagerEvent.rosterLoaded",properties="rosterEvent")]
		public function chatManagerEvent_connectSuccess(rosterEvent:RosterEvent):void
		{
			
			loginView.removeLoad();
			
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
				
				Alert.show("No se pudo conectar con el servidor de chat","Error");
				
			}
			
			loginView.removeLoad();
			
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


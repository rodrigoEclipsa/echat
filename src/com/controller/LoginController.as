package com.controller
{
	import com.adobe.crypto.SHA1;
	import com.event.ChatManagerEvent;
	import com.event.ErrorServiceEvent;
	import com.event.LoginEvent;
	import com.model.ChatManagerModel;
	import com.model.LoginModel;
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.login.LoginView;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.utils.ObjectUtil;
	
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.events.ConnectionSuccessEvent;
	import org.igniterealtime.xiff.events.RoomEvent;
	import org.igniterealtime.xiff.events.XIFFErrorEvent;
	
	import service.ServiceEchat;
	
	import util.app.ConfigParameters;
	import util.vo.ResultVO;
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
	
	   
			
		var service_echat:ServiceEchat = new ServiceEchat();
		
		service_echat.login(service_chat_loginHandler,email,SHA1.hash(password));
			
			
			
		function service_chat_loginHandler(result:Object):void
		{
			
				
			
			
			
			if(result is ErrorServiceEvent)
			{
				
				Alert.show("Se produjo un error","Error");
			
				loginView.removeLoad();
			}
			else
			{
				
				var resultVO:ResultVO= result as ResultVO;
				
				if(resultVO.success)
				{
					
					//si tiene acceso existe la propiedad access
					if(resultVO.data.hasOwnProperty("access"))
					{
						
				//		trace("loggued : " + ObjectUtil.toString(resultVO.data))
			
						loginModel.agentVO = resultVO.data.agentVO;
						
						
						
						for each(var domainVO:DomainVO in resultVO.data.domainsVO)
						loginModel.arrayList_domainsVO.addItem(domainVO);
					
						
						loginModel.rolesVO = resultVO.data.rolesVO;
						
						
						
						
						chatManagerController.login("agent_"+resultVO.data.agentVO.id,SHA1.hash(password)); 
						
						
						
					}
					else
					{
						loginView.removeLoad();
						Alert.show("Usuario o Contraseña incorrecto","Atencion");
						
					}
					
					
				}
				else
				{
					Alert.show("ups algo salio mal, contactese con eclipsa ","Atencion");
					loginView.removeLoad();
					
				}
				
				
			}
			
			
		
			
			
		}
			
			
		}
		
		
		
		[EventHandler("ChatManagerEvent.connectSuccess",properties="connectionSuccessEvent")]
		public function chatManagerEvent_connectSuccess(connectionSuccessEvent:ConnectionSuccessEvent):void
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
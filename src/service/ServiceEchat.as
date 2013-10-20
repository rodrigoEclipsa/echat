package service
{
	
	
	
	
	import com.event.ErrorServiceEvent;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.controls.Alert;
	import mx.messaging.events.MessageFaultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	import mx.utils.ObjectUtil;
	
	import util.app.ConfigParameters;
	



	
	
	public class ServiceEchat 
	{
		
		public var gatewayUrl:String= "http://" + ConfigParameters.server + "/amfphp_echat/index.php/amf/gateway/";
		public var remoteObj:RemoteObject;
		public var _func:Function;
		
		private var interval:uint;
		
		public function ServiceEchat()
		{
			
			remoteObj = new RemoteObject("service_echat");
			
			remoteObj.endpoint = gatewayUrl;
			
			remoteObj.source = "service_echat";
			
			remoteObj.addEventListener(ResultEvent.RESULT,getResult);
			remoteObj.addEventListener(FaultEvent.FAULT,onFault);
			
			interval = setInterval(timeOut,60000);
			
		}
		
		
		private function timeOut():void
		{
			
			var errorServiceEvent:ErrorServiceEvent = new ErrorServiceEvent(ErrorServiceEvent.timeOut);
			
			_func(errorServiceEvent);
			
			disconnect();
			destroy();
			
		}
	
		
		public function disconnect():void
		{
			
			remoteObj.disconnect();	
			destroy();
		}
		
		private function getResult(event:ResultEvent):void
		{
			
			
				_func(event.result);
		
				destroy();
		}
		
		
		
		private function onFault(event:FaultEvent):void
		{
			
			
			trace("ERROR: " + event.fault);
			
			
			//Alert.show(event.fault.faultString);
			
			var errorServiceEvent:ErrorServiceEvent = new ErrorServiceEvent(ErrorServiceEvent.timeOut);
			
			errorServiceEvent.message = event.message.body.toString();
            _func(errorServiceEvent);
			
			destroy();
			
		}
		
		
		
	    private function destroy():void
		{
			clearInterval(interval);
			remoteObj=null;
			_func = null;
			
			
			
			
		}
		
		
		
		////-----------------------------------------------------------------------------------funciones del servicio
		
		
		
		
		
		
		public function login(func:Function,email:String,password:String):void
		{
			
			_func=func;
			
			remoteObj.login(email,password);
			
		}
		
		
		public function requestAttended(func:Function,user:String):void
		{
			
			_func=func;
			remoteObj.requestAttended(user);
			
		}
		
		
		public function getUserId(func:Function,user_id:int):void
		{
			
			_func=func;
			
			remoteObj.getUserId(user_id);
			
		}
		
		
	
		public function getAgents(func:Function,ids:String):void
		{
			
			
			_func=func;
			
			remoteObj.getAgents(ids);
			
		}
		
		
		
	}
		
}
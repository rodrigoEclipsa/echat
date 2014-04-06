package service
{
	
	
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
		
		public var gatewayUrl:String= "http://" + ConfigParameters.server + "/space_eclipsa/server/amfphp_echat/index.php/amf/gateway/";
		public var remoteObj:RemoteObject;
		public var _func:Function;
		
		
		
		public function ServiceEchat()
		{
			
			remoteObj = new RemoteObject("service_echat");
			
			remoteObj.endpoint = gatewayUrl;
			
			remoteObj.source = "service_echat";
			
			remoteObj.showBusyCursor = true;
			remoteObj.requestTimeout = 40;
			
			remoteObj.addEventListener(ResultEvent.RESULT,getResult);
			remoteObj.addEventListener(FaultEvent.FAULT,onFault);
			
			
			
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
			
			

            _func(event.fault);
			
			destroy();
			
		}
		
		
		private function destroy():void
		{
			
			remoteObj=null;
			_func = null;
			
			
		}
		
		
		////-----------------------------------------------------------------------------------funciones del servicio
		
		
		public function test(func:Function):void
		{
			
			_func=func;
			
			remoteObj.test();
			
		}
		
		
		
		
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
		
		
		public function getAgentId(func:Function,agent_id:int):void
		{
			
			_func=func;
			
			remoteObj.getAgentId(agent_id);
			
		}
		
		
	
		public function getAgentsByIds(func:Function,ids:Array):void
		{
			
			
			_func=func;
			
			remoteObj.getAgentsByIds(ids);
			
		}
		
		
		
	}
		
}
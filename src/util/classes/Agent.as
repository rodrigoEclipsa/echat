package util.classes
{
	
	
	
	
	import Interface.Icontact;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.TextFlow;
	
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.swizframework.core.IDisposable;
	
	import util.vo.entities.AgentVO;
	import util.vo.entities.RoleVO;
	
	[Bindable]
	public class Agent implements IDisposable,Icontact
	{
		
		
		public var roleVO:RoleVO;
		public var agentVO:AgentVO;
	
		
		///---------IContact
		
		private var _historyText:TextFlow;
		private var _contact:Contact;
		
		private var _lastAppendText:Boolean = false;
		//------------
		
		
		
		
		
		public var secondConnect:Number = 0;
	
		public var createAt:Number = new Date().time;
		
		
		public function Agent(agentVO:AgentVO)
		{
			
	
		this.agentVO = agentVO;	
			
		
		
		}
		
		
		
		
		/**
		 * si es true el usuario fue el ultimo que escribio, si es false fue el agente
		 * **/
		public function get lastAppendText():Boolean
		{
			return _lastAppendText;
		}
		
	
		public function set lastAppendText(value:Boolean):void
		{
			_lastAppendText = value;
		}

		
		public function get historyText():TextFlow
		{
			if(!_historyText)
				_historyText = new TextFlow();
			
			return _historyText;
		}
		
		public function set historyText(value:TextFlow):void
		{
			_historyText = value;
		}

		
		public function get contact():Contact
		{
			return _contact;
		}

		public function set contact(value:Contact):void
		{
			_contact = value;
		}

		public function destroy():void
		{
			contact = null;
			
			
		}
		
		
	}
}
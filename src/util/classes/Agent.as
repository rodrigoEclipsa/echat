package util.classes
{
	
	
	
	
	import Interface.Icontact;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
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
		
		private var _historyText:String = "";
		private var _contact:Contact;
		//------------
		
		
		
		
		
		public var minuteConnect:Number = 0;
	
		public var createAt:Number = new Date().time;
		
		
		public function Agent(agentVO:AgentVO)
		{
			
	
		this.agentVO = agentVO;	
			
		
		
		}
		
		
		
		public function get historyText():String
		{
			return _historyText;
		}
		
		public function set historyText(value:String):void
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
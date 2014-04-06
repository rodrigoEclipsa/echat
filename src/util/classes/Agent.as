package util.classes
{




	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	
	import mx.collections.ArrayCollection;
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.swizframework.core.IDisposable;
	
	import util.Interface.IContact;
	import util.vo.entities.AgentVO;
	import util.vo.entities.RoleVO;

	[Bindable]
	public class Agent extends ContactBase implements IDisposable,IContact
	{


		public var roleVO:RoleVO;
		public var agentVO:AgentVO;
        
		private var _domainsIds:Array = new Array();

		
	
		public var secondConnect:Number=0;

		public function getNickChat():String
		{
			
			return agentVO.nick;
			
		}


		public function Agent(agentVO:AgentVO)
		{


			this.agentVO=agentVO;

		}

		

		public function get domainsIds():Array
		{
			return _domainsIds;
		}

		public function set domainsIds(value:Array):void
		{
			_domainsIds = value;
		}

	

		
		public function getContactId():int
		{

		
			return agentVO.id;

		}

		public function getContactName():String
		{

			return agentVO.name;

		}



	



		
	

		public function destroy():void
		{


		


		}


	}
}
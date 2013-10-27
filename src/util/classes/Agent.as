package util.classes
{




	import Interface.IContact;
	
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.swizframework.core.IDisposable;
	
	import util.vo.entities.AgentVO;
	import util.vo.entities.RoleVO;

	[Bindable]
	public class Agent implements IDisposable, IContact
	{


		public var roleVO:RoleVO;
		public var agentVO:AgentVO;


		///---------IContact
		private var _historyText:TextFlow;
		private var _contact:Contact;

		private var _lastChatJid:UnescapedJID;

		private var _lastChatTimeStamp:Number;
		//------------





		public var secondConnect:Number=0;

		public var createAt:Number=new Date().time;


		public function Agent(agentVO:AgentVO)
		{


			this.agentVO=agentVO;



		}




		public function get lastChatJid():UnescapedJID
		{
			return _lastChatJid;
		}


		public function set lastChatJid(value:UnescapedJID):void
		{
			_lastChatJid=value;
		}

		public function getContactId():int
		{

			return agentVO.id;

		}

		public function getContactName():String
		{

			return agentVO.name;

		}



		public function get lastChatTimeStamp():Number
		{
			return _lastChatTimeStamp;
		}

		public function set lastChatTimeStamp(value:Number):void
		{
			_lastChatTimeStamp=value;
		}




		public function get historyText():TextFlow
		{

			if(!_historyText)
			{
				
				
				_historyText = new TextFlow();
				
				var p:ParagraphElement = new ParagraphElement();
				_historyText.addChild(p);
				
				
			}
			
			
			return _historyText;
			
		}

		public function set historyText(value:TextFlow):void
		{
			_historyText=value;
		}


		public function get contact():Contact
		{
			return _contact;
		}

		public function set contact(value:Contact):void
		{
			_contact=value;
		}

		public function destroy():void
		{


			_contact=null;


		}


	}
}
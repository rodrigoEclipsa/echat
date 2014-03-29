package util.classes
{




	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.TextFlow;
	
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
	import org.swizframework.core.IDisposable;
	
	import util.Interface.IContact;
	import util.vo.entities.AgentVO;
	import util.vo.entities.RoleVO;

	[Bindable]
	public class Agent implements IDisposable, IContact
	{


		public var roleVO:RoleVO;
		public var agentVO:AgentVO;
        
		private var _domainsIds:Array = new Array();

		///---------IContact
		private var _historyText:TextFlow;
	

		private var _lastChatJid:UnescapedJID;

		private var _lastChatTimeStamp:Number;
		
		private var _createAt:Number=new Date().time;
		
		
		
		private var _online:Boolean =false;
		private var _show:String;
		private var _jid:UnescapedJID;
		
		
		//------------





		public var secondConnect:Number=0;

		


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

		public function get jid():UnescapedJID
		{
			return _jid;
		}

		public function set jid(value:UnescapedJID):void
		{
			_jid = value;
		}

		public function get show():String
		{
			return _show;
		}

		public function set show(value:String):void
		{
			_show = value;
		}

		public function get online():Boolean
		{
			return _online;
		}

		public function set online(value:Boolean):void
		{
			_online = value;
		}

		public function get createAt():Number
		{
			return _createAt;
		}

		public function set createAt(value:Number):void
		{
			_createAt = value;
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


	

		public function destroy():void
		{


		


		}


	}
}
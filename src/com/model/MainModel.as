package com.model
{
	
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.utils.ObjectProxy;
	import mx.utils.UIDUtil;
	
	import org.igniterealtime.xiff.conference.Room;
	import org.igniterealtime.xiff.conference.RoomOccupant;
	import org.igniterealtime.xiff.core.EscapedJID;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.Message;
	
	import util.app.ConfigParameters;
	import util.vo.ChatVO;
	import util.vo.QueueChatVO;

	
	
	
	[Bindable]
	public class MainModel
	{
	
		
		
			
		
		[Inject]
		public var chatManagerModel:ChatManagerModel;
		
		
		
		public var arrayCollection_domains:ArrayCollection = new ArrayCollection();
		
		
		
		
		
		
		/*
		type queuechatvo
		
		cola de chat 
		
		se produce cuando atendio a un usuario en llamada
		*/
		public var arrayCollection_queueChat:ArrayCollection = new ArrayCollection();
		
		/*
		
		type queuechatvo
		
		cola de llamadas 
		
		se produce cuando un usuario envia mensajes de chat
		
		*/
		public var arrayCollection_queueCall:ArrayCollection = new ArrayCollection();
		

		
		/*
		
		type queuechatvo
		
		lista de visitas en la web
		
		se produce cuando un usuario visita la web
		
		*/
		public var arrayCollection_visitor:ArrayCollection = new ArrayCollection();
		
		
		
		
		public var currentQueueChatVO:QueueChatVO;
		
		
		public var arrayList_agent:ArrayList = new ArrayList();
		
		
		
		
		public function clearData():void
		{
			
			arrayCollection_queueChat.removeAll();
			arrayCollection_queueCall.removeAll();
			arrayList_agent.removeAll();
			currentQueueChatVO = null;
			
		}
		
		
		public function getChatVO(queueChatVO:QueueChatVO,uid:String):ChatVO
		{
			
			var chatVO:ChatVO;
			
			var len:uint = queueChatVO.arrayList_historyChat.source.length-1;
			
			
			for(var i:int =len ; i>=0;i--)
			{
				
				var item:ChatVO = queueChatVO.arrayList_historyChat.source[i] as ChatVO;
				
				if(item.uid ==  uid)
				{
					chatVO = item;
					break;
					
				}
				
			}
			
			
			return chatVO;
			
		}
		
		
	
		
		
		public function getQueueChatVO(node:String):QueueChatVO
	    {
			
			
			var queueChatVO:QueueChatVO;
			
			for each(var queueChatVOItem:QueueChatVO in arrayCollection_queueChat)
			{
				
				if(node == queueChatVOItem.jid.node )
				{
					queueChatVO = queueChatVOItem;
					break;
					
				}
				
			}
			
			
			return queueChatVO;
			
		}
		
		
	  
	
	 
	
		
		
		
	}
}
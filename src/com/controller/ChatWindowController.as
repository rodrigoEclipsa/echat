package com.controller
{
	
	
	
	import util.Interface.IContact;
	
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.chatWindow.ChatWindowView;
	
	import util.classes.User;
	
	public class ChatWindowController
	{
		
		[Bindable]
		[Inject]
		public var mainModel:MainModel;
		
		[Bindable]
		[ViewAdded]
		public var mainView:MainView;
		
		
		[Bindable]
		[ViewAdded]
		public var chatWindowView:ChatWindowView;

		
		public function ChatWindowController()
		{
		}
		
		
		
		public function openChatWindow(iContact:IContact):void
		{
			
			
			
			//pregunto si el usuario esta en la cola de chat, si no la agrego
			if(!mainModel.isQueueChat(iContact))
				mainModel.currentDomainWorkSpace.arrayCollection_queueChat.addItem(iContact);
			
			
			
			// si no esta activo lo pongo activo y lo selecciono en el tab
			if(mainModel.currentDomainWorkSpace.currentActiveContact != iContact )
			{
				
				
				mainModel.currentDomainWorkSpace.currentActiveContact = iContact;
				mainView.tabBar_queueChat.selectedItem = mainModel.currentDomainWorkSpace.currentActiveContact;
				
				
			
				
				mainView.group_chatWindow.visible = true;
				
				
			}
			
			chatWindowView.dataChange();
			
			
			
		}
		
		
		public function closeChatWindow(contact:IContact):void
		{
			
			
			
			
			var userIndex:int = mainModel.currentDomainWorkSpace.arrayCollection_queueChat.getItemIndex(contact);
			
			//	trace("user: " + mainModel.currentWorkSpaceDomain.currentActiveUser)
			
			if(mainModel.currentDomainWorkSpace.currentActiveContact == contact)
			{
			
				mainModel.currentDomainWorkSpace.currentActiveContact = null;
				mainView.group_chatWindow.visible = false;
				
				
			}
			
			
			mainModel.currentDomainWorkSpace.arrayCollection_queueChat.removeItemAt(userIndex);
			
			
			
			
		}
		
		
		
		public function minimizeChatWindow():void
		{
				
			mainView.tabBar_queueChat.selectedIndex = -1;
			mainModel.currentDomainWorkSpace.currentActiveContact = null;
			
			mainView.group_chatWindow.visible = false;
			
		}
		
		
		
		
	
		
		
		
		
		
	}
}
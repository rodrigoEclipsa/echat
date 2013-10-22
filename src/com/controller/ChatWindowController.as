package com.controller
{
	
	
	
	import Interface.Icontact;
	
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
		
		
		
		public function openChatWindow(contact:Icontact):void
		{
			
			
			
			//pregunto si el usuario esta en la cola de chat, si no la agrego
			if(!mainModel.isQueueChat(contact))
				mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.addItem(contact);
			
			
			
			// si no esta activo lo pongo activo y lo selecciono en el tab
			if(mainModel.currentWorkSpaceDomain.currentActiveContact != contact )
			{
				
				
				mainModel.currentWorkSpaceDomain.currentActiveContact = contact;
				mainView.tabBar_queueChat.selectedItem = mainModel.currentWorkSpaceDomain.currentActiveContact;
				
				
			
				
				
				mainView.group_chatWindow.visible = true;
				
				
				
				
			}
			
			chatWindowView.dataChange();
			
			
			
		}
		
		
		public function closeChatWindow(contact:Icontact):void
		{
			
			
			
			
			var userIndex:int = mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.getItemIndex(contact);
			
			//	trace("user: " + mainModel.currentWorkSpaceDomain.currentActiveUser)
			
			if(mainModel.currentWorkSpaceDomain.currentActiveContact == contact)
			{
			
				mainModel.currentWorkSpaceDomain.currentActiveContact = null;
				mainView.group_chatWindow.visible = false;
				
				
			}
			
			
			mainModel.currentWorkSpaceDomain.arrayCollection_queueChat.removeItemAt(userIndex);
			
			
			
			
		}
		
		
		
		public function minimizeChatWindow():void
		{
				
			mainView.tabBar_queueChat.selectedIndex = -1;
			mainModel.currentWorkSpaceDomain.currentActiveContact = null;
			
			mainView.group_chatWindow.visible = false;
			
		}
		
		
		
		
	
		
		
		
		
		
	}
}
package com.controller
{
	import com.model.MainModel;
	import com.view.MainView;
	import com.view.chatWindow.ChatWindowView;
	
	import util.classes.User;

	public class VisitListController
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
	
		public function VisitListController()
		{
		}
		
		
		
	
		
		
		
		
		
		
	}
}
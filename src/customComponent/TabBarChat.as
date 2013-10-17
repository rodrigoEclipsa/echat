package customComponent
{
	import spark.components.TabBar;
	
	
	[Event(name="close", type="com.event.customComponent.TabBarChatEvent")]
	
	public class TabBarChat extends TabBar
	{
		public function TabBarChat()
		{
			super();
		}
	}
}
package Assets
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	


	[Bindable]
	public class EmbeddedAssets 
	{
		
		
		private static  var embeddedAssets:EmbeddedAssets;
		
		public static function getInstance():EmbeddedAssets
		{
			
			if(!embeddedAssets)
				embeddedAssets = new EmbeddedAssets();
				
			
			return embeddedAssets;
		}
		
		
		
		
		[Embed(source='Assets/arrow_agent.png')]
		public  var arrow_agent:Class;
		
		
		[Embed(source='Assets/arrow_user.png')]
		public  var arrow_user:Class;
		
		
		
		
		[Embed(source='Assets/check.png')]
		public  var checkIcon:Class;
		
		
		[Embed(source='Assets/reloj.png')]
		public  var relojIcon:Class;
		
		
		
		
		[Embed(source='Assets/logoeclipsa.jpg')]
		public  var logoEclipsa:Class;
		
		
		
		//-------------------------------------------------------- icon app
		
		
		[Embed(source='Assets/iconApp/icon_032.png')]
		public  var trayIcon:Class;
		
		
		
		
		//---------------------------------------------------------------------
		
		
		
		//[Embed(source='Assets/disconnectIcon/disconnect.png')]
	//public  var trayIcon:Class;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}
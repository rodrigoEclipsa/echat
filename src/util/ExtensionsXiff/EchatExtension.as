package util.ExtensionsXiff
{
	import flash.xml.XMLDocument;
	
	import mx.rpc.xml.SimpleXMLDecoder;
	
	import org.igniterealtime.xiff.data.Extension;
	import org.igniterealtime.xiff.data.ExtensionClassRegistry;
	import org.igniterealtime.xiff.data.IExtension;

	public class EchatExtension extends Extension implements IExtension
	{
	
		
		
		public var name:String = "prueva exten";
		
		
		public function EchatExtension()
		{
			
		
			//super(<echat/>);
		//this.xml.echat = <echat>dsda</echat>
			//this.setField("a","value");
			//this.setAttribute("a","value");
		}
		
		
		
		
	   public function setDataExtension(xml:XML):void
	   {
		   
		   
		   this.xml.echat = xml;
		   
	   }
		
		
	
		public function getElementName():String
		{
			// TODO Auto Generated method stub
			return "echat";
		}
		
		public function getNS():String
		{
			// TODO Auto Generated method stub
			return "custom:iq:example";
		}
		
		
		public static function enable():void
		{
			
			ExtensionClassRegistry.register(EchatExtension);
		
		
		}
		
		
		
	
		
		
		
		
		
	}
}
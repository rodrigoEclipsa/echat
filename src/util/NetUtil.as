package util
{
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;

	public class NetUtil
	{
		
		
		public static function getMacID():String
		{
			var MacAddress:String;
			var ni:NetworkInfo = NetworkInfo.networkInfo;
			var interfaceVector:Vector.<NetworkInterface> = ni.findInterfaces();
			for each (var item:NetworkInterface in interfaceVector)
			{
				var child:NetworkInterface = item as NetworkInterface;
				MacAddress = child.hardwareAddress;
				break;
			}
			return MacAddress;
		}
		
		
	}
}
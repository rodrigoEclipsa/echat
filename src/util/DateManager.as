package util
{
	import spark.formatters.DateTimeFormatter;

	public class DateManager
	{
		/*
		public static function formatDate(date:Date):String
		{
			
			var result:String;
			var day:String;
			var month:String;
			var year:String = date.fullYear.toString();
			var hs:String = date.hours.toString();
			var min:String = date.minutes.toString();
			
			switch(date.day)
			{
				
				case 0:
					day ="Domingo";
					break;
				
				case 1:
					day ="Lunes";
					break;
				
				
				case 2:
					day ="Martes";
					break;
				
				
				case 3:
					day ="Miercoles";
					break;
				
				
				case 4:
					day ="Jueves";
					break;
				
				
				case 5:
					day ="Viernes";
					break;
				
				
				case 6:
					day ="Sabado";
					break;
				
				
			}
			
			
			
			
			switch(date.month)
			{
				
				
				case 0:
					
					month = "Enero";
					break;
				
				case 1:
					
					month = "Febrero";
					break;
				
				case 2:
					
					month = "Marzo";
					break;
				
				case 3:
					
					month = "Abril";
					break;
				
				case 4:
					
					month = "Mayo";
					break;
				
				case 5:
					
					month = "Junio";
					break;
				
				case 6:
					
					month = "Julio";
					break;
				
				case 7:
					
					month = "Agosto";
					break;
				
				case 8:
					
					month = "Septiembre";
					break;
				
				case 9:
					
					month = "Octubre";
					break;
				
				case 10:
					
					month = "Noviembre";
					break;
				
				case 11:
					
					month = "Diciembre";
					break;
				
				
				
			}
			
			
			
			
			if(int(hs) < 10)
			{
				var fhs:String = "0";
				
				fhs += hs;
				
				hs = fhs;
				
			}
			
			if(int(min) < 10)
			{
				
				var fmin:String = "0";
				
				fmin += min;
				
				min = fmin;
				
			}
			
			
			result = day+" "+ date.date+" de "+ month+ " de "+ year+ " " +hs+":"+min+" HS  ";
			
			return result;
			
			
			
			
			
			
			
			
		}
		
		
		*/
		
		
		public static function formatDate(format:String = "HH:mm"):String
		{
			
			var date:Date = new Date();
			
			var formatter:DateTimeFormatter = new DateTimeFormatter();
			
			
			formatter.dateTimePattern = format;
			
			
			var strHs:String = formatter.format(date);
			
			return strHs;
			
			
		}
		
		public static function unixTimeStampToHS(timeStamp:Number):String
		{
			
			var date:Date = new Date(timeStamp*1000);
			
			var formatter:DateTimeFormatter = new DateTimeFormatter();
			
			
			formatter.dateTimePattern = "HH:mm";
			
			
			
			
			
			var strHs:String = formatter.format(date);
			
			return strHs;
			
			
		}
		
		
		public static function getUnixTimeStamp():Number
		{
			
			return Math.round(new Date().time/1000);
			
			
			
			
		}
		
		public static function getTimeStamp():Number
		{
			
			var date:Date = new Date();
			
			return date.time;
			
			
			
			
		}
		
		
		
	}
}
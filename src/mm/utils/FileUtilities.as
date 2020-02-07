package mm.utils 
{
	import flash.filesystem.*;
	import flash.net.*;
	import flash.utils.*;
	
	public class FileUtilities 
	{
		public static function getFileName(file:File):String
		{
			if (!file) return "";
			var fileName:String = file.nativePath;
			if (fileName.indexOf("\\") != -1) return fileName.split("\\").pop();
			else return fileName;
		}
		
		public static function getTimeStamp():String
		{
			var now:Date = new Date();
			var d:String = numberLengthFix(now.getDate());
			var m:String = numberLengthFix(now.getMonth());
			var y:String = numberLengthFix(now.getFullYear());
			var hr:String = numberLengthFix(now.getHours());
			var mn:String = numberLengthFix(now.getMinutes());
			var sc:String = numberLengthFix(now.getSeconds());
			
			var timeStamp:String = d + m + y + hr + mn + sc;
			return timeStamp;
		}
		
		public static function numberLengthFix(value:*, length:uint = 2):String
		{
			value = String(value);
			while (value.length < length) {
				value = "0" + value;
			}
			return value;
		}
		
		// constructor
		
		public function FileUtilities() {
			// silence is golden
		}
		
	}
	
	// end of class
	
}

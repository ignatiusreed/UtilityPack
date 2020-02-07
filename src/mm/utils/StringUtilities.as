package mm.utils
{
	import flash.utils.getQualifiedClassName;
	public class StringUtilities extends Object
	{
		// utils
		
		public static function getNiceName(str:String):String
		{
			var niceName:String = str.toLocaleLowerCase();
			niceName = localeFix(niceName);
			niceName = stripUnwantedChars(niceName);
			return niceName;
		}
		
		private static function shiftChar(str:String, isUpperCase:Boolean):String
		{
			if (!checkIfLetter(str)) return "";
			if (isUpperCase) return str.toLocaleUpperCase();
			else return str.toLocaleLowerCase();
		}
		
		public static function noCacheFix(url:String = ""):String
		{
			var str:String = "?";
			if (url) {
				if (url.indexOf("?") != -1) str = "&";
			}
			return url + str + "v=" + Math.random();
		}
		
		private static function localeFix(str:String):String
		{
			return str.replace(/[^\w\s]|_/g, "");
		}
		
		public static function checkIfLetter(char:String):Boolean
		{
			return !(new RegExp(/[^A-Za-z]/).test(char));
		}
		
		public static function checkIfNumber(str:* = ""):Boolean
		{
			if (!isNaN(Number("0x" + str))) return true;
			else if (isNaN(Number(str))) return false;
			else return true;
		}
		
		public static function checkIfNumberAndConvert(str:String = ""):Number
		{
			if (!isNaN(Number("0x" + str))) return Number("0x" + str);
			else if (isNaN(Number(str))) return 0;
			else return Number(str);
		}
		
		public static function checkIfContains(keyword:String, content:String):Boolean
		{
			if (!keyword) return false;
			var pattern:RegExp = new RegExp(keyword, "i");
			return pattern.exec(content);
		}
		
		public static function getFileAndExtenstion(str:String):Object
		{
			var obj:Object = {name: null, extension: null};
			
			if (str.indexOf(".") != -1) {
				var arr:Array = str.split(".");
				obj.name = arr[0];
				obj.extension = arr[1];
			}
			
			return obj;
		}
		
		public static function getExtension(str:String):String
		{
			var index:int = str.lastIndexOf(".");
			if (index != -1) return str.substring(index + 1);
			else return "";
		}
		
		public static function stripExtension(str:String):String
		{
			var index:int = str.lastIndexOf(".");
			if (index != -1) return str.substring(0, index);
			else return str
		}
		
		public static function getFileAndExtension(str:String):Object
		{
			return {name: stripExtension(str), extension: getExtension(str)};
		}
		
		public static function checkIfHasCorrectExtension(str:String, ext:String = ""):Boolean
		{
			var strExt:String = getExtension(str);
			if (!strExt) return false;
			if (ext) return strExt == ext;
			else return (strExt.length >= 1 && strExt.length <= 4);
		}
		
		public static function getExtensionFromMimeType(str:String):String
		{
			if (str.indexOf("/") != -1) return str.split("/")[1];
			else return str;
		}
		
		private function extensionFix(str:String, ext:String): String
		{
			var index:int = str.lastIndexOf(".");
			var currExt:String = (index != -1) ? str.substring(index + 1) : "";
			switch (currExt) {
				case "":
					return str + "." + ext;
				case ext:
					return str;
				default:
					return str.substr(0, index) + "." + ext;
			}
		}
		
		public static function getClassName(data:*):String
		{
			var str:String = getQualifiedClassName(data);
			var index:uint = str.indexOf("::");
			if (index != -1) return str.substring(index + 2);
			return "";
		}
		
		public static function stripUnwantedChars(str:String):String
		{
			var patternReplace:Array = [
				{unwanted: "Ą", replace: "A"},
				{unwanted: "Ć", replace: "C"},
				{unwanted: "Ę", replace: "E"},
				{unwanted: "Ł", replace: "L"},
				{unwanted: "Ń", replace: "N"},
				{unwanted: "Ó", replace: "O"},
				{unwanted: "Ś", replace: "S"},
				{unwanted: "Ż", replace: "Z"},
				{unwanted: "Ź", replace: "Z"},
				{unwanted: "!", replace: ""},
				{unwanted: "-", replace: ""},
				{unwanted: "–", replace: ""},
				{unwanted: " ", replace: ""}
			];
			
			for (var i:int = 0; i < patternReplace.length; i++) {
				var item:Object = patternReplace[i];
				if (checkIfLetter(item.unwanted)) {
					str = str.replace( new RegExp( shiftChar(item.unwanted, true), "g"), shiftChar(item.replace, true) );
					str = str.replace( new RegExp( shiftChar(item.unwanted, false), "g"), shiftChar(item.replace, false) );
				} else {
					str = str.replace( new RegExp(item.unwanted, "g"), item.replace);
				}
			}
			
			return str;
		}
		
		public static function explodeString(str:String, char:String = ""):Array
		{
			if (!str) return [];
			
			if (!char) {
				var charList:Array = [",", ";", "|", "-", ".", ":", " "];
				for (var i:uint = 0; i < charList.length; i++) {
					if (str.indexOf(charList[i]) != -1) {
						char = charList[i];
						break;
					}
				}
			}
			
			if (str.indexOf(char) != -1) return str.split(char);
			else return [str];
		}
		
		// constructor
		
		public function StringUtilities()
		{
			// silence is golden
		}
		
	}
	
	// end of class
	
}
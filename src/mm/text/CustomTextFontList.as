package mm.text
{
	import flash.text.*;
	import flash.utils.*;

	public class CustomTextFontList extends Object
	{
		/*font_GGSubscript;
		font_GGSuperscript;
		font_HelveticaNeueLTPro75Bold;
		font_RobotoBold;
		font_RobotoBoldItalic;
		font_RobotoLight;
		font_RobotoLightItalic;
		font_RobotoMedium;
		font_RobotoMediumItalic;
		font_RobotoRegular;
		font_RobotoRegularItalic;*/
		
		public static const HELVETICA_BOLD:String = "font_HelveticaNeueLTPro75Bold";
		
		public static const ROBOTO_LIGHT:String = "font_RobotoLight";
		public static const ROBOTO_LIGHT_ITALIC:String = "font_RobotoLightItalic";
		public static const ROBOTO_REGULAR:String = "font_RobotoRegular";
		public static const ROBOTO_REGULAR_ITALIC:String = "font_RobotoRegularItalic";
		public static const ROBOTO_BOLD:String = "font_RobotoBold";
		public static const ROBOTO_BOLD_ITALIC:String = "font_RobotoBoldItalic";
		public static const ROBOTO_MEDIUM:String = "font_RobotoMedium";
		public static const ROBOTO_MEDIUM_ITALIC:String = "font_RobotoMediumItalic";
		
		public static const GG_SUPERSCRIPT:String = "font_GGSuperscript";
		public static const GG_SUBSCRIPT:String = "font_GGSubscript";
		
		public static function traceAllFonts():void
		{
			var fonts:Array = Font.enumerateFonts();
			for each (var f:Font in fonts) {
				trace(f.fontName, ":", f.fontStyle);
			}
		}
		
		public static function getFontName(fontName:String):String
		{
			var fontClass:Class = getDefinitionByName(fontName) as Class;
			var customFont:Font = new fontClass();
			return customFont.fontName;
		}
		
		// ...
	}
	
	// end of class
}
package mm.draw
{
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	
	public class CustomColor extends Object
	{
		public static function colorize(target_clip:DisplayObject, color:uint):void
		{
			var ct:ColorTransform = new ColorTransform();
			ct.color = color;
			target_clip.transform.colorTransform = ct;
		}
		
		public static function decolorize(target_clip:DisplayObject):void
		{
			target_clip.transform.colorTransform = null;
		}
		
		public static function randomColor():uint
		{
			return Math.floor(Math.random() * (0xFFFFFF + 1));
		}
		
		public static function autoAlpha(target_clip:DisplayObject, target_alpha:Number):void
		{
			target_clip.visible = (target_clip.alpha = target_alpha) > 0;
		}
		
		public static function uintToHex(dec:uint, html:Boolean = false):String
		{
			var digits:String = "0123456789ABCDEF";
			var hex:String = '';
			
			while (dec > 0)
			{
				var next:uint = dec & 0xF;
				dec >>= 4;
				hex = digits.charAt(next) + hex;
			}
			
			if (hex.length == 0) hex = '0';
			
			while (hex.length < 6)
			{
				hex = "0" + hex;
			}
			
			if (html) hex = "#" + hex;
			else hex = "0x" + hex;
			
			return hex;
		}
		
		// ...
	}
	
	// end of class
}
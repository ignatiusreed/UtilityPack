package mm.draw
{
	import flash.display.*;
	import flash.geom.*;

	public class CustomShape extends Shape
	{
		
		// rectangle or square
		
		public static function drawRectangle(item:* = null, size:Object = null, background:Object = null, border:Object = null, bounds:Array = null, misc:Object = null):Shape
		{
			var noItem:Boolean = item == null;
			if (!item) item = new Shape();
			
			if (!misc) misc = {};
			if (!size) size = {};
			var bgw:Number = (size.width) ? size.width : 100;
			var bgh:Number = (size.height) ? size.height : bgw;
			var ox:Number = (size.x) ? size.x : 0;
			var oy:Number = (size.y) ? size.y : 0;
			if (misc.centered) {
				ox -= bgw * .5;
				oy -= bgh * .5;
			}
			
			if (!background) background = {};
			var bgc:uint = (background.color != undefined) ? background.color : 0xFFFFFF;
			var bga:Number = (background.alpha != undefined) ? background.alpha : 1;
			
			if (!border) border = {};
			var brs:uint = (border.size) ? border.size : 0;
			var brc:uint = (border.color) ? border.color : 0x0;
			var bra:Number = (border.alpha) ? border.alpha : 0;
			var brr:uint = (border.radius) ? border.radius : 0;
			
			if (misc.clear) item.graphics.clear();
			if (border) item.graphics.lineStyle(brs, brc, bra, true, "normal", null, null, 3);
			item.graphics.beginFill(bgc, bga);
			item.graphics.drawRoundRect(ox, oy, bgw, bgh, brr, brr);
			item.graphics.endFill();
			
			if (bounds) {
				var grid:Rectangle;
				switch (bounds.length) {
					case 1:
						grid = new Rectangle(bounds[0], bounds[0], bgw - bounds[0] * 2, bgh - bounds[0] * 2);
						break;
					case 2:
						grid = new Rectangle(bounds[0], bounds[1], bgw - bounds[0] * 2, bgh - bounds[1] * 2);
						break;
					case 4:
						grid = new Rectangle(bounds[0], bounds[1], bgw - bounds[0] - bounds[2], bgh - bounds[1] - bounds[3]);
						break;
				}
				if (grid) item.scale9Grid = grid;
			}
			
			return (noItem) ? item : null;
		}
		
		// elipse or circle
		
		public static function drawCircle(item:* = null, size:Object = null, background:Object = null, border:Object = null, misc:Object = null):Shape
		{
			var noItem:Boolean = item == null;
			if (!item) item = new Shape();
			
			if (!misc) misc = {};
			if (!size) size = {};
			var bgw:Number = (size.width) ? size.width : 0;
			var bgh:Number = (size.height) ? size.height : 0;
			var bgr:Number = (size.radius) ? size.radius : 50;
			if (!bgw && !bgh) bgw = bgh = bgr * 2;
			var ox:Number = (size.x) ? size.x : 0;
			var oy:Number = (size.y) ? size.y : 0;
			if (misc.centered) {
				ox -= bgw * .5;
				oy -= bgh * .5;
			}
			
			if (!background) background = {};
			var bgc:uint = (background.color != undefined) ? background.color : 0xFF0000;
			var bga:Number = (background.alpha != undefined) ? background.alpha : 1;
			
			if (!border) border = {};
			var brs:uint = (border.size) ? border.size : 0;
			var brc:uint = (border.color) ? border.color : 0x0;
			var bra:Number = (border.alpha) ? border.alpha : 0;
			
			if (misc.clear) item.graphics.clear();
			if (border) item.graphics.lineStyle(brs, brc, bra, true, "normal", null, null, 3);
			item.graphics.beginFill(bgc, bga);
			item.graphics.drawEllipse(ox, oy, bgw, bgh);
			item.graphics.endFill();
			
			return (noItem) ? item : null;
		}
		
		// pie (also a circle)
		
		private static var CONVERT_TO_RADIANS:Number = Math.PI / 180;
		
		public static function drawPie(item:* = null, size:Object = null, percent:Number = 0, background:Object = null, border:Object = null, misc:Object = null):Shape
		{
			var noItem:Boolean = item == null;
			if (!item) item = new Shape();
			
			if (!misc) misc = {};
			if (!size) size = {};
			var bgw:Number = (size.width) ? size.width : 100;
			var bgh:Number = (size.height) ? size.height : 100;
			var bgr:Number = (size.radius) ? size.radius : 100;
			var ox:Number = (size.x) ? size.x : bgw * .5;
			var oy:Number = (size.y) ? size.y : bgh * .5;
			if (misc.centered) ox = oy = 0;
			
			if (percent > 100) percent = 100;
			var angle:Number = 3.60 * percent;
			
			if (!background) background = {};
			var bgc:uint = (background.color != undefined) ? background.color : 0xFFFFFF;
			var bga:Number = (background.alpha != undefined) ? background.alpha : 1;
			
			if (!border) border = {};
			var brs:uint = (border.size) ? border.size : 0;
			var brc:uint = (border.color) ? border.color : 0x0;
			var bra:Number = (border.alpha) ? border.alpha : 0;
			
			if (misc.clear) item.graphics.clear();
			if (border) item.graphics.lineStyle(brs, brc, bra, true, "normal", null, null, 3);
			item.graphics.moveTo(ox, oy);
			item.graphics.beginFill(bgc, bga);
			item.graphics.lineTo(ox + bgr, oy);
			
			var nSeg:Number = Math.floor (angle / 30);
			var pSeg:Number = angle - nSeg * 30;
			var a:Number = 0.268;
			var endx:Number;
			var endy:Number;
			var ax:Number;
			var ay:Number;
			
			for (var i:uint = 0; i < nSeg; i++) {
				endx = bgr * Math.cos((i + 1) * 30 * CONVERT_TO_RADIANS);
				endy = bgr * Math.sin((i + 1) * 30 * CONVERT_TO_RADIANS);
				ax = endx + bgr * a * Math.cos(((i + 1) * 30  - 90) * CONVERT_TO_RADIANS);
				ay = endy + bgr * a * Math.sin(((i + 1) * 30  - 90) * CONVERT_TO_RADIANS);
				item.graphics.curveTo(ox + ax, oy + ay, ox + endx, oy + endy);
			}
			
			if (pSeg > 0) {
				a = Math.tan (pSeg / 2 * CONVERT_TO_RADIANS);
				endx = bgr * Math.cos((i * 30 + pSeg) * CONVERT_TO_RADIANS);
				endy = bgr * Math.sin((i * 30 + pSeg) * CONVERT_TO_RADIANS);
				ax = endx + bgr * a * Math.cos((i * 30 + pSeg - 90) * CONVERT_TO_RADIANS);
				ay = endy + bgr * a * Math.sin((i * 30 + pSeg - 90) * CONVERT_TO_RADIANS);
				item.graphics.curveTo(ox + ax, oy + ay, ox + endx, oy + endy);
			}
			
			return (noItem) ? item : null;
		}
		
		/*
		public static function drawCustomLine(line_width:Number, line_height:Number = 0, line_thickness:Number = 1, line_color:uint = 0x0, line_alpha:Number = 1, dash_size:Number = 0, gap_size:Number = 0,
			line_scaling:String = LineScaleMode.NONE, line_caps:String = CapsStyle.NONE, line_joint:String = JointStyle.MITER, line_miter:Number = 1):Shape
		{
			var custom_shape:Shape = new Shape();
			custom_shape.graphics.lineStyle(line_thickness, line_color, line_alpha, true, line_scaling, line_caps, line_joint, line_miter);
			
			custom_shape.graphics.moveTo(0, 0);
			
			if (dash_size && gap_size)
			{
				if (line_height == 0) // horizontal
				{
					while (custom_shape.width <= line_width)
					{
						if (custom_shape.width == 0)
						{
							if (custom_shape.width + dash_size >= line_width)
							{
								custom_shape.graphics.lineTo(line_width, 0);
							}
							else
							{
								custom_shape.graphics.lineTo(custom_shape.width + dash_size, 0);
							}
						}
						else
						{
							if (custom_shape.width + gap_size + dash_size <= line_width)
							{
								custom_shape.graphics.lineTo(custom_shape.width + gap_size + dash_size, 0);
								
								if (custom_shape.width == line_width) break;
							}
							else
							{
								custom_shape.graphics.lineTo(line_width, 0);
							}
						}
					
						if (custom_shape.width + gap_size < line_width)
						{
							custom_shape.graphics.moveTo(custom_shape.width + gap_size, 0);
						}
						else
						{
							break;
						}
					}
				}
				else if (line_width == 0) //  vertical
				{
					while (custom_shape.height <= line_height)
					{
						if (custom_shape.height == 0)
						{
							if (custom_shape.height + dash_size >= line_height)
							{
								custom_shape.graphics.lineTo(0, line_height);
							}
							else
							{
								custom_shape.graphics.lineTo(0, custom_shape.height + dash_size);
							}
						}
						else
						{
							if (custom_shape.height + gap_size + dash_size <= line_height)
							{
								custom_shape.graphics.lineTo(0, custom_shape.height + gap_size + dash_size);
								
								if (custom_shape.height == line_height) break;
							}
							else
							{
								custom_shape.graphics.lineTo(0, line_height);
							}
						}
					
						if (custom_shape.height + gap_size < line_height)
						{
							custom_shape.graphics.moveTo(0, custom_shape.height + gap_size);
						}
						else
						{
							break;
						}
					}
				}
			}
			else
			{
				custom_shape.graphics.lineTo(line_width, line_height);
			}
			
			return custom_shape;
		}
		
		// ...
	}
	
	// end of class
}

package mm.draw
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class CustomAlign extends Object
	{
		public static const TOP_LEFT:String = "TL";
		public static const TOP_RIGHT:String = "TR";
		public static const BOTTOM_RIGHT:String = "BR";
		public static const BOTTOM_LEFT:String = "BL";
		public static const CENTER_TOP:String = "CT";
		public static const CENTER_RIGHT:String = "CR";
		public static const CENTER_BOTTOM:String = "CB";
		public static const CENTER_LEFT:String = "CL";
		public static const CENTER_CENTER:String = "CC";
		
		public static const DIRECTION_HORIZONTAL:String = "H";
		public static const DIRECTION_VERTICAL:String = "V";
		
		// align before
		
		public static function posBeforeHorizontally(target_clip:DisplayObject, other_clip:DisplayObject, target_width:Number = 0):Number
		{
			return (target_width > 0) ? other_clip.x - target_width : other_clip.x - target_clip.width;
		}
		
		public static function posBeforeVertically(target_clip:DisplayObject, other_clip:DisplayObject, target_height:Number = 0):Number
		{
			return (target_height > 0) ? other_clip.y - target_height : other_clip.y - target_clip.height;
		}
		
		// align after
		
		public static function posAfterHorizontally(other_clip:DisplayObject, other_width:Number = 0):Number
		{
			return (other_width > 0) ? other_clip.x + other_width : other_clip.x + other_clip.width;
		}
		
		public static function posAfterVertically(other_clip:DisplayObject, other_height:Number = 0):Number
		{
			return (other_height > 0) ? other_clip.y + other_height : other_clip.y + other_clip.height;
		}
		
		// align inside
		
		public static function posInsideLeft(container_clip:DisplayObject):Number
		{
			return container_clip.x;
		}
		
		public static function posInsideRight(target_clip:DisplayObject, container_clip:DisplayObject):Number
		{
			return container_clip.x + container_clip.width - target_clip.width;
		}
		
		public static function posInsideTop(container_clip:DisplayObject):Number
		{
			return container_clip.y;
		}
		
		public static function posInsideBottom(target_clip:DisplayObject, container_clip:DisplayObject):Number
		{
			return container_clip.y + container_clip.height - target_clip.height;
		}
		
		// center
		
		public static function centerHorizontally(target_clip:DisplayObject, container_clip:DisplayObject):Number
		{
			return container_clip.x + (container_clip.width - target_clip.width) * .5;
		}
		
		public static function centerVertically(target_clip:DisplayObject, container_clip:DisplayObject):Number
		{
			return container_clip.y + (container_clip.height - target_clip.height) * .5;
		}
		
		public static function centerHorizontallyAlt(target_width:Number, container_width:Number):Number
		{
			return (container_width - target_width) * .5;
		}
		
		public static function centerVerticallyAlt(target_height:Number, container_height:Number):Number
		{
			return (container_height - target_height) * .5;
		}
		
		// custom stage align
		
		public static function customStageAlign(target_clip:DisplayObject, container_clip:DisplayObject, alignment:String):Point
		{
			alignment = alignment.toUpperCase();
			
			var new_x:Number;
			var new_y:Number;
			
			if (alignment.indexOf("L") != -1)
			{
				new_x = posInsideLeft(container_clip);
			}
			
			if (alignment.indexOf("R") != -1)
			{
				new_x = posInsideRight(target_clip, container_clip);
			}
			
			if (alignment.indexOf("T") != -1)
			{
				new_y = posInsideTop(container_clip);
			}
			
			if (alignment.indexOf("B") != -1)
			{
				new_y = posInsideBottom(target_clip, container_clip);
			}
			
			if (alignment.indexOf("C") != -1)
			{
				new_x = centerHorizontally(target_clip, container_clip);
			}
			
			if (alignment == CENTER_CENTER)
			{
				new_y = centerVertically(target_clip, container_clip);
			}
			
			return new Point(new_x, new_y);
		}
		
		// distribute horizontally
		
		public static function distributeHorizontally(items:Array, container_clip:DisplayObject, margin:uint = 0, item_lengths:Vector.<Number> = null, container_width:Number = 0):void
		{
			var i:uint = 0;
			var start:Number = container_clip.width;
			
			if (container_width > 0) start = container_clip.width;
			
			if (!item_lengths)
			{
				for (i = 0; i < items.length; i++)
				{
					start -= items[i].width;
				}
			}
			else
			{
				for (i = 0; i < items.length; i++)
				{
					start -= item_lengths[i];
				}
			}
			
			start = (start - margin * (items.length - 1)) * .5;
			
			items[0].x = start;
			
			if (!item_lengths)
			{
				for (i = 1; i < items.length; i++)
				{
					items[i].x = items[i - 1].x + items[i - 1].width + margin;
				}
			}
			else
			{
				for (i = 1; i < items.length; i++)
				{
					items[i].x = items[i - 1].x + item_lengths[i - 1] + margin;
				}
			}
		}
		
		// top layer
		
		public static function moveToTop(target_clip:DisplayObject):void
		{
			target_clip.parent.setChildIndex(target_clip, target_clip.parent.numChildren - 1);
		}
		
		// ...
	}
	
	// end of class
}

package mm.events
{
	import flash.events.Event;
	
	public class CustomEvent extends Event
	{
		private var _data:*;
		
		public function CustomEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public override function clone():Event
        {
            return new CustomEvent(type, _data, bubbles, cancelable);
        }
       
        public override function toString():String
        {
            return formatToString("CustomEvent", "data", "type", "bubbles", "cancelable");
        }
		
		//
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(data:*):void
		{
			_data = data;
		}
		
		// ...
		
	}
	
	// end of class
	
}

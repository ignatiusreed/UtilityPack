package mm.events
{
	import flash.event.EventDispatcher;
	
	public class Mediator extends EventDispatcher
	{
		// this is just a dummy base file!
		// copy this file to your project and add many other constants as event types 
		// usage: mediator.dispatchEvent(new CustomEvent(Mediator.SOME_EVENT, {data: "hello world"}));
		public static const SOME_EVENT:String = "someEvent";
		
		public function Mediator()
		{
			// silence is golden
		}
		
		// ...
		
	}
	
	// end of class
	
}
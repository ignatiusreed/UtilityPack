package mm.ui
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	import mm.events.CustomEvent;
	
	public class CustomCheckbox extends Sprite
	{
		public static const EVENT_CHECKBOX_CLICK:String = "checkboxClick";
		public static const EVENT_CHECKBOX_TOGGGLE:String = "checkboxToggle";
		
		protected var _data:Object;
		protected var _isOn:Boolean;
		protected var _isLocked:Boolean;
		protected var _isToggle:Boolean;
		protected var _resizeHit:Boolean;
		protected var _body:MovieClip;
		protected var _icon:MovieClip;
		protected var _label:TextField;
		protected var _hit:Sprite;
		
		public function CustomCheckbox(data:Object = null)
		{
			_data = data;
			_isOn = (data.isOn != undefined) ? data.isOn : false;
			_isLocked = (data.isLocked != undefined) ? data.isLocked : false;
			_isToggle = (data.isToggle != undefined) ? data.isToggle : true;
			_resizeHit = (data.resizeHit != undefined) ? data.resizeHit : true;
			
			drawItems();
			drawHit();
			updateToggleDisplayState();
		}
		
		protected function drawHit():void
		{
			if (_isLocked) return;
			
			_hit = new Sprite();
			_hit.graphics.beginFill(0x00FFFF, 0);
			_hit.graphics.drawRect(0, 0, 10, 10);
			_hit.graphics.endFill();
			
			refreshHit();
			
			_hit.buttonMode = true;
			_hit.addEventListener(MouseEvent.MOUSE_OVER, itemOver, false, 0, true);
			_hit.addEventListener(MouseEvent.MOUSE_OUT, itemOut, false, 0, true);
			_hit.addEventListener(MouseEvent.RELEASE_OUTSIDE, itemOut, false, 0, true);
			_hit.addEventListener(MouseEvent.CLICK, itemClick, false, 0, true);
			addChild(_hit);
		}
		
		public function refreshHit():void
		{
			if (_resizeHit) {
				_hit.width = 1;
				_hit.width = width;
				_hit.height = 1;
				_hit.height = height;
			} else {
				_hit.width = _data.maxWidth ? _data.maxWidth : width;
				_hit.height = _data.maxHeight ? _data.maxHeight : height;
			}
		}
		
		protected function drawItems():void
		{
			
		}
		
		protected function itemOver(e:MouseEvent):void
		{
			
		}
		
		protected function itemOut(e:MouseEvent):void
		{

		}
		
		protected function itemClick(e:MouseEvent):void
		{
			if (_isToggle) toggle(true);
			else dispatchEvent( new CustomEvent(EVENT_CHECKBOX_CLICK, {itemID: _data.id, itemLabel: _data.itemLabel, itemValue: _data.itemValue, toggleState: _isOn, itemClip: this}) );
		}
		
		protected function updateToggleDisplayState():void
		{
			
		}
		
		public function get label():TextField
		{
			return _label;
		}
		
		public function getLabel():String
		{
			return _data.itemLabel;
		}
		
		public function getState():Boolean
		{
			return _isOn;
		}
		
		public function setLock(isLocked:Boolean):void
		{
			if (_isLocked == isLocked) return;
			
			_isLocked = isLocked;
			_hit.visible = !_isLocked;
			updateToggleDisplayState();
		}
		
		public function getLock():Boolean
		{
			return _isLocked;
		}
		
		public function setLabelText(str:String):void
		{
			if (_label) _label.text = str;
		}
		
		public function getLabelText():String
		{
			return _label ? _label.text : "";
		}
		
		public function setState(isOn:Boolean):void
		{
			if (!_isToggle) return;
			
			_isOn = isOn;
			updateToggleDisplayState();
		}
		
		public function toggle(sendEvent:Boolean):void
		{
			if (!_isToggle) return;
			
			_isOn = !_isOn;
			if (sendEvent) dispatchEvent( new CustomEvent(EVENT_CHECKBOX_TOGGGLE, {itemID: _data.id, itemLabel: _data.itemLabel, itemValue: _data.itemValue, toggleState: _isOn, itemClip: this}) );
			updateToggleDisplayState();
		}
		
		// ...
		
	}
	
	// end of class
	
}
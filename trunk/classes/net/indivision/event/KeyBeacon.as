import net.indivision.core.AbstractDispatcher;
import mx.utils.Delegate;
/**
* Listens for key events and dispatches an event corresponding to the key.
* @event onKeyDown Broadcast when a key is pressed.
* @event onKeyUp Broadcast when a key is released.
* @event <DYNAMIC> Broadcasts the letter pressed or released as an event.
*/
class net.indivision.event.KeyBeacon extends AbstractDispatcher
{
	/**
	* Class only dispatches events if enabled set to true (default value is true).
	*/
	public var enabled:Boolean = true;
	/**
	* undocumented (default value is false).
	*/
	public var strict:Boolean = false;
	private var _lastKey:String;
	private var _lastChar:String;
	private var lastSpecial:Array;
	public function KeyBeacon()
	{
		super();
		var myListener:Object = new Object();
		myListener.onKeyDown = Delegate.create(this, keyDown);
		myListener.onKeyUp = Delegate.create(this, keyUp);
		Key.addListener(myListener);
	}
	private function keyDown():Void
	{
		keyEvent("down", "onKeyDown");
	}
	private function keyUp():Void
	{
		keyEvent("up", "onKeyUp");
	}
	private function keyEvent(suffix, eventType):Void
	{
		if (enabled) {
			var char, key;
			char = _lastChar = chr(Key.getAscii());
			if (Key.getCode() == Key.ENTER) {
				char = "";
			}
			if (strict) {
				var special = getSpecial();
				for (var i = 0; i <= special.length; i++) {
					switch (suffix) {
					case "up" :
						if (lastSpecial[i] == undefined) {
							key = char + suffix;
						} else {
							key = lastSpecial[i] + char + suffix;
						}
						break;
					case "down" :
						if (special[i] == undefined) {
							key = char + suffix;
						} else {
							key = special[i] + char + suffix;
						}
						break;
					}
					_lastKey = key;
					dispatchEvent({type:key, target:this});
					dispatchEvent({type:eventType, target:this});
				}
			} else {
				switch (suffix) {
				case "up" :
					key = lastSpecial.join("") + char + suffix;
					break;
				case "down" :
					key = getSpecial().join("") + char + suffix;
					break;
				}
				_lastKey = key;
				dispatchEvent({type:key, target:this});
				dispatchEvent({type:eventType, target:this});
			}
		}
	}
	private function getSpecial():Array
	{
		var c = [];
		if (Key.isDown(Key.SHIFT)) {
			c.push("shift");
		}
		if (Key.isDown(Key.CONTROL)) {
			c.push("ctrl");
		}
		if (Key.isDown(Key.ALT)) {
			c.push("alt");
		}
		if (Key.isDown(Key.BACKSPACE)) {
			c.push("backspace");
		}
		if (Key.isDown(Key.DELETEKEY)) {
			c.push("delete");
		}
		if (Key.isDown(Key.TAB)) {
			c.push("tab");
		}
		if (Key.isDown(Key.LEFT)) {
			c.push("left");
		}
		if (Key.isDown(Key.RIGHT)) {
			c.push("right");
		}
		if (Key.isDown(Key.UP)) {
			c.push("up");
		}
		if (Key.isDown(Key.DOWN)) {
			c.push("down");
		}
		if (Key.isDown(Key.ENTER)) {
			c.push("enter");
		}
		lastSpecial = c;
		return c;
	}
	/**
	* @return the last key pressed as a String.
	*/
	public function get lastKey():String
	{
		return _lastKey;
	}
	/**
	* @return the last character code as a String.
	*/
	public function get lastChar():String
	{
		return _lastChar;
	}
}

import mx.utils.Delegate;
import mx.events.EventDispatcher;
import net.indivision.core.MovieClipDispatcher;
/**
* Foundation for state-based buttons.
* @event onRollOver Broadcast when mouse rolls over button.
* @event onRollOut Broadcast when mouse rolls out from button.
* @event onPress Broadcast when mouse-button is pressed while over button.
* @event onRelease Broadcast when mouse-button is released while over button.
* @event onReleaseOutside Broadcast when mouse button is released while off of button if mouse-button was pressed while over.
*/
class net.indivision.control.AbstractButton extends MovieClipDispatcher
{
	/**
	* Adds an event listener.
	* @see mx.events.EventDispatcher
	*/
	public var addEventListener:Function;
	/**
	* Removes an event listener.
	* @see mx.events.EventDispatcher
	*/
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	private var interior:MovieClip;
	private var states:Array;
	private var _state:Number;
	private var _over:Boolean;
	private var _lock:Number = null;
	private var _active:Boolean = true;
	private var _label:String;
	public function AbstractButton()
	{
		super();
		target = mc;
		EventDispatcher.initialize(this);
	}
	/**
	* De-actives and locks the button at its current state.
	* @see net.indivision.control.ButtonBase#lock
	* @see net.indivision.control.ButtonBase#active
	*/
	public function freeze():Void
	{
		lock = state;
		active = false;
	}
	/**
	* Activates and unLocks the button.
	* @see net.indivision.control.ButtonBase#unLock
	* @see net.indivision.control.ButtonBase#active
	*/
	public function unFreeze():Void
	{
		unLock();
		active = true;
	}
	/**
	* Disables lock.
	* @see net.indivision.control.ButtonBase#lock
	*/
	public function unLock():Void
	{
		// may want to over-ride this with custom routine
		lock = null;
		state = 0;
	}
	private function refresh():Void
	{
		// NOTE: over-ride this with custom routine
		interior.labelField.text = label;
	}
	private function _onRollOver():Void
	{
		if (_active && _lock == null) {
			_over = true;
			state = 1;
		}
		dispatchEvent({type:"onRollOver", target:this});
	}
	private function _onRollOut():Void
	{
		if (_active && _lock == null) {
			_over = false;
			state = 0;
		}
		dispatchEvent({type:"onRollOut", target:this});
	}
	private function _onPress():Void
	{
		if (_active && _lock == null) {
			state = 2;
			dispatchEvent({type:"onPress", target:this});
		}
	}
	private function _onRelease():Void
	{
		if (_active && _lock == null) {
			state = 1;
			dispatchEvent({type:"onRelease", target:this});
		}
	}
	private function _onReleaseOutside():Void
	{
		if (_active && _lock == null) {
			state = 0;
			dispatchEvent({type:"onReleaseOutside", target:this});
		}
	}
	/**
	* Sets the text property of labelField.
	* @param text the text to apply to labelField.
	*/
	public function set label(text:String):Void
	{
		if (text && text != interior.labelField.text) {
			_label = text;
			interior.labelField.text = text;
			refresh();
		}
	}
	/**
	* @return the current label text.
	*/
	public function get label():String
	{
		return _label;
	}
	/**
	* Changes the button state.
	* @param newState the state to change to.
	*/
	public function set state(newState:Number):Void
	{
		if (newState != state) {
			_state = newState;
			refresh();
		}
	}
	/**
	* @return the current button state.
	*/
	public function get state():Number
	{
		return _state;
	}
	/**
	* @return returns true if the button is currently in a roll-over state.
	*/
	public function get over():Boolean
	{
		return _over;
	}
	/**
	* Changes the button to the designated state and locks it there.
	* @param lockState the state to lock to.
	*/
	public function set lock(lockState:Number):Void
	{
		_lock = lockState;
		if (state != _lock) {
			state = _lock;
		}
	}
	/**
	* Sets whether or not the button is active (affected by user input).
	* @param isActive button is affected by user input if true.
	*/
	public function set active(isActive:Boolean):Void
	{
		_active = isActive;
		if (isActive) {
			interior.useHandCursor = true;
		} else {
			interior.useHandCursor = false;
		}
	}
	/**
	* @return whether or not the button is active.
	*/
	public function get active():Boolean
	{
		return _active;
	}
	/**
	* @param movieClip the MovieClip to use for representing the button (when it isn't already associated via linkage properties).
	*/
	public function set target(movieClip:MovieClip):Void
	{
		_mc = movieClip;
		if (mc._interior == undefined) {
			interior = mc;
		} else {
			interior = mc._interior;
		}
		mc.onRollOver = Delegate.create(this, _onRollOver);
		mc.onRollOut = Delegate.create(this, _onRollOut);
		mc.onPress = Delegate.create(this, _onPress);
		mc.onRelease = Delegate.create(this, _onRelease);
		mc.onReleaseOutside = Delegate.create(this, _onReleaseOutside);
		refresh();
	}
}

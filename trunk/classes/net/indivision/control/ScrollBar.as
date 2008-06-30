import net.indivision.core.MovieClipDispatcher;
import mx.utils.Delegate;
import mx.events.EventDispatcher;
/**
* A basic scrollbar. Requires specific movieclip structure. See sample FLA for details.
* @event onHandlePress Broadcast when the scroll handle is pressed.
* @event onHandleRelease Broadcast when the scroll handle is released.
* @event onTrayRelease Broadcast when the mouse button is released over the scroll tray.
* @event onChange Broadcast when the content is scrolled.
*/
class net.indivision.control.ScrollBar extends MovieClipDispatcher
{
	/**
	* Determines whether or not events are dispatched from ScrollBar (true by default).
	*/
	public var isEnabled:Boolean = true;
	/**
	* Determines whether or not the ScrollBar handle positions itself where the tray is released (true by default).
	*/
	public var isUpdatedOnTrayRelease:Boolean = true;
	private var mc:MovieClip;
	private var tray:MovieClip;
	private var handle:MovieClip;
	private var onMouseMove:Function;
	private var _position:Number;
	private var lastPosition:Number;
	private var _handleSize:Number;
	private var lastMouse:Number;
	private var _lastTrayPosition:Number;
	public function ScrollBar()
	{
		super();
		tray = mc.tray;
		handle = mc.handle;
		initialize();
	}
	/**
	* Sets the position to 0.
	*/
	public function reset():Void
	{
		position = 0;
	}
	private function initialize():Void
	{
		position = 0;
		handle.onPress = Delegate.create(this, onHandlePress);
		handle.onRelease = handle.onReleaseOutside = Delegate.create(this, onHandleRelease);
		tray.onRelease = Delegate.create(this, onTrayRelease);
	}
	private function getHandleSize():Number
	{
		if (_handleSize == undefined) {
			return handle._height;
		} else {
			return _handleSize;
		}
	}
	private function getMax():Number
	{
		return tray._height - getHandleSize();
	}
	private function update():Void
	{
		handle._y = Math.round(tray._y + (_position * getMax()));
	}
	private function onHandlePress():Void
	{
		if (isEnabled) {
			lastMouse = mc._ymouse;
			onMouseMove = onHandleMove;
			dispatchEvent({type:"onHandlePress", target:this});
		}
	}
	private function onHandleRelease():Void
	{
		if (isEnabled) {
			stopDrag();
			onMouseMove = null;
			dispatchEvent({type:"onHandleRelease", target:this});
		}
	}
	private function onHandleMove():Void
	{
		onDragHandle();
		_position = (handle._y - tray._y) / getMax();
		if (_position != lastPosition) {
			onChangeEvent();
		}
		updateAfterEvent();
	}
	private function onDragHandle():Void
	{
		if (mc._ymouse < 0) {
			handle._y = 0;
		} else if (mc._ymouse > getMax() + getHandleSize()) {
			handle._y = getMax();
		} else {
			handle._y += mc._ymouse - lastMouse;
			lastMouse = mc._ymouse;
			if (handle._y < 0) {
				handle._y = 0;
			} else if (handle._y > getMax()) {
				handle._y = getMax();
			}
		}
	}
	private function onTrayRelease():Void
	{
		if (isEnabled) {
			var p:Number;
			if (mc._ymouse > getMax()) {
				_lastTrayPosition = 1;
			} else {
				_lastTrayPosition = mc._ymouse / getMax();
			}
			if (isUpdatedOnTrayRelease) {
				position = lastTrayPosition;
			}
			dispatchEvent({type:"onTrayRelease", target:this});
		}
	}
	private function onChangeEvent():Void
	{
		lastPosition = _position;
		dispatchEvent({type:"onChange", target:this});
	}
	/**
	* @return the last tray position released.
	*/
	public function get lastTrayPosition():Number
	{
		return _lastTrayPosition;
	}
	/**
	* @param newSize the new size to use for the ScrollBar handle. Useful to change when the handle graphic includes a glow or dropshadow.
	*/
	public function set handleSize(newSize:Number):Void
	{
		_handleSize = newSize;
	}
	/**
	* Changes the position of the handle and scrolls the content accordingly.
	* @param newPosition the new position as a Number between 0 and 1.
	*/
	public function set position(newPosition:Number):Void
	{
		_position = newPosition;
		if (_position < 0) {
			_position = 0;
		} else if (_position > 1) {
			_position = 1;
		}
		if (_position != lastPosition) {
			onChangeEvent();
			update();
		}
	}
	/**
	* @return the current scroll position as a Number between 0 and 1.
	*/
	public function get position():Number
	{
		return _position;
	}
}

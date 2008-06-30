import net.indivision.tween.FrameMotion;
import net.indivision.core.AbstractMovieClip;
import mx.utils.Delegate;
/**
* MovieClip extenstion with the ability to play forward and back between anchor points on the time-line.
*/
class net.indivision.element.Animation extends AbstractMovieClip
{
	private var frameMotion:FrameMotion;
	private var _tstate:Number = 0;
	private var _cstate:Number = -1;
	private var startframe:Number;
	private var lastframe:Number;
	public function Animation(target:MovieClip)
	{
		super();
		if (typeof (this) == "movieclip") {
			super.stop();
			frameMotion = new FrameMotion();
			frameMotion.target = this;
		} else {
			if (target) {
				_mc = target;
			}
			mc.stop();
			frameMotion = new FrameMotion();
			frameMotion.target = mc;
		}
		mc.anchor = Delegate.create(this, anchor);
		goforward();
	}
	/**
	* This method triggers a state change. By calling the anchor() method on the time-line of a key-framed animation, the user is able to define sequentially numbered states.
	*/
	public function anchor():Void
	{
		update();
		if (_tstate == state) {
			stop();
		}
	}
	/**
	* Animates target MovieClip backward until reaching the next anchor-point.
	*/
	public function reverse(r:Number):Void
	{
		if (r) {
			rate = r;
		}
		_tstate = -1;
		goreverse();
		// Haven't discovered way to determine 
		// how many anchorpoints there are when 
		// overlapping frame 1 in reverse.
		// *** Yet to be developed...
	}
	/**
	* Animates target MovieClip forward until reaching the next anchor-point.
	*/
	public function play(r:Number):Void
	{
		if (r) {
			rate = r;
		}
		_tstate = -1;
		goforward();
	}
	/**
	* Stops the current animation.
	*/
	public function stop():Void
	{
		frameMotion.stop();
	}
	/**
	* Removes Animation.
	*/
	public function removeMovieClip():Void
	{
		stop();
		super.removeMovieClip();
	}
	private function goforward():Void
	{
		frameMotion.forward();
	}
	private function goreverse():Void
	{
		frameMotion.reverse();
	}
	private function onUnload():Void
	{
		stop();
	}
	private function update():Void
	{
		var cf = mc._currentframe;
		if (state === -1) {
			_cstate = 0;
			startframe = lastframe = cf;
		} else if (cf > lastframe) {
			_cstate++;
			lastframe = mc._currentframe;
		} else if (cf == startframe) {
			_cstate = 0;
			lastframe = mc._currentframe;
		} else if (cf != lastframe) {
			_cstate--;
			lastframe = mc._currentframe;
		}
	}
	/**
	* @param milliseconds time in milliseconds to wait between advancing frames forward or back. If undefined or 0, onEnterFrame is used.
	*/
	public function set rate(milliseconds:Number)
	{
		frameMotion.rate = milliseconds;
	}
	/**
	* @return time in milliseconds of wait between each frame advance. If 0, onEnterFrame is used.
	*/
	public function get rate():Number
	{
		return frameMotion.rate;
	}
	/**
	* Causes the MovieClip to animate forward or backward toward the designated state.
	* @param newState the state or anchor-point to animate to.
	*/
	public function set state(newState:Number)
	{
		var cf = mc._currentframe;
		if (state != newState || cf != lastframe) {
			_tstate = newState;
			if (_tstate == _cstate) {
				if (cf < lastframe) {
					goforward();
				} else {
					goreverse();
				}
			} else {
				if (_tstate > _cstate) {
					goforward();
				} else {
					goreverse();
				}
			}
		} else {
			stop();
		}
	}
	/**
	* @return the last state triggered by an anchor call on the time-line.
	*/
	public function get state():Number
	{
		return _cstate;
	}
}

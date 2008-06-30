import net.indivision.tween.TweenBase;
import net.indivision.tween.Motion;
/**
* Uses a Motion to tween through a movieclips frames.
*/
class net.indivision.tween.FrameTween extends TweenBase
{
	private var _target:MovieClip;
	private var startframe:Number;
	private var change:Number;
	private var _forceFrames:Boolean;
	/**
	* @param target MovieClip to affect.
	* @param motion Motion to use.
	* @param forceFrames determines whether or not tween sequence will skip frames.
	*/
	public function FrameTween(target:MovieClip, motion:Motion, forceFrames:Boolean)
	{
		super(updateFrame, motion);
		_target = target;
		_forceFrames = forceFrames;
		startframe = 1;
		change = target._totalframes;
		if (_forceFrames) {
			motion.steps = change;
		}
	}
	/**
	* Tweens to a designated frame from the currentframe.
	* @param frame frame to tween to.
	*/
	public function animateTo(frame:Number):Void
	{
		if (!frame) {
			frame = _target._totalframes;
		}
		startframe = _target._currentframe;
		change = frame - startframe;
		if (_forceFrames) {
			motion.steps = Math.abs(change);
		}
		start();
	}
	private function updateFrame(z:Number):Void
	{
		var f:Number = Math.round(startframe + (change * z));
		_target.gotoAndStop(f);
	}
}

import net.indivision.tween.Motion;
import net.indivision.tween.PropertyTween;
import mx.utils.Delegate;
/**
* Handlers for moving Objects.
*/
class net.indivision.tween.Move
{
	private static var _motion:Motion;
	private function Move()
	{
	}
	/**
	* Places methods for handling motion directly onto a target Object so that the user could then use "moveTo" by itself, without referencing this class.
	* @param target the MovieClip to place the methods on to.
	* @param customMotion the Motion to apply.
	*/
	public static function grant(target:MovieClip, customMotion:Motion):Void
	{
		var mc = init(target, customMotion);
		target.moveTo = Delegate.create(mc, mc.moveTo);
		target.moveFrom = Delegate.create(mc, mc.moveFrom);
		target.alter = Delegate.create(mc, mc.alter);
	}
	/**
	* Moves the target from its current position to a new x:y location.
	* @param target Object to move.
	* @param x _x position to move target to.
	* @param y _y position to move target to.
	* @param onComplete (optional) Function to execute on completion of tween.
	* @param customMotion (optional) the Motion to apply.
	*/
	public static function moveTo(target:Object, x:Number, y:Number, onComplete:Function, customMotion:Motion):Void
	{
		start(target, x, y, onComplete, customMotion);
	}
	/**
	* Moves the target a designated value(s) away from its current location.
	* @param target Object to move.
	* @param x _x position to move target to.
	* @param y _y position to move target to.
	* @param onComplete (optional) Function to execute on completion of tween.
	* @param customMotion (optional) the Motion to apply.
	*/
	public static function moveFrom(target:Object, x:Number, y:Number, onComplete:Function, customMotion:Motion):Void
	{
		start(target, target._x + x, target._y + y, onComplete, customMotion);
	}
	private static function init(t:Object, m:Motion):PropertyTween
	{
		if (m == undefined) {
			m = _motion;
		}
		if (t.__indivision__Motion == undefined) {
			t.__indivision__Motion = new PropertyTween(t, m);
		}
		t.__indivision__Motion.motion = m;
		//
		return t.__indivision__Motion;
	}
	private static function start(t:Object, x:Number, y:Number, c:Function, m:Motion):Void
	{
		var mc = init(t, m);
		mc.moveTo(x, y, c);
	}
	/**
	* @param customMotion the Motion to apply.
	*/
	public static function set motion(customMotion:Motion):Void
	{
		if (customMotion) {
			_motion = customMotion;
		}
	}
}

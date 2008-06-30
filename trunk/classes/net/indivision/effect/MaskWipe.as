import net.indivision.shape.RectangleShape;
import net.indivision.arrange.Position;
import net.indivision.arrange.Align;
import net.indivision.effect.TweenEffect;
import net.indivision.tween.Motion;
/**
* Creates and moves a mask over or away from an Object.
*/
class net.indivision.effect.MaskWipe extends TweenEffect
{
	private var mask:MovieClip;
	private var isIn:Boolean;
	private var _direction:String = "in";
	private var _side:String = "left";
	public function MaskWipe()
	{
		super();
	}
	/**
	* Applies the wipe to an Object.
	* @param target Object to apply Wipe to.
	* @param directionValue (optional) direction wipe will go. Can be "in" or "out".
	* @param sideValue side wipe will come in or go out from. Can be "left", "topLeft", "top", "topRight", "right", "bottomRight", "bottom" or "bottomLeft".
	*/
	public function apply(target:Object, directionValue:String, sideValue:String):Void
	{
		direction = directionValue;
		side = sideValue;
		if (mask == undefined) {
			mask = target._parent["__MotionMask_" + target._name];
			if (mask == undefined) {
				mask = target._parent.createEmptyMovieClip("__MotionMask_" + target._name, target._parent.getNextHighestDepth());
			}
		}
		super.apply(mask);
		if (direction == "in") {
			moveIn(target);
		} else {
			moveOut(target);
		}
	}
	/**
	* Stop current Wipe.
	*/
	public function stop():Void
	{
		mask.clear();
		if (isIn) {
			target.setMask(null);
		}
		super.stop();
	}
	private function init(t:Object):Object
	{
		var rs = new RectangleShape(mask, t._width, t._height);
		var r = rs.draw();
		mask._alpha = 0;
		t.setMask(mask);
		Align.left([t, mask]);
		Align.top([t, mask]);
		return {x:mask._x, y:mask._y};
	}
	private function startMove(x:Number, y:Number):Void
	{
		propertyTween.moveTo(x, y);
	}
	private function moveIn(t:Object):Void
	{
		isIn = true;
		var point = init(t);
		Position.place(t, mask, side);
		startMove(point.x, point.y);
	}
	private function moveOut(t:Object):Void
	{
		isIn = false;
		var startPoint = init(t);
		Position.place(t, mask, side);
		var point = {x:mask._x, y:mask._y};
		mask._x = startPoint.x;
		mask._y = startPoint.y;
		startMove(point.x, point.y);
	}
	/**
	* @param directionValue direction wipe will go. Can be "in" or "out".
	*/
	public function set direction(directionValue:String):Void
	{
		if (directionValue) {
			_direction = directionValue.toLowerCase();
		}
	}
	/**
	* @return direction wipe will go ("in" by default).
	*/
	public function get direction():String
	{
		return _direction;
	}
	/**
	* @param sideValue side wipe will come in or go out from. Can be "left", "topLeft", "top", "topRight", "right", "bottomRight", "bottom" or "bottomLeft".
	*/
	public function set side(sideValue:String):Void
	{
		if (sideValue) {
			_side = sideValue.toLowerCase();
		}
	}
	/**
	* @return side wipe will come in or go out from ("left" by default).
	*/
	public function get side():String
	{
		return _side;
	}
}

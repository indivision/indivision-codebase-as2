import net.indivision.shape.RectangleShape;
import net.indivision.arrange.Position;
import net.indivision.arrange.Align;
import net.indivision.effect.TweenEffect;
import net.indivision.tween.Motion;
/**
* Creates a mask for an Object and then moves that Object out of or into the masked region.
*/
class net.indivision.effect.Reveal extends TweenEffect
{
	private var mask:MovieClip;
	private var isIn:Boolean;
	private var _direction:String = "in";
	private var _side:String = "left";
	private var startPoint:Object;
	/**
	* @param motion Motion to apply to tween.
	* @param targetMask (optional) Mask to use for the reveal. Generates square if parameter omitted.
	*/
	public function Reveal(Void)
	{
		super();
	}
	/**
	* Applies the reveal to an Object.
	* @param target Object to apply reveal to.
	* @param directionValue (optional) direction reveal will go. Can be "in" or "out".
	* @param sideValue side reveal will come in or go out from. Can be "left", "topLeft", "top", "topRight", "right", "bottomRight", "bottom" or "bottomLeft".
	*/
	public function apply(target:Object, directionValue:String, sideValue:String):Void
	{
		resetPosition();
		direction = directionValue;
		side = sideValue;
		if (mask == undefined) {
			mask = target._parent.createEmptyMovieClip("__MotionMask_" + target._name, target._parent.getNextHighestDepth());
		}
		super.apply(target);
		if (direction == "in") {
			moveIn(target);
		} else {
			moveOut(target);
		}
	}
	private function init(t:Object):Object
	{
		//
		var rs = new RectangleShape(mask, t._width, t._height);
		var r = rs.draw();
		mask._alpha = 0;
		t.setMask(mask);
		var sx = t._x;
		var sy = t._y;
		Align.left([t, mask]);
		Align.top([t, mask]);
		return {x:sx, y:sy};
	}
	private function startMove(x:Number, y:Number):Void
	{
		propertyTween.moveTo(x, y);
	}
	private function moveIn(t:Object):Void
	{
		isIn = true;
		startPoint = init(t);
		Position.place(mask, t, side);
		startMove(startPoint.x, startPoint.y);
	}
	private function moveOut(t:Object):Void
	{
		isIn = false;
		startPoint = init(t);
		Position.place(mask, t, side);
		var point = {x:t._x, y:t._y};
		t._x = startPoint.x;
		t._y = startPoint.y;
		startMove(point.x, point.y);
	}
	private function stop():Void
	{
		if (isIn) {
			target.setMask(null);
		}
		resetPosition();
		super.stop();
	}
	private function resetPosition():Void
	{
		target._x = startPoint.x;
		target._y = startPoint.y;
	}
	/**
	* @param directionValue direction reveal will go. Can be "in" or "out".
	*/
	public function set direction(directionValue:String):Void
	{
		if (directionValue) {
			_direction = directionValue.toLowerCase();
		}
	}
	/**
	* @return direction reveal will go ("in" by default).
	*/
	public function get direction():String
	{
		return _direction;
	}
	/**
	* @param sideValue side reveal will come in or go out from. Can be "left", "topLeft", "top", "topRight", "right", "bottomRight", "bottom" or "bottomLeft".
	*/
	public function set side(sideValue:String):Void
	{
		if (sideValue) {
			_side = sideValue.toLowerCase();
		}
	}
	/**
	* @return side reveal will come in or go out from ("left" by default).
	*/
	public function get side():String
	{
		return _side;
	}
}

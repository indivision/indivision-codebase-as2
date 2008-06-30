import net.indivision.shape.AbstractShape;
import net.indivision.arrange.Boundary;
/**
* Adjusts a Shape so that its size matches the extents of a target MovieClip.
*/
class net.indivision.shape.Backdrop
{
	private function Backdrop()
	{
	}
	/**
	* Adjusts shape size and postion to match the extents and position of the target.
	* @param shape the Shape to adjust.
	* @param target the MovieClip to adjust size to.
	* @param margin (optional) additional amount of margin to include in sizing the shape.
	*/
	public static function create(shape:AbstractShape, target:MovieClip, margin:Number):Void
	{
		if (margin == undefined) {
			margin = 0;
		}
		shape.x = Boundary.getValue("left", target) - margin;
		shape.y = Boundary.getValue("top", target) - margin;
		shape.width = target._width + (margin * 2);
		shape.height = target._height + (margin * 2);
		shape.draw();
	}
}

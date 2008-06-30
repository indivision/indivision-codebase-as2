import net.indivision.shape.LineStyle;
import net.indivision.shape.FillStyle;
/**
* A dataclass used to define and store fill and line styles.
*/
class net.indivision.shape.ShapeStyle
{
	/**
	* The LineStyle to apply to a target MovieClip.
	* @see net.indivision.shape.LineStyle
	*/
	public var lineStyle:LineStyle;
	/**
	* The ShapeStyle to apply to a target MovieClip.
	* @see net.indivision.shape.ShapeStyle
	*/
	public var fillStyle:FillStyle;
	/**
	* @param line The LineStyle to apply to a target MovieClip.
	* @param fill The ShapeStyle to apply to a target MovieClip.
	* @see net.indivision.shape.LineStyle
	* @see net.indivision.shape.ShapeStyle
	*/
	public function ShapeStyle(line:LineStyle, fill:FillStyle)
	{
		if (line) {
			lineStyle = line;
		} else {
			lineStyle = new LineStyle();
		}
		if (fill) {
			fillStyle = fill;
		} else {
			fillStyle = new FillStyle();
		}
	}
	/**
	* Applies the lineStyle and fillStyle to a target MovieClip.
	* @param target the MovieClip to affect. Usually a derivative of AbstractShape.
	* @see net.indivision.shape.AbstractShape
	* @see net.indivision.shape
	*/
	public function apply(target:MovieClip):Void
	{
		lineStyle.apply(target);
		fillStyle.apply(target);
	}
}

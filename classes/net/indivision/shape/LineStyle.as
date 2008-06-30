/**
* A dataclass used to define and store line styles.
*/
class net.indivision.shape.LineStyle
{
	/**
	* Value used to set the width of a target shape's lines.
	*/
	public var width:Number = null;
	/**
	* Hex value used to set the line color of a target shape.
	*/
	public var rgb:Number = 0x000000;
	/**
	* Value used to set the alpha of a target shape's lines.
	*/
	public var alpha:Number = 100;
	/**
	* @param width (optional) Value used to set the width of a target shape's lines.
	* @param rgb (optional) Hex value used to set the line color of a target shape.
	* @param alpha (optional) Value used to set the alpha of a target shape's lines.
	*/
	public function LineStyle(width:Number, rgb:Number, alpha:Number)
	{
		if (width != undefined) {
			this.width = width;
		}
		if (rgb != undefined) {
			this.rgb = rgb;
		}
		if (alpha != undefined) {
			this.alpha = alpha;
		}
	}
	/**
	* Applies the rgb, alpha and width to a target shape's lines.
	* @param target the MovieClip to affect. Usually a derivative of AbstractShape.
	* @see net.indivision.shape.AbstractShape
	* @see net.indivision.shape
	*/
	public function apply(target:MovieClip):Void
	{
		target.lineStyle(width, rgb, alpha);
	}
}

/**
* A dataclass used to define and store fill styles.
*/
class net.indivision.shape.FillStyle
{
	/**
	* Hex value used to set the fill color of a target shape.
	*/
	public var rgb:Number = 0x000000;
	/**
	* Value used to set the alpha of a target shape's fill.
	*/
	public var alpha:Number = 100;
	/**
	* @param rgb (optional) Hex value used to set the fill color of a target shape.
	* @param alpha (optional) Value used to set the alpha of a target shape's fill.
	*/
	public function FillStyle(rgb:Number, alpha:Number)
	{
		if (rgb != undefined) {
			this.rgb = rgb;
		}
		if (alpha != undefined) {
			this.alpha = alpha;
		}
	}
	/**
	* Applies the rgb and alpha to a target shape's fill.
	* @param target the MovieClip to affect. Usually a derivative of AbstractShape.
	* @see net.indivision.shape.AbstractShape
	* @see net.indivision.shape
	*/
	public function apply(target:MovieClip):Void
	{
		target.beginFill(rgb, alpha);
	}
}

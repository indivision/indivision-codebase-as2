import net.indivision.shape.AbstractShape;
/**
* Draws a rectangle.
*/
class net.indivision.shape.RectangleShape extends AbstractShape
{
	/**
	* @param movieClip the MovieClip to draw the shape in.
	* @param w width of rectangle.
	* @param h height of rectangle.
	* @param xPosition the x position to start the draw at.
	* @param yPosition the y position to start the draw at.
	*/
	public function RectangleShape(movieClip:MovieClip, w:Number, h:Number, xPosition:Number, yPosition:Number)
	{
		super();
		target = movieClip;
		width = w;
		height = h;
		if (xPosition) {
			x = xPosition;
		} else {
			x = 0;
		}
		if (yPosition) {
			y = yPosition;
		} else {
			y = 0;
		}
	}
	/**
	* Draws the rectangle.
	* @param doClear determines whether or not previous drawings are cleared in the target before drawing the rectangle.
	*/
	public function draw(doClear:Boolean):Void
	{
		if (doClear != false) {
			mc.clear();
		}
		mc.moveTo(x, y);
		_shapeStyle.apply(mc);
		mc.lineTo(x + width, y);
		mc.lineTo(x + width, y + height);
		mc.lineTo(x, y + height);
		mc.lineTo(x, y);
		mc.endFill();
	}
}

import net.indivision.shape.ShapeStyle;
import net.indivision.shape.FillStyle;
import net.indivision.shape.LineStyle;
/**
* Abstract class for shapes, containing x, y, width and height properties. Contains method for applying ShapeStyle to shape.
*/
class net.indivision.shape.AbstractShape
{
	/**
	* x position for shape to be drawn.
	*/
	public var x:Number = 0;
	/**
	* y position for shape to be drawn.
	*/
	public var y:Number = 0;
	/**
	* width for shape to be drawn.
	*/
	public var width:Number = 100;
	/**
	* height for shape to be drawn.
	*/
	public var height:Number = 100;
	private var mc:MovieClip;
	private var _shapeStyle:ShapeStyle;
	public function AbstractShape(Void)
	{
		super();
		shapeStyle = new ShapeStyle(new LineStyle(), new FillStyle());
	}
	/**
	* Abstract Function, meant to be over-loaded by shape specific method.
	*/
	public function draw():Void
	{
	}
	/**
	* ShapeStyle to apply to target.
	* @see net.indivision.shape.ShapeStyle
	*/
	public function set shapeStyle(style:ShapeStyle):Void
	{
		if (style) {
			_shapeStyle = style;
		}
	}
	/**
	* MovieClip to draw shape in.
	*/
	public function set target(movieClip:MovieClip):Void
	{
		if (movieClip) {
			mc = movieClip;
		}
	}
}

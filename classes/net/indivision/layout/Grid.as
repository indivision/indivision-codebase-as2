import net.indivision.arrange.Align;
import net.indivision.arrange.Distribute;
import net.indivision.layout.AbstractLayout;
/**
* Arranges a series of Objects in an array into a grid. Grid is scaleable depending on which parameter (width or height) is designated last.
*/
class net.indivision.layout.Grid extends AbstractLayout
{
	/**
	* The amount of space in pixels to place between Objects.
	*/
	public var spacing:Number = 0;
	private var _width:Number = 3;
	private var _height:Number = 0;
	public function Grid()
	{
	}
	/**
	* Arranges the array of Objects into a grid.
	* @param array the Array of Objects to be arranged.
	*/
	public function arrange(array:Array):Void
	{
		super.arrange(array);
		var i:Number;
		var a, b, c, d, e;
		if (_width > 0) {
			a = "horizontal";
			b = "verticalSpacing";
			c = "vertical";
			d = "horizontalSpacing";
			e = _width;
		} else {
			a = "vertical";
			b = "horizontalSpacing";
			c = "horizontal";
			d = "verticalSpacing";
			e = _height;
		}
		var r;
		var subList = [];
		for (i = 0; i < array.length; i += e) {
			subList.push(array[i]);
		}
		Align[a](subList);
		Distribute[b](subList, spacing);
		for (i = 0; i < array.length; i += e) {
			r = array.slice(i, i + e);
			Align[c](r);
			Distribute[d](r, spacing);
		}
	}
	/**
	* @param w the number of columns to use for the grid.
	*/
	public function set width(w:Number):Void
	{
		_width = w;
		_height = 0;
	}
	/**
	* @param h the number of rows to use for the grid.
	*/
	public function set height(h:Number):Void
	{
		_height = h;
		_width = 0;
	}
}

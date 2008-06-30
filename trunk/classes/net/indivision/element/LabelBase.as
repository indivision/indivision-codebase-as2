import net.indivision.core.AbstractMovieClip;
import net.indivision.shape.AbstractShape;
import net.indivision.shape.ShapeStyle;
import net.indivision.shape.LineStyle;
import net.indivision.shape.FillStyle;
import net.indivision.shape.RectangleShape;
import mx.utils.Delegate;
/**
* Creates and manages a textfield and backdrop.
*/
class net.indivision.element.LabelBase extends AbstractMovieClip
{
	/**
	* Creates and manages a textfield and backdrop.
	*/
	public static var defaults:Array = [{property:"selectable", value:false}, {property:"autoSize", value:true}];
	private var _textField:TextField;
	private var _backdrop:AbstractShape;
	private var _backdropMC:MovieClip;
	private var _margin:Number = 2;
	private var __width:Number = null;
	private var __height:Number = null;
	/**
	* @param target the MovieClip location to draw the label in.
	*/
	public function LabelBase(target:MovieClip)
	{
		super();
		_mc = target;
		init();
	}
	/**
	* @param newTextFormat a new TextFormat for the label.
	* @see TextFormat
	*/
	public function setTextFormat(newTextFormat:TextFormat):Void
	{
		textField.setTextFormat(newTextFormat);
		refresh();
	}
	/**
	* Alters the current TextFormat without changing other settings.
	* @param property property to affect as a String (ie. "font").
	* @param value value to set property to.
	*/
	public function alterFormat(property:String, value:Object):Void
	{
		var format = textField.getTextFormat();
		format[property] = value;
		textField.setTextFormat(format);
		refresh();
	}
	private function init():Void
	{
		_backdropMC = mc.createEmptyMovieClip("__backdrop", 1);
		mc.createTextField("__textField", 2, 0, 0, 0, 0);
		_textField = mc.__textField;
		for (var i in defaults) {
			_textField[defaults[i].property] = defaults[i].value;
		}
		var r = new RectangleShape();
		r.shapeStyle = new ShapeStyle(new LineStyle(0, 0x000000, 100), new FillStyle(0xFFFFFF, 100));
		backdrop = r;
	}
	private function refresh():Void
	{
		sizeTextField();
		sizeBackdrop();
	}
	private function sizeBackdrop():Void
	{
		var nw = textField._width + (margin * 2) - 1;
		var nh = textField._height + (margin * 2) - 1;
		if (width != null) {
			nw = width;
		}
		if (height != null) {
			nh = height;
		}
		//        
		_backdrop.width = nw;
		_backdrop.height = nh;
		_backdrop.draw();
	}
	private function sizeTextField():Void
	{
		textField._x = _margin;
		textField._y = _margin;
		if (width != null) {
			textField._width = width - (margin * 2) + 1;
		}
		if (height != null) {
			textField._height = height - (margin * 2);
		}
	}
	/**
	* @return a reference to the TextField object containing the label copy.
	*/
	public function get textField():TextField
	{
		return _textField;
	}
	/**
	* @param newTextFormat a new TextFormat for the label.
	* @see TextFormat
	*/
	public function set textFormat(newTextFormat:TextFormat):Void
	{
		setTextFormat(newTextFormat);
	}
	/**
	* @param shape an AbstractShape to use as backdrop for the label.
	* @see net.indivision.shape.Shape
	*/
	public function set backdrop(shape:AbstractShape):Void
	{
		_backdrop = shape;
		_backdrop.target = _backdropMC;
		refresh();
	}
	/**
	* @param text the text to populate the label.
	*/
	public function set label(text:String):Void
	{
		textField.text = text;
		refresh();
	}
	/**
	* @return label text.
	*/
	public function get label():String
	{
		return textField.text;
	}
	/**
	* Changes width of label.
	* @param newWidth new label width.
	*/
	public function set width(newWidth:Number):Void
	{
		__width = newWidth;
		textField.autoSize = false;
		refresh();
	}
	/**
	* @return current width of label.
	*/
	public function get width():Number
	{
		return __width;
	}
	/**
	* Changes height of label.
	* @param newHeight new label height.
	*/
	public function set height(newHeight:Number):Void
	{
		__height = newHeight;
		textField.autoSize = false;
		refresh();
	}
	/**
	* @return current height of label.
	*/
	public function get height():Number
	{
		return __height;
	}
	/**
	* Determines the size of the margin created by the backdrop, surrounding the label text.
	* @param size the Number of pixels to extend the label away from the text.
	*/
	public function set margin(size:Number):Void
	{
		_margin = size;
		refresh();
	}
	/**
	* @return the current margin created by the backdrop, surrounding the label text.
	*/
	public function get margin():Number
	{
		return _margin;
	}
	/**
	* @param newShapeStyle new ShapeStyle to apply to the backdrop states.
	* @see net.indivision.shape
	*/
	public function set shapeStyle(newShapeStyle:ShapeStyle):Void
	{
		_backdrop.shapeStyle = newShapeStyle;
		_backdrop.draw();
	}
}

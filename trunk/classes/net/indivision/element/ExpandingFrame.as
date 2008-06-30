import net.indivision.core.MovieClipDispatcher;
import net.indivision.arrange.Distribute;
import net.indivision.arrange.Align;
import mx.utils.Delegate;
/**
* Stretches and moves a collection of movieclips to create a sizeable frame with consistently proportioned corners. Requires specific movieclip structure. See sample flas.
* @todo Modify properties to reflect regular MovieClip properties (_height, _width, etc.) in order to more easily implement in other systems.
*/
class net.indivision.element.ExpandingFrame extends MovieClipDispatcher
{
	private var topLeft:MovieClip;
	private var top:MovieClip;
	private var topRight:MovieClip;
	private var right:MovieClip;
	private var bottomRight:MovieClip;
	private var bottom:MovieClip;
	private var bottomLeft:MovieClip;
	private var left:MovieClip;
	private var backdrop:MovieClip;
	public function ExpandingFrame()
	{
		super();
	}
	/**
	* Resizes the frame.
	* @param width the width to resize to.
	* @param height the height to resize to.
	*/
	public function reSize(width:Number, height:Number):Void
	{
		update(width, height);
	}
	private function update(w:Number, h:Number):Void
	{
		//
		top._width = w - (topLeft._width + topRight._width);
		right._height = h - (topRight._height + bottomRight._height);
		bottom._width = w - (bottomRight._width + bottomLeft._width);
		left._height = h - (bottomLeft._height + topLeft._height);
		backdrop._width = w;
		backdrop._height = h;
		//
		Distribute.horizontalSpacing([topLeft, top, topRight]);
		Distribute.verticalSpacing([topRight, right, bottomRight]);
		Distribute.horizontalSpacing([bottomLeft, bottom, bottomRight]);
		Distribute.verticalSpacing([topLeft, left, bottomLeft]);
		//
		Align.right([topRight, right, bottomRight, backdrop]);
		Align.bottom([bottomLeft, bottom, bottomRight, backdrop]);
	}
}

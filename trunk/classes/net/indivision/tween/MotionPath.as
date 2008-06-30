import net.indivision.tween.TweenBase;
import net.indivision.tween.Motion;
import net.indivision.shape.LineStyle;
import com.senocular.Path;
/**
* Moves an Object and/or draws a line along a Path.
*/
class net.indivision.tween.MotionPath extends TweenBase
{
	/**
	* determines whether or not a line is drawn along the path.
	*/
	public var showLine:Boolean;
	/**
	* determines whether or not the target is oriented to the path as it moves along.
	*/
	public var orient:Boolean;
	/**
	* determines whether or not the effect is applied from the beginning or end of the path.
	*/
	public var reverse:Boolean;
	private var mc:MovieClip;
	private var _path:Path;
	private var _line:MovieClip;
	private var _lineStyle:LineStyle;
	private var snap:Boolean;
	private var interupt:Boolean;
	/**
	* determines whether or not the effect is applied from the beginning or end of the path.
	* @param target MovieClip to move along the path.
	* @param path senocular.Path to move target along.
	* @param motion motion to apply to the movement.
	* @param lineMovieClip (optional) where to draw the path line (if any).
	* @param lineStyle (optional) LineStyle definition for the line (if any).
	* @see Path
	*/
	public function MotionPath(target:MovieClip, path:Path, motion:Motion, lineMovieClip:MovieClip, lineStyle:LineStyle)
	{
		super(traverse, motion);
		mc = target;
		_path = path;
		if (lineMovieClip) {
			_line = lineMovieClip;
		} else {
			_line = mc._parent;
		}
		if (lineStyle) {
			_lineStyle = lineStyle;
		} else {
			_lineStyle = new LineStyle(0, 0xFFFFFF, 100);
		}
	}
	private function traverse(z:Number):Void
	{
		if (reverse) {
			z = 1 - z;
		}
		_path.traverse(mc, z, orient);
		if (showLine) {
			_line.clear();
			_lineStyle.apply(_line);
			_path.drawUpTo(_line, z);
		}
	}
}

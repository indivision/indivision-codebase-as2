import net.indivision.arrange.Boundary;
/**
* Aligns a series of Objects from an Array along their center lines or other edges.
*/
class net.indivision.arrange.Align
{
	private function Align()
	{
	}
	/**
	* Aligns an Array of Objects horizontally along their horizontal centers.
	* @param array Array of Objects to align.
	* @param stage (optional) aligns to stage.
	*/
	public static function horizontal(array:Array, stage:MovieClip):Void
	{
		sequence(array, "hcenter", "_x", stage);
	}
	/**
	* Aligns an Array of Objects vertically along their vertical centers.
	* @param array Array of Objects to align.
	* @param stage (optional) aligns to stage.
	*/
	public static function vertical(array:Array, stage:MovieClip):Void
	{
		sequence(array, "vcenter", "_y", stage);
	}
	/**
	* Aligns an Array of Objects along their left-most edges.
	* @param array Array of Objects to align.
	* @param stage (optional) aligns to stage.
	*/
	public static function left(array:Array, stage:MovieClip):Void
	{
		sequence(array, "left", "_x", stage);
	}
	/**
	* Aligns an Array of Objects along their right-most edges.
	* @param array Array of Objects to align.
	* @param stage (optional) aligns to stage.
	*/
	public static function right(array:Array, stage:MovieClip):Void
	{
		//array[0]._x -= array[0]._width;
		sequence(array, "right", "_x", stage);
	}
	/**
	* Aligns an Array of Objects along their top-most edges.
	* @param array Array of Objects to align.
	* @param stage (optional) aligns to stage.
	*/
	public static function top(array:Array, stage:MovieClip):Void
	{
		sequence(array, "top", "_y", stage);
	}
	/**
	* Aligns an Array of Objects along their bottom-most edges.
	* @param array Array of Objects to align.
	* @param stage (optional) aligns to stage.
	*/
	public static function bottom(array:Array, stage:MovieClip):Void
	{
		sequence(array, "bottom", "_y", stage);
	}
	private static function sequence(array:Array, a:String, b:String, stage:MovieClip):Void
	{
		if (stage) {
			array.unshift(stage);
		}
		var line:Number = array[0][b] + Boundary.getValue(a, array[0]);
		var i:Number;
		for (i = 1; i < array.length; i++) {
			var point:Number = Boundary.getValue(a, array[i]);
			array[i][b] = Math.ceil(line - point);
		}
		if (stage) {
			array.shift();
		}
	}
}

/**
* Evenly distributes a series of Objects in an Array putting a definable amount of space between each Object.
* @todo Fix horizontal and vertical methods to account for MovieClips that may not be justified to x:0, y:0.
*/
class net.indivision.arrange.Distribute
{
	private function Distribute()
	{
	}
	/**
	* Evenly distributes an Array of Objects horizontally.
	* @param array Array of Objects to distribute.
	*/
	public static function horizontal(array:Array):Void
	{
		range(array, "_x");
	}
	/**
	* Evenly distributes an Array of Objects vertically.
	* @param array Array of Objects to distribute.
	*/
	public static function vertical(array:Array):Void
	{
		range(array, "_y");
	}
	/**
	* Distributes an Array of Objects horizontally with a designated amount of space between each Object.
	* @param array Array of Objects to distribute.
	* @param spacing (optional) amount of space to divide Objects in pixels.
	* @param reverse (optional) if true, Objects are distributed from the initial Object left rather than left to right. This is useful for right-justified lists.
	*/
	public static function horizontalSpacing(array:Array, spacing:Number, reverse:Boolean):Void
	{
		sequence(array, "_x", "_width", spacing, reverse);
	}
	/**
	* Distributes an Array of Objects vertically with a designated amount of space between each Object.
	* @param array Array of Objects to distribute.
	* @param spacing (optional) amount of space to divide Objects in pixels.
	* @param reverse (optional) if true, Objects are distributed from the initial Object up rather than top down. This is useful for bottom-justified lists.
	*/
	public static function verticalSpacing(array:Array, spacing:Number, reverse:Boolean):Void
	{
		sequence(array, "_y", "_height", spacing, reverse);
	}
	/**
	* Applies the height of the first Object in the Array to all Objects.
	* @param array Array of Objects to affect.
	*/
	public static function height(array:Array):Void
	{
		sequence(array, "_height", "null");
	}
	/**
	* Applies the width of the first Object in the Array to all Objects.
	* @param array Array of Objects to affect.
	*/
	public static function width(array:Array):Void
	{
		sequence(array, "_width", "null");
	}
	private static function sequence(array:Array, a:String, b:String, spacing:Number, reverse:Boolean):Void
	{
		if (spacing == undefined) {
			spacing = 0;
		}
		var i:Number;
		for (i = 1; i < array.length; i++) {
			var aobj = array[i];
			var bobj = array[i - 1];
			var pad = 0;
			var abounds = aobj.getBounds();
			var bbounds = bobj.getBounds();
			if (b == "_height") {
				var fa = aobj._yscale / 100;
				var fb = bobj._yscale / 100;
				pad = (bbounds.yMin * fb) - (abounds.yMin * fa);
			} else if (b == "_width") {
				var fa = aobj._xscale / 100;
				var fb = bobj._xscale / 100;
				pad = (bbounds.xMin * fb) - (abounds.xMin * fa);
			}
			aobj[a] = bobj[a] + pad;
			if (bobj[b] != undefined) {
				if (reverse) {
					aobj[a] -= aobj[b] + spacing;
				} else {
					aobj[a] += bobj[b] + spacing;
				}
			}
		}
	}
	private static function range(array:Array, a:String):Void
	{
		// NOTE: Should be able to cover todo by implementing getBounds here.
		var step:Number = (array[array.length - 1][a] - array[0][a]) / (array.length - 1);
		var i:Number;
		for (i = 1; i < array.length - 1; i++) {
			array[i][a] = array[0][a] + (i * step);
		}
	}
}

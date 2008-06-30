import net.indivision.operation.Iteration;
/**
* Abstract class for comparison operations.
*/
class net.indivision.operation.AbstractAnalysis
{
	private static var val:Number;
	private static var item:Object;
	private static var count:Number;
	private function AbstractAnalysis()
	{
	}
	private static function find(f:Function, a:Array, p:String):Void
	{
		init(a, p);
		Iteration.apply(f, a, [p]);
	}
	private static function init(a:Array, p:String)
	{
		val = qualify(a[0], p);
		item = a[0];
		count = 0;
	}
	private static function isHigher(t:Object, i:Number, p:String)
	{
		if (qualify(t, p) > val) {
			val = qualify(t, p);
			item = t;
			count = i;
		}
	}
	private static function isLower(t:Object, i:Number, p:String)
	{
		if (qualify(t, p) < val) {
			val = qualify(t, p);
			item = t;
			count = i;
		}
	}
	private static function qualify(t:Object, p:String):Number
	{
		if (p === undefined) {
			if (typeof (t) == "number") {
				return Number(t);
			} else {
				return null;
			}
		} else {
			return t[p];
		}
	}
}

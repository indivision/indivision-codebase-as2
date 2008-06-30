/**
* Methods for running consistent hit-tests on Objects that may exist on any MovieClips coordinate plane.
*/
class net.indivision.util.GlobalHitTest
{
	private function GlobalHitTest()
	{
	}
	/**
	* Tests whether or not the mouse is currently over a target Object.
	* @param target the Object to run the hit-test on.
	* @return true if the mouse is over the target. false if it is not.
	*/
	public static function testMouse(target:Object):Boolean
	{
		return testPoint(target, target._parent._xmouse, target._parent._ymouse);
	}
	/**
	* Tests whether or not a designated point is currently over a target Object.
	* @param target the Object to run the hit-test on.
	* @param x the x coordinate for the test point.
	* @param y the y coordinate for the test point.
	* @return true if the point is over the target. false if it is not.
	*/
	public static function testPoint(target:Object, x:Number, y:Number):Boolean
	{
		var point = {x:x, y:y};
		target._parent.localToGlobal(point);
		var ht = target.hitTest(point.x, point.y, true);
		if (!ht) {
			return false;
		} else {
			return true;
		}
	}
}

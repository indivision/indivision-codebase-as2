import mx.events.EventDispatcher;
/**
* Alternative to onEnterFrameBeacon. Works the same but uses event dispatcher rather than BroadcasterMX.
*/
class net.indivision.event.FrameEventBeacon
{
	/**
	* Initializes EventDispatcher on _global.MovieClip and starts dispatching events on onEnterFrame.
	* Add listeners via {@code _global.MovieClip.addEventListener("onEnterFrame", yourListener);}
	* @see mc.events.EventDispatcher
	*/
	public static function initialize()
	{
		var gmc = _global.MovieClip;
		if (!_root.__FrameEventBeacon) {
			EventDispatcher.initialize(gmc);
			var mc = _root.createEmptyMovieClip("__FrameEventBeacon", _root.getNextHighestDepth());
			mc.onEnterFrame = function()
			{
				_global.MovieClip.dispatchEvent({type:"onEnterFrame"});
			};
		}
	}
}

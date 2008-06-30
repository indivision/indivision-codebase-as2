import net.indivision.core.AbstractDispatcher;
import mx.utils.Delegate;
/**
* A loader that includes a system for determining bandwidth that is progressively more accurate, the more content is loaded through the class.
* @event onProgress Broadcast whenever bytes are loaded.
* @event onComplete Broadcast when load is complete.
* @event onInit Broadcast when load is complete and the loaded Object is initialized (generally after one frame).
*/
class net.indivision.load.PerformanceLoader extends AbstractDispatcher
{
	private var _target:MovieClip;
	private var _url:String;
	private var time:Number;
	private var last:Number;
	private var _elapsed:Number = 0;
	private var _total:Number = 0;
	private var loader:Object;
	/**
	* @param targetURL the URL of the content to load.
	* @param targetMovieClip the MovieClip to load to.
	*/
	public function PerformanceLoader()
	{
		loader = new MovieClipLoader();
		loader.onLoadProgress = Delegate.create(this, progress);
		loader.onLoadComplete = Delegate.create(this, complete);
		loader.onLoadInit = Delegate.create(this, init);
		loader.onLoadStart = Delegate.create(this, reset);
	}
	/**
	* Designates a new url and target MovieClip and starts load.
	* @param targetURL the URL of the content to load.
	* @param targetMovieClip the MovieClip to load to.
	*/
	public function load(targetURL:String, targetMovieClip:MovieClip):Boolean
	{
		url = targetURL;
		target = targetMovieClip;
		return start();
	}
	/**
	* Start loading.
	*/
	public function start():Boolean
	{
		return loader.loadClip(url, target);
	}
	private function reset():Void
	{
		last = 0;
		time = getTimer();
	}
	private function progress():Void
	{
		record();
		dispatchEvent({type:"onProgress", target:this});
	}
	private function complete():Void
	{
		dispatchEvent({type:"onComplete", target:this});
	}
	private function init():Void
	{
		dispatchEvent({type:"onInit", target:this});
	}
	private function record():Void
	{
		_elapsed += (getTimer() - time);
		time = getTimer();
		_total += (target.getBytesLoaded() - last);
		last = target.getBytesLoaded();
	}
	/**
	* @param targetMovieClip the MovieClip to load to.
	*/
	public function set target(targetMovieClip:MovieClip):Void
	{
		if (targetMovieClip) {
			_target = targetMovieClip;
		}
	}
	/**
	* @return the current target.
	*/
	public function get target():MovieClip
	{
		return _target;
	}
	/**
	* @param targetURL the URL of the content to load.
	*/
	public function set url(targetURL:String):Void
	{
		if (targetURL) {
			_url = targetURL;
		}
	}
	/**
	* @return the current URL.
	*/
	public function get url():String
	{
		return _url;
	}
	/**
	* @return a Number between 0 and 1 representing the amount of bytes loaded.
	*/
	public function get loaded():Number
	{
		return target.getBytesLoaded() / target.getBytesTotal();
	}
	/**
	* @return a Number between 0 and 100 representing the amount of bytes loaded.
	*/
	public function get percentage():Number
	{
		return loaded * 100;
	}
	/**
	* @return the estimated bandwidth in bytes per second.
	*/
	public function get bytes():Number
	{
		return _total / _elapsed;
	}
	/**
	* @return the total number of all bytes loaded.
	*/
	public function get total():Number
	{
		return _total;
	}
	/**
	* @return the total amount of time spent on all loading.
	*/
	public function get elapsed():Number
	{
		return _elapsed;
	}
}

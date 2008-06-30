import net.indivision.core.AbstractDispatcher;
import net.indivision.load.PerformanceLoader;
import mx.utils.Delegate;
/**
* Loads a series of items from an Array in order.
* @event onLoadStart
* @event onLoadProgress
* @event onLoadComplete
*/
class net.indivision.load.LoadQueue extends AbstractDispatcher
{
	private var _loader:PerformanceLoader;
	private var _list:Array;
	private var _position:Number;
	private var _target:MovieClip;
	private var _path:String = "";
	public function LoadQueue(Void)
	{
		super();
		_loader = new PerformanceLoader();
		loader.addEventListener("onInit", Delegate.create(this, advance));
		loader.addEventListener("onProgress", Delegate.create(this, progress));
	}
	/**
	* Incomplete.
	*/
	public function addItem(i:Object):Void
	{
	}
	/**
	* Sets a new Array (if supplied) and starts loading.
	* @param urlArray (optional) an Array of URLs to load.
	*/
	public function start(urlArray:Array):Void
	{
		if (urlArray) {
			list = urlArray;
		}
		startLoad();
	}
	/**
	* Incomplete.
	*/
	public function stop():Void
	{
	}
	private function advance(event:Object):Void
	{
		_position++;
		if (_position < _list.length) {
			startLoad();
		} else {
			dispatchEvent({type:"onLoadComplete", target:this});
			_target.__LoadQueueHolder.unloadMovie();
		}
	}
	private function progress(event:Object):Void
	{
		dispatchEvent({type:"onLoadProgress", target:this});
	}
	private function startLoad():Void
	{
		dispatchEvent({type:"onLoadStart", target:this});
		_target.createEmptyMovieClip("__LoadQueueHolder", _target.getNextHighestDepth());
		loader.load(_path + _list[_position], _target.__LoadQueueHolder);
	}
	/**
	* @param urlArray an Array of URLs to load.
	*/
	public function set list(urlArray:Array):Void
	{
		_list = urlArray;
		_position = 0;
	}
	/**
	* @return the current Array of URLs to load.
	*/
	public function get list():Array
	{
		return _list;
	}
	/**
	* @param targetMovieClip the MovieClip to load to.
	*/
	public function set target(targetMovieClip:MovieClip):Void
	{
		_target = targetMovieClip;
	}
	/**
	* @return the current target.
	*/
	public function get target():MovieClip
	{
		return _target;
	}
	/**
	* @return the numeric position in the list of the currently loading URL.
	*/
	public function get position():Number
	{
		return _position;
	}
	/**
	* @param newPath a path to append to the front of the file names (blank by default).
	*/
	public function set path(newPath:String):Void
	{
		_path = newPath;
	}
	/**
	* @return the total number of files to load.
	*/
	public function get count():Number
	{
		return list.length;
	}
	/**
	* @return the current filename being loaded.
	*/
	public function get item():Number
	{
		return list[position];
	}
	/**
	* @return a reference to the PerformanceLoader class for retrieving performance values.
	* @see net.indivision.load.PerformanceLoader
	*/
	public function get loader():PerformanceLoader
	{
		return _loader;
	}
}

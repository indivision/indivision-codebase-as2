import net.indivision.core.AbstractDispatcher;
/**
* Abstract class for various media types in media package.
* @event onLoad Broadcasted when load is executed.
* @see net.indivision.media
*/
class net.indivision.media.AbstractMedia extends AbstractDispatcher
{
	private var _target:Object;
	public function AbstractMedia()
	{
	}
	/**
	* @param url URL location of media to load.
	*/
	public function load(url:String):Void
	{
		dispatchEvent({type:"onLoad", target:this});
	}
	/**
	* @return the percent of bytes loaded, represented as a Number between 0 and 1.
	*/
	public function getLoaded():Number
	{
		return target.getBytesLoaded() / target.getBytesTotal();
	}
	/**
	* @param mediaTarget new location of media.
	*/
	public function set target(mediaTarget:Object):Void
	{
		_target = mediaTarget;
	}
	/**
	* @return location of media.
	*/
	public function get target():Object
	{
		return _target;
	}
}

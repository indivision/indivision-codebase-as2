import net.indivision.control.IScrubbable;
import mx.utils.Delegate;
import mx.video.NCManager;
import mx.video.VideoPlayer;
/**
* For handling FLV videos. *** Requires MovieClip 'FLVMedia' available in fla_examples\source\media\FLVMedia\FLVMedia.fla ***
*/
class net.indivision.media.FLVMedia extends VideoPlayer implements IScrubbable
{
	/**
	* Determines whether or not the video plays on load automatically or waits for the play function to execute (true by default).
	*/
	public var doAutoPlay:Boolean = true;
	private var _lastPosition:Number;
	private var _data:Object;
	private var _mute:Number = 0;
	private var _dummy:NCManager;
	public function FLVMedia()
	{
		addEventListener("metadataReceived", Delegate.create(this, capture));
	}
	/**
	* @param url the URL to the FLV to load.
	*/
	public function load(url:String):Void
	{
		if (doAutoPlay) {
			this.play(url);
		} else {
			load(url);
		}
		dispatchEvent({type:"onLoad", target:this});
	}
	/**
	* Plays the video.
	* @param url (optional) the URL to the FLV to load.
	*/
	public function play(url:String):Void
	{
		if (!isPlaying()) {
			super.play(url);
			dispatchEvent({type:"onPlay", target:this});
		}
	}
	/**
	* Stops the video.
	*/
	public function stop():Void
	{
		if (isPlaying()) {
			super.stop();
			dispatchEvent({type:"onStop", target:this});
		}
	}
	/**
	* Pauses the video.
	*/
	public function pause():Void
	{
		if (isPlaying()) {
			super.pause();
			dispatchEvent({type:"onPause", target:this});
		}
	}
	/**
	* toggles mute.
	*/
	public function mute():Void
	{
		if (_mute > 0) {
			volume = _mute;
			_mute = 0;
		} else {
			_mute = volume;
			volume = 0;
		}
	}
	/**
	* @param newPosition the new play position to move the video to as a number between 0 and 1.
	*/
	public function setPosition(newPosition:Number):Void
	{
		_lastPosition = newPosition;
		if (getLoaded() < newPosition) {
			playheadTime = totalTime * getLoaded();
		} else {
			playheadTime = totalTime * newPosition;
		}
		dispatchEvent({type:"onPosition", target:this});
	}
	/**
	* @return the current video play position as a number between 0 and 1.
	*/
	public function getPosition():Number
	{
		if (metadata) {
			return playheadTime / totalTime;
		} else {
			return 0;
		}
	}
	/**
	* @return whether or not the media is playing.
	*/
	public function isPlaying():Boolean
	{
		if (state == PLAYING) {
			return true;
		} else {
			return false;
		}
	}
	/**
	* @return the percent of bytes loaded, represented as a Number between 0 and 1.
	*/
	public function getLoaded():Number
	{
		return bytesLoaded / bytesTotal;
	}
	private function capture():Void
	{
		_data = metadata;
		dispatchEvent({type:"onMetaData", target:this});
	}
	/**
	* @return the video bitrate.
	*/
	public function get bitrate():Number
	{
		return bytesTotal / totalTime;
	}
	/**
	* @return the length of the video in seconds.
	*/
	public function get duration():Number
	{
		if (metadata) {
			return totalTime;
		} else {
			return 0;
		}
	}
	/**
	* @return meta data Object.
	*/
	public function get data():Object
	{
		return _data;
	}
	/**
	* @return the last position navigated to as a number between 0 and 1.
	*/
	public function get lastPosition():Number
	{
		return _lastPosition;
	}
}

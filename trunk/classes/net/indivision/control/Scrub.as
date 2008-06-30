import net.indivision.control.ScrollBar;
import net.indivision.control.IScrubbable;
import net.indivision.event.FrameEventBeacon;
import mx.utils.Delegate;
/**
* A type of ScrollBar designed to work in conjunction with LinearMedia.
* @event onMediaEnd Broadcast when media reaches its end.
* @see net.indivision.media.LinearMedia
*/
class net.indivision.control.Scrub extends ScrollBar
{
	/**
	* Determines whether or not moving the scrub handle updates the position of the media as it is dragged (false by default).
	*/
	public var isUpdatingMedia:Boolean = false;
	private var onEnterFrame:Function = null;
	private var scrubbing:Boolean = false;
	private var interrupt:Boolean = false;
	// NOTE: ReleasePosition of adjusted scrub position must be tracked to check against the current position of the media to eliminate scrub stuttering position as the stream adjusts.
	private var releasePosition:Number;
	private var _trackProgress:Boolean = false;
	private var tracker:Function;
	private var functionStack:Array;
	private var _media:IScrubbable;
	private var _isVideo:Boolean;
	public function Scrub()
	{
		super();
		mc.bar._visible = false;
		handle._visible = false;
		tray.useHandCursor = false;
	}
	private function mediaPlay()
	{
		if (!handle._visible) {
			handle._visible = true;
			tray.useHandCursor = true;
		}
		setTracking(true);
	}
	private function mediaStop()
	{
		setTracking(false);
		position = 0;
	}
	private function mediaPause()
	{
		setTracking(false);
	}
	private function mediaPosition()
	{
		// @kludge: By-passing interface rules because flash interfaces dont support properties (8/2/06)
		position = Object(_media).lastPosition;
	}
	private function getMax():Number
	{
		if (_trackProgress) {
			return (tray._height - getHandleSize()) * _media.getLoaded();
		} else {
			return tray._height - getHandleSize();
		}
	}
	private function updateProgress():Void
	{
		if (_media.getLoaded() == 1) {
			mc.bar._yscale = 100;
			_global.MovieClip.removeEventListener("onEnterFrame", tracker);
		} else {
			mc.bar._yscale = _media.getLoaded() * 100;
			if (mc.bar._yscale > 100) {
				mc.bar._yscale = 100;
			} else if (mc.bar._yscale < 0) {
				mc.bar._yscale = 0;
			}
		}
	}
	private function mediaLoad():Void
	{
		if (_trackProgress) {
			mc.bar._visible = true;
		}
	}
	private function onChangeEvent():Void
	{
		super.onChangeEvent();
		if (scrubbing && isUpdatingMedia) {
			_media.setPosition(position);
		}
	}
	private function setTracking(v:Boolean):Void
	{
		if (v) {
			onEnterFrame = Delegate.create(this, track);
		} else {
			onEnterFrame = null;
		}
	}
	private function track():Void
	{
		if (releasePosition == undefined || Math.abs(_media.getPosition() - releasePosition) < .05) {
			releasePosition = undefined;
			position = _media.getPosition();
		}
		if (_media.getPosition() >= .9999) {
			interrupt = false;
			setTracking(false);
			if (!scrubbing && !_isVideo) {
				mediaComplete();
			}
		}
	}
	private function onHandlePress():Void
	{
		scrubbing = true;
		if (isUpdatingMedia) {
			if (_media.isPlaying) {
				interrupt = true;
			}
			_media.stop();
		}
		setTracking(false);
		super.onHandlePress();
	}
	private function onHandleRelease():Void
	{
		scrubbing = false;
		if (conformPosition()) {
			setTracking(true);
			if (interrupt) {
				_media.play();
				interrupt = false;
			}
		}
		super.onHandleRelease();
	}
	private function onTrayRelease():Void
	{
		super.onTrayRelease();
		conformPosition();
	}
	private function conformPosition():Boolean
	{
		releasePosition = position;
		_media.setPosition(position);
		if (position >= .9999 && !_isVideo) {
			mediaComplete();
			return false;
		}
		return true;
	}
	private function mediaComplete():Void
	{
		interrupt = false;
		setTracking(false);
		releasePosition = undefined;
		// @kludge: By-passing interface rules because flash interfaces dont support properties (8/2/06)
		if (Object(_media).autoRewind != false) {
			position = 0;
		}
		dispatchEvent({type:"onMediaEnd", target:this});
	}
	/**
	* Determines whether or not load progress is tracked.
	* @param trackProgress tracks load progress of media if set to true.
	*/
	public function set isTrackingProgress(trackProgress:Boolean):Void
	{
		_trackProgress = trackProgress;
		if (_trackProgress) {
			FrameEventBeacon.initialize();
			tracker = Delegate.create(this, updateProgress);
			_global.MovieClip.addEventListener("onEnterFrame", tracker);
		} else {
			_global.MovieClip.removeEventListener("onEnterFrame", tracker);
		}
	}
	/**
	* @param scrubbable the IScrubbable media to be affected by Scrub.
	*/
	public function set media(scrubbable:IScrubbable):Void
	{
		var i;
		for (i in functionStack) {
			// @kludge: By-passing interface rules because flash interfaces dont support properties (8/2/06)
			Object(_media).removeEventListener(functionStack[i].type, functionStack[i].event);
		}
		functionStack = [];
		functionStack.push({type:"onPlay", event:Delegate.create(this, mediaPlay)});
		functionStack.push({type:"onPause", event:Delegate.create(this, mediaPause)});
		functionStack.push({type:"onLoad", event:Delegate.create(this, mediaLoad)});
		functionStack.push({type:"onStop", event:Delegate.create(this, mediaStop)});
		functionStack.push({type:"onPosition", event:Delegate.create(this, mediaPosition)});
		functionStack.push({type:"complete", event:Delegate.create(this, mediaComplete)});
		_media = scrubbable;
		// @kludge: Cheap way of determining if media is a video (by seeing if it has a 'version' value.)
		if (Object(_media).version) {
			_isVideo = true;
		} else {
			_isVideo = false;
		}
		for (i in functionStack) {
			// @kludge: By-passing interface rules because flash interfaces dont support properties (8/2/06)
			Object(_media).addEventListener(functionStack[i].type, functionStack[i].event);
		}
	}
}

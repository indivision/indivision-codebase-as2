import net.indivision.media.AbstractMedia;
import mx.utils.Delegate;
/**
* For handling static media (images or swfs).
* @event onLoadComplete Broadcast when media is finished loading.
* @event onProgress Broadcast when progress is made during loading.
*/
class net.indivision.media.StaticMedia extends AbstractMedia
{
	private var loader:Object;
	public function StaticMedia()
	{
		super();
		loader = new MovieClipLoader();
		loader.onLoadInit = Delegate.create(this, onLoadInit);
		loader.onLoadProgress = Delegate.create(this, onLoadProgress);
	}
	private function onLoadInit():Void
	{
		dispatchEvent({type:"onLoadComplete", target:this});
	}
	private function onLoadProgress():Void
	{
		dispatchEvent({type:"onProgress", target:this});
	}
}

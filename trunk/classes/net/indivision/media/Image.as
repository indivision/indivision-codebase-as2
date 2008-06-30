import net.indivision.media.StaticMedia;
/**
* For handling all image media types.
*/
class net.indivision.media.Image extends StaticMedia
{
	public function Image()
	{
		super();
	}
	/**
	* @param url path to image.
	* @param target location to load image in to.
	*/
	public function load(url:String, target:MovieClip):Void
	{
		if (target) {
			this.target = target;
		}
		loader.loadClip(url, target);
		super.load();
	}
}

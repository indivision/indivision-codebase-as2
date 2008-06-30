import net.indivision.core.MovieClipDispatcher;
import net.indivision.data.XMLConstruct;
import mx.utils.Delegate;
/**
* Foundation class for use with projects that load an XML file at start-up.
*/
class net.indivision.project.AbstractXMLProject extends MovieClipDispatcher
{
	private var data:XMLConstruct;
	/**
	* Sets up a data variable and loads an XML file into it. Executes 'dataLoaded' method (intended to be overloaded) upon completion of the XML.
	* @param root the base movieclip for the project (usually 'this' or '_root').
	* @param url path to XML to load.
	*/
	public function AbstractXMLProject(root:MovieClip, url:String)
	{
		super();
		_mc = root;
		data = new XMLConstruct();
		data.addEventListener("onLoad", Delegate.create(this, dataLoaded));
		data.load(url);
	}
	private function dataLoaded():Void
	{
		trace("dataLoaded!");
	}
}

import mx.events.EventDispatcher;
import net.indivision.data.XMLConstructNode;
/**
* A recursive method for converting XML into a dot-syntax / multi-dimensional array structure.
* @event onLoad Broadcast when XML is loaded and parsed.
*/
dynamic class net.indivision.data.XMLConstruct extends XMLConstructNode
{
	/**
	* Executes after XML is loaded and parsed.
	*/
	public var onLoad:Function;
	/**
	* Adds an event listener.
	* @see EventDispatcher
	*/
	public var addEventListener:Function;
	/**
	* Removes an event listener.
	* @see EventDispatcher
	*/
	public var removeEventListener:Function;
	private var dispatchEvent:Function;
	private var rootVal:String = "firstChild";
	/**
	* @param input (optional) parses an XMLNode on class instantiation.
	*/
	public function XMLConstruct(input:XMLNode)
	{
		super();
		EventDispatcher.initialize(this);
		if (input != undefined) {
			parse(input);
		}
	}
	/**
	* Sets the root node of the target XMLNode to start parsing into the XMLConstruct Object ("firstChild" by default). This can be useful to shorten data contained in un-needed XML layers.
	* @param root string representation of XML root path to start parsing ("firstChild" by default).
	*/
	public function setRoot(root:String):Void
	{
		rootVal = root;
	}
	/**
	* Builds multi-dimensional Object from XML and places data on this instance.
	* @param input XML Object or String with XML formatting
	*/
	public function parse(input:XMLNode):Void
	{
		var pXML:XML, pObj:XMLConstructNode, c:String, tArr:Array;
		nodeName = input[rootVal].nodeName;
		pObj = parseNode(input[rootVal], new XMLConstructNode());
		for (c in this) {
			if (this[c] instanceof Array) {
				delete this[c];
			}
		}
		attributes = undefined;
		tArr = [];
		for (c in pObj) {
			if (c == "attributes") {
				for (var a in pObj[c]) {
					addAttribute(a, pObj[c][a]);
				}
			} else {
				tArr.push(c);
			}
		}
		for (c in tArr) {
			this[tArr[c]] = pObj[tArr[c]];
		}
	}
	/**
	* Loads XML file and runs parse on the data upon completion.
	* @param path path to XML file or script returning XML data.
	*/
	public function load(path:String)
	{
		var thisObj:XMLConstruct = this;
		var tXML:XML = new XML();
		tXML.ignoreWhite = true;
		tXML.load(path);
		tXML.onLoad = function(success:Boolean)
		{
			thisObj.parse(tXML);
			thisObj.onLoad(success);
			thisObj.dispatchEvent({type:"onLoad", target:thisObj, success:success});
		};
	}
	private function parseNode(xObj:XMLNode, obj:XMLConstructNode):XMLConstructNode
	{
		var c:String, nName:String, nType:Number, cNode:XMLNode;
		var xa:Object = xObj.attributes;
		for (c in xa) {
			obj.addAttribute(c, xa[c]);
		}
		for (c in xObj.childNodes) {
			cNode = xObj.childNodes[c];
			nName = cNode.nodeName;
			nType = cNode.nodeType;
			if (nType == 3) {
				obj._value = cNode.nodeValue;
			} else if (nType == 1 && nName != null) {
				var sObj = parseNode(cNode, new XMLConstructNode());
				obj.appendChild(nName, sObj);
			}
		}
		return obj;
	}
}

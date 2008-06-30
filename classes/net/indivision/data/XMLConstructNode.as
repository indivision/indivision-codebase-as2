/**
* A data Object element used to build a flash-native representation of XML.
*/
dynamic class net.indivision.data.XMLConstructNode
{
	/**
	* Contains XML node attributes (if any).
	*/
	public var attributes:Object;
	/**
	* Contains XML node text value (if any).
	*/
	public var _value:String;
	private var nodeName:String;
	public function XMLConstructNode()
	{
	}
	/**
	* Appends a child node.
	* @param nodeName name for new node.
	* @param node XMLConstructNode to add.
	*/
	public function appendChild(nodeName:String, node:XMLConstructNode):Void
	{
		if (!(this[nodeName] instanceof Array)) {
			this[nodeName] = [];
			this[nodeName].__resolve = getFirstElement;
			_global.ASSetPropFlags(this[nodeName], "__resolve", 1, 0);
		}
		node.nodeName = nodeName;
		this[nodeName].unshift(node);
		_global.ASSetPropFlags(node, "nodeName", 1, 0);
	}
	/**
	* Adds a string attribute to this node.
	* @param attributeName name for new attribute.
	* @param string string value to add.
	*/
	public function addAttribute(attributeName:String, string:String):Void
	{
		if (attributes == undefined) {
			attributes = {};
		}
		attributes[attributeName] = string;
	}
	/**
	* @return XML representation of this node and all child nodes.
	*/
	public function toXML():XML
	{
		var topXML:XML = new XML(String(toXMLNode()));
		topXML.firstChild.appendChild(parseConstruct(this, new XML()));
		return topXML;
	}
	public function toString():String
	{
		var s = "[XMLConstructNode: " + nodeName + " ]";
		return s;
	}
	private function toXMLNode():XMLNode
	{
		var doc:XML, c:String, textNode:XMLNode, node:XMLNode;
		doc = new XML();
		node = doc.createElement(nodeName);
		for (c in attributes) {
			node.attributes[c] = attributes[c];
		}
		doc.appendChild(node);
		textNode = doc.createTextNode(_value);
		node.appendChild(textNode);
		return node;
	}
	private function getFirstElement(f:String)
	{
		return this[0][f];
	}
	private function parseConstruct(xObj:XMLConstructNode, doc:XML):XML
	{
		var a:String, n:String, aObj:Array, nObj:XMLConstructNode, nName:String, nNode:XMLNode;
		for (a in xObj) {
			aObj = xObj[a];
			if (aObj instanceof Array) {
				for (n in aObj) {
					nObj = aObj[n];
					if (nObj instanceof XMLConstructNode) {
						doc.appendChild(nObj.toXMLNode());
						doc.lastChild.appendChild(parseConstruct(nObj, new XML()));
					}
				}
			}
		}
		return doc;
	}
}

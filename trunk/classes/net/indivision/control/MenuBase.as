import net.indivision.core.MovieClipDispatcher;
import net.indivision.layout.AbstractLayout;
import net.indivision.control.LabelButton;
import net.indivision.layout.Column;
import mx.utils.Delegate;
/**
* Handles a collection of buttons from an array or XMLConstruct source.
* @event onRelease Broadcast when menu item is released.
* @todo Re-work so that it expects a DataProvider rather than an XMLConstruct.
*/
class net.indivision.control.MenuBase extends MovieClipDispatcher
{
	/**
	* The select state that represents the selected menu item.
	* @see net.indivision.control.ButtonBase
	*/
	public var selectedState:Number;
	private var labelField:String = "label";
	private var _lastRelease:Object;
	private var _data:Array;
	private var _items:Array;
	private var _itemClips:Array;
	private var _content:MovieClip;
	private var _itemLayer:MovieClip;
	private var _layout;
	private var attach:String;
	/**
	* @param target the MovieClip to draw the menu in.
	*/
	public function MenuBase(target:MovieClip)
	{
		super();
		_mc = target;
		_layout = new Column();
	}
	/**
	* Draw the menu based on the curent data.
	* @todo Need to clear previous menu movieclips before building new.
	*/
	public function draw():Void
	{
		buildMenu();
	}
	/**
	* Selects a menu item based on its sequential ID (0 being the first item, 1 the second, etc.).
	* @param selectID the sequential ID of the menu item to select.
	*/
	public function select(selectID:Object):Void
	{
		items[selectID].onRelease();
	}
	private function buildMenu():Void
	{
		reset();
		var obj, d, l, customAttach;
		for (var i = 0; i < data.length; i++) {
			d = data[i];
			l = _itemLayer.getNextHighestDepth();
			customAttach = getAttach(d);
			if (customAttach) {
				obj = _itemLayer.attachMovie(customAttach, "item" + l, l);
				obj.label = getTitle(d);
				_itemClips.push(obj);
			} else if (attach) {
				obj = _itemLayer.attachMovie(attach, "item" + l, l);
				obj.label = getTitle(d);
				_itemClips.push(obj);
			} else {
				obj = new LabelButton();
				obj.target = _itemLayer.createEmptyMovieClip("item" + i, l);
				obj.label = d;
				_itemClips.push(obj.mc);
			}
			obj.data = d;
			obj.id = i;
			obj.parent = this;
			obj.addEventListener("onRelease", Delegate.create(this, itemRelease));
			_items.push(obj);
		}
		_layout.arrange(_itemClips);
	}
	private function getAttach(o:Object):String
	{
		if (o.attributes.attach) {
			return o.attributes.attach;
		} else if (o.attach) {
			return o.attach;
		} else {
			return undefined;
		}
	}
	private function getTitle(o:Object):String
	{
		if (o.attributes.title == undefined) {
			if (o.title[0]._value == undefined) {
				if (o.title == undefined) {
					return String(o);
				} else {
					return o.title;
				}
			} else {
				return o.title[0]._value;
			}
		} else {
			return o.attributes.title;
		}
	}
	private function reset():Void
	{
		_items = [];
		_itemClips = [];
		_content = mc.createEmptyMovieClip("content", 1);
		_itemLayer = _content.createEmptyMovieClip("itemLayer", 1);
	}
	private function itemRelease(e:Object):Void
	{
		if (selectedState) {
			_lastRelease.unlock();
			_lastRelease = e.target;
			_lastRelease.lock = selectedState;
		} else {
			_lastRelease = e.target;
		}
		dispatchEvent({type:"onRelease", target:this});
	}
	/**
	* @return a reference to the menu Object that was released last.
	*/
	public function get lastRelease():Object
	{
		return _lastRelease;
	}
	/**
	* @return an Array of all Objects in the menu.
	*/
	public function get items():Array
	{
		return _items;
	}
	/**
	* @return the data Array used to draw the menu.
	*/
	public function get data():Array
	{
		return _data;
	}
	/**
	* @param array an Array representing information to draw the menu.
	*/
	public function set data(array:Array):Void
	{
		_data = array;
	}
	/**
	* @param abstractLayout the layout class to use when arranging the menu items.
	* @see net.indivision.layout
	*/
	public function set layout(abstractLayout:AbstractLayout):Void
	{
		_layout = abstractLayout;
	}
}

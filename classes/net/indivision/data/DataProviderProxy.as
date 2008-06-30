/**
* Translates data arrays between mx style dataProvider and data structure used for Indivision classes.
* @todo Modify classes to expect mx DataProvider and eliminate any need for this class.
*/
class net.indivision.data.DataProviderProxy
{
	private function DataProviderProxy()
	{
	}
	public static function makeData(d:Object):Object
	{
		var a:Array = [];
		var i:Number;
		for (i = 0; i < d.length; i++) {
			a.push({attributes:{title:d[i].label}, data:d[i].data});
		}
		return a;
	}
	public static function makeProvider(d:Object):Object
	{
		var a:Array = [];
		var i:Number;
		for (i = 0; i < d.length; i++) {
			a.push({label:d[i].title, data:d[i].data});
		}
		return a;
	}
}

package
{
	import flash.display.Sprite;
	
	import ru.alexli.blurback.App;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			addChild(App.instance);
		}
	}
}
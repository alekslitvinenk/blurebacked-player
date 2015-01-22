package ru.alexli.blurback
{
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	
	import ru.alexli.fcake.utils.crypto.Base64;
	import ru.alexli.fcake.utils.log.BrowserConsoleTarget;
	import ru.alexli.fcake.utils.log.LogLevel;
	import ru.alexli.fcake.utils.log.Logger;
	import ru.alexli.fcake.utils.log.TraceTarget;
	import ru.alexli.fcake.view.AbstractApp;
	
	public class App extends AbstractApp
	{
		private static var canBeInstantiated:Boolean;
		
		private static var _instance:App;
		
		private var loader:Loader;
		
		public static function get instance():App
		{
			if(!_instance)
			{
				canBeInstantiated = true;
				_instance = new App();
			}
			
			return _instance;
		}
		
		public function App()
		{
			if(!canBeInstantiated)
			{
				throw new IllegalOperationError("Error!");
			}
		}
		
		override protected function init():void
		{
			Logger.targets = [new TraceTarget(LogLevel.DEBUG), new BrowserConsoleTarget(LogLevel.DEBUG)];
				
			super.init();
		}
		
		override protected function onAppCreated():void
		{
			addChild(loader = new Loader());
			
			Logger.debug("Flash: ", ExternalInterface.available);
			
			ExternalInterface.addCallback("process_file", onProcessFile);
		}
		
		//callbacks
		public function onProcessFile(str:String):void
		{
			var ba:ByteArray = Base64.decodeToByteArray(str);
			
			ba.position = 0;
			
			loader.loadBytes(ba);
		}
	}
}
package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Stage;
	import gemeSet.*;

	public class Main extends Sprite
	{
		public static var game:*;
		public static var mainMenu:*;
		public static var editor:*;
		public static var da:*;
		public static var gameSettings:*;
		public static var help:*;
		public static var place:Stage;

		public static var plan1:Sprite = new Sprite  ;
		public static var plan2:Sprite = new Sprite  ;
		public static var planForAttack:Sprite = new Sprite  ;
		public static var plan3:Sprite = new Sprite  ;
		public static var plan4:Sprite = new Sprite  ;

		public static var saveGrid:Array = new Array ();
		public static var placeOfCastle:Array = [[null,null],[null,null]];

		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			addChild(plan4);
			addChild(plan3);
			addChild(planForAttack);
			addChild(plan2);
			addChild(plan1);
			place = stage;

			for (var i = 0; i < 16; i++)
			{
				saveGrid[i] = new Array  ;
				for (var m = 0; m < 11; m++)
				{
					saveGrid[i][m] = new Array(2);
					saveGrid[i][m][0] = null;
					saveGrid[i][m][1] = 0;
				}
			}

			da = new MajorData();

			mainMenu = new MainMenu();
			
			
			Main.place.addChild(mainMenu);
		}
		public static function addClass(class_p)
		{
			if (class_p == 0)
			{
				Main.game = new Game();
				Main.place.addChild(game);
			}
			if (class_p == 1)
			{
				Main.editor = new Editor();
				Main.place.addChild(editor);
			}
			if (class_p == 2)
			{
				Main.mainMenu = new MainMenu();
				Main.place.addChild(mainMenu);
			}
			if (class_p == 3)
			{
				Main.gameSettings = new GameSettings();
				Main.place.addChild(gameSettings);
			}
			if (class_p == 4)
			{
				Main.help = new Help();
				Main.place.addChild(help);
			}
		}
		public static function removeClass(class_p)
		{
			if (class_p == 0)
			{
				game.cleanGame();
				Main.place.removeChild(game);
				Main.game = null;
			}
			if (class_p == 1)
			{
				editor.cleanEditor();
				Main.place.removeChild(editor);
				Main.editor = null;
			}
			if (class_p == 2)
			{
				mainMenu.cleanMainMenu();
				Main.place.removeChild(mainMenu);
				Main.mainMenu = null;
			}
			if (class_p == 3)
			{
				gameSettings.cleanGameSettings();
				Main.place.removeChild(gameSettings);
				Main.gameSettings = null;
			}
			if (class_p == 4)
			{
				help.cleanHelp();
				Main.place.removeChild(help);
				Main.help = null;
			}
		}
	}
}
package 
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class MainMenu extends Sprite
	{
		private var blockUp = new blockUp_mc  ;
		private var blockDown = new blockDown_mc  ;
		private var darkness = new darkness_mc  ;
		private var bit:Array = new Array();
		private var a = 0;//изменение угла у синуса изменяющего альфу частиц :))
		private var b = 0;//изменение угла у синуса изменяющего альфу частиц :))
		private var razresh:Boolean;
		private var time = 0;
		private var timeTillHide = 0;
		private var allBits:Sprite = new Sprite  ;
		public var buttonsSprite:Sprite = new Sprite  ;
		private var button:Array = new Array();
		private var timeOfZoom = 0;
		private var radius:Number = 130;

		public function MainMenu()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			buttonsSprite.x = 400;
			buttonsSprite.y = 300;
			addChild(buttonsSprite);
			buttonsSprite.scaleX = 0.9;
			buttonsSprite.scaleY = buttonsSprite.scaleX;
			Main.plan1.addChild(blockUp);
			blockDown.y = 326;
			Main.plan1.addChild(blockDown);
			Main.plan1.addChild(darkness);

			button[0] = new ButtonMenu(3);
			button[1] = new ButtonMenu(1);
			button[2] = new ButtonMenu(4);
			button[0].y =  -  radius;
			button[1].x = -0.8660254 * radius;
			button[1].y = radius / 2;
			button[2].x = 0.8660254 * radius;
			button[2].y = radius / 2;

			buttonsSprite.addChild(button[0]);
			buttonsSprite.addChild(button[1]);
			buttonsSprite.addChild(button[2]);

			Main.plan2.addChild(allBits);
			addEventListener(Event.ENTER_FRAME,ef);
		}
		private function ef(e:Event)
		{
			time++;
			allBits.x = (mouseX - 400) / 20;
			allBits.y = (mouseY - 300) / 20;


			if (timeOfZoom >= Math.PI/2)
			{
				timeOfZoom = Math.PI / 2;
				buttonsSprite.scaleX = 1;
				buttonsSprite.scaleY = 1;
			}
			else
			{
				timeOfZoom +=  0.01;
				buttonsSprite.scaleX = 0.9 + Math.sin(timeOfZoom) / 10;
				buttonsSprite.scaleY = buttonsSprite.scaleX;
			}

			a +=  0.05;
			darkness.alpha = Math.sin(a/2);
			blockDown.alpha = Math.sin(a);
			blockUp.alpha = Math.cos(a+0.8);
			if (a > Math.PI*2)
			{
				a = 0;
			}
			if (time > 22)
			{
				time = int(Math.random() * 10);
				bit.push(new Bit(Math.random()*840-20,615,0));
				var u = bit.length - 1;
				allBits.addChild(bit[u]);
			}
			for (var i = 0; i<bit.length; i++)
			{
				bit[i].efBit();
				if (bit[i].bit.y < -20)
				{
					allBits.removeChild(bit[i]);
					bit.splice(i,1);
				}
			}
			if (timeTillHide>300)
			{
				razresh = true;
			}
			if (razresh)
			{
				b +=  0.05;
				allBits.alpha = Math.abs(Math.cos(b)) * 0.5 + 0.3;
				if (b>Math.PI)
				{
					razresh = false;
					timeTillHide = int(Math.random() * 150);
					allBits.alpha = 1;
					b = 0;
				}
			}
			else
			{
				timeTillHide++;
			}
			for (var n = 0; n<button.length; n++)
			{
				button[n].ef();
			}
		}
		public function cleanMainMenu()
		{
			removeEventListener(Event.ENTER_FRAME,ef);
			for (var i = 0; i<button.length; i++)
			{
				button[i].dellEvents();
				buttonsSprite.removeChild(button[i]);
				button[i] = null;
			}
			for (var m = 0; m<bit.length; m++)
			{
				bit[m].cleanBit();
				allBits.removeChild(bit[m]);
				bit[m] = null;
			}
			Main.plan2.removeChild(allBits);
			allBits = null;
			Main.plan1.removeChild(blockUp);
			Main.plan1.removeChild(blockDown);
			Main.plan1.removeChild(darkness);
			blockUp = null;
			blockDown = null;
			darkness = null;
		}

	}
}
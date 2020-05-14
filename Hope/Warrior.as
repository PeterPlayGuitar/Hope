package 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class Warrior extends Sprite
	{
		public var kindW;
		public var side;
		public var health;
		public var force;

		private var beginHealthWar;
		private var beginHealthArch;

		public var choise:Boolean = false;
		public var steps;
		public var positionX = 0;
		public var positionY = 0;

		private var colvoOfStepsForArcher = Main.da.archerBeginSteps_d;
		private var colvoOfStepsForWar = Main.da.warBeginSteps_d;
		public var beginColvoSteps;

		private var men;
		public var noSteps = new noSteps_mc  ;
		public var onStageNoSteps:Boolean = false;

		public var crit:Number;

		private var indepInf = new indepInf_mc  ;
		private var indepInfOnStage:Boolean = false;
		private var beginHealthW = Main.da.warHealth_d;
		private var beginHealthA = Main.da.archerHealth_d;

		public function Warrior(kindW_p, side_p)
		{
			kindW = kindW_p;
			side = side_p;

			beginHealthWar = Main.game.army.armySide[side].beginHealthWar;
			beginHealthArch = Main.game.army.armySide[side].beginHealthArch;

			if (side == 0)
			{
				if (kindW == 0)
				{
					men = new warM_mc  ;
					health = beginHealthWar;
					beginColvoSteps = colvoOfStepsForWar;
					steps = beginColvoSteps;
					force = Main.game.army.armySide[side].attackWar;
					crit = Main.game.army.armySide[side].critWar;
					men.gotoAndStop(Main.game.army.armySide[side].improvmentWar);
				}
				else
				{
					health = beginHealthArch;
					men = new archM_mc  ;
					beginColvoSteps = colvoOfStepsForArcher;
					steps = beginColvoSteps;
					force = Main.game.army.armySide[side].attackArch;
					crit = Main.game.army.armySide[side].critArch;
					men.gotoAndStop(Main.game.army.armySide[side].improvmentArch);
				}
			}
			else
			{
				if (kindW == 0)
				{
					health = beginHealthWar;
					men = new warE_mc  ;
					beginColvoSteps = colvoOfStepsForWar;
					steps = beginColvoSteps;
					force = Main.game.army.armySide[side].attackWar;
					crit = Main.game.army.armySide[side].critWar;
					men.gotoAndStop(Main.game.army.armySide[side].improvmentWar);
				}
				else
				{
					health = beginHealthArch;
					men = new archE_mc  ;
					beginColvoSteps = colvoOfStepsForArcher;
					steps = beginColvoSteps;
					force = Main.game.army.armySide[side].attackArch;
					crit = Main.game.army.armySide[side].critArch;
					men.gotoAndStop(Main.game.army.armySide[side].improvmentArch);
				}
			}

			addChild(men);
			men.addEventListener(MouseEvent.CLICK, mouseChoise);
			men.addEventListener(MouseEvent.MOUSE_OVER, MOV);
			men.addEventListener(MouseEvent.MOUSE_OUT, MOU);
		}
		public function improving(attackPlus)
		{
			men.gotoAndStop(2);
			force = attackPlus;
		}
		private function mouseChoise(e:MouseEvent)
		{

			if (Main.game.turn == side && Main.game.army.silense && ! Main.game.army.allowedAttack)
			{
				Main.game.army.deleteTargets();
				choise = true;
				Main.game.army.setInf(Main.game.army.wakedObject);
				Main.game.castle[side].dellInfCastle();
			}
		}
		public function getDamage(force,crit_enemy)
		{
			var damage = int(force * Main.game.grid[positionX][positionY].protection);
			if (Math.random() > crit_enemy)
			{
				Main.game.bang.makeCertainBang(positionX*50+25,positionY*50+25,damage/3-1,int(Math.random()*15+15),0xffff00,0);
			}
			else
			{
				damage *=  Main.game.army.valueOfCrit;
				Main.game.bang.makeCertainBang(positionX*50+25,positionY*50+25,damage/3-1,int(Math.random()*15+40),0xff0000,0);

				Main.game.stat.addS(Main.game.otherSide(side),9,1);
			}
			health -=  int(damage);
			indepInf.healthInf.text = int(health);
			Main.game.army.lastHealthFromDamage = health;

			Main.game.figure.seregaDavayH(positionX,positionY,-int(damage));

			Main.game.stat.addS(Main.game.otherSide(side),2,int(damage));
		}

		public function traatMyself()
		{
			var begHealth;
			if (kindW == 0)
			{
				begHealth = beginHealthWar;
			}
			else
			{
				begHealth = beginHealthArch;
			}
			if (health<begHealth && steps != 0)
			{
				var aa = health;
				health +=  Main.da.plusTreatBegin_d;
				if (health>begHealth)
				{
					health = begHealth;
				}
				Main.game.castle[side].money -=  Main.da.wasteMoneyToTreat_d;
				steps = 0;
				noSteps.x = positionX * 50;
				noSteps.y = positionY * 50;
				Main.plan3.addChild(noSteps);
				onStageNoSteps = true;
				Main.game.army.deleteTargets();

				Main.game.bang.makeCertainBang(positionX*50+25,positionY*50+25,4,30,0xff0000,1);
				Main.game.figure.seregaDavayH(positionX,positionY,health-aa);
			}

		}
		public function fun1()
		{
			//функция, проверяющая есть ли шаги у воина и если нет то показывает это на сцене
			if (steps <= 0)
			{
				steps = 0;
				noSteps.x = positionX * 50;
				noSteps.y = positionY * 50;
				Main.plan3.addChild(noSteps);
				onStageNoSteps = true;
			}
		}
		public function deleteNoSteps()
		{
			if (onStageNoSteps)
			{
				Main.plan3.removeChild(noSteps);
				onStageNoSteps = false;
			}
		}
		private function MOV(e:MouseEvent)
		{
			indepInf.healthInf.text = int(health);
			indepInf.protection.text = int(100 - Main.game.grid[positionX][positionY].protection*100)+"%";
			Main.plan1.addChild(indepInf);
			indepInfOnStage = true;
		}
		private function MOU(e:MouseEvent)
		{
			Main.plan1.removeChild(indepInf);
			indepInfOnStage = false;
		}
		public function dellEvents()
		{
			if (indepInfOnStage)
			{
				Main.plan1.removeChild(indepInf);
			}
			men.removeEventListener(MouseEvent.CLICK, mouseChoise);
			men.removeEventListener(MouseEvent.MOUSE_OVER, MOV);
			men.removeEventListener(MouseEvent.MOUSE_OUT, MOU);
		}
		public function cleanWarrior()
		{
			dellEvents();
			removeChild(men);
			men = null;
			deleteNoSteps();
			noSteps = null;
		}

	}
}
// if side is 0, warrior is my, else is enemy
// if kindW is 0, warrior is war, else is archer
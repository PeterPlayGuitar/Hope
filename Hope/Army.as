package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class Army extends Sprite
	{
		public var armySide:Array = new Array();

		public var exel = new exel_mc  ;
		public var infOfWarrior = new infOfWarrior_mc  ;

		public var onStageInf:Boolean = false;
		private var upside:Boolean = false;
		public var silense:Boolean = true;
		private var putDone:Boolean = false;

		private var counter = 0;
		private var moveObject;

		private var direct:Array = new Array(2);
		private var mousePut:Array = new Array(2);

		private var attackPlaces:Array = new Array();
		private var AAAPla:Array = new Array();
		public var allowedAttack:Boolean = false;
		private var size:int;

		private var dart:*;

		public var valueOfCrit = Main.da.damageFromCrit_d;
		public var lastHealthFromDamage:Number;

		private var chanceGetDimond:Number = Main.da.chanceGetADimond_d;

		public function Army()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);

			armySide[0] = new ArmyE(0);
			armySide[1] = new ArmyE(1);
			addChild(armySide[0]);
			addChild(armySide[1]);
			infOfWarrior.x = 400 + infOfWarrior.width / 2;
			infOfWarrior.y = 600;
			infOfWarrior.addEventListener(MouseEvent.MOUSE_OVER, overInf);
		}

		private function overInf(e:MouseEvent)
		{
			if (upside)
			{
				infOfWarrior.y = 600;
				upside = false;
			}
			else
			{
				infOfWarrior.y = infOfWarrior.height;
				upside = true;
			}
		}//**метка ?2
		public function mouseClickOnArmy()
		{

			if (wakedObject != null && silense)
			{
				moveObject = wakedObject;
				mousePut = [int(mouseX/50),int(mouseY/50)];
				var pos = [moveObject.positionX,moveObject.positionY];
				direct = [mousePut[0] - pos[0],mousePut[1] - pos[1]];
				if (allowedAttack && fun1(mousePut[0],mousePut[1]))
				{
					if (moveObject.kindW == 0 && moveObject.steps >= Main.game.grid[mousePut[0]][mousePut[1]].stepsForMove)
					{
						deleteInf();
						silense = false;
						addEventListener(Event.ENTER_FRAME,attackFun);
					}
					if (moveObject.kindW == 1 && moveObject.steps >= 1)
					{
						deleteInf();
						dart = new Dart(Main.game.turn);
						dart.x = moveObject.positionX * 50 + 25;
						Main.plan2.addChild(dart);
						silense = false;
						addEventListener(Event.ENTER_FRAME,shotFun);
					}
				}
				else if (busy(mousePut[0],mousePut[1]) == 2 && mouseY<550 &&!allowedAttack)
				{
					var one = unsigning(direct[0]);
					var two = unsigning(direct[1]);
					if (one<=1 && two <=1 && moveObject.steps >= Main.game.grid[mousePut[0]][mousePut[1]].stepsForMove)
					{/*нажатие на соседнюю клетку*/
						silense = false;
						Main.game.grid[pos[0]][pos[1]].sideBusy = 2;
						deleteInf();
						addEventListener(Event.ENTER_FRAME,moving);
					}
					else
					{//нажатие мимо
						deleteTargets();
					}
				}
			}
		}
		private function moving(e:Event)
		{
			counter++;
			moveObject.x +=  50 / Main.game.basicTime * direct[0];
			moveObject.y +=  50 / Main.game.basicTime * direct[1];
			if (counter > Main.game.basicTime)
			{
				removeEventListener(Event.ENTER_FRAME,moving);
				Main.game.castle[Main.game.turn].dellInfCastle();
				setPosition(moveObject,mousePut[0],mousePut[1]);
				moveObject.steps -=  Main.game.grid[mousePut[0]][mousePut[1]].stepsForMove;
				moveObject.fun1();
				if (moveObject.steps <= 0)
				{
					deleteTargets();
				}
				else
				{
					setInf(moveObject);
				}
				counter = 0;
				silense = true;

				Main.game.stat.addS(Main.game.turn,1,1);
			}
		}
		private function attackFun(e:Event)
		{
			counter++;
			if (counter<Main.game.basicTime)
			{
				moveObject.x +=  50 / Main.game.basicTime * direct[0];
				moveObject.y +=  50 / Main.game.basicTime * direct[1];
			}
			else if (counter<Main.game.basicTime*2)
			{
				moveObject.x -=  50 / Main.game.basicTime * direct[0];
				moveObject.y -=  50 / Main.game.basicTime * direct[1];
			}
			else
			{
				counter = 0;

				allowedAttack = false;
				setPosition(moveObject,moveObject.positionX,moveObject.positionY);
				moveObject.steps = 0;
				moveObject.fun1();
				deleteTargets();
				dellPlacesOfAttack();
				Main.game.castle[Main.game.turn].dellInfCastle();
				removeEventListener(Event.ENTER_FRAME,attackFun);

				Main.game.downString.attackButton.attackButton.gotoAndStop(1);

				makeDamage(moveObject.force,mousePut[0],mousePut[1],moveObject.crit,moveObject);

				silense = true;

				Main.game.stat.addS(moveObject.side,3,1);
			}
		}

		private function shotFun(e:Event)
		{
			counter++;
			var time = 2 * Main.game.basicTime;
			var realValue = 25 + moveObject.positionY * 50 + direct[1] * 50 * counter / time;
			var additionValue = (counter - time) * 100 * counter / (time * time);
			var ly = dart.y;
			dart.y = realValue + additionValue;
			var ay = dart.y;
			var lv = dart.x;
			dart.x +=  direct[0] * 50 / time;
			var av = dart.x;
			dart.rotation = 180/Math.PI* Math.atan2(ay-ly,av-lv);
			dart.scaleX = (-(counter-time/2+1)*(counter-time/2+1)+(time/2+1)*(time/2+1))/((time/2+1)*(time/2+1)/1.5);
			dart.scaleY = dart.scaleX;

			if (counter > time)
			{
				moveObject.steps = 0;
				moveObject.fun1();
				counter = 0;
				allowedAttack = false;
				dellPlacesOfAttack();
				deleteTargets();
				Main.plan2.removeChild(dart);
				dart = null;
				Main.game.castle[Main.game.turn].dellInfCastle();
				removeEventListener(Event.ENTER_FRAME,shotFun);

				Main.game.downString.attackButton.attackButton.gotoAndStop(1);

				makeDamage(moveObject.force,mousePut[0],mousePut[1],moveObject.crit,moveObject);

				silense = true;

				Main.game.stat.addS(moveObject.side,4,1);
			}

		}

		public function setPosition(obj, X, Y)
		{
			obj.x = 50 * X;
			obj.y = 50 * Y;
			obj.positionX = X;
			obj.positionY = Y;
			Main.game.grid[X][Y].sideBusy = obj.side;
		}
		private function fun1(X,Y)
		{
			//функция возвращает значение attackPlaces[?][3] в клетке X и Y
			var haveFind = false;
			var a = 0;
			for (var i = 0; i<size; i++)
			{
				if (attackPlaces[i][0] == X && attackPlaces[i][1] == Y)
				{
					a = i;
					haveFind = true;
				}
			}
			if (haveFind)
			{
				return attackPlaces[a][2];
			}
			else
			{
				return false;
			}
		}
		public function clickAttack()
		{
			var dude = wakedObject;
			if (silense && allowedAttack)
			{
				allowedAttack = false;
				dellPlacesOfAttack();
				Main.game.downString.attackButton.attackButton.gotoAndStop(1);
			}
			else if (silense && dude != null&&!allowedAttack)
			{
				addPlacesOfAttack(dude.kindW);
				allowedAttack = true;
				Main.game.downString.attackButton.attackButton.gotoAndStop(2);

				// тут проверка на наличие мест для аттаки;

				var a:Boolean = false;
				for (var i = 0; i<size; i++)
				{
					if (attackPlaces[i][2])
					{
						a = true;
						break;
					}
				}
				if (! a)
				{
					allowedAttack = false;
					dellPlacesOfAttack();
					Main.game.downString.attackButton.attackButton.gotoAndStop(1);
				}
			}
		}
		private function addPlacesOfAttack(kindW)
		{
			var dude = wakedObject;
			var xx = dude.positionX;
			var yy = dude.positionY;
			if (kindW == 0)
			{
				attackPlaces[0] = [xx-1,yy - 1,funW(xx-1,yy-1)];
				attackPlaces[1] = [xx,yy - 1,funW(xx,yy - 1)];
				attackPlaces[2] = [xx+1,yy - 1,funW(xx+1,yy - 1)];
				attackPlaces[3] = [xx-1,yy,funW(xx-1,yy)];
				attackPlaces[4] = [xx+1,yy,funW(xx+1,yy)];
				attackPlaces[5] = [xx-1,yy+1,funW(xx-1,yy+1)];
				attackPlaces[6] = [xx,yy + 1,funW(xx,yy + 1)];
				attackPlaces[7] = [xx+1,yy+1,funW(xx+1,yy+1)];
				size = 8;
			}
			else
			{
				attackPlaces[0] = [xx - 2,yy - 2,funA(-2,-2)];
				attackPlaces[1] = [xx,yy - 2,funA(0,-2)];
				attackPlaces[2] = [xx + 2,yy - 2,funA(2,-2)];
				attackPlaces[3] = [xx - 1,yy - 1,funA(-1,-1)];
				attackPlaces[4] = [xx,yy - 1,funA(0,-1)];
				attackPlaces[5] = [xx + 1,yy - 1,funA(1,-1)];
				attackPlaces[6] = [xx - 2,yy,funA(-2,0)];
				attackPlaces[7] = [xx - 1,yy,funA(-1,0)];
				attackPlaces[8] = [xx + 1,yy,funA(1,0)];
				attackPlaces[9] = [xx + 2,yy,funA(2,0)];
				attackPlaces[10] = [xx - 1,yy + 1,funA(-1,1)];
				attackPlaces[11] = [xx,yy + 1,funA(0,1)];
				attackPlaces[12] = [xx + 1,yy + 1,funA(1,1)];
				attackPlaces[13] = [xx - 2,yy + 2,funA(-2,2)];
				attackPlaces[14] = [xx,yy + 2,funA(0,2)];
				attackPlaces[15] = [xx + 2,yy + 2,funA(2,2)];
				size = 16;
			}

			for (var i = 0; i<size; i++)
			{
				if (attackPlaces[i][2])
				{
					AAAPla[i] = new PlaceOfAttack(kindW);
					AAAPla[i].x = attackPlaces[i][0] * 50;
					AAAPla[i].y = attackPlaces[i][1] * 50;
					Main.plan3.addChild(AAAPla[i]);
				}
			}
		}
		public function dellPlacesOfAttack()
		{
			for (var i = 0; i<16; i++)
			{
				attackPlaces[i] = null;
				if (AAAPla[i] != null)
				{
					Main.plan3.removeChild(AAAPla[i]);
					AAAPla[i] = null;
				}
			}
		}
		private function funW(X,Y)
		{//метод возвращает тру если на координатах враг на газоне холме лесе или крепости

			if (X >= 0 && X < 16 && Y >=0 && Y < 11)
			{
				var a = Main.game.grid[X][Y];
				if ((a.that == "lawn"||a.that == "wood"||a.that == "cast"||a.that == "hill")
				&& a.sideBusy == Main.game.otherSide(Main.game.turn))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		private function funA(X,Y):Boolean
		{//то же чо и funW(X,Y) только для лучников

			var xx = wakedObject.positionX;
			var yy = wakedObject.positionY;
			var b = Main.game.grid;

			if (xx+X >= 0 && xx+X < 16 && yy+Y >=0 && yy+Y < 11)
			{

				if ((unsigning(X) == 2 || unsigning(Y) == 2)
				&&!(b[xx+X][yy+Y].that == "top" || b[xx+X][yy+Y].that == "hill"|| b[xx+X][yy+Y].that == "sea")
				&&b[xx+X][yy+Y].sideBusy == Main.game.otherSide(Main.game.turn))
				{
					var a = Main.game.grid[xx + X / 2][yy + Y / 2].that;
					if (a == "lawn"||a == "sea")
					{
						return true;
					}
					else
					{
						return false;
					}
				}
				else if (b[xx + X][yy + Y].that != "top"
				 && b[xx + X][yy + Y].that != "sea"
				 &&!(unsigning(X) == 2 || unsigning(Y) == 2)
				 &&b[xx+X][yy+Y].sideBusy == Main.game.otherSide(Main.game.turn))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}

		}
		private function unsigning(num)
		{
			if (num<0)
			{
				return -num;
			}
			else
			{
				return num;
			}
		}
		public function busy(X,Y):int
		{
			if (Main.game.grid[X][Y] != null)
			{
				return Main.game.grid[X][Y].sideBusy;
			}
			return 3;
		}
		public function addSteps(sideDude)
		{
			for (var i = 0; i<armySide[sideDude].archer.length; i++)
			{
				armySide[sideDude].archer[i].steps = armySide[sideDude].archer[i].beginColvoSteps;
			}
			for (var m = 0; m<armySide[sideDude].war.length; m++)
			{
				armySide[sideDude].war[m].steps = armySide[sideDude].war[m].beginColvoSteps;
			}
		}
		public function deleteNoSteps(numTurn)
		{
			for (var i = 0; i<armySide[numTurn].archer.length; i++)
			{
				armySide[numTurn].archer[i].deleteNoSteps();
			}
			for (var m = 0; m<armySide[numTurn].war.length; m++)
			{
				armySide[numTurn].war[m].deleteNoSteps();
			}
		}
		private function makeDamage(force,X,Y,crit,killer)
		{
			var kindW;
			var side;
			var numer;
			for (var i = 0; i<armySide[0].war.length; i++)
			{
				if (armySide[0].war[i].positionX == X && armySide[0].war[i].positionY == Y)
				{
					armySide[0].war[i].getDamage(force,crit);
					kindW = 0;
					side = 0;
					numer = i;
					break;
				}
			}
			for (var n = 0; n<armySide[1].war.length; n++)
			{
				if (armySide[1].war[n].positionX == X && armySide[1].war[n].positionY == Y)
				{
					armySide[1].war[n].getDamage(force,crit);
					kindW = 0;
					side = 1;
					numer = n;
					break;
				}
			}
			for (var m = 0; m<armySide[0].archer.length; m++)
			{
				if (armySide[0].archer[m].positionX == X && armySide[0].archer[m].positionY == Y)
				{
					armySide[0].archer[m].getDamage(force,crit);
					kindW = 1;
					side = 0;
					numer = m;
					break;
				}
			}
			for (var b = 0; b<armySide[1].archer.length; b++)
			{
				if (armySide[1].archer[b].positionX == X && armySide[1].archer[b].positionY == Y)
				{
					armySide[1].archer[b].getDamage(force,crit);
					kindW = 1;
					side = 1;
					numer = b;
					break;
				}
			}
			if (lastHealthFromDamage <= 0)
			{
				deathWarrior(side,kindW,numer);
				if (Math.random() < chanceGetDimond)
				{
					Main.game.castle[Main.game.turn].dimonds +=  1;
				}
				var randMoney = int(Math.random()*(Main.da.moneyForMorderTo_d - Main.da.moneyForMorderFrom_d+1)+Main.da.moneyForMorderFrom_d);
				Main.game.castle[Main.game.turn].money +=  randMoney;

				Main.game.figure.seregaDavayM(killer.positionX,killer.positionY,randMoney);

				if (killer.kindW == 0)
				{
					addEventListener(Event.ENTER_FRAME,moving);
					moveObject = killer;
					Main.game.grid[moveObject.positionX][moveObject.positionY].sideBusy = 2;
					counter = 0;
					direct = [X - moveObject.positionX,Y - moveObject.positionY];
					mousePut = [X,Y];
				}

				Main.game.stat.addS(Main.game.turn,0,1);

				Main.game.stat.addS(side,5,1);

				Main.game.stat.addS(Main.game.turn,8,randMoney);
			}
		}
		//*метка ?1
		private function deathWarrior(side_c,kindW_c,num_c)
		{
			var dude;
			if (kindW_c == 0)
			{
				dude = armySide[side_c].war[num_c];
				dude.cleanWarrior();
				armySide[side_c].removeChild(dude);
				armySide[side_c].war.splice(num_c,1);
			}
			else
			{
				dude = armySide[side_c].archer[num_c];
				dude.cleanWarrior();
				armySide[side_c].removeChild(dude);
				armySide[side_c].archer.splice(num_c,1);
			}
			Main.game.grid[dude.positionX][dude.positionY].sideBusy = 2;

		}
		public function fromButtonToDellWarrior()
		{
			if (wakedObject != null && silense && !allowedAttack)
			{
				Main.game.setTablo("deleteWarrior");
			}
		}
		public function deleteWarriorSpecial()
		{
			var a = wakedObject;
			var X = a.positionX;
			var Y = a.positionY;
			deathWarrior(a.side,a.kindW,SPECIALnumerOfWakedObject(a.side));
			deleteTargets();
			Main.game.castle[Main.game.turn].money +=  Main.da.plusMoneyForDisband_d;

			Main.game.bang.makeSmokeBang(X*50+25,Y*50+40,3,15);

			Main.game.figure.seregaDavayM(X,Y,Main.da.plusMoneyForDisband_d);
		}
		public function get wakedObject():Warrior
		{
			for (var i = 0; i<armySide[0].war.length; i++)
			{
				if (armySide[0].war[i].choise == true)
				{
					return armySide[0].war[i];
				}
			}
			for (var n = 0; n<armySide[1].war.length; n++)
			{
				if (armySide[1].war[n].choise == true)
				{
					return armySide[1].war[n];
				}
			}
			for (var m = 0; m<armySide[0].archer.length; m++)
			{
				if (armySide[0].archer[m].choise == true)
				{
					return armySide[0].archer[m];
				}
			}
			for (var b = 0; b<armySide[1].archer.length; b++)
			{
				if (armySide[1].archer[b].choise == true)
				{
					return armySide[1].archer[b];
				}
			}
			return null;
		}
		public function SPECIALnumerOfWakedObject(side_p)
		{
			for (var i = 0; i<armySide[side_p].war.length; i++)
			{
				if (armySide[side_p].war[i].choise == true)
				{
					return i;
				}
			}
			for (var m = 0; m<armySide[side_p].archer.length; m++)
			{
				if (armySide[side_p].archer[m].choise == true)
				{
					return m;
				}
			}
			return null;
		}
		public function deleteTargets()
		{
			for (var i = 0; i<armySide[0].war.length; i++)
			{
				armySide[0].war[i].choise = false;
			}
			for (var n = 0; n<armySide[0].archer.length; n++)
			{
				armySide[0].archer[n].choise = false;
			}
			for (var b = 0; b<armySide[1].war.length; b++)
			{
				armySide[1].war[b].choise = false;
			}
			for (var m = 0; m<armySide[1].archer.length; m++)
			{
				armySide[1].archer[m].choise = false;
			}
			dellPlacesOfAttack();
			deleteInf();
		}
		public function setInf(dude)
		{
			exel.x = dude.x;
			exel.y = dude.y;
			Main.plan3.addChild(exel);
			Main.plan1.addChild(infOfWarrior);
			onStageInf = true;
			infOfWarrior.health.text = int(dude.health);
			infOfWarrior.steps.text = dude.steps + "/" + dude.beginColvoSteps;
			infOfWarrior.force.text = dude.force;
			infOfWarrior.protection.text = int(100 - Main.game.grid[dude.positionX][dude.positionY].protection*100)+"%";
			infOfWarrior.crit.text = int(dude.crit * 100) + "%";
		}
		public function deleteInf()
		{
			if (onStageInf)
			{
				Main.plan3.removeChild(exel);
				Main.plan1.removeChild(infOfWarrior);
				onStageInf = false;
			}
		}
		public function cleanArmy()
		{
			infOfWarrior.removeEventListener(MouseEvent.MOUSE_OVER, overInf);
			deleteTargets();

			armySide[0].cleanArmySide();
			armySide[1].cleanArmySide();
			removeChild(armySide[0]);
			removeChild(armySide[1]);
			armySide[0] = null;
			armySide[1] = null;
		}
	}
}
package 
{
	public class MajorData
	{
		//common
		public var basicTime_d = 15;
		public var style_d = 2;
		public var colvoStyles_d = 3;
		public var damageFromCrit_d = 1.6;
		public var chanceGetADimond_d = 0.1;
		public var plusTreatBegin_d = 6;
		public var wasteMoneyToTreat_d = 1;
		public var moneyForMorderFrom_d = 6;
		public var moneyForMorderTo_d = 11;
		public var expensesForOneExtraWarrior_d = 2;
		public var plusMoneyForDisband_d = 5;

		//prices of buildings
		public var price_d:Array = new Array(14);

		//features of warriors
		public var archerForce_d = 10;
		public var archerCrit_d = 0.15;
		public var archerHealth_d = 50;
		public var archerBeginSteps_d = 3;

		public var warForce_d = 15;
		public var warCrit_d = 0.07;
		public var warHealth_d = 75;
		public var warBeginSteps_d = 3;

		//prices of manage
		public var priceArch_d = 15;
		public var priceWar_d = 20;
		public var priceBuyDiamond_d = 25;
		public var priceSellDiamond_d = 13;

		//features of valeys 
		public var minusEnergyForReplaceCast_d = 1;
		public var minusEnergyForReplaceLawn_d = 1;
		public var minusEnergyForReplaceWood_d = 2;
		public var minusEnergyForReplaceHill_d = 3;
		public var minusEnergyForReplaceTop_d = 4;
		public var minusEnergyForReplaceSea_d = 5;

		public var protectCast_d = 0.6;
		public var protectLawn_d = 1;
		public var protectWood_d = 0.8;
		public var protectHill_d = 0.9;
		public var protectTop_d = 1;
		public var protectSea_d = 1;

		//other features of buildings
		public var healthPlusG0_d = 15;
		public var plusMoneyG2_d = 5;
		public var plusMoneyG3_d = 7;
		public var populationPlusG4_d = 6;
		public var attackPlusG5_d = 13;
		public var attackPlusG6_d = 20;
		public var populationPlusG7_d = 12;
		public var healthPlusG8_d = 21;
		public var plusMoneyG9_d = 9;
		public var critPlusG10_d = 0.07;

		//castle
		public var beginPopulation_d = 3;
		public var beginMoney_d = 5;
		public var beginDailyProfit_d = 3;
		public var beginDimonds_d = 0;
		public var beginHealth_d = 10;

		public function MajorData()
		{
			price_d[0] = 20;
			price_d[1] = 10;
			price_d[2] = 15;
			price_d[3] = 15;
			price_d[4] = 10;
			price_d[5] = 40;
			price_d[6] = 30;
			price_d[7] = 30;
			price_d[8] = 30;
			price_d[9] = 50;
			price_d[10] = 25;
			price_d[11] = 15;
			price_d[12] = 65;
			price_d[13] = 100;
		}
	}
}
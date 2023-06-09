CreatePointTearchHunt()
{
	SetTimer("harta1", 60000, false);
	CreatePickup(1275, 2, -2090.8560,-2249.4260,30.7900, -1);
	Create3DTextLabel("{00FF00}TreasureHunt\n{FFFFFF}type:{FFFF00}/gethunt & /getcoin", 0xFFFF00AA, -2090.8560,-2249.4260,30.7900, 50.0, 0);
}

new pickup_harta[10];
new bool:harta[5] = false;
new time_dug[MAX_PLAYERS];

#define treasure1 763.0416,-447.8749,15.9818
#define treasure2 44.2541,33.6656,2.3275
#define treasure3 2155.1956,-655.1735,54.6248
#define treasure4 -363.1943,2264.5986,42.4946

enum aTreasure
{
	Treasure,
	GetTreasure
}
new IsPlayerHunt[MAX_PLAYERS][aTreasure];

epublic: harta1(playerid)
{
	pickup_harta[0] = CreatePickup(1210, 2, treasure1, -1);
	if(IsPlayerHunt[playerid][Treasure] == 1)
	{
		SendClientMessage(playerid, -1, "Treasure{FFFFFF}:hidden treasure in dillimore area");
		harta[0] = true;
	}
	return 1;
}
epublic: harta2(playerid)
{
	pickup_harta[1] = CreatePickup(1210, 2, treasure2, -1);
	if(IsPlayerHunt[playerid][Treasure] == 1)
	{
		SendClientMessage(playerid, -1, "Treasure{FFFFFF}:hidden treasure in blueberry area");
		harta[1] = true;
	}
	return 1;
}
epublic: harta3(playerid)
{
	pickup_harta[2] = CreatePickup(1210, 2, treasure3, -1);
	if(IsPlayerHunt[playerid][Treasure] == 1)
	{
		SendClientMessage(playerid, -1, "Treasure{FFFFFF}:hidden treasure in red country area");
		harta[2] = true;
	}
	return 1;
}
epublic: harta4(playerid)
{
	pickup_harta[3] = CreatePickup(1210, 2, treasure4, -1);
	if(IsPlayerHunt[playerid][Treasure] == 1)
	{
		SendClientMessage(playerid, -1, "Treasure{FFFFFF}:hidden treasure in village area near LV. dam");
		harta[3] = true;
	}
	return 1;
}

CMD:gpshunt(playerid)
{
	if(harta[0] == true)
	{
		SetPlayerGPS(playerid, treasure1);
	}
	else if(harta[1] == true)
	{
	    SetPlayerGPS(playerid, treasure2);
	}
	else if(harta[2] == true)
	{
		SetPlayerGPS(playerid, treasure3);
	}
	else if(harta[3] == true)
	{
	    SetPlayerGPS(playerid, treasure4);
	}
	return 1;
}

CMD:getcoin(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, -2090.8560,-2249.4260,30.7900)) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you can't redeem here");
	if(IsPlayerHunt[playerid][GetTreasure] == 0) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you don't have treasure");
    new rand = random(100000);
	PlayerInfo[playerid][pRed] +=rand;
	OnPlayerUpdateAccountsPer(playerid, "pRed", PlayerInfo[playerid][pRed]);
	IsPlayerHunt[playerid][GetTreasure] -=1;
	format(String, 114, "{FF0000}INFO{FFFFFF}:You get {FF0000}%d${FFFFFF} for reedem treasure", rand);
	SendClientMessage(playerid, -1, String);
	return 1;
}
CMD:gethunt(playerid)
{
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -2090.8560,-2249.4260,30.7900)) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you can't get job here");
	IsPlayerHunt[playerid][Treasure] +=1;
	SendClientMessage(playerid, -1, "Your now Treasure Hunt");
	SetPlayerAttachedObject(playerid,1,337, 5, -0.000000,0.114000,0.047000,-30.300003,-163.299865,175.699951);
	return 1;
}
CMD:dig(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 5.0, treasure1))
	{
	    if(IsPlayerHunt[playerid][Treasure] == 0) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you are not a treasure hunter");
	    if(harta[0] == false) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:This treasure has been dug up");
	    SetTimer("harta2", 60000, false);
	    TogglePlayerControllableEx(playerid, 0);
    	ApplyAnimation(playerid, "BASEBALL", "Bat_4", 3.1, 0, 0, 0, 0, 20000, 1);
	    time_dug[playerid] = SetTimerEx("DigTime", 7000, false, "d", playerid);
	    DestroyPickup(pickup_harta[0]);
	    SendClientMessage(playerid, -1, "INFO{FFFFFF}:you managed to dig treasure");
	    harta[0] = false;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, treasure2))
	{
	    if(IsPlayerHunt[playerid][Treasure] == 0) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you are not a treasure hunter");
	    if(harta[1] == false) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:This treasure has been dug up");
	    SetTimer("harta3", 60000, false);
	    TogglePlayerControllableEx(playerid, 0);
    	ApplyAnimation(playerid, "BASEBALL", "Bat_4", 3.1, 0, 0, 0, 0, 20000, 1);
	    time_dug[playerid] = SetTimerEx("DigTime", 7000, false, "d", playerid);
		DestroyPickup(pickup_harta[1]);
		SendClientMessage(playerid, -1, "INFO{FFFFFF}:you managed to dig treasure");
		harta[1] = false;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, treasure3))
	{
	    if(IsPlayerHunt[playerid][Treasure] == 0) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you are not a treasure hunter");
	    if(harta[2] == false) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:This treasure has been dug up");
	    SetTimer("harta4", 60000, false);
	    TogglePlayerControllableEx(playerid, 0);
    	ApplyAnimation(playerid, "BASEBALL", "Bat_4", 3.1, 0, 0, 0, 0, 20000, 1);
	    time_dug[playerid] = SetTimerEx("DigTime", 7000, false, "d", playerid);
	    DestroyPickup(pickup_harta[2]);
	    SendClientMessage(playerid, -1, "INFO{FFFFFF}:you managed to dig treasure");
	    harta[2] = false;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 5.0, treasure4))
	{
	    if(IsPlayerHunt[playerid][Treasure] == 0) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:you are not a treasure hunter");
	    if(harta[3] == false) return SendClientMessage(playerid, COLOR_RED, "ERROR{FFFFFF}:This treasure has been dug up");
	    SetTimer("harta1", 60000, false);
	    TogglePlayerControllableEx(playerid, 0);
    	ApplyAnimation(playerid, "BASEBALL", "Bat_4", 3.1, 0, 0, 0, 0, 20000, 1);
	    time_dug[playerid] = SetTimerEx("DigTime", 7000, false, "d", playerid);
	    DestroyPickup(pickup_harta[3]);
	    SendClientMessage(playerid, -1, "INFO{FFFFFF}:you managed to dig treasure");
	    harta[3] = false;
	}
	else SCM(playerid, COLOR_RED, "ERROR{FFFFFF}:no treasure here");
	return 1;
}

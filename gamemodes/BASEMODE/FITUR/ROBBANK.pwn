new timer_robbankls[MAX_PLAYERS];
new timer_robbank[MAX_PLAYERS];
#define COLOR_LIGHTGREEN 	0x00FF00FF

CreatePointRobBank()
{
    CreateDynamicPickup(1210, 23, 1667.4841,-1351.7847,18.2186, -1);
    CreateDynamicPickup(1550, 23, 1649.1769,-1356.3109,18.2086, -1);
    CreateDynamicPickup(1254, 23, -282.7677,-2174.3760,28.6580, -1);
    CreateDynamic3DTextLabel("[HACKED]\nCMD:/HACK", COLOR_RED, 1667.4841,-1351.7847,18.2186, 2.0);
	CreateDynamic3DTextLabel("[ROBBERY]\nCMD:/ROBBANK", COLOR_GREEN, 1649.1769,-1356.3109,18.2086, 2.0);
    CreateDynamic3DTextLabel("[HASIL ROBBERY]\nCMD:/TUKAR", COLOR_GREEN, -282.7677,-2174.3760,28.6580, 2.0);
}

CMD:tukar(playerid, params [])
{
    if(!IsAGang(playerid)) return ShowError(playerid, "LU BUKAN GANG, KHUSUS GANG");
    {
        if(PlayerInfo[playerid][pBanki] == 0)
        {
            ShowError(playerid, "Anda Belom Merampok Bank.");
            return 1;
        }
        if(!IsPlayerInRangeOfPoint(playerid, 2.0, -282.7677,-2174.3760,28.6580))//Change those X,Y,Z
        {
            ShowError(playerid, " Kamu tidak di penyetoran !");
            return 1;
        }
        else
        {
            ShowInfo(playerid, "Anda Berhasil Menukarkan Hasil Rampok");
			PlayerInfo[playerid][pBanki] = 0;
			RemovePlayerAttachedObject(playerid, 9);
            GivePlayerMoney(playerid, 5000000);
            PlayerInfo[playerid][pCash] += 5000000;
            OnPlayerUpdateAccountsPer(playerid, "pCash", PlayerInfo[playerid][pCash]);
        }
    }
    return 1;
}

CMD:robbank(playerid, params [])
{

    if(!IsAGang(playerid)) return ShowError(playerid, "LU BUKAN GANG, KHUSUS GANG");
    {
        if(PlayerInfo[playerid][pHackBank] == 0)
        {
            ShowError(playerid, "Anda Belom Menghack Bank.");
            return 1;
        }
        if(!IsPlayerInRangeOfPoint(playerid, 2.0, 1649.1769,-1356.3109,18.2086))//Change those X,Y,Z
        {
            ShowError(playerid, " Kamu tidak di bank !");
            return 1;
        }
        else
        {
            ShowInfo(playerid, "Anda Sedang Mengambil Duit, Harap Tunggu...");
			PlayerInfo[playerid][pHackBank] = 0;
            TogglePlayerControllableEx(playerid, 0);
  	        timer_robbankls[playerid] = SetTimerEx("RobBankLs", 30000, false, "d", playerid);
            SetPVarInt(playerid, "fRobBank", 1);
            ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.0, 1, 0, 0, 0, 0, 1);
        }
    }
    return 1;
}

CMD:hack(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1667.4841,-1351.7847,18.2186))
	{
		if(!IsAGang(playerid)) return ShowError(playerid, "LU BUKAN GANG, KHUSUS GANG");
		{
			TogglePlayerControllableEx(playerid, 0);
		  	timer_robbank[playerid] = SetTimerEx("HackBankLs", 30000, false, "d", playerid);
		    SetPVarInt(playerid, "fHack", 1);
		    PlayerPlaySound(playerid,1133,0.0,0.0,0.0);
			SendClientMessageToAll(COLOR_LIGHTRED, "||----------------BERITA TERKINI----------------||");
		    SendClientMessageToAll(COLOR_LIGHTGREEN, " Bank Tanah Air  telah dibobol oleh penjahat Warga diharap menjauh dari lokasi bank.");
		    SendClientMessageToAll(COLOR_LIGHTGREEN, " Bank saat ini sedang dirampok. ");
		    SendClientMessageToAll(COLOR_LIGHTGREEN, " Aparat atau polisi segera menuju ke bank!");
		    SendClientMessageToAll(COLOR_LIGHTRED, "||----------------BERITA TERKINI----------------||");
		    ShowInfo(playerid, "Anda Sedang Mengbobol Bank Silakan Tunggu 30 Detik.....");
          }
    }
    return 1;
}

epublic: RobBankLs(playerid)
{
    if(GetPVarInt(playerid, "fRobBank"))
	{
		TogglePlayerControllableEx(playerid, 1);
		PlayerInfo[playerid][pBanki] = 1;
		SetPlayerAttachedObject(playerid, 9, 1550, 3, 0.1, 0.1, -0.1, 0.0, 270.0, 0.0, 1, 1, 1);
		ClearAnimations(playerid);
		DeletePVar(playerid, "fRobBank");
        SetPlayerGPS(playerid, -282.7677,-2174.3760,28.6580 ,5.0);
        ShowInfo(playerid,"Anda Berhasil Ngerob Bank");
        ShowInfo(playerid,"Sekarang, Bawalah Barang Itu Ke Tanda Di Peta Untuk Ditukar!");
	}
    else TogglePlayerControllableEx(playerid, 1);
    return 1;
}

epublic: HackBankLs(playerid)
{
    if(GetPVarInt(playerid, "fHack"))
	{
		TogglePlayerControllableEx(playerid, 1);
		PlayerInfo[playerid][pHackBank] = 1;
		ClearAnimations(playerid);
		DeletePVar(playerid, "fHack");
		GameTextForPlayer(playerid, "~r~terbobol", 3000, 0);
	}
    else TogglePlayerControllableEx(playerid, 1);
    return 1;
}

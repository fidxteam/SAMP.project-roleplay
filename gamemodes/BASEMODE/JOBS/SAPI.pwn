new DutyPeternak[MAX_PLAYERS];
#define MAX_LOKASI_SAPI 7
new Float:LokasiSapi[7][3] =
{
	 {-112.9958,-1522.0404,3.0280},
	 {-112.9399,-1524.8097,2.9450},
	 {-113.0517,-1527.7986,2.8629},
	 {-112.9300,-1530.6658,2.7742},
	 {-112.9432,-1533.9424,2.6998},
	 {-112.9286,-1536.8031,2.6635},
	 {-112.9264,-1539.5449,2.6223}
};

CreatePointSapi()
{
    new StrCodeSapi[260];
    CreateDynamicPickup(1275, 23, -110.8084,-1516.4492,3.0950, -1);
	format(StrCodeSapi, sizeof(StrCodeSapi), "DUTY PETERNAK\n GUNAKAN /DUTYPETERNAK\n OFFDUTY PETERNAK /DUTYPETERNAK \n >> UNTUK BEKERJA MENJADI PETANI/PETERNAK");
	CreateDynamic3DTextLabel(StrCodeSapi, COLOR_BLUE, -110.8084,-1516.4492,3.0950, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	for(new SapiJob; SapiJob < MAX_LOKASI_SAPI; SapiJob++)
	{
	    CreatePickup(2709, 23, LokasiSapi[SapiJob][0], LokasiSapi[SapiJob][1], LokasiSapi[SapiJob][2], 0);
	    CreateDynamic3DTextLabel("MEMERAS SUSU SAPI\n TEKAN [Y]\n >> UNTUK MEMERAS SUSU SAPI", COLOR_BLUE, LokasiSapi[SapiJob][0], LokasiSapi[SapiJob][1], LokasiSapi[SapiJob][2], 10.0);
	}
}

CMD:dutypeternak(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, -110.8084,-1516.4492,3.0950)) return ShowError(playerid, "Anda Harus Berada Di Markas Gojek");
    if(!DutyPeternak[playerid])
	{
		DutyPeternak[playerid] = 1;
		if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 158);
		else SetPlayerSkin(playerid, 157);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ShowInfo(playerid, "Berhasil OnDuty Peternak");
		ShowInfo(playerid, "Pergi Ke Dekat Sapi Lalu Tekan [ Y ]");
	}
	else
	{
		DutyPeternak[playerid] = 0;
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		ShowInfo(playerid, "Berhasil OffDuty Peternak");
	}
	return 1;
}

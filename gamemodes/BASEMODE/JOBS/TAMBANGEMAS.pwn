new DutyMinerOn[MAX_PLAYERS],
	MinerEmas[MAX_PLAYERS],
	MinerBatu[MAX_PLAYERS];
	
#define MAX_POINT_MINER 4
new Float:PointMiner[4][3] =
{
	 {451.3564,-882.4265,3.3113},
	 {450.7592,-875.9765,2.7160},
	 {451.7977,-879.2418,3.1985},
	 {451.2084,-884.5941,2.7160}
};

CreatePonitTambang()
{
    new StrCodeGojek[260];
    CreateDynamicPickup(1275, 23, 447.5744,-851.7632,29.8050, -1);
	format(StrCodeGojek, sizeof(StrCodeGojek), "DUTY TAMBANG\n CMD : /DUTYTAMBANG\n >> UNTUK ONDUTY DAN OFFDUTY");
	CreateDynamic3DTextLabel(StrCodeGojek, COLOR_BLUE, 447.5744,-851.7632,29.8050, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, 444.2808,-848.4777,29.8050, -1);
	format(StrCodeGojek, sizeof(StrCodeGojek), "TAMBANG\n CMD : /JUALEMASBATU\n >> UNTUK MENJUAL EMAS DAN BATU");
	CreateDynamic3DTextLabel(StrCodeGojek, COLOR_BLUE, 444.2808,-848.4777,29.8050, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, 444.8524,-849.0543,29.8050, -1);
	format(StrCodeGojek, sizeof(StrCodeGojek), "TEKAN [Y] \n >> UNTUK MASUK");
	CreateDynamic3DTextLabel(StrCodeGojek, COLOR_BLUE, 444.8524,-849.0543,29.8050, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, 440.0827,-856.7990,2.7160, -1);
	format(StrCodeGojek, sizeof(StrCodeGojek), "TEKAN [Y] \n >> UNTUK KELUAR");
	CreateDynamic3DTextLabel(StrCodeGojek, COLOR_BLUE, 440.0827,-856.7990,2.71600, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	for(new POINT; POINT < MAX_POINT_MINER; POINT++)
	{
	    CreatePickup(1239, 23, PointMiner[POINT][0], PointMiner[POINT][1], PointMiner[POINT][2], 0);
	    CreateDynamic3DTextLabel("{ff0000}MINER POINT{fffafa}\n{ffff00}TEKAN Y{fffafa}\n >> UNTUK MINER", COLOR_BLUE, PointMiner[POINT][0], PointMiner[POINT][1], PointMiner[POINT][2], 10.0);
	}
}

CMD:dutytambang(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 447.5744,-851.7632,29.8050)) return ShowError(playerid, "Anda Harus Berada Di Markas Gojek");
    if(!DutyMinerOn[playerid])
	{
		DutyMinerOn[playerid] = 1;
		if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 16);
		else SetPlayerSkin(playerid, 211);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ShowInfo(playerid, "Berhasil OnDuty Tambang");
		ShowInfo(playerid, "Masuk Ke Dalam Lalu Tekan Y");
	}
	else
	{
		DutyMinerOn[playerid] = 0;
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		ShowInfo(playerid, "Berhasil OffDuty Tambang");
	}
	return 1;
}

CMD:jualemasbatu(playerid, params[])
{
	new JumlahEmas, JumlahBatu;
	if(!IsPlayerInRangeOfPoint(playerid, 2, 444.2808,-848.4777,29.8050)) return ShowError(playerid, "Anda Harus Di Dekat Tambang Batu Emas");
    if(sscanf(params, "dd", JumlahEmas, JumlahBatu)) return ShowSyntax(playerid, "/jumlahemasbatu [JUMLAH EMAS] [JUMLAH BATU]");
    new HargaEmas = JumlahEmas * 10000;
    new HargaBatu = JumlahBatu * 5000;
	if(JumlahEmas < 0 || JumlahEmas > 500) return ShowInfo(playerid, "Jumlah Emas maximal 0 - 10.");
	if(JumlahBatu < 0 || JumlahEmas > 500) return ShowInfo(playerid, "Jumlah Batu maximal 0 - 5.");
	if(MinerEmas[playerid] < JumlahEmas) return ShowError(playerid, "Anda Tidak Memiliki Emas");
	if(MinerBatu[playerid] < JumlahBatu) return ShowError(playerid, "Anda Tidak Memiliki Batu");
	GivePlayerMoneyEx(playerid, HargaEmas, "hasil jual Emas");
	GivePlayerMoneyEx(playerid, HargaBatu, "hasil jual Batu");
	MinerEmas[playerid] -= JumlahEmas;
	MinerBatu[playerid] -= JumlahBatu;
	SCMF(playerid, -1, "Berhasil Menjual Emas Sebanyak {ffff00} [%d] {fffafa} Harga {7fff00} [%i] {fffafa}", JumlahEmas, HargaEmas);
	SCMF(playerid, -1, "Berhasil Menjual Batu Sebanyak {ffff00} [%d] {fffafa} Harga {7fff00} [%i] {fffafa}", JumlahBatu, HargaBatu);

	ShowSucces(playerid, "Berhasil Jual Garam");
	return 1;
}

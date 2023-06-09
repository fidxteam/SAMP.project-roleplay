#define MAX_GARAM 5

new GaramService[MAX_PLAYERS],
    GaramStart[MAX_PLAYERS],
    GaramDuty[MAX_PLAYERS],
	StockSyatem[MAX_PLAYERS];

new Float:RandomGaram[5][3] =
{
	{446.1100,-1900.2751,1.0702},
	{461.5081,-1896.0833,0.8627},
	{480.6394,-1897.2913,1.0336},
	{497.3434,-1901.1643,1.1944},
	{425.3671,-1903.3289,0.9601}
};

CreatePointGaram()
{
    new StrCodeGaram[260];
    CreateDynamicPickup(1239, 23, 447.0673,-1872.5562,4.3723, -1);
	format(StrCodeGaram, sizeof(StrCodeGaram), "PENJUAL GARAM\n GUNAKAN /JUALGARAM\n>> HARGA 10K PERSATU GARAM");
	CreateDynamic3DTextLabel(StrCodeGaram, COLOR_BLUE, 447.0673,-1872.5562,4.3723, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1275, 23, 444.9889,-1875.3264,4.3723, -1);
	format(StrCodeGaram, sizeof(StrCodeGaram), "GARAM DUTY\nGUNAKAN /DUTYGARAM\n >> UNTUK ONDUTY DAN OFFDUTY");
	CreateDynamic3DTextLabel(StrCodeGaram, COLOR_BLUE, 444.9889,-1875.3264,4.3723, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	for(new Garam; Garam < MAX_GARAM; Garam++)
	{
	    CreatePickup(19135, 23, RandomGaram[Garam][0], RandomGaram[Garam][1], RandomGaram[Garam][2], 0);
	    CreateDynamic3DTextLabel("GARAM POINT\n GUNAKAN /AMBILGARAM\n >> UNTUK MEGAMBIL GARAM", COLOR_BLUE, RandomGaram[Garam][0], RandomGaram[Garam][1], RandomGaram[Garam][2], 10.0);
	}
}

CMD:dutygaram(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 444.9889,-1875.3264,4.3723)) return ShowError(playerid, "Anda Harus Berada Di Markas Garam");
    if(!GaramDuty[playerid])
	{
		GaramDuty[playerid] = 1;
		if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 35);
		else SetPlayerSkin(playerid, 31);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ShowInfo(playerid, "Untuk Megambil Garam Gunakan /findgaram");
		ShowInfo(playerid, "Berhasil OnDuty Garam");
	}
	else
	{
		GaramDuty[playerid] = 0;
		BahanMakan[playerid] = 0;
		BahanMinum[playerid] = 0;
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		ShowInfo(playerid, "Berhasil OffDuty Garam");
	}
	return 1;
}

CMD:ambilgaram(playerid)
{
	new RandTerbaru = StockSyatem[playerid];
    if(!IsPlayerInRangeOfPoint(playerid, 2, RandomGaram[RandTerbaru][0], RandomGaram[RandTerbaru][1], RandomGaram[RandTerbaru][2])) return ShowError(playerid, "Anda Harus Berada Di Ladang Garam");
    if(GaramDuty[playerid] == 0) return ShowError(playerid, "Anda Belum Onduty");
    if(GaramStart[playerid] == 0) return ShowError(playerid, "Anda Belum Memulai Gunakan /FindGaram");
	GaramService[playerid] += 1;
	GaramStart[playerid] = 0;
	StockSyatem[playerid] = 0;
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ShowSucces(playerid, "Berhasil Megambil Garam Untuk Menjual Ke Ladang");
	return 1;
}

CMD:findgaram(playerid)
{
    if(GaramDuty[playerid] == 0) return ShowError(playerid, "Anda Belum Onduty");
    if(GaramStart[playerid] == 1) return ShowError(playerid, "Anda Sudah Melakukan Pencarian Garam");

    new rand = random(5);
    SetPlayerCheckpoint(playerid, RandomGaram[rand][0], RandomGaram[rand][1], RandomGaram[rand][2], 7.0);
    GaramStart[playerid] = 1;
    StockSyatem[playerid] = rand;
    ShowSucces(playerid, "Anda Sekarang Berhasil Menemukan Garam Siap Panen Segera Ke Sana");
	return 1;
}

CMD:jualgaram(playerid, params[])
{
	new JumlahGaram;
	if(!IsPlayerInRangeOfPoint(playerid, 2, 447.0673,-1872.5562,4.3723)) return ShowError(playerid, "Anda Harus Berada Di Toko Pembeli Garam");
    if(sscanf(params, "d", JumlahGaram)) return ShowSyntax(playerid, "/JualGaram [Jumlah]");
    new HargaGaram = JumlahGaram * 10000;
	if(JumlahGaram < 0 || JumlahGaram > 500) return ShowInfo(playerid, "JumlahGaram maximal 0 - 10.");
	if(GaramService[playerid] < JumlahGaram) return ShowError(playerid, "Anda Tidak Memiliki Garam");
	GivePlayerMoneyEx(playerid, HargaGaram, "hasil jual Garam");
	GaramService[playerid] -= JumlahGaram;
	SCMF(playerid, -1, "BERHASIL MENJUAL Garam %d HARGA %i", JumlahGaram, HargaGaram);

	ShowSucces(playerid, "Berhasil Jual Garam");
	return 1;
}

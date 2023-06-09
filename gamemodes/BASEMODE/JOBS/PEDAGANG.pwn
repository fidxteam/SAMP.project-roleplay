CreatePointPedagang()
{
    new StrCodePedagang[260];
    CreateDynamicPickup(1275, 23, 1271.4315,-1545.9287,13.8382, -1);
	format(StrCodePedagang, sizeof(StrCodePedagang), "DUTY PEDAGANG\n GUNAKAN /DUTYPEDAGANG\n OFFDUTY PEDAGANG /DUTYPEDAGANG \n >> UNTUK BEKERJA MENJADI PETUGAS PEDAGANG");
	CreateDynamic3DTextLabel(StrCodePedagang, COLOR_BLUE, 1271.4315,-1545.9287,13.8382, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	CreateDynamicPickup(1239, 23, 1270.9558,-1546.7205,13.8457, -1);
	format(StrCodePedagang, sizeof(StrCodePedagang), "MAKAN\n GUNAKAN /AMBILAYAM \n >> UNTUK MEGAMBIL MAKANAN");
	CreateDynamic3DTextLabel(StrCodePedagang, COLOR_BLUE, 1270.9558,-1546.7205,13.8457, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, 1273.3864,-1545.8881,13.8383, -1);
	format(StrCodePedagang, sizeof(StrCodePedagang), "MINUM\n GUNAKAN /AMBILSUSU \n >> UNTUK MEGAMBIL MINUMAN");
	CreateDynamic3DTextLabel(StrCodePedagang, COLOR_BLUE, 1273.3864,-1545.8881,13.8383, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
}

CMD:dutypedagang(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 1271.4315,-1545.9287,13.8382)) return ShowError(playerid, "Anda Harus Berada Di Markas Pedagang");
    if(!IsAPedagang(playerid)) return ShowInfo(playerid, "Anda bukan Pedagang!.");
    if(!DutyPedagang[playerid])
	{
		DutyPedagang[playerid] = 1;
		if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 155);
		else SetPlayerSkin(playerid, 205);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ShowInfo(playerid, "Berhasil OnDuty Pedagang");
	}
	else
	{
		DutyPedagang[playerid] = 0;
		BahanMakan[playerid] = 0;
		BahanMinum[playerid] = 0;
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		ShowInfo(playerid, "Berhasil OffDuty Pedagang");
	}
	return 1;
}

CMD:ambilayam(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 1270.9558,-1546.7205,13.8457)) return ShowError(playerid, "Anda Harus Berada Di Markas Pedagang");
    if(!IsAPedagang(playerid)) return ShowInfo(playerid, "Anda bukan Pedagang!.");
    if(DutyPedagang[playerid] == 0) return ShowError(playerid, "Anda Belum Bekerjaan Sebagai Petugas Pedagang");
	new JumlahStock;
	if(sscanf(params, "d", JumlahStock)) return ShowSyntax(playerid, "/AmbilAyam [JUMLAH]");
	if(BahanMakan[playerid] > 5) return ShowError(playerid, "Anda Sudah Memiliki Lebih dari 5");
	if(JumlahStock < 1 || JumlahStock > 5) return ShowInfo(playerid, "Harga Hanya Bisa 1 Hingga 5");

	BahanMakan[playerid] += JumlahStock;
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ShowInfo(playerid, "Berhasil Megambil Ayam");
	return 1;
}

CMD:ambilsusu(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 1273.3864,-1545.8881,13.8383)) return ShowError(playerid, "Anda Harus Berada Di Markas Pedagang");
    if(!IsAPedagang(playerid)) return ShowInfo(playerid, "Anda bukan Pedagang!.");
    if(DutyPedagang[playerid] == 0) return ShowError(playerid, "Anda Belum Bekerjaan Sebagai Petugas Pedagang");
	new JumlahStock;
	if(sscanf(params, "d", JumlahStock)) return ShowSyntax(playerid, "/AmbilSusu [JUMLAH]");
	if(BahanMakan[playerid] > 5) return ShowError(playerid, "Anda Sudah Memiliki Lebih dari 5");
	if(JumlahStock < 1 || JumlahStock > 5) return ShowInfo(playerid, "Harga Hanya Bisa 1 Hingga 5");

	BahanMinum[playerid] += JumlahStock;
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ShowInfo(playerid, "Berhasil Megambil Susu");
	return 1;
}

CMD:givefood(playerid, params[])
{
	new Target, JumlahStock, Harga;
	if(sscanf(params, "udd", Target, JumlahStock, Harga)) return ShowSyntax(playerid, "/GiveFood [ID PLAYER] [JUMLAH] [HARGA]");
	if(!IsAPedagang(playerid)) return ShowInfo(playerid, "Anda bukan Pedagang!.");
	if(BahanMakan[playerid] < JumlahStock) return ShowError(playerid, "Anda Tidak Memiliki Jumlah Stock Sebanyak Itu");
	if(Harga < 1 || Harga > 1000000) return ShowInfo(playerid, "Harga Hanya Bisa 10000 Hingga 25000");
	
	GivePlayerMoneyEx(Target, -Harga, "Pedagang Jualan");
	GivePlayerMoneyEx(playerid, Harga, "Pedagang Jualan");
	BahanMakan[playerid] -= JumlahStock;
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ApplyAnimation(Target, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ShowInfo(playerid, "Berhasil Mmemberikan Ayam");
	ShowInfo(Target, "Anda Baru Saja Di Beri Ayam");
	return 1;
}

CMD:givedrink(playerid, params[])
{
    new Target, JumlahStock, Harga;
	if(sscanf(params, "udd", Target, JumlahStock, Harga)) return ShowSyntax(playerid, "/GiveFood [ID PLAYER] [JUMLAH] [HARGA]");
	if(!IsAPedagang(playerid)) return ShowInfo(playerid, "Anda bukan Pedagang!.");
    if(BahanMinum[playerid] < JumlahStock) return ShowError(playerid, "Anda Tidak Memiliki Jumlah Stock Sebanyak Itu");
    if(Harga < 1 || Harga > 1000000) return ShowInfo(playerid, "Harga Hanya Bisa 10000 Hingga 25000");
    
	GivePlayerMoneyEx(Target, -Harga, "Pedagang Jualan");
	GivePlayerMoneyEx(playerid, Harga, "Pedagang Jualan");
	BahanMinum[playerid] -= JumlahStock;
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ApplyAnimation(Target, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	ShowInfo(playerid, "Berhasil Mmemberikan Susu");
	ShowInfo(Target, "Anda Baru Saja Di Beri Susu");
	return 1;
}

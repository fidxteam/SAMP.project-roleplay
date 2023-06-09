#define MAX_RANDOM_INDIHOME 7
new Float:RandomIndiHome[7][3] =
{
	 {1904.6653,-1946.0804,13.5469},
	 {1929.5248,-1945.9526,13.5543},
	 {1951.3820,-1945.2133,13.5469},
	 {2091.1621,-1827.3114,13.5545},
	 {2091.1621,-1827.3114,13.5545},
	 {2087.6345,-1743.1956,13.5519},
	 {2017.6399,-1603.2557,13.5392}
};

CreatePointIndiHome()
{
    new StrCodeIndiHome[260];
    CreateDynamicPickup(1275, 23, 303.3354,-226.4888,1.5836, -1);
	format(StrCodeIndiHome, sizeof(StrCodeIndiHome), "DUTY INDIHOME\n GUNAKAN /DUTYINDIHOME\n OFFDUTY INDIHOME /DUTYINDIHOME \n >> UNTUK BEKERJA MENJADI PETUGAS INDIHOME");
	CreateDynamic3DTextLabel(StrCodeIndiHome, COLOR_BLUE, 303.3354,-226.4888,1.5836, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //
	
	CreateDynamicPickup(1239, 23, 303.1586,-238.0738,1.5781, -1);
	format(StrCodeIndiHome, sizeof(StrCodeIndiHome), "KENDARAAN PETUGAS INDIHOME\n GUNAKAN /HOMECAR \n >> UNTUK MEGAMBIL KENDARAAN PETUGAS INDIHOME");
	CreateDynamic3DTextLabel(StrCodeIndiHome, COLOR_BLUE, 303.1586,-238.0738,1.5781, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	for(new IndiHome; IndiHome < MAX_RANDOM_INDIHOME; IndiHome++)
	{
	    CreatePickup(1252, 23, RandomIndiHome[IndiHome][0], RandomIndiHome[IndiHome][1], RandomIndiHome[IndiHome][2], 0);
	    CreateDynamic3DTextLabel("SERVICE INDIHOME\n /SERVICEHOME\n >> UNTUK MELAKUKAN SERVICE", COLOR_BLUE, RandomIndiHome[IndiHome][0], RandomIndiHome[IndiHome][1], RandomIndiHome[IndiHome][2], 10.0);
	}
}

CMD:dutyindihome(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 303.3354,-226.4888,1.5836)) return ShowError(playerid, "Anda Harus Berada Di Markas IndiHome");
    if(!DutyIndiHome[playerid])
	{
		DutyIndiHome[playerid] = 1;
		if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 260);
		else SetPlayerSkin(playerid, 93);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ShowInfo(playerid, "Berhasil OnDuty IndiHome");
		ShowInfo(playerid, "Gunakan /HomeService Untuk Bekerja");
		ShowInfo(playerid, "Pergi Ke Samping Untuk /HomeCar");
	}
	else
	{
		DutyIndiHome[playerid] = 0;
		IndiHomeStart[playerid] = 0;
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		ShowInfo(playerid, "Berhasil Off Duty IndiHome");
	}
	return 1;
}

CMD:servicehome(playerid)
{
	new RandTerbaru = AgusSampSystem[playerid];
    if(!IsPlayerInRangeOfPoint(playerid, 4, RandomIndiHome[RandTerbaru][0], RandomIndiHome[RandTerbaru][1], RandomIndiHome[RandTerbaru][2])) return ShowError(playerid, "Anda Harus Berada Di Tiang IndiHome");
    if(DutyIndiHome[playerid] == 0) return ShowError(playerid, "Anda Belum Bekerjaan Sebagai Petugas IndiHome");
    if(IndiHomeStart[playerid] == 0) return ShowError(playerid, "Anda Belum Memulai Gunakan /HomeService");
	IndiHomeService[playerid] += 1;
	IndiHomeStart[playerid] = 0;
	ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
	GivePlayerMoneyEx(playerid, 15000, "GAJI INDIHOME");
	ShowInfo(playerid, "Berhasil Service Tilang Listrik /homeservice Untuk Melanjutkan");
	ShowInfo(playerid, "Anda Di Gaji Untuk Tiang Listrik Ini Rp.15.000");
	return 1;
}

CMD:homeservice(playerid)
{
    if(DutyIndiHome[playerid] == 0) return ShowError(playerid, "Anda Belum Bekerjaan Sebagai Petugas IndiHome");
    if(IndiHomeStart[playerid] == 1) return ShowError(playerid, "Anda Sudah Melakukan Pencarian Tiang");
    
    new rand = random(7);
    SetPlayerCheckpoint(playerid, RandomIndiHome[rand][0], RandomIndiHome[rand][1], RandomIndiHome[rand][2], 7.0);
    IndiHomeStart[playerid] = 1;
    AgusSampSystem[playerid] = rand;
    ShowInfo(playerid, "Anda Sekarang Berhasil Menemukan Tiang Rusak Segera Ke Sana");
	return 1;
}

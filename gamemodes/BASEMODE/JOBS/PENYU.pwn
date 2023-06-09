new DutyTelurPenyu[MAX_PLAYERS],
	TelurPenyuStart[MAX_PLAYERS],
    TelurPenyu[MAX_PLAYERS],
	FindByAgus[MAX_PLAYERS];
    

#define MAX_RANDOM_PENYU 28
new Float:RandomPenyu[28][3] =
{
	 {235.038757, -1896.293090, 0.015315}, //1
	 {231.638778, -1899.473266, 0.015315}, //2
	 {233.998748, -1901.553222, 0.015315}, //3
	 {238.018722, -1900.713012, 0.015315}, //4
	 {226.968704, -1906.342773, 0.015315}, //5
	 {230.528747, -1905.742797, 0.015315}, //6
	 {229.118850, -1902.482543, 0.015315}, //7
	 {212.638778, -1899.473266, 0.015315}, //8
	 {214.998748, -1901.553222, 0.015315}, //9
	 {219.018722, -1900.713012, 0.015315}, //10
	 {207.968704, -1906.342773, 0.015315}, //11
	 {211.528747, -1905.742797, 0.015315}, //12
	 {210.118850, -1902.482543, 0.015315}, //13
	 {192.638778, -1899.473266, 0.015315}, //14
	 {194.998748, -1901.553222, 0.015315}, //15
	 {199.018722, -1900.713012, 0.015315}, //16
	 {187.968704, -1906.342773, 0.015315}, //17
	 {191.528747, -1905.742797, 0.015315}, //18
	 {190.118850, -1902.482543, 0.015315}, //19
	 {199.018722, -1919.713012, 0.015315}, //20
	 {187.968704, -1925.342773, 0.015315}, //21
	 {191.528747, -1924.742797, 0.015315}, //22
	 {190.118850, -1921.482543, 0.015315}, //23
	 {212.638778, -1918.473266, 0.015315}, //24
	 {214.998748, -1920.553222, 0.015315}, //25
	 {219.018722, -1919.713012, 0.015315}, //26
	 {207.968704, -1925.342773, 0.015315}, //27
	 {211.528747, -1924.742797, 0.015315} //28
};

CreatePointTelurPenyu()
{
    new StrCodePenyu[260];
    CreateDynamicPickup(1275, 23, 200.4407,-1874.7971,3.7082, -1);
	format(StrCodePenyu, sizeof(StrCodePenyu), "DUTY TELUR PENYU\n CMD : DUTYPENYU\n >> UNTUK ONDUTY DAN OFFDUTY TELUR PENYU");
	CreateDynamic3DTextLabel(StrCodePenyu, COLOR_BLUE, 200.4407,-1874.7971,3.7082, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	CreateDynamicPickup(1239, 23, 202.3781,-1873.0271,3.7082, -1);
	format(StrCodePenyu, sizeof(StrCodePenyu), "SIMPAN TELUR\n TEKAN [Y]\n>> UNTUK MEYIMPAN TELUR PENYU");
	CreateDynamic3DTextLabel(StrCodePenyu, COLOR_BLUE, 202.3781,-1873.0271,3.7082, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); //

	for(new Telur; Telur < MAX_RANDOM_PENYU; Telur++)
	{
	    CreatePickup(1252, 23, RandomPenyu[Telur][0], RandomPenyu[Telur][1], RandomPenyu[Telur][2], 0);
	    CreateDynamic3DTextLabel("TELUR PENYU\n TEKAN [Y]\n>> UNTUK MEHAMBIL TELUR PENYU", COLOR_BLUE, RandomPenyu[Telur][0], RandomPenyu[Telur][1], RandomPenyu[Telur][2], 10.0);
	}
}

CMD:dutypenyu(playerid)
{
    if(!IsPlayerInRangeOfPoint(playerid, 7, 200.4407,-1874.7971,3.7082)) return ShowError(playerid, "Anda Harus Berada Di Markas Penyu");
    if(!DutyTelurPenyu[playerid])
	{
		DutyTelurPenyu[playerid] = 1;
		if(PlayerInfo[playerid][pSex] == 1) SetPlayerSkin(playerid, 45);
		else SetPlayerSkin(playerid, 145);
		ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
		ShowInfo(playerid, "Berhasil OnDuty Penyu");
		ShowInfo(playerid, "Gunakan /PenyuFind Untuk Bekerja");
	}
	else
	{
		DutyTelurPenyu[playerid] = 0;
		TelurPenyuStart[playerid] = 0;
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		ShowInfo(playerid, "Berhasil Off Duty Penyu");
	}
	return 1;
}

CMD:penyufind(playerid)
{
    if(DutyTelurPenyu[playerid] == 0) return ShowError(playerid, "Anda Belum Bekerja Sebagai Telur Penyu");
    if(TelurPenyuStart[playerid] == 1) return ShowError(playerid, "Anda Sudah Mencari Telur");

    new rand = random(28);
    SetPlayerCheckpoint(playerid, RandomPenyu[rand][0], RandomPenyu[rand][1], RandomPenyu[rand][2], 5.0);
    TelurPenyuStart[playerid] = 1;
    FindByAgus[playerid] = rand;
    ShowInfo(playerid, "Telur Penyu Terlihat Segera Ke Sana");
	return 1;
}

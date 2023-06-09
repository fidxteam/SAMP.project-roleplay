// JOB TRUCKER
enum TruckerInfo
{
	pTruckerDuty,
	pTruckerMoney,
	pTruckerCompo
}

new TruckerData[MAX_PLAYERS][TruckerInfo];

#define DIALOG_SELL_COMPONENT 1108
#define DIALOG_JUAL_COMPONENT 1109

CreatePointTrucker()
{
    new jobstr[460];
    
    CreateDynamicPickup(1275, 23, 1227.6866,181.6240,20.4101, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[TRUCKER POINT]\n{ffffff}NAMA: {ffff00}TRUCKER KERJA\n{ffffff}>> CMD : DUTYTRUCKER CMD : OFFTRUCKER {ffffff}UNTUK BEKERJA TRUCKER");
	CreateDynamic3DTextLabel(jobstr, -1, 1227.6866,181.6240,20.4101, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(954, 23, 1202.8326,174.5572,20.5029, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[TRUCKER POINT]\n{ffffff}NAMA: {ffff00}TRUCKER UNLOAD\n{ffffff}>> CMD : UNLOADCOMPONENT {ffffff}UNTUK UNLOAD COMPONENT");
	CreateDynamic3DTextLabel(jobstr, -1, 1202.8326,174.5572,20.5029, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

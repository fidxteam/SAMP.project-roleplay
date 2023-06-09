// JOB COMPONENT
enum pMiner
{
	pMinerDuty,
	pMoneyMiner,
	pMinerLevel,
}
new pMinerOn[MAX_PLAYERS][pMiner];

#define DIALOG_SIMPAN_MINERAL 870

CreatePointComponent()
{
    new jobstr[130];
	CreateDynamicPickup(1275, 23, 602.1800,867.8798,-42.9609, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER GETJOB]\n{ffffff}NAMA: {ffff00}MINER JOBS\n{ffffff}>> CMD : DUTYMINER CMD : OFFMINER {ffffff}UNTUK BEKERJA SEBAGIA MINER");
	CreateDynamic3DTextLabel(jobstr, -1, 602.1800,867.8798,-42.9609, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 613.5657,865.8920,-42.9609, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 613.5657,865.8920,-42.9609, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 633.0966,859.0549,-42.9067, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 633.0966,859.0549,-42.9067, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 618.2393,813.6473,-42.9609, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 618.2393,813.6473,-42.9609, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 648.2403,807.5249,-42.8494, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 648.2403,807.5249,-42.8494, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 661.4178,809.3361,-42.3277, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 661.4178,809.3361,-42.3277, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 626.2418,807.8336,-42.9609, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 626.2418,807.8336,-42.9609, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 607.1849,810.4722,-42.5829, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 607.1849,810.4722,-42.5829, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1239, 23, 620.7202,805.8942,-36.3682, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[MINER POINT]\n{ffffff}NAMA: {ffff00}MINER ON\n{ffffff}>> CMD : MINER {ffffff}UNTUK MEGAMBIL MINERAL DLL");
	CreateDynamic3DTextLabel(jobstr, -1, 620.7202,805.8942,-36.3682, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	
	CreateDynamicPickup(1252, 23, 590.0835,873.1124,-42.4973, -1);
	format(jobstr, sizeof(jobstr), "{08DBFC}[TEMPAT MEYIMPAN MINERAL]\n{ffffff}NAMA: {ffff00}MINERAL POINT\n{ffffff}>> CMD : SIMPANMINERAL {ffffff}UNTUK MEYIMPAN MINERAL");
	CreateDynamic3DTextLabel(jobstr, -1, 590.0835,873.1124,-42.4973, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

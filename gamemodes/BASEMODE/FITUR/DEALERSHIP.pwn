#define MAX_DEALERSHIP 50

enum D_DEALERSHIP
{
	DD_NAME[512],
	Float:DD_POS_X,
	Float:DD_POS_Y,
	Float:DD_POS_Z,
	Float:FF_POS_X,
	Float:FF_POS_Y,
	Float:FF_POS_Z,
	Float:FF_POS_A,
	DD_TYPE,
    DD_ID
}
new DEALERSHIPDATA[MAX_DEALERSHIP][D_DEALERSHIP];
new Text3D:DD_LABELS[MAX_DEALERSHIP],
	DD_PICKUP[MAX_DEALERSHIP],
	DD_POS_PICKUP[MAX_DEALERSHIP],
	Text3D:DD_POS_LABELS[MAX_DEALERSHIP],
	DD_MAP_ICON[MAX_DEALERSHIP];


stock LoadMyDealerShip()
{
	new file[500];
	for(new i=0; i < MAX_DEALERSHIP; i++)
	{
	    format(file,sizeof(file),"Database/DealerShip/[%d].dat",i);
	    if(dini_Exists(file))
	    {
			format(DEALERSHIPDATA[i][DD_NAME],24,"%s",dini_Get(file,"Nama"));
		    DEALERSHIPDATA[i][DD_POS_X] = dini_Float(file,"PosX");
		    DEALERSHIPDATA[i][DD_POS_Y] = dini_Float(file,"PosY");
		    DEALERSHIPDATA[i][DD_POS_Z] = dini_Float(file,"PosZ");
		    DEALERSHIPDATA[i][FF_POS_X] = dini_Float(file,"FPosX");
		    DEALERSHIPDATA[i][FF_POS_Y] = dini_Float(file,"FPosY");
		    DEALERSHIPDATA[i][FF_POS_Z] = dini_Float(file,"FPosZ");
		    DEALERSHIPDATA[i][FF_POS_A] = dini_Float(file,"FPosA");
		    DEALERSHIPDATA[i][DD_TYPE] = dini_Int(file,"TYPE");
		    DEALERSHIPDATA[i][DD_ID] = dini_Int(file,"UID");
		    UpdateDealerShip(i);
		}
	}
}

stock SaveMyDeaerShip()
{
	new file[500];
	for(new i=0; i < MAX_DEALERSHIP; i++)
	{
	    format(file,sizeof(file),"Database/DealerShip/[%d].dat",i);
	    if(dini_Exists(file))
	    {
			dini_Set(file,"Nama",DEALERSHIPDATA[i][DD_NAME]);
			dini_FloatSet(file,"PosX",DEALERSHIPDATA[i][DD_POS_X]);
			dini_FloatSet(file,"PosY",DEALERSHIPDATA[i][DD_POS_Y]);
			dini_FloatSet(file,"PosZ",DEALERSHIPDATA[i][DD_POS_Z]);
			dini_FloatSet(file,"FPosX",DEALERSHIPDATA[i][FF_POS_X]);
			dini_FloatSet(file,"FPosY",DEALERSHIPDATA[i][FF_POS_Y]);
			dini_FloatSet(file,"FPosZ",DEALERSHIPDATA[i][FF_POS_Z]);
			dini_FloatSet(file,"FPosA",DEALERSHIPDATA[i][FF_POS_A]);
			dini_IntSet(file,"TYPE",DEALERSHIPDATA[i][DD_TYPE]);
			dini_IntSet(file,"UID",DEALERSHIPDATA[i][DD_ID]);
		}
	}
}

stock SaveMyDealerShips(TMD_ID)
{
	new file[500];
	format(file,sizeof(file),"Database/DealerShip/[%d].dat", TMD_ID);
	if(dini_Exists(file))
    {
        dini_Set(file,"Nama",DEALERSHIPDATA[TMD_ID][DD_NAME]);
		dini_FloatSet(file,"PosX",DEALERSHIPDATA[TMD_ID][DD_POS_X]);
		dini_FloatSet(file,"PosY",DEALERSHIPDATA[TMD_ID][DD_POS_Y]);
		dini_FloatSet(file,"PosZ",DEALERSHIPDATA[TMD_ID][DD_POS_Z]);
		dini_FloatSet(file,"FPosX",DEALERSHIPDATA[TMD_ID][FF_POS_X]);
		dini_FloatSet(file,"FPosY",DEALERSHIPDATA[TMD_ID][FF_POS_Y]);
		dini_FloatSet(file,"FPosZ",DEALERSHIPDATA[TMD_ID][FF_POS_Z]);
		dini_FloatSet(file,"FPosA",DEALERSHIPDATA[TMD_ID][FF_POS_A]);
		dini_IntSet(file,"TYPE",DEALERSHIPDATA[TMD_ID][DD_TYPE]);
		dini_IntSet(file,"UID",DEALERSHIPDATA[TMD_ID][DD_ID]);
	}
}

stock UpdateDealerShip(TMD_ID)
{
	DestroyDynamic3DTextLabel(DD_LABELS[TMD_ID]);
	DestroyDynamicPickup(DD_PICKUP[TMD_ID]);
	DestroyDynamic3DTextLabel(DD_POS_LABELS[TMD_ID]);
	DestroyDynamicPickup(DD_POS_PICKUP[TMD_ID]);

    if(DEALERSHIPDATA[TMD_ID][DD_TYPE] == 1)
    {
		new string[2048];
		format(string, sizeof(string), "DEALERSHIP ID %d\nTYPE {ffff00}MOTOR{ffffff}\n CMD : {ffff00}/BUYPV{ffffff}\n >> UNTUK MEMBELI MOTOR", TMD_ID);
		DD_LABELS[TMD_ID] = CreateDynamic3DTextLabel(string, -1, DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z]+0.1, 10.0);
		DD_PICKUP[TMD_ID] = CreateDynamicPickup(1239, 1,DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z]);
		DD_MAP_ICON[TMD_ID] = CreateDynamicMapIcon(DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z], 55, 0, 0, -1, -1, 100.0);

		format(string, sizeof(string), "DEALERSHIP ID %d\nTYPE {ffff00}MOTOR{ffffff}\n CMD : {ffff00}/CAR{ffffff}\n >> UNTUK MEGAMBIL KENDARAAN", TMD_ID);
		DD_POS_LABELS[TMD_ID] = CreateDynamic3DTextLabel(string, -1, DEALERSHIPDATA[TMD_ID][FF_POS_X],DEALERSHIPDATA[TMD_ID][FF_POS_Y],DEALERSHIPDATA[TMD_ID][FF_POS_Z]+0.1, 10.0);
		DD_POS_PICKUP[TMD_ID] = CreateDynamicPickup(1239, 1,DEALERSHIPDATA[TMD_ID][FF_POS_X],DEALERSHIPDATA[TMD_ID][FF_POS_Y],DEALERSHIPDATA[TMD_ID][FF_POS_Z]);
	}
	if(DEALERSHIPDATA[TMD_ID][DD_TYPE] == 2)
    {
		new string[2048];
		format(string, sizeof(string), "DEALERSHIP ID %d\nTYPE {ffff00}MED CAR{ffffff}\n CMD : {ffff00}/BUYPV{ffffff}\n >> UNTUK MEMBELI MOBIL", TMD_ID);
		DD_LABELS[TMD_ID] = CreateDynamic3DTextLabel(string, -1, DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z]+0.1, 10.0);
		DD_PICKUP[TMD_ID] = CreateDynamicPickup(1239, 1,DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z]);
		DD_MAP_ICON[TMD_ID] = CreateDynamicMapIcon(DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z], 55, 0, 0, -1, -1, 100.0);

		format(string, sizeof(string), "DEALERSHIP ID %d\nTYPE {ffff00}MED CAR{ffffff}\n CMD : {ffff00}/CAR{ffffff}\n >> UNTUK MEGAMBIL KENDARAAN", TMD_ID);
		DD_POS_LABELS[TMD_ID] = CreateDynamic3DTextLabel(string, -1, DEALERSHIPDATA[TMD_ID][FF_POS_X],DEALERSHIPDATA[TMD_ID][FF_POS_Y],DEALERSHIPDATA[TMD_ID][FF_POS_Z]+0.1, 10.0);
		DD_POS_PICKUP[TMD_ID] = CreateDynamicPickup(1239, 1,DEALERSHIPDATA[TMD_ID][FF_POS_X],DEALERSHIPDATA[TMD_ID][FF_POS_Y],DEALERSHIPDATA[TMD_ID][FF_POS_Z]);
	}
	if(DEALERSHIPDATA[TMD_ID][DD_TYPE] == 3)
    {
		new string[2048];
		format(string, sizeof(string), "DEALERSHIP ID %d\nTYPE {ffff00}HIGH CAR{ffffff}\n CMD : {ffff00}/BUYPV{ffffff}\n >> UNTUK MEMBELI MOBIL SPORT", TMD_ID);
		DD_LABELS[TMD_ID] = CreateDynamic3DTextLabel(string, -1, DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z]+0.1, 10.0);
		DD_PICKUP[TMD_ID] = CreateDynamicPickup(1239, 1,DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z]);
		DD_MAP_ICON[TMD_ID] = CreateDynamicMapIcon(DEALERSHIPDATA[TMD_ID][DD_POS_X],DEALERSHIPDATA[TMD_ID][DD_POS_Y],DEALERSHIPDATA[TMD_ID][DD_POS_Z], 55, 0, 0, -1, -1, 100.0);

		format(string, sizeof(string), "DEALERSHIP ID %d\nTYPE {ffff00}HIGH CAR{ffffff}\n CMD : {ffff00}/CAR{ffffff}\n >> UNTUK MEGAMBIL KENDARAAN", TMD_ID);
		DD_POS_LABELS[TMD_ID] = CreateDynamic3DTextLabel(string, -1, DEALERSHIPDATA[TMD_ID][FF_POS_X],DEALERSHIPDATA[TMD_ID][FF_POS_Y],DEALERSHIPDATA[TMD_ID][FF_POS_Z]+0.1, 10.0);
		DD_POS_PICKUP[TMD_ID] = CreateDynamicPickup(1239, 1,DEALERSHIPDATA[TMD_ID][FF_POS_X],DEALERSHIPDATA[TMD_ID][FF_POS_Y],DEALERSHIPDATA[TMD_ID][FF_POS_Z]);
	}
}

CMD:createdealership(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
	new namanya[512], Type, file[500];
	if(sscanf(params,"s[50]d", namanya, Type)) return TextAgus(playerid, -1, "USAGE: /CreateDealership <Name> <Type 1-3>");
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	for(new i=0;i<MAX_DEALERSHIP;i++)
	{
        format(file,sizeof(file),"Database/DealerShip/[%d].dat",i);
   	    if(!(dini_Exists(file)))
   	    {
			format(DEALERSHIPDATA[i][DD_NAME], 512, namanya);
			DEALERSHIPDATA[i][DD_ID] = i;
			DEALERSHIPDATA[i][DD_TYPE] = Type;
			DEALERSHIPDATA[i][DD_POS_X] = X;
			DEALERSHIPDATA[i][DD_POS_Y] = Y;
			DEALERSHIPDATA[i][DD_POS_Z] = Z;
			DEALERSHIPDATA[i][FF_POS_X] = 0;
			DEALERSHIPDATA[i][FF_POS_Y] = 0;
			DEALERSHIPDATA[i][FF_POS_Z] = 0;
            dini_Create(file);
            UpdateDealerShip(i);
            SaveMyDealerShips(i);
			ShowInfo(playerid, "Dynamic Dealership Berhasil Di Buat Jangan Lupa /EditDealership");
			return 1;
        }
    }
	return 1;
}

CMD:editdealership(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
    new DelaerShipId;
    if(sscanf(params,"d", DelaerShipId)) return TextAgus(playerid, -1, "USAGE: /EditDealerShip <Name>");

    new Float:X, Float:Y, Float:Z, Float:Angle;
	GetPlayerPos(playerid, X,Y,Z);
    GetPlayerFacingAngle(playerid, Angle);
    DEALERSHIPDATA[DelaerShipId][FF_POS_X] = X;
	DEALERSHIPDATA[DelaerShipId][FF_POS_Y] = Y;
	DEALERSHIPDATA[DelaerShipId][FF_POS_Z] = Z;
	DEALERSHIPDATA[DelaerShipId][FF_POS_A] = Angle;
	UpdateDealerShip(DelaerShipId);
	SaveMyDealerShips(DelaerShipId);
	ShowInfo(playerid, "Berhasil Edit Lokasi Spawn Kendaraan");
	return 1;
}

CMD:hapusdealership(playerid,params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
    for(new i=0; i < MAX_DEALERSHIP; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, DEALERSHIPDATA[i][DD_POS_X], DEALERSHIPDATA[i][DD_POS_Y], DEALERSHIPDATA[i][DD_POS_Z]))
	    {
			DEALERSHIPDATA[i][DD_ID] = 0;
			DEALERSHIPDATA[i][DD_TYPE] = 0;
			DEALERSHIPDATA[i][DD_POS_X] = 0;
			DEALERSHIPDATA[i][DD_POS_Y] = 0;
			DEALERSHIPDATA[i][DD_POS_Z] = 0;
			DEALERSHIPDATA[i][FF_POS_X] = 0;
			DEALERSHIPDATA[i][FF_POS_Y] = 0;
			DEALERSHIPDATA[i][FF_POS_Z] = 0;
			DestroyDynamic3DTextLabel(DD_LABELS[i]);
			DestroyDynamicPickup(DD_PICKUP[i]);
			DestroyDynamic3DTextLabel(DD_POS_LABELS[i]);
			DestroyDynamicPickup(DD_POS_PICKUP[i]);
	    	DestroyDynamicMapIcon(DD_MAP_ICON[i]);
			new file[128];
			format(file,sizeof(file),"Database/DealerShip/[%d].dat",i);
			dini_Remove(file);
			ShowInfo(playerid, "Anda Menghapus Dynamic Dealership");
			return 1;
		}
	}
	TextAgus(playerid, -1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Dealership mana pun.");
	return 1;
}


#define MAX_RENTCAR 500

enum E_RENTCAR
{
	RC_NAME[512],
	Float:RC_POS_X,
	Float:RC_POS_Y,
	Float:RC_POS_Z,
    RC_ID
}
new RentCarData[MAX_RENTCAR][E_RENTCAR];
new Text3D:RC_LABELS[MAX_RENTCAR],
	RC_PICKUP[MAX_RENTCAR];

stock LoadMyRentCar()
{
	new file[128];
	for(new i=0; i < MAX_RENTCAR; i++)
	{
	    format(file,sizeof(file),"Database/RentCar/[%d].ini",i);
	    if(dini_Exists(file))
	    {
			format(RentCarData[i][RC_NAME],24,"%s",dini_Get(file,"Nama"));
		    RentCarData[i][RC_POS_X] = dini_Float(file,"PosX");
		    RentCarData[i][RC_POS_Y] = dini_Float(file,"PosY");
		    RentCarData[i][RC_POS_Z] = dini_Float(file,"PosZ");
		    RentCarData[i][RC_ID] = dini_Int(file,"UID");
		    UpdateRentCar(i);
		}
	}
}

stock SaveMyRentCar()
{
	new file[128];
	for(new i=0; i < MAX_RENTCAR; i++)
	{
	    format(file,sizeof(file),"Database/RentCar/[%d].ini",i);
	    if(dini_Exists(file))
	    {
			dini_Set(file,"Nama",RentCarData[i][RC_NAME]);
			dini_FloatSet(file,"PosX",RentCarData[i][RC_POS_X]);
			dini_FloatSet(file,"PosY",RentCarData[i][RC_POS_Y]);
			dini_FloatSet(file,"PosZ",RentCarData[i][RC_POS_Z]);
			dini_IntSet(file,"UID",RentCarData[i][RC_ID]);
		}
	}
}

stock SaveMyCarRent(RC_IDD)
{
	new file[128];
	format(file,sizeof(file),"Database/RentCar/[%d].ini", RC_IDD);
	if(dini_Exists(file))
    {
        dini_Set(file,"Nama",RentCarData[RC_IDD][RC_NAME]);
		dini_FloatSet(file,"PosX",RentCarData[RC_IDD][RC_POS_X]);
		dini_FloatSet(file,"PosY",RentCarData[RC_IDD][RC_POS_Y]);
		dini_FloatSet(file,"PosZ",RentCarData[RC_IDD][RC_POS_Z]);
		dini_IntSet(file,"UID",RentCarData[RC_IDD][RC_ID]);
	}
}

stock UpdateRentCar(RC_IDD)
{
	DestroyDynamic3DTextLabel(RC_LABELS[RC_IDD]);
	DestroyDynamicPickup(RC_PICKUP[RC_IDD]);

	new string[2048];
	format(string, sizeof(string), "PEYEWAHAN KENDARAAN \n ID [%d]\n TEKAN [Y] \n >> UNTUK MEYEWA KENDARAAN", RC_IDD);
	RC_LABELS[RC_IDD] = CreateDynamic3DTextLabel(string, -1, RentCarData[RC_IDD][RC_POS_X],RentCarData[RC_IDD][RC_POS_Y],RentCarData[RC_IDD][RC_POS_Z]+0.1, 10.0);
	RC_PICKUP[RC_IDD] = CreateDynamicPickup(19134, 1,RentCarData[RC_IDD][RC_POS_X],RentCarData[RC_IDD][RC_POS_Y],RentCarData[RC_IDD][RC_POS_Z]);
}

CMD:createrent(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
	new namanya[512], file[128];
	if(sscanf(params,"s[50]", namanya)) return TextAgus(playerid, -1, "USAGE: /CreateRent <Name>");
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	for(new i=0;i<MAX_RENTCAR;i++)
	{
        format(file,sizeof(file),"Database/RentCar/[%d].ini",i);
   	    if(!(dini_Exists(file)))
   	    {
			format(RentCarData[i][RC_NAME], 512, namanya);
			RentCarData[i][RC_ID] = i;
			RentCarData[i][RC_POS_X] = X;
			RentCarData[i][RC_POS_Y] = Y;
			RentCarData[i][RC_POS_Z] = Z;
            dini_Create(file);
            UpdateRentCar(i);
            SaveMyCarRent(i);
			ShowInfo(playerid, "Dynamic Rentcar Berhasil Di Buat");
			return 1;
        }
    }
	return 1;
}

CMD:hapusrent(playerid,params[])
{
    for(new i=0; i < MAX_RENTCAR; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, RentCarData[i][RC_POS_X], RentCarData[i][RC_POS_Y], RentCarData[i][RC_POS_Z]))
	    {
			RentCarData[i][RC_ID] = 0;
			RentCarData[i][RC_POS_X] = 0;
			RentCarData[i][RC_POS_Y] = 0;
			RentCarData[i][RC_POS_Z] = 0;
			DestroyDynamic3DTextLabel(RC_LABELS[i]);
			DestroyDynamicPickup(RC_PICKUP[i]);
			new file[128];
			format(file,sizeof(file),"Database/RentCar/[%d].ini",i);
			dini_Remove(file);
			ShowInfo(playerid, "Anda Menghapus DyNamic RentCar");
			return 1;
		}
	}
	TextAgus(playerid, -1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat RentCar mana pun.");
	return 1;
}

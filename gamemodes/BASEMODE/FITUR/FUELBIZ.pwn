#define MAX_FUELBIZ 500

enum F_FUEL
{
	FE_NAME[512],
	Float:FE_POS_X,
	Float:FE_POS_Y,
	Float:FE_POS_Z,
    FE_ID
}
new FUELBIZDATA[MAX_FUELBIZ][F_FUEL];
new Text3D:FE_LABELS[MAX_FUELBIZ],
	FE_PICKUP[MAX_FUELBIZ];

stock LoadFuelBizData()
{
	new file[128];
	for(new i=0; i < MAX_FUELBIZ; i++)
	{
	    format(file,sizeof(file),"Database/Fuel/[%d].ini",i);
	    if(dini_Exists(file))
	    {
			format(FUELBIZDATA[i][FE_NAME],24,"%s",dini_Get(file,"Nama"));
		    FUELBIZDATA[i][FE_POS_X] = dini_Float(file,"PosX");
		    FUELBIZDATA[i][FE_POS_Y] = dini_Float(file,"PosY");
		    FUELBIZDATA[i][FE_POS_Z] = dini_Float(file,"PosZ");
		    FUELBIZDATA[i][FE_ID] = dini_Int(file,"UID");
		    UpdateFuelBiz(i);
		}
	}
}

stock SaveAllBizFuel()
{
	new file[128];
	for(new i=0; i < MAX_FUELBIZ; i++)
	{
	    format(file,sizeof(file),"Database/Fuel/[%d].ini",i);
	    if(dini_Exists(file))
	    {
			dini_Set(file,"Nama",FUELBIZDATA[i][FE_NAME]);
			dini_FloatSet(file,"PosX",FUELBIZDATA[i][FE_POS_X]);
			dini_FloatSet(file,"PosY",FUELBIZDATA[i][FE_POS_Y]);
			dini_FloatSet(file,"PosZ",FUELBIZDATA[i][FE_POS_Z]);
			dini_IntSet(file,"UID",FUELBIZDATA[i][FE_ID]);
		}
	}
}

stock SaveMyFuelBiz(FE_IDD)
{
	new file[128];
	format(file,sizeof(file),"Database/Fuel/[%d].ini", FE_IDD);
	if(dini_Exists(file))
    {
        dini_Set(file,"Nama",FUELBIZDATA[FE_IDD][FE_NAME]);
		dini_FloatSet(file,"PosX",FUELBIZDATA[FE_IDD][FE_POS_X]);
		dini_FloatSet(file,"PosY",FUELBIZDATA[FE_IDD][FE_POS_Y]);
		dini_FloatSet(file,"PosZ",FUELBIZDATA[FE_IDD][FE_POS_Z]);
		dini_IntSet(file,"UID",FUELBIZDATA[FE_IDD][FE_ID]);
	}
}

stock UpdateFuelBiz(FE_IDD)
{
	DestroyDynamic3DTextLabel(FE_LABELS[FE_IDD]);
	DestroyDynamicPickup(FE_PICKUP[FE_IDD]);

	new string[2048];
	format(string, sizeof(string), "FUEL BIZ ID [%d] \n TEKAN [Y]\n >> UNTUK MEMBELI BENGSING", FE_IDD);
	FE_LABELS[FE_IDD] = CreateDynamic3DTextLabel(string, -1, FUELBIZDATA[FE_IDD][FE_POS_X],FUELBIZDATA[FE_IDD][FE_POS_Y],FUELBIZDATA[FE_IDD][FE_POS_Z]+0.1, 10.0);
	FE_PICKUP[FE_IDD] = CreateDynamicPickup(1650, 1,FUELBIZDATA[FE_IDD][FE_POS_X],FUELBIZDATA[FE_IDD][FE_POS_Y],FUELBIZDATA[FE_IDD][FE_POS_Z]);
}

CMD:createfuel(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
	new namanya[512], file[128];
	if(sscanf(params,"s[50]", namanya)) return TextAgus(playerid, -1, "USAGE: /createfuel <Name>");
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	for(new i=0;i<MAX_FUELBIZ;i++)
	{
        format(file,sizeof(file),"Database/Fuel/[%d].ini",i);
   	    if(!(dini_Exists(file)))
   	    {
			format(FUELBIZDATA[i][FE_NAME], 512, namanya);
			FUELBIZDATA[i][FE_ID] = i;
			FUELBIZDATA[i][FE_POS_X] = X;
			FUELBIZDATA[i][FE_POS_Y] = Y;
			FUELBIZDATA[i][FE_POS_Z] = Z;
            dini_Create(file);
            UpdateFuelBiz(i);
            SaveMyFuelBiz(i);
			ShowInfo(playerid, "Dynamic Fuel Berhasil Di Buat");
			return 1;
        }
    }
	return 1;
}

CMD:removefuel(playerid,params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
    for(new i=0; i < MAX_FUELBIZ; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, FUELBIZDATA[i][FE_POS_X], FUELBIZDATA[i][FE_POS_Y], FUELBIZDATA[i][FE_POS_Z]))
	    {
			FUELBIZDATA[i][FE_ID] = 0;
			FUELBIZDATA[i][FE_POS_X] = 0;
			FUELBIZDATA[i][FE_POS_Y] = 0;
			FUELBIZDATA[i][FE_POS_Z] = 0;
			DestroyDynamic3DTextLabel(FE_LABELS[i]);
	    	DestroyDynamicPickup(FE_PICKUP[i]);
			new file[128];
			format(file,sizeof(file),"Database/Fuel/[%d].ini",i);
			dini_Remove(file);
			ShowInfo(playerid, "Anda Menghapus Dynamic Fuel");
			return 1;
		}
	}
	TextAgus(playerid, -1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Pom Fuel mana pun.");
	return 1;
}

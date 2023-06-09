#define MAX_STATERPACK 500

enum E_STATERPACK
{
	ST_NAME[512],
	Float:ST_POS_X,
	Float:ST_POS_Y,
	Float:ST_POS_Z,
    ST_ID
}
new STATERPACKDATA[MAX_STATERPACK][E_STATERPACK];
new Text3D:ST_LABELS[MAX_STATERPACK],
	ST_PICKUP[MAX_STATERPACK];

stock LoadMyStaterPack()
{
	new file[128];
	for(new i=0; i < MAX_STATERPACK; i++)
	{
	    format(file,sizeof(file),"Database/StaterPack/[%d].ini",i);
	    if(dini_Exists(file))
	    {
			format(STATERPACKDATA[i][ST_NAME],24,"%s",dini_Get(file,"Nama"));
		    STATERPACKDATA[i][ST_POS_X] = dini_Float(file,"PosX");
		    STATERPACKDATA[i][ST_POS_Y] = dini_Float(file,"PosY");
		    STATERPACKDATA[i][ST_POS_Z] = dini_Float(file,"PosZ");
		    STATERPACKDATA[i][ST_ID] = dini_Int(file,"UID");
		    UpdateStaterpack(i);
		}
	}
}

stock SaveMyStater()
{
	new file[128];
	for(new i=0; i < MAX_STATERPACK; i++)
	{
	    format(file,sizeof(file),"Database/StaterPack/[%d].ini",i);
	    if(dini_Exists(file))
	    {
			dini_Set(file,"Nama",STATERPACKDATA[i][ST_NAME]);
			dini_FloatSet(file,"PosX",STATERPACKDATA[i][ST_POS_X]);
			dini_FloatSet(file,"PosY",STATERPACKDATA[i][ST_POS_Y]);
			dini_FloatSet(file,"PosZ",STATERPACKDATA[i][ST_POS_Z]);
			dini_IntSet(file,"UID",STATERPACKDATA[i][ST_ID]);
		}
	}
}

stock SaveMyStaterpack(ST_IDD)
{
	new file[128];
	format(file,sizeof(file),"Database/StaterPack/[%d].ini", ST_IDD);
	if(dini_Exists(file))
    {
        dini_Set(file,"Nama",STATERPACKDATA[ST_IDD][ST_NAME]);
		dini_FloatSet(file,"PosX",STATERPACKDATA[ST_IDD][ST_POS_X]);
		dini_FloatSet(file,"PosY",STATERPACKDATA[ST_IDD][ST_POS_Y]);
		dini_FloatSet(file,"PosZ",STATERPACKDATA[ST_IDD][ST_POS_Z]);
		dini_IntSet(file,"UID",STATERPACKDATA[ST_IDD][ST_ID]);
	}
}

stock UpdateStaterpack(ST_IDD)
{
	DestroyDynamic3DTextLabel(ST_LABELS[ST_IDD]);
	DestroyDynamicPickup(ST_PICKUP[ST_IDD]);

	new string[2048];
	format(string, sizeof(string), "{ffff00}STATERPACK  [%d]{fffafa}\n{adff2f}CMD : STATERPACK{fffafa}\n {ffff00}>> UNTUK MEGAMBIL STATERPACK{fffafa}", ST_IDD);
	ST_LABELS[ST_IDD] = CreateDynamic3DTextLabel(string, -1, STATERPACKDATA[ST_IDD][ST_POS_X],STATERPACKDATA[ST_IDD][ST_POS_Y],STATERPACKDATA[ST_IDD][ST_POS_Z]+0.1, 10.0);
	ST_PICKUP[ST_IDD] = CreateDynamicPickup(1210, 1,STATERPACKDATA[ST_IDD][ST_POS_X],STATERPACKDATA[ST_IDD][ST_POS_Y],STATERPACKDATA[ST_IDD][ST_POS_Z]);
}

CMD:createst(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
	new namanya[512], file[128];
	if(sscanf(params,"s[50]", namanya)) return TextAgus(playerid, -1, "USAGE: /createst <Name>");
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	for(new i=0;i<MAX_STATERPACK;i++)
	{
        format(file,sizeof(file),"Database/StaterPack/[%d].ini",i);
   	    if(!(dini_Exists(file)))
   	    {
			format(STATERPACKDATA[i][ST_NAME], 512, namanya);
			STATERPACKDATA[i][ST_ID] = i;
			STATERPACKDATA[i][ST_POS_X] = X;
			STATERPACKDATA[i][ST_POS_Y] = Y;
			STATERPACKDATA[i][ST_POS_Z] = Z;
            dini_Create(file);
            UpdateStaterpack(i);
            SaveMyStaterpack(i);
			ShowInfo(playerid, "Dynamic Staterpack Berhasil Di Buat");
			return 1;
        }
    }
	return 1;
}

CMD:hapusst(playerid,params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 5 || !admin_logged[playerid]) return 1;
    for(new i=0; i < MAX_STATERPACK; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 1.0, STATERPACKDATA[i][ST_POS_X], STATERPACKDATA[i][ST_POS_Y], STATERPACKDATA[i][ST_POS_Z]))
	    {
			STATERPACKDATA[i][ST_ID] = 0;
			STATERPACKDATA[i][ST_POS_X] = 0;
			STATERPACKDATA[i][ST_POS_Y] = 0;
			STATERPACKDATA[i][ST_POS_Z] = 0;
			DestroyDynamic3DTextLabel(ST_LABELS[i]);
	    	DestroyDynamicPickup(ST_PICKUP[i]);
			new file[128];
			format(file,sizeof(file),"Database/StaterPack/[%d].ini",i);
			dini_Remove(file);
			ShowInfo(playerid, "Anda Menghapus Dynamic Staterpack");
			return 1;
		}
	}
	TextAgus(playerid, -1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Tambang mana pun.");
	return 1;
}

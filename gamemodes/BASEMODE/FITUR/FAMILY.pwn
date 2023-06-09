#define MAX_FAMILY_DYNAMIC 1000

#define strcpy(%0,%1)   strcat(((%0[0] = 0), %0), %1)
#define SendInfo(%1,%2) UserSend(%1, -1, "{b6bfc8}INFO: {ffffff}"%2)

#define DIALOG_FAMILY_MENU 5007
#define DIALOG_FAMILY_UANG 5008
#define DIALOG_FAMILY_DRUGS 5009
#define DIALOG_MASUKAN_UANG 5010
#define DIALOG_KELUAR_UANG 5011
#define DIALOG_MASUKAN_DRUGS 5012
#define DIALOG_KELUAR_DRUGS 5013

#define DIALOG_WEAPON 5000
#define DIALOG_SHOTGUN 5001
#define DIALOG_MECHINEGUN 5002
#define DIALOG_ASSAULT 5003
#define DIALOG_SNIPER 5004
#define DIALOG_ARMOR 5005
#define DIALOG_TYPE_FAMILY 5006

#define COLOR_RED       0xFF0000FF

new BajuFamily = mS_INVALID_LISTID;

enum E_FAMILY
{
	F_OWNER[512],
	F_NAME[512],
    F_SLOT_1[512],
	F_SLOT_2[512],
	F_SLOT_3[512],
	F_SLOT_4[512],
	F_SLOT_5[512],
	F_SLOT_6[512],
	F_SLOT_7[512],
	F_SLOT_8[512],
	F_SLOT_9[512],
	F_SLOT_10[512],
	F_OWNED,
	F_LOCK_STATUS,
	F_PRICE,
	Float:F_POS_X,
	Float:F_POS_Y,
	Float:F_POS_Z,
    F_ID,
    F_UANG,
    F_DRUGS,

}
new FAMILYDATA[MAX_FAMILY_DYNAMIC][E_FAMILY];
new Text3D:F_DESKRIPSKI[MAX_FAMILY_DYNAMIC];
new F_PICKUP[MAX_FAMILY_DYNAMIC];

UserSend(playerid, color, const text[], {Float,_}:...)
{
	static args, str[2048];
	if((args = numargs()) <= 3)
	{
	    SendClientMessage(playerid, color, text);
	}
	else
	{
		while(--args >= 3)
		{
			#emit LCTRL 	5
			#emit LOAD.alt 	args
			#emit SHL.C.alt 2
			#emit ADD.C 	12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S 	text
		#emit PUSH.C 	2048
		#emit PUSH.C 	str
		#emit PUSH.S	8
		#emit SYSREQ.C 	format
		#emit LCTRL 	5
		#emit SCTRL 	4

		SendClientMessage(playerid, color, str);

		#emit RETN
	}
	return 1;
}

stock LoadAllFamily()
{
	new file[1285];
	for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
	    format(file,sizeof(file),"Family/[ID-%d].ini",i);
	    if(dini_Exists(file))
	    {
	        format(FAMILYDATA[i][F_OWNER],24,"%s",dini_Get(file,"Owner"));
			format(FAMILYDATA[i][F_NAME],24,"%s",dini_Get(file,"Nama"));
			format(FAMILYDATA[i][F_SLOT_1],24,"%s",dini_Get(file,"Slot1"));
			format(FAMILYDATA[i][F_SLOT_2],24,"%s",dini_Get(file,"Slot2"));
			format(FAMILYDATA[i][F_SLOT_3],24,"%s",dini_Get(file,"Slot3"));
			format(FAMILYDATA[i][F_SLOT_4],24,"%s",dini_Get(file,"Slot4"));
			format(FAMILYDATA[i][F_SLOT_5],24,"%s",dini_Get(file,"Slot5"));
			format(FAMILYDATA[i][F_SLOT_6],24,"%s",dini_Get(file,"Slot6"));
			format(FAMILYDATA[i][F_SLOT_7],24,"%s",dini_Get(file,"Slot7"));
			format(FAMILYDATA[i][F_SLOT_8],24,"%s",dini_Get(file,"Slot8"));
			format(FAMILYDATA[i][F_SLOT_9],24,"%s",dini_Get(file,"Slot9"));
			format(FAMILYDATA[i][F_SLOT_10],24,"%s",dini_Get(file,"Slot10"));
	        FAMILYDATA[i][F_OWNED] = dini_Int(file,"Owned");
	        FAMILYDATA[i][F_LOCK_STATUS] = dini_Int(file,"Locked");
	        FAMILYDATA[i][F_PRICE] = dini_Int(file,"Price");
		    FAMILYDATA[i][F_POS_X] = dini_Float(file,"PosX");
		    FAMILYDATA[i][F_POS_Y] = dini_Float(file,"PosY");
		    FAMILYDATA[i][F_POS_Z] = dini_Float(file,"PosZ");
		    FAMILYDATA[i][F_ID] = dini_Int(file,"UID");
			FAMILYDATA[i][F_UANG] = dini_Int(file,"Money");
			FAMILYDATA[i][F_DRUGS] = dini_Int(file,"Drugs");
		    RefreshFamily(i);
		}
	}
}

stock SaveAllFamily()
{
	new file[1285];
	for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
	    format(file,sizeof(file),"Family/[ID-%d].ini",i);
	    if(dini_Exists(file))
	    {
	        dini_Set(file,"Owner",FAMILYDATA[i][F_OWNER]);
			dini_Set(file,"Nama",FAMILYDATA[i][F_NAME]);
			dini_Set(file,"Slot1",FAMILYDATA[i][F_SLOT_1]);
			dini_Set(file,"Slot2",FAMILYDATA[i][F_SLOT_2]);
			dini_Set(file,"Slot3",FAMILYDATA[i][F_SLOT_3]);
			dini_Set(file,"Slot4",FAMILYDATA[i][F_SLOT_4]);
			dini_Set(file,"Slot5",FAMILYDATA[i][F_SLOT_5]);
			dini_Set(file,"Slot6",FAMILYDATA[i][F_SLOT_6]);
			dini_Set(file,"Slot7",FAMILYDATA[i][F_SLOT_7]);
			dini_Set(file,"Slot8",FAMILYDATA[i][F_SLOT_8]);
			dini_Set(file,"Slot9",FAMILYDATA[i][F_SLOT_9]);
			dini_Set(file,"Slot10",FAMILYDATA[i][F_SLOT_10]);
			dini_IntSet(file,"Owned",FAMILYDATA[i][F_OWNED]);
			dini_IntSet(file,"Locked",FAMILYDATA[i][F_LOCK_STATUS]);
			dini_IntSet(file,"Price",FAMILYDATA[i][F_PRICE]);
			dini_FloatSet(file,"PosX",FAMILYDATA[i][F_POS_X]);
			dini_FloatSet(file,"PosY",FAMILYDATA[i][F_POS_Y]);
			dini_FloatSet(file,"PosZ",FAMILYDATA[i][F_POS_Z]);
			dini_IntSet(file,"UID",FAMILYDATA[i][F_ID]);
			dini_IntSet(file,"Money",FAMILYDATA[i][F_UANG]);
			dini_IntSet(file,"Drugs",FAMILYDATA[i][F_DRUGS]);
		}
	}
}

stock SaveFamily(FAMILY_ID)
{
	new file[1285];
	format(file,sizeof(file),"Family/[ID-%d].ini", FAMILY_ID);
	if(dini_Exists(file))
    {
        dini_Set(file,"Owner",FAMILYDATA[FAMILY_ID][F_OWNER]);
        dini_Set(file,"Nama",FAMILYDATA[FAMILY_ID][F_NAME]);
        dini_Set(file,"Slot1",FAMILYDATA[FAMILY_ID][F_SLOT_1]);
		dini_Set(file,"Slot2",FAMILYDATA[FAMILY_ID][F_SLOT_2]);
		dini_Set(file,"Slot3",FAMILYDATA[FAMILY_ID][F_SLOT_3]);
		dini_Set(file,"Slot4",FAMILYDATA[FAMILY_ID][F_SLOT_4]);
		dini_Set(file,"Slot5",FAMILYDATA[FAMILY_ID][F_SLOT_5]);
		dini_Set(file,"Slot6",FAMILYDATA[FAMILY_ID][F_SLOT_6]);
		dini_Set(file,"Slot7",FAMILYDATA[FAMILY_ID][F_SLOT_7]);
		dini_Set(file,"Slot8",FAMILYDATA[FAMILY_ID][F_SLOT_8]);
		dini_Set(file,"Slot9",FAMILYDATA[FAMILY_ID][F_SLOT_9]);
		dini_Set(file,"Slot10",FAMILYDATA[FAMILY_ID][F_SLOT_10]);
		dini_IntSet(file,"Owned",FAMILYDATA[FAMILY_ID][F_OWNED]);
		dini_IntSet(file,"Locked",FAMILYDATA[FAMILY_ID][F_LOCK_STATUS]);
		dini_IntSet(file,"Price",FAMILYDATA[FAMILY_ID][F_PRICE]);
		dini_FloatSet(file,"PosX",FAMILYDATA[FAMILY_ID][F_POS_X]);
		dini_FloatSet(file,"PosY",FAMILYDATA[FAMILY_ID][F_POS_Y]);
		dini_FloatSet(file,"PosZ",FAMILYDATA[FAMILY_ID][F_POS_Z]);
		dini_IntSet(file,"UID",FAMILYDATA[FAMILY_ID][F_ID]);
		dini_IntSet(file,"Money",FAMILYDATA[FAMILY_ID][F_UANG]);
		dini_IntSet(file,"Drugs",FAMILYDATA[FAMILY_ID][F_DRUGS]);
	}
}

stock RefreshFamily(FAMILY_ID)
{
	DestroyDynamic3DTextLabel(F_DESKRIPSKI[FAMILY_ID]);
	DestroyDynamicPickup(F_PICKUP[FAMILY_ID]);
	new string[2048];
	if(FAMILYDATA[FAMILY_ID][F_OWNED] == 1)
	{
		if(FAMILYDATA[FAMILY_ID][F_LOCK_STATUS] == 0)
		{
	   	 format(string, sizeof(string), "[ {00ff00}FAMILY ID: %d{ffffff} ]\nFAMILY NAMA: [ {00ff00}%s {ffffff}]\nFAMILY OWNER: [ {00ff00}%s {ffffff}]\nLOKASI FAMILY: [ {00ff00}%s{ffffff} ]\nSTATUS: [{00ff00} AKTIF {ffffff}]", FAMILY_ID, FAMILYDATA[FAMILY_ID][F_NAME], FAMILYDATA[FAMILY_ID][F_OWNER], NamaDaerah(FAMILYDATA[FAMILY_ID][F_POS_X], FAMILYDATA[FAMILY_ID][F_POS_Y], FAMILYDATA[FAMILY_ID][F_POS_Z]));
		}
		if(FAMILYDATA[FAMILY_ID][F_LOCK_STATUS] == 1)
		{
	   	 format(string, sizeof(string), "[ {00ff00}FAMILY ID: %d{ffffff} ]\nFAMILY NAMA: [ {00ff00}%s {ffffff}]\nFAMILY OWNER: [ {00ff00}%s {ffffff}]\nLOKASI FAMILY: [ {00ff00}%s{ffffff} ]\nSTATUS: [{00ff00} OFFLINE {ffffff}]", FAMILY_ID, FAMILYDATA[FAMILY_ID][F_NAME], FAMILYDATA[FAMILY_ID][F_OWNER], NamaDaerah(FAMILYDATA[FAMILY_ID][F_POS_X], FAMILYDATA[FAMILY_ID][F_POS_Y], FAMILYDATA[FAMILY_ID][F_POS_Z]));
		}
	    F_DESKRIPSKI[FAMILY_ID] = CreateDynamic3DTextLabel(string, -1, FAMILYDATA[FAMILY_ID][F_POS_X],FAMILYDATA[FAMILY_ID][F_POS_Y],FAMILYDATA[FAMILY_ID][F_POS_Z]+0.1, 50.0);
	    F_PICKUP[FAMILY_ID] = CreateDynamicPickup(1239, 1,FAMILYDATA[FAMILY_ID][F_POS_X],FAMILYDATA[FAMILY_ID][F_POS_Y],FAMILYDATA[FAMILY_ID][F_POS_Z]+0.2);
	}
	if(FAMILYDATA[FAMILY_ID][F_OWNED] == 0)
	{
	    format(string, sizeof(string), "[ {00ff00}FAMILY ID %d{ffffff} ]\n FAMILY INI DI JUAL!\nLOKASI FAMILY: [ {00ff00}%s {ffffff}]\nHARGA: [ {00ff00}$%d{ffffff} ]\nGUNAKAN '{00ff00}/BELIFAMILY{ffffff}' UNTUK MEMBELI FAMILY", FAMILY_ID, NamaDaerah(FAMILYDATA[FAMILY_ID][F_POS_X], FAMILYDATA[FAMILY_ID][F_POS_Y], FAMILYDATA[FAMILY_ID][F_POS_Z]), FAMILYDATA[FAMILY_ID][F_PRICE]);
	    F_DESKRIPSKI[FAMILY_ID] = CreateDynamic3DTextLabel(string, -1, FAMILYDATA[FAMILY_ID][F_POS_X],FAMILYDATA[FAMILY_ID][F_POS_Y],FAMILYDATA[FAMILY_ID][F_POS_Z]+0.1, 50.0);
	    F_PICKUP[FAMILY_ID] = CreateDynamicPickup(1239, 1,FAMILYDATA[FAMILY_ID][F_POS_X],FAMILYDATA[FAMILY_ID][F_POS_Y],FAMILYDATA[FAMILY_ID][F_POS_Z]);
	}
}

stock GetFamNama(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof( name ));
    return name;
}

CMD:createlc(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 7 || !admin_logged[playerid]) return 1;
	new price, namanya[512], file[128];
	if(sscanf(params,"s[50]d", namanya, price)) return UserSend(playerid, -1, "USAGE: /createlc <Name> <Price>");
    new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X,Y,Z);
	for(new i=0;i<MAX_FAMILY_DYNAMIC;i++)
	{
        format(file,sizeof(file),"Family/[ID-%d].ini",i);
   	    if(!(dini_Exists(file)))
   	    {
   	 	    format(FAMILYDATA[i][F_OWNER], 512,"No Owner");
			format(FAMILYDATA[i][F_NAME], 512, namanya);
			format(FAMILYDATA[i][F_SLOT_1], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_2], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_3], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_4], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_5], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_6], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_7], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_8], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_9], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_10], 512,"No Member");
			FAMILYDATA[i][F_OWNED] = 0;
			FAMILYDATA[i][F_UANG] = 0;
			FAMILYDATA[i][F_DRUGS] = 0;
			FAMILYDATA[i][F_PRICE] = price;
			FAMILYDATA[i][F_ID] = i;
			FAMILYDATA[i][F_POS_X] = X;
			FAMILYDATA[i][F_POS_Y] = Y;
			FAMILYDATA[i][F_POS_Z] = Z;
			FAMILYDATA[i][F_LOCK_STATUS] = 1;
            dini_Create(file);
            SaveFamily(i);
			RefreshFamily(i);
			UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Family Berhasil dibuat!");
			return 1;
        }
    }
	return 1;
}

CMD:removelc(playerid,params[])
{
	if(PlayerInfo[playerid][pAdminLevel] < 7 || !admin_logged[playerid]) return 1;
    for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, FAMILYDATA[i][F_POS_X], FAMILYDATA[i][F_POS_Y], FAMILYDATA[i][F_POS_Z]))
	    {
	        format(FAMILYDATA[i][F_OWNER],24,"REMOVED");
	        format(FAMILYDATA[i][F_SLOT_1], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_2], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_3], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_4], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_5], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_6], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_7], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_8], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_9], 512,"No Member");
			format(FAMILYDATA[i][F_SLOT_10], 512,"No Member");
			FAMILYDATA[i][F_OWNED] = 0;
			FAMILYDATA[i][F_UANG] = 0;
			FAMILYDATA[i][F_DRUGS] = 0;
			FAMILYDATA[i][F_PRICE] = 0;
			FAMILYDATA[i][F_ID] = 0;
			FAMILYDATA[i][F_POS_X] = 0;
			FAMILYDATA[i][F_POS_Y] = 0;
			FAMILYDATA[i][F_POS_Z] = 9;
			FAMILYDATA[i][F_LOCK_STATUS] = 0;
			DestroyDynamic3DTextLabel(F_DESKRIPSKI[i]);
	    	DestroyDynamicPickup(F_PICKUP[i]);
			new file[1285];
			format(file,sizeof(file),"Family/[ID-%d].ini",i);
			dini_Remove(file);
			UserSend(playerid, -1, "Anda telah menghapus Family ini.");
			return 1;
		}
	}
	UserSend(playerid, -1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Family mana pun.");
	return 1;
}

CMD:family(playerid, params[])
{
	new type[2048], string[2048];
    for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 3.0, FAMILYDATA[i][F_POS_X], FAMILYDATA[i][F_POS_Y], FAMILYDATA[i][F_POS_Z]))
	    {
			if(sscanf(params, "s[24]S()[512]", type, string))
		 	{
		  		UserSend(playerid, -1, "USAGE: /Family [name, lock, info]");
		  		return 1;
		    }
		    if(!strcmp(type, "name", true))
		    {
		        new name[512];
				if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				if(sscanf(string, "s[248]", name)) return UserSend(playerid, -1, "USAGE: /Family [name] <new name>");
				format(FAMILYDATA[i][F_NAME], 512, name);
		        SaveFamily(i);
				RefreshFamily(i);
		    }
		    if(!strcmp(type, "lock", true))
		    {
		    	if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				if(FAMILYDATA[i][F_LOCK_STATUS] == 1)
				{
				    FAMILYDATA[i][F_LOCK_STATUS] = 0;
				    RefreshFamily(i);
				    SaveFamily(i);
	                UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda telah membuka kunci Family Anda.");
				    return 1;
				}
				if(FAMILYDATA[i][F_LOCK_STATUS] == 0)
				{
				    FAMILYDATA[i][F_LOCK_STATUS] = 1;
				    RefreshFamily(i);
	                SaveFamily(i);
	                UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda telah mengunci Family Anda.");
				    return 1;
				}
		    }
			if(!strcmp(type, "info", true))
		    {
				if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				if(FAMILYDATA[i][F_LOCK_STATUS] == 0)
				{
			   	 format(string, sizeof(string),"NAME: %s\nOWNER: %d\nMONEY %d\nSTATUS: {00ff00}OPEN", FAMILYDATA[i][F_NAME], FAMILYDATA[i][F_OWNER], FAMILYDATA[i][F_UANG]);
				}
				if(FAMILYDATA[i][F_LOCK_STATUS] == 1)
				{
			   	 format(string, sizeof(string),"NAME: %s\nOWNER: %d\nMONEY %d\nSTATUS: {ff0000}CLOSE", FAMILYDATA[i][F_NAME], FAMILYDATA[i][F_OWNER], FAMILYDATA[i][F_UANG]);
				}
				ShowPlayerDialog(playerid, DIALOG_TYPE_FAMILY, DIALOG_STYLE_MSGBOX, "Family Info", string, "Close", "Close");
		    }
		}
	}
    return 1;
}

CMD:belifamily(playerid, params[])
{
    for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
  		if(IsPlayerInRangeOfPoint(playerid, 3.0, FAMILYDATA[i][F_POS_X], FAMILYDATA[i][F_POS_Y], FAMILYDATA[i][F_POS_Z]))
  		{
			if(FAMILYDATA[i][F_OWNED] == 1) return UserSend(playerid, -1,"{ff0000}ERROR: {ffffff}Family ini sudah dimiliki.");
			if(GetPlayerMoney(playerid) < FAMILYDATA[i][F_PRICE]) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda tidak punya cukup uang untuk membeli bengkel ini.");
			GivePlayerMoney(playerid, -FAMILYDATA[i][F_PRICE]);
			format(FAMILYDATA[i][F_OWNER],24,"%s", GetFamNama(playerid));
			FAMILYDATA[i][F_OWNED] = 1;
			SaveFamily(i);
			RefreshFamily(i);
			UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda berhasil Membeli Family Ini Dengan Harga: [{00ff00}$%d{ffffff}]", FAMILYDATA[i][F_PRICE]);
			return 1;
  		}
	}
	UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Family mana pun.");
	return 1;
}
CMD:jualfamily(playerid,params[])
{
	for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, FAMILYDATA[i][F_POS_X], FAMILYDATA[i][F_POS_Y], FAMILYDATA[i][F_POS_Z]))
    	{
			if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
			new hasildibagidua = FAMILYDATA[i][F_PRICE] / 2;
			GivePlayerMoney(playerid, hasildibagidua);
			FAMILYDATA[i][F_OWNED] = 0;
			format(FAMILYDATA[i][F_OWNER], 512, "{ff0000}No Owner");
			FAMILYDATA[i][F_LOCK_STATUS] = 1;
			RefreshFamily(i);
			SaveFamily(i);
			UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda telah berhasil menjual Family pribadi Anda Dengan Harga: [{00ff00}$%d{ffffff}]", hasildibagidua);
		    return 1;
		  }
	}
	UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Family mana pun.");
	return 1;
}

CMD:fstorage(playerid,params[])
{
	for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FAMILYDATA[i][F_POS_X], FAMILYDATA[i][F_POS_Y], FAMILYDATA[i][F_POS_Z]))
    	{
			if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_1], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_2], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_3], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_4], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_5], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_6], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_7], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_8], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_9], GetFamNama(playerid)) && strcmp(FAMILYDATA[i][F_SLOT_10], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik/Member Family ini.");
			ShowPlayerDialog(playerid, DIALOG_FAMILY_MENU, DIALOG_STYLE_LIST, "Family", "BAJU FAMILY\nSENJATA FAMILY\nUANG FAMILY\nDRUGS FAMILY", "Choose", "Cancel");
		    return 1;
		  }
	}
	UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda tidak berada di dekat Family mana pun.");
	return 1;
}

CMD:invitefam(playerid, params[])
{
	new type[2048], targetid;
    for(new i=0; i < MAX_FAMILY_DYNAMIC; i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid, 5.0, FAMILYDATA[i][F_POS_X], FAMILYDATA[i][F_POS_Y], FAMILYDATA[i][F_POS_Z]))
	    {
			if(sscanf(params, "s[50]d", type, targetid))
		 	{
		  		UserSend(playerid, -1, "USAGE: /INVITEFAM [SLOT, 1-10] [ID PLAYER]");
		  		return 1;
		    }
		    if(!strcmp(type, "1", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_1],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		    if(!strcmp(type, "2", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_2],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
			if(!strcmp(type, "3", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_3],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		    if(!strcmp(type, "4", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_4],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		    if(!strcmp(type, "5", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_5],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
			if(!strcmp(type, "6", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_6],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		    if(!strcmp(type, "7", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_7],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		    if(!strcmp(type, "8", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_8],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
			if(!strcmp(type, "9", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_9],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		    if(!strcmp(type, "10", true))
		    {
		        if(strcmp(FAMILYDATA[i][F_OWNER], GetFamNama(playerid))) return UserSend(playerid,-1,"{ff0000}ERROR: {ffffff}Anda bukan pemilik Family ini.");
				format(FAMILYDATA[i][F_SLOT_10],24,"%s", GetFamNama(targetid));
				RefreshFamily(i);
				SaveFamily(i);
				UserSend(playerid, -1,"{00ff00}INFO: {ffffff}Anda Baru Saja Megundang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(targetid));
				UserSend(targetid, -1,"{00ff00}INFO: {ffffff}Anda Sekarang Member Family Oleh : [{00ff00}%s{ffffff}]", GetFamNama(playerid));
		    }
		}
	}
    return 1;
}

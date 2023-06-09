stock SaveDoors()
{
    new File:File,i,string[200];
    i = 0;
	while(i < MAX_DOORS)
	{
 		format(string, sizeof(string), "%d|%d|%d|%f|%f|%f|%f|%f|%f|%f|%f|%d|%d|%d|\r\n",
    	DoorInfo[i][dMi],
		DoorInfo[i][dVe],
		DoorInfo[i][dIe],
		DoorInfo[i][dAe],
		DoorInfo[i][dXe],
		DoorInfo[i][dYe],
		DoorInfo[i][dZe],
		DoorInfo[i][dXi],
		DoorInfo[i][dYi],
		DoorInfo[i][dZi],
		DoorInfo[i][dAi],
		DoorInfo[i][dIi],
		DoorInfo[i][dVi],
		DoorInfo[i][dExit]);
		if(i == 0)
	    {
	        File = fopen("Doors.txt",io_write);
	    }
	    else
	    {
	    	File = fopen("Doors.txt",io_append);
	    }
		fwrite(File,string);
		fclose(File);
		i++;
	}
	print("Doors saved successfully.");
}
stock LoadDoors()
{
	new dinfo[14][128];
	new string[200];
	new str[200];
	new File:File = fopen("Doors.txt", io_read);
	if(File)
	{
	    new i = 0;
		while(i < MAX_DOORS)
		{
		    fread(File, string);
		    split(string,dinfo, '|');
		    DoorInfo[i][dMi] = strval(dinfo[0]);
			DoorInfo[i][dVe] = strval(dinfo[1]);
			DoorInfo[i][dIe] = strval(dinfo[2]);
			DoorInfo[i][dAe] = floatstr(dinfo[3]);
			DoorInfo[i][dXe] = floatstr(dinfo[4]);
			DoorInfo[i][dYe] = floatstr(dinfo[5]);
			DoorInfo[i][dZe] = floatstr(dinfo[6]);
			DoorInfo[i][dXi] = floatstr(dinfo[7]);
			DoorInfo[i][dYi] = floatstr(dinfo[8]);
			DoorInfo[i][dZi] = floatstr(dinfo[9]);
			DoorInfo[i][dAi] = floatstr(dinfo[10]);
			DoorInfo[i][dIi] = strval(dinfo[11]);
			DoorInfo[i][dVi] = strval(dinfo[12]);
			DoorInfo[i][dExit] = strval(dinfo[13]);
			if(DoorInfo[i][dMi])
			{
			    DoorInfo[i][dPicki] = CreateDynamicPickup(1318, 1, DoorInfo[i][dXi], DoorInfo[i][dYi], DoorInfo[i][dZi]+0.2, DoorInfo[i][dVi], DoorInfo[i][dIi]);
                DoorInfo[i][dPicke] = CreateDynamicPickup(1318, 1, DoorInfo[i][dXe], DoorInfo[i][dYe], DoorInfo[i][dZe]+0.2, DoorInfo[i][dVe], DoorInfo[i][dIe]);
				format(string, sizeof(string), "ID: %d\n{ffff00}Tekan F{fffafa}", i);
			 	DoorInfo[i][dText] = CreateDynamic3DTextLabel(string,-1,DoorInfo[i][dXe], DoorInfo[i][dYe], DoorInfo[i][dZe]+0.3, 15);
			 	format(str, sizeof(str), "ID: %d\n{ffff00}Tekan F{fffafa}", i);
				DoorInfo[i][cText] = CreateDynamic3DTextLabel(str,-1,DoorInfo[i][dXi], DoorInfo[i][dYi], DoorInfo[i][dZi]+0.3, 15);
			}
			i++;
	    }
	}
	print("Doors loaded successfully.");
	return 1;
}
stock split(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}
forward enter(playerid);
public enter(playerid)
{
	TogglePlayerControllable(playerid,1);
	KillTimer(entertimer[playerid]);
}

CMD:createdoor(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 7 || !admin_logged[playerid]) return 1;
	new string[500];
	new str[500];
	for(new i=0; i<MAX_DOORS; i++)
	{
	    if(!DoorInfo[i][dMi])
	    {
	        new rand = random(50);
		    GetPlayerPos(playerid, DoorInfo[i][dXe], DoorInfo[i][dYe], DoorInfo[i][dZe]);
            DoorInfo[i][dMi] = rand;
			DoorInfo[i][dIe] = GetPlayerInterior(playerid);
			DoorInfo[i][dVe] = GetPlayerVirtualWorld(playerid);
			GetPlayerFacingAngle(playerid, DoorInfo[i][dAe]);
            DoorInfo[i][dPicke] = CreateDynamicPickup(1318, 1, DoorInfo[i][dXe], DoorInfo[i][dYe], DoorInfo[i][dZe]+0.2, DoorInfo[i][dVe], DoorInfo[i][dIe]);
			format(string, sizeof(string), "ID: %d\n{ffff00}Tekan F{fffafa}", i);
 	 		DoorInfo[i][dText] = CreateDynamic3DTextLabel(string,-1,DoorInfo[i][dXe], DoorInfo[i][dYe], DoorInfo[i][dZe]+0.3, 15);
            format(string, sizeof(string), "{ffff00}Anda Telah Membuat Pintu ID {fffafa}{ff0000} %d{fffafa}", i);
            format(str, sizeof(str), "ID: %d\n{ffff00}Tekan F{fffafa}", i);
			DoorInfo[i][cText] = CreateDynamic3DTextLabel(str,-1,DoorInfo[i][dXi], DoorInfo[i][dYi], DoorInfo[i][dZi]+0.3, 15);
    		SCM(playerid,COLOR_LIGHTBLUE, string);
			i = MAX_DOORS;
			SaveDoors();
		}
	}
	return 1;
}
CMD:editdoor(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 7 || !admin_logged[playerid]) return 1;
    static
        id,
        type[50],
        string[800],
		str[200];

    if(sscanf(params, "ds[50]S()[128]", id, type, string))
    {
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "/editdoor [id] [name]");
        SendClientMessage(playerid, COLOR_LIGHTBLUE, "[NAMES]:{FFFFFF} interior, remove");
        return 1;
    }
    if(!strcmp(type, "interior", true))
    {
		if(DoorInfo[id][dMi] == 0) return SCM(playerid,-1, "ID pintu tidak valid.");
		if(DoorInfo[id][dExit] == 1)
		{
		    DestroyDynamicPickup(DoorInfo[id][dPicki]);
		}
		DoorInfo[id][dIi] = GetPlayerInterior(playerid);
		DoorInfo[id][dVi] = GetPlayerVirtualWorld(playerid);
		GetPlayerFacingAngle(playerid, DoorInfo[id][dAi]);
		GetPlayerPos(playerid, DoorInfo[id][dXi], DoorInfo[id][dYi], DoorInfo[id][dZi]);
	    DoorInfo[id][dPicki] = CreateDynamicPickup(1318, 1, DoorInfo[id][dXi], DoorInfo[id][dYi], DoorInfo[id][dZi]+0.2, DoorInfo[id][dVi], DoorInfo[id][dIi]);
	    format(str, sizeof(str), "ID: %d\n{ffff00}Tekan F{fffafa}", id);
		DoorInfo[id][cText] = CreateDynamic3DTextLabel(str,-1,DoorInfo[id][dXi], DoorInfo[id][dYi], DoorInfo[id][dZi]+0.3, 15);
	    format(string, sizeof(string), "{ffff00}Anda Telah Mentukan Interior Pintu ID{fffafa}{ff0000} %d{fffafa}", id, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
	    SCM(playerid,COLOR_LIGHTBLUE, string);
	    DoorInfo[id][dExit] = 1;
	    SaveDoors();
    }
	else if(!strcmp(type, "remove", true))
    {
	    if(sscanf(params, "i", id)) return SCM(playerid,-1, "[INFO]: /remove [id]");
		if(!DoorInfo[id][dMi]) return SCM(playerid,-1, "ID pintu tidak valid.");
	 	format(string, sizeof(string),"{ffff00}Anda telah menghapus id pintu {fffafa}{ff0000} %d{fffafa}",id);
	    SCM(playerid,-1,string);
		DoorInfo[id][dMi] = 0;
		DoorInfo[id][dVe] = 0;
		DoorInfo[id][dIe] = 0;
		DoorInfo[id][dAe] = 0;
		DoorInfo[id][dXe] = 0;
		DoorInfo[id][dYe] = 0;
		DoorInfo[id][dZe] = 0;
		DoorInfo[id][dXi] = 0;
		DoorInfo[id][dYi] = 0;
		DoorInfo[id][dZi] = 0;
		DoorInfo[id][dAi] = 0;
		DoorInfo[id][dIi] = 0;
		DoorInfo[id][dVi] = 0;
		DoorInfo[id][dExit] = 0;
		DestroyDynamicPickup(DoorInfo[id][dPicke]);
		DestroyDynamicPickup(DoorInfo[id][dPicki]);
	    DestroyDynamic3DTextLabel(DoorInfo[id][dText]);
	    DestroyDynamic3DTextLabel(DoorInfo[id][cText]);
	    SaveDoors();
	}
    return 1;
}
CMD:gotodid(playerid, params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 7 || !admin_logged[playerid]) return 1;
    new i, string[200];
	if(sscanf(params, "i", i)) return SendClientMessage(playerid,-1, "[INFO]: /gotodid [doorid]");
	if(!DoorInfo[i][dMi]) return SendClientMessage(playerid,-1, "ID pintu tidak valid.");
	SetPlayerInterior(playerid, DoorInfo[i][dIe]);
	SetPlayerVirtualWorld(playerid, DoorInfo[i][dVe]);
	SetPlayerPos(playerid, DoorInfo[i][dXe], DoorInfo[i][dYe], DoorInfo[i][dZe]);
	format(string, sizeof(string), "{ffff00}Anda telah berteleportasi ke pintu {fffafa}{ff0000} ID %d{fffafa}", i);
	SendClientMessage(playerid,-1, string);
	return 1;
}

CMD:dhelp(playerid,params[])
{
    if(PlayerInfo[playerid][pAdminLevel] < 7 || !admin_logged[playerid]) return 1;
	new string[200];
	strcat(string, "\t\t{00C0FF}Commands List:\t\t\n\n");
	strcat(string, "/cdoor /cexit /ddoor /did /gotodid /vw /setvw /saved /gotopos /gotols");
	ShowPlayerDialog(playerid, 1398, DIALOG_STYLE_MSGBOX, "{00C0FF}Pintu Masuk/Keluar Dinamis Sederhana untuk Toko",string, "OK", "");
	return 1;
}

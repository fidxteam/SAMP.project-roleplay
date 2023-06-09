enum eNotify
{
	NotifyIcon,
	NotifyMessage[320],
	NotifySize
}
new InfoNotify[MAX_PLAYERS][3][eNotify];
new MaxPlayerNotify[MAX_PLAYERS];
new PlayerText:TextDrawNotifikasi[MAX_PLAYERS][3*8];
new IndexNotify[MAX_PLAYERS];

forward HideNotify(playerid);
public HideNotify(playerid)
{
	if(!IndexNotify[playerid]) return 1;
	--IndexNotify[playerid];
	MaxPlayerNotify[playerid]--;
	for(new i=-1;++i<8;) PlayerTextDrawDestroy(playerid, TextDrawNotifikasi[playerid][(IndexNotify[playerid]*8)+i]);
	return 1;
}

stock ShowInfo(playerid, pesan[])
{
	ShowNotify(playerid, pesan, 1);
 	return 1;
}
stock ShowError(playerid, pesan[])
{
	ShowNotify(playerid, pesan, 2);
 	return 1;
}
stock ShowSucces(playerid, pesan[])
{
	ShowNotify(playerid, pesan, 3);
 	return 1;
}
stock ShowSyntax(playerid, pesan[])
{
	ShowNotify(playerid, pesan, 4);
 	return 1;
}

stock ShowWarning(playerid, pesan[])
{
	ShowNotify(playerid, pesan, 5);
	return 1;
}

stock PermissionError(playerid)
{
	ShowError(playerid, "Anda tidak berhak menggunakan CMD ini!");
	return 1;
}

stock ShowNotify(const playerid, const string:message[], const icon)
{
	if(MaxPlayerNotify[playerid] == 3) return 1;
	MaxPlayerNotify[playerid]++;
	PlayerPlaySound(playerid, 1057 , 0.0, 0.0, 0.0);
	for(new x=-1; ++x <IndexNotify[playerid];)
	{
		for(new i=-1;++i<8;) PlayerTextDrawDestroy(playerid, TextDrawNotifikasi[playerid][(x*8) + i]);
		InfoNotify[playerid][IndexNotify[playerid]-x] = InfoNotify[playerid][(IndexNotify[playerid]-x)-1];
	}
	format(InfoNotify[playerid][0][NotifyMessage], 320, "%s", message);
	InfoNotify[playerid][0][NotifyIcon] = icon;
	InfoNotify[playerid][0][NotifySize] = 3;
	++IndexNotify[playerid];
	new Float:new_x=0.0;
	for(new x=-1;++x<IndexNotify[playerid];)
	{
		CreateNotify(playerid, x, x * 8, new_x);
		new_x += (InfoNotify[playerid][x][NotifySize]*7.25)+25.0;
	}
	SetTimerEx("HideNotify", 5000, false, "d", playerid);
	return 1;
}

stock CreateNotify(const playerid, index, i, const Float:new_x)
{
	new lines = InfoNotify[playerid][index][NotifySize];
	new Float:x = (lines * 10) + new_x;
	new Float:posisibaru = x+30.0;
	if(InfoNotify[playerid][index][NotifyIcon] == 1)
	{
		TextDrawNotifikasi[playerid][i] = CreatePlayerTextDraw(playerid, 485.000000, 169.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2094792959);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 485.000000, 203.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2094792959);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 492.000000, 174.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], -5.500000, 35.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2094792959);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 491.000000, 171.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 119.000000, 41.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 926564095);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 494.000000, 179.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 22.500000, 23.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2094792959);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 505.000000, 184.000000+posisibaru, "i");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.474999, 1.500000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 2);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 174.000000+posisibaru, "INFO");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.329165, 1.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 184.000000+posisibaru, InfoNotify[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.212500, 0.949998);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 608.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);
	}
	if(InfoNotify[playerid][index][NotifyIcon] == 2)
	{
	    TextDrawNotifikasi[playerid][i] = CreatePlayerTextDraw(playerid, 485.000000, 169.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -583711489);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 485.000000, 203.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -583711489);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 492.000000, 174.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], -5.500000, 35.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -583711489);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 491.000000, 171.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 119.000000, 41.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 926564095);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 494.000000, 179.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 22.500000, 23.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -583711489);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 505.000000, 184.000000+posisibaru, "i");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.474999, 1.500000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 2);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 174.000000+posisibaru, "ERROR");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.329165, 1.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 184.000000+posisibaru, InfoNotify[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.212500, 0.949998);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 608.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);
	}
	if(InfoNotify[playerid][index][NotifyIcon] == 3)
	{
	    TextDrawNotifikasi[playerid][i] = CreatePlayerTextDraw(playerid, 485.000000, 169.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 485.000000, 203.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 492.000000, 174.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], -5.500000, 35.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 491.000000, 171.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 119.000000, 41.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 926564095);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 494.000000, 179.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 22.500000, 23.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 505.000000, 184.000000+posisibaru, "i");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.474999, 1.500000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 2);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 174.000000+posisibaru, "SUCCES");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.329165, 1.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 184.000000+posisibaru, InfoNotify[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.212500, 0.949998);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 608.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);
	}
	if(InfoNotify[playerid][index][NotifyIcon] == 4)
	{
	    TextDrawNotifikasi[playerid][i] = CreatePlayerTextDraw(playerid, 485.000000, 169.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2025182719);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 485.000000, 203.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2025182719);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 492.000000, 174.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], -5.500000, 35.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2025182719);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 491.000000, 171.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 119.000000, 41.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 926564095);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 494.000000, 179.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 22.500000, 23.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 2025182719);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 505.000000, 184.000000+posisibaru, "i");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.474999, 1.500000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 2);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 174.000000+posisibaru, "SYNTAX");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.329165, 1.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 184.000000+posisibaru, InfoNotify[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.212500, 0.949998);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 608.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);
	}
	if(InfoNotify[playerid][index][NotifyIcon] == 5)
	{
	    TextDrawNotifikasi[playerid][i] = CreatePlayerTextDraw(playerid, 485.000000, 169.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 485.000000, 203.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 9.000000, 10.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 492.000000, 174.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], -5.500000, 35.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 491.000000, 171.000000+posisibaru, "ld_dual:white");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 119.000000, 41.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], 926564095);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 494.000000, 179.000000+posisibaru, "ld_beat:chit");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 22.500000, 23.500000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -20904193);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 505.000000, 184.000000+posisibaru, "i");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.474999, 1.500000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 2);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 174.000000+posisibaru, "WARNING");
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.329165, 1.000000);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);

		TextDrawNotifikasi[playerid][++i] = CreatePlayerTextDraw(playerid, 515.000000, 184.000000+posisibaru, InfoNotify[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawNotifikasi[playerid][i], 0.212500, 0.949998);
		PlayerTextDrawTextSize(playerid, TextDrawNotifikasi[playerid][i], 608.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawNotifikasi[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawNotifikasi[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawNotifikasi[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawNotifikasi[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawNotifikasi[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawNotifikasi[playerid][i]);
	}
	return true;
}

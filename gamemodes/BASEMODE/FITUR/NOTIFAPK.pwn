enum E_NOTIFYDATA
{
	NotifyIcon,
	NotifyMessage[320],
	NotifySize
}
new IndoApkRilis[MAX_PLAYERS][4][E_NOTIFYDATA];
new MaxPlayerApkNew[MAX_PLAYERS];
new PlayerText:TextDrawnApkNew[MAX_PLAYERS][4*7];
new IndexNotifyApk[MAX_PLAYERS];

forward HideApkNew(playerid);
public HideApkNew(playerid)
{
	if(!IndexNotifyApk[playerid]) return 1;
	--IndexNotifyApk[playerid];
	MaxPlayerApkNew[playerid]--;
	for(new i=-1;++i<7;) PlayerTextDrawDestroy(playerid, TextDrawnApkNew[playerid][(IndexNotifyApk[playerid]*7)+i]);
	return 1;
}

stock CreateNotifyApk(const playerid, index, i, const Float:new_x)
{
	new lines = IndoApkRilis[playerid][index][NotifySize];
	new Float:x = (lines * 10) + new_x;
	new Float:posisibaru = x+30.0;
	if(IndoApkRilis[playerid][index][NotifyIcon] == 1)
	{
		TextDrawnApkNew[playerid][i] = CreatePlayerTextDraw(playerid, 503.000000, 122.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 102.000000, 36.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 486.000000, 122.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 15.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 487.000000, 121.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 15.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], 65535);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 504.000000, 120.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 102.000000, 36.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 490.000000, 119.000000+posisibaru, "A");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.550000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 507.000000, 121.000000+posisibaru, "FACEBOOK");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.304165, 1.399999);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 508.000000, 133.000000+posisibaru, IndoApkRilis[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.166666, 1.149999);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 603.500000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);
	}
	if(IndoApkRilis[playerid][index][NotifyIcon] == 2)
	{
	    TextDrawnApkNew[playerid][i] = CreatePlayerTextDraw(playerid, 503.000000, 122.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 102.000000, 36.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 486.000000, 122.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 15.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 487.000000, 121.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 15.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], 2094792959);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 504.000000, 120.000000+posisibaru, "ld_bum:blkdot");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 4);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 102.000000, 36.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 490.000000, 119.000000+posisibaru, "T");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.550000, 2.000000);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 507.000000, 121.000000+posisibaru, "TWIITER");
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.304165, 1.399999);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 400.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);

		TextDrawnApkNew[playerid][++i] = CreatePlayerTextDraw(playerid, 508.000000, 133.000000+posisibaru, IndoApkRilis[playerid][index][NotifyMessage]);
		PlayerTextDrawFont(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, TextDrawnApkNew[playerid][i], 0.166666, 1.149999);
		PlayerTextDrawTextSize(playerid, TextDrawnApkNew[playerid][i], 603.500000, 17.000000);
		PlayerTextDrawSetOutline(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawColor(playerid, TextDrawnApkNew[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TextDrawnApkNew[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, TextDrawnApkNew[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, TextDrawnApkNew[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, TextDrawnApkNew[playerid][i], 0);
		PlayerTextDrawShow(playerid, TextDrawnApkNew[playerid][i]);
	}
	return true;
}

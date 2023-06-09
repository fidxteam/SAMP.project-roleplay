#define MAX_INVENTORY 20

#define DIALOG_GIVEITEM 112233
#define	DIALOG_INVAMOUNT 334455

new PlayerText:INVBOX[MAX_PLAYERS][6];
new PlayerText:INVNAME[MAX_PLAYERS];
new PlayerText:TOTALQUANTTY[MAX_PLAYERS];
new PlayerText:BARQUANTTY[MAX_PLAYERS][2];
new PlayerText:INDEXTD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:NAMETD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:AMOUNTTD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:MODELTD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:LINETD[MAX_PLAYERS][MAX_INVENTORY];
new PlayerText:CLOSETD[MAX_PLAYERS];
new PlayerText:USETD[MAX_PLAYERS];
new PlayerText:GIVETD[MAX_PLAYERS];
new PlayerText:TOTALAMOUNT[MAX_PLAYERS];
new PlayerText:NOTIFBOX[MAX_PLAYERS][6];

enum inventoryData
{
	invExists,
	invID,
	invItem[32 char],
	invModel,
	invQuantity,
 	invTotalQuantity
};
new InventoryData[MAX_PLAYERS][MAX_INVENTORY][inventoryData];

enum e_InventoryItems
{
	e_InventoryItem[32], //Nama item
	e_InventoryModel, //Object item cari di google
	e_InventoryTotal    //Quantity item misalnya 1 atau 2 dan 3 atau 4 atau 5 ini berat item nya
};

//Tambahin barang nya di sini "{"Nama Item", ID Object, Berat}" di bawah ini sudah ada beberapa item
new const g_aInventoryItems[][e_InventoryItems] =
{
	{"GPS", 18875, 3},
	{"Cellphone", 18867, 3},
	{"Radio", 19942, 3},
	{"Mask", 19036, 1},
	{"Snack", 2703, 1},
	{"Water", 2958, 1},
	{"Clip", 2958, 2},
	{"P3K", 11736, 2},
	{"Micin", 1575, 1},
	{"Borax", 1580, 1},
	{"Metall", 3117, 1},
	{"Patron", 2061, 1},
	{"Buku telepon", 2894, 1},
	{"Rokok", 19897, 1},
	{"Arloji", 19039, 1},
	{"Pilox", 41, 1},
	{"Repair Kit", 2969, 1},
	{"Daging", 2806, 1},
	{"Susu", 19569, 1},
	{"Ayam", 2663, 1},
	{"Susu Botol", 19570, 1},
	{"Component", 19627, 1},
	{"Pancing", 18632, 2},
	{"Umpan", 19566, 1},
	{"Ikan", 19630, 1}
};

stock CreatePlayerInv(playerid)
{
    INVBOX[playerid][0] = CreatePlayerTextDraw(playerid, 141.000000, 142.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INVBOX[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, INVBOX[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INVBOX[playerid][0], 13.000000, 8.000000);
	PlayerTextDrawSetOutline(playerid, INVBOX[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, INVBOX[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, INVBOX[playerid][0], 1);
	PlayerTextDrawColor(playerid, INVBOX[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, INVBOX[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, INVBOX[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, INVBOX[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, INVBOX[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, INVBOX[playerid][0], 0);

	INVBOX[playerid][1] = CreatePlayerTextDraw(playerid, 143.000000, 134.000000, "0");
	PlayerTextDrawFont(playerid, INVBOX[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, INVBOX[playerid][1], 0.408331, 1.699998);
	PlayerTextDrawTextSize(playerid, INVBOX[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVBOX[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, INVBOX[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, INVBOX[playerid][1], 1);
	PlayerTextDrawColor(playerid, INVBOX[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, INVBOX[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, INVBOX[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, INVBOX[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, INVBOX[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, INVBOX[playerid][1], 0);

	INVBOX[playerid][2] = CreatePlayerTextDraw(playerid, 427.000000, 194.000000, "_");
	PlayerTextDrawFont(playerid, INVBOX[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, INVBOX[playerid][2], 0.533333, 12.950013);
	PlayerTextDrawTextSize(playerid, INVBOX[playerid][2], 298.500000, 75.000000);
	PlayerTextDrawSetOutline(playerid, INVBOX[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, INVBOX[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, INVBOX[playerid][2], 2);
	PlayerTextDrawColor(playerid, INVBOX[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, INVBOX[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, INVBOX[playerid][2], 100);
	PlayerTextDrawUseBox(playerid, INVBOX[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, INVBOX[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, INVBOX[playerid][2], 0);

	TOTALAMOUNT[playerid] = CreatePlayerTextDraw(playerid, 393.000000, 200.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, TOTALAMOUNT[playerid], 4);
	PlayerTextDrawLetterSize(playerid, TOTALAMOUNT[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TOTALAMOUNT[playerid], 68.500000, 19.000000);
	PlayerTextDrawSetOutline(playerid, TOTALAMOUNT[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TOTALAMOUNT[playerid], 0);
	PlayerTextDrawAlignment(playerid, TOTALAMOUNT[playerid], 1);
	PlayerTextDrawColor(playerid, TOTALAMOUNT[playerid], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, TOTALAMOUNT[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TOTALAMOUNT[playerid], 50);
	PlayerTextDrawUseBox(playerid, TOTALAMOUNT[playerid], 1);
	PlayerTextDrawSetProportional(playerid, TOTALAMOUNT[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TOTALAMOUNT[playerid], 1);

	USETD[playerid] = CreatePlayerTextDraw(playerid, 393.000000, 227.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, USETD[playerid], 4);
	PlayerTextDrawLetterSize(playerid, USETD[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, USETD[playerid], 68.500000, 19.000000);
	PlayerTextDrawSetOutline(playerid, USETD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, USETD[playerid], 0);
	PlayerTextDrawAlignment(playerid, USETD[playerid], 1);
	PlayerTextDrawColor(playerid, USETD[playerid], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, USETD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, USETD[playerid], 50);
	PlayerTextDrawUseBox(playerid, USETD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, USETD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, USETD[playerid], 1);

	GIVETD[playerid] = CreatePlayerTextDraw(playerid, 393.000000, 254.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, GIVETD[playerid], 4);
	PlayerTextDrawLetterSize(playerid, GIVETD[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, GIVETD[playerid], 68.500000, 19.000000);
	PlayerTextDrawSetOutline(playerid, GIVETD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, GIVETD[playerid], 0);
	PlayerTextDrawAlignment(playerid, GIVETD[playerid], 1);
	PlayerTextDrawColor(playerid, GIVETD[playerid], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, GIVETD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, GIVETD[playerid], 50);
	PlayerTextDrawUseBox(playerid, GIVETD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, GIVETD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, GIVETD[playerid], 1);

	INVBOX[playerid][3] = CreatePlayerTextDraw(playerid, 427.000000, 204.000000, "JUMLAHH");
	PlayerTextDrawFont(playerid, INVBOX[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, INVBOX[playerid][3], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, INVBOX[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVBOX[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, INVBOX[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, INVBOX[playerid][3], 2);
	PlayerTextDrawColor(playerid, INVBOX[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, INVBOX[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, INVBOX[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, INVBOX[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, INVBOX[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, INVBOX[playerid][3], 0);

	INVBOX[playerid][4] = CreatePlayerTextDraw(playerid, 427.000000, 231.000000, "GUNAKAN");
	PlayerTextDrawFont(playerid, INVBOX[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, INVBOX[playerid][4], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, INVBOX[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVBOX[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, INVBOX[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, INVBOX[playerid][4], 2);
	PlayerTextDrawColor(playerid, INVBOX[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, INVBOX[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, INVBOX[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, INVBOX[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, INVBOX[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, INVBOX[playerid][4], 0);

	INVBOX[playerid][5] = CreatePlayerTextDraw(playerid, 427.000000, 258.000000, "KIRIM");
	PlayerTextDrawFont(playerid, INVBOX[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, INVBOX[playerid][5], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, INVBOX[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVBOX[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, INVBOX[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, INVBOX[playerid][5], 2);
	PlayerTextDrawColor(playerid, INVBOX[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, INVBOX[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, INVBOX[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, INVBOX[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, INVBOX[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, INVBOX[playerid][5], 0);

	CLOSETD[playerid] = CreatePlayerTextDraw(playerid, 427.000000, 286.000000, "TUTUP");
	PlayerTextDrawFont(playerid, CLOSETD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, CLOSETD[playerid], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, CLOSETD[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, CLOSETD[playerid], 0);
	PlayerTextDrawSetShadow(playerid, CLOSETD[playerid], 0);
	PlayerTextDrawAlignment(playerid, CLOSETD[playerid], 2);
	PlayerTextDrawColor(playerid, CLOSETD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, CLOSETD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, CLOSETD[playerid], 50);
	PlayerTextDrawUseBox(playerid, CLOSETD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, CLOSETD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, CLOSETD[playerid], 1);

	INVNAME[playerid] = CreatePlayerTextDraw(playerid, 138.000000, 124.000000, "INDO_THEATER_ROLEPLAY");
	PlayerTextDrawFont(playerid, INVNAME[playerid], 1);
	PlayerTextDrawLetterSize(playerid, INVNAME[playerid], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, INVNAME[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, INVNAME[playerid], 0);
	PlayerTextDrawSetShadow(playerid, INVNAME[playerid], 0);
	PlayerTextDrawAlignment(playerid, INVNAME[playerid], 1);
	PlayerTextDrawColor(playerid, INVNAME[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, INVNAME[playerid], 255);
	PlayerTextDrawBoxColor(playerid, INVNAME[playerid], 50);
	PlayerTextDrawUseBox(playerid, INVNAME[playerid], 0);
	PlayerTextDrawSetProportional(playerid, INVNAME[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, INVNAME[playerid], 0);

	BARQUANTTY[playerid][0] = CreatePlayerTextDraw(playerid, 157.000000, 138.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BARQUANTTY[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, BARQUANTTY[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BARQUANTTY[playerid][0], 208.500000, 13.000000);
	PlayerTextDrawSetOutline(playerid, BARQUANTTY[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, BARQUANTTY[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, BARQUANTTY[playerid][0], 1);
	PlayerTextDrawColor(playerid, BARQUANTTY[playerid][0], 100);
	PlayerTextDrawBackgroundColor(playerid, BARQUANTTY[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, BARQUANTTY[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, BARQUANTTY[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, BARQUANTTY[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, BARQUANTTY[playerid][0], 0);

	BARQUANTTY[playerid][1] = CreatePlayerTextDraw(playerid, 157.000000, 138.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, BARQUANTTY[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, BARQUANTTY[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BARQUANTTY[playerid][1], 0.000000, 13.000000);
	PlayerTextDrawSetOutline(playerid, BARQUANTTY[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, BARQUANTTY[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, BARQUANTTY[playerid][1], 1);
	PlayerTextDrawColor(playerid, BARQUANTTY[playerid][1], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, BARQUANTTY[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, BARQUANTTY[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, BARQUANTTY[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, BARQUANTTY[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, BARQUANTTY[playerid][1], 0);

	TOTALQUANTTY[playerid] = CreatePlayerTextDraw(playerid, 325.000000, 140.000000, "25.0/100.0");
	PlayerTextDrawFont(playerid, TOTALQUANTTY[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TOTALQUANTTY[playerid], 0.208333, 0.949998);
	PlayerTextDrawTextSize(playerid, TOTALQUANTTY[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TOTALQUANTTY[playerid], 0);
	PlayerTextDrawSetShadow(playerid, TOTALQUANTTY[playerid], 0);
	PlayerTextDrawAlignment(playerid, TOTALQUANTTY[playerid], 1);
	PlayerTextDrawColor(playerid, TOTALQUANTTY[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TOTALQUANTTY[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TOTALQUANTTY[playerid], 50);
	PlayerTextDrawUseBox(playerid, TOTALQUANTTY[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TOTALQUANTTY[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TOTALQUANTTY[playerid], 0);

	INDEXTD[playerid][0] = CreatePlayerTextDraw(playerid, 138.000000, 156.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][0], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][0], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][0], 1);

	INDEXTD[playerid][1] = CreatePlayerTextDraw(playerid, 184.000000, 156.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][1], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][1], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][1], 1);

	INDEXTD[playerid][2] = CreatePlayerTextDraw(playerid, 230.000000, 156.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][2], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][2], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][2], 1);

	INDEXTD[playerid][3] = CreatePlayerTextDraw(playerid, 276.000000, 156.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][3], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][3], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][3], 1);

	INDEXTD[playerid][4] = CreatePlayerTextDraw(playerid, 322.000000, 156.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][4], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][4], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][4], 1);

	INDEXTD[playerid][5] = CreatePlayerTextDraw(playerid, 138.000000, 209.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][5], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][5], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][5], 1);

	INDEXTD[playerid][6] = CreatePlayerTextDraw(playerid, 184.000000, 209.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][6], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][6], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][6], 1);

	INDEXTD[playerid][7] = CreatePlayerTextDraw(playerid, 230.000000, 209.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][7], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][7], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][7], 1);

	INDEXTD[playerid][8] = CreatePlayerTextDraw(playerid, 276.000000, 209.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][8], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][8], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][8], 1);

	INDEXTD[playerid][9] = CreatePlayerTextDraw(playerid, 322.000000, 209.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][9], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][9], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][9], 1);

	INDEXTD[playerid][10] = CreatePlayerTextDraw(playerid, 138.000000, 262.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][10], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][10], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][10], 1);

	INDEXTD[playerid][11] = CreatePlayerTextDraw(playerid, 184.000000, 262.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][11], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][11], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][11], 1);

	INDEXTD[playerid][12] = CreatePlayerTextDraw(playerid, 230.000000, 262.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][12], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][12], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][12], 1);

	INDEXTD[playerid][13] = CreatePlayerTextDraw(playerid, 276.000000, 262.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][13], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][13], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][13], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][13], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][13], 1);

	INDEXTD[playerid][14] = CreatePlayerTextDraw(playerid, 322.000000, 262.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][14], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][14], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][14], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][14], 1);

	INDEXTD[playerid][15] = CreatePlayerTextDraw(playerid, 138.000000, 315.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][15], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][15], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][15], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][15], 1);

	INDEXTD[playerid][16] = CreatePlayerTextDraw(playerid, 184.000000, 315.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][16], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][16], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][16], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][16], 1);

	INDEXTD[playerid][17] = CreatePlayerTextDraw(playerid, 230.000000, 315.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][17], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][17], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][17], 1);

	INDEXTD[playerid][18] = CreatePlayerTextDraw(playerid, 276.000000, 315.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][18], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][18], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][18], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][18], 1);

	INDEXTD[playerid][19] = CreatePlayerTextDraw(playerid, 322.000000, 315.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, INDEXTD[playerid][19], 4);
	PlayerTextDrawLetterSize(playerid, INDEXTD[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, INDEXTD[playerid][19], 44.000000, 50.000000);
	PlayerTextDrawSetOutline(playerid, INDEXTD[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, INDEXTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, INDEXTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, INDEXTD[playerid][19], 100);
	PlayerTextDrawBackgroundColor(playerid, INDEXTD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, INDEXTD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, INDEXTD[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, INDEXTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, INDEXTD[playerid][19], 1);

	LINETD[playerid][0] = CreatePlayerTextDraw(playerid, 138.000000, 195.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][0], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][0], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][0], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][0], 0);

	LINETD[playerid][1] = CreatePlayerTextDraw(playerid, 184.000000, 195.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][1], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][1], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][1], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][1], 0);

	LINETD[playerid][2] = CreatePlayerTextDraw(playerid, 230.000000, 195.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][2], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][2], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][2], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][2], 0);

	LINETD[playerid][3] = CreatePlayerTextDraw(playerid, 276.000000, 195.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][3], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][3], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][3], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][3], 0);

	LINETD[playerid][4] = CreatePlayerTextDraw(playerid, 322.000000, 195.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][4], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][4], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][4], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][4], 0);

	LINETD[playerid][5] = CreatePlayerTextDraw(playerid, 138.000000, 247.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][5], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][5], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][5], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][5], 0);

	LINETD[playerid][6] = CreatePlayerTextDraw(playerid, 184.000000, 247.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][6], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][6], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][6], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][6], 0);

	LINETD[playerid][7] = CreatePlayerTextDraw(playerid, 230.000000, 247.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][7], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][7], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][7], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][7], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][7], 0);

	LINETD[playerid][8] = CreatePlayerTextDraw(playerid, 276.000000, 247.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][8], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][8], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][8], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][8], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][8], 0);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][8], 0);

	LINETD[playerid][9] = CreatePlayerTextDraw(playerid, 322.000000, 247.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][9], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][9], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][9], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][9], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][9], 0);

	LINETD[playerid][10] = CreatePlayerTextDraw(playerid, 138.000000, 301.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][10], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][10], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][10], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][10], 0);

	LINETD[playerid][11] = CreatePlayerTextDraw(playerid, 184.000000, 301.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][11], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][11], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][11], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][11], 0);

	LINETD[playerid][12] = CreatePlayerTextDraw(playerid, 230.000000, 301.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][12], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][12], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][12], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][12], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][12], 0);

	LINETD[playerid][13] = CreatePlayerTextDraw(playerid, 276.000000, 301.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][13], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][13], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][13], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][13], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][13], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][13], 0);

	LINETD[playerid][14] = CreatePlayerTextDraw(playerid, 322.000000, 301.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][14], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][14], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][14], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][14], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][14], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][14], 0);

	LINETD[playerid][15] = CreatePlayerTextDraw(playerid, 138.000000, 354.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][15], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][15], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][15], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][15], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][15], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][15], 0);

	LINETD[playerid][16] = CreatePlayerTextDraw(playerid, 184.000000, 354.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][16], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][16], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][16], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][16], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][16], 0);

	LINETD[playerid][17] = CreatePlayerTextDraw(playerid, 230.000000, 354.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][17], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][17], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][17], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][17], 0);

	LINETD[playerid][18] = CreatePlayerTextDraw(playerid, 276.000000, 354.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][18], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][18], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][18], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][18], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][18], 0);

	LINETD[playerid][19] = CreatePlayerTextDraw(playerid, 322.000000, 354.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, LINETD[playerid][19], 4);
	PlayerTextDrawLetterSize(playerid, LINETD[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, LINETD[playerid][19], 44.000000, 11.500000);
	PlayerTextDrawSetOutline(playerid, LINETD[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, LINETD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, LINETD[playerid][19], 1);
	PlayerTextDrawColor(playerid, LINETD[playerid][19], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, LINETD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, LINETD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, LINETD[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, LINETD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, LINETD[playerid][19], 0);

	NAMETD[playerid][0] = CreatePlayerTextDraw(playerid, 161.000000, 196.000000, "Hamburger");
	PlayerTextDrawFont(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][0], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][0], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][0], 0);

	NAMETD[playerid][1] = CreatePlayerTextDraw(playerid, 207.000000, 196.000000, "Coffe");
	PlayerTextDrawFont(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][1], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][1], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][1], 0);

	NAMETD[playerid][2] = CreatePlayerTextDraw(playerid, 253.000000, 196.000000, "Phone");
	PlayerTextDrawFont(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][2], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][2], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][2], 0);

	NAMETD[playerid][3] = CreatePlayerTextDraw(playerid, 299.000000, 196.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][3], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][3], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][3], 0);

	NAMETD[playerid][4] = CreatePlayerTextDraw(playerid, 346.000000, 196.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][4], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][4], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][4], 0);

	NAMETD[playerid][5] = CreatePlayerTextDraw(playerid, 161.000000, 248.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][5], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][5], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][5], 0);

	NAMETD[playerid][6] = CreatePlayerTextDraw(playerid, 207.000000, 248.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][6], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][6], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][6], 0);

	NAMETD[playerid][7] = CreatePlayerTextDraw(playerid, 253.000000, 248.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][7], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][7], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][7], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][7], 0);

	NAMETD[playerid][8] = CreatePlayerTextDraw(playerid, 299.000000, 248.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][8], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][8], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][8], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][8], 0);

	NAMETD[playerid][9] = CreatePlayerTextDraw(playerid, 346.000000, 248.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][9], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][9], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][9], 0);

	NAMETD[playerid][10] = CreatePlayerTextDraw(playerid, 161.000000, 302.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][10], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][10], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][10], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][10], 0);

	NAMETD[playerid][11] = CreatePlayerTextDraw(playerid, 207.000000, 302.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][11], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][11], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][11], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][11], 0);

	NAMETD[playerid][12] = CreatePlayerTextDraw(playerid, 253.000000, 302.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][12], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][12], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][12], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][12], 0);

	NAMETD[playerid][13] = CreatePlayerTextDraw(playerid, 299.000000, 302.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][13], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][13], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][13], 0);

	NAMETD[playerid][14] = CreatePlayerTextDraw(playerid, 346.000000, 302.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][14], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][14], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][14], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][14], 0);

	NAMETD[playerid][15] = CreatePlayerTextDraw(playerid, 161.000000, 355.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][15], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][15], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][15], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][15], 0);

	NAMETD[playerid][16] = CreatePlayerTextDraw(playerid, 207.000000, 355.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][16], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][16], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][16], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][16], 0);

	NAMETD[playerid][17] = CreatePlayerTextDraw(playerid, 253.000000, 355.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][17], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][17], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][17], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][17], 0);

	NAMETD[playerid][18] = CreatePlayerTextDraw(playerid, 299.000000, 355.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][18], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][18], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][18], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][18], 0);

	NAMETD[playerid][19] = CreatePlayerTextDraw(playerid, 346.000000, 355.000000, "Water");
	PlayerTextDrawFont(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, NAMETD[playerid][19], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NAMETD[playerid][19], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, NAMETD[playerid][19], 2);
	PlayerTextDrawColor(playerid, NAMETD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, NAMETD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, NAMETD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, NAMETD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, NAMETD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, NAMETD[playerid][19], 0);

	AMOUNTTD[playerid][0] = CreatePlayerTextDraw(playerid, 140.000000, 157.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][0], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][0], 0);

	AMOUNTTD[playerid][1] = CreatePlayerTextDraw(playerid, 186.000000, 157.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][1], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][1], 0);

	AMOUNTTD[playerid][2] = CreatePlayerTextDraw(playerid, 232.000000, 157.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][2], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][2], 0);

	AMOUNTTD[playerid][3] = CreatePlayerTextDraw(playerid, 278.000000, 157.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][3], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][3], 0);

	AMOUNTTD[playerid][4] = CreatePlayerTextDraw(playerid, 324.000000, 157.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][4], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][4], 0);

	AMOUNTTD[playerid][5] = CreatePlayerTextDraw(playerid, 140.000000, 210.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][5], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][5], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][5], 0);

	AMOUNTTD[playerid][6] = CreatePlayerTextDraw(playerid, 186.000000, 210.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][6], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][6], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][6], 0);

	AMOUNTTD[playerid][7] = CreatePlayerTextDraw(playerid, 232.000000, 210.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][7], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][7], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][7], 0);

	AMOUNTTD[playerid][8] = CreatePlayerTextDraw(playerid, 278.000000, 210.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][8], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][8], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][8], 0);

	AMOUNTTD[playerid][9] = CreatePlayerTextDraw(playerid, 324.000000, 210.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][9], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][9], 0);

	AMOUNTTD[playerid][10] = CreatePlayerTextDraw(playerid, 140.000000, 263.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][10], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][10], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][10], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][10], 0);

	AMOUNTTD[playerid][11] = CreatePlayerTextDraw(playerid, 186.000000, 263.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][11], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][11], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][11], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][11], 0);

	AMOUNTTD[playerid][12] = CreatePlayerTextDraw(playerid, 232.000000, 263.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][12], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][12], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][12], 0);

	AMOUNTTD[playerid][13] = CreatePlayerTextDraw(playerid, 278.000000, 263.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][13], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][13], 0);

	AMOUNTTD[playerid][14] = CreatePlayerTextDraw(playerid, 324.000000, 263.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][14], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][14], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][14], 0);

	AMOUNTTD[playerid][15] = CreatePlayerTextDraw(playerid, 140.000000, 315.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][15], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][15], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][15], 0);

	AMOUNTTD[playerid][16] = CreatePlayerTextDraw(playerid, 186.000000, 315.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][16], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][16], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][16], 0);

	AMOUNTTD[playerid][17] = CreatePlayerTextDraw(playerid, 232.000000, 315.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][17], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][17], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][17], 0);

	AMOUNTTD[playerid][18] = CreatePlayerTextDraw(playerid, 278.000000, 315.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][18], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][18], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][18], 0);

	AMOUNTTD[playerid][19] = CreatePlayerTextDraw(playerid, 324.000000, 315.000000, "100");
	PlayerTextDrawFont(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawLetterSize(playerid, AMOUNTTD[playerid][19], 0.233333, 1.100000);
	PlayerTextDrawTextSize(playerid, AMOUNTTD[playerid][19], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, AMOUNTTD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, AMOUNTTD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, AMOUNTTD[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, AMOUNTTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, AMOUNTTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, AMOUNTTD[playerid][19], 0);

	MODELTD[playerid][0] = CreatePlayerTextDraw(playerid, 113.000000, 113.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][0], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][0], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][0], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][0], 1, 1);

	MODELTD[playerid][1] = CreatePlayerTextDraw(playerid, 160.000000, 113.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][1], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][1], 19835);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][1], 0.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][1], 1, 1);

	MODELTD[playerid][2] = CreatePlayerTextDraw(playerid, 208.000000, 113.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][2], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][2], 18867);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][2], -254.000000, 0.000000, 0.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][2], 1, 1);

	MODELTD[playerid][3] = CreatePlayerTextDraw(playerid, 252.000000, 113.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][3], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][3], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][3], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][3], 1, 1);

	MODELTD[playerid][4] = CreatePlayerTextDraw(playerid, 300.000000, 113.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][4], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][4], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][4], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][4], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][4], 1, 1);

	MODELTD[playerid][5] = CreatePlayerTextDraw(playerid, 113.000000, 166.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][5], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][5], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][5], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][5], 1, 1);

	MODELTD[playerid][6] = CreatePlayerTextDraw(playerid, 160.000000, 166.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][6], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][6], 19835);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][6], 0.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][6], 1, 1);

	MODELTD[playerid][7] = CreatePlayerTextDraw(playerid, 208.000000, 165.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][7], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][7], 18867);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][7], -254.000000, 0.000000, 0.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][7], 1, 1);

	MODELTD[playerid][8] = CreatePlayerTextDraw(playerid, 252.000000, 166.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][8], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][8], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][8], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][8], 1, 1);

	MODELTD[playerid][9] = CreatePlayerTextDraw(playerid, 300.000000, 167.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][9], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][9], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][9], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][9], 1, 1);

	MODELTD[playerid][10] = CreatePlayerTextDraw(playerid, 113.000000, 219.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][10], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][10], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][10], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][10], 1, 1);

	MODELTD[playerid][11] = CreatePlayerTextDraw(playerid, 160.000000, 219.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][11], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][11], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][11], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][11], 19835);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][11], 0.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][11], 1, 1);

	MODELTD[playerid][12] = CreatePlayerTextDraw(playerid, 208.000000, 219.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][12], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][12], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][12], 18867);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][12], -254.000000, 0.000000, 0.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][12], 1, 1);

	MODELTD[playerid][13] = CreatePlayerTextDraw(playerid, 252.000000, 220.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][13], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][13], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][13], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][13], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][13], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][13], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][13], 1, 1);

	MODELTD[playerid][14] = CreatePlayerTextDraw(playerid, 300.000000, 220.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][14], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][14], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][14], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][14], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][14], 1, 1);

	MODELTD[playerid][15] = CreatePlayerTextDraw(playerid, 113.000000, 272.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][15], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][15], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][15], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][15], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][15], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][15], 1, 1);

	MODELTD[playerid][16] = CreatePlayerTextDraw(playerid, 160.000000, 272.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][16], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][16], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][16], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][16], 19835);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][16], 0.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][16], 1, 1);

	MODELTD[playerid][17] = CreatePlayerTextDraw(playerid, 208.000000, 272.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][17], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][17], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][17], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][17], 18867);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][17], -254.000000, 0.000000, 0.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][17], 1, 1);

	MODELTD[playerid][18] = CreatePlayerTextDraw(playerid, 252.000000, 272.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][18], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][18], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][18], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][18], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][18], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][18], 1, 1);

	MODELTD[playerid][19] = CreatePlayerTextDraw(playerid, 301.000000, 272.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MODELTD[playerid][19], 5);
	PlayerTextDrawLetterSize(playerid, MODELTD[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MODELTD[playerid][19], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, MODELTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, MODELTD[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawBoxColor(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawUseBox(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, MODELTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, MODELTD[playerid][19], 0);
	PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][19], 2703);
	PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][19], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, MODELTD[playerid][19], 1, 1);

	NOTIFBOX[playerid][0] = CreatePlayerTextDraw(playerid, 382.000000, 347.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][0], 40.500000, 13.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][0], 0);

	NOTIFBOX[playerid][1] = CreatePlayerTextDraw(playerid, 384.000000, 349.000000, "REMOVED_1x");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][1], 0.170833, 0.850000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][1], 255);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][1], 0);

	NOTIFBOX[playerid][2] = CreatePlayerTextDraw(playerid, 412.000000, 363.000000, "_");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][2], 0.533333, 6.399988);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][2], 298.500000, 56.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][2], 2);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][2], 100);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][2], 0);

	NOTIFBOX[playerid][3] = CreatePlayerTextDraw(playerid, 382.000000, 409.000000, "ld_dual:white");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][3], 60.000000, 14.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][3], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][3], 1);

	NOTIFBOX[playerid][4] = CreatePlayerTextDraw(playerid, 412.000000, 411.000000, "Hamburger");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][4], 0.212495, 0.850000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][4], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][4], 2);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][4], 0);

	NOTIFBOX[playerid][5] = CreatePlayerTextDraw(playerid, 365.000000, 320.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, NOTIFBOX[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, NOTIFBOX[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, NOTIFBOX[playerid][5], 93.000000, 128.000000);
	PlayerTextDrawSetOutline(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, NOTIFBOX[playerid][5], 1);
	PlayerTextDrawColor(playerid, NOTIFBOX[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawBoxColor(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawUseBox(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, NOTIFBOX[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, NOTIFBOX[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, NOTIFBOX[playerid][5], 2703);
	PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], -80.000000, 0.000000, -12.000000, 2.779998);
	PlayerTextDrawSetPreviewVehCol(playerid, NOTIFBOX[playerid][5], 1, 1);
}

stock Inventory_Clear(playerid)
{
	static
	    string[64];

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (InventoryData[playerid][i][invExists])
	    {
	        InventoryData[playerid][i][invExists] = 0;
	        InventoryData[playerid][i][invModel] = 0;
	        InventoryData[playerid][i][invQuantity] = 0;
	        InventoryData[playerid][i][invTotalQuantity] = 0;
		}
	}
	format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d'", PlayerInfo[playerid][pID]);
	return mysql_tquery(mMysql, string);
}

stock Inventory_GetItemID(playerid, item[])
{
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        continue;

		if (!strcmp(InventoryData[playerid][i][invItem], item)) return i;
	}
	return -1;
}

stock Inventory_GetFreeID(playerid)
{
	if (Inventory_Items(playerid) >= 20)
		return -1;

	for(new i = 0; i < MAX_INVENTORY; i++)
	{
	    if (!InventoryData[playerid][i][invExists])
	        return i;
	}
	return -1;
}

stock Inventory_Items(playerid)
{
    new count;

    for(new i = 0; i < MAX_INVENTORY; i++) if (InventoryData[playerid][i][invExists]) {
        count++;
	}
	return count;
}

stock Inventory_Count(playerid, item[])
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid != -1)
	    return InventoryData[playerid][itemid][invQuantity];

	return 0;
}

stock PlayerHasItem(playerid, item[])
{
	return (Inventory_GetItemID(playerid, item) != -1);
}

stock Inventory_Set(playerid, item[], model, amount, totalquantity)
{
	new itemid = Inventory_GetItemID(playerid, item);

	if (itemid == -1 && amount > 0)
		Inventory_Addset(playerid, item, model, amount, totalquantity);

	else if (amount > 0 && itemid != -1)
	    Inventory_SetQuantity(playerid, item, amount, totalquantity);

	else if (amount < 1 && itemid != -1)
	    Inventory_Remove(playerid, item, -1);

	return 1;
}

stock Inventory_SetQuantity(playerid, item[], quantity, totalquantity)
{
	new
	    itemid = Inventory_GetItemID(playerid, item),
	    string[128];

	if (itemid != -1)
	{
	    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
	    mysql_tquery(mMysql, string);

	    format(string, sizeof(string), "UPDATE `inventory` SET `invTotal` = %d WHERE `ID` = '%d' AND `invID` = '%d'", totalquantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
	    mysql_tquery(mMysql, string);

	    InventoryData[playerid][itemid][invQuantity] = quantity;
	    InventoryData[playerid][itemid][invTotalQuantity] = totalquantity;
	}
	return 1;
}

stock Inventory_Remove(playerid, item[], quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid != -1)
	{
	    for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
		{
	        new totalquantity = g_aInventoryItems[i][e_InventoryTotal];
		    if (InventoryData[playerid][itemid][invQuantity] > 0 && InventoryData[playerid][itemid][invTotalQuantity] > 0)
		    {
		        InventoryData[playerid][itemid][invQuantity] -= quantity;
		        InventoryData[playerid][itemid][invTotalQuantity] -= totalquantity;
			}
			if (quantity == -1 || InventoryData[playerid][itemid][invQuantity] < 1 || totalquantity == -1 || InventoryData[playerid][itemid][invTotalQuantity] < 1)
			{
			    InventoryData[playerid][itemid][invExists] = false;
			    InventoryData[playerid][itemid][invModel] = 0;
			    InventoryData[playerid][itemid][invQuantity] = 0;
			    InventoryData[playerid][itemid][invTotalQuantity] = 0;

			    format(string, sizeof(string), "DELETE FROM `inventory` WHERE `ID` = '%d' AND `invID` = '%d'", PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
		        mysql_tquery(mMysql, string);
			}
			else if (quantity != -1 && InventoryData[playerid][itemid][invQuantity] > 0 && totalquantity != -1 && InventoryData[playerid][itemid][invTotalQuantity] > 0)
			{
				format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` - %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
	            mysql_tquery(mMysql, string);

	            format(string, sizeof(string), "UPDATE `inventory` SET `invTotal` = `invTotal` - %d WHERE `ID` = '%d' AND `invID` = '%d'", totalquantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
	            mysql_tquery(mMysql, string);
			}
		}
		return 1;
	}
	return 0;
}

stock Inventory_Addset(playerid, item[], model, quantity = 1, totalquantity)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
	   		InventoryData[playerid][itemid][invExists] = true;
		    InventoryData[playerid][itemid][invModel] = model;
		    InventoryData[playerid][itemid][invQuantity] = quantity;
		    InventoryData[playerid][itemid][invTotalQuantity] = totalquantity;

		    strpack(InventoryData[playerid][itemid][invItem], item, 32 char);

      		mysql_format(mMysql, string, sizeof(string), "INSERT INTO inventory SET ID='%d', invItem='%s', invModel='%d', invQuantity='%d', invTotal='%d'", PlayerInfo[playerid][pID], item, model, quantity, totalquantity);
			mysql_tquery(mMysql, string, "OnInventoryAdd", "dd", playerid, itemid);
		    return itemid;
		}
		return -1;
	}
	else
	{
		format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
	   	mysql_tquery(mMysql, string);

	   	format(string, sizeof(string), "UPDATE `inventory` SET `invTotal` = `invTotal` + %d WHERE `ID` = '%d' AND `invID` = '%d'", totalquantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
   		mysql_tquery(mMysql, string);

	  	InventoryData[playerid][itemid][invQuantity] += quantity;
  		InventoryData[playerid][itemid][invTotalQuantity] += totalquantity;
	}
	return itemid;
}

stock Inventory_Add(playerid, item[], model, quantity = 1)
{
	new
		itemid = Inventory_GetItemID(playerid, item),
		string[128];

	if (itemid == -1)
	{
	    itemid = Inventory_GetFreeID(playerid);

	    if (itemid != -1)
	    {
         	for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
			{
          		new totalquantity = g_aInventoryItems[i][e_InventoryTotal];
     	 	  	InventoryData[playerid][itemid][invExists] = true;
		        InventoryData[playerid][itemid][invModel] = model;
		        InventoryData[playerid][itemid][invQuantity] = quantity;
		        InventoryData[playerid][itemid][invTotalQuantity] = totalquantity;

		        strpack(InventoryData[playerid][itemid][invItem], item, 32 char);

				mysql_format(mMysql, string, sizeof(string), "INSERT INTO inventory SET ID='%d', invItem='%s', invModel='%d', invQuantity='%d', invTotal='%d'", PlayerInfo[playerid][pID], item, model, quantity, totalquantity);
				mysql_tquery(mMysql, string, "OnInventoryAdd", "dd", playerid, itemid);
		        return itemid;
			}
		}
		return -1;
	}
	else
	{
	    for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
		{
  			new totalquantity = g_aInventoryItems[i][e_InventoryTotal];
		    format(string, sizeof(string), "UPDATE `inventory` SET `invQuantity` = `invQuantity` + %d WHERE `ID` = '%d' AND `invID` = '%d'", quantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
		    mysql_tquery(mMysql, string);

		    format(string, sizeof(string), "UPDATE `inventory` SET `invTotal` = `invTotal` + %d WHERE `ID` = '%d' AND `invID` = '%d'", totalquantity, PlayerInfo[playerid][pID], InventoryData[playerid][itemid][invID]);
	     	mysql_tquery(mMysql, string);

		    InventoryData[playerid][itemid][invQuantity] += quantity;
		    InventoryData[playerid][itemid][invTotalQuantity] += totalquantity;
		}
	}
	return itemid;
}

publics: OnInventoryAdd(playerid, itemid)
{
	InventoryData[playerid][itemid][invID] = cache_insert_id();
	return 1;
}

publics: LoadPlayerItems(playerid)
{
	new name[128];
	new count = cache_num_rows();
	if(count > 0)
	{
	    for(new i = 0; i < count; i++)
	    {
	        InventoryData[playerid][i][invExists] = true;

	        cache_get_value_name_int(i, "invID", InventoryData[playerid][i][invID]);
	        cache_get_value_name_int(i, "invModel", InventoryData[playerid][i][invModel]);
	        cache_get_value_name_int(i, "invQuantity", InventoryData[playerid][i][invQuantity]);
	        cache_get_value_name_int(i, "invTotal", InventoryData[playerid][i][invTotalQuantity]);

	        cache_get_value_name(i, "invItem", name);

			strpack(InventoryData[playerid][i][invItem], name, 32 char);
		}
	}
	return 1;
}

stock Inventory_Close(playerid)
{
	for(new i = 0; i < 6; i++)
	{
		PlayerTextDrawHide(playerid, INVBOX[playerid][i]);
	}
	PlayerTextDrawHide(playerid, GIVETD[playerid]);
	PlayerTextDrawHide(playerid, USETD[playerid]);
	PlayerTextDrawHide(playerid, CLOSETD[playerid]);
	PlayerTextDrawHide(playerid, TOTALAMOUNT[playerid]);
	PlayerTextDrawHide(playerid, INVNAME[playerid]);
	PlayerTextDrawHide(playerid, BARQUANTTY[playerid][0]);
	PlayerTextDrawHide(playerid, BARQUANTTY[playerid][1]);
	PlayerTextDrawHide(playerid, TOTALQUANTTY[playerid]);
	CancelSelectTextDraw(playerid);
	PlayerInfo[playerid][pSelectItem] = -1;
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		PlayerTextDrawHide(playerid, INDEXTD[playerid][i]);
		PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
		PlayerTextDrawHide(playerid, NAMETD[playerid][i]);
		PlayerTextDrawHide(playerid, LINETD[playerid][i]);
		PlayerTextDrawHide(playerid, MODELTD[playerid][i]);
	}
	return 1;
}

stock Inventory_Show(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	new str[256], string[256], totalall, quantitybar;
	for(new i = 0; i < 6; i++)
	{
		PlayerTextDrawShow(playerid, INVBOX[playerid][i]);
	}
	PlayerTextDrawShow(playerid, TOTALAMOUNT[playerid]);
	PlayerTextDrawShow(playerid, GIVETD[playerid]);
	PlayerTextDrawShow(playerid, USETD[playerid]);
	PlayerTextDrawShow(playerid, CLOSETD[playerid]);
	PlayerTextDrawShow(playerid, INVNAME[playerid]);
	SelectTextDraw(playerid, 0xAFAFAFFF);
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
  		PlayerTextDrawShow(playerid, INDEXTD[playerid][i]);
  		PlayerTextDrawShow(playerid, LINETD[playerid][i]);
		PlayerTextDrawShow(playerid, AMOUNTTD[playerid][i]);
		totalall += InventoryData[playerid][i][invTotalQuantity];
		format(str, sizeof(str), "%.1f/250.0", float(totalall));
		PlayerTextDrawSetString(playerid, TOTALQUANTTY[playerid], str);
		PlayerTextDrawShow(playerid, TOTALQUANTTY[playerid]);
		PlayerTextDrawShow(playerid, BARQUANTTY[playerid][0]);
		quantitybar = totalall * 208/250;
	    PlayerTextDrawTextSize(playerid, BARQUANTTY[playerid][1], quantitybar, 13.0);
	    PlayerTextDrawShow(playerid, BARQUANTTY[playerid][1]);
		if(InventoryData[playerid][i][invExists])
		{
			PlayerTextDrawShow(playerid, NAMETD[playerid][i]);
			PlayerTextDrawSetPreviewModel(playerid, MODELTD[playerid][i], InventoryData[playerid][i][invModel]);

			if(InventoryData[playerid][i][invModel] == 18867)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], -254.000000, 0.000000, 0.000000, 2.779998);
			}
			else if(InventoryData[playerid][i][invModel] == 2958)
			{
				PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], 0.000000, 0.000000, -85.000000, 2.029999);
			}
			else if(InventoryData[playerid][i][invModel] == 2703)
			{
				PlayerTextDrawSetPreviewRot(playerid, MODELTD[playerid][i], -80.000000, 0.000000, -12.000000, 2.779998);
			}
			PlayerTextDrawShow(playerid, MODELTD[playerid][i]);
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s", string);
			PlayerTextDrawSetString(playerid, NAMETD[playerid][i], str);
			format(str, sizeof(str), "%d", InventoryData[playerid][i][invQuantity]);
			PlayerTextDrawSetString(playerid, AMOUNTTD[playerid][i], str);
		}
		else
		{
			PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
		}
	}
	new StrInventory[499];
	format(StrInventory, sizeof(StrInventory), "%s", GetName(playerid));
	PlayerTextDrawSetString(playerid, INVNAME[playerid], StrInventory);
	return 1;
}

publics: Inventory_Update(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	new str[256], string[256], totalall, quantitybar;
	for(new i = 0; i < MAX_INVENTORY; i++)
	{
		totalall += InventoryData[playerid][i][invTotalQuantity];
		format(str, sizeof(str), "%.1f/250.0", float(totalall));
		PlayerTextDrawSetString(playerid, TOTALQUANTTY[playerid], str);
		quantitybar = totalall * 208/250;
	    PlayerTextDrawTextSize(playerid, BARQUANTTY[playerid][1], quantitybar, 13.0);
		if(InventoryData[playerid][i][invExists])
		{
			strunpack(string, InventoryData[playerid][i][invItem]);
			format(str, sizeof(str), "%s", string);
			PlayerTextDrawSetString(playerid, NAMETD[playerid][i], str);
			format(str, sizeof(str), "%d", InventoryData[playerid][i][invQuantity]);
			PlayerTextDrawSetString(playerid, AMOUNTTD[playerid][i], str);
		}
		else
		{
			PlayerTextDrawHide(playerid, AMOUNTTD[playerid][i]);
			PlayerTextDrawHide(playerid, MODELTD[playerid][i]);
			PlayerTextDrawHide(playerid, NAMETD[playerid][i]);
		}
	}
	return 1;
}

publics: OnPlayerUseItem(playerid, itemid, name[])
{
    //Contoh saat memakan item Snack
	if(!strcmp(name, "Ayam"))
	{
	    if(PlayerInfo[playerid][pLapar] >= 100) return Send(playerid, -1, "Karaktermu tidak mau makan!");
        Inventory_Remove(playerid, "Ayam", 1);
 		ShowItemBox(playerid, "Ayam", "USED_1x", 2663, 2);
	    SetPlayerChatBubble(playerid,"memakan nasgor",COLOR_PURPLE,30.0,10000);
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
		PlayerInfo[playerid][pLapar] +=20;
	}
	//Contoh saat minum
 	else if(!strcmp(name, "Susu"))
	{
	    if(PlayerInfo[playerid][pHaus] >= 100) return Send(playerid, -1, "Karaktermu tidak mau minum!");
 		Inventory_Remove(playerid, "Susu Botol", 1);
 		ShowItemBox(playerid, "Susu", "USED_1x", 19570, 2);
	    SetPlayerChatBubble(playerid,"meminum susu",COLOR_PURPLE,30.0,10000);
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.0, 0, 0, 0, 0, 0,1);
		PlayerInfo[playerid][pHaus] +=20;
	}
	else if(!strcmp(name, "Phone"))
	{
	    if(PlayerInfo[playerid][pNumber] == 0) return Send(playerid, COLOR_GREY, "Anda tidak memiliki kartu SIM!");
	    if(player_gag[playerid]) return SCM(playerid, COLOR_GREY, "Anda Sedang Dimute, Mendapatkan Larangan Berbicara");

		ApplyAnimation(playerid,"PED","phone_talk", 4.1, 0, 1, 1, 1, 1, 1);
	}
	else if(!strcmp(name, "P3K"))
	{
	    new Float:shealth;
	 	GetPlayerHealth(playerid, shealth);
	 	if(GetPlayerAnimationIndex(playerid) == 1157) return Send(playerid, -1, "Anda tidak dapat menggunakan dua kotak P3K sekaligus.");
	   	if(shealth >= 100) return Send(playerid,-1, "Jangan gunakan, kesehatan Anda normal.");
	   	if(IsPlayerInAnyVehicle(playerid)) return Send(playerid, -1, "Tidak dapat digunakan dalam transportasi.");

	   	new heal24hp = 60;
		new healedhp;
	   	if((floatround(shealth) + heal24hp) > 100) healedhp = 100 - floatround(shealth);
	   	else healedhp = heal24hp;

		SetPlayerHealthEx(playerid, (floatround(shealth) + healedhp));

		Inventory_Remove(playerid, "P3K", 1);
		ShowItemBox(playerid, "P3K", "USED_1x", 2958, 2);

		new gtexthp[17], gtexthpGTS[17];
		format(gtexthp, sizeof(gtexthp),"~g~+%dhp", healedhp);
		GameTextForPlayer(playerid, gtexthp, 1500, 1);
		format(gtexthpGTS, sizeof(gtexthpGTS),"+%dhp", healedhp);
		SetPlayerChatBubble(playerid, gtexthpGTS ,COLOR_NEWS,15.0,10000);

	    SCMF(playerid, -1, "Anda menggunakan kotak P3K. Kesehatan {33D441}diisi ulang "W"pada {33D441}%d "W"unit", healedhp);
	    ApplyAnimation(playerid,"ped","gum_eat",4.0,0,0,0,0,0,1);
	    SetPlayerAttachedObject(playerid,1,11736,6,0.118999,0.020000,0.026000,-93.699874,-4.799996,88.400108,1.000000,1.000000,1.000000);
	    SetTimerEx("HealUnFr", 1600, false, "d", playerid);
	}
	else if(!strcmp(name, "Cellphone"))
	{
	    TextDrawShowForPlayer(playerid, HANDPHONETD[0]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[1]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[2]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[3]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[4]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[5]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[6]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[7]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[8]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[9]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[10]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[11]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[12]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[13]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[14]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[15]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[16]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[17]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[18]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[19]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[20]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[21]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[22]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[23]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[24]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[25]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[26]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[27]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[28]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[29]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[30]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[31]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[32]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[33]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[34]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[35]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[36]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[37]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[38]);
		TextDrawShowForPlayer(playerid, HANDPHONETD[39]);
		TextDrawShowForPlayer(playerid, CLOSEHP);
		TextDrawShowForPlayer(playerid, FACEBOOKAPK);
		TextDrawShowForPlayer(playerid, GOPAYAPK);
		TextDrawShowForPlayer(playerid, DANAAPK);
		TextDrawShowForPlayer(playerid, INLATERAPK);
		TextDrawShowForPlayer(playerid, PLAYSTOREAPK);
		TextDrawShowForPlayer(playerid, SPOFITYAPK);
		TextDrawShowForPlayer(playerid, TREDINGAPK);
		TextDrawShowForPlayer(playerid, BITCOINAPK);
		PlayerTextDrawShow(playerid, BATREHP[playerid]);
		SelectTextDraw(playerid, 0xFF0000FF);
		Inventory_Close(playerid);
	}
	return 1;
}


stock ShowItemBox(playerid, string[], total[], model, time)
{
	new validtime = time*1000;
	PlayerTextDrawSetString(playerid, NOTIFBOX[playerid][4], string);
	PlayerTextDrawSetString(playerid, NOTIFBOX[playerid][1], total);

	PlayerTextDrawSetPreviewModel(playerid, NOTIFBOX[playerid][5], model);
	if(model == 18867)
	{
		PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], -271.000000, 0.000000, 0.000000, 2.029999);
	}
	else if(model == 2958)
	{
		PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], 0.000000, 0.000000, -85.000000, 2.029999);
	}
	else if(model == 2703)
	{
		PlayerTextDrawSetPreviewRot(playerid, NOTIFBOX[playerid][5], -80.000000, 0.000000, -12.000000, 2.779998);
	}
	for(new i = 0; i < 6; i++)
	{
		PlayerTextDrawShow(playerid, NOTIFBOX[playerid][i]);
	}
 	SetTimerEx("HideItemBox", validtime, false, "d", playerid);
	return 1;
}

publics: HideItemBox(playerid)
{
    for(new i = 0; i < 6; i++)
	{
		PlayerTextDrawHide(playerid, NOTIFBOX[playerid][i]);
	}
	return 1;
}

epublic:UpdateInv(playerid)
{
	Inventory_Update(playerid);
	return SetTimerEx("UpdateInv", 250, false, "d", playerid);
}

CMD:setitem(playerid, params[])
{
	new
	    userid,
		item[32],
		amount;

    if(PlayerInfo[playerid][pAdminLevel] < 1 || !admin_logged[playerid]) return 1;

	if (sscanf(params, "uds[32]", userid, amount, item))
	    return SendClientMessage(playerid, 0xAFAFAFFF, "USE: /setitem [playerid/name] [amount] [item name]");

	for (new i = 0; i < sizeof(g_aInventoryItems); i ++) if (!strcmp(g_aInventoryItems[i][e_InventoryItem], item, true))
	{
	    new tes = amount * g_aInventoryItems[i][e_InventoryTotal];
       	Inventory_Set(userid, g_aInventoryItems[i][e_InventoryItem], g_aInventoryItems[i][e_InventoryModel], amount, tes);

		return SCMF(playerid, 0xAFAFAFFF, "You have set %s's \"%s\" to %d.", Name(userid), item, amount);
	}
	SendClientMessage(playerid, 0xAFAFAFFF, "ERROR: Invalid item name (use /itemlist for list)");
	return 1;
}

CMD:itemlist(playerid, params[])
{
	new string[1024];

    if(PlayerInfo[playerid][pAdminLevel] < 1 || !admin_logged[playerid]) return 1;

	if (!strlen(string))
	{
		for (new i = 0; i < sizeof(g_aInventoryItems); i ++)
		{
			format(string, sizeof(string), "%s%s\n", string, g_aInventoryItems[i][e_InventoryItem]);
		}
	}
	return SPD(playerid, 0000, DIALOG_STYLE_LIST, "List of Items", string, "Select", "Cancel");
}

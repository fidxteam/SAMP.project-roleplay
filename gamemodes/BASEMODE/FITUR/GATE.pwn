#define MAX_GATES       		20
#define GATE_OBJECT     		980
#define GATE_STATE_CLOSED   	0
#define GATE_STATE_OPEN         1

enum fs_gates
{
	gCreated,
	Float:gX,
	Float:gY,
	Float:gZ,
	Float:gA,
	gObject,
	gPlacedBy[24],
	gStatus,
	gPassword
}

new GateInfo[MAX_GATES][fs_gates];

stock GateLoad()
{
    for( new i = 0; i != MAX_GATES; i++ )
	{
	    if( GateInfo[i][gCreated] == 0 )
	    {
			new file[64];
			format( file, 64, "Database/Databasegate/%d.dat", i );
			if( fexist( file ) )
			{
			    GateInfo[i][gCreated] = 1;
				GateInfo[i][gX] = dini_Float( file, "X" );
				GateInfo[i][gY] = dini_Float( file, "Y" );
				GateInfo[i][gZ] = dini_Float( file, "Z" );
				GateInfo[i][gA] = dini_Float( file, "A" );
				GateInfo[i][gStatus] = dini_Int( file, "Status" );
				GateInfo[i][gPassword] = dini_Int( file, "Password" );
				format( GateInfo[i][gPlacedBy], 24, dini_Get( file, "PlacedBy" ) );
				GateInfo[i][gObject] = CreateObject( GATE_OBJECT, GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ], 0, 0, GateInfo[i][gA] );
            }
        }
    }
    return 1;
}

stock SaveGate()
{
    for( new i = 0; i != MAX_GATES; i++ )
	{
	    if( GateInfo[i][gCreated] == 1 )
	    {
			new file[64];
			format( file, 64, "Database/Databasegate/%d.dat", i );
			if( fexist( file ) )
			{
				dini_IntSet( file, "Object", GateInfo[i][gObject] );
				dini_FloatSet( file, "X", GateInfo[i][gX] );
				dini_FloatSet( file, "Y", GateInfo[i][gY] );
				dini_FloatSet( file, "Z", GateInfo[i][gZ] );
				dini_FloatSet( file, "A", GateInfo[i][gA] );
				dini_IntSet( file, "Status", GateInfo[i][gStatus] );
				dini_IntSet( file, "Password", GateInfo[i][gPassword] );
				dini_Set( file, "PlacedBy", GateInfo[i][gPlacedBy] );
				DestroyObject( GateInfo[i][gObject] );
				format( GateInfo[i][gPlacedBy], 24, "None" );
		        GateInfo[i][gCreated] = 0;
		        GateInfo[i][gX] = 0.0;
		        GateInfo[i][gY] = 0.0;
		        GateInfo[i][gZ] = 0.0;
		        GateInfo[i][gA] = 0.0;
		        GateInfo[i][gStatus] = GATE_STATE_CLOSED;
            }
        }
    }
	return 1;
}

stock CreateGate( playerid, password, Float:x, Float:y, Float:z, Float:a )
{
	for( new i = 0; i != MAX_GATES; i++ )
	{
	    if( GateInfo[i][gCreated] == 0 )
	    {
			new szName[24];
			GetPlayerName( playerid, szName, 24 );

			GateInfo[i][gObject] = CreateObject( GATE_OBJECT, x, y, z+1.5, 0, 0, a );

			format( GateInfo[i][gPlacedBy], 24, "%s", szName );
	        GateInfo[i][gCreated] = 1;
	        GateInfo[i][gX] = x;
	        GateInfo[i][gY] = y;
	        GateInfo[i][gZ] = z+1.5; // comment the +1.5 if you're not using object 980.
	        GateInfo[i][gA] = a;
			GateInfo[i][gStatus] = GATE_STATE_CLOSED;
			GateInfo[i][gPassword] = password;
			SetPlayerPos( playerid, x+1, y+1, z );

			new file[64];
			format( file, 64, "Database/Databasegate/%d.dat", i );
			if( !fexist( file ) )
			{
			    dini_Create( file );
				dini_IntSet( file, "Object", GateInfo[i][gObject] );
				dini_FloatSet( file, "X", GateInfo[i][gX] );
				dini_FloatSet( file, "Y", GateInfo[i][gY] );
				dini_FloatSet( file, "Z", GateInfo[i][gZ] );
				dini_FloatSet( file, "A", GateInfo[i][gA] );
				dini_IntSet( file, "Status", GateInfo[i][gStatus] );
				dini_Set( file, "PlacedBy", GateInfo[i][gPlacedBy] );
            }
			break;
        }
    }
}

CMD:creategate( playerid, params[] )
{
    if(PlayerInfo[playerid][pAdminLevel] < 8) return ShowError(playerid, "You are not authorized to use this command");
	if( isnull( params) )
	    return SendClientMessage( playerid, -1, "USE: /creategate [password]" );

	if( !strval( params ) )
	    return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0}You need to enter a password." );

	if( IsPlayerInAnyVehicle( playerid ) )
	    return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You need to get out of the car." );

	new Float:pPos[4];
	GetPlayerPos( playerid, pPos[0], pPos[1], pPos[2] );
	GetPlayerFacingAngle( playerid, pPos[3] );
	CreateGate( playerid, strval( params ), pPos[0], pPos[1], pPos[2], pPos[3] );
	SendClientMessage( playerid, -1, "INFO You have successfully created the gate. Use /gopen and /gclose to open and close gates." );

	return 1;
}

CMD:gopen( playerid, params[] )
{
	if( isnull( params ) )
	    return SendClientMessage( playerid, -1, "Use: /gopen [Password Gates]" );

	new szName[24], gate = -1;
	GetPlayerName( playerid, szName, 24 );
	for( new i = 0; i != MAX_GATES; i++ )
		if( GateInfo[i][gCreated] == 1 )
			if( strval( params ) == GateInfo[i][gPassword] )
				{ gate = i; break; }

	if( gate != -1 )
	{
	    if( !IsObjectMoving( GateInfo[gate][gObject] ) )
	    {
	    	if( IsPlayerInRangeOfPoint( playerid, 10.0, GateInfo[gate][gX], GateInfo[gate][gY], GateInfo[gate][gZ] ) )
			{
   				if( GateInfo[gate][gStatus] == GATE_STATE_CLOSED )
	        	{
				    MoveObject( GateInfo[gate][gObject], GateInfo[gate][gX], GateInfo[gate][gY], GateInfo[gate][gZ]-5.3, 7.0 );
					SendClientMessage( playerid, -1, "You have opened the gate." );
				}

				else
	    			return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} The gate is already open." );
			}

			else
    			return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You are not near the gate.." );
        }

       	else
	    	return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You have to wait for the gate to move" );
	}

	else
	    return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} Invalid password" );

	return 1;
}

CMD:gclose( playerid, params[] )
{
	if( isnull( params ) )
	    return SendClientMessage( playerid, -1, "Use: /gclose [Password]" );

	new szName[24], gate = -1;
	GetPlayerName( playerid, szName, 24 );
	for( new i = 0; i != MAX_GATES; i++ )
		if( GateInfo[i][gCreated] == 1 )
			if( strval( params ) == GateInfo[i][gPassword] )
				{ gate = i; break; }

	if( gate != -1 )
	{
	    if( !IsObjectMoving( GateInfo[gate][gObject] ) )
	    {
	       	if( IsPlayerInRangeOfPoint( playerid, 10.0, GateInfo[gate][gX], GateInfo[gate][gY], GateInfo[gate][gZ] ) )
			{
				if( GateInfo[gate][gStatus] == GATE_STATE_OPEN )
	        	{
				    MoveObject( GateInfo[gate][gObject], GateInfo[gate][gX], GateInfo[gate][gY], GateInfo[gate][gZ]+5.3, 7.0 );
					SendClientMessage( playerid, -1, "You have closed the gate." );
				}

				else
	    			return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} The gate is already closed." );
			}

			else
				return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You are not near the gate" );
        }

       	else
	    	return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You have to wait for the gate to move." );
	}

	else
	    return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} Invalid password." );

	return 1;
}

CMD:removegate( playerid, params[] )
{
    if(PlayerInfo[playerid][pAdminLevel] < 8) return ShowError(playerid, "You are not authorized to use this command");
	for( new i = 0; i != MAX_GATES; i++ )
	{
		if( GateInfo[i][gCreated] == 1 )
		{
		    if( IsPlayerInRangeOfPoint( playerid, 10.0, GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ] ) )
			{
  				new szName[24];
				GetPlayerName( playerid, szName, 24 );
				if( !strcmp( szName, GateInfo[i][gPlacedBy], true ) || IsPlayerAdmin( playerid ) )
				{
					DestroyObject( GateInfo[i][gObject] );
					format( GateInfo[i][gPlacedBy], 24, "None" );
			        GateInfo[i][gCreated] = 0;
			        GateInfo[i][gX] = 0.0;
			        GateInfo[i][gY] = 0.0;
			        GateInfo[i][gZ] = 0.0;
			        GateInfo[i][gA] = 0.0;
			        GateInfo[i][gPassword] = 0;
			        GateInfo[i][gStatus] = GATE_STATE_CLOSED;
			        SendClientMessage( playerid, -1, "You have removed the gate." );

					new file[32];
					format( file, 32, "Database/Databasegate/%d.dat", i );
					if( dini_Exists( file ) )
	    				dini_Remove( file );
					break;
                }

				else
					return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You are not the owner of this gate" );
			}

			else
				return SendClientMessage( playerid, -1, "You are not near the gate." );
        }
    }

	return 1;
}

CMD:gateinfo( playerid, params[] )
{
	if( IsPlayerAdmin( playerid ) )
	{
		for( new i = 0; i != MAX_GATES; i++ )
		{
			if( GateInfo[i][gCreated] == 1 )
			{
			    if( IsPlayerInRangeOfPoint( playerid, 5.0, GateInfo[i][gX], GateInfo[i][gY], GateInfo[i][gZ] ) )
				{
					new szString[128];
					format( szString, 128, "Gate Info( Placed by: %s | Password: %d)", GateInfo[i][gPlacedBy], GateInfo[i][gPassword] );
					SendClientMessage( playerid, -1, szString );
					return 1;
				}

				else
					return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You are not near the gate." );
	        }
	    }
    }

	else
		return SendClientMessage( playerid, -1, "{ff0000}ERROR: {ffffe0} You are not an admin." );
	return 1;
}

/*|==============================================================|INCUDES|===============================================================|*/
#include < a_samp >
#include < sscanf2 >
#include < streamer >
#include < Pawn.CMD >
#include < colandreas >
/*|==============================================================|INCUDES|===============================================================|*/

/*|==============================================================|DEFINES|===============================================================|*/
#if !defined INV_MAX_PAGES
	#define INV_MAX_PAGES			( 3 )
#endif

#if !defined INV_MAX_ITEMS
	#define INV_MAX_ITEMS			( 6 )
#endif

#if !defined INV_TOTAL_MAX_ITEMS
	#define INV_TOTAL_MAX_ITEMS		( INV_MAX_PAGES*INV_MAX_ITEMS )
#endif
/*|==============================================================|DEFINES|===============================================================|*/

/*|=============================================================|ENUMATORS|==============================================================|*/
enum E_DATA_INVENTORY {
	bool:e_Used[ INV_MAX_ITEMS ],
	e_GunID[ INV_MAX_ITEMS ]
};

enum {
	DIALOG_INV_CONFIRM = 1
};
/*|=============================================================|ENUMATORS|==============================================================|*/

/*|=============================================================|VARIABLES|==============================================================|*/
new InvInfo[ MAX_PLAYERS ] [ INV_MAX_PAGES ] [ E_DATA_INVENTORY ];
/*|=============================================================|VARIABLES|==============================================================|*/

/*|=============================================================|GLOBAL-TDS|=============================================================|*/

/*|=============================================================|GLOBAL-TDS|=============================================================|*/
new Text:textdraw_0, Text:textdraw_1, Text:textdraw_2, Text:textdraw_3;
/*|=============================================================|GLOBAL-TDS|=============================================================|*/

/*|=============================================================|PLAYER-TDS|=============================================================|*/
new PlayerText:InvGun[ 6 ], PlayerText:InvLeft, PlayerText:InvRight, 
	PlayerText:NearGun1, PlayerText:NearGun2, PlayerText:NearGun3, PlayerText:NearLeft, PlayerText:NearRight;
/*|=============================================================|PLAYER-TDS|=============================================================|*/

/*|==============================================================|TD-FUNC|===============================================================|*/
INV_CreateTextdraws( playerid = INVALID_PLAYER_ID ) {
	if( playerid == INVALID_PLAYER_ID ) {
		textdraw_0 = TextDrawCreate(321.000000, 121.000000, "_");
		TextDrawFont(textdraw_0, 1);
		TextDrawLetterSize(textdraw_0, 0.975000, 29.750001);
		TextDrawTextSize(textdraw_0, 326.000000, 389.500000);
		TextDrawSetOutline(textdraw_0, 1);
		TextDrawSetShadow(textdraw_0, 0);
		TextDrawAlignment(textdraw_0, 2);
		TextDrawColor(textdraw_0, -1);
		TextDrawBackgroundColor(textdraw_0, 255);
		TextDrawBoxColor(textdraw_0, 135);
		TextDrawUseBox(textdraw_0, 1);
		TextDrawSetProportional(textdraw_0, 1);
		TextDrawSetSelectable(textdraw_0, 0);

		textdraw_1 = TextDrawCreate(321.000000, 123.000000, "_");
		TextDrawFont(textdraw_1, 1);
		TextDrawLetterSize(textdraw_1, 0.600000, 29.249982);
		TextDrawTextSize(textdraw_1, 298.500000, 386.000000);
		TextDrawSetOutline(textdraw_1, 1);
		TextDrawSetShadow(textdraw_1, 0);
		TextDrawAlignment(textdraw_1, 2);
		TextDrawColor(textdraw_1, -1);
		TextDrawBackgroundColor(textdraw_1, 255);
		TextDrawBoxColor(textdraw_1, 9145223);
		TextDrawUseBox(textdraw_1, 1);
		TextDrawSetProportional(textdraw_1, 1);
		TextDrawSetSelectable(textdraw_1, 0);

		textdraw_2 = TextDrawCreate(400.500000, 127.000000, "_");
		TextDrawFont(textdraw_2, 1);
		TextDrawLetterSize(textdraw_2, 0.600000, 15.800006);
		TextDrawTextSize(textdraw_2, 298.500000, 206.000000);
		TextDrawSetOutline(textdraw_2, 1);
		TextDrawSetShadow(textdraw_2, 0);
		TextDrawAlignment(textdraw_2, 2);
		TextDrawColor(textdraw_2, -1);
		TextDrawBackgroundColor(textdraw_2, 255);
		TextDrawBoxColor(textdraw_2, -1962934137);
		TextDrawUseBox(textdraw_2, 1);
		TextDrawSetProportional(textdraw_2, 1);
		TextDrawSetSelectable(textdraw_2, 0);

		textdraw_3 = TextDrawCreate(167.000000, 125.000000, "_");
		TextDrawFont(textdraw_3, 1);
		TextDrawLetterSize(textdraw_3, 0.600000, 28.750007);
		TextDrawTextSize(textdraw_3, 298.500000, 74.000000);
		TextDrawSetOutline(textdraw_3, 1);
		TextDrawSetShadow(textdraw_3, 0);
		TextDrawAlignment(textdraw_3, 2);
		TextDrawColor(textdraw_3, -1);
		TextDrawBackgroundColor(textdraw_3, 255);
		TextDrawBoxColor(textdraw_3, 135);
		TextDrawUseBox(textdraw_3, 1);
		TextDrawSetProportional(textdraw_3, 1);
		TextDrawSetSelectable(textdraw_3, 0);
	} else {
		InvGun[ 0 ] = CreatePlayerTextDraw(playerid, 298.000000, 127.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, InvGun[ 0 ], 5);
		PlayerTextDrawLetterSize(playerid, InvGun[ 0 ], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvGun[ 0 ], 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, InvGun[ 0 ], 0);
		PlayerTextDrawSetShadow(playerid, InvGun[ 0 ], 0);
		PlayerTextDrawAlignment(playerid, InvGun[ 0 ], 1);
		PlayerTextDrawColor(playerid, InvGun[ 0 ], -1);
		PlayerTextDrawBackgroundColor(playerid, InvGun[ 0 ], -2686721);
		PlayerTextDrawBoxColor(playerid, InvGun[ 0 ], 0);
		PlayerTextDrawUseBox(playerid, InvGun[ 0 ], 0);
		PlayerTextDrawSetProportional(playerid, InvGun[ 0 ], 1);
		PlayerTextDrawSetSelectable(playerid, InvGun[ 0 ], 1);
		PlayerTextDrawSetPreviewModel(playerid, InvGun[ 0 ], 356);
		PlayerTextDrawSetPreviewRot(playerid, InvGun[ 0 ], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, InvGun[ 0 ], 1, 1);

		InvGun[ 1 ] = CreatePlayerTextDraw(playerid, 367.000000, 127.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, InvGun[ 1 ], 5);
		PlayerTextDrawLetterSize(playerid, InvGun[ 1 ], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvGun[ 1 ], 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, InvGun[ 1 ], 0);
		PlayerTextDrawSetShadow(playerid, InvGun[ 1 ], 0);
		PlayerTextDrawAlignment(playerid, InvGun[ 1 ], 1);
		PlayerTextDrawColor(playerid, InvGun[ 1 ], -1);
		PlayerTextDrawBackgroundColor(playerid, InvGun[ 1 ], -2686721);
		PlayerTextDrawBoxColor(playerid, InvGun[ 1 ], 0);
		PlayerTextDrawUseBox(playerid, InvGun[ 1 ], 0);
		PlayerTextDrawSetProportional(playerid, InvGun[ 1 ], 1);
		PlayerTextDrawSetSelectable(playerid, InvGun[ 1 ], 1);
		PlayerTextDrawSetPreviewModel(playerid, InvGun[ 1 ], 355);
		PlayerTextDrawSetPreviewRot(playerid, InvGun[ 1 ], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, InvGun[ 1 ], 1, 1);

		InvGun[ 2 ] = CreatePlayerTextDraw(playerid, 436.000000, 127.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, InvGun[ 2 ], 5);
		PlayerTextDrawLetterSize(playerid, InvGun[ 2 ], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvGun[ 2 ], 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, InvGun[ 2 ], 0);
		PlayerTextDrawSetShadow(playerid, InvGun[ 2 ], 0);
		PlayerTextDrawAlignment(playerid, InvGun[ 2 ], 1);
		PlayerTextDrawColor(playerid, InvGun[ 2 ], -1);
		PlayerTextDrawBackgroundColor(playerid, InvGun[ 2 ], -2686721);
		PlayerTextDrawBoxColor(playerid, InvGun[ 2 ], 0);
		PlayerTextDrawUseBox(playerid, InvGun[ 2 ], 0);
		PlayerTextDrawSetProportional(playerid, InvGun[ 2 ], 1);
		PlayerTextDrawSetSelectable(playerid, InvGun[ 2 ], 1);
		PlayerTextDrawSetPreviewModel(playerid,InvGun[ 2 ], 348);
		PlayerTextDrawSetPreviewRot(playerid,InvGun[ 2 ], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid,InvGun[ 2 ], 1, 1);

		InvGun[ 5 ] = CreatePlayerTextDraw(playerid,436.000000, 199.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, InvGun[ 5 ], 5);
		PlayerTextDrawLetterSize(playerid, InvGun[ 5 ], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvGun[ 5 ], 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, InvGun[ 5 ], 0);
		PlayerTextDrawSetShadow(playerid, InvGun[ 5 ], 0);
		PlayerTextDrawAlignment(playerid, InvGun[ 5 ], 1);
		PlayerTextDrawColor(playerid, InvGun[ 5 ], -1);
		PlayerTextDrawBackgroundColor(playerid, InvGun[ 5 ], -2686721);
		PlayerTextDrawBoxColor(playerid, InvGun[ 5 ], 0);
		PlayerTextDrawUseBox(playerid, InvGun[ 5 ], 0);
		PlayerTextDrawSetProportional(playerid, InvGun[ 5 ], 1);
		PlayerTextDrawSetSelectable(playerid, InvGun[ 5 ], 1);
		PlayerTextDrawSetPreviewModel(playerid, InvGun[ 5 ], 358);
		PlayerTextDrawSetPreviewRot(playerid, InvGun[ 5 ], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, InvGun[ 5 ], 1, 1);

		InvGun[ 4 ] = CreatePlayerTextDraw(playerid, 367.000000, 199.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, InvGun[ 4 ], 5);
		PlayerTextDrawLetterSize(playerid, InvGun[ 4 ], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvGun[ 4 ], 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, InvGun[ 4 ], 0);
		PlayerTextDrawSetShadow(playerid, InvGun[ 4 ], 0);
		PlayerTextDrawAlignment(playerid, InvGun[ 4 ], 1);
		PlayerTextDrawColor(playerid, InvGun[ 4 ], -1);
		PlayerTextDrawBackgroundColor(playerid, InvGun[ 4 ], -2686721);
		PlayerTextDrawBoxColor(playerid, InvGun[ 4 ], 0);
		PlayerTextDrawUseBox(playerid, InvGun[ 4 ], 0);
		PlayerTextDrawSetProportional(playerid, InvGun[ 4 ], 1);
		PlayerTextDrawSetSelectable(playerid, InvGun[ 4 ], 1);
		PlayerTextDrawSetPreviewModel(playerid, InvGun[ 4 ], 353);
		PlayerTextDrawSetPreviewRot(playerid, InvGun[ 4 ], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, InvGun[ 4 ], 1, 1);

		InvGun[ 3 ] = CreatePlayerTextDraw(playerid, 298.000000, 199.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, InvGun[ 3 ], 5);
		PlayerTextDrawLetterSize(playerid, InvGun[ 3 ], 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvGun[ 3 ], 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, InvGun[ 3 ], 0);
		PlayerTextDrawSetShadow(playerid, InvGun[ 3 ], 0);
		PlayerTextDrawAlignment(playerid, InvGun[ 3 ], 1);
		PlayerTextDrawColor(playerid, InvGun[ 3 ], -1);
		PlayerTextDrawBackgroundColor(playerid, InvGun[ 3 ], -2686721);
		PlayerTextDrawBoxColor(playerid, InvGun[ 3 ], 0);
		PlayerTextDrawUseBox(playerid, InvGun[ 3 ], 0);
		PlayerTextDrawSetProportional(playerid, InvGun[ 3 ], 1);
		PlayerTextDrawSetSelectable(playerid, InvGun[ 3 ], 1);
		PlayerTextDrawSetPreviewModel(playerid, InvGun[ 3 ], 351);
		PlayerTextDrawSetPreviewRot(playerid, InvGun[ 3 ], -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, InvGun[ 3 ], 1, 1);

		InvLeft = CreatePlayerTextDraw(playerid, 297.000000, 285.000000, "ld_beat:left");
		PlayerTextDrawFont(playerid, InvLeft, 4);
		PlayerTextDrawLetterSize(playerid, InvLeft, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvLeft, 17.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, InvLeft, 1);
		PlayerTextDrawSetShadow(playerid, InvLeft, 0);
		PlayerTextDrawAlignment(playerid, InvLeft, 1);
		PlayerTextDrawColor(playerid, InvLeft, -1);
		PlayerTextDrawBackgroundColor(playerid, InvLeft, 255);
		PlayerTextDrawBoxColor(playerid, InvLeft, 50);
		PlayerTextDrawUseBox(playerid, InvLeft, 1);
		PlayerTextDrawSetProportional(playerid, InvLeft, 1);
		PlayerTextDrawSetSelectable(playerid, InvLeft, 1);

		InvRight = CreatePlayerTextDraw(playerid, 488.000000, 285.000000, "ld_beat:right");
		PlayerTextDrawFont(playerid, InvRight, 4);
		PlayerTextDrawLetterSize(playerid, InvRight, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, InvRight, 17.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, InvRight, 1);
		PlayerTextDrawSetShadow(playerid, InvRight, 0);
		PlayerTextDrawAlignment(playerid, InvRight, 1);
		PlayerTextDrawColor(playerid, InvRight, -1);
		PlayerTextDrawBackgroundColor(playerid, InvRight, 255);
		PlayerTextDrawBoxColor(playerid, InvRight, 50);
		PlayerTextDrawUseBox(playerid, InvRight, 1);
		PlayerTextDrawSetProportional(playerid, InvRight, 1);
		PlayerTextDrawSetSelectable(playerid, InvRight, 1);

		NearGun1 = CreatePlayerTextDraw(playerid, 133.000000, 127.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, NearGun1, 5);
		PlayerTextDrawLetterSize(playerid, NearGun1, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, NearGun1, 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, NearGun1, 0);
		PlayerTextDrawSetShadow(playerid, NearGun1, 0);
		PlayerTextDrawAlignment(playerid, NearGun1, 1);
		PlayerTextDrawColor(playerid, NearGun1, -1);
		PlayerTextDrawBackgroundColor(playerid, NearGun1, -2686721);
		PlayerTextDrawBoxColor(playerid, NearGun1, 0);
		PlayerTextDrawUseBox(playerid, NearGun1, 0);
		PlayerTextDrawSetProportional(playerid, NearGun1, 1);
		PlayerTextDrawSetSelectable(playerid, NearGun1, 1);
		PlayerTextDrawSetPreviewModel(playerid, NearGun1, 352);
		PlayerTextDrawSetPreviewRot(playerid, NearGun1, -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, NearGun1, 1, 1);

		NearGun2 = CreatePlayerTextDraw(playerid, 133.000000, 199.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, NearGun2, 5);
		PlayerTextDrawLetterSize(playerid, NearGun2, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, NearGun2, 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, NearGun2, 0);
		PlayerTextDrawSetShadow(playerid, NearGun2, 0);
		PlayerTextDrawAlignment(playerid, NearGun2, 1);
		PlayerTextDrawColor(playerid, NearGun2, -1);
		PlayerTextDrawBackgroundColor(playerid, NearGun2, -2686721);
		PlayerTextDrawBoxColor(playerid, NearGun2, 0);
		PlayerTextDrawUseBox(playerid, NearGun2, 0);
		PlayerTextDrawSetProportional(playerid, NearGun2, 1);
		PlayerTextDrawSetSelectable(playerid, NearGun2, 1);
		PlayerTextDrawSetPreviewModel(playerid, NearGun2, 357);
		PlayerTextDrawSetPreviewRot(playerid, NearGun2, -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, NearGun2, 1, 1);

		NearGun3 = CreatePlayerTextDraw(playerid, 133.000000, 271.000000, "Preview_Model");
		PlayerTextDrawFont(playerid, NearGun3, 5);
		PlayerTextDrawLetterSize(playerid, NearGun3, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, NearGun3, 67.000000, 70.000000);
		PlayerTextDrawSetOutline(playerid, NearGun3, 0);
		PlayerTextDrawSetShadow(playerid, NearGun3, 0);
		PlayerTextDrawAlignment(playerid, NearGun3, 1);
		PlayerTextDrawColor(playerid, NearGun3, -1);
		PlayerTextDrawBackgroundColor(playerid, NearGun3, -2686721);
		PlayerTextDrawBoxColor(playerid, NearGun3, 0);
		PlayerTextDrawUseBox(playerid, NearGun3, 0);
		PlayerTextDrawSetProportional(playerid, NearGun3, 1);
		PlayerTextDrawSetSelectable(playerid, NearGun3, 1);
		PlayerTextDrawSetPreviewModel(playerid, NearGun3, 349);
		PlayerTextDrawSetPreviewRot(playerid, NearGun3, -10.000000, 0.000000, -20.000000, 1.000000);
		PlayerTextDrawSetPreviewVehCol(playerid, NearGun3, 1, 1);

		NearLeft = CreatePlayerTextDraw(playerid, 133.000000, 351.000000, "ld_beat:left");
		PlayerTextDrawFont(playerid, NearLeft, 4);
		PlayerTextDrawLetterSize(playerid, NearLeft, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, NearLeft, 17.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, NearLeft, 1);
		PlayerTextDrawSetShadow(playerid, NearLeft, 0);
		PlayerTextDrawAlignment(playerid, NearLeft, 1);
		PlayerTextDrawColor(playerid, NearLeft, -1);
		PlayerTextDrawBackgroundColor(playerid, NearLeft, 255);
		PlayerTextDrawBoxColor(playerid, NearLeft, 50);
		PlayerTextDrawUseBox(playerid, NearLeft, 1);
		PlayerTextDrawSetProportional(playerid, NearLeft, 1);
		PlayerTextDrawSetSelectable(playerid, NearLeft, 1);

		NearRight = CreatePlayerTextDraw(playerid, 184.000000, 351.000000, "ld_beat:right");
		PlayerTextDrawFont(playerid, NearRight, 4);
		PlayerTextDrawLetterSize(playerid, NearRight, 0.600000, 2.000000);
		PlayerTextDrawTextSize(playerid, NearRight, 17.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, NearRight, 1);
		PlayerTextDrawSetShadow(playerid, NearRight, 0);
		PlayerTextDrawAlignment(playerid, NearRight, 1);
		PlayerTextDrawColor(playerid, NearRight, -1);
		PlayerTextDrawBackgroundColor(playerid, NearRight, 255);
		PlayerTextDrawBoxColor(playerid, NearRight, 50);
		PlayerTextDrawUseBox(playerid, NearRight, 1);
		PlayerTextDrawSetProportional(playerid, NearRight, 1);
		PlayerTextDrawSetSelectable(playerid, NearRight, 1);
	}
	return ( true );
}

INV_DesroyTextdraws( playerid = INVALID_PLAYER_ID ) {
	if( playerid == INVALID_PLAYER_ID ) TextDrawDestroy( textdraw_0 ), TextDrawDestroy( textdraw_1 ), TextDrawDestroy( textdraw_2 ), TextDrawDestroy( textdraw_3 );
	else PlayerTextDrawDestroy( playerid, InvGun[ 0 ] ), PlayerTextDrawDestroy( playerid, InvGun[ 1 ] ), PlayerTextDrawDestroy( playerid, InvGun[ 2 ] ),
		 PlayerTextDrawDestroy( playerid, InvGun[ 3 ] ), PlayerTextDrawDestroy( playerid, InvGun[ 4 ] ), PlayerTextDrawDestroy( playerid, InvGun[ 5 ] ),
		 PlayerTextDrawDestroy( playerid, InvLeft ), PlayerTextDrawDestroy( playerid, InvRight ), PlayerTextDrawDestroy( playerid, NearGun1 ),
		 PlayerTextDrawDestroy( playerid, NearGun2 ), PlayerTextDrawDestroy( playerid, NearGun3 ), PlayerTextDrawDestroy( playerid, NearLeft ),
		 PlayerTextDrawDestroy( playerid, NearRight );
	return ( true );
}
INV_ShowTextdraws( playerid ) {
	TextDrawShowForPlayer( playerid, textdraw_0 ), TextDrawShowForPlayer( playerid, textdraw_1 ), TextDrawShowForPlayer( playerid, textdraw_2 ), 
	TextDrawShowForPlayer( playerid, textdraw_3 ), PlayerTextDrawShow( playerid, InvGun[ 0 ] ), PlayerTextDrawShow( playerid, InvGun[ 1 ] ), 
	PlayerTextDrawShow( playerid, InvGun[ 2 ] ), PlayerTextDrawShow( playerid, InvGun[ 3 ] ), PlayerTextDrawShow( playerid, InvGun[ 4 ] ), 
	PlayerTextDrawShow( playerid, InvGun[ 5 ] ), PlayerTextDrawShow( playerid, InvLeft ), PlayerTextDrawShow( playerid, InvRight ), 
	PlayerTextDrawShow( playerid, NearGun1 ), PlayerTextDrawShow( playerid, NearGun2 ), PlayerTextDrawShow( playerid, NearGun3 ), 
	PlayerTextDrawShow( playerid, NearLeft ), PlayerTextDrawShow( playerid, NearRight ), SelectTextDraw( playerid, 0xe5ff00ff );
	return ( true );
}
/*|==============================================================|TD-FUNC|===============================================================|*/

/*|=============================================================|FUNCTIONS|===============================================================|*/
INV_ResetVars( playerid ) {
	for( new i; i < INV_MAX_ITEMS; i++ ) {
		for( new p; p < INV_MAX_PAGES; p++ ) {
			InvInfo[ playerid ] [ p ] [ e_Used ] [ i ] = false;
			InvInfo[ playerid ] [ p ] [ e_GunID ] [ i ] = 0;
		}
	}
	DeletePVar( playerid, "_InvClick" );
	DeletePVar( playerid, "_InvSelGun" );
	DeletePVar( playerid, "_InvPage" );
	DeletePVar( playerid, "_InvSeeing" );
	return ( true );
}

INV_Show( playerid ) {
	INV_Close( playerid );
	SetPVarInt( playerid, "_InvSeeing", 1 );
	for( new i, d = INV_MAX_ITEMS; i < d; i++ ) {
		if( !InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_Used ] [ i ] ) {
			PlayerTextDrawSetPreviewModel( playerid, InvGun[ i ], 999999 );
			continue;
		}
		PlayerTextDrawSetPreviewModel( playerid, InvGun[ i ], GetModelGun( InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_GunID ] [ i ] ) );

	}
	INV_ShowTextdraws( playerid );
	return ( true );
}

INV_Close( playerid ) {
	DeletePVar( playerid, "_InvSeeing" );
	TextDrawHideForPlayer( playerid, textdraw_0 ), TextDrawHideForPlayer( playerid, textdraw_1 ), TextDrawHideForPlayer( playerid, textdraw_2 ), 
	TextDrawHideForPlayer( playerid, textdraw_3 ), PlayerTextDrawHide( playerid, InvGun[ 0 ] ), PlayerTextDrawHide( playerid, InvGun[ 1 ] ), 
	PlayerTextDrawHide( playerid, InvGun[ 2 ] ), PlayerTextDrawHide( playerid, InvGun[ 3 ] ), PlayerTextDrawHide( playerid, InvGun[ 4 ] ), 
	PlayerTextDrawHide( playerid, InvGun[ 5 ] ), PlayerTextDrawHide( playerid, InvLeft ), PlayerTextDrawHide( playerid, InvRight ), 
	PlayerTextDrawHide( playerid, NearGun1 ), PlayerTextDrawHide( playerid, NearGun2 ), PlayerTextDrawHide( playerid, NearGun3 ), 
	PlayerTextDrawHide( playerid, NearLeft ), PlayerTextDrawHide( playerid, NearRight );
	return ( true );
}

INV_GetFreeSlot( playerid, &page, &item ) {
	for( new i; i < INV_MAX_PAGES; i++ ) {
		for( new j; j < INV_MAX_ITEMS; j++) {
			if( !InvInfo[ playerid ] [ i ] [ e_Used ] [ j ] ) return page = i, item = j;
		}
	} 
	return ( page = -1, item = -1 );
}

GetModelGun( gunid )  {
	new ModelID;
	switch( gunid ) {
		case WEAPON_BRASSKNUCKLE: ModelID = 331;
		case WEAPON_GOLFCLUB:  ModelID = 333;
		case WEAPON_NITESTICK: ModelID = 334;
		case WEAPON_KNIFE: ModelID = 335;
		case WEAPON_BAT: ModelID = 336;
		case WEAPON_SHOVEL: ModelID = 337;
		case WEAPON_POOLSTICK: ModelID = 338;
		case WEAPON_KATANA: ModelID = 339;
		case WEAPON_CHAINSAW: ModelID = 19086;
		case WEAPON_DILDO: ModelID = 321;
		case WEAPON_DILDO2: ModelID = 332;
		case WEAPON_VIBRATOR: ModelID = 14890;
		case WEAPON_VIBRATOR2: ModelID = 14890;
		case WEAPON_FLOWER: ModelID = 325;
		case WEAPON_CANE: ModelID = 326;
		case WEAPON_GRENADE: ModelID = 342;
		case WEAPON_TEARGAS: ModelID = 343;
		case WEAPON_MOLTOV: ModelID = 344;
		case WEAPON_COLT45: ModelID = 346;
		case WEAPON_SILENCED: ModelID = 347;
		case WEAPON_DEAGLE: ModelID = 348;
		case WEAPON_SHOTGUN: ModelID = 349;
		case WEAPON_SAWEDOFF: ModelID = 350;
		case WEAPON_SHOTGSPA: ModelID = 351;
		case WEAPON_UZI: ModelID = 352;
		case WEAPON_MP5: ModelID = 353;
		case WEAPON_AK47: ModelID = 355;
		case WEAPON_M4: ModelID = 356;
		case WEAPON_TEC9: ModelID = 372;
		case WEAPON_RIFLE: ModelID = 355;
		case WEAPON_SNIPER: ModelID = 358;
		case WEAPON_ROCKETLAUNCHER: ModelID = 359;
		case WEAPON_HEATSEEKER: ModelID = 360; 
		case WEAPON_FLAMETHROWER: ModelID = 361;
		case WEAPON_MINIGUN: ModelID = 362;
		case WEAPON_SATCHEL: ModelID = 363;
		case WEAPON_BOMB: ModelID = 364;
		case WEAPON_SPRAYCAN: ModelID = 365;
		case WEAPON_FIREEXTINGUISHER: ModelID = 366;
		case WEAPON_CAMERA: ModelID = 367;
		case WEAPON_PARACHUTE: ModelID = 371;
		default: ModelID = 999999;
	}
	return ( ModelID );
}

SendClientMessageEx( playerid, color, const text[ ], { Float,_ }:... ) {
	static args, str[ 192 ];

	if( ( args = numargs( ) ) <= 3 ) {
	    SendClientMessage( playerid, color, text );
	}
	else {
		while(--args >= 3) {
			#emit LCTRL 	5
			#emit LOAD.alt 	args
			#emit SHL.C.alt 2
			#emit ADD.C 	12
			#emit ADD
			#emit LOAD.I
			#emit PUSH.pri
		}
		#emit PUSH.S 	text
		#emit PUSH.C 	192
		#emit PUSH.C 	str
		#emit PUSH.S	8
		#emit SYSREQ.C 	format
		#emit LCTRL 	5
		#emit SCTRL 	4
		SendClientMessage(playerid, color, str);
		#emit RETN
	}
	return ( true );
}
/*|=============================================================|FUNCTIONS|===============================================================|*/

/*|=============================================================|CALLBACKS|===============================================================|*/
public OnFilterScriptInit( ) {
	INV_CreateTextdraws( );
	return ( true );
}

public OnFilterScriptExit( ) {
	INV_DesroyTextdraws( );
	return ( true );
}

public OnPlayerConnect( playerid ) {
	INV_CreateTextdraws( playerid );
	return ( true );
}

public OnPlayerDisconnect( playerid, reason ) {
	INV_DesroyTextdraws( playerid );
	INV_ResetVars( playerid );
	return ( true );
}

public OnPlayerClickPlayerTextDraw( playerid, PlayerText:playertextid ) {
	for( new i; i < sizeof( InvGun ); i++ ) {
		if( playertextid == InvGun[ i ] && InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_Used ] [ i ] ) {
			if( GetPVarInt( playerid, "_InvClick" ) < 2 ) {
				SetPVarInt( playerid, "_InvClick", GetPVarInt( playerid, "_InvClick" )+1 );
				SetPVarInt( playerid, "_InvUNIX", gettime( )+2 );
			} else {
				if( GetPVarInt( playerid, "_InvUNIX" ) > gettime( ) ) {
					new str[ 124 ], gName[ 20 ];
					GetWeaponName( InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_GunID ] [ i ], gName, sizeof( gName ) );
					SetPVarInt( playerid, "_InvSelGun", i );
					format( str, sizeof( str ), "Would you like to take %s from your inventory?", gName );
					ShowPlayerDialog( playerid, DIALOG_INV_CONFIRM, DIALOG_STYLE_MSGBOX,  "Confirmation", str, "Yes.", "No." );
				} else DeletePVar( playerid, "_InvClick" );
			}
			return ( true );
		}
	}
	if( playertextid == InvRight ) {
		if( GetPVarInt( playerid, "_InvPage" )+1 >= INV_MAX_PAGES ) 
			return SendClientMessageEx( playerid, -1, "{64e3d0}| [Server] | {FFFFFF}There are only %d pages.", INV_MAX_PAGES );
		else SetPVarInt( playerid, "_InvPage", GetPVarInt( playerid, "_InvPage" )+1 ), INV_Show( playerid );
	}
	if( playertextid == InvLeft ) {
		if( GetPVarInt( playerid, "_InvPage" )-1 < 0 ) 
			return SendClientMessageEx( playerid, -1, "{64e3d0}| [Server] | {FFFFFF}There are only %d pages.", INV_MAX_PAGES );
		else SetPVarInt( playerid, "_InvPage", GetPVarInt( playerid, "_InvPage" )-1 ), INV_Show( playerid );
	}
	return ( true );
}

public OnPlayerClickTextDraw( playerid, Text:clickedid ) {
	if( clickedid == Text:INVALID_TEXT_DRAW && GetPVarInt( playerid, "_InvSeeing") == 1 ) return INV_Close( playerid ), CancelSelectTextDraw( playerid );
	return ( true );
}

public OnDialogResponse( playerid, dialogid, response, listitem, inputtext[ ] ) {
	switch( dialogid ) {
		case DIALOG_INV_CONFIRM: {
			if( response ) {
				new i = GetPVarInt( playerid, "_InvSelGun" ), gName[ 20 ];
				GetWeaponName( InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_GunID ] [ i ], gName, sizeof( gName ) );
				InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_Used ] [ i ] = false;
				PlayerTextDrawSetPreviewModel( playerid, InvGun[ i ], 999999 );
				PlayerTextDrawHide( playerid, InvGun[ i ] );
				PlayerTextDrawShow( playerid, InvGun[ i ] );
				SendClientMessageEx( playerid, -1, "{64e3d0}| [Server] | {FFFFFF}You've took %s from your inventory.", gName );
				GivePlayerWeapon( playerid, InvInfo[ playerid ] [ GetPVarInt( playerid, "_InvPage" ) ] [ e_GunID ] [ i ], 999999 );
			} 
		}
	}
	return ( true );
}
/*|=============================================================|CALLBACKS|===============================================================|*/

/*|==============================================================|COMMANDS|===============================================================|*/
alias:inv( "inventory" );
CMD:inv( playerid ) {
	SetPVarInt( playerid, "_InvPage", 0 );
	INV_Show( playerid );
	return ( true );
}

CMD:addinv( playerid, params[ ] ){
	new page, slot, gunid;
	INV_GetFreeSlot( playerid, page, slot );
	if( page == -1 || slot == -1 ) return SendClientMessage( playerid, -1, "{64e3d0}| [Server] | {FFFFFF}Your inventory is currently full." );
	else if( sscanf( params, "d", gunid ) ) return SendClientMessage( playerid, -1, "{64e3d0}| [Usage] | {FFFFFF}/addinv [Weapon ID]" );
	InvInfo[ playerid ] [ page ] [ e_GunID ] [ slot ] = gunid;
	InvInfo[ playerid ] [ page ] [ e_Used ] [ slot ] = true;
	return ( true );
}
/*|==============================================================|COMMANDS|===============================================================|*/
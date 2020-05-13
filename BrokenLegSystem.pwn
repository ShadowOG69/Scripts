/*|=============================================================|INCUDES|=============================================================|*/
#define FILTERSCRIPT
#include < a_samp >
#include < sscanf2 >
#include < Pawn.CMD >
#define YSI_NO_HEAP_MALLOC
#include < YSI_Coding\y_timers >
#include < YSI_Data\y_bit >
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
/*|=============================================================|INCUDES|=============================================================|*/

/*|============================================================|VARIABLES|============================================================|*/
new BitArray:PlayerBrokeLeg< MAX_PLAYERS >, BitArray:CrawlTimer < MAX_PLAYERS >, LastAnimation[ MAX_PLAYERS ] = { -1, ... };
/*|============================================================|VARIABLES|============================================================|*/

/*|=============================================================|ARRAYS|==============================================================|*/
new FeltMsg[ 5 ] [ 144 ] = {
	{ "Woopsie... You felt and twisted your ankle, it must've hurted so bad..." },
	{ "Dammit, you failed to flex your parkour skills and broke foot." },
	{ "Congratulations, you just embarrassed yourself by breaking calf..." },
	{ "You surpassed yourself infront of everyone, crawl now..." },
	{ "If you tried not to act stupid, you wouldn't be crawling now..." }
};
/*|=============================================================|ARRAYS|==============================================================|*/

/*|============================================================|FUNCTIONS|============================================================|*/
ResetBVars( playerid ) {
	if( Bit_Get( PlayerBrokeLeg, playerid ) ) Bit_Vet( PlayerBrokeLeg, playerid );
	if( Bit_Get( CrawlTimer, playerid ) ) Bit_Vet( CrawlTimer, playerid );
	LastAnimation[ playerid ] = -1;
	return ( true );
}
/*|============================================================|FUNCTIONS|============================================================|*/

/*|=============================================================|TIMERS|==============================================================|*/
timer _CrawlPlayer[1000](playerid, option) {
	if( option == 0 ) {
		ApplyAnimation( playerid, "FINALE", "FIN_Cop1_ClimbOut2", 4.1, 0, 1, 1, 1, 1 ), defer _CrawlPlayer[750](playerid, 1);
		return ( true );
	}
	else if( option == 1 ) ApplyAnimation( playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0 ), Bit_Vet( CrawlTimer, playerid );
	return ( true );
}
ptask _OneSecondTimer[1000](playerid) {
	LastAnimation[ playerid ] = GetPlayerAnimationIndex( playerid );
	return ( true );
}
/*|=============================================================|TIMERS|==============================================================|*/

/*|============================================================|CALLBACKS|============================================================|*/
public OnFilterScriptInit() {
	print( "|====================================================|" );
	print( "Breaking leg system has successfully been initialized." );
	print( "|====================================================|" );
	return ( true );
}

public OnPlayerDisconnect( playerid, reason ) return ResetBVars( playerid );

public OnPlayerTakeDamage( playerid, issuerid, Float:amount, weaponid, bodypart ) {
	if( amount >= 9.0 && !Bit_Get( PlayerBrokeLeg, playerid ) && LastAnimation[ playerid ] == 1130 ) {
		ApplyAnimation( playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0 ), SendClientMessage( playerid, 0x757575FF, FeltMsg [ random( sizeof FeltMsg ) ] );
		if( !Bit_Get( PlayerBrokeLeg, playerid ) ) Bit_Let( PlayerBrokeLeg, playerid );
	}
	return ( true );
}

public OnPlayerKeyStateChange( playerid, newkeys, oldkeys ) {
	if( PRESSED( KEY_WALK ) ) {
		if( Bit_Get( PlayerBrokeLeg, playerid ) && !Bit_Get( CrawlTimer, playerid ) ) Bit_Let( CrawlTimer, playerid ), 
																					 defer _CrawlPlayer[750](playerid, 0 );
	}
	return ( true );
}
/*|============================================================|CALLBACKS|============================================================|*/

/*|============================================================|COMMANDS|=============================================================|*/
CMD:treatwound( playerid ) {
	if( !Bit_Get( PlayerBrokeLeg, playerid ) ) return ( true );
	SendClientMessage( playerid, 0x757575FF, "** You've successfully treated your broken leg. *" );
	ResetBVars( playerid );
	ApplyAnimation( playerid, "PED", "getup_front", 4.0, 0, 1, 1, 0, 0, 1 );
	if( PlayerHasDialogOpen[ playerid ] ) ShowPlayerDialog( playerid, -1, DIALOG_STYLE_MSGBOX, "", "", "", "" );
	return ( true );
}
/*|============================================================|COMMANDS|=============================================================|*/
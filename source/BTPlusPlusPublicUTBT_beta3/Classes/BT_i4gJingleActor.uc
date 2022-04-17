//=============================================================================
// BT_i4gJingleActor made by OwYeaW
//=============================================================================
class BT_i4gJingleActor expands Actor;
//=============================================================================
#exec audio import name=i4gJingle file=Sounds\Jingle.wav
#exec audio import name=i4gJingleEnlegit file=Sounds\i4gJingleEnlegit.wav

var Sound Jingle;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(3, false);
}

function Timer()
{
	PlayerPawn(Owner).ClientPlaySound(Jingle);
//	PlayerPawn(Owner).ClientPlaySound(Jingle);
//	PlayerPawn(Owner).ClientPlaySound(Jingle);

//	PlayOwnedSound(Jingle, SLOT_Misc);//, 999999999);	Owner.
//	PlayOwnedSound(Jingle, SLOT_Misc);//, 999999999);	Owner.
//	PlayOwnedSound(Jingle, SLOT_Misc);//, 999999999);	Owner.
	Destroy();
}

defaultproperties
{
	Jingle=Sound'i4gJingleEnlegit'
	bHidden=true
}
//=============================================================================
// UTBT_FlagReplacer made by OwYeaW
//
// hacky way to replace every flag with our own flag
// important to make sure gameplay stays 100% the same
//=============================================================================
class UTBT_FlagReplacer extends SpawnNotify;

#exec TEXTURE IMPORT NAME=UTBT_Flag_blue	FILE=Textures\JpflagBUTBT.pcx
#exec TEXTURE IMPORT NAME=UTBT_Flag_red		FILE=Textures\JpflagRUTBT.pcx

event PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(2, false);
}

function Timer()
{
	local FlagBase FB;

	foreach AllActors(class'FlagBase', FB)
		FB.bHidden = false;
}

simulated event Actor SpawnNotification(Actor A)
{
	local CTFFlag newFlag, oldFlag;
	local FlagBase HomeBase;

	if(CTFFlag(A) != None && UTBT_Flag(A) == None)
	{
		oldFlag			= CTFFlag(A);

		newFlag = Spawn(class'UTBT_Flag', oldFlag.Owner, oldFlag.Tag, oldFlag.Location, oldFlag.Rotation);
		newFlag.Team		= oldFlag.Team;
		newFlag.Skin		= oldFlag.Skin;
		newFlag.bHidden		= oldFlag.bHidden;
		newFlag.LightHue	= oldFlag.LightHue;

		if(oldFlag.HomeBase != None)
			HomeBase = oldFlag.HomeBase;
		else
		{
			// not optimal - but works (for public temporarily solution)
			foreach newFlag.RadiusActors(class'FlagBase', HomeBase, 0.1)
			{
				if(oldFlag.IsA('RedFlag'))
				{
					if(HomeBase.Team == 0)
					{
						break;
					}
				}
				else if(HomeBase.Team == 1)
				{
					break;
				}
			}
		}

		if(HomeBase != None)
		{
			HomeBase.GoToState('');
			oldFlag.HomeBase	= HomeBase;
			newFlag.HomeBase	= HomeBase;
			newFlag.Team		= HomeBase.Team;
		}

		// replace flag skins with UTBT skins
		// only when map uses default flag skins, custom skins wont be overwitten :)
		if(newFlag.Skin == Texture'Botpack.Skins.JpflagB')
		{
			newFlag.Skin = Texture'UTBT_Flag_blue';
			if(newFlag.HomeBase != None)
				newFlag.HomeBase.Skin = Texture'UTBT_Flag_blue';
		}
		else if(newFlag.Skin == Texture'Botpack.Skins.JpflagR')
		{
			newFlag.Skin = Texture'UTBT_Flag_red';
			if(newFlag.HomeBase != None)
				newFlag.HomeBase.Skin = Texture'UTBT_Flag_red';
		}

		CTFReplicationInfo(Level.Game.GameReplicationInfo).FlagList[newFlag.Team] = newFlag;
		oldFlag.LifeSpan = 0.1;
		//oldFlag.Destroy();
		//HomeBase.bHidden = false;
	}

	return A;
}
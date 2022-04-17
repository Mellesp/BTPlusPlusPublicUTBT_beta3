//=============================================================================
// BT_FlagMeshActor made by OwYeaW
//=============================================================================
class BT_FlagMeshActor extends Info;

defaultproperties
{
	Mesh=LodMesh'Botpack.newflag'
	bHidden=False
	bOnlyOwnerSee=True
	bAlwaysTick=True
	Physics=PHYS_Rotating
	RemoteRole=ROLE_None
	DrawType=DT_Mesh
	DrawScale=0.05
	AmbientGlow=255
	bUnlit=True
	CollisionRadius=0.000000
	CollisionHeight=0.000000
}
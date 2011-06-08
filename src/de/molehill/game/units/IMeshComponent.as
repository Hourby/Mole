package de.molehill.game.units
{
	public interface IMeshComponent
	{
		function get meshName (): String;
		function set meshName (value:String): void;
						
		function addMesh (mesh:IMeshComponent): void;
		
		function removeMesh (mesh:IMeshComponent): void;
		
		function getMeshByName (name:String): IMeshComponent;
		
		function onMoveForward():void;
		
		function onMoveBackward():void;
		
		function onTargetOnEnemy():void;
		
		function onFire():void;
	}
}
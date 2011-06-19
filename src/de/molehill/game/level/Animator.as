package de.molehill.game.level
{
	import away3d.animators.PathAnimator;
	import away3d.core.base.Object3D;
	import away3d.extrusions.PathExtrude;
	import away3d.extrusions.utils.Path;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class Animator extends EventDispatcher
	{
		private var _path : Path;
		private var _animTime:Number = 0;
		private var _pathExtrude:PathExtrude;
		private var _pathAnimator:PathAnimator;
		
		
		public function Animator()
		{
		}
		
		public function initAnimation(view:Object3D, wayPoints : Vector.<Point>) : void {
			var pathData : Vector.<Vector3D> = new Vector.<Vector3D>();
			for (var i : uint = 0; i < wayPoints.length - 1; i++) {
				pathData.push(new Vector3D(wayPoints[i].x * 500, 0, wayPoints[i].y * 500));
				pathData.push(new Vector3D((wayPoints[i + 1].x + wayPoints[i].x) * 250, 0, (wayPoints[i + 1].y + wayPoints[i].y) * 250));
				pathData.push(new Vector3D(wayPoints[i + 1].x * 500, 0, wayPoints[i + 1].y * 500));
			}
			_path = new Path(pathData);
			_pathAnimator = new PathAnimator(_path, view, null, true, null, null);
		}
		
		public function animatePath() : void {
			if (_pathAnimator) {
				_animTime += (0.02 / _path.length);
				_pathAnimator.updateProgress(_animTime);
				if (_animTime > 1) {
					var lastRotation:uint = uint (_pathAnimator.target.rotationY);
					_animTime = 1;
					_pathAnimator.updateProgress(_animTime);
					_pathAnimator.target.rotationY;
					_pathAnimator = null;
					_animTime = 0;
					dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATION_COMPLETE,lastRotation));
				}
			}
		}
	}
}
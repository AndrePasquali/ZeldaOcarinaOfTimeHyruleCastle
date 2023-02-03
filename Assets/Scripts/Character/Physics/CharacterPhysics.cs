using System;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character.Physics
{
    public class CharacterPhysics: MonoBehaviour
    {
        public float RayCastDistance = 3.0F;
        public enum RayDirection
        {
            Up,
            Left,
            Right,
            Down
        }

        public bool IsCollidingLeft => RayToDirection(RayDirection.Left);
        public bool IsCollidingRight => RayToDirection(RayDirection.Right);
        public bool IsCollidingTop => RayToDirection(RayDirection.Up);
        public bool IsCollidingDown => RayToDirection(RayDirection.Down);
        
        [SerializeField] private float _groundCheckDistance = 0.1f;
        [SerializeField] private LayerMask _groundLayerMask;
        [SerializeField] private bool _isGrounded;

        private void FixedUpdate()
        {
            if (IsCollidingDown) Debug.Log("Colliding Down");
            if (IsCollidingLeft) Debug.Log("Colliding Left");
            if (IsCollidingRight) Debug.Log("Colliding Right");
            if (IsCollidingTop) Debug.Log("Colliding Top");
            
            if(IsGrounded()) Debug.Log("Is Grounded");
        }

        public bool RayToDirection(RayDirection targetDirection)
        {
            switch (targetDirection)
            {
                case RayDirection.Up:
                {
                    var origin = transform.position;
                    var target = transform.TransformDirection(transform.up);
                    var rayCastHit = UnityEngine.Physics.Raycast(origin, target, RayCastDistance);
                    Debug.DrawRay(origin, target, Color.cyan);
                    return rayCastHit;
                }
                case RayDirection.Left:
                {
                    var origin = transform.up * 2.0F;
                    var target = transform.TransformDirection(-transform.right);
                    var rayCastHit = UnityEngine.Physics.Raycast(origin, target, RayCastDistance);
                    Debug.DrawRay(origin, target, Color.magenta);
                    return rayCastHit;
                }
                case RayDirection.Right:
                {
                    var origin = transform.position;
                    var target = transform.TransformDirection(transform.right);
                    var rayCastHit = UnityEngine.Physics.Raycast(origin, target, RayCastDistance);
                    Debug.DrawRay(origin, target, Color.yellow);
                    return rayCastHit;
                }
                case RayDirection.Down:
                {
                    var origin = transform.position;
                    var target = transform.TransformDirection(-transform.up);
                    var rayCastHit = UnityEngine.Physics.Raycast(origin, target, RayCastDistance);
                    Debug.DrawRay(origin, target, Color.green);
                    return rayCastHit;
                }
                default: return false;
            }
        }

        public bool IsGrounded()
        {
            var isGrounded = UnityEngine.Physics.Raycast(transform.position, -Vector3.up, _groundCheckDistance, _groundLayerMask);

            _isGrounded = isGrounded;
            
            return isGrounded;
        }
    }
}
using System;
using JetBrains.Annotations;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character.Physics
{
    public class CharacterPhysics: MonoBehaviour
    {
        public float RayCastDistance = 3.0F;
        public float RayCastOffset = 0.5F;
        public enum RayDirection
        {
            Up,
            Left,
            Right,
            Back,
            Front
        }

        public bool IsCollidingLeft => RayToDirection(RayDirection.Left);
        public bool IsCollidingRight => RayToDirection(RayDirection.Right);
        public bool IsCollidingTop => RayToDirection(RayDirection.Up);
        public bool IsCollidingBack => RayToDirection(RayDirection.Back);
        public bool IsCollidingFront => RayToDirection(RayDirection.Front);


        private RaycastHit _currentHit;

        public CharacterStateMachine CharacterState =>
            _characterState ?? (_characterState = ServiceLocator.Get<CharacterStateMachine>());
        private CharacterStateMachine _characterState;
        
        public CharacterMovement CharacterMovement =>
            _characterMovement ?? (_characterMovement = ServiceLocator.Get<CharacterMovement>());
        private CharacterMovement _characterMovement;
        
        public InputController InputController =>
            _inputController ?? (_inputController = ServiceLocator.Get<InputController>());
        private InputController _inputController;

        public Rigidbody Rigidbody => _rigidbody ?? (_rigidbody = GetComponent<Rigidbody>());
        private Rigidbody _rigidbody;

        [SerializeField] private float _groundCheckDistance = 0.1f;
        [SerializeField] private LayerMask _groundLayerMask;
        [SerializeField] private bool _isGrounded;

        [CanBeNull]
        public GameObject GetGameObjectByTag(string tag)
        {
            if(_currentHit.collider != null)
                if (_currentHit.transform.gameObject.tag.Equals(tag))
                    return _currentHit.transform.gameObject;

            return null;
        }

        public bool RayToDirection(RayDirection targetDirection, float rayDistance = 3.0F)
        {
            switch (targetDirection)
            {
                case RayDirection.Up:
                {
                    var origin = transform.position;
                    var target = transform.up;
                    var rayCastHit = UnityEngine.Physics.Raycast(hitInfo: out _currentHit, origin: origin, direction: target, maxDistance: rayDistance);
                    Debug.DrawRay(origin, target, Color.cyan);
                    return rayCastHit;
                }
                case RayDirection.Left:
                {
                    var origin = transform.position + (transform.up * RayCastOffset);
                    var target = -transform.right;
                    var rayCastHit = UnityEngine.Physics.Raycast(hitInfo: out _currentHit, origin: origin, direction: target, maxDistance: rayDistance);
                    Debug.DrawRay(origin, target, Color.blue);
                    return rayCastHit;
                }
                case RayDirection.Right:
                {
                    var origin = transform.position + (transform.up * RayCastOffset);
                    var target = transform.right;
                    var rayCastHit = UnityEngine.Physics.Raycast(hitInfo: out _currentHit, origin: origin, direction: target, maxDistance: rayDistance);
                    Debug.DrawRay(origin, target, Color.yellow);
                    return rayCastHit;
                }
                case RayDirection.Back:
                {
                    var origin = transform.position + (transform.up * RayCastOffset);
                    var target = -transform.forward;
                    var rayCastHit = UnityEngine.Physics.Raycast(hitInfo: out _currentHit, origin: origin, direction: target, maxDistance: rayDistance);
                    Debug.DrawRay(origin, target, Color.green);
                    return rayCastHit;
                }
                case RayDirection.Front:
                {
                    var origin = transform.position + (transform.up * RayCastOffset);
                    var target = transform.forward;
                    var rayCastHit = UnityEngine.Physics.Raycast(hitInfo: out _currentHit, origin: origin, direction: target, maxDistance: rayDistance);
                    Debug.DrawRay(origin, target, Color.magenta);
                    return rayCastHit;
                }
                default: return false;
            }
        }

        public RaycastHit GetHit() => _currentHit;

        public bool IsGrounded()
        {
            var isGrounded = UnityEngine.Physics.Raycast(transform.position, -Vector3.up, _groundCheckDistance);

            _isGrounded = isGrounded;
            
            return isGrounded;
        }

        public Vector3 GetVelocity() => Rigidbody.velocity;
    }
}
using System;
using System.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Game;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class Box : MonoBehaviour, IPushable
    {
        [SerializeField] private Rigidbody _rigibody;
        [SerializeField] private FixedJoint _joint;

        [SerializeField] private int _id;

        private void Start() => Initialize();

        private void Initialize()
        {
            return;
            var box1Position = GameRuntimeStateHolder.GetBoxPositionState().Box1PositionState;
            var box2Position = GameRuntimeStateHolder.GetBoxPositionState().Box2PositionState;

            if (_id == 1 && box1Position != null) transform.position = box1Position;

            if (_id == 2 && box2Position != null) transform.position = box2Position;
        }




        public FixedJoint GetJoint()
        {
            if (_joint != null)
                return _joint;

            _joint = gameObject.AddComponent<FixedJoint>();

            return _joint;
        }

        private void OnCollisionEnter(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                if (_joint == null)
                    _joint = gameObject.AddComponent<FixedJoint>();

            }
        }

        private void OnTriggerStay(Collider other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                var currentMovementState = GameRuntimeStateHolder.GetCurrentMovementState();

                if (currentMovementState != Character.StateMachine.CharacterMovement.Pushing && _joint != null)
                    Destroy(_joint);

            }

        }

        private async void OnCollisionExit(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                var distanceToPlayer = Vector3.Distance(transform.position, other.transform.position);

                if (distanceToPlayer < 2.5F) return;

                if (_joint != null) Destroy(_joint);
            }
        }

    }
}
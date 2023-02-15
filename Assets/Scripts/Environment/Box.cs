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

        public int Id;

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

        private void OnCollisionExit(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                var distanceToPlayer = Vector3.Distance(transform.position, other.transform.position);

                if (distanceToPlayer < 2.5F) return;

                if (_joint != null) Destroy(_joint);
            }
        }

        public void DisablePhysics()
        {
            _rigibody.isKinematic = true;
            _rigibody.angularVelocity = Vector3.zero;
            _rigibody.velocity = Vector3.zero;

            if (_joint != null) Destroy(_joint);

        }

    }
}
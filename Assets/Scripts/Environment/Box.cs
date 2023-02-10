using System;
using System.Threading.Tasks;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class Box: MonoBehaviour, IPushable
    {
        [SerializeField] private Rigidbody _rigibody;
        [SerializeField] private FixedJoint _joint;

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

        private async void OnCollisionExit(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                if(_joint != null) Destroy(_joint);
            }
        }
    }
}
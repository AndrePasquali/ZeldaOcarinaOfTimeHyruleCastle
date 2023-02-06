using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class Box: MonoBehaviour, IPushable
    {
        [SerializeField] private Rigidbody _rigibody;

        private void OnCollisionEnter(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                _rigibody.isKinematic = false;
            }
        }

        private void OnCollisionExit(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                _rigibody.isKinematic = true;
            }
        }
    }
}
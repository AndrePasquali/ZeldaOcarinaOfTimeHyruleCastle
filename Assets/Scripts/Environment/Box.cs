using System;
using System.Threading.Tasks;
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

        private async void OnCollisionExit(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                await Task.Delay(TimeSpan.FromSeconds(2));
                _rigibody.isKinematic = true;
            }
        }
    }
}
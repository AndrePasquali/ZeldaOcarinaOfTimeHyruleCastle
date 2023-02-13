using System;
using UnityEngine;
using MainLeaf.OcarinaOfTime.Enrironment;
using Cysharp.Threading.Tasks;


namespace MainLeaf.Environment
{
    public class ObjectiveHelper : MonoBehaviour
    {
        public void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.name == "Box")
            {
                var rigidbody = other.gameObject.GetComponent<Rigidbody>();

                rigidbody.freezeRotation = false;
                rigidbody.constraints = RigidbodyConstraints.None;

            }
        }

        private async void ApplyForce()
        {
            await UniTask.Delay(1000);

            GetComponent<Rigidbody>().AddForce(transform.forward * 0.7F, ForceMode.VelocityChange);

        }
    }
}


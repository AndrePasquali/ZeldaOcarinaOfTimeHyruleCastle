using System;
using UnityEngine;
using MainLeaf.OcarinaOfTime.Enrironment;
using Cysharp.Threading.Tasks;


namespace MainLeaf.Environment
{
    public class ObjectiveHelper : MonoBehaviour
    {
        private bool _completed;
        public void OnTriggerStay(Collider other)
        {
            if (other.gameObject.name == "Box" && !_completed)
            {
                var rigidbody = other.gameObject.GetComponent<Rigidbody>();

                rigidbody.freezeRotation = false;
                rigidbody.constraints = RigidbodyConstraints.None;

                _completed = true;

            }

            CheckFixedJoint(other);


        }

        public void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.name == "Box" && !_completed)
            {
                var rigidbody = other.gameObject.GetComponent<Rigidbody>();

                rigidbody.freezeRotation = false;
                rigidbody.constraints = RigidbodyConstraints.None;

                if (other.gameObject.GetComponent<FixedJoint>() != null)
                {
                    var fixedJoint = other.gameObject.GetComponent<FixedJoint>();
                    Destroy(fixedJoint);
                }

                _completed = true;

            }
        }

        public void OnTriggerExit(Collider other)
        {
            if (other.gameObject.name == "Box" && !_completed)
            {
                var rigidbody = other.gameObject.GetComponent<Rigidbody>();

                rigidbody.freezeRotation = false;
                rigidbody.constraints = RigidbodyConstraints.None;

                if (other.gameObject.GetComponent<FixedJoint>() != null)
                {
                    var fixedJoint = other.gameObject.GetComponent<FixedJoint>();
                    Destroy(fixedJoint);
                }

                _completed = true;

            }
        }

        private void CheckFixedJoint(Collider other)
        {
            if (other.gameObject.name == "Box")
                if (other.gameObject.GetComponent<FixedJoint>() != null)
                {
                    var fixedJoint = other.gameObject.GetComponent<FixedJoint>();
                    Destroy(fixedJoint);
                }
        }


        private async void ApplyForce()
        {
            await UniTask.Delay(1000);

            GetComponent<Rigidbody>().AddForce(transform.forward * 0.8F, ForceMode.VelocityChange);

        }
    }
}


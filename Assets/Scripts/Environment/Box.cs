using System;
using MainLeaf.OcarinaOfTime.Player;
using UnityEngine;
using UnityEngine.EventSystems;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class Box: MonoBehaviour, IPushable
    {
        [SerializeField] private Rigidbody _rigibody;
        [SerializeField] private float _forceMultiplier = 2F;
        private bool _drag;

        private void FixedUpdate() => EveryFrame();
        
        private void EveryFrame()
        {
            if (Input.GetMouseButtonDown(0)) _drag = true;
            if (Input.GetMouseButtonUp(0)) _drag = false;
        }

        private void OnCollisionStay(Collision other)
        {
            if(other.gameObject.tag.Equals("Player")) Push(other.gameObject, _rigibody);
        }

        private void OnCollisionExit(Collision other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                var player = other.gameObject.GetComponent<PlayerController>();
                player.SetAnimator("Push", false);
            }
        }

        public void Push(GameObject player, Rigidbody pushableObject)
        {
            if (_drag)
            {
                Debug.Log($"Push {gameObject.name}");
                pushableObject.isKinematic = false;
                pushableObject.AddForce(gameObject.transform.forward * _forceMultiplier, ForceMode.Force);
                player.GetComponent<PlayerController>().SetAnimator("Push", true);
            }
            else
            {
                pushableObject.isKinematic = true;
                player.GetComponent<PlayerController>().SetAnimator("Push", false);
            }
        }
    }
}
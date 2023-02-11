using System;
using Cinemachine;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class MultiCamera: MonoBehaviour
    {
        [SerializeField] private CinemachineVirtualCamera _camera;
        public string Id => gameObject.name;

        public enum Direction
        {
            FRONT,
            BACK
        }

        public Direction CurrentDirection = Direction.FRONT;

        private void ChangeCamera()
        {
            MultiCameraController.OnCameraChange.Invoke(this);
        }

        public void ChangePriority(int newPriority) => _camera.Priority = newPriority;

        private void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag.Equals("Player"))
            {
                var position = transform.position;
                var otherPosition = other.transform.position;

                if (otherPosition.x > position.x) CurrentDirection = Direction.BACK;
                if (otherPosition.x < position.x) CurrentDirection = Direction.FRONT;
                
                ChangeCamera();
            }
        }
    }
}
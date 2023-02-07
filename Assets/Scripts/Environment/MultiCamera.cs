using System;
using Cinemachine;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class MultiCamera: MonoBehaviour
    {
        [SerializeField] private CinemachineVirtualCamera _nextCamera;
        [SerializeField] private CinemachineVirtualCamera _prevCamera;

        private void ChangeCamera()
        {
            var previousCameraInactive = _nextCamera.Priority > _prevCamera.Priority;

            if (previousCameraInactive)
            {
                _nextCamera.Priority = _prevCamera.Priority - 1;
                return;
            }

            _nextCamera.Priority = _prevCamera.Priority + 1;
        }

        private void OnTriggerEnter(Collider other)
        {
            if(other.gameObject.tag.Equals("Player"))
                ChangeCamera();
        }
    }
}
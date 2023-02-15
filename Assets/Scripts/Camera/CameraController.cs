using System;
using Cinemachine;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Camera
{
    public class CameraController : MonoBehaviour
    {
        [SerializeField] private CinemachineFreeLook _freeLookCamera;
        [SerializeField] private CinemachineVirtualCamera _thirdPersonCamera;

        private void Start()
        {
            ServiceLocator.Register(this);
        }

        public enum CameraMode
        {
            ThirdPerson,
            FreeLook
        }

        public CameraMode CurrentMode = CameraMode.FreeLook;

        public void ChangeMode(CameraMode newCameraMode)
        {
            if (CurrentMode == newCameraMode) return;

            switch (newCameraMode)
            {
                case CameraMode.FreeLook:
                    {
                        CurrentMode = newCameraMode;
                        _freeLookCamera.Priority = _thirdPersonCamera.Priority + 1;
                        break;
                    }
                case CameraMode.ThirdPerson:
                    {
                        CurrentMode = newCameraMode;
                        _thirdPersonCamera.Priority = _freeLookCamera.Priority + 1;
                        break;
                    }
            }
        }


    }
}
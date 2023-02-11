using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class MultiCameraController: MonoBehaviour
    {
        [SerializeField] private List<MultiCamera> _cameraList;

        public static Action<MultiCamera> OnCameraChange;
        private void Start() => OnCameraChange += ChangeActiveCamera;

        public void ChangeActiveCamera(MultiCamera camera)
        {
            var targetIndex = 0;

            for (var i = 0; i < _cameraList.Count; i++)
            {
                if (_cameraList[i].Id == camera.Id)
                    targetIndex = camera.CurrentDirection == MultiCamera.Direction.FRONT ? i + 1 : i;
            }

            var validatedIndex = targetIndex < _cameraList.Count - 1
                ? targetIndex
                : _cameraList.Count - 1;

            validatedIndex = targetIndex < 0 ? 0 : targetIndex;
            
            _cameraList.ElementAt(validatedIndex).ChangePriority(100);

            var currentActiveCameraId = _cameraList.ElementAt(validatedIndex).Id;
            
            _cameraList.ForEach(e =>
            {
                if(e.Id != currentActiveCameraId)
                    e.ChangePriority(0);
            });
            
        }
    }
}
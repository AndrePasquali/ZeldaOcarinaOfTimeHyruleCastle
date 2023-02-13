using System;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment.Item
{
    public class ItemRotate: MonoBehaviour
    {
        public Vector3 RotationSpeed = new Vector3(0, 45, 0);

        private bool _enabled = true;

        private void Start() => Rotate();

        private async void Rotate()
        {
            while (_enabled)
            {
                transform.Rotate(RotationSpeed * Time.deltaTime);
                
                await UniTask.WaitForEndOfFrame();
            }
        }

        private void OnDestroy() => _enabled = false;
    }
}
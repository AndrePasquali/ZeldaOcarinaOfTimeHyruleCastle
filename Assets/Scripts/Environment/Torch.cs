using Cysharp.Threading.Tasks;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class Torch: MonoBehaviour
    {
        [SerializeField] private float _flickerSpeed = 0.05f;
        [SerializeField] private float _intensityMin = 0.25f;
        [SerializeField] private float _intensityMax = 0.5f;

        public Light TorchLight => _torchLight ?? (_torchLight = GetComponent<Light>());
        private Light _torchLight;

        void Start() => ProcessTorchEffect();

        private async void ProcessTorchEffect()
        {
            while (true)
            {
                var randomValue = Random.Range(0f, 1f);
                var randomIntensity = Random.Range(_intensityMin, _intensityMax);

                if (randomValue <= _flickerSpeed) TorchLight.intensity = randomIntensity;

                await UniTask.WaitForEndOfFrame();
            }
        }
    }
}
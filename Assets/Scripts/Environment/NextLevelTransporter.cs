using System;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    [RequireComponent(typeof(BoxCollider))]
    public class NextLevelTransporter: MonoBehaviour
    {
        [SerializeField] private int _nextLevelIndex = 2;

        public async void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag.Equals("Player")) 
                await SceneManager.LoadSceneAsync(_nextLevelIndex);
        }
    }
}
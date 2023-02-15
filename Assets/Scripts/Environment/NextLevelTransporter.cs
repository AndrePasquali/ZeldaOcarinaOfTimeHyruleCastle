using System;
using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Game;
using MainLeaf.OcarinaOfTime.Scenes;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    [RequireComponent(typeof(BoxCollider))]
    public class NextLevelTransporter : MonoBehaviour
    {
        public async void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag.Equals("Player"))
                await SceneManager.LoadSceneAsync(0);
        }
    }
}
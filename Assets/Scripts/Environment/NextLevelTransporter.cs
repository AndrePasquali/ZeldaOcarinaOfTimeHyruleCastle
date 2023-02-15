using System.Threading.Tasks;
using System;
using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Game.Level;
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
            {
                LevelController.OnLevelEnded.Invoke((SceneName)SceneManager.GetActiveScene().buildIndex, EndGameReason.Completed);

                await SceneManager.LoadSceneAsync(0);
            }
        }
    }
}
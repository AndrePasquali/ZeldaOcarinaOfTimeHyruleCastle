
using MainLeaf.OcarinaOfTime.Game;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace MainLeaf.OcarinaOfTime.Scenes
{

    public class SceneStateController : MonoBehaviour
    {
        private void Start() => UpdateSceneState();

        private void UpdateSceneState()
        {
            int currentScene = SceneManager.GetActiveScene().buildIndex;

            GameRuntimeStateHolder.SaveScene((SceneName)currentScene);

            Time.timeScale = 1;
        }
    }


}
using System;
using MainLeaf.OcarinaOfTime.Game;
using MainLeaf.OcarinaOfTime.Scenes;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace MainLeaf.OcarinaOfTime.Scenes
{

    public class Loading : MonoBehaviour
    {
        private void Start() => LoadNextScene();

        private void LoadNextScene()
        {
            var targetScene = GetNextLevel();
            SceneManager.LoadScene((int)targetScene);
        }

        public SceneName GetNextLevel()
        {
            var currentLevel = GameRuntimeStateHolder.GetCurrentLevel();
            var currentLevelCompleted = GameRuntimeStateHolder.IsLevelCompleted(currentLevel);

            Debug.Log("CURRENT LEVEL: " + currentLevel);
            switch (currentLevel)
            {
                case SceneName.COURTYARD_CASTLE: return SceneName.MAIN;
                case SceneName.LOADING: return SceneName.MAIN;
                case SceneName.HYRULE_CASTLE:
                    {

                        return SceneName.COURTYARD;
                    }
                case SceneName.COURTYARD:
                    {
                        if (!GameRuntimeStateHolder.IsLevelCompleted(SceneName.COURTYARD))
                            return SceneName.HYRULE_CASTLE;


                        return SceneName.COURTYARD_CASTLE;
                    }

                case SceneName.MAIN:
                    {
                        return SceneName.HYRULE_CASTLE;
                    }
                default:
                    {
                        return SceneName.MAIN;
                    }
            }
        }
    }
}
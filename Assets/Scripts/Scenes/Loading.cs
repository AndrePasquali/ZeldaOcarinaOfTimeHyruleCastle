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
            var targetScene = GetNextScene();
            SceneManager.LoadScene((int)targetScene);
        }

        public SceneName GetNextScene()
        {
            var currentScene = GameRuntimeStateHolder.GetCurrentScene();
            var currentGameState = GameRuntimeStateHolder.GetGameState();
            switch (currentScene)
            {
                case SceneName.COURTYARD_CASTLE: return SceneName.MAIN;
                case SceneName.LOADING: return SceneName.MAIN;
                case SceneName.HYRULE_CASTLE:
                    {

                        GameRuntimeStateHolder.ChangeGameState(GameRuntimeStateHolder.GameState.GAMEPLAY);
                        GameRuntimeStateHolder.SaveScene(SceneName.COURTYARD);
                        return SceneName.COURTYARD;
                    }
                case SceneName.COURTYARD:
                    {
                        if (currentGameState == GameRuntimeStateHolder.GameState.GAMEOVER)
                        {

                            GameRuntimeStateHolder.ChangeGameState(GameRuntimeStateHolder.GameState.COMPLETED);
                            GameRuntimeStateHolder.SaveScene(SceneName.HYRULE_CASTLE);
                            return SceneName.HYRULE_CASTLE;
                        }

                        GameRuntimeStateHolder.ChangeGameState(GameRuntimeStateHolder.GameState.GAMEPLAY);
                        GameRuntimeStateHolder.SaveScene(SceneName.COURTYARD_CASTLE);
                        return SceneName.COURTYARD_CASTLE;
                    }

                case SceneName.MAIN:
                    {
                        GameRuntimeStateHolder.ChangeGameState(GameRuntimeStateHolder.GameState.GAMEPLAY);
                        GameRuntimeStateHolder.SaveScene(SceneName.HYRULE_CASTLE);
                        return SceneName.HYRULE_CASTLE;
                    }
                default:
                    {
                        GameRuntimeStateHolder.SaveScene(SceneName.MAIN);
                        return SceneName.MAIN;
                    }
            }
        }
    }
}
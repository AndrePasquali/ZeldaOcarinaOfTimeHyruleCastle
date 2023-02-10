using MainLeaf.OcarinaOfTime.Game;
using MainLeaf.OcarinaOfTime.Scenes;
using UnityEngine;
using UnityEngine.SceneManagement;

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
            case SceneName.LOADING: return SceneName.MAIN;
            case SceneName.HYRULE_CASTLE: return SceneName.COURTYARD;
            case SceneName.COURTYARD:
                if (currentGameState == GameRuntimeStateHolder.GameState.GAMEOVER)
                    return SceneName.HYRULE_CASTLE;
                return SceneName.MAIN;
            case SceneName.MAIN: return SceneName.HYRULE_CASTLE;
            default: return SceneName.MAIN;
        }
    }
}

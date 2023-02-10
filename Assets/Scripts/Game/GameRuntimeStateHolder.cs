using MainLeaf.OcarinaOfTime.Scenes;

namespace MainLeaf.OcarinaOfTime.Game
{
    public static class GameRuntimeStateHolder
    {
        public enum GameState
        {
            DEFAULT,
            GAMEPLAY,
            GAMEOVER
        }

        private static GameState _currentGameState;
        
        private static SceneName _currentScene =  SceneName.LOADING;
        public static void SaveScene(SceneName newScene) => _currentScene = newScene;
        public static SceneName GetCurrentScene() => _currentScene;

        public static void ChangeGameState(GameState newState) => _currentGameState = newState;

        public static SceneName GetNextScene()
        {
            switch (_currentScene)
            {
                case SceneName.LOADING: return SceneName.MAIN;
                case SceneName.HYRULE_CASTLE: return SceneName.COURTYARD;
                case SceneName.COURTYARD:
                    if (_currentGameState == GameState.GAMEOVER)
                    {
                        ChangeGameState(GameState.GAMEOVER);
                        return SceneName.HYRULE_CASTLE;
                    }
                    return SceneName.MAIN;
                case SceneName.MAIN: return SceneName.HYRULE_CASTLE;
                default: return SceneName.MAIN;
            }
        }

        public static GameState GetGameState() => _currentGameState;
    }
}
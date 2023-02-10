using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Game;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace MainLeaf.OcarinaOfTime.Scenes
{
    public class SceneSwitcher : MonoBehaviour
    {
        [SerializeField] private Button _button;
        private void Start() => _button.onClick.AddListener(LoadScene);

        private async void LoadScene()
        {
            SaveGameState();
            
            await SceneManager.LoadSceneAsync(0);
        }

        private void SaveGameState()
        {
            GameRuntimeStateHolder.SaveScene(SceneName.MAIN);
            GameRuntimeStateHolder.ChangeGameState(GameRuntimeStateHolder.GameState.DEFAULT);
        }
    }
}

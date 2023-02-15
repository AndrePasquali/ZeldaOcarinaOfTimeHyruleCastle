using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Game;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace Mainleaf.OcarinaOfTime.UI
{
    public sealed class PauseMenuController : MonoBehaviour
    {
        [SerializeField]
        private Button _resumeButton;
        [SerializeField] private Button _restartButton;
        [SerializeField] private Button _quitButton;

        private void Start()
        {
            _resumeButton.onClick.AddListener(OnResumeButton);
            _restartButton.onClick.AddListener(OnRestartButton);
            _quitButton.onClick.AddListener(OnQuitButton);
        }

        private void OnResumeButton()
        {
            UIController.OnUIScreenChanged.Invoke(UIController.UIScreen.DEFAULT);

        }

        private async void OnRestartButton()
        {
            await SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().buildIndex);
        }

        private async void OnQuitButton()
        {
            GameRuntimeStateHolder.OnGameQuit();
            await SceneManager.LoadSceneAsync(0);

        }

        private void OnDestroy()
        {
            _resumeButton.onClick.RemoveAllListeners();
            _restartButton.onClick.RemoveAllListeners();
            _quitButton.onClick.RemoveAllListeners();

        }

    }
}
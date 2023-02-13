using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Audio;
using MainLeaf.OcarinaOfTime.Game;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using TMPro;
using DG.Tweening;

namespace MainLeaf.OcarinaOfTime.Scenes
{
    public class SceneSwitcher : MonoBehaviour, ISound
    {
        [SerializeField] private Button _button;
        [SerializeField] private AudioSource _audioSource;
        [SerializeField] private AudioClip _audioClip;

        private void Start() => Initialized();

        private void Initialized()
        {
            _button.onClick.AddListener(LoadScene);

            StartAnimation();
        }

        private void StartAnimation()
        {
            var text = _button.transform.GetChild(0).GetComponent<TMP_Text>();

            text.DOFade(0, 1.5F).OnComplete(() =>
            {
                text.DOFade(1, 1.5F);
            }).SetLoops(-1).SetEase(Ease.InOutCirc);
        }

        private async void LoadScene()
        {
            SaveGameState();

            PlaySoundFX();

            await UniTask.Delay(800);

            await SceneManager.LoadSceneAsync(0);
        }

        private void Update()
        {
            if (UnityEngine.Input.GetKeyDown(KeyCode.Return)) LoadScene();
        }

        private void SaveGameState()
        {
            GameRuntimeStateHolder.SaveScene(SceneName.MAIN);
            GameRuntimeStateHolder.ChangeGameState(GameRuntimeStateHolder.GameState.DEFAULT);
        }

        public void PlaySoundFX()
        {
            _audioSource.PlayOneShot(_audioClip);
        }
    }
}

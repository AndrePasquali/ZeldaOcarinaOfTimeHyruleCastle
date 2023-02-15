using System.Collections;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using MainLeaf.OcarinaOfTime.Game;
using MainLeaf.OcarinaOfTime.Game.Level;
using MainLeaf.OcarinaOfTime.Scenes;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace MainLeaf.OcarinaOfTime.Enrironment
{
    public class EventTrigger : MonoBehaviour
    {
        public AudioClip _soundClip;

        public AudioSource _audioSource;

        [SerializeField]
        public Transform Popup;

        public Button ContinueButton;
        public UnityEvent Event;

        private bool _triggered;

        private void Update()
        {
            if (UnityEngine.Input.GetKeyDown(KeyCode.Return) && _triggered) OnContinue();
        }

        private void Start()
        {

            ContinueButton.onClick.AddListener(OnContinue);
        }

        public void OnTriggerEnter(Collider other)
        {
            if (other.gameObject.tag == "Player")
            {
                _audioSource.Stop();
                _audioSource.PlayOneShot(_soundClip);

                Popup.gameObject.SetActive(true);

                var text = ContinueButton.transform.GetChild(0).GetComponent<TMP_Text>();

                text.DOFade(0, 1.5F).OnComplete(() =>
                {
                    text.DOFade(1, 1.5F);
                }).SetLoops(-1).SetEase(Ease.InOutCirc);

                Time.timeScale = 0;

                _triggered = true;

            }

        }

        private void SaveGameState()
        {
            LevelController.OnLevelEnded.Invoke(SceneName.COURTYARD_CASTLE, EndGameReason.Completed);
        }

        private async void OnContinue()
        {
            SaveGameState();

            await SceneManager.LoadSceneAsync(0);

        }


    }
}



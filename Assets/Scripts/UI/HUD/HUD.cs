using System.IO;
using System;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Player;
using MainLeaf.OcarinaOfTime.Services;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace MainLeaf.OcarinaOfTime.UI.HUD
{
    public class HUD : MonoBehaviour
    {
        [SerializeField] private TMP_Text _points;
        [SerializeField] private Image _actionImage;
        [SerializeField] private Transform _actionTransform;
        [SerializeField] private Sprite[] _actionSprites;
        [SerializeField] private bool _enabled = true;

        public void Start()
        {
            ServiceLocator.Register(this);

            CharacterStateMachine.OnCharacterMovementStateChange += OnCharacterMovementChange;

            UpdatePoints();

            Time.timeScale = 1;

        }

        private void OnCharacterMovementChange(CharacterMovement newMovementState)
        {
            if (_actionImage == null || _actionImage == null) return;

            try
            {
                if (_actionSprites?.Length - 1 >= (int)newMovementState)
                {
                    _actionImage?.DOFade(1, 0);
                    _actionTransform?.DORotate(new Vector3(90, 0, 0), 0.15F, RotateMode.FastBeyond360).OnComplete(() =>
                    {
                        _actionTransform?.DORotate(new Vector3(0, 0, 0), 0.15F);
                    });
                    _actionImage.sprite = _actionSprites[(int)newMovementState];
                }


                ResetActionImage();


            }
            catch (Exception e)
            {


            }

        }

        private async void ResetActionImage()
        {
            await UniTask.Delay(TimeSpan.FromSeconds(1.5F));

            if (enabled) _actionImage?.DOFade(0, 0);
        }

        public void UpdatePoints() => _points.text = PlayerProgress.GetPoints().ToString();

        private void OnDestroy()
        {
            _enabled = false;
        }

    }
}
using UnityEngine;
using System.Collections.Generic;
using System;
using MainLeaf.OcarinaOfTime.Audio;
using Cysharp.Threading.Tasks;

namespace MainLeaf.OcarinaOfTime.Game.Goal
{
    public class GoalDetection : MonoBehaviour, ISound
    {
        [SerializeField] private GameObject _box1;
        [SerializeField] private GameObject _box2;

        [SerializeField] private AudioClip _soundClip;
        [SerializeField] private AudioSource _AudioSource;

        private bool _completed;
        private bool _failed;

        private readonly float _xAxisGoal = 9.979904F;
        private readonly float _yAxisGoal = -0.999729968F;
        private readonly float _zAxisGoal = 3.410384F;


        private void Update()
        {
            CheckGoal();
        }

        private void CheckGoal()
        {
            if (!IsBoxesStacked() || _completed || _failed) return;

            if (IsBoxesStacked())
            {
                _completed = true;
                PlaySoundFX();
                NotifyGoalCompleted();

            }
            if (CheckIfGoalIsFailure())
            {
                _failed = true;
                NotifyGoalFailed();
            }
        }

        private bool IsBoxesStacked()
        {
            var box1Position = _box1.transform.localPosition;
            var box2Position = _box2.transform.localPosition;

            var validBox1HorizontalPosition = CheckTolerance(box1Position.x, _xAxisGoal, 0.7F);
            var validBox2HorizontalPosition = CheckTolerance(box2Position.x, _xAxisGoal, 0.8F);

            var verticalPositionToCheck = box1Position.y - box2Position.y;

            var validBoxVerticalPosition = CheckTolerance(verticalPositionToCheck, _yAxisGoal, 0.7F);

            var validBox1ZPosition = CheckTolerance(box1Position.z, _zAxisGoal, 0.7F);
            var validBox2ZPosition = CheckTolerance(box2Position.z, _zAxisGoal, 0.7F);

            return validBox1HorizontalPosition && validBox2HorizontalPosition && validBox1ZPosition && validBox2ZPosition && validBoxVerticalPosition;

        }

        private bool CheckIfGoalIsFailure()
        {
            var box1Failure = _box1.transform.localPosition.y < 0;
            var box2Failure = _box2.transform.localPosition.y < 0;

            return box1Failure && box2Failure;
        }



        private bool CheckTolerance(float value, float reference, float tolerance)
        {
            return value >= reference - tolerance && value <= reference + tolerance;
        }

        private void NotifyGoalCompleted()
        {
            SaveBoxState();

            OnObjectiveCompleted();
        }

        private void NotifyGoalFailed()
        {

        }

        private async void OnObjectiveCompleted()
        {
            await UniTask.Delay(1000);

            if (!IsBoxesStacked()) return;

            _box1.GetComponent<Rigidbody>().isKinematic = true;
            _box2.GetComponent<Rigidbody>().isKinematic = true;
        }

        private void SaveBoxState()
        {
            var box1 = new BoxState
            {
                Position = _box1.transform.position,
                Rotation = _box1.transform.rotation
            };
            var box2 = new BoxState
            {
                Position = _box2.transform.position,
                Rotation = _box2.transform.rotation
            };

            GameRuntimeStateHolder.SetBoxPositionState(box1, box2);
        }

        public void PlaySoundFX()
        {
            _AudioSource.PlayOneShot(_soundClip);
        }
    }
}
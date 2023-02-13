using UnityEngine;
using System.Collections.Generic;
using System;
using MainLeaf.OcarinaOfTime.Audio;

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
        private readonly List<IGoalObserver> _observers = new List<IGoalObserver>();

        public void AddObserver(IGoalObserver observer)
        {
            _observers.Add(observer);
        }

        public void RemoveObserver(IGoalObserver observer)
        {
            _observers.Remove(observer);
        }

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

            var validBox1HorizontalPosition = IsWithinTolerance(box1Position.x, _xAxisGoal, 0.5F);
            var validBox2HorizontalPosition = IsWithinTolerance(box2Position.x, _xAxisGoal, 0.5F);

            var verticalPositionToCheck = box1Position.y - box2Position.y;

            var validBoxVerticalPosition = IsWithinTolerance(verticalPositionToCheck, _yAxisGoal, 0.5F);

            var validBox1ZPosition = IsWithinTolerance(box1Position.z, _zAxisGoal, 0.5F);
            var validBox2ZPosition = IsWithinTolerance(box2Position.z, _zAxisGoal, 0.5F);

            return validBox1HorizontalPosition && validBox2HorizontalPosition && validBox1ZPosition && validBox2ZPosition && validBoxVerticalPosition;

        }

        private bool CheckIfGoalIsFailure()
        {
            var box1Failure = _box1.transform.localPosition.y < 0;
            var box2Failure = _box2.transform.localPosition.y < 0;

            return box1Failure && box2Failure;
        }



        private bool IsWithinTolerance(float value, float reference, float tolerance)
        {
            return value >= reference - tolerance && value <= reference + tolerance;
        }

        private void NotifyGoalCompleted()
        {
            Debug.Log("Objetivo concluído!");

            foreach (var observer in _observers) observer.OnGoalCompleted();
        }

        private void NotifyGoalFailed()
        {
            Debug.Log("Objetivo Falhou");

        }

        private void OnObjectiveCompleted()
        {
            _box1.GetComponent<Rigidbody>().isKinematic = true;
            _box2.GetComponent<Rigidbody>().isKinematic = true;
        }

        public void PlaySoundFX()
        {
            _AudioSource.PlayOneShot(_soundClip);
        }
    }

}
using UnityEngine;
using System.Collections.Generic;
using System;
namespace MainLeaf.OcarinaOfTime.Game.Goal
{
    public class GoalDetection : MonoBehaviour
    {
        [SerializeField] private GameObject _box1;
        [SerializeField] private GameObject _box2;
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
            if (!IsBoxesStacked()) return;

            NotifyGoalCompleted();
        }

        private bool IsBoxesStacked()
        {
            if (_box1.transform.position.y > _box2.transform.position.y)
                return Mathf.Abs(_box1.transform.position.y - _box2.transform.position.y) < 0.1f;

            else if (_box2.transform.position.y > _box1.transform.position.y)
                return Mathf.Abs(_box2.transform.position.y - _box1.transform.position.y) < 0.1f;
            else return false;

        }

        private void NotifyGoalCompleted()
        {
            Debug.Log("Objetivo concluído!");


            foreach (var observer in _observers) observer.OnGoalCompleted();
        }

    }

}
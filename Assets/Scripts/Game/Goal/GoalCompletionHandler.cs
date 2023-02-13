using UnityEngine;
namespace MainLeaf.OcarinaOfTime.Game.Goal
{
    public class GoalCompletionHandler : MonoBehaviour, IGoalObserver
    {
        public void OnGoalCompleted()
        {
            Debug.Log("Objetivo concluído!");
        }
    }
}
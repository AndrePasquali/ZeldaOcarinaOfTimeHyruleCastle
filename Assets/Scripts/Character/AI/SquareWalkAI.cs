using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public sealed class SquareWalkAI : MonoBehaviour
    {
        public float PauseTime = 2.0F;
        public float Speed = 5.0F;

        public Transform[] Points;
        public int CurrentPoint;
        private AIState _currentState;
        public NavMeshAgent Agent;

        private void Start() => Initialize();

        private void Initialize()
        {
            Agent = GetComponent<NavMeshAgent>();
            _currentState = new WalkState(this, Points, Agent);
        }
        
        private void Update()
        {
            _currentState.UpdateState();
        }
        
        
    }
}

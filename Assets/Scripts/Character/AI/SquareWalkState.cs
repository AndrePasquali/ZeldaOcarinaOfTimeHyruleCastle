using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public sealed class SquareWalkState : IAIState
    {
        private Transform[] _points;
        private int _currentPoint;
        public NavMeshAgent _agent;
        private AIStateMachine _stateMachine;
        private Transform _player;
        private float _timerCounter;

        public SquareWalkState(AIStateMachine stateMachine, NavMeshAgent agent, Transform[] wayPoints)
        {
            _stateMachine = stateMachine;
            _agent = agent;
            _points = wayPoints;
        }
        public void UpdateState()
        {
            Vector3 target = _points[_currentPoint].position;
            _agent.destination = target;

            if (_agent.remainingDistance <= _agent.stoppingDistance + 0.75F)
            {
                _currentPoint = (_currentPoint + 1) % _points.Length;
                _stateMachine.ChangeState(_stateMachine.PauseState);
            }
        }
    }
}

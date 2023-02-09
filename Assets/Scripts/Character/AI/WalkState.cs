using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public class WalkState : IAIState
    {
        private AIStateMachine _stateMachine;
        private NavMeshAgent _agent;
        private Transform[] _wayPoints;
        private Transform _currentDestination;
        private float _timeCounter;
        private readonly float _distanceThreshold = 3f;

        public WalkState(AIStateMachine stateMachine, NavMeshAgent agent, Transform[] wayPoints)
        {
            _stateMachine = stateMachine;
            _agent = agent;
            _wayPoints = wayPoints;
            _currentDestination = wayPoints[UnityEngine.Random.Range(0, _wayPoints.Length - 1)];
        }

        public void UpdateState()
        {
            _agent.SetDestination(_currentDestination.position);

            if (DestinationIsReached())
            {
                _agent.isStopped = true;
                _timeCounter += Time.deltaTime;
                if(_timeCounter <= 3F) return;
                _timeCounter = 0;
                _agent.isStopped = false;
                
                _stateMachine.ChangeState(_stateMachine.FollowPlayerState);
            }
        }

        private bool DestinationIsReached()
        {
            var isNear = Vector3.Distance(_agent.transform.position, _currentDestination.position) <= 1.5F;

            return isNear;        
        }
    }
}

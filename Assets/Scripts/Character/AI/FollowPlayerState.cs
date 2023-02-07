using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public class FollowPlayerState: IAIState
    {
        private AIStateMachine _stateMachine;
        private Transform _player;
        private NavMeshAgent _agent;
        private Animator _animator;
        private float _timerCounter;

        public FollowPlayerState(AIStateMachine stateMachine, Transform player, NavMeshAgent agent, Animator animator)
        {
            _stateMachine = stateMachine;
            _player = player;
            _agent = agent;
            _animator = animator;
        }

        public void UpdateState()
        {
            _agent.destination = _player.position;

            if (ReachedPlayer())
            {
                _agent.isStopped = true;
                _timerCounter += Time.deltaTime;
                if(_timerCounter < 5F) return;
                _timerCounter = 0;
                _agent.isStopped = false;
                
                ChangeState();
            }
        }

        public void ChangeState()
        {
            _stateMachine.ChangeState(_stateMachine.WalkState);
        }

        public bool ReachedPlayer()
        {
            var distanceToPlayer = Vector3.Distance(_agent.transform.position, _player.position) <= 3.0F;

            return distanceToPlayer;
        }
    }
}
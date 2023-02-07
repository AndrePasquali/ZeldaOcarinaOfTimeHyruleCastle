using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public class PauseState: IAIState
    {
        private AIStateMachine _stateMachine;
        private NavMeshAgent _agent;
        private float _timerCounter;
        private float _timer = 5.0F;
        public PauseState(AIStateMachine stateMachine, NavMeshAgent agent)
        {
            _stateMachine = stateMachine;
            _agent = agent;
        }

        public void UpdateState()
        {
            _agent.isStopped = true;
            _timer -= Time.deltaTime;

            if (_timer <= 0)
            {
                _stateMachine.ChangeState(_stateMachine.SquareWalkState);
                _timer = 5.0F;
                _agent.isStopped = false;
            }
        }
    }
}
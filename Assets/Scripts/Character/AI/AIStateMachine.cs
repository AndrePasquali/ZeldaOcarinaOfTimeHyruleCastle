using UnityEngine;
using UnityEngine.AI;

namespace MainLeaf.OcarinaOfTime.Character.AI
{
    public class AIStateMachine : MonoBehaviour
    {
        public enum AIState
        {
            FOLLOW,
            WALK,
            PAUSE
        }

        public AIState CurrentAIState;
        public Transform Player => _player ?? (_player = GameObject.FindWithTag("Player").transform);
        private Transform _player;
        public NavMeshAgent Agent => _agent ?? (_agent = GetComponent<NavMeshAgent>());
        private NavMeshAgent _agent;

        [SerializeField] private Animator _animator;

        public IAIState CurrentState;
        public FollowPlayerState FollowPlayerState;
        public SquareWalkState SquareWalkState;
        public WalkState WalkState;
        public PauseState PauseState;

        public Transform[] Waypoints;

        private void Start()
        {
            FollowPlayerState = new FollowPlayerState(this, Player, Agent, _animator);
            SquareWalkState = new SquareWalkState(this, Agent, Waypoints);
            WalkState = new WalkState(this, Agent, Waypoints);
            PauseState = new PauseState(this, Agent);
            CurrentState = SquareWalkState;
        }

        private void Update()
        {
            CurrentState.UpdateState();
            
            UpdateAnimator();
        }

        private void UpdateAnimator()
        {
            Vector3 velocity = Agent.velocity;
            Vector3 localVelocity = transform.InverseTransformDirection(velocity);
            
            _animator.SetFloat("Foward", localVelocity.z);
        }

        public void ChangeState(IAIState newState)
        {
            CurrentState = newState;

            if (newState is FollowPlayerState)
                CurrentAIState = AIState.FOLLOW;
            else if (newState is WalkState)
            {
                transform.LookAt(Player);
                CurrentAIState = AIState.WALK;
            }
        }

        public void OnDestroy()
        {
            Agent.gameObject.SetActive(false);
        }
    }
}

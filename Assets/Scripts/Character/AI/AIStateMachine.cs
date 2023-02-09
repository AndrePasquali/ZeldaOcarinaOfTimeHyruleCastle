using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.SceneManagement;

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

        public CharacterPhysics CharacterPhysics =>
            _characterPhysics ?? (_characterPhysics = GetComponent<CharacterPhysics>());
        private CharacterPhysics _characterPhysics;

        [SerializeField] private Animator _animator;

        [SerializeField] private float _detectPlayerDistanceView = 5F;
        [SerializeField] private float _detectPlayerDistance = 2.5F;

        public IAIState CurrentState;
        public FollowPlayerState FollowPlayerState;
        public SquareWalkState SquareWalkState;
        public WalkState WalkState;
        public PauseState PauseState;
        private bool _playerDetected;

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
            
            CheckPlayerByView();
            CheckPlayerByDistance();
        }

        private void OnAnimatorMove()
        {
            var velocity = Agent.velocity.magnitude;
            
            _animator.SetFloat("Forward", velocity > 0 ? 0.5F : 0);
            
            //_animator.SetFloat("Turn", Agent.transform.rotation.eulerAngles.magnitude);
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

        private void CheckPlayerByView()
        {
            var rayForward = CharacterPhysics.RayToDirection(CharacterPhysics.RayDirection.Front, _detectPlayerDistanceView);
            
            if(!rayForward || _playerDetected) return;
            
            var hit = CharacterPhysics.GetHit();

            if (hit.transform.gameObject.tag.Equals("Player")) OnPlayerBusted();
        }

        public void CheckPlayerByDistance()
        {
            if(_playerDetected) return;
            
            var playerIsNear = Vector3.Distance(transform.position, Player.transform.position) < _detectPlayerDistance;
            
            if(playerIsNear) OnPlayerBusted();
            
        }

        private void OnPlayerBusted()
        {
            _playerDetected = true;

            Time.timeScale = 0;

            var popup = ServiceLocator.Get<PopupController>();
                
            popup.ShowPopup("ALERT", "Hey You! Stop! \n You. kid. over there!",
                () => SceneManager.LoadScene(1));
        }

        public void OnDestroy()
        {
            Agent.gameObject.SetActive(false);
        }
    }
}

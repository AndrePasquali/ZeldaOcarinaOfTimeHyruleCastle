using System;
using System.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterJump: CharacterAbility, ICharacterStateObserver
    {
        [SerializeField] private float _jumpForce = 5;
        [SerializeField] private float _minJumpInterval = 2.0F;

        private float _jumpTime;
        
        protected override void Execute()
        {
            var physics = ServiceLocator.Get<CharacterPhysics>();

            if(!physics.IsGrounded()) return;

            if (physics.RayToDirection(CharacterPhysics.RayDirection.Front))
            {
                var hit = physics.GetHit();

                if (hit.collider != null &&
                    Vector3.Distance(hit.transform.position, transform.position) <= 2.0F)
                {
                    if (hit.transform.GetComponent<IPushable>() != null)
                    {
                        return;
                    }
                }
            }

            bool jumpAllowed = (Time.time - _jumpTime) >= _minJumpInterval;

            if (jumpAllowed)
            {
                _jumpTime = Time.time;
                Rigidbody.AddForce(Vector3.up * _jumpForce, ForceMode.Impulse);
                UpdateAnimator();
                OnStateStart();
            }
        }

        protected override void UpdateAnimator(bool value = true)
        {
            var isRunning = Rigidbody.velocity.magnitude > 0;
            Animator.SetTrigger(isRunning ? "JumpForward" : "Jump");
        }

        public void Jump() => Execute();
        public async void OnStateStart()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Jumping);

            await Task.Delay(TimeSpan.FromSeconds(1.0F));
            
            OnStateFinish();
        }

        public void OnStateFinish()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Idle);
        }
    }
}
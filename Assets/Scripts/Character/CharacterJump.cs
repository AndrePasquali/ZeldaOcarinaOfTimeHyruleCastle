using System;
using System.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
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
            Animator.SetTrigger(AnimationName);
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
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Default);
        }
    }
}
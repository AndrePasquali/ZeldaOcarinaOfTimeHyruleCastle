using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterJump: CharacterAbility
    {
        [SerializeField] private float _jumpForce = 5;
        [SerializeField] private float _minJumpInterval = 2.0F;

        private float _jumpTime;
        
        protected override void Execute()
        {
            var physics = ServiceLocator.Get<CharacterPhysics>();

            if(!physics.IsGrounded()) return;
            
            bool jumpCooldownOver = (Time.time - _jumpTime) >= _minJumpInterval;
            
            if (jumpCooldownOver)
            {
                _jumpTime = Time.time;
                Rigidbody.AddForce(Vector3.up * _jumpForce, ForceMode.Impulse);
                UpdateAnimator();
            }
        }

        protected override void UpdateAnimator(bool value = true)
        {
            Animator.SetTrigger(AnimationName);
        }

        public void Jump() => Execute();
    }
}
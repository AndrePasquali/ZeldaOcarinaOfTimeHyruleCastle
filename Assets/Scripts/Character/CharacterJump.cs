using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterJump: CharacterAbility
    {
        [SerializeField] private float _jumpForce = 30;
        [SerializeField] private float _minJumpInterval = 2.0F;
        
        private float _jumpTime;
        private bool _isGrounded;
        
        protected override void Execute()
        {
            bool jumpCooldownOver = (Time.time - _jumpTime) >= _minJumpInterval;
            
            if (jumpCooldownOver && _isGrounded)
            {
                _jumpTime = Time.time;
                Rigidbody.AddForce(Vector3.up * _jumpForce, ForceMode.Impulse);
            }
        }

        protected override void UpdateAnimator(bool value = true)
        {
            Animator?.SetTrigger(AnimationName);
        }

        public void Jump()
        {
            Execute();
            UpdateAnimator();
        }
    }
}
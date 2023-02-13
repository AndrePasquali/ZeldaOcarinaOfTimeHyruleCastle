using System;
using System.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Audio;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterJump : CharacterAbility, ICharacterStateObserver, ISound
    {
        [SerializeField] private float _jumpForce = 5;
        [SerializeField] private float _minJumpInterval = 2.0F;

        [SerializeField] private GameObject _targetJump;

        private float _jumpTime;



        protected override void Execute()
        {
            var physics = ServiceLocator.Get<CharacterPhysics>();

            if (!physics.IsGrounded()) return;

            CharacterStateMachine.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Jumping);

            bool jumpAllowed = (Time.time - _jumpTime) >= _minJumpInterval;

            if (jumpAllowed)
            {
                _jumpTime = Time.time;
                Rigidbody.AddForce(Vector3.up * _jumpForce, ForceMode.Impulse);
                //Jump(_targetJump.transform.position);
                UpdateAnimator();
                OnStateStart();
            }
        }

        public void JumpTo(Vector3 target)
        {
            Vector3 direction = (target - transform.position).normalized;
            float distance = Vector3.Distance(transform.position, target);
            float speed = Mathf.Sqrt(2 * distance * UnityEngine.Physics.gravity.magnitude / Mathf.Sin(2 * Mathf.Deg2Rad * 10));
            Rigidbody.AddForce(direction * 17, ForceMode.Impulse);
        }

        protected override void UpdateAnimator(bool value = true)
        {
            var isRunning = Rigidbody.velocity.magnitude > 0;
            Animator.SetTrigger(isRunning ? "JumpForward" : "Jump");
        }

        public void Jump() => Execute();
        public async void OnStateStart()
        {
            PlaySoundFX();

            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Jumping);

            await Task.Delay(TimeSpan.FromSeconds(1.0F));

            OnStateFinish();
        }

        public void OnStateFinish()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Idle);
        }

        public void PlaySoundFX()
        {
            AudioSource.PlayOneShot(SoundClip[UnityEngine.Random.Range(0, SoundClip.Length)]);
        }
    }
}
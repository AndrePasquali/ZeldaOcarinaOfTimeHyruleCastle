using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Audio;
using MainLeaf.OcarinaOfTime.Camera;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterCrouch : CharacterAbility, ICharacterStateObserver, ISound, ICameraChange
    {
        protected override void Execute()
        {
            var physics = ServiceLocator.Get<CharacterPhysics>();

            if (!physics.IsGrounded()) return;

            CharacterStateMachine.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Crouching);

            UpdateAnimator();
        }

        protected override void UpdateAnimator(bool value = true)
        {
            Animator.SetBool(AnimationName, value);
        }

        public async void Crouch()
        {
            ChangeMode(CameraController.CameraMode.ThirdPerson);

            while (UnityEngine.Input.GetKey(KeyCode.C))
            {
                Execute();

                await UniTask.Delay(TimeSpan.FromSeconds(0.5F));
            }

            OnStateFinish();
        }

        public async void Crouch(float duration = 3)
        {
            ChangeMode(CameraController.CameraMode.ThirdPerson);

            UpdateAnimator();

            var timer = duration;

            while (duration < 0)
            {
                duration -= Time.deltaTime;

                Execute();

                await UniTask.Delay(TimeSpan.FromSeconds(0.5F));
            }

            OnStateFinish();
        }

        public void PlaySoundFX()
        {
            AudioSource.PlayOneShot(SoundClip[UnityEngine.Random.Range(0, SoundClip.Length)]);
        }

        public void OnStateStart()
        {
            throw new NotImplementedException();
        }

        public void OnStateFinish()
        {
            UpdateAnimator(false);
            ChangeMode(CameraController.CameraMode.FreeLook);
            CharacterStateMachine.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Default);
        }

        public void ChangeMode(CameraController.CameraMode newCameraMode)
        {
            var cameraController = ServiceLocator.Get<CameraController>();
            cameraController.ChangeMode(newCameraMode);
        }
    }
}
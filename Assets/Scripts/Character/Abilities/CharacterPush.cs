using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterPush: CharacterAbility, ICharacterStateObserver
    {
        [SerializeField] private float PushForce = 2.0F;
        [SerializeField] private float PushSpeed = 0.5F;
        [SerializeField] private float MinDistanceToPush = 2.0F;
        private Rigidbody _targetRigidbody;
        protected override void Execute()
        {
           if(!AbilityEnabled) return;

           var physics = ServiceLocator.Get<CharacterPhysics>();
           
           if(!physics.IsGrounded()) return;

           var blackBars = ServiceLocator.Get<BlackBars>();

           if (physics.RayToDirection(CharacterPhysics.RayDirection.Front))
           {
               var hit = physics.GetHit();
               
               if (hit.collider != null && Vector3.Distance(hit.transform.position, transform.position) <= MinDistanceToPush)
               {
                   if (hit.transform.GetComponent<IPushable>() != null)
                   {
                       var rigidbody = hit.transform.GetComponent<Rigidbody>();
                       
                       _targetRigidbody = rigidbody;
                       
                       UpdateAnimator(true);
                       
                       if(rigidbody != null) rigidbody.AddForce(transform.forward * PushForce, ForceMode.Impulse);
            
                       Rigidbody.AddForce(transform.forward * PushSpeed, ForceMode.VelocityChange);
                       
                       blackBars.ShowBlackBars();
                       OnStateStart();
                   }
               }
           }
           else
           {
               blackBars.HideBlackBars();
           }
        }

        protected override void UpdateAnimator(bool value)
        {
            Animator.SetTrigger(AnimationName);
        }

        public async void Push()
        {
            while (Input.GetButton("Push"))
            {
                Execute();
                await UniTask.Delay(TimeSpan.FromSeconds(1));
            }
            
            var blackBars = ServiceLocator.Get<BlackBars>();
            blackBars.HideBlackBars();
        }

        public async void OnStateStart()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Pushing);
            _targetRigidbody.isKinematic = false;
            await Task.Delay(TimeSpan.FromSeconds(3.0F));
            OnStateFinish();

        }

        public void OnStateFinish()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Default);
        }
    }
}
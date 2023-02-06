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
        [SerializeField] private float MinDistanceToPush = 2.0F;
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
                       var rigibody = hit.transform.GetComponent<Rigidbody>();

                       if(rigibody != null) rigibody.AddForce(Vector3.forward * PushForce, ForceMode.Impulse);
                       
                       blackBars.ShowBlackBars();
                       UpdateAnimator(true);
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

        public void Push()
        {
            Execute();
        }

        public void OnStateStart()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Pushing);
        }

        public void OnStateFinish()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Default);

        }
    }
}
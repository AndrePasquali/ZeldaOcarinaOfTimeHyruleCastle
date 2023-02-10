using System;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Camera;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterPush: CharacterAbility, ICharacterStateObserver, ICameraChange
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

                       var velocity = Rigidbody.velocity;
                       var isStopped = velocity.magnitude == 0;
                       var localVelocity = transform.InverseTransformDirection(velocity);
                       var movingForward = localVelocity.z > 0;

                       hit.transform.GetComponent<Box>().GetJoint().connectedBody = Rigidbody;


                     //  var forceToApply = movingForward ? transform.forward : transform.forward * -1;

                       
                      // if(rigidbody != null) rigidbody.velocity = isStopped ? Vector3.zero : forceToApply * PushForce;
            
                       //Rigidbody.AddForce(isStopped ? Vector3.zero : forceToApply, ForceMode.VelocityChange);
                       
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
            Animator.SetBool("Push", true);
        }

        public async void Push()
        {
            ChangeMode(CameraController.CameraMode.ThirdPerson);
            while (Input.GetKey(KeyCode.F))
            {
                Execute();
                
                await UniTask.Delay(TimeSpan.FromSeconds(0.5F));
            }
            
            var blackBars = ServiceLocator.Get<BlackBars>();
            blackBars.HideBlackBars();
            if(_targetRigidbody != null) _targetRigidbody.GetComponent<Box>().GetJoint().connectedBody = null;
            
            Animator.SetBool("Push", false);


            ChangeMode(CameraController.CameraMode.FreeLook);
        }

        public async void OnStateStart()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Pushing);
           // _targetRigidbody.isKinematic = false;
            await Task.Delay(TimeSpan.FromSeconds(3.0F));
            OnStateFinish();

        }

        public void OnStateFinish()
        {
            Character.OnCharacterMovementStateChange.Invoke(StateMachine.CharacterMovement.Default);
        }

        public void ChangeMode(CameraController.CameraMode newCameraMode)
        {
            var cameraController = ServiceLocator.Get<CameraController>();
            cameraController.ChangeMode(newCameraMode);
        }
    }
}
using System;
using System.Threading.Tasks;
using MainLeaf.OcarinaOfTime.Character;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Enrironment;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

public class CharacterClimb : CharacterAbility, ICharacterStateObserver
{
    [SerializeField] private float MinDistanceToClimb = 2.0F;
    [SerializeField] private float ClimbForce = 2.0F;

    protected override void Execute()
    {
        if(!AbilityEnabled) return;

        var physics = ServiceLocator.Get<CharacterPhysics>();
           
        if(!physics.IsGrounded()) return;
        
        if (physics.RayToDirection(CharacterPhysics.RayDirection.Front))
        {
            var hit = physics.GetHit();
               
            if (hit.collider != null && Vector3.Distance(hit.transform.position, transform.position) <= MinDistanceToClimb)
            {
                if (hit.transform.GetComponent<IPushable>() != null)
                {
                    Rigidbody.AddForce(Vector3.forward * ClimbForce, ForceMode.Impulse);
                    UpdateAnimator(true);
                    OnStateStart();
                }
            }
        }
    }

    protected override void UpdateAnimator(bool value = true)
    {
        Animator.SetTrigger(AnimationName);
    }

    public void Climb() => Execute();

    public async void OnStateStart()
    {
        Character.OnCharacterMovementStateChange.Invoke(MainLeaf.OcarinaOfTime.Character.StateMachine.CharacterMovement.Climb);

        await Task.Delay(TimeSpan.FromSeconds(3.0F));
    }

    public void OnStateFinish()
    {
        Rigidbody.isKinematic = true;
        Character.OnCharacterMovementStateChange.Invoke(MainLeaf.OcarinaOfTime.Character.StateMachine.CharacterMovement.Idle);
    }
}

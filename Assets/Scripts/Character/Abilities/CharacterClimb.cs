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
    [SerializeField] private float ClimbJumpForce = 5.0F;
    private bool _isClimbing;
    private CapsuleCollider _capsuleCollider;

    private void Start()
    {
        _capsuleCollider = GetComponent<CapsuleCollider>();
    }

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
                    Rigidbody.AddForce(Vector3.up * ClimbJumpForce, ForceMode.Impulse);
                    AddForceForward();
                    UpdateAnimator(true);
                    OnStateStart();
                    _isClimbing = true;
                    Debug.Log($"START CLIMB");

                }
                else
                {
                    _isClimbing = false;
                }
            }
        }
    }

    private async void AddForceForward()
    {
        await Task.Delay(TimeSpan.FromSeconds(0.5F));
        
        Debug.Log($"START FORCE FORWARD CLIMB");
        
        Rigidbody.AddForce(transform.forward * ClimbForce, ForceMode.VelocityChange);
        
    }

    private void FixedUpdate()
    {
       
    }

    protected override void UpdateAnimator(bool value = true)
    {
        Animator.SetTrigger(AnimationName);
    }

    public void Climb() => Execute();

    public async void OnStateStart()
    {
        Character.OnCharacterMovementStateChange.Invoke(MainLeaf.OcarinaOfTime.Character.StateMachine.CharacterMovement.Climb);

        while (Rigidbody.velocity.y > 0)
        {
            await Task.Delay(TimeSpan.FromSeconds(0.25F));
        }
        
        OnStateFinish();
    }

    public void OnStateFinish()
    {
        _isClimbing = false;
        Character.OnCharacterMovementStateChange.Invoke(MainLeaf.OcarinaOfTime.Character.StateMachine.CharacterMovement.Idle);
    }
}

using System;
using System.Collections;
using System.Collections.Generic;
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
    private BoxCollider _boxCollider;
    private Transform climbTarget;


    private void Start()
    {
        _capsuleCollider = GetComponent<CapsuleCollider>();
    }

    protected override void Execute()
    {
        if (!AbilityEnabled) return;

        var physics = ServiceLocator.Get<CharacterPhysics>();

        if (!physics.IsGrounded()) return;

        if (physics.RayToDirection(CharacterPhysics.RayDirection.Front))
        {
            var hit = physics.GetHit();

            if (hit.collider != null && Vector3.Distance(hit.transform.position, transform.position) <= MinDistanceToClimb)
            {
                if (hit.transform.GetComponent<IPushable>() != null)
                {
                    Rigidbody.AddForce(Vector3.up * ClimbJumpForce, ForceMode.Impulse);

                    UpdateAnimator(true);
                    OnStateStart();

                    _boxCollider = hit.transform.GetComponent<BoxCollider>();
                    _isClimbing = true;

                    // MoveCapsuleColliderWithAnimation(1.0F);
                    //StartCoroutine(MoveCapsuleColliderWithAnimation());

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

        Rigidbody.AddForce(transform.forward * ClimbForce, ForceMode.VelocityChange);

    }


    private Vector3 GetTopOfBoxPosition()
    {
        Vector3 capsuleColliderCenter = transform.position + _capsuleCollider.center;
        float capsuleColliderRadius = _capsuleCollider.radius;
        float capsuleColliderHeight = _capsuleCollider.height;
        Collider[] colliders = Physics.OverlapCapsule(capsuleColliderCenter + Vector3.up * capsuleColliderHeight / 2,
            capsuleColliderCenter - Vector3.up * capsuleColliderHeight / 2,
            capsuleColliderRadius);
        foreach (Collider collider in colliders)
        {
            if (collider.CompareTag("Climb"))
            {
                Bounds boxBounds = collider.bounds;
                return boxBounds.max + new Vector3(0, _capsuleCollider.height / 2, 0);
            }
        }
        return Vector3.zero;
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

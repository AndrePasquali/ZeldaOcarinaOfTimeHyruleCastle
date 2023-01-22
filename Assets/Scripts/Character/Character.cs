using MainLeaf.OcarinaOfTime.Character.Enum;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public abstract class Character: MonoBehaviour
    {
        [SerializeField] private Animator _animator;

        [SerializeField] private string[] _animatorParameters;
        
        public CharacterType Type;

        public CharacterMovementStates MovementState = CharacterMovementStates.Idle;

        public CharacterDirection DirectionType;

        public int Direction => DirectionType == CharacterDirection.Right ? 1 : 0;

        public virtual void ProcessAnimator()
        {
            
        }

    }
}
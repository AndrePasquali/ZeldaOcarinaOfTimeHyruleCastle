using System;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class Character : MonoBehaviour
    {
        [SerializeField] private Animator _animator;

        public CharacterMovement CharacterMovement;

        public CharacterStateMachine CharacterState;

        public InputController InputController;

        public CharacterPhysics CharacterPhysics;

        public static Action<MainLeaf.OcarinaOfTime.Character.StateMachine.CharacterMovement> OnCharacterMovementStateChange;

        private void OnCharacterMovementChange(MainLeaf.OcarinaOfTime.Character.StateMachine.CharacterMovement newMovementState)
        {
            CharacterState.CurrentMovementState = newMovementState;
        }

        private void Awake() => Initialize();

        private void Initialize()
        {
            OnCharacterMovementStateChange += OnCharacterMovementChange;

            CharacterState = GetComponent<CharacterStateMachine>();
            CharacterMovement = GetComponent<CharacterMovement>();
            InputController = GetComponent<InputController>();
            CharacterPhysics = GetComponent<CharacterPhysics>();

            ServiceLocator.Register(_animator);
            ServiceLocator.Register(CharacterState);
            ServiceLocator.Register(CharacterMovement);
            ServiceLocator.Register(InputController);
            ServiceLocator.Register(CharacterPhysics);
        }
    }
}
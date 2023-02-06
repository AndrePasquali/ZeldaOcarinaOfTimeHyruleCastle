using System;
using MainLeaf.OcarinaOfTime.Character.Physics;
using MainLeaf.OcarinaOfTime.Character.StateMachine;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class Character: MonoBehaviour
    {
        [SerializeField] private Animator _animator;
        
        public CharacterMovement CharacterMovement;
        
        public CharacterStateMachine CharacterState;
        
        public InputController InputController;

        private void Awake() => Initialize();

        private void Initialize()
        {
            CharacterState = GetComponent<CharacterStateMachine>();
            CharacterMovement = GetComponent<CharacterMovement>();
            InputController = GetComponent<InputController>();

            ServiceLocator.Register(_animator);
            ServiceLocator.Register(CharacterState);
            ServiceLocator.Register(CharacterMovement);
            ServiceLocator.Register(InputController);
            ServiceLocator.Register(GetComponent<CharacterPhysics>());
        }
    }
}
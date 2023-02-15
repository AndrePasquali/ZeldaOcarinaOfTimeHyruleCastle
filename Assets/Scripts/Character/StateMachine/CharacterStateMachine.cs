using UnityEngine;
using System;

namespace MainLeaf.OcarinaOfTime.Character.StateMachine
{
    public class CharacterStateMachine : MonoBehaviour
    {
        public CharacterCondition CurrentConditionState;
        public CharacterDirection CurrentDirectionState;
        public CharacterMovement CurrentMovementState;
        public static Action<CharacterMovement> OnCharacterMovementStateChange;


        public void ChangeMovementState(CharacterMovement newMovement)
        {
            OnCharacterMovementStateChange.Invoke(newMovement);

            switch (newMovement)
            {
                case CharacterMovement.Pushing:
                    {
                        CurrentMovementState = CharacterMovement.Pushing;
                        break;

                    }
                case CharacterMovement.Jumping:
                    {

                        CurrentMovementState = CharacterMovement.Jumping;
                        break;
                    }
                case CharacterMovement.Crouching:
                    {
                        CurrentMovementState = CharacterMovement.Crouching;

                        break;
                    }
            }
        }

    }
}
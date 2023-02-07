using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character.StateMachine
{
    public class CharacterStateMachine: MonoBehaviour
    {
        public CharacterCondition CurrentConditionState;
        public CharacterDirection CurrentDirectionState;
        public CharacterMovement CurrentMovementState;
        

        public void ChangeMovementState(CharacterMovement newMovement)
        {
            switch (newMovement)
            {
                case CharacterMovement.Pushing:
                {
                    var pushBehaviour = GetComponent<CharacterPush>();
                    pushBehaviour.Push();
                    break;
                }
                case CharacterMovement.Jumping:
                {
                    var climb = GetComponent<CharacterClimb>();
                    
                    climb.Climb();
                    break;
                }
            }
        }
        
    }
}
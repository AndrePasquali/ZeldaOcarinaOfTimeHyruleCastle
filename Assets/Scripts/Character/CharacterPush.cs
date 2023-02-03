using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public class CharacterPush: CharacterAbility
    {
        protected override void Execute()
        {
            Debug.Log("Push");
        }

        protected override void UpdateAnimator(bool value)
        {
            Animator.SetBool(AnimationName, value);
        }

        public void Push()
        {
            Execute();
            UpdateAnimator(true);
        }
    }
}
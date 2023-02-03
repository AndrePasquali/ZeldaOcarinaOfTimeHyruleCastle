using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public abstract class CharacterAbility: MonoBehaviour
    {
        public string AnimationName;
        public Animator Animator;
        public Rigidbody Rigidbody => _rigibody ?? (_rigibody = GetComponent<Rigidbody>());
        private Rigidbody _rigibody;
        protected abstract void Execute();

        protected abstract void UpdateAnimator(bool value = true);
    }
}
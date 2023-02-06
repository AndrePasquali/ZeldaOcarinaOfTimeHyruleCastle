using System;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public abstract class CharacterAbility: MonoBehaviour
    {
        public bool AbilityEnabled;

        public KeyCode ActionKey;
        
        public string AnimationName;
        public Animator Animator;

        protected bool Initialized;
        public Rigidbody Rigidbody => _rigibody ?? (_rigibody = GetComponent<Rigidbody>());
        private Rigidbody _rigibody;
        protected abstract void Execute();

        private void Awake() => Initialized = true;

        protected abstract void UpdateAnimator(bool value = true);
    }
}
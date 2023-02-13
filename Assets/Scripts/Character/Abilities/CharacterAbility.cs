using System;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Character
{
    public abstract class CharacterAbility : MonoBehaviour
    {
        public bool AbilityEnabled;

        public KeyCode ActionKey;

        public string AnimationName;
        public Animator Animator => _animator ?? (_animator = ServiceLocator.Get<Animator>());

        private Animator _animator;

        protected bool Initialized;
        public Rigidbody Rigidbody => _rigibody ?? (_rigibody = GetComponent<Rigidbody>());
        private Rigidbody _rigibody;

        [Header("SOUND FX")]
        [SerializeField] protected AudioSource AudioSource;
        [SerializeField] protected AudioClip[] SoundClip;
        protected abstract void Execute();

        private void Awake() => Initialized = true;

        protected abstract void UpdateAnimator(bool value = true);
    }
}
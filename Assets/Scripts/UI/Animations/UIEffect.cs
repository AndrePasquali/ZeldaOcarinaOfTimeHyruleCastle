using UnityEngine;
using DG.Tweening;
using UnityEngine.Events;

namespace MainLeaf.OcarinaOfTime.UI
{
    public abstract class UIEffect : MonoBehaviour
    {
        [SerializeField] protected CanvasGroup CanvasGroup;

        [Header("SETTINGS")]
        [SerializeField] protected float Duration;
        [SerializeField] protected bool AutoStart;
        [SerializeField] protected Ease EaseEffect;


        [Header("EVENTS")]
        public UnityEvent OnAnimationFinishedEvent;

        public UnityEvent OnAnimationStartedEvent;


        private void Start()
        {
            if (AutoStart) StartAnimation();
        }
        public abstract void StartAnimation();

        protected virtual void OnAnimationStart()
        {
            if (OnAnimationStartedEvent != null) OnAnimationStartedEvent?.Invoke();

        }

        protected virtual void OnAnimationFinish()
        {
            if (OnAnimationFinishedEvent != null) OnAnimationFinishedEvent?.Invoke();
        }
    }
}
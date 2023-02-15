using UnityEngine;
using DG.Tweening;
namespace MainLeaf.OcarinaOfTime.UI
{
    public abstract class UIEffect : MonoBehaviour
    {
        [SerializeField] protected CanvasGroup CanvasGroup;
        [SerializeField] protected float Duration;
        [SerializeField] protected bool AutoStart;
        [SerializeField] protected Ease EaseEffect;

        private void Start()
        {
            if (AutoStart) StartAnimation();
        }
        public abstract void StartAnimation();

        public virtual void OnAnimationStart()
        {

        }

        public virtual void OnAnimationFinish()
        {

        }
    }
}
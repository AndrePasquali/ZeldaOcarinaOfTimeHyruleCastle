using DG.Tweening;

namespace MainLeaf.OcarinaOfTime.UI
{
    public sealed class FadeOutEffect : UIEffect
    {
        public override void StartAnimation() => CanvasGroup.DOFade(0, Duration).SetEase(EaseEffect);

    }
}
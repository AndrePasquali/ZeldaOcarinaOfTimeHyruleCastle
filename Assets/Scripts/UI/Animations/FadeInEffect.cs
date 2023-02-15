using DG.Tweening;

namespace MainLeaf.OcarinaOfTime.UI
{
    public sealed class FadeInEffect : UIEffect
    {
        public override void StartAnimation() => CanvasGroup.DOFade(1, Duration).SetEase(EaseEffect);
    }
}
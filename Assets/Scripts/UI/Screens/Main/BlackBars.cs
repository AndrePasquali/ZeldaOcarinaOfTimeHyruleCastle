using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

public class BlackBars : MonoBehaviour
{
    [SerializeField] private Animator _animator;

    private void Awake()
    {
        ServiceLocator.Register(this);
    }

    public void ShowBlackBars()
    {
        _animator.SetBool("Enabled", true);
    }

    public void HideBlackBars()
    {
        _animator.SetBool("Enabled", false);
    }
}

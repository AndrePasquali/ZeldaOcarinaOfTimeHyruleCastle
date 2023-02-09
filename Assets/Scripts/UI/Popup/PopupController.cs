using System;
using MainLeaf.OcarinaOfTime.Services;
using UnityEngine;

public class PopupController : MonoBehaviour
{
    [SerializeField] private PopupMessage _popup;

    private void Start()
    {
        ServiceLocator.Register(this);
    }

    public void ShowPopup(string title, string body, Action callback)
    {
        var popup = Instantiate(_popup);
        
        popup.SetTitle(title);
        popup.SetBody(body);
        popup.SetCallBack(callback);
    }
}

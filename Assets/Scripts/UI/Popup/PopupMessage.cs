using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PopupMessage : MonoBehaviour
{
    [SerializeField] private TMP_Text _title;
    [SerializeField] private TMP_Text _body;
    [SerializeField] private Button _button;
    
    public void SetTitle(string newTitle) => _title.text = newTitle;

    public void SetBody(string newBody) => _body.text = newBody;

    public async void SetCallBack(Action callback) => _button.onClick.AddListener(() => callback.Invoke());

}

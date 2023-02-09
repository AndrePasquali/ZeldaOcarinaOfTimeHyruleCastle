using System;
using System.Collections;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Loading : MonoBehaviour
{
    [SerializeField] private float _loadingDuration = 3.0F;

    private void Start()
    {
        LoadNextScene();
    }

    private async void LoadNextScene()
    {
        await UniTask.Delay(TimeSpan.FromSeconds(_loadingDuration));

        SceneManager.LoadScene(3);
    }
}

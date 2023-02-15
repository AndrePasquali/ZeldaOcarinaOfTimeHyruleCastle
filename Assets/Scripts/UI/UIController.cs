using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System;
using UnityEngine.SceneManagement;

namespace Mainleaf.OcarinaOfTime.UI
{
    public class UIController : MonoBehaviour
    {
        [SerializeField] private List<UIScreenItem> _uiScreenList;
        public enum UIScreen
        {
            DEFAULT,
            PAUSE
        }

        private UIScreen _currentUIScreen;

        public UIScreen CurrentUIScreen
        {
            get { return _currentUIScreen; }
            set
            {
                switch (value)
                {
                    case UIScreen.DEFAULT:
                        {
                            if (_uiScreenList == null || _uiScreenList.Count == 0) return;

                            _uiScreenList.FirstOrDefault(e => e.Screen == UIScreen.PAUSE).Enabled = false;
                            break;
                        }
                    case UIScreen.PAUSE:
                        {
                            if (_uiScreenList == null || _uiScreenList.Count == 0) return;
                            _uiScreenList.FirstOrDefault(e => e.Screen == UIScreen.PAUSE).Enabled = true;
                            break;
                        }

                }
                _currentUIScreen = value;
            }
        }

        public static Action<UIScreen> OnUIScreenChanged;

        private void Start()
        {
            OnUIScreenChanged += ChangeUIState;
        }

        private void ChangeUIState(UIScreen newUIState) => CurrentUIScreen = newUIState;
        public void Update()
        {
            if (UnityEngine.Input.GetKeyDown(KeyCode.Escape))
            {
                if (CurrentUIScreen == UIScreen.PAUSE)
                {
                    CurrentUIScreen = UIScreen.DEFAULT;
                    return;
                }

                if (SceneManager.GetActiveScene().buildIndex == 1)
                    Application.Quit();

                CurrentUIScreen = UIScreen.PAUSE;

            }
        }
    }
}
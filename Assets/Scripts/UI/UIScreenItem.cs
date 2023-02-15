using UnityEngine;

namespace Mainleaf.OcarinaOfTime.UI
{
    public sealed class UIScreenItem : MonoBehaviour
    {
        public UIController.UIScreen Screen;
        public bool Enabled
        {
            get => enabled;
            set
            {
                try
                {
                    if (gameObject != null)
                        gameObject?.SetActive(enabled);
                    enabled = value;

                }
                catch (System.Exception e)
                {

                }

            }

        }

        private bool _enabled;


    }

}
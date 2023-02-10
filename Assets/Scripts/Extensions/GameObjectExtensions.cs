using UnityEngine;

namespace MainLeaf.OcarinaOfTime.Extensions
{
    public static class GameObjectExtensions
    {
        public static void Show(this GameObject gameObject)
        {
            gameObject.SetActive(true);
        }

        public static void Hide(this GameObject gameObject)
        {
            gameObject.SetActive(false);
        }
    }
}
using MainLeaf.OcarinaOfTime.Player;
using MainLeaf.OcarinaOfTime.Services;
using TMPro;
using UnityEngine;

namespace MainLeaf.OcarinaOfTime.UI.HUD
{
    public class HUD: MonoBehaviour
    {
        [SerializeField] private TMP_Text _points;
        [SerializeField] private TMP_Text _action;
        public void Start()
        {
            ServiceLocator.Register(this);
            
            UpdatePoints();
        }

        public void UpdatePoints() => _points.text = PlayerProgress.GetPoints().ToString();
        public void UpdateAction(string action) => _action.text = action;
    }
}
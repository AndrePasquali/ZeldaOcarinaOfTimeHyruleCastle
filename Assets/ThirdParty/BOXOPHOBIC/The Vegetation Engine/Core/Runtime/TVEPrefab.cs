﻿// Cristian Pop - https://boxophobic.com/

using UnityEngine;
#if UNITY_EDITOR
using Boxophobic.StyledGUI;
#endif

namespace TheVegetationEngine
{
#if UNITY_EDITOR
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q4fstlrr3cw4")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Prefab")]
#endif
    public class TVEPrefab : StyledMonoBehaviour
    {
#if UNITY_EDITOR
        [StyledBanner(0.890f, 0.745f, 0.309f, "Prefab")]
        public bool styledBanner;

        [HideInInspector]
        public string storedPrefabBackupGUID = "";
        [HideInInspector]
        public string storedPreset = "";
        [HideInInspector]
        public string storedOverrides = "";
        [HideInInspector]
        public bool isCollected = false;
#endif
    }
}





// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.hbq3w8ae720x")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Manager")]
    public class TVEManager : StyledMonoBehaviour
    {
        public static TVEManager Instance;

        [StyledBanner(0.890f, 0.745f, 0.309f, "The Vegetation Engine")]
        public bool styledBanner;

        [HideInInspector]
        public TVEGlobalMotion globalMotion;
        [HideInInspector]
        public TVEGlobalDetails globalDetails;
        [HideInInspector]
        public TVEGlobalControl globalControl;
        [HideInInspector]
        public TVEGlobalVolume globalVolume;

        void Awake()
        {
            Instance = this;
            CreateComponents();
        }

        void OnEnable()
        {
            // OnEnable is always called after script compilation
            Instance = this;
            //globalVolume.InitVolumeRendering();

            Shader.SetGlobalFloat("TVE_Enabled", 1);
        }

        void OnDisable()
        {
            Instance = null;
            Shader.SetGlobalFloat("TVE_Enabled", 0);
        }

        void OnDestroy()
        {
            Instance = null;
            Shader.SetGlobalFloat("TVE_Enabled", 0);
        }

        void CreateComponents()
        {
            if (globalMotion == null)
            {
                GameObject go = new GameObject();

                go.AddComponent<MeshFilter>();
                go.GetComponent<MeshFilter>().mesh = Resources.Load<Mesh>("Internal Mesh Arrow");

                go.AddComponent<MeshRenderer>();
                go.GetComponent<MeshRenderer>().sharedMaterial = Resources.Load<Material>("Internal Arrow");

                go.AddComponent<TVEGlobalMotion>();

                SetParent(go);

                go.transform.localPosition = new Vector3(0, 2f, 0);

                globalMotion = go.GetComponent<TVEGlobalMotion>();
                globalMotion.name = "Global Motion";
            }

            if (globalDetails == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalDetails>();
                SetParent(go);

                globalDetails = go.GetComponent<TVEGlobalDetails>();
                globalDetails.name = "Global Details";
            }

            if (globalControl == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalControl>();
                SetParent(go);

                globalControl = go.GetComponent<TVEGlobalControl>();
                globalControl.name = "Global Control";
            }

            if (globalVolume == null)
            {
                GameObject go = new GameObject();
                go.AddComponent<TVEGlobalVolume>();
                SetParent(go);

                go.transform.localScale = new Vector3(400, 200, 400);

                globalVolume = go.GetComponent<TVEGlobalVolume>();
                globalVolume.name = "Global Volume";
            }
        }

        void SetParent(GameObject go)
        {
            go.transform.parent = gameObject.transform;
            go.transform.localPosition = Vector3.zero;
            go.transform.eulerAngles = Vector3.zero;
            go.transform.localScale = Vector3.one;
        }
    }
}
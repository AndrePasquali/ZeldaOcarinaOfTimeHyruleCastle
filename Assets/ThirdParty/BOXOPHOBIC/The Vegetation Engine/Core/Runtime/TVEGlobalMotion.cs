// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.czf8ud5bmaq2")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Motion")]
    public class TVEGlobalMotion : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Motion")]
        public bool styledBanner;

        [StyledCategory("Direction Settings", 5, 10)]
        public bool goCat;

        [Tooltip("Sets the main direction from a gameobject.")]
        public GameObject mainDirection;

        [StyledCategory("Wind Settings")]
        public bool windCat;

        [Tooltip("Controls the global wind power.")]
        [StyledRangeOptions("Wind Power", 0, 1, new string[] { "None", "Windy", "Strong" })]
        public float windPower = 0.5f;

        [StyledCategory("Motion Settings")]
        public bool motionCat;

        [StyledMessage("Info", "Changing the direction smoothly is only possible when Sync Noise with Main Direction is disabled! The speed settings cannot be animated in realtime!", 0, 10)]
        public bool styledMessage = true;

        [Tooltip("Sets the texture used for wind gust and motion highlight.")]
        public Texture2D noiseTexture;

        [Space(10)]
        [Tooltip("Controls the scale of the motion noise.")]
        [Range(0, 2)]
        public float noiseScale = 1;
        [Tooltip("Controls the speed of the motion noise.")]
        [Range(0, 2)]
        public float noiseSpeed = 1;

        [Tooltip("Controls the power of the motion flutter.")]
        [Range(0, 2)]
        public float flutterPower = 1;
        [Tooltip("Controls the speed of the motion flutter.")]
        [Range(0, 2)]
        public float flutterSpeed = 1;

        //[Space(10)]
        //public bool syncNoiseWithMainDirection = true;

        [StyledCategory("Fade Settings")]
        public bool fadeCat;

        [Tooltip("Controls the Details Motion (Flutter) fade out distance in world units.")]
        [Range(0.0f, 200.0f)]
        public float motionFadeDistance = 100.0f;

        [StyledSpace(10)]
        public bool styledSpace0;

        [System.NonSerialized]
        public bool isEnabled = true;

        void Start()
        {

#if UNITY_EDITOR
            gameObject.GetComponent<MeshRenderer>().hideFlags = HideFlags.HideInInspector;
            gameObject.GetComponent<MeshFilter>().hideFlags = HideFlags.HideInInspector;
#endif

            // Disable Arrow in play mode
            if (Application.isPlaying == true)
            {
                gameObject.GetComponent<MeshRenderer>().enabled = false;
            }
            else
            {
                gameObject.GetComponent<MeshRenderer>().enabled = true;
            }

            gameObject.name = "Global Motion";
            gameObject.transform.SetSiblingIndex(0);

            if (noiseTexture == null)
            {
                noiseTexture = Resources.Load<Texture2D>("Internal NoiseTex");
            }

            SetGlobalShaderProperties();

        }

        void Update()
        {
            if (mainDirection == null)
            {
                mainDirection = gameObject;
            }

            gameObject.transform.eulerAngles = new Vector3(0, mainDirection.transform.eulerAngles.y, 0);

            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            if (isEnabled)
            {
                var windDirection = transform.forward;
                Shader.SetGlobalVector("TVE_MotionParams", new Vector4(windDirection.x * 0.5f + 0.5f, windDirection.z * 0.5f + 0.5f, windPower, 0.0f));
            }

            Shader.SetGlobalTexture("TVE_NoiseTex", noiseTexture);
            Shader.SetGlobalVector("TVE_NoiseParams", new Vector4(noiseScale, noiseSpeed, 0, 0));

            //if (syncNoiseWithMainDirection)
            //{
            //    Shader.SetGlobalVector("TVE_NoiseParams", new Vector4(noiseScale, noiseSpeed, 0, 1));
            //}
            //else
            //{
            //    Shader.SetGlobalVector("TVE_NoiseParams", new Vector4(noiseScale, noiseSpeed, 0, 0));
            //}

            Shader.SetGlobalVector("TVE_FlutterParams", new Vector4(flutterPower, flutterSpeed, 0.0f, 0.0f));

            Shader.SetGlobalFloat("TVE_MotionFadeStart", (motionFadeDistance + 0.01f) * 0.5f);
            Shader.SetGlobalFloat("TVE_MotionFadeEnd", motionFadeDistance + 0.01f);
        }
    }
}

// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;

namespace TheVegetationEngine
{
    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.q3sme6mi00gy")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Global Control")]
    public class TVEGlobalControl : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Global Control")]
        public bool styledBanner;

        [StyledCategory("Light Settings", 5, 10)]
        public bool lightCat;

        [Tooltip("Sets the main light used as the sun in the scene.")]
        public Light mainLight;

        [StyledCategory("Season Settings")]
        public bool seasonCat;

        [Tooltip("Use the Seasons slider to control the element properties when the element is set to Seasons mode.")]
        [StyledRangeOptions("Season Control", 0, 4, new string[] { "Winter", "Spring", "Summer", "Autumn", "Winter" })]
        public float seasonControl = 2f;

        [StyledCategory("Global Settings")]
        public bool defaultCat;

        [StyledMessage("Info", "The global settings provide a free alternative to the elements which will create render textures, using up more memory! Perfect for shaders compiled without support for colors, extras or vertex elements!", 0, 10)]
        public bool styledMessage = true;

        [Tooltip("Controls the global tinting color. Color Alpha is used to multiply the material colors (Intensity = 0) or to replace the material colors (Intensity = 1).")]
        [ColorUsage(true, true)]
        public Color globalColor = new Color(0.5f, 0.5f, 0.5f, 0);
        [Tooltip("Controls the global alpha fading.")]
        [Range(0.0f, 1.0f)]
        public float globalAlpha = 1.0f;
        [Tooltip("Controls the global overlay intensity.")]
        [Range(0.0f, 1.0f)]
        public float globalOverlay = 0.0f;
        [Tooltip("Controls the smoothness on vegetation and props for a wet look.")]
        [Range(0.0f, 1.0f)]
        public float globalWetness = 0.0f;
        [Tooltip("Controls the global emissive intensity.")]
        [Range(0.0f, 1.0f)]
        public float globalEmissive = 1;
        [Tooltip("Controls the global subsurface intensity.")]
        [Range(0.0f, 1.0f)]
        public float globalSubsurface = 1;
        [Tooltip("Controls the global size value.")]
        [Range(0.0f, 1.0f)]
        public float globalSizeFade = 1.0f;

        [StyledCategory("Overlay Settings")]
        public bool overlayCat;

        [StyledMessage("Info", "The overlay texures are disabled for the built-in shaders. They will only be used for shaders compiled with the Overlay Quality option set to Complex on the Amplify Base function!", 0, 0)]
        public bool overlayMessage = true;

        [Space(10)]
        [Tooltip("Controls the global overlay color.")]
        [ColorUsage(false, true)]
        public Color overlayColor = Color.white;
        [Tooltip("Controls the global overlay smoothness.")]
        [Range(0.0f, 1.0f)]
        public float overlaySmoothness = 0.5f;
        [Tooltip("Controls the global overlay normal intensity.")]
        [Range(0.0f, 1.0f)]
        public float overlayNormalScale = 0.5f;

        [Space(10)]
        [Tooltip("Sets the global overlay albedo texture.")]
        public Texture2D overlayAlbedo;
        [Tooltip("Sets the global overlay normal texture.")]
        public Texture2D overlayNormal;
        [Tooltip("Controls the global overlay albedo and normal texture tilling.")]
        public float overlayTilling = 1.0f;

        [StyledCategory("Wetness Settings")]
        public bool wetnessCat;

        [Tooltip("Controls the global wetness albedo contrast.")]
        [Range(0.0f, 1.0f)]
        public float wetnessContrast = 0.5f;
        [Tooltip("Controls the global wetness normal intensity.")]
        [Range(0.0f, 1.0f)]
        public float wetnessNormalScale = 0.5f;

        [StyledCategory("Noise Settings")]
        public bool noiseCat;

        [Tooltip("Sets the global world space 3D noise texture used for material noise settings.")]
        private Texture3D worldNoiseTexture;

        [Tooltip("Sets the global 3D noise texture used for camera distance and glancing angle fade.")]
        public Texture3D noiseTexture3D;
        [Tooltip("Controls the global 3D noise texture scale used for camera distance and glancing angle fade.")]
        public float noiseTextureTilling = 1.0f;

        [StyledCategory("Fade Settings")]
        public bool fadeCat;

        [Tooltip("Controls the Camera fade distance in world units.")]
        public float cameraFadeDistance = 0.0f;
        [Tooltip("Controls the Size Fade paramters on the materials. With higher values, the fade will happen at a greater distance.")]
        public float sizeFadeDistanceBias = 1.0f;


        [StyledSpace(10)]
        public bool styledSpace0;

        void Start()
        {
            gameObject.name = "Global Control";
            gameObject.transform.SetSiblingIndex(2);

            if (mainLight == null)
            {
                SetGlobalLightingMainLight();
            }

            if (worldNoiseTexture == null)
            {
                worldNoiseTexture = CreateNoiseTexture("Internal WorldTex3D");
            }

            if (noiseTexture3D == null)
            {
                noiseTexture3D = CreateNoiseTexture("Internal NoiseTex3D");
            }

            SetGlobalShaderProperties();
        }

        void Update()
        {
            SetGlobalShaderProperties();
        }

        void SetGlobalShaderProperties()
        {
            if (mainLight != null)
            {
                var mainLightColor = mainLight.color.linear;
                var mainLightValue = new Color(mainLight.intensity, mainLight.intensity, mainLight.intensity).linear;
                var mainLightParams = new Color(mainLightColor.r, mainLightColor.g, mainLightColor.b, mainLightValue.r);

                Shader.SetGlobalVector("TVE_MainLightParams", mainLightParams);
                Shader.SetGlobalVector("TVE_MainLightDirection", Vector4.Normalize(-mainLight.transform.forward));
            }
            else
            {
                var mainLightParams = new Vector4(1, 1, 1, 1);

                Shader.SetGlobalVector("TVE_MainLightParams", mainLightParams);
                Shader.SetGlobalVector("TVE_MainLightDirection", new Vector4(0, 1, 0, 0));
            }

            float seasonLerp = 0;

            if (seasonControl >= 0 && seasonControl < 1)
            {
                seasonLerp = seasonControl;
                Shader.SetGlobalVector("TVE_SeasonOptions", new Vector4(1, 0, 0, 0));
            }
            else if (seasonControl >= 1 && seasonControl < 2)
            {
                seasonLerp = seasonControl - 1.0f;
                Shader.SetGlobalVector("TVE_SeasonOptions", new Vector4(0, 1, 0, 0));
            }
            else if (seasonControl >= 2 && seasonControl < 3)
            {
                seasonLerp = seasonControl - 2.0f;
                Shader.SetGlobalVector("TVE_SeasonOptions", new Vector4(0, 0, 1, 0));
            }
            else if (seasonControl >= 3 && seasonControl <= 4)
            {
                seasonLerp = seasonControl - 3.0f;
                Shader.SetGlobalVector("TVE_SeasonOptions", new Vector4(0, 0, 0, 1));
            }

            var smoothLerp = Mathf.SmoothStep(0, 1, seasonLerp);
            Shader.SetGlobalFloat("TVE_SeasonLerp", smoothLerp);

            if (QualitySettings.activeColorSpace == ColorSpace.Linear)
            {
                Shader.SetGlobalVector("TVE_ColorsParams", globalColor.linear);
            }
            else
            {
                Shader.SetGlobalVector("TVE_ColorsParams", globalColor);
            }

            Shader.SetGlobalFloat("TVE_OverlayValue", globalOverlay);
            Shader.SetGlobalFloat("TVE_WetnessValue", globalWetness);
            Shader.SetGlobalFloat("TVE_EmissiveValue", globalEmissive);
            Shader.SetGlobalFloat("TVE_AlphaValue", globalAlpha);
            Shader.SetGlobalFloat("TVE_SubsurfaceValue", globalSubsurface);
            Shader.SetGlobalFloat("TVE_SizeValue", globalSizeFade);

            Shader.SetGlobalColor("TVE_OverlayColor", overlayColor);
            Shader.SetGlobalTexture("TVE_OverlayAlbedoTex", overlayAlbedo);
            Shader.SetGlobalTexture("TVE_OverlayNormalTex", overlayNormal);
            Shader.SetGlobalFloat("TVE_OverlayTilling", overlayTilling);
            Shader.SetGlobalFloat("TVE_OverlayNormalValue", overlayNormalScale);
            Shader.SetGlobalFloat("TVE_OverlaySmoothness", overlaySmoothness);

            Shader.SetGlobalFloat("TVE_WetnessContrast", wetnessContrast);
            Shader.SetGlobalFloat("TVE_WetnessNormalValue", wetnessNormalScale);

            var extras = new Color(globalEmissive, globalWetness, globalOverlay, globalAlpha);
            Shader.SetGlobalVector("TVE_ExtrasParams", extras);

            var vertex = new Vector4(0.0f, 0.0f, 0.0f, globalSizeFade);
            Shader.SetGlobalVector("TVE_VertexParams", vertex);

            Shader.SetGlobalTexture("TVE_WorldTex3D", worldNoiseTexture);
            Shader.SetGlobalTexture("TVE_NoiseTex3D", noiseTexture3D);
            Shader.SetGlobalFloat("TVE_NoiseTex3DTilling", noiseTextureTilling);

            Shader.SetGlobalFloat("TVE_DistanceFadeBias", sizeFadeDistanceBias + 0.01f);
            Shader.SetGlobalFloat("TVE_CameraFadeMin", (cameraFadeDistance + 0.01f) * 0.5f);
            Shader.SetGlobalFloat("TVE_CameraFadeMax", cameraFadeDistance + 0.01f);
        }

        void SetGlobalLightingMainLight()
        {
            var allLights = FindObjectsOfType<Light>();
            var intensity = 0.0f;

            for (int i = 0; i < allLights.Length; i++)
            {
                if (allLights[i].type == LightType.Directional)
                {
                    if (allLights[i].intensity > intensity)
                    {
                        mainLight = allLights[i];
                    }
                }
            }
        }

        Texture3D CreateNoiseTexture(string name)
        {
            int size = 16;

            Texture3D texture = new Texture3D(size, size, size, TextureFormat.R8, false);
            texture.wrapMode = TextureWrapMode.Repeat;
            texture.name = name;

            Color32[] colors = new Color32[size * size * size];

            for (int z = 0; z < size; z++)
            {
                int zOffset = z * size * size;
                for (int y = 0; y < size; y++)
                {
                    int yOffset = y * size;
                    for (int x = 0; x < size; x++)
                    {
                        colors[x + yOffset + zOffset] = new Color(Random.Range(0f, 1f), 0, 0);
                    }
                }
            }

            texture.SetPixels32(colors);
            texture.Apply();

            return texture;
        }
    }
}

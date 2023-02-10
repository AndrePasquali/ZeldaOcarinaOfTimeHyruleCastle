// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.StyledGUI;
using Boxophobic.Utils;
using System;
using System.IO;
using System.Linq;
using System.Globalization;

namespace TheVegetationEngine
{
    public class TVEMaterialManager : EditorWindow
    {
        const int GUI_SMALL_WIDTH = 50;
        const int GUI_HEIGHT = 18;
        const int GUI_SELECTION_HEIGHT = 24;
        float GUI_HALF_EDITOR_WIDTH = 200;

        string[] materialOptions = new string[]
        {
        "All", "Render Settings", "Global Settings", "Main Settings", "Detail Settings", "Occlusion Settings", "Gradient Settings", "Noise Settings", "Subsurface Settings", "Emissive Settings", "Perspective Settings", "Size Fade Settings", "Motion Settings",
        };

        string[] savingOptions = new string[]
        {
        "Save All Settings", "Save Current Settings",
        };

        List<TVEMaterialData> materialData = new List<TVEMaterialData>
        {

        };

        List<TVEMaterialData> saveData = new List<TVEMaterialData>
        {

        };

        List<TVEMaterialData> renderSettings = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryRender", "Render Settings"),

            new TVEMaterialData("_RenderMode", "Render Mode", -9999, "Opaque 0 Transparent 1", false),
            new TVEMaterialData("_RenderCull", "Render Faces", -9999, "Both 0 Back 1 Front 2", false),
            new TVEMaterialData("_RenderNormals", "Render Normals", -9999, "Flip 0 Mirror 1 Same 2", false),
            new TVEMaterialData("_RenderSpecular", "Render Specular", -9999, "Off 0 On 1", false),

            new TVEMaterialData("_RenderDirect", "Render Direct", -9999, 0, 1, false, true),
            new TVEMaterialData("_RenderShadow", "Render Shadow", -9999, 0, 1, false, false),
            new TVEMaterialData("_RenderAmbient", "Render Ambient", -9999, 0, 1, false, false),

            new TVEMaterialData("_RenderClip", "Alpha Clipping", -9999, "Off 0 On 1", true),
            new TVEMaterialData("_RenderCoverage", "Alpha To Mask", -9999, "Off 0 On 1", false),
            new TVEMaterialData("_AlphaClipValue", "Alpha Treshold", -9999, 0, 1, false, false),
            new TVEMaterialData("_AlphaFeatherValue", "Alpha Feather", -9999, 0, 2, false, false),

            new TVEMaterialData("_SpaceRenderFade"),

            new TVEMaterialData("_FadeConstantValue", "Fade Constant Value", -9999, 0, 1, false, false),
            new TVEMaterialData("_FadeVerticalValue", "Fade Vertical Angle", -9999, 0, 1, false, false),
            new TVEMaterialData("_FadeHorizontalValue", "Fade Horizontal Angle", -9999, 0, 1, false, false),
            new TVEMaterialData("_FadeGlancingValue", "Fade Glancing Angle", -9999, 0, 1, false, false),
            new TVEMaterialData("_FadeCameraValue", "Fade Camera Distance", -9999, 0, 1, false, false),
        };

        List<TVEMaterialData> globalData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryGlobals", "Global Settings"),

            new TVEMaterialData("_MessageGlobalsVariation", "Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another.", 0, 10, MessageType.Info),

            new TVEMaterialData("_LayerColorsValue", "Layer Colors", -9999, "TVELayers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEMaterialData("_LayerExtrasValue", "Layer Extras", -9999, "TVELayers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEMaterialData("_LayerMotionValue", "Layer Motion", -9999, "TVELayers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),
            new TVEMaterialData("_LayerVertexValue", "Layer Vertex", -9999, "TVELayers", "Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 8 Layer_8 8", false),

            new TVEMaterialData("_SpaceGlobalLayers"),

            new TVEMaterialData("_GlobalColors", "Global Color", -9999, 0, 1, false, false),
            new TVEMaterialData("_GlobalAlpha", "Global Alpha", -9999, 0, 1, false, false),
            new TVEMaterialData("_GlobalOverlay", "Global Overlay", -9999, 0, 1, false, false),
            new TVEMaterialData("_GlobalWetness", "Global Wetness", -9999, 0, 1, false, false),
            new TVEMaterialData("_GlobalEmissive", "Global Emissive", -9999, 0, 1, false, false),
            new TVEMaterialData("_GlobalSize", "Global Size Fade", -9999, 0, 1, false, false),

            new TVEMaterialData("_SpaceGlobalLocals"),

            new TVEMaterialData("_ColorsVariationValue", "Color Variation", -9999, 0, 1, false, false),
            new TVEMaterialData("_AlphaVariationValue", "Alpha Variation", -9999, 0, 1, false, false),
            new TVEMaterialData("_OverlayVariationValue", "Overlay Variation", -9999, 0, 1, false, false),

            new TVEMaterialData("_SpaceGlobalOptions"),

            new TVEMaterialData("_ColorsPositionMode", "Use Pivot Position for Colors", -9999, false),
            new TVEMaterialData("_ExtrasPositionMode", "Use Pivot Position for Extras", -9999, false),
        };

        List<TVEMaterialData> mainData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryMain", "Main Settings"),

            new TVEMaterialData("_MessageMainMask", "Use the Main Mask remap sliders to control the mask for Global Color, Gradient Tinting and Subsurface Effect. The mask is stored in Main Mask Blue channel.", 0, 10, MessageType.Info),

            new TVEMaterialData("_MainUVs", "Main UVs", new Vector4(-9999, 0,0,0), false),
            new TVEMaterialData("_MainColor", "Main Color", new Color(-9999, 0,0,0), true, true),
            new TVEMaterialData("_MainNormalValue", "Main Normal", -9999, -8, 8, false, false),
            new TVEMaterialData("_MainMetallicValue", "Main Metallic", -9999, 0, 1, false, false),
            new TVEMaterialData("_MainOcclusionValue", "Main Occlusion", -9999, 0, 1, false, false),
            new TVEMaterialData("_MainSmoothnessValue", "Main Smoothness", -9999, 0, 1, false, false),
            new TVEMaterialData("_MainMaskMinValue", "Main Mask Min", -9999, 0, 1, false, false),
            new TVEMaterialData("_MainMaskMaxValue", "Main Mask Max", -9999, 0, 1, false, false),
        };

        List<TVEMaterialData> secondData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryDetail", "Detail Settings"),

            new TVEMaterialData("_MessageSecondMask", "Use the Detail Mask remap sliders to control the mask for Global Color, Gradient Tinting and Subsurface Effect. The mask is stored in Detail Mask Blue channel.", 0, 10, MessageType.Info),

            new TVEMaterialData("_DetailMode", "Detail Mode", -9999, "Off 0 On 1", false),
            new TVEMaterialData("_DetailBlendMode", "Detail Blend", -9999, "Replace 0 Overlay 1", false),
            new TVEMaterialData("_DetailTypeMode", "Detail Type", -9999, "Vertex_Blue 0 Projection 1", false),
            new TVEMaterialData("_DetailCoordMode", "Detail Coord", -9999, "UV_0 0 Baked 1", false),
            new TVEMaterialData("_DetailOpaqueMode", "Detail Opaque", -9999, "Off 0 On 1", false),

            new TVEMaterialData("_SecondUVs", "Detail UVs", new Vector4(-9999, 0,0,0), true),
            new TVEMaterialData("_SecondColor", "Detail Color", new Color(-9999, 0,0,0), true, true),
            new TVEMaterialData("_SecondNormalValue", "Detail Normal", -9999, -8, 8, false, false),
            new TVEMaterialData("_SecondMetallicValue", "Detail Metallic", -9999, 0, 1, false, false),
            new TVEMaterialData("_SecondOcclusionValue", "Detail Occlusion", -9999, 0, 1, false, false),
            new TVEMaterialData("_SecondSmoothnessValue", "Detail Smoothness", -9999, 0, 1, false, false),
            new TVEMaterialData("_SecondMaskMinValue", "Detail Mask Min", -9999, 0, 1, false, false),
            new TVEMaterialData("_SecondMaskMaxValue", "Detail Mask Max", -9999, 0, 1, false, false),

            new TVEMaterialData("_DetailNormalValue", "Detail Blend Normals", -9999, 0, 1, false, true),

            new TVEMaterialData("_DetailMaskMode", "Detail Mask Mode", -9999, "Main_Mask 0 Detail_Mask 1", true),
            new TVEMaterialData("_DetailMaskInvertMode", "Detail Mask Invert", -9999, "Off 0 On 1", false),
            new TVEMaterialData("_DetailMeshValue", "Detail Mesh Offset", -9999, -1, 1, false, false),
            new TVEMaterialData("_DetailBlendMinValue", "Detail Blend Min", -9999, 0, 1, false, false),
            new TVEMaterialData("_DetailBlendMaxValue", "Detail Blend Max", -9999, 0, 1, false, false),
        };

        List<TVEMaterialData> occlusionData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryOcclusion", "Occlusion Settings"),

            new TVEMaterialData("_MessageOcclusion", "Use the Occlusion Color for tinting and the Occlusion Alpha as Global Color and Global Overlay mask control. The mask is stored in Vertex Green channel.", 0, 10, MessageType.Info),

            new TVEMaterialData("_VertexOcclusionColor", "Occlusion Color", new Color(-9999, 0,0,0), true, false),
            new TVEMaterialData("_VertexOcclusionMinValue", "Occlusion Min", -9999, 0, 1, false, false),
            new TVEMaterialData("_VertexOcclusionMaxValue", "Occlusion Max", -9999, 0, 1, false, false),

            new TVEMaterialData("_ColorsMaskMode", "Use Inverted Mask for Colors", -9999, false),
        };

        List<TVEMaterialData> gradientData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryGradient", "Gradient Settings"),

            new TVEMaterialData("_GradientColorOne", "Gradient Color One", new Color(-9999, 0,0,0), true, false),
            new TVEMaterialData("_GradientColorTwo", "Gradient Color Two", new Color(-9999, 0,0,0), true, false),
            new TVEMaterialData("_GradientMinValue", "Gradient Mask Min", -9999, 0, 1, false, false),
            new TVEMaterialData("_GradientMaxValue", "Gradient Mask Max", -9999, 0, 1, false, false),
        };

        List<TVEMaterialData> noiseData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryNoise", "Noise Settings"),

            new TVEMaterialData("_NoiseColorOne", "Noise Color One", new Color(-9999, 0,0,0), true, true),
            new TVEMaterialData("_NoiseColorTwo", "Noise Color Two", new Color(-9999, 0,0,0), true, false),
            new TVEMaterialData("_NoiseMinValue", "Noise Min", -9999, 0, 1, false, false),
            new TVEMaterialData("_NoiseMaxValue", "Noise Max", -9999, 0, 1, false, false),
            new TVEMaterialData("_NoiseScaleValue", "Noise Scale", -9999, 0, 10, false, false),
        };

        List<TVEMaterialData> subsurfaceData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategorySubsurface", "Subsurface Settings"),

            new TVEMaterialData("_MessageSubsurface", "In HDRP, the Subsurface Color and Power are fake effects used for artistic control. For physically correct subsurface scattering the Power slider need to be set to 0.", 0, 10, MessageType.Info),

            new TVEMaterialData("_SubsurfaceValue", "Subsurface Intensity", -9999, 0, 1, false, false),
            new TVEMaterialData("_SubsurfaceColor", "Subsurface Color", new Color(-9999, 0,0,0), true, false),
            new TVEMaterialData("_SubsurfaceScatteringValue", "Subsurface Power", -9999, 0, 16, false, false),
            new TVEMaterialData("_SubsurfaceAngleValue", "Subsurface Angle", -9999, 1, 16, false, false),
            new TVEMaterialData("_SubsurfaceNormalValue", "Subsurface Normal", -9999, 0, 1, false, false),
            new TVEMaterialData("_SubsurfaceDirectValue", "Subsurface Direct", -9999, 0, 1, false, false),
            new TVEMaterialData("_SubsurfaceAmbientValue", "Subsurface Ambient", -9999, 0, 1, false, false),
            new TVEMaterialData("_SubsurfaceShadowValue", "Subsurface Shadow", -9999, 0, 1, false, false),
        };

        List<TVEMaterialData> emissiveData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryEmissive", "Emissive Settings"),

            new TVEMaterialData("_EmissiveUVs", "Emissive UVs", new Vector4(-9999, 0,0,0), false),
            new TVEMaterialData("_EmissiveColor", "Emissive Color", new Color(-9999, 0,0,0), true, true),
        };

        List<TVEMaterialData> perspectiveSettings = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryPerspective", "Perspective Settings"),

            new TVEMaterialData("_PerspectivePushValue", "Perspective Push", -9999, 0, 4, false, false),
            new TVEMaterialData("_PerspectiveNoiseValue", "Perspective Noise", -9999, 0, 4, false, false),
            new TVEMaterialData("_PerspectiveAngleValue", "Perspective Angle", -9999, 0, 8, false, false),
        };

        List<TVEMaterialData> sizeFadeData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategorySizeFade", "Size Fade Settings"),

            new TVEMaterialData("_SizeFadeStartValue", "Size Fade Start", -9999, 0, 1000, false, false),
            new TVEMaterialData("_SizeFadeEndValue", "Size Fade End", -9999, 0, 1000, false, false),
        };

        List<TVEMaterialData> motionData = new List<TVEMaterialData>
        {
            new TVEMaterialData("_CategoryMotion", "Motion Settings"),

            new TVEMaterialData("_MessageMotionVariation", "Procedural variation in use. Use the Scale settings if the Variation is splitting the mesh.", 0, 10, MessageType.Info),

            new TVEMaterialData("_MotionHighlightColor", "Motion Highlight Color", new Color(-9999, 0,0,0), true, false),
            new TVEMaterialData("_MotionFacingValue", "Motion Directional Mask", -9999, 0, 1, false, false),
            new TVEMaterialData("_MotionObjectVariation", "Motion Object Variation", -9999, 0, 1, false, false),

            new TVEMaterialData("_MotionAmplitude_10", "Motion Bending", -9999, 0, 2, false, true),
            new TVEMaterialData("_MotionSpeed_10", "Motion Speed", -9999, 0, 40, true, false),
            new TVEMaterialData("_MotionScale_10", "Motion Scale", -9999, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_10", "Motion Variation", -9999, 0, 20, false, false),

            new TVEMaterialData("_MotionAmplitude_20", "Motion Squash", -9999, 0, 2, false, true),
            new TVEMaterialData("_MotionAmplitude_22", "Motion Rolling", -9999, 0, 2, false, false),
            new TVEMaterialData("_MotionSpeed_20", "Motion Speed", -9999, 0, 40, true, false),
            new TVEMaterialData("_MotionScale_20", "Motion Scale", -9999, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_20", "Motion Variation", -9999, 0, 20, false, false),

            new TVEMaterialData("_MotionAmplitude_32", "Motion Flutter", -9999, 0, 2, false, true),
            new TVEMaterialData("_MotionSpeed_32", "Motion Speed", -9999, 0, 40, true, false),
            new TVEMaterialData("_MotionScale_32", "Motion Scale", -9999, 0, 20, false, false),
            new TVEMaterialData("_MotionVariation_32", "Motion Variation", -9999, 0, 20, false, false),

            new TVEMaterialData("_InteractionAmplitude", "Interaction Amplitude", -9999, 0, 2, false, true),
            new TVEMaterialData("_InteractionMaskValue", "Interaction Use Mask", -9999, 0, 1, false, false),

            new TVEMaterialData("_SpaceMotionLocals"),

            new TVEMaterialData("_MotionValue_20", "Use Branch Motion Settings", -9999, false),
            new TVEMaterialData("_MotionValue_30", "Use Flutter Motion Settings", -9999, false),
        };

        List<GameObject> selectedObjects = new List<GameObject>();
        List<Material> selectedMaterials = new List<Material>();

        string[] allPresetPaths;
        List<string> presetPaths;
        List<string> presetLines;
        string[] presetOptions;

        int presetIndex;
        int settingsIndex = 12;
        int settingsIndexOld = -1;
        int savingIndex = 1;
        string savePath = "";

        bool isValid = true;
        bool showSelection = true;

        bool useLine;
        List<bool> useLines;

        float windPower = 0.5f;
        TVEGlobalMotion globalMotion;
        Material dummyMaterial;

        string userFolder = "Assets/BOXOPHOBIC/User";

        GUIStyle stylePopup;
        GUIStyle styleCenteredHelpBox;

        Color bannerColor;
        string bannerText;
        static TVEMaterialManager window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine/Material Manager", false, 2001)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEMaterialManager>(false, "Material Manager", true);
            window.minSize = new Vector2(389, 300);
        }

        void OnEnable()
        {
            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Material Manager";

            if (TVEManager.Instance == null)
            {
                isValid = false;
            }

            OverrideWind();

            materialData = new List<TVEMaterialData>();
            materialData.AddRange(renderSettings);
            materialData.AddRange(globalData);
            materialData.AddRange(mainData);
            materialData.AddRange(secondData);
            materialData.AddRange(occlusionData);
            materialData.AddRange(gradientData);
            materialData.AddRange(noiseData);
            materialData.AddRange(subsurfaceData);
            materialData.AddRange(emissiveData);
            materialData.AddRange(perspectiveSettings);
            materialData.AddRange(sizeFadeData);
            materialData.AddRange(motionData);

            GetPresets();
            GetPresetOptions();

            string[] searchFolders = AssetDatabase.FindAssets("User");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("User.pdf"))
                {
                    userFolder = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                    userFolder = userFolder.Replace("/User.pdf", "");
                    userFolder += "/The Vegetation Engine/";
                }
            }

            settingsIndex = Convert.ToInt16(SettingsUtils.LoadSettingsData(userFolder + "Material Settings.asset", "12"));
        }

        void OnSelectionChange()
        {
            Initialize();
            Repaint();
        }

        void OnFocus()
        {
            Initialize();
            Repaint();
            OverrideWind();
        }

        void OnLostFocus()
        {
            ResetWind();
        }

        void OnDisable()
        {
            ResetWind();
        }

        void OnDestroy()
        {
            ResetWind();
        }

        void OnGUI()
        {
            SetGUIStyles();

            GUI_HALF_EDITOR_WIDTH = this.position.width / 2.0f - 24;

            StyledGUI.DrawWindowBanner(bannerColor, bannerText);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            if (isValid && selectedMaterials.Count > 0)
            {
                EditorGUILayout.HelpBox("The Material Manager tool allows to set the same values to all selected material. Please note that Undo is not supported for the Material Manager window!", MessageType.Info, true);
            }
            else
            {
                if (isValid == false)
                {
                    GUILayout.Button("\n<size=14>The Vegetation Engine manager is missing from your scene!</size>\n", styleCenteredHelpBox);

                    GUILayout.Space(10);

                    if (GUILayout.Button("Create Scene Manager", GUILayout.Height(24)))
                    {
                        if (GameObject.Find("The Vegetation Engine") != null)
                        {
                            Debug.Log("<b>[The Vegetation Engine]</b> " + "The Vegetation Engine Manager is already set in your scene!");
                            isValid = true;
                            return;
                        }

                        GameObject manager = new GameObject();
                        manager.AddComponent<TVEManager>();
                        manager.name = "The Vegetation Engine";

                        UnityEditor.SceneManagement.EditorSceneManager.MarkSceneDirty(UnityEditor.SceneManagement.EditorSceneManager.GetActiveScene());

                        Debug.Log("<b>[The Vegetation Engine]</b> " + "The Vegetation Engine is set in the current scene!");

                        isValid = true;
                    }
                }
                else if (selectedMaterials.Count == 0)
                {
                    GUILayout.Button("\n<size=14>Select one or multiple gameobjects or materials to get started!</size>\n", styleCenteredHelpBox);
                }
            }

            if (isValid == false || selectedMaterials.Count == 0)
            {
                GUI.enabled = false;
            }

            DrawWindPower();
            SetGlobalShaderProperties();

            if (selectedMaterials.Count > 0)
            {
                GUILayout.Space(5);
            }

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false, GUILayout.Width(this.position.width - 28), GUILayout.Height(this.position.height - 180));

            DrawMaterials();

            GUILayout.Space(10);

            presetIndex = StyledPopup("Material Preset", presetIndex, presetOptions);

            if (presetIndex > 0)
            {
                if (presetIndex != presetOptions.Length - 1)
                {
                    GetPresetLines();

                    for (int i = 0; i < selectedMaterials.Count; i++)
                    {
                        var material = selectedMaterials[i];

                        GetMaterialConversionFromPreset(material);
                        TVEUtils.SetMaterialSettings(material);
                    }

                    materialData = new List<TVEMaterialData>();
                    materialData.AddRange(renderSettings);
                    materialData.AddRange(globalData);
                    materialData.AddRange(mainData);
                    materialData.AddRange(secondData);
                    materialData.AddRange(occlusionData);
                    materialData.AddRange(gradientData);
                    materialData.AddRange(noiseData);
                    materialData.AddRange(subsurfaceData);
                    materialData.AddRange(emissiveData);
                    materialData.AddRange(perspectiveSettings);
                    materialData.AddRange(sizeFadeData);
                    materialData.AddRange(motionData);

                    GetMaterialProperties();

                    presetIndex = 0;
                    settingsIndexOld = -1;

                    Debug.Log("<b>[The Vegetation Engine]</b> " + "The selected preset has been applied!");
                }
                else
                {
                    ValidateAllProjectMaterials();

                    Debug.Log("<b>[The Vegetation Engine]</b> " + "All project materials have been updated!");

                    presetIndex = 0;
                    settingsIndexOld = -1;
                }
            }

            EditorGUI.BeginChangeCheck();

            settingsIndex = StyledPopup("Material Settings", settingsIndex, materialOptions);

            if (EditorGUI.EndChangeCheck())
            {
#if !THE_VEGETATION_ENGINE_DEVELOPMENT

                SettingsUtils.SaveSettingsData(userFolder + "Material Settings.asset", settingsIndex);
#endif
            }

            if (settingsIndexOld != settingsIndex)
            {
                materialData = new List<TVEMaterialData>();

                if (settingsIndex == 0)
                {
                    materialData.AddRange(renderSettings);
                    materialData.AddRange(globalData);
                    materialData.AddRange(mainData);
                    materialData.AddRange(secondData);
                    materialData.AddRange(occlusionData);
                    materialData.AddRange(gradientData);
                    materialData.AddRange(noiseData);
                    materialData.AddRange(subsurfaceData);
                    materialData.AddRange(emissiveData);
                    materialData.AddRange(perspectiveSettings);
                    materialData.AddRange(sizeFadeData);
                    materialData.AddRange(motionData);
                }
                else if (settingsIndex == 1)
                {
                    materialData = renderSettings;
                }
                else if (settingsIndex == 2)
                {
                    materialData = globalData;
                }
                else if (settingsIndex == 3)
                {
                    materialData = mainData;
                }
                else if (settingsIndex == 4)
                {
                    materialData = secondData;
                }
                else if (settingsIndex == 5)
                {
                    materialData = occlusionData;
                }
                else if (settingsIndex == 6)
                {
                    materialData = emissiveData;
                }
                else if (settingsIndex == 7)
                {
                    materialData = subsurfaceData;
                }
                else if (settingsIndex == 8)
                {
                    materialData = gradientData;
                }
                else if (settingsIndex == 9)
                {
                    materialData = noiseData;
                }
                else if (settingsIndex == 10)
                {
                    materialData = perspectiveSettings;
                }
                else if (settingsIndex == 11)
                {
                    materialData = sizeFadeData;
                }
                else if (settingsIndex == 12)
                {
                    materialData = motionData;
                }

                settingsIndexOld = settingsIndex;
            }

            for (int i = 0; i < materialData.Count; i++)
            {
                if (materialData[i].type == TVEMaterialData.PropertyType.Range)
                {
                    materialData[i].value = StyledSlider(materialData[i].name, materialData[i].value, materialData[i].min, materialData[i].max, materialData[i].snap, materialData[i].space);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Vector)
                {
                    materialData[i].vector = StyledVector(materialData[i].name, materialData[i].vector, materialData[i].space);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Color)
                {
                    materialData[i].vector = StyledColor(materialData[i].name, materialData[i].vector, materialData[i].hdr, materialData[i].space);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Enum)
                {
                    materialData[i].value = StyledEnum(materialData[i].name, materialData[i].value, materialData[i].file, materialData[i].options, materialData[i].space);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Toggle)
                {
                    materialData[i].value = StyledToggle(materialData[i].name, materialData[i].value, materialData[i].space);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Space)
                {
                    StyledSpace(materialData[i].name, materialData[i].value);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Category)
                {
                    StyledCategory(materialData[i].name, materialData[i].value, materialData[i].category);
                }
                else if (materialData[i].type == TVEMaterialData.PropertyType.Message)
                {
                    StyledMessage(materialData[i].name, materialData[i].value, materialData[i].message, materialData[i].spaceTop, materialData[i].spaceDown, materialData[i].messageType);
                }
            }

            GUILayout.Space(20);

            SavePreset();

            SetMaterialProperties();

            GUILayout.EndScrollView();

            GUILayout.EndVertical();

            GUILayout.Space(13);
            GUILayout.EndHorizontal();
        }

        void SetGUIStyles()
        {
            stylePopup = new GUIStyle(EditorStyles.popup)
            {
                alignment = TextAnchor.MiddleCenter
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void DrawWindPower()
        {
            GUIStyle styleMid = new GUIStyle();
            styleMid.alignment = TextAnchor.MiddleCenter;
            styleMid.normal.textColor = Color.gray;
            styleMid.fontSize = 7;

            GUILayout.Space(10);

            //GUILayout.Label("Wind Power (for testing only)");

            GUILayout.BeginHorizontal();
            GUILayout.Space(4);
            windPower = GUILayout.HorizontalSlider(windPower, 0.0f, 1.0f);

            GUILayout.Space(4);
            GUILayout.EndHorizontal();

            int maxWidth = 20;

            GUILayout.Space(15);

            GUILayout.BeginHorizontal();
            GUILayout.Space(2);
            GUILayout.Label("None", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Label("", styleMid);
            GUILayout.Label("Windy", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Label("", styleMid);
            GUILayout.Label("Strong", styleMid, GUILayout.Width(maxWidth));
            GUILayout.Space(7);
            GUILayout.EndHorizontal();
        }

        void DrawMaterials()
        {
            if (selectedMaterials.Count > 0)
            {
                GUILayout.Space(10);
            }

            if (showSelection)
            {
                if (StyledButton("Hide Material Selection"))
                    showSelection = !showSelection;
            }
            else
            {
                if (StyledButton("Show Material Selection"))
                    showSelection = !showSelection;
            }
            if (showSelection)
            {
                for (int i = 0; i < selectedMaterials.Count; i++)
                {
                    if (selectedMaterials[i] != null)
                    {
                        StyledMaterial(selectedMaterials[i]);
                    }
                }
            }
        }

        void StyledMaterial(Material material)
        {
            string color;
            bool useExternalSettings = true;

            if (EditorGUIUtility.isProSkin)
            {
                color = "<color=#87b8ff>";
            }
            else
            {
                color = "<color=#0b448b>";
            }

            if (material.GetTag("UseExternalSettings", false) == "False")
            {
                color = "<color=#808080>";
            }

            GUILayout.Label("<size=10><b>" + color + material.name.Replace(" (TVE Material)", "") + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            var lastRect = GUILayoutUtility.GetLastRect();

            var buttonRect = new Rect(lastRect.x, lastRect.y, lastRect.width - 24, lastRect.height);

            if (GUI.Button(buttonRect, "", GUIStyle.none))
            {
                EditorGUIUtility.PingObject(material);
            }

            var toogleRect = new Rect(lastRect.width - 16, lastRect.y + 6, 12, 12);

            if (material.GetTag("UseExternalSettings", false) == "False")
            {
                useExternalSettings = false;
            }

            EditorGUI.BeginChangeCheck();

            useExternalSettings = EditorGUI.Toggle(toogleRect, useExternalSettings);
            GUI.Label(toogleRect, new GUIContent("", "Should the Prefab Settings tool affect the material?"));

            if (useExternalSettings)
            {
                material.SetOverrideTag("UseExternalSettings", "True");
            }
            else
            {
                material.SetOverrideTag("UseExternalSettings", "False");
            }

            if (EditorGUI.EndChangeCheck())
            {
                ResetMaterialData();
                InitCustomMaterials();
                GetMaterialProperties();
            }
        }

        int StyledPopup(string name, int index, string[] options)
        {
            if (index > options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(name, GUILayout.Width(GUI_HALF_EDITOR_WIDTH));
            index = EditorGUILayout.Popup(index, options, stylePopup, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
            GUILayout.EndHorizontal();

            return index;
        }

        float StyledValue(string name, float val, bool snap, bool space)
        {
            if (val == -9999)
            {
                return val;
            }
            else
            {
                if (space)
                {
                    GUILayout.Space(10);
                }

                GUILayout.BeginHorizontal();

                float equalValue = val;
                float mixedValue = 0;

                if (val == -8888)
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    EditorGUI.showMixedValue = true;

                    mixedValue = EditorGUILayout.FloatField(mixedValue);

                    if (mixedValue != 0)
                    {
                        val = mixedValue;
                    }

                    float floatVal = EditorGUILayout.FloatField(val, GUILayout.MaxWidth(GUI_SMALL_WIDTH));

                    if (val != floatVal)
                    {
                        val = floatVal;
                    }

                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    equalValue = EditorGUILayout.FloatField(equalValue);

                    val = equalValue;

                    float floatVal = EditorGUILayout.FloatField(val, GUILayout.MaxWidth(GUI_SMALL_WIDTH));

                    if (val != floatVal)
                    {
                        val = floatVal;
                    }
                }

                GUILayout.EndHorizontal();

                if (snap)
                {
                    val = Mathf.Round(val);
                }
                else
                {
                    val = Mathf.Round(val * 1000f) / 1000f;
                }

                return val;
            }
        }

        float StyledSlider(string name, float val, float min, float max, bool snap, bool space)
        {
            if (val == -9999)
            {
                return val;
            }
            else
            {
                if (space)
                {
                    GUILayout.Space(10);
                }

                GUILayout.BeginHorizontal();

                float equalValue = val;
                float mixedValue = 0;

                if (val == -8888)
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    EditorGUI.showMixedValue = true;

                    mixedValue = GUILayout.HorizontalSlider(mixedValue, min, max);

                    if (mixedValue != 0)
                    {
                        val = mixedValue;
                    }

                    float floatVal = EditorGUILayout.FloatField(val, GUILayout.MaxWidth(GUI_SMALL_WIDTH));

                    if (val != floatVal)
                    {
                        val = Mathf.Clamp(floatVal, min, max);
                    }

                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    equalValue = GUILayout.HorizontalSlider(equalValue, min, max);

                    val = equalValue;

                    float floatVal = EditorGUILayout.FloatField(val, GUILayout.MaxWidth(GUI_SMALL_WIDTH));

                    if (val != floatVal)
                    {
                        val = Mathf.Clamp(floatVal, min, max);
                    }
                }

                GUILayout.EndHorizontal();

                if (snap)
                {
                    val = Mathf.Round(val);
                }
                else
                {
                    val = Mathf.Round(val * 1000f) / 1000f;
                }

                return val;
            }
        }

        Vector4 StyledVector(string name, Vector4 vector, bool space)
        {
            if (vector.x == -9999)
            {
                return vector;
            }
            else
            {
                if (space)
                {
                    GUILayout.Space(10);
                }

                GUILayout.BeginHorizontal();

                if (vector.x == -8888)
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    EditorGUI.showMixedValue = true;
                    vector = EditorGUILayout.Vector4Field(new GUIContent(""), vector, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    vector = EditorGUILayout.Vector4Field(new GUIContent(""), vector, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                }

                GUILayout.EndHorizontal();

                return vector;
            }
        }

        Color StyledColor(string name, Color color, bool HDR, bool space)
        {
            if (color.r == -9999)
            {
                return color;
            }
            else
            {
                if (space)
                {
                    GUILayout.Space(10);
                }

                GUILayout.BeginHorizontal();

                if (color.r == -8888)
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    EditorGUI.showMixedValue = true;
                    color = EditorGUILayout.ColorField(new GUIContent(""), color, true, true, HDR, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    color = EditorGUILayout.ColorField(new GUIContent(""), color, true, true, HDR, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                }

                GUILayout.EndHorizontal();

                return color;
            }
        }

        float StyledEnum(string name, float value, string file, string options, bool space)
        {
            if (value == -9999)
            {
                return value;
            }
            else
            {
                if (space)
                {
                    GUILayout.Space(10);
                }

                GUILayout.BeginHorizontal();

                if (Resources.Load<TextAsset>(file) != null)
                {
                    var layersPath = AssetDatabase.GetAssetPath(Resources.Load<TextAsset>(file));

                    StreamReader reader = new StreamReader(layersPath);

                    options = reader.ReadLine();

                    reader.Close();
                }

                string[] enumSplit = options.Split(char.Parse(" "));
                List<string> enumOptions = new List<string>(enumSplit.Length / 2);
                List<int> enumIndices = new List<int>(enumSplit.Length / 2);

                for (int i = 0; i < enumSplit.Length; i++)
                {
                    if (i % 2 == 0)
                    {
                        enumOptions.Add(enumSplit[i].Replace("_", " "));
                    }
                    else
                    {
                        enumIndices.Add(int.Parse(enumSplit[i]));
                    }
                }

                int index = (int)value;
                int realIndex = enumIndices[0];

                for (int i = 0; i < enumIndices.Count; i++)
                {
                    if (enumIndices[i] == index)
                    {
                        realIndex = i;
                    }
                }

                if (value == -8888)
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    EditorGUI.showMixedValue = true;

                    value = EditorGUILayout.Popup(-8888, enumOptions.ToArray(), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));

                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    value = EditorGUILayout.Popup(realIndex, enumOptions.ToArray(), GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH - 5));
                }

                GUILayout.EndHorizontal();

                return value;
            }
        }

        float StyledToggle(string name, float val, bool space)
        {
            if (val == -9999)
            {
                return val;
            }
            else
            {
                if (space)
                {
                    GUILayout.Space(10);
                }

                GUILayout.BeginHorizontal();

                bool boolValue = false;

                if (val > 0.5f)
                {
                    boolValue = true;
                }

                if (val == -8888)
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    EditorGUI.showMixedValue = true;

                    EditorGUI.BeginChangeCheck();

                    boolValue = EditorGUILayout.Toggle(boolValue);

                    if (EditorGUI.EndChangeCheck())
                    {
                        if (boolValue)
                        {
                            val = 1;
                        }
                        else
                        {
                            val = 0;
                        }
                    }

                    EditorGUI.showMixedValue = false;
                }
                else
                {
                    GUILayout.Label(name, GUILayout.MaxWidth(GUI_HALF_EDITOR_WIDTH));

                    boolValue = EditorGUILayout.Toggle(boolValue);

                    if (boolValue)
                    {
                        val = 1;
                    }
                    else
                    {
                        val = 0;
                    }
                }

                GUILayout.EndHorizontal();

                return val;
            }
        }

        void StyledSpace(string name, float val)
        {
            if (val != -9999)
            {
                GUILayout.Space(10);
            }
        }

        void StyledCategory(string name, float val, string category)
        {
            if (val != -9999)
            {
                GUILayout.Space(10);
                StyledGUI.DrawWindowCategory(category);
                GUILayout.Space(10);
            }
        }

        void StyledMessage(string name, float val, string message, int spaceTop, int spaceDown, MessageType messageType)
        {
            if (val != -9999)
            {
                GUILayout.Space(spaceTop);
                EditorGUILayout.HelpBox(message, messageType, true);
                GUILayout.Space(spaceDown);
            }
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            return value;
        }

        void Initialize()
        {
            ResetMaterialData();
            GetSelectedObjects();
            GetPrefabMaterials();
            InitCustomMaterials();
            GetMaterialProperties();
        }

        void ResetMaterialData()
        {
            for (int d = 0; d < materialData.Count; d++)
            {
                if (materialData[d].type == TVEMaterialData.PropertyType.Space)
                {
                    materialData[d].value = -9999;
                }
                else if (materialData[d].type == TVEMaterialData.PropertyType.Category)
                {
                    materialData[d].value = -9999;
                }
                else if (materialData[d].type == TVEMaterialData.PropertyType.Value)
                {
                    materialData[d].value = -9999;
                }
                else if (materialData[d].type == TVEMaterialData.PropertyType.Range)
                {
                    materialData[d].value = -9999;
                }
                else if (materialData[d].type == TVEMaterialData.PropertyType.Vector)
                {
                    materialData[d].vector.x = -9999;
                }
                else if (materialData[d].type == TVEMaterialData.PropertyType.Color)
                {
                    materialData[d].vector.x = -9999;
                }
                else if (materialData[d].type == TVEMaterialData.PropertyType.Toggle)
                {
                    materialData[d].value = -9999;
                }
            }
        }

        void GetSelectedObjects()
        {
            selectedObjects = new List<GameObject>();
            selectedMaterials = new List<Material>();

            for (int i = 0; i < Selection.objects.Length; i++)
            {
                var selection = Selection.objects[i];

                if (selection.GetType() == typeof(GameObject))
                {
                    selectedObjects.Add((GameObject)selection);
                }

                if (selection.GetType() == typeof(Material))
                {
                    selectedMaterials.Add((Material)selection);
                }
            }
        }

        void GetPrefabMaterials()
        {
            var gameObjects = new List<GameObject>();
            var meshRenderers = new List<MeshRenderer>();

            for (int i = 0; i < selectedObjects.Count; i++)
            {
                gameObjects.Add(selectedObjects[i]);
                GetChildRecursive(selectedObjects[i], gameObjects);
            }

            for (int i = 0; i < gameObjects.Count; i++)
            {
                if (gameObjects[i].GetComponent<MeshRenderer>() != null)
                {
                    meshRenderers.Add(gameObjects[i].GetComponent<MeshRenderer>());
                }
            }

            for (int i = 0; i < meshRenderers.Count; i++)
            {
                if (meshRenderers[i].sharedMaterials != null)
                {
                    for (int j = 0; j < meshRenderers[i].sharedMaterials.Length; j++)
                    {
                        var material = meshRenderers[i].sharedMaterials[j];

                        if (material != null)
                        {
                            if (!selectedMaterials.Contains(material))
                            {
                                selectedMaterials.Add(material);
                            }
                        }
                    }
                }
            }
        }

        void GetChildRecursive(GameObject go, List<GameObject> gameObjects)
        {
            foreach (Transform child in go.transform)
            {
                if (child == null)
                    continue;

                gameObjects.Add(child.gameObject);
                GetChildRecursive(child.gameObject, gameObjects);
            }
        }

        void InitCustomMaterials()
        {
            Material TVEMaterial = null;

            for (int i = 0; i < selectedMaterials.Count; i++)
            {
                var material = selectedMaterials[i];

                if (material.HasProperty("_IsTVEShader"))
                {
                    TVEMaterial = material;
                    break;
                }
            }

            if (TVEMaterial != null)
            {
                for (int i = 0; i < selectedMaterials.Count; i++)
                {
                    var material = selectedMaterials[i];

                    if (material.HasProperty("_IsInitialized"))
                    {
                        if (material.GetInt("_IsInitialized") == 0)
                        {
                            TheVegetationEngine.TVEShaderUtils.CopyMaterialProperties(TVEMaterial, material);
                            material.SetInt("_IsInitialized", 1);
                        }
                    }
                }
            }
        }

        void GetMaterialProperties()
        {
            for (int i = 0; i < selectedMaterials.Count; i++)
            {
                var material = selectedMaterials[i];

                for (int d = 0; d < materialData.Count; d++)
                {
                    if (material.HasProperty(materialData[d].prop))
                    {
                        if (!TVEShaderUtils.GetPropertyVisibility(material, materialData[d].prop))
                        {
                            continue;
                        }
                    }
                    else
                    {
                        continue;
                    }

                    if (material.GetTag("UseExternalSettings", false) == "False")
                    {
                        continue;
                    }
                    if (materialData[d].type == TVEMaterialData.PropertyType.Space || materialData[d].type == TVEMaterialData.PropertyType.Category || materialData[d].type == TVEMaterialData.PropertyType.Message)
                    {
                        materialData[d].value = 1;
                    }
                    else if (materialData[d].type == TVEMaterialData.PropertyType.Value || materialData[d].type == TVEMaterialData.PropertyType.Range)
                    {
                        var value = material.GetFloat(materialData[d].prop);

                        if (materialData[d].value != -9999 && materialData[d].value != value)
                        {
                            materialData[d].value = -8888;
                        }
                        else
                        {
                            materialData[d].value = value;
                        }
                    }
                    else if (materialData[d].type == TVEMaterialData.PropertyType.Vector || materialData[d].type == TVEMaterialData.PropertyType.Color)
                    {
                        if (material.HasProperty(materialData[d].prop))
                        {
                            var vector = material.GetVector(materialData[d].prop);

                            if (materialData[d].vector.x != -9999 && materialData[d].vector != vector)
                            {
                                materialData[d].vector = new Color(-8888f, 0, 0, 0);
                            }
                            else
                            {
                                materialData[d].vector = vector;
                            }
                        }
                    }
                    else if (materialData[d].type == TVEMaterialData.PropertyType.Enum)
                    {
                        var value = material.GetFloat(materialData[d].prop);

                        if (materialData[d].value != -9999 && materialData[d].value != value)
                        {
                            materialData[d].value = -8888;
                        }
                        else
                        {
                            materialData[d].value = value;
                        }
                    }
                    else if (materialData[d].type == TVEMaterialData.PropertyType.Toggle)
                    {
                        var value = material.GetFloat(materialData[d].prop);

                        if (materialData[d].value != -9999 && materialData[d].value != value)
                        {
                            materialData[d].value = -8888;
                        }
                        else
                        {
                            materialData[d].value = value;
                        }
                    }
                }
            }
        }

        void SetMaterialProperties()
        {
            for (int i = 0; i < selectedMaterials.Count; i++)
            {
                var material = selectedMaterials[i];

                // Maybe a better check for unfocus on Converter Convert button pressed
                if (material != null)
                {
                    TVEUtils.SetMaterialSettings(material);

                    bool UseExternalSettings = true;

                    if (material.GetTag("UseExternalSettings", false) == "False")
                    {
                        UseExternalSettings = false;
                    }

                    if (UseExternalSettings == false)
                    {
                        continue;
                    }

                    for (int d = 0; d < materialData.Count; d++)
                    {
                        if (materialData[d].type == TVEMaterialData.PropertyType.Value)
                        {
                            if (material.HasProperty(materialData[d].prop) && materialData[d].value > -99)
                            {
                                material.SetFloat(materialData[d].prop, materialData[d].value);
                            }
                        }
                        else if (materialData[d].type == TVEMaterialData.PropertyType.Range)
                        {
                            if (material.HasProperty(materialData[d].prop) && materialData[d].value > -99)
                            {
                                material.SetFloat(materialData[d].prop, materialData[d].value);
                            }
                        }
                        else if (materialData[d].type == TVEMaterialData.PropertyType.Vector)
                        {
                            if (material.HasProperty(materialData[d].prop) && materialData[d].vector.x > -99)
                            {
                                material.SetColor(materialData[d].prop, materialData[d].vector);
                            }
                        }
                        else if (materialData[d].type == TVEMaterialData.PropertyType.Color)
                        {
                            if (material.HasProperty(materialData[d].prop) && materialData[d].vector.x > -99)
                            {
                                material.SetColor(materialData[d].prop, materialData[d].vector);
                            }
                        }
                        else if (materialData[d].type == TVEMaterialData.PropertyType.Enum)
                        {
                            if (material.HasProperty(materialData[d].prop) && materialData[d].value > -99)
                            {
                                material.SetFloat(materialData[d].prop, materialData[d].value);
                            }
                        }
                        else if (materialData[d].type == TVEMaterialData.PropertyType.Toggle)
                        {
                            if (material.HasProperty(materialData[d].prop) && materialData[d].value > -99)
                            {
                                material.SetFloat(materialData[d].prop, materialData[d].value);
                            }
                        }
                    }
                }
            }
        }

        void GetPresets()
        {
            presetPaths = new List<string>();
            presetPaths.Add(null);

            // FindObjectsOfTypeAll not working properly for unloaded assets
            allPresetPaths = Directory.GetFiles(Application.dataPath, "*.tvepreset", SearchOption.AllDirectories);
            allPresetPaths = allPresetPaths.OrderBy(f => new FileInfo(f).Name).ToArray();

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                string assetPath = "Assets" + allPresetPaths[i].Replace(Application.dataPath, "").Replace('\\', '/');

                if (assetPath.Contains("[SETTINGS]") == true)
                {
                    presetPaths.Add(assetPath);
                }
            }

            //for (int i = 0; i < presetTreePaths.Count; i++)
            //{
            //    Debug.Log(presetTreePaths[i]);
            //}
        }

        void GetPresetOptions()
        {
            presetOptions = new string[presetPaths.Count + 1];
            presetOptions[0] = "Choose a preset";

            for (int i = 1; i < presetPaths.Count; i++)
            {
                presetOptions[i] = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(presetPaths[i]).name;
                presetOptions[i] = presetOptions[i].Replace("[SETTINGS] ", "");
                presetOptions[i] = presetOptions[i].Replace(" - ", "/");
            }

            presetOptions[presetPaths.Count] = "Validate All Project Materials";

            //for (int i = 0; i < presetOptions.Length; i++)
            //{
            //    Debug.Log(presetOptions[i]);
            //}
        }

        void GetPresetLines()
        {
            StreamReader reader = new StreamReader(presetPaths[presetIndex]);

            presetLines = new List<string>();

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine().TrimStart();

                presetLines.Add(line);
            }

            reader.Close();

            //for (int i = 0; i < presetLines.Count; i++)
            //{
            //    Debug.Log(presetLines[i]);
            //}
        }

        void GetMaterialConversionFromPreset(Material material)
        {
            InitConditionFromLine();

            for (int i = 0; i < presetLines.Count; i++)
            {
                useLine = GetConditionFromLine(presetLines[i], material);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Material"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";
                        var src = "";
                        var set = "";

                        var x = "0";
                        var y = "0";
                        var z = "0";
                        var w = "0";

                        if (splitLine.Length > 1)
                        {
                            type = splitLine[1];
                        }

                        if (splitLine.Length > 2)
                        {
                            src = splitLine[2];
                            set = splitLine[2];
                        }

                        if (splitLine.Length > 3)
                        {
                            x = splitLine[3];
                        }

                        if (splitLine.Length > 4)
                        {
                            y = splitLine[4];
                        }

                        if (splitLine.Length > 5)
                        {
                            z = splitLine[5];
                        }

                        if (splitLine.Length > 6)
                        {
                            w = splitLine[6];
                        }

                        if (type == "SET_FLOAT")
                        {
                            material.SetFloat(set, float.Parse(x, CultureInfo.InvariantCulture));
                        }
                        else if (type == "SET_COLOR")
                        {
                            material.SetColor(set, new Color(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "SET_VECTOR")
                        {
                            material.SetVector(set, new Vector4(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "ENABLE_INSTANCING")
                        {
                            material.enableInstancing = true;
                        }
                        else if (type == "DISABLE_INSTANCING")
                        {
                            material.enableInstancing = false;
                        }
                        else if (type == "SET_SHADER_BY_NAME")
                        {
                            var shader = presetLines[i].Replace("Material SET_SHADER_BY_NAME ", "");

                            if (Shader.Find(shader) != null)
                            {
                                material.shader = Shader.Find(shader);
                            }
                        }
                        else if (type == "SET_SHADER_BY_LIGHTING")
                        {
                            var lighting = presetLines[i].Replace("Material SET_SHADER_BY_LIGHTING ", "");

                            var newShaderName = material.shader.name;
                            newShaderName = newShaderName.Replace("Vertex", "XXX");
                            newShaderName = newShaderName.Replace("Simple", "XXX");
                            newShaderName = newShaderName.Replace("Standard", "XXX");
                            newShaderName = newShaderName.Replace("Subsurface", "XXX");
                            newShaderName = newShaderName.Replace("XXX", lighting);

                            if (Shader.Find(newShaderName) != null)
                            {
                                material.shader = Shader.Find(newShaderName);
                            }
                        }
                    }
                }
            }
        }

        void InitConditionFromLine()
        {
            useLines = new List<bool>();
            useLines.Add(true);
        }

        bool GetConditionFromLine(string line, Material material)
        {
            var valid = true;

            if (line.StartsWith("if"))
            {
                valid = false;

                string[] splitLine = line.Split(char.Parse(" "));

                var type = "";
                var check = "";
                var val = splitLine[splitLine.Length - 1];

                if (splitLine.Length > 1)
                {
                    type = splitLine[1];
                }

                if (splitLine.Length > 2)
                {
                    for (int i = 2; i < splitLine.Length; i++)
                    {
                        if (!float.TryParse(splitLine[i], out _))
                        {
                            check = check + splitLine[i] + " ";
                        }
                    }

                    check = check.TrimEnd();
                }

                if (type.Contains("SHADER_NAME_CONTAINS"))
                {
                    var name = material.shader.name.ToUpperInvariant();

                    if (name.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_NAME_CONTAINS"))
                {
                    var name = material.name.ToUpperInvariant();

                    if (name.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_NAME_CONTAINS"))
                {
                    if (material.name.Contains(check))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_PIPELINE_IS_STANDARD"))
                {
                    if (material.GetTag("RenderPipeline", false) == "")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_PIPELINE_IS_UNIVERSAL"))
                {
                    if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_PIPELINE_IS_HD"))
                {
                    if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_RENDERTYPE_TAG_CONTAINS"))
                {
                    if (material.GetTag("RenderType", false).Contains(check))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_HAS_PROP"))
                {
                    if (material.HasProperty(check))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_FLOAT_EQUALS"))
                {
                    var min = float.Parse(val, CultureInfo.InvariantCulture) - 0.1f;
                    var max = float.Parse(val, CultureInfo.InvariantCulture) + 0.1f;

                    if (material.HasProperty(check) && material.GetFloat(check) > min && material.GetFloat(check) < max)
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_KEYWORD_ENABLED"))
                {
                    if (material.IsKeywordEnabled(check))
                    {
                        valid = true;
                    }
                }

                useLines.Add(valid);
            }

            if (line.StartsWith("if") && line.Contains("!"))
            {
                valid = !valid;
                useLines[useLines.Count - 1] = valid;
            }

            if (line.StartsWith("endif") || line.StartsWith("}"))
            {
                useLines.RemoveAt(useLines.Count - 1);
            }

            var useLine = true;

            for (int i = 1; i < useLines.Count; i++)
            {
                if (useLines[i] == false)
                {
                    useLine = false;
                    break;
                }
            }

            return useLine;
        }

        void SavePreset()
        {
            GUILayout.BeginHorizontal();

            savingIndex = EditorGUILayout.Popup(savingIndex, savingOptions, stylePopup, GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 2), GUILayout.Height(GUI_HEIGHT));

            if (GUILayout.Button("Save Preset", GUILayout.Height(GUI_HEIGHT)))
            {
                savePath = EditorUtility.SaveFilePanelInProject("Save Preset", "Custom - My Preset", "tvepreset", "Use the ' - ' simbol to create categories!");

                if (savePath != "")
                {
                    savePath = savePath.Replace("[SETTINGS] ", "");
                    savePath = savePath.Replace(Path.GetFileName(savePath), "[SETTINGS] " + Path.GetFileName(savePath));

                    StreamWriter writer = new StreamWriter(savePath);
                    saveData = new List<TVEMaterialData>();

                    if (savingIndex == 0)
                    {
                        saveData.AddRange(renderSettings);
                        saveData.AddRange(globalData);
                        saveData.AddRange(mainData);
                        saveData.AddRange(secondData);
                        saveData.AddRange(occlusionData);
                        saveData.AddRange(gradientData);
                        saveData.AddRange(noiseData);
                        saveData.AddRange(subsurfaceData);
                        saveData.AddRange(emissiveData);
                        saveData.AddRange(perspectiveSettings);
                        saveData.AddRange(sizeFadeData);
                        saveData.AddRange(motionData);
                    }
                    else if (savingIndex == 1)
                    {
                        saveData = materialData;
                    }

                    for (int i = 0; i < saveData.Count; i++)
                    {
                        if (saveData[i].space == true)
                        {
                            writer.WriteLine("");
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Space)
                        {
                            writer.WriteLine("");
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Category)
                        {
                            writer.WriteLine("");
                            writer.WriteLine("// " + saveData[i].category);
                            writer.WriteLine("");
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Value)
                        {
                            if (saveData[i].value > -99)
                            {
                                writer.WriteLine("Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Range)
                        {
                            if (saveData[i].value > -99)
                            {
                                writer.WriteLine("Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Vector)
                        {
                            if (saveData[i].vector.x > -99)
                            {
                                writer.WriteLine("Material SET_VECTOR " + saveData[i].prop + " " + saveData[i].vector.x.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.y.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.z.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.w.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_VECTOR " + saveData[i].prop + " " + saveData[i].vector.x.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.y.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.z.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.w.ToString(CultureInfo.InvariantCulture));
                            }
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Color)
                        {
                            if (saveData[i].vector.x > -99)
                            {
                                writer.WriteLine("Material SET_VECTOR " + saveData[i].prop + " " + saveData[i].vector.x.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.y.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.z.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.w.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_VECTOR " + saveData[i].prop + " " + saveData[i].vector.x.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.y.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.z.ToString(CultureInfo.InvariantCulture) + " " + saveData[i].vector.w.ToString(CultureInfo.InvariantCulture));
                            }
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Enum)
                        {
                            if (saveData[i].value > -99)
                            {
                                writer.WriteLine("Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                        }

                        if (saveData[i].type == TVEMaterialData.PropertyType.Toggle)
                        {
                            if (saveData[i].value > -99)
                            {
                                writer.WriteLine("Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                            else
                            {
                                writer.WriteLine("//Material SET_FLOAT " + saveData[i].prop + " " + saveData[i].value.ToString(CultureInfo.InvariantCulture));
                            }
                        }
                    }

                    writer.Close();

                    AssetDatabase.Refresh();

                    GetPresets();
                    GetPresetOptions();

                    // Reset materialData
                    settingsIndexOld = -1;

                    Debug.Log("<b>[The Vegetation Engine]</b> " + "Material preset saved!");

                    GUIUtility.ExitGUI();
                }
            }

            GUILayout.EndHorizontal();
        }

        void ValidateAllProjectMaterials()
        {
            var allMaterialGUIDs = AssetDatabase.FindAssets("t:material", null);

            int total = 0;
            int count = 0;

            foreach (var asset in allMaterialGUIDs)
            {
                var path = AssetDatabase.GUIDToAssetPath(asset);

                if (path.Contains("TVE Material") || path.Contains("TVE_Material"))
                {
                    total++;
                }
                else if (path.Contains("TVE Element") || path.Contains("TVE_Element"))
                {
                    total++;
                }
                else if (path.Contains("_Impostor"))
                {
                    total++;
                }
            }

            foreach (var asset in allMaterialGUIDs)
            {
                var path = AssetDatabase.GUIDToAssetPath(asset);

                if (path.Contains("TVE Material") || path.Contains("TVE_Material"))
                {
                    var material = AssetDatabase.LoadAssetAtPath<Material>(path);
                    TVEUtils.SetMaterialSettings(material);

                    count++;
                }
                else if (path.Contains("TVE Element") || path.Contains("TVE_Element"))
                {
                    var material = AssetDatabase.LoadAssetAtPath<Material>(path);
                    TVEUtils.SetElementSettings(material);

                    count++;
                }
                else if (path.Contains("_Impostor"))
                {
                    var material = AssetDatabase.LoadAssetAtPath<Material>(path);
                    TVEUtils.SetMaterialSettings(material);

                    count++;
                }

                EditorUtility.DisplayProgressBar("The Vegetatin Engine", "Processing " + Path.GetFileName(path), (float)count * (1.0f / (float)total));
            }

            EditorUtility.ClearProgressBar();
        }

        void OverrideWind()
        {
            if (TVEManager.Instance != null)
            {
                globalMotion = TVEManager.Instance.globalMotion;
            }

            if (globalMotion != null)
            {
                windPower = globalMotion.windPower;
                globalMotion.isEnabled = false;
            }

            dummyMaterial = Resources.Load<Material>("Internal Dummy");
        }

        void ResetWind()
        {
            if (globalMotion != null)
            {
                windPower = globalMotion.windPower;
                globalMotion.isEnabled = true;

                SetGlobalShaderProperties();
            }
        }

        void SetGlobalShaderProperties()
        {
            Vector4 windEditor = Shader.GetGlobalVector("TVE_MotionParams");
            Shader.SetGlobalVector("TVE_MotionParams", new Vector4(windEditor.x, windEditor.y, windPower, 0.0f));

            dummyMaterial.SetFloat("_DummyValue", windPower);
        }
    }
}

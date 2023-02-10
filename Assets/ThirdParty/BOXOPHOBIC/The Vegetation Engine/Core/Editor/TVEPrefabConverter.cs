// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.StyledGUI;
using Boxophobic.Utils;
using System.IO;
using System.Linq;
using System.Globalization;

namespace TheVegetationEngine
{
    public class TVEPrefabConverter : EditorWindow
    {
        const int NONE = 0;

        const int GUI_SPACE_SMALL = 5;
        const int GUI_SELECTION_HEIGHT = 24;
        const int GUI_SQUARE_BUTTON_WIDTH = 20;
        const int GUI_SQUARE_BUTTON_HEIGHT = 18;
        float GUI_HALF_EDITOR_WIDTH = 200;

        const string PREFABS_DATA_PATH = "/Assets Data/Prefabs Data";
        const string SHARED_DATA_PATH = "/Assets Data/Shared Data";
        const string TEXTURE_DATA_PATH = "/Assets Data/Texture Data";

        readonly int[] MaxTextureSizes = new int[]
        {
        0,
        32,
        64,
        128,
        256,
        512,
        1024,
        2048,
        4096,
        8192,
        };

        string[] SourceMaskEnum = new string[]
        {
        "None", "Channel", "Procedural", "Texture", "3rd Party",
        };

        string[] SourceMaskMeshEnum = new string[]
        {
        "[0]  Vertex R", "[1]  Vertex G", "[2]  Vertex B", "[3]  Vertex A",
        "[4]  UV 0 X", "[5]  UV 0 Y", "[6]  UV 0 Z", "[7]  UV 0 W",
        "[8]  UV 2 X", "[9]  UV 2 Y", "[10]  UV 2 Z", "[11]  UV 2 W",
        "[12]  UV 3 X", "[13]  UV 3 Y", "[14]  UV 3 Z", "[16]  UV 3 W",
        "[16]  UV 4 X", "[17]  UV 4 Y", "[18]  UV 4 Z", "[19]  UV 4 W",
        };

        string[] SourceMaskProceduralEnum = new string[]
        {
        "[0]  Constant Black", "[1]  Constant White", "[2]  Random Element Variation", "[3]  Predictive Element Variation", "[4]  Height", "[5]  Sphere", "[6]  Cylinder", "[7]  Capsule",
        "[8]  Base To Top", "[9]  Bottom Projection", "[10]  Top Projection", "[11]  Height Offset (Low)", "[12]  Height Offset (Medium)", "[13]  Height Offset (High)",
        "[14]  Height Grass", "[15] Sphere Plant", "[16] Cylinder Tree", "[17] Capsule Tree", "[18] Normalized Pos X", "[19] Normalized Pos Y", "[20] Normalized Pos Z",
        };

        string[] SourceMask3rdPartyEnum = new string[]
        {
        "[0]  CTI Leaves Mask", "[1]  CTI Leaves Variation", "[2]  ST8 Leaves Mask", "[3]  NM Leaves Mask", "[4]  Nicrom Leaves Mask", "[5]  Nicrom Detail Mask",
        };

        string[] SourceFromTextureEnum = new string[]
        {
        "[0]  Channel R", "[1]  Channel G", "[2]  Channel B", "[3]  Channel A"
        };

        string[] SourceCoordEnum = new string[]
        {
        "None", "Channel", "Procedural", "3rd Party",
        };

        string[] SourceCoordMeshEnum = new string[]
        {
        "[0]  UV 0", "[1]  UV 2", "[2]  UV 3", "[3]  UV 4",
        };

        string[] SourceCoordProceduralEnum = new string[]
        {
        "[0]  Automatic", "[1]  Planar XZ", "[2]  Planar XY", "[3]  Planar ZY",
        };

        string[] SourceCoord3rdPartyEnum = new string[]
        {
        "[0]  NM Trunk Blend"
        };

        string[] SourcePivotsEnum = new string[]
        {
        "None", "Procedural",
        };

        string[] SourcePivotsProceduralEnum = new string[]
        {
        "[0]  Procedural Pivots",
        };

        string[] SourceNormalsEnum = new string[]
        {
        "From Mesh", "Procedural",
        };

        string[] SourceNormalsProceduralEnum = new string[]
        {
        "[0]  Recalculate Normals",
        "[1]  Flat Shading (Low)", "[2]  Flat Shading (Medium)", "[3]  Flat Shading (Full)",
        "[4]  Spherical Shading (Low)", "[5]  Spherical Shading (Medium)", "[6]  Spherical Shading (Full)",
        };

        string[] SourceBoundsEnum = new string[]
        {
        "From Mesh", "Procedural",
        };

        string[] SourceBoundsProceduralEnum = new string[]
        {
        "[0]  Expand Bounds (Small)", "[1]  Expand Bounds (Medium)", "[2]  Expand Bounds (Large)", "[3]  Expand Bounds (Conservative)",
        };

        string[] SourceActionEnum = new string[]
        {
        "None", "One Minus", "Negative", "Remap 0-1", "Power Of 2", "Multiply by Height",
        };

        string[] ReadWriteModeEnum = new string[]
        {
        "Mark Meshes As Non Readable", "Mark Meshes As Readable",
        };

        enum OutputMesh
        {
            Off = 0,
            Default = 10,
            Custom = 20,
            DEEnvironment = 100,
        }

        enum OutputMaterial
        {
            Off = 0,
            Default = 10,
        }

        enum OutputTexture
        {
            UseCurrentResolution = 0,
            UseHighestResolution = 10,
            UsePreviewResolution = 20,
        }

        enum OutputTransform
        {
            UseOriginalTransforms = 0,
            TransformToWorldSpace = 10,
        }

        OutputMesh outputMeshIndex = OutputMesh.Default;
        OutputMaterial outputMaterialIndex = OutputMaterial.Default;
        OutputTexture outputTextureIndex = OutputTexture.UseHighestResolution;
        OutputTransform outputTransformIndex = OutputTransform.TransformToWorldSpace;
        string outputPipeline = "";
        string outputSuffix = "TVE";
        bool outputValid = true;
        int readWriteMode = 0;

        string infoTitle = "";
        string infoPreset = "";
        string infoStatus = "";
        string infoOnline = "";
        string infoMessage = "";
        string infoWarning = "";
        string infoError = "";

        int sourceVariation = 0;
        int optionVariation = 0;
        int actionVariation = 0;
        int coordVariation = 0;
        Texture2D textureVariation;
        List<Texture2D> textureVariationList;

        int sourceOcclusion = 0;
        int optionOcclusion = 0;
        int actionOcclusion = 0;
        int coordOcclusion = 0;
        Texture2D textureOcclusion;
        List<Texture2D> textureOcclusionList;

        int sourceDetail = 0;
        int optionDetail = 0;
        int actionDetail = 0;
        int coordDetail = 0;
        Texture2D textureDetail;
        List<Texture2D> textureDetailList;

        int sourceHeight = 0;
        int optionHeight = 0;
        int actionHeight = 0;
        int coordHeight = 0;
        Texture2D textureHeight;
        List<Texture2D> textureHeightList;

        int sourceMotion2 = 0;
        int optionMotion2 = 0;
        int actionMotion2 = 0;
        int coordMotion2 = 0;
        Texture2D textureMotion2;
        List<Texture2D> textureMotion2List;

        int sourceMotion3 = 0;
        int optionMotion3 = 0;
        int actionMotion3 = 0;
        int coordMotion3 = 0;
        Texture2D textureMotion3;
        List<Texture2D> textureMotion3List;

        int sourceMainCoord = 1;
        int optionMainCoord = 0;

        int sourceDetailCoord = 1;
        int optionDetailCoord = 0;

        int sourcePivots = 0;
        int optionPivots = 0;

        int sourceNormals = 0;
        int optionNormals = 0;

        int sourceBounds = 0;
        int optionBounds = 0;

        string projectDataFolder;
        string prefabDataFolder;
        string userFolder = "Assets/BOXOPHOBIC/User";

        List<TVEPrefabData> prefabObjects;
        int convertedPrefabCount;
        int supportedPrefabCount;
        int collectiblePrefabCount;
        int validPrefabCount;

        GameObject prefabObject;
        GameObject prefabInstance;
        GameObject prefabBackup;
        string prefabName;

        List<GameObject> gameObjectsInPrefab;
        List<MeshRenderer> meshRenderersInPrefab;
        List<Material[]> materialArraysInPrefab;
        List<Material[]> materialArraysInstances;
        List<MeshFilter> meshFiltersInPrefab;
        List<Mesh> meshesInPrefab;
        List<Mesh> meshInstances;
        List<MeshCollider> meshCollidersInPrefab;
        List<Mesh> collidersInPrefab;
        List<Mesh> colliderInstances;
        Vector4 maxBoundsInfo;

        Material blitMaterial;
        Texture blitTexture;
        TextureImporter[] sourceTexImporters;
        TextureImporterSettings[] sourceTexSettings;
        TextureImporterCompression[] sourceTexCompressions;
        int[] sourceimportSizes;

        int[] maskChannels;
        int[] maskCoords;
        //int[] maskLayers;
        int[] maskActions0;
        int[] maskActions1;
        int[] maskActions2;
        Texture[] maskTextures;
        List<string> packedTextureNames;
        List<Texture> packedTextureObjects;

        int presetIndex = 0;
        int optionIndex = 0;
        bool presetAutoDetected = false;
        bool presetMixedValues = false;
        List<int> overrideIndices;
        List<bool> overrideGlobals;

        bool showAdvancedSettings = false;
        bool shareCommonMaterials = true;
        bool keepConvertedMaterials = false;
        bool hasOutputModifications = false;
        bool hasMeshModifications = false;

        string[] allPresetPaths;
        List<string> presetPaths;
        List<string> presetLines;
        List<string> overridePaths;
        List<string> detectLines;
        string[] PresetsEnum;
        string[] OptionsEnum;
        string[] OverridesEnum;

        Shader shaderBark;
        Shader shaderCross;
        Shader shaderGrass;
        Shader shaderLeaf;
        Shader shaderProp;
        Shader shaderUber;

        List<bool> useMaterialLines;
        List<bool> useOptionLines;
        bool isValid = true;
        bool showSelection = true;
        float seed = 1;

        string renderPipeline;

        GUIStyle stylePopup;
        GUIStyle styleCenteredHelpBox;
        GUIStyle styleMiniToggleButton;
        Color bannerColor;
        string bannerText;
        static TVEPrefabConverter window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine/Prefab Converter", false, 2000)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEPrefabConverter>(false, "Prefab Converter", true);
            window.minSize = new Vector2(400, 280);
        }

        void OnEnable()
        {
            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Prefab Converter";

            if (TVEManager.Instance == null)
            {
                isValid = false;
            }

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

            string pipeline = SettingsUtils.LoadSettingsData(userFolder + "/Pipeline.asset", "Standard");

            if (pipeline.Contains("Standard"))
            {
                renderPipeline = "Standard";
            }
            else if (pipeline.Contains("Universal"))
            {
                renderPipeline = "Universal";
            }
            else if (pipeline.Contains("High"))
            {
                renderPipeline = "HD";
            }

            int intSeed = UnityEngine.Random.Range(1, 99);
            float floatSeed = UnityEngine.Random.Range(0.1f, 0.9f);
            seed = intSeed + floatSeed;

            InitTexturePacker();
            GetDefaultShaders();

            GetPresets();
            Initialize();
        }

        void OnSelectionChange()
        {
            GetPrefabObjects();
            GetPrefabPresets();
            GetAllPresetInfo();

            Repaint();
        }

        void OnFocus()
        {
            GetPrefabObjects();
            GetPrefabPresets();
            GetAllPresetInfo();

            Repaint();
        }

        void Initialize()
        {
            overrideIndices = new List<int>();
            overrideGlobals = new List<bool>();

            GetPrefabObjects();
            GetGlobalOverrides();
            GetPrefabPresets();

            if (overrideIndices.Count == 0)
            {
                overrideIndices.Add(0);
                overrideGlobals.Add(false);
            }

            GetAllPresetInfo(true);
        }

        void OnGUI()
        {
            GUI_HALF_EDITOR_WIDTH = this.position.width / 2.0f - 24;

            SetGUIStyles();

            StyledGUI.DrawWindowBanner(bannerColor, bannerText);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            DrawMessage();

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false, GUILayout.Width(this.position.width - 28), GUILayout.Height(this.position.height - 230));

            DrawPrefabObjects();

            if (isValid == false || validPrefabCount == 0)
            {
                GUI.enabled = false;
            }

            DrawConversionSettings();
            DrawConversionButtons();

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

            styleMiniToggleButton = new GUIStyle(GUI.skin.GetStyle("Button"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void DrawMessage()
        {
            GUILayout.Space(-2);

            if (EditorSettings.serializationMode != UnityEditor.SerializationMode.ForceText)
            {
                EditorGUILayout.HelpBox("The Prefab Converter cannot be used because the Asset Serialization Mode is not set to Force Text under Project Settings > Editor! Please change the settings to use the converter!", MessageType.Error, true);
            }
            else
            {
                if (isValid && validPrefabCount > 0)
                {
                    if (presetIndex != 0)
                    {
                        var preset = "";
                        var status = "";
                        //var warning = "";
                        //var error = "";

                        if (infoPreset != "")
                        {
                            preset = "\n" + infoPreset + " Please note, after conversion, material adjustments might be needed!" + "\n";
                        }

                        if (infoStatus != "")
                        {
                            status = "\n" + infoStatus + "\n";
                        }

                        if (GUILayout.Button("\n<size=14>" + infoTitle + "</size>\n"
                                            + preset
                                            + status
                                            , styleCenteredHelpBox))
                        {
                            Application.OpenURL(infoOnline);
                        }

                        if (infoError != "")
                        {
                            GUILayout.Space(10);
                            EditorGUILayout.HelpBox(infoError, MessageType.Error, true);
                        }
                        else
                        {
                            if (infoMessage != "")
                            {
                                GUILayout.Space(10);
                                EditorGUILayout.HelpBox(infoMessage, MessageType.Info, true);
                            }

                            if (infoWarning != "")
                            {
                                GUILayout.Space(10);
                                EditorGUILayout.HelpBox(infoWarning, MessageType.Warning, true);
                            }
                        }
                    }
                    else
                    {
                        if (presetMixedValues)
                        {
                            GUILayout.Button("\n<size=14>Multiple conversion presets detected!</size>\n", styleCenteredHelpBox);
                        }
                        else
                        {
                            GUILayout.Button("\n<size=14>Choose a preset to convert the selected prefabs!</size>\n", styleCenteredHelpBox);
                        }
                    }
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
                    else if (validPrefabCount == 0)
                    {
                        GUILayout.Button("\n<size=14>Select one or multiple prefabs to get started!</size>\n", styleCenteredHelpBox);
                    }
                }
            }
        }

        void DrawPrefabObjects()
        {
            if (prefabObjects.Count > 0)
            {
                GUILayout.Space(10);

                if (showSelection)
                {
                    if (StyledButton("Hide Prefab Selection"))
                        showSelection = !showSelection;
                }
                else
                {
                    if (StyledButton("Show Prefab Selection"))
                        showSelection = !showSelection;
                }

                if (showSelection)
                {
                    for (int i = 0; i < prefabObjects.Count; i++)
                    {
                        StyledPrefab(prefabObjects[i]);
                    }
                }
            }
        }

        void DrawConversionSettings()
        {
            GUILayout.Space(10);

            EditorGUI.BeginChangeCheck();

            GUILayout.BeginHorizontal();

            presetIndex = StyledPresetPopup("Conversion Preset", "The preset used to convert the selected prefab or prefabs.", presetIndex, PresetsEnum);

            if (presetIndex != 0)
            {
                if (StyledMiniToggleButton("", "Select the preset file.", 12, false))
                {
                    EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(presetPaths[presetIndex]));
                }

                var lastRect = GUILayoutUtility.GetLastRect();
                var iconRect = new Rect(lastRect.x, lastRect.y - 1, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);
                GUI.Label(iconRect, EditorGUIUtility.IconContent("Preset.Context"));
            }

            GUILayout.EndHorizontal();

            if (EditorGUI.EndChangeCheck())
            {
                presetAutoDetected = false;

                GetAllPresetInfo(true);
            }

            if (presetIndex != 0 && OptionsEnum.Length > 1)
            {
                EditorGUI.BeginChangeCheck();

                GUILayout.BeginHorizontal();

                optionIndex = StyledPresetPopup("Conversion Option", "The preset used to convert the selected prefab or prefabs.", optionIndex, OptionsEnum);
                GUILayout.Label("", GUILayout.Width(GUI_SQUARE_BUTTON_WIDTH - 2));

                GUILayout.EndHorizontal();

                if (EditorGUI.EndChangeCheck())
                {
                    GetAllPresetInfo(false);
                }
            }

            if (presetIndex != 0)
            {
                EditorGUI.BeginChangeCheck();

                for (int i = 0; i < overrideIndices.Count; i++)
                {
                    GUILayout.BeginHorizontal();

                    overrideIndices[i] = StyledPresetPopup("Conversion Override", "Adds extra functionality over the currently used preset.", overrideIndices[i], OverridesEnum);

                    if (overrideIndices[i] == 0)
                    {
                        GUI.enabled = false;
                    }

                    overrideGlobals[i] = StyledMiniToggleButton("", "Set Override as global for future conversions.", 11, overrideGlobals[i]);

                    var lastRect = GUILayoutUtility.GetLastRect();
                    var iconRect = new Rect(lastRect.x - 1, lastRect.y - 1, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);
                    GUI.Label(iconRect, EditorGUIUtility.IconContent("InspectorLock"));

                    if (overrideIndices[i] == 0)
                    {
                        overrideGlobals[i] = false;
                    }

                    GUI.enabled = true;

                    GUILayout.EndHorizontal();
                }

                var overridesCount = overrideIndices.Count;

                if (overrideIndices[0] != 0 || overridesCount > 1)
                {
                    GUILayout.BeginHorizontal();

                    GUILayout.Label("");

                    if (overridesCount > 1)
                    {
                        if (GUILayout.Button(new GUIContent("-", "Remove the last override."), GUILayout.MaxWidth(GUI_SQUARE_BUTTON_WIDTH), GUILayout.MaxHeight(GUI_SQUARE_BUTTON_HEIGHT)))
                        {
                            overrideIndices.RemoveAt(overridesCount - 1);
                            overrideGlobals.RemoveAt(overridesCount - 1);
                        }
                    }

                    if (GUILayout.Button(new GUIContent("+", "Add a new override."), GUILayout.MaxWidth(GUI_SQUARE_BUTTON_WIDTH), GUILayout.MaxHeight(GUI_SQUARE_BUTTON_HEIGHT)))
                    {
                        overrideIndices.Add(0);
                        overrideGlobals.Add(false);
                    }

                    GUILayout.EndHorizontal();

                    if (EditorGUI.EndChangeCheck())
                    {
                        GetAllPresetInfo(false);
                        SaveGlobalOverrides();
                    }
                }

                GUILayout.Space(10);

                if (supportedPrefabCount + convertedPrefabCount == 0)
                {
                    GUI.enabled = false;
                }
                else
                {
                    GUI.enabled = true;
                }

                GUILayout.BeginHorizontal();
                GUILayout.Label("Show Advanced Settings", GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                showAdvancedSettings = EditorGUILayout.Toggle(showAdvancedSettings);
                GUILayout.EndHorizontal();

                if (showAdvancedSettings)
                {
                    GUILayout.Space(10);
                    StyledGUI.DrawWindowCategory("Output Settings");
                    GUILayout.Space(10);

                    if (hasOutputModifications)
                    {
                        EditorGUILayout.HelpBox("The output settings have been overriden and they will not update when changing the preset or adding overrides!", MessageType.Info, true);
                        GUILayout.Space(10);
                    }

                    EditorGUI.BeginChangeCheck();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Output Meshes", "Mesh packing for the current preset."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    outputMeshIndex = (OutputMesh)EditorGUILayout.EnumPopup(outputMeshIndex, stylePopup);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Output Materials", "Material conversion for the current preset."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    outputMaterialIndex = (OutputMaterial)EditorGUILayout.EnumPopup(outputMaterialIndex, stylePopup);
                    GUILayout.EndHorizontal();

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Output Textures", "Texture conversion for the current preset."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    outputTextureIndex = (OutputTexture)EditorGUILayout.EnumPopup(outputTextureIndex, stylePopup);
                    GUILayout.EndHorizontal();

                    if (outputMeshIndex != OutputMesh.Off)
                    {
                        GUILayout.BeginHorizontal();
                        GUILayout.Label(new GUIContent("Output Transforms", "Transform meshes to world space."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                        outputTransformIndex = (OutputTransform)EditorGUILayout.EnumPopup(outputTransformIndex, stylePopup);
                        GUILayout.EndHorizontal();
                    }

                    GUILayout.BeginHorizontal();
                    GUILayout.Label(new GUIContent("Output Suffix", "Suffix used when saving assets to disk."), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                    outputSuffix = EditorGUILayout.TextField(outputSuffix);
                    GUILayout.EndHorizontal();

                    if (EditorGUI.EndChangeCheck())
                    {
                        hasOutputModifications = true;
                    }

                    if (outputMeshIndex == OutputMesh.Off)
                    {
                        GUILayout.Space(10);
                        StyledGUI.DrawWindowCategory("Mesh Settings");
                        GUILayout.Space(10);

                        if (hasMeshModifications)
                        {
                            EditorGUILayout.HelpBox("The mesh settings have been overriden and they will not update when changing the preset or adding overrides!", MessageType.Info, true);
                            GUILayout.Space(10);
                        }

                        EditorGUI.BeginChangeCheck();

                        readWriteMode = StyledPopup("ReadWrite Mode", "Set meshes readable mode.", readWriteMode, ReadWriteModeEnum);

                        sourceBounds = StyledSourcePopup("Bounds", "Mesh vertex bounds override.", sourceBounds, SourceBoundsEnum);
                        optionBounds = StyledBoundsOptionEnum("Bounds", "", sourceBounds, optionBounds);

                        sourceNormals = StyledSourcePopup("Normals", "Mesh vertex normals override.", sourceNormals, SourceNormalsEnum);
                        optionNormals = StyledNormalsOptionEnum("Normals", "", sourceNormals, optionNormals);

                        GUILayout.Space(10);

                        sourceMainCoord = StyledSourcePopup("Main Coord", "Main UVs used for the main texture set. Stored in UV0.XY.", sourceMainCoord, SourceCoordEnum);
                        optionMainCoord = StyledCoordOptionEnum("Main Coord", "", sourceMainCoord, optionMainCoord);

                        sourceDetailCoord = StyledSourcePopup("Detail Coord", "Detail UVs used for layer blending for bark and props. Stored in UV2.ZW.", sourceDetailCoord, SourceCoordEnum);
                        optionDetailCoord = StyledCoordOptionEnum("Detail Coord", "", sourceDetailCoord, optionDetailCoord);

                        GUILayout.Space(10);

                        sourceDetail = StyledSourcePopup("Detail Mask", "Detail mask used for layer blending for bark. Stored in Vertex Blue.", sourceDetail, SourceMaskEnum);
                        textureDetail = StyledTexture("Detail Mask", "", sourceDetail, textureDetail);
                        optionDetail = StyledMaskOptionEnum("Detail Mask", "", sourceDetail, optionDetail, false);
                        coordDetail = StyledTextureCoord("Detail Mask", "", sourceDetail, coordDetail);
                        actionDetail = StyledActionOptionEnum("Detail Mask", "", sourceDetail, actionDetail, true);

                        if (EditorGUI.EndChangeCheck())
                        {
                            hasMeshModifications = true;
                        }
                    }

                    if (outputMeshIndex == OutputMesh.Default)
                    {
                        GUILayout.Space(10);
                        StyledGUI.DrawWindowCategory("Mesh Settings");
                        GUILayout.Space(10);

                        if (hasMeshModifications)
                        {
                            EditorGUILayout.HelpBox("The mesh settings have been overriden and they will not update when changing the preset or adding overrides!", MessageType.Info, true);
                            GUILayout.Space(10);
                        }

                        EditorGUI.BeginChangeCheck();

                        readWriteMode = StyledPopup("ReadWrite Mode", "Set meshes readable mode.", readWriteMode, ReadWriteModeEnum);

                        sourceBounds = StyledSourcePopup("Bounds", "Mesh vertex bounds override.", sourceBounds, SourceBoundsEnum);
                        optionBounds = StyledBoundsOptionEnum("Bounds", "", sourceBounds, optionBounds);

                        sourceNormals = StyledSourcePopup("Normals", "Mesh vertex normals override.", sourceNormals, SourceNormalsEnum);
                        optionNormals = StyledNormalsOptionEnum("Normals", "", sourceNormals, optionNormals);

                        GUILayout.Space(10);

                        sourceMainCoord = StyledSourcePopup("Main Coord", "Main UVs used for the main texture set. Stored in UV0.XY.", sourceMainCoord, SourceCoordEnum);
                        optionMainCoord = StyledCoordOptionEnum("Main Coord", "", sourceMainCoord, optionMainCoord);

                        sourceDetailCoord = StyledSourcePopup("Detail Coord", "Detail UVs used for layer blending for bark and props. Stored in UV2.ZW.", sourceDetailCoord, SourceCoordEnum);
                        optionDetailCoord = StyledCoordOptionEnum("Detail Coord", "", sourceDetailCoord, optionDetailCoord);

                        GUILayout.Space(10);

                        sourceVariation = StyledSourcePopup("Variation", "Variation mask used for wind animation and global effects. Stored in Vertex Red.", sourceVariation, SourceMaskEnum);
                        textureVariation = StyledTexture("Variation", "", sourceVariation, textureVariation);
                        optionVariation = StyledMaskOptionEnum("Variation", "", sourceVariation, optionVariation, false);
                        coordVariation = StyledTextureCoord("Variation", "", sourceVariation, coordVariation);
                        actionVariation = StyledActionOptionEnum("Variation", "", sourceVariation, actionVariation, true);

                        sourceOcclusion = StyledSourcePopup("Occlusion", "Vertex Occlusion mask used to add depth and light scattering mask. Stored in Vertex Green.", sourceOcclusion, SourceMaskEnum);
                        textureOcclusion = StyledTexture("Occlusion", "", sourceOcclusion, textureOcclusion);
                        optionOcclusion = StyledMaskOptionEnum("Occlusion", "", sourceOcclusion, optionOcclusion, false);
                        coordOcclusion = StyledTextureCoord("Occlsuion", "", sourceOcclusion, coordOcclusion);
                        actionOcclusion = StyledActionOptionEnum("Occlusion", "", sourceOcclusion, actionOcclusion, true);

                        sourceDetail = StyledSourcePopup("Detail Mask", "Detail mask used for layer blending for bark. Stored in Vertex Blue.", sourceDetail, SourceMaskEnum);
                        textureDetail = StyledTexture("Detail Mask", "", sourceDetail, textureDetail);
                        optionDetail = StyledMaskOptionEnum("Detail Mask", "", sourceDetail, optionDetail, false);
                        coordDetail = StyledTextureCoord("Detail Mask", "", sourceDetail, coordDetail);
                        actionDetail = StyledActionOptionEnum("Detail Mask", "", sourceDetail, actionDetail, true);

                        GUILayout.Space(10);

                        sourceHeight = StyledSourcePopup("Height Mask", "Multi mask used for bending motion, gradient colors for leaves and subsurface/overlay mask for grass. The default value is set to height. Stored in Vertex Alpha.", sourceHeight, SourceMaskEnum);
                        textureHeight = StyledTexture("Height Mask", "", sourceHeight, textureHeight);
                        optionHeight = StyledMaskOptionEnum("Height Mask", "", sourceHeight, optionHeight, false);
                        coordHeight = StyledTextureCoord("Height Mask", "", sourceHeight, coordHeight);
                        actionHeight = StyledActionOptionEnum("Height Mask", "", sourceHeight, actionHeight, true);

                        sourceMotion2 = StyledSourcePopup("Branch Mask", "Motion mask used for squash animations. Stored in UV0.Z as a packed mask.", sourceMotion2, SourceMaskEnum);
                        textureMotion2 = StyledTexture("Branch Mask", "", sourceMotion2, textureMotion2);
                        optionMotion2 = StyledMaskOptionEnum("Branch Mask", "", sourceMotion2, optionMotion2, false);
                        coordMotion2 = StyledTextureCoord("Branch Mask", "", sourceMotion2, coordMotion2);
                        actionMotion2 = StyledActionOptionEnum("Branch Mask", "", sourceMotion2, actionMotion2, true);

                        sourceMotion3 = StyledSourcePopup("Flutter Mask", "Motion mask used for flutter animation. Stored in UV0.Z as a packed mask.", sourceMotion3, SourceMaskEnum);
                        textureMotion3 = StyledTexture("Flutter Mask", "", sourceMotion3, textureMotion3);
                        optionMotion3 = StyledMaskOptionEnum("Flutter Mask", "", sourceMotion3, optionMotion3, false);
                        coordMotion3 = StyledTextureCoord("Flutter Mask", "", sourceMotion3, coordMotion3);
                        actionMotion3 = StyledActionOptionEnum("Flutter Mask", "", sourceMotion3, actionMotion3, true);

                        GUILayout.Space(10);

                        sourcePivots = StyledSourcePopup("Pivot Positions", "Pivots storing for grass when multiple grass blades are combined into a single mesh. Stored in UV4.XZY.", sourcePivots, SourcePivotsEnum);
                        optionPivots = StyledPivotsOptionEnum("Pivot Positions", "", sourcePivots, optionPivots);

                        GUILayout.Space(10);

                        if (EditorGUI.EndChangeCheck())
                        {
                            hasMeshModifications = true;
                        }
                    }

                    if (outputMeshIndex == OutputMesh.Custom)
                    {
                        GUILayout.Space(10);
                        StyledGUI.DrawWindowCategory("Mesh Settings");
                        GUILayout.Space(10);

                        if (hasMeshModifications)
                        {
                            EditorGUILayout.HelpBox("The mesh settings have been overriden and they will not update when changing the preset or adding overrides!", MessageType.Info, true);
                            GUILayout.Space(10);
                        }

                        EditorGUI.BeginChangeCheck();

                        readWriteMode = StyledPopup("ReadWrite Mode", "Set meshes readable mode.", readWriteMode, ReadWriteModeEnum);

                        sourceBounds = StyledSourcePopup("Bounds", "Mesh vertex bounds override.", sourceBounds, SourceBoundsEnum);
                        optionBounds = StyledBoundsOptionEnum("Bounds", "", sourceBounds, optionBounds);

                        sourceNormals = StyledSourcePopup("Normals", "", sourceNormals, SourceNormalsEnum);
                        optionNormals = StyledNormalsOptionEnum("Normals", "", sourceNormals, optionNormals);

                        GUILayout.Space(10);

                        sourceVariation = StyledSourcePopup("Vertex Red", "", sourceVariation, SourceMaskEnum);
                        textureVariation = StyledTexture("Vertex Red", "", sourceVariation, textureVariation);
                        optionVariation = StyledMaskOptionEnum("Vertex Red", "", sourceVariation, optionVariation, false);
                        coordVariation = StyledTextureCoord("Vertex Red", "", sourceVariation, coordVariation);
                        actionVariation = StyledActionOptionEnum("Vertex Red", "", sourceVariation, actionVariation, true);

                        sourceOcclusion = StyledSourcePopup("Vertex Green", "", sourceOcclusion, SourceMaskEnum);
                        textureOcclusion = StyledTexture("Vertex Green", "", sourceOcclusion, textureOcclusion);
                        optionOcclusion = StyledMaskOptionEnum("Vertex Green", "", sourceOcclusion, optionOcclusion, false);
                        coordOcclusion = StyledTextureCoord("Vertex Green", "", sourceOcclusion, coordOcclusion);
                        actionOcclusion = StyledActionOptionEnum("Vertex Green", "", sourceOcclusion, actionOcclusion, true);

                        sourceDetail = StyledSourcePopup("Vertex Blue", "", sourceDetail, SourceMaskEnum);
                        textureDetail = StyledTexture("Vertex Blue", "", sourceDetail, textureDetail);
                        optionDetail = StyledMaskOptionEnum("Vertex Blue", "", sourceDetail, optionDetail, false);
                        coordDetail = StyledTextureCoord("Vertex Blue", "", sourceDetail, coordDetail);
                        actionDetail = StyledActionOptionEnum("Vertex Blue", "", sourceDetail, actionDetail, true);

                        sourceHeight = StyledSourcePopup("Vertex Alpha", "", sourceHeight, SourceMaskEnum);
                        textureHeight = StyledTexture("Vertex Blue", "", sourceHeight, textureHeight);
                        optionHeight = StyledMaskOptionEnum("Vertex Alpha", "", sourceHeight, optionHeight, false);
                        coordHeight = StyledTextureCoord("Vertex Alpha", "", sourceHeight, coordHeight);
                        actionHeight = StyledActionOptionEnum("Vertex Alpha", "", sourceHeight, actionHeight, true);

                        if (EditorGUI.EndChangeCheck())
                        {
                            hasMeshModifications = true;
                        }
                    }

                    if (outputMeshIndex == OutputMesh.DEEnvironment)
                    {
                        GUILayout.Space(10);
                        StyledGUI.DrawWindowCategory("Mesh Settings");
                        GUILayout.Space(10);

                        if (hasMeshModifications)
                        {
                            EditorGUILayout.HelpBox("The mesh settings have been overriden and they will not update when changing the preset or adding overrides!", MessageType.Info, true);
                            GUILayout.Space(10);
                        }

                        EditorGUI.BeginChangeCheck();

                        readWriteMode = StyledPopup("ReadWrite Mode", "Set meshes readable mode.", readWriteMode, ReadWriteModeEnum);

                        sourceBounds = StyledSourcePopup("Bounds", "Mesh vertex bounds override.", sourceBounds, SourceBoundsEnum);
                        optionBounds = StyledBoundsOptionEnum("Bounds", "", sourceBounds, optionBounds);

                        sourceNormals = StyledSourcePopup("Normals", "", sourceNormals, SourceNormalsEnum);
                        optionNormals = StyledNormalsOptionEnum("Normals", "", sourceNormals, optionNormals);

                        GUILayout.Space(10);

                        sourceVariation = StyledSourcePopup("Variation", "", sourceVariation, SourceMaskEnum);
                        textureVariation = StyledTexture("Variation", "", sourceVariation, textureVariation);
                        optionVariation = StyledMaskOptionEnum("Variation", "", sourceVariation, optionVariation, false);
                        coordVariation = StyledTextureCoord("Variation", "", sourceVariation, coordVariation);
                        actionVariation = StyledActionOptionEnum("Variation", "", sourceVariation, actionVariation, true);

                        sourceOcclusion = StyledSourcePopup("Occlusion", "", sourceOcclusion, SourceMaskEnum);
                        textureOcclusion = StyledTexture("Occlusion", "", sourceOcclusion, textureOcclusion);
                        optionOcclusion = StyledMaskOptionEnum("Occlusion", "", sourceOcclusion, optionOcclusion, false);
                        coordOcclusion = StyledTextureCoord("Occlusion", "", sourceOcclusion, coordOcclusion);
                        actionOcclusion = StyledActionOptionEnum("Occlusion", "", sourceOcclusion, actionOcclusion, true);

                        sourceHeight = StyledSourcePopup("Height Mask", "Height mask used for bending animation.", sourceHeight, SourceMaskEnum);
                        textureHeight = StyledTexture("Height Mask", "", sourceHeight, textureHeight);
                        optionHeight = StyledMaskOptionEnum("Height Mask", "", sourceHeight, optionHeight, false);
                        coordHeight = StyledTextureCoord("Height Mask", "", sourceHeight, coordHeight);
                        actionHeight = StyledActionOptionEnum("Height Mask", "", sourceHeight, actionHeight, true);

                        sourceMotion3 = StyledSourcePopup("Flutter Mask", "Motion mask used for flutter animation.", sourceMotion3, SourceMaskEnum);
                        textureMotion3 = StyledTexture("Flutter Mask", "", sourceMotion3, textureMotion3);
                        optionMotion3 = StyledMaskOptionEnum("Flutter Mask", "", sourceMotion3, optionMotion3, false);
                        coordMotion3 = StyledTextureCoord("Flutter Mask", "", sourceMotion3, coordMotion3);
                        actionMotion3 = StyledActionOptionEnum("Flutter Mask", "", sourceMotion3, actionMotion3, true);

                        if (EditorGUI.EndChangeCheck())
                        {
                            hasMeshModifications = true;
                        }
                    }
                }
            }
        }

        void DrawConversionButtons()
        {
            GUILayout.Space(10);
            GUILayout.BeginHorizontal();

            if (convertedPrefabCount == 0)
            {
                GUI.enabled = false;
            }
            else
            {
                GUI.enabled = true;
            }

            if (GUILayout.Button("Revert", GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 2)))
            {
                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    var data = prefabObjects[i];

                    if (data.status == PrefabStatus.Converted)
                    {
                        prefabObject = prefabObjects[i].gameObject;

                        RevertPrefab(true);
                    }
                }

                GetPrefabObjects();
            }

            if (supportedPrefabCount + convertedPrefabCount == 0)
            {
                GUI.enabled = false;
            }
            else
            {
                if (presetIndex == 0 || outputValid == false || !isValid || EditorSettings.serializationMode != UnityEditor.SerializationMode.ForceText)
                {
                    GUI.enabled = false;
                }
                else
                {
                    GUI.enabled = true;
                }
            }

            if (GUILayout.Button("Convert"))
            {
                if (convertedPrefabCount > 0)
                {
                    keepConvertedMaterials = EditorUtility.DisplayDialog("Keep Converted Materials?", "When enabled, the prefab converter will only convert the meshes and keep the converted materials and textures from the previous conversion if available!", "Keep Converted Materials", "No");
                }

                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    var data = prefabObjects[i];

                    if (data.status == PrefabStatus.Converted || data.status == PrefabStatus.Supported)
                    {
                        prefabObject = prefabObjects[i].gameObject;

                        if (data.status == PrefabStatus.Converted)
                        {
                            RevertPrefab(false);
                        }

                        ConvertPrefab();
                    }
                }

                GetPrefabObjects();

                EditorUtility.ClearProgressBar();
            }

            if (collectiblePrefabCount == 0)
            {
                GUI.enabled = false;
            }
            else
            {
                GUI.enabled = true;
            }

            if (StyledMiniToggleButton("", "Collect Converted Data", 12, false))
            {
                var latestDataFolder = SettingsUtils.LoadSettingsData(userFolder + "Converter Latest.asset", "Assets");

                if (!Directory.Exists(latestDataFolder))
                {
                    latestDataFolder = "Assets";
                }

                //if (showFolderSelectionDialogue)
                //{
                projectDataFolder = EditorUtility.OpenFolderPanel("Save Converted Assets to Folder", latestDataFolder, "");

                if (projectDataFolder != "")
                {
                    projectDataFolder = "Assets" + projectDataFolder.Substring(Application.dataPath.Length);
                }
                //}
                //else
                //{
                //    if (latestDataFolder == "Assets")
                //    {
                //        projectDataFolder = EditorUtility.OpenFolderPanel("Save Converted Assets to Folder", latestDataFolder, "");

                //        if (projectDataFolder != "")
                //        {
                //            projectDataFolder = "Assets" + projectDataFolder.Substring(Application.dataPath.Length);
                //        }
                //    }
                //    else
                //    {
                //        projectDataFolder = latestDataFolder;
                //    }
                //}

                if (projectDataFolder != "")
                {
                    if (!Directory.Exists(projectDataFolder))
                    {
                        Directory.CreateDirectory(projectDataFolder);
                        AssetDatabase.Refresh();
                    }

#if !THE_VEGETATION_ENGINE_DEVELOPMENT

                    SettingsUtils.SaveSettingsData(userFolder + "Converter Latest.asset", projectDataFolder);

#endif

                    CreateAssetsDataSubFolders();

                    shareCommonMaterials = EditorUtility.DisplayDialog("Share Common Materials?", "When enabled, the common materials are shared across multiple assets! When disabled, the converter will save new materials for each prefab!", "Share Common Materials", "No");
                }
                else
                {
                    GUIUtility.ExitGUI();
                    return;
                }

                for (int i = 0; i < prefabObjects.Count; i++)
                {
                    var prefabData = prefabObjects[i];

                    if (prefabData.status == PrefabStatus.Converted || prefabData.status == PrefabStatus.ConvertedMissingBackup)
                    {
                        prefabObject = prefabObjects[i].gameObject;

                        CollectPrefab();
                    }
                }

                GetPrefabObjects();
            }

            var lastRect = GUILayoutUtility.GetLastRect();
            var iconRect = new Rect(lastRect.x, lastRect.y - 1, GUI_SQUARE_BUTTON_WIDTH, GUI_SQUARE_BUTTON_WIDTH);

            if (EditorGUIUtility.isProSkin)
            {
                GUI.color = new Color(0.7f, 1f, 0.3f);
            }
            else
            {
                GUI.color = new Color(0.6f, 0.8f, 0.0f);
            }


            GUI.Label(iconRect, EditorGUIUtility.IconContent("d_Package Manager@2x"));
            GUI.color = Color.white;

            GUILayout.EndHorizontal();
            GUI.enabled = true;
        }

        void StyledPrefab(TVEPrefabData prefabData)
        {
            if (prefabData.status == PrefabStatus.Converted)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    GUILayout.Label("<size=10><b><color=#f6d161>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    GUILayout.Label("<size=10><b><color=#e16f00>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
            }

            if (prefabData.status == PrefabStatus.Supported)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    GUILayout.Label("<size=10><b><color=#87b8ff>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    GUILayout.Label("<size=10><b><color=#0b448b>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
            }

            if (prefabData.status == PrefabStatus.ConvertedAndCollected)
            {
                if (EditorGUIUtility.isProSkin)
                {
                    GUILayout.Label("<size=10><b><color=#b7d63c>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
                else
                {
                    GUILayout.Label("<size=10><b><color=#408800>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
                }
            }

            if (prefabData.status == PrefabStatus.Unsupported || prefabData.status == PrefabStatus.Backup || prefabData.status == PrefabStatus.ConvertedMissingBackup)
            {
                GUILayout.Label("<size=10><b><color=#808080>" + prefabData.gameObject.name + "</color></b></size>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));
            }

            var lastRect = GUILayoutUtility.GetLastRect();

            if (GUI.Button(lastRect, "", GUIStyle.none))
            {
                EditorGUIUtility.PingObject(prefabData.gameObject);
            }

            if (prefabData.status == PrefabStatus.Unsupported)
            {
                var iconRect = new Rect(lastRect.width - 18, lastRect.y + 2, 20, 20);

                GUI.Label(iconRect, EditorGUIUtility.IconContent("console.warnicon.sml"));
                GUI.Label(iconRect, new GUIContent("", "SpeedTree, Tree Creator, Models or any other asset type prefabs cannot be converted directly, you will need to drag the asset into the hierarchy then back to the project window to create a regular prefab!"));
            }

            if (prefabData.status == PrefabStatus.Backup)
            {
                var iconRect = new Rect(lastRect.width - 18, lastRect.y + 2, 20, 20);

                GUI.Label(iconRect, EditorGUIUtility.IconContent("console.warnicon.sml"));
                GUI.Label(iconRect, new GUIContent("", "The prefab is a backup file used to revert the converted prefab!"));
            }

            if (prefabData.status == PrefabStatus.ConvertedMissingBackup)
            {
                var iconRect = new Rect(lastRect.width - 18, lastRect.y + 2, 20, 20);

                GUI.Label(iconRect, EditorGUIUtility.IconContent("console.erroricon.sml"));
                GUI.Label(iconRect, new GUIContent("", "The prefab cannot be reverted or reconverted because the backup file is missing!"));
            }

            if (prefabData.status == PrefabStatus.ConvertedAndCollected)
            {
                var iconRect = new Rect(lastRect.width - 18, lastRect.y + 2, 20, 20);

                GUI.Label(iconRect, EditorGUIUtility.IconContent("console.infoicon.sml"));
                GUI.Label(iconRect, new GUIContent("", "The prefab is collected. Select the parent prefab if you want to re-convert or re-collect the assets!"));
            }
        }

        int StyledPopup(string name, string tooltip, int index, string[] options)
        {
            if (index >= options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(new GUIContent(name, tooltip), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
            index = EditorGUILayout.Popup(index, options, stylePopup);
            GUILayout.EndHorizontal();

            return index;
        }

        int StyledPresetPopup(string name, string tooltip, int index, string[] options)
        {
            if (index >= options.Length)
            {
                index = 0;
            }

            GUILayout.BeginHorizontal();
            GUILayout.Label(new GUIContent(name, tooltip), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
            index = EditorGUILayout.Popup(index, options, stylePopup);

            var lastRect = GUILayoutUtility.GetLastRect();
            GUI.Label(lastRect, new GUIContent("", options[index]));

            GUILayout.EndHorizontal();

            return index;
        }

        int StyledSourcePopup(string name, string tooltip, int index, string[] options)
        {
            index = StyledPopup(name + " Source", tooltip, index, options);

            return index;
        }

        int StyledActionOptionEnum(string name, string tooltip, int source, int option, bool space)
        {
            if (source > 0)
            {
                option = StyledPopup(name + " Action", tooltip, option, SourceActionEnum);
            }

            if (space)
            {
                GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        int StyledMaskOptionEnum(string name, string tooltip, int source, int option, bool space)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourceMaskMeshEnum);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceMaskProceduralEnum);
            }
            if (source == 3)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourceFromTextureEnum);
            }
            if (source == 4)
            {
                option = StyledPopup(name + " 3rd Party", tooltip, option, SourceMask3rdPartyEnum);
            }

            if (space)
            {
                GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        Texture2D StyledTexture(string name, string tooltip, int source, Texture2D texture)
        {
            if (source == 3)
            {
                GUILayout.BeginHorizontal();
                GUILayout.Label(new GUIContent(name + " Texture", ""), GUILayout.Width(GUI_HALF_EDITOR_WIDTH - 5));
                texture = (Texture2D)EditorGUILayout.ObjectField(texture, typeof(Texture2D), false);
                GUILayout.EndHorizontal();
            }

            return texture;
        }

        int StyledTextureCoord(string name, string tooltip, int sourceTexture, int option)
        {
            if (sourceTexture == 3)
            {
                option = StyledPopup(name + " Coord", tooltip, option, SourceCoordMeshEnum);
            }

            return option;
        }

        int StyledCoordOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Channel", tooltip, option, SourceCoordMeshEnum);
            }
            if (source == 2)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceCoordProceduralEnum);
            }
            if (source == 3)
            {
                option = StyledPopup(name + " 3rd Party", tooltip, option, SourceCoord3rdPartyEnum);
            }

            GUILayout.Space(GUI_SPACE_SMALL);

            return option;
        }

        int StyledPivotsOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourcePivotsProceduralEnum);
                GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        int StyledNormalsOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceNormalsProceduralEnum);
                GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        int StyledBoundsOptionEnum(string name, string tooltip, int source, int option)
        {
            if (source == 1)
            {
                option = StyledPopup(name + " Procedural", tooltip, option, SourceBoundsProceduralEnum);
                GUILayout.Space(GUI_SPACE_SMALL);
            }

            return option;
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            return value;
        }

        bool StyledMiniToggleButton(string text, string tooltip, int size, bool value)
        {
            value = GUILayout.Toggle(value, new GUIContent("<size=" + size + ">" + text + "</size>", tooltip), styleMiniToggleButton, GUILayout.MaxWidth(GUI_SQUARE_BUTTON_WIDTH), GUILayout.MaxHeight(GUI_SQUARE_BUTTON_HEIGHT));

            return value;
        }

        /// <summary>
        /// Convert and Revert Macros
        /// </summary>

        void ConvertPrefab()
        {
            prefabName = prefabObject.name;

            string dataPath;
            string savePath = "/" + prefabName + ".prefab";

            dataPath = AssetDatabase.GetAssetPath(prefabObject);
            dataPath = Path.GetDirectoryName(dataPath);
            dataPath = dataPath + savePath;
            prefabDataFolder = dataPath;

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Prepare Prefab", 0.0f);

            var prefabScale = prefabObject.transform.localScale;

            prefabInstance = Instantiate(prefabObject);
            prefabInstance.transform.localPosition = Vector3.zero;
            prefabInstance.transform.rotation = Quaternion.identity;
            prefabInstance.transform.localScale = Vector3.one;
            prefabInstance.AddComponent<TVEPrefab>();

            var prefabComponent = prefabInstance.GetComponent<TVEPrefab>();

            prefabComponent.storedPreset = PresetsEnum[presetIndex] + ";" + OptionsEnum[optionIndex];

            for (int i = 0; i < overrideIndices.Count; i++)
            {
                if (overrideIndices[i] != 0)
                {
                    prefabComponent.storedOverrides = prefabComponent.storedOverrides + OverridesEnum[overrideIndices[i]] + ";";
                }
            }

            prefabComponent.storedOverrides.Replace("None", "");

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Create Backup", 0.1f);

            CreatePrefabDataFolder(false);
            CreatePrefabBackupFile();

            prefabComponent.storedPrefabBackupGUID = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(prefabBackup));

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Prepare Assets", 0.2f);

            GetGameObjectsInPrefab();
            FixInvalidPrefabScripts();

            DisableInvalidGameObjectsInPrefab();

            GetMeshRenderersInPrefab();
            GetMaterialArraysInPrefab();

            GetMeshFiltersInPrefab();
            GetMeshesInPrefab();
            CreateMeshInstances();

            GetMeshCollidersInPrefab();
            GetCollidersInPrefab();
            CreateColliderInstances();

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Transform Space", 0.3f);

            if (outputMeshIndex != OutputMesh.Off)
            {
                if (outputTransformIndex == OutputTransform.TransformToWorldSpace)
                {
                    TransformMeshesToWorldSpace();
                }
            }

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Get Bounds", 0.4f);

            GetMaxBoundsInPrefab();

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Convert Materials", 0.6f);

            if (outputMaterialIndex != OutputMaterial.Off)
            {
                CreateMaterialArraysInstances();
                ConvertMaterials();
            }

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Convert Meshes", 0.8f);

            ConvertMeshes();
            ConvertColliders();

            prefabInstance.transform.localScale = prefabScale;

            EnableInvalidGameObjectsInPrefab();

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Save Prefab", 0.9f);

            SavePrefab(prefabInstance, prefabObject, true);
            EditorGUIUtility.PingObject(prefabObject);

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            EditorUtility.DisplayProgressBar("The Vegetation Engine", prefabObject.name + ": Finish Conversion", 1.0f);

            DestroyImmediate(prefabInstance);
        }

        void CollectPrefab()
        {
            prefabName = prefabObject.name;

            string dataPath;
            string savePath = "/" + prefabName + ".prefab";

            dataPath = projectDataFolder + savePath;

            prefabInstance = Instantiate(prefabObject);
            var prefabComponent = prefabInstance.GetComponent<TVEPrefab>();

            prefabComponent.storedPrefabBackupGUID = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(prefabObject));
            prefabComponent.isCollected = true;

            CreatePrefabDataFolder(true);
            GetGameObjectsInPrefab();

            GetMeshRenderersInPrefab();
            GetMaterialArraysInPrefab();

            GetMeshFiltersInPrefab();
            GetMeshesInPrefab();
            GetMeshCollidersInPrefab();
            GetCollidersInPrefab();

            CollectMaterials();
            CollectMeshes();
            CollectColliders();

            if (File.Exists(dataPath))
            {
                PrefabUtility.SaveAsPrefabAssetAndConnect(prefabInstance, dataPath, InteractionMode.AutomatedAction);
                EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<GameObject>(dataPath));
            }
            else
            {
                PrefabUtility.SaveAsPrefabAsset(prefabInstance, dataPath);
                EditorGUIUtility.PingObject(AssetDatabase.LoadAssetAtPath<GameObject>(dataPath));
            }

            AssetDatabase.SetLabels(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(dataPath), new string[] { outputSuffix + " Prefab" });

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            DestroyImmediate(prefabInstance);
        }

        void RevertPrefab(bool deleteConvertedAssets)
        {
            var prefabBackup = GetPrefabBackupFile(prefabObject);

            prefabInstance = Instantiate(prefabBackup);

            GetGameObjectsInPrefab();
            FixInvalidPrefabScripts();

            SavePrefab(prefabInstance, prefabObject, false);

            if (deleteConvertedAssets)
            {
                // Cleaup converted data on revert
                var prefabPath = AssetDatabase.GetAssetPath(prefabObject);
                var standalonePath = prefabPath.Replace(Path.GetFileName(prefabPath), "") + prefabObject.name;
                //var collectedPath = prefabPath.Replace(Path.GetFileName(prefabPath), "") + PREFABS_DATA_PATH + "/" + prefabObject.name;

                try
                {
                    FileUtil.DeleteFileOrDirectory(standalonePath);
                    FileUtil.DeleteFileOrDirectory(standalonePath + ".meta");
                    //FileUtil.DeleteFileOrDirectory(collectedPath);
                }
                catch
                {
                    Debug.Log("<b>[The Vegetation Engine]</b> " + "The converted prefab data cannot be deleted on revert!");
                }
            }

            //AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            DestroyImmediate(prefabInstance);
        }

        void SavePrefab(GameObject prefabInstance, GameObject prefabObject, bool setLabel)
        {
            //PrefabUtility.ReplacePrefab(prefabInstance, prefabObject, ReplacePrefabOptions.ReplaceNameBased);

            var prefabPath = AssetDatabase.GetAssetPath(prefabObject);

            PrefabUtility.SaveAsPrefabAssetAndConnect(prefabInstance, prefabPath, InteractionMode.AutomatedAction);

            if (setLabel)
            {
                AssetDatabase.SetLabels(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(prefabPath), new string[] { outputSuffix + " Prefab" });
            }
        }

        /// <summary>
        /// Get GameObjects, Materials and MeshFilters in Prefab
        /// </summary>

        void CreateAssetsDataSubFolders()
        {
            if (!Directory.Exists(projectDataFolder + PREFABS_DATA_PATH))
            {
                Directory.CreateDirectory(projectDataFolder + PREFABS_DATA_PATH);
            }

            if (!Directory.Exists(projectDataFolder + SHARED_DATA_PATH))
            {
                Directory.CreateDirectory(projectDataFolder + SHARED_DATA_PATH);
            }

            if (!Directory.Exists(projectDataFolder + TEXTURE_DATA_PATH))
            {
                Directory.CreateDirectory(projectDataFolder + TEXTURE_DATA_PATH);
            }

            AssetDatabase.Refresh();
        }

        void GetPrefabObjects()
        {
            prefabObjects = new List<TVEPrefabData>();
            convertedPrefabCount = 0;
            supportedPrefabCount = 0;
            collectiblePrefabCount = 0;
            validPrefabCount = 0;

            for (int i = 0; i < Selection.gameObjects.Length; i++)
            {
                var selection = Selection.gameObjects[i];
                var prefabData = GetPrefabData(selection);

                bool prefabDataExists = false;

                for (int j = 0; j < prefabObjects.Count; j++)
                {
                    if (prefabObjects[j].gameObject == prefabData.gameObject)
                    {
                        prefabDataExists = true;
                    }
                }

                if (!prefabDataExists)
                {
                    prefabObjects.Add(prefabData);
                }

                if (prefabData.status == PrefabStatus.Converted)
                {
                    convertedPrefabCount++;
                }

                if (prefabData.status == PrefabStatus.Supported)
                {
                    supportedPrefabCount++;
                }

                if (prefabData.status == PrefabStatus.Converted || prefabData.status == PrefabStatus.ConvertedMissingBackup)
                {
                    collectiblePrefabCount++;
                }

                validPrefabCount = convertedPrefabCount + supportedPrefabCount + collectiblePrefabCount;
            }
        }

        void GetPrefabPresets()
        {
            presetMixedValues = false;
            presetAutoDetected = false;

            var presetIndices = new int[prefabObjects.Count];

            if (prefabObjects.Count > 0)
            {
                for (int o = 0; o < prefabObjects.Count; o++)
                {
                    var prefabObject = prefabObjects[o];
                    var prefabComponent = prefabObject.gameObject.GetComponent<TVEPrefab>();

                    if (prefabComponent != null)
                    {
                        if (prefabComponent.storedPreset != "")
                        {
                            // Get new style presets
                            if (prefabComponent.storedPreset.Contains(";"))
                            {
                                var splitLine = prefabComponent.storedPreset.Split(char.Parse(";"));

                                var preset = splitLine[0];
                                var option = splitLine[1];

                                for (int i = 0; i < PresetsEnum.Length; i++)
                                {
                                    if (preset == PresetsEnum[i])
                                    {
                                        presetIndex = i;
                                        presetIndices[o] = i;

                                        GetAllPresetInfo();

                                        for (int j = 0; j < OptionsEnum.Length; j++)
                                        {
                                            if (option == OptionsEnum[j])
                                            {
                                                optionIndex = j;
                                            }
                                        }
                                    }
                                }
                            }
                            // Try get old style presets
                            else
                            {
                                var splitLine = prefabComponent.storedPreset.Split(char.Parse("/"));

                                var option = splitLine[splitLine.Length - 1];
                                var preset = prefabComponent.storedPreset.Replace("/" + option, "");

                                for (int i = 0; i < PresetsEnum.Length; i++)
                                {
                                    if (prefabComponent.storedPreset == PresetsEnum[i] || preset == PresetsEnum[i])
                                    {
                                        presetIndex = i;
                                        presetIndices[o] = i;

                                        GetAllPresetInfo();

                                        for (int j = 0; j < OptionsEnum.Length; j++)
                                        {
                                            if (option == OptionsEnum[j])
                                            {
                                                optionIndex = j;
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        if (prefabComponent.storedOverrides != "")
                        {
                            var splitLine = prefabComponent.storedOverrides.Split(char.Parse(";"));

                            for (int i = 0; i < splitLine.Length; i++)
                            {
                                for (int j = 0; j < OverridesEnum.Length; j++)
                                {
                                    if (splitLine[i] == OverridesEnum[j])
                                    {
                                        if (!overrideIndices.Contains(j))
                                        {
                                            overrideIndices.Add(j);
                                            overrideGlobals.Add(false);
                                        }
                                    }
                                }
                            }
                        }

                        presetAutoDetected = false;
                    }
                    else
                    {
                        // Try to autodetect preset
                        for (int i = 0; i < detectLines.Count; i++)
                        {
                            if (detectLines[i].StartsWith("Detect"))
                            {
                                var detect = detectLines[i].Replace("Detect ", "").Split(new string[] { " && " }, System.StringSplitOptions.None);
                                var preset = detectLines[i + 1].Replace("Preset ", "").Replace(" - ", "/");

                                int detectCount = 0;

                                for (int d = 0; d < detect.Length; d++)
                                {
                                    var element = detect[d].ToUpperInvariant();

                                    if (element.StartsWith("!"))
                                    {
                                        element = element.Replace("!", "");

                                        if (!prefabObject.attributes.Contains(element))
                                        {
                                            detectCount++;
                                        }
                                    }
                                    else
                                    {
                                        if (prefabObject.attributes.Contains(element))
                                        {
                                            detectCount++;
                                        }
                                    }
                                }

                                if (detectCount == detect.Length)
                                {
                                    for (int j = 0; j < PresetsEnum.Length; j++)
                                    {
                                        if (PresetsEnum[j] == preset)
                                        {
                                            presetIndex = j;
                                            presetIndices[o] = (j);
                                            presetAutoDetected = true;

                                            //break;
                                        }
                                    }
                                }
                            }

                            //Debug.Log(currentPreset);
                        }
                    }
                }

                for (int i = 1; i < presetIndices.Length; i++)
                {
                    if (presetIndices[i - 1] != presetIndices[i])
                    {
                        presetIndex = 0;
                        presetMixedValues = true;

                        break;
                    }
                }
            }
        }

        string GetPrefabAttributes(TVEPrefabData prefabObject)
        {
            string attributes = "";

            attributes += AssetDatabase.GetAssetPath(prefabObject.gameObject) + ";";

            var gameObjects = new List<GameObject>();
            var meshRenderers = new List<MeshRenderer>();

            gameObjects.Add(prefabObject.gameObject);
            GetChildRecursive(prefabObject.gameObject, gameObjects);

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
                            if (!attributes.Contains(material.shader.name))
                            {
                                attributes += material.shader.name + ",";
                            }
                        }
                    }
                }
            }

            return attributes.ToUpperInvariant();
        }

        void CreatePrefabDataFolder(bool isCollected)
        {
            string dataPath;
            string savePath = "/" + prefabName;

            if (isCollected)
            {
                dataPath = projectDataFolder + PREFABS_DATA_PATH + savePath;

                //if (Directory.Exists(dataPath))
                //{
                //    FileUtil.DeleteFileOrDirectory(dataPath);
                //    FileUtil.DeleteFileOrDirectory(dataPath + ".meta");
                //    AssetDatabase.Refresh();
                //}
            }
            else
            {
                dataPath = AssetDatabase.GetAssetPath(prefabObject);
                dataPath = Path.GetDirectoryName(dataPath);
                dataPath = dataPath + savePath;
                prefabDataFolder = dataPath;
            }

            if (!Directory.Exists(dataPath))
            {
                Directory.CreateDirectory(dataPath);
                AssetDatabase.Refresh();
            }
        }

        void CreatePrefabBackupFile()
        {
            string dataPath;
            string savePath = "/" + prefabName + " (" + outputSuffix + " Backup).prefab";

            dataPath = prefabDataFolder + savePath;

            AssetDatabase.CopyAsset(AssetDatabase.GetAssetPath(prefabObject), dataPath);
            AssetDatabase.Refresh();

            prefabBackup = AssetDatabase.LoadAssetAtPath<GameObject>(dataPath);
        }

        TVEPrefabData GetPrefabData(GameObject selection)
        {
            TVEPrefabData prefabData = new TVEPrefabData();

            prefabData.gameObject = selection;
            prefabData.status = PrefabStatus.Undefined;

            if (PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection).Length > 0)
            {
                var prefabPath = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(selection);
                var prefabAsset = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);
                var prefabAssets = AssetDatabase.LoadAllAssetRepresentationsAtPath(prefabPath);
                var prefabType = PrefabUtility.GetPrefabAssetType(prefabAsset);

                if (prefabAssets.Length == 0)
                {
                    if (prefabType == PrefabAssetType.Regular || prefabType == PrefabAssetType.Variant)
                    {
                        var prefabComponent = prefabAsset.GetComponent<TVEPrefab>();

                        if (prefabComponent != null)
                        {
                            if (prefabComponent.isCollected)
                            {
                                prefabData.status = PrefabStatus.ConvertedAndCollected;
                            }
                            else
                            {
                                var prefabBackupGO = GetPrefabBackupFile(prefabAsset);

                                if (prefabBackupGO != null)
                                {
                                    prefabData.status = PrefabStatus.Converted;
                                }
                                else
                                {
                                    prefabData.status = PrefabStatus.ConvertedMissingBackup;
                                }
                            }
                        }
                        else
                        {
                            if (prefabPath.Contains("TVE Backup"))
                            {
                                prefabData.status = PrefabStatus.Backup;
                            }
                            else
                            {
                                prefabData.status = PrefabStatus.Supported;
                            }
                        }
                    }
                    else if (prefabType == PrefabAssetType.MissingAsset || prefabType == PrefabAssetType.NotAPrefab)
                    {
                        prefabData.status = PrefabStatus.Undefined;
                    }
                }
                else
                {
                    if (prefabType == PrefabAssetType.Model || prefabPath.EndsWith(".st") || prefabPath.EndsWith(".spm") || prefabPath.EndsWith(".prefab"))
                    {
                        prefabData.status = PrefabStatus.Unsupported;
                    }
                }

                prefabData.gameObject = prefabAsset;
            }
            else
            {
                prefabData.gameObject = selection;
                prefabData.status = PrefabStatus.Undefined;
            }

            if (prefabData.status == PrefabStatus.Supported)
            {
                prefabData.attributes = GetPrefabAttributes(prefabData);
            }

            return prefabData;
        }

        GameObject GetPrefabBackupFile(GameObject prefabInstance)
        {
            GameObject prefabBackupGO = null;

            var prefabBackupGUID = prefabInstance.GetComponent<TVEPrefab>().storedPrefabBackupGUID;

            if (prefabBackupGUID != null || prefabBackupGUID != "")
            {
                var prefabBackupPath = AssetDatabase.GUIDToAssetPath(prefabBackupGUID);
                prefabBackupGO = AssetDatabase.LoadAssetAtPath<GameObject>(prefabBackupPath);
            }

            // Get the backup if serialization changed
            if (prefabBackupGO == null)
            {
                var prefabPath = AssetDatabase.GetAssetPath(prefabInstance);
                var prefabName = Path.GetFileNameWithoutExtension(prefabPath);
                var prefabBackupName = prefabName + " (TVE Backup)";
                var prefabBackupAssets = AssetDatabase.FindAssets(prefabBackupName);

                if (prefabBackupAssets != null && prefabBackupAssets.Length > 0)
                {
                    var prefabBackupPath = AssetDatabase.GUIDToAssetPath(prefabBackupAssets[0]);
                    prefabBackupGO = AssetDatabase.LoadAssetAtPath<GameObject>(prefabBackupPath);
                }
            }

            return prefabBackupGO;
        }

        void GetGameObjectsInPrefab()
        {
            gameObjectsInPrefab = new List<GameObject>();
            gameObjectsInPrefab.Add(prefabInstance);

            GetChildRecursive(prefabInstance, gameObjectsInPrefab);
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

        void DisableInvalidGameObjectsInPrefab()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (gameObjectsInPrefab[i].name.Contains("Impostor") == true)
                {
                    gameObjectsInPrefab[i].SetActive(false);
                    Debug.Log("<b>[The Vegetation Engine]</b> " + "Impostor Mesh are not supported! The " + gameObjectsInPrefab[i].name + " gameobject remains unchanged!");
                }

                if (gameObjectsInPrefab[i].GetComponent<BillboardRenderer>() != null)
                {
                    gameObjectsInPrefab[i].SetActive(false);
                    Debug.Log("<b>[The Vegetation Engine]</b> " + "Billboard Renderers are not supported! The " + gameObjectsInPrefab[i].name + " gameobject has been disabled. You can manually enable them after the conversion is done!");
                }

                if (gameObjectsInPrefab[i].GetComponent<MeshRenderer>() != null)
                {
                    var material = gameObjectsInPrefab[i].GetComponent<MeshRenderer>().sharedMaterial;

                    if (material != null)
                    {
                        if (material.shader.name.Contains("BK/Billboards"))
                        {
                            gameObjectsInPrefab[i].SetActive(false);
                            Debug.Log("<b>[The Vegetation Engine]</b> " + "BK Billboard Renderers are not supported! The " + gameObjectsInPrefab[i].name + " gameobject has been disabled. You can manually enable them after the conversion is done!");
                        }
                    }
                }

                if (gameObjectsInPrefab[i].GetComponent<Tree>() != null)
                {
                    DestroyImmediate(gameObjectsInPrefab[i].GetComponent<Tree>());
                }
            }
        }

        void EnableInvalidGameObjectsInPrefab()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (gameObjectsInPrefab[i].name.Contains("Impostor") == true)
                {
                    gameObjectsInPrefab[i].SetActive(true);
                }
            }
        }

        void FixInvalidPrefabScripts()
        {
            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                GameObjectUtility.RemoveMonoBehavioursWithMissingScript(gameObjectsInPrefab[i]);
            }
        }

        void GetMeshRenderersInPrefab()
        {
            meshRenderersInPrefab = new List<MeshRenderer>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                if (IsValidGameObject(gameObjectsInPrefab[i]) && gameObjectsInPrefab[i].GetComponent<MeshRenderer>() != null)
                {
                    meshRenderersInPrefab.Add(gameObjectsInPrefab[i].GetComponent<MeshRenderer>());
                }
                else
                {
                    meshRenderersInPrefab.Add(null);
                }
            }
        }

        void GetMaterialArraysInPrefab()
        {
            materialArraysInPrefab = new List<Material[]>();

            for (int i = 0; i < meshRenderersInPrefab.Count; i++)
            {
                if (meshRenderersInPrefab[i] != null)
                {
                    materialArraysInPrefab.Add(meshRenderersInPrefab[i].sharedMaterials);
                }
                else
                {
                    materialArraysInPrefab.Add(null);
                }
            }
        }

        void CreateMaterialArraysInstances()
        {
            materialArraysInstances = new List<Material[]>();

            for (int i = 0; i < materialArraysInPrefab.Count; i++)
            {
                if (materialArraysInPrefab[i] != null)
                {
                    var originalMaterials = materialArraysInPrefab[i];
                    var instanceMaterials = new Material[originalMaterials.Length];

                    for (int j = 0; j < originalMaterials.Length; j++)
                    {
                        var originalMaterial = originalMaterials[j];

                        if (IsValidMaterial(originalMaterial))
                        {
                            bool useProjectMaterial = false;

                            var dataGUID = AssetDatabase.AssetPathToGUID(AssetDatabase.GetAssetPath(originalMaterial)).Substring(0, 2).ToUpper();

                            string dataPath = "";
                            string savePath = "/" + originalMaterial.name + " " + dataGUID + " (" + outputSuffix + " Material).mat";

                            if (keepConvertedMaterials)
                            {
                                dataPath = prefabDataFolder + savePath;

                                if (File.Exists(dataPath))
                                {
                                    useProjectMaterial = true;
                                }
                            }

                            if (useProjectMaterial)
                            {
                                instanceMaterials[j] = AssetDatabase.LoadAssetAtPath<Material>(dataPath);
                            }
                            else
                            {
                                instanceMaterials[j] = new Material(shaderLeaf);
                                instanceMaterials[j].name = originalMaterial.name + " " + dataGUID + " (" + outputSuffix + " Material)";
                                instanceMaterials[j].enableInstancing = true;
                            }
                        }
                        else
                        {
                            instanceMaterials[j] = originalMaterial;
                        }
                    }

                    materialArraysInstances.Add(instanceMaterials);
                }
                else
                {
                    materialArraysInstances.Add(null);
                }
            }
        }

        void GetMeshFiltersInPrefab()
        {
            meshFiltersInPrefab = new List<MeshFilter>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                var meshFilter = gameObjectsInPrefab[i].GetComponent<MeshFilter>();

                if (IsValidGameObject(gameObjectsInPrefab[i]) && meshFilter != null)
                {
                    meshFiltersInPrefab.Add(meshFilter);
                }
                else
                {
                    meshFiltersInPrefab.Add(null);
                }
            }
        }

        void GetMeshesInPrefab()
        {
            meshesInPrefab = new List<Mesh>();

            for (int i = 0; i < meshFiltersInPrefab.Count; i++)
            {
                if (meshFiltersInPrefab[i] != null)
                {
                    meshesInPrefab.Add(meshFiltersInPrefab[i].sharedMesh);
                }
                else
                {
                    meshesInPrefab.Add(null);
                }
            }
        }

        void CreateMeshInstances()
        {
            meshInstances = new List<Mesh>();

            for (int i = 0; i < meshFiltersInPrefab.Count; i++)
            {
                var mesh = meshesInPrefab[i];

                if (mesh != null)
                {
                    var meshSettings = TVEUtils.PreProcessMesh(mesh);

                    var meshName = System.Text.RegularExpressions.Regex.Replace(mesh.name, "[^\\w\\._ ()]", "");

                    var meshInstance = Instantiate(mesh);
                    meshInstance.name = meshName + " " + i.ToString("X2") + " (" + outputSuffix + " Model)";
                    meshInstances.Add(meshInstance);

                    TVEUtils.PostProcessMesh(mesh, meshSettings);
                }
                else
                {
                    meshInstances.Add(null);
                }
            }
        }

        void GetMeshCollidersInPrefab()
        {
            meshCollidersInPrefab = new List<MeshCollider>();

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                var allMeshCollider = gameObjectsInPrefab[i].GetComponents<MeshCollider>();

                if (IsValidGameObject(gameObjectsInPrefab[i]))
                {
                    for (int j = 0; j < allMeshCollider.Length; j++)
                    {
                        if (allMeshCollider[j] != null)
                        {
                            meshCollidersInPrefab.Add(allMeshCollider[j]);
                        }
                        else
                        {
                            meshCollidersInPrefab.Add(null);
                        }
                    }

                }
                else
                {
                    meshCollidersInPrefab.Add(null);
                }
            }
        }

        void GetCollidersInPrefab()
        {
            collidersInPrefab = new List<Mesh>();

            for (int i = 0; i < meshCollidersInPrefab.Count; i++)
            {
                if (meshCollidersInPrefab[i] != null)
                {
                    collidersInPrefab.Add(meshCollidersInPrefab[i].sharedMesh);
                }
                else
                {
                    collidersInPrefab.Add(null);
                }
            }
        }

        void CreateColliderInstances()
        {
            colliderInstances = new List<Mesh>();

            for (int i = 0; i < meshCollidersInPrefab.Count; i++)
            {
                var mesh = collidersInPrefab[i];

                if (mesh != null)
                {
                    var meshSettings = TVEUtils.PreProcessMesh(mesh);

                    var meshName = System.Text.RegularExpressions.Regex.Replace(mesh.name, "[^\\w\\._ ()]", "");

                    var colliderInstance = Instantiate(mesh);
                    colliderInstance.name = meshName + " " + i.ToString("X2") + " (" + outputSuffix + " Model)";
                    colliderInstances.Add(colliderInstance);

                    TVEUtils.PostProcessMesh(mesh, meshSettings);
                }
                else
                {
                    colliderInstances.Add(null);
                }
            }
        }

        void TransformMeshesToWorldSpace()
        {
            for (int i = 0; i < meshInstances.Count; i++)
            {
                if (meshInstances[i] != null)
                {
                    var instance = meshInstances[i];
                    var transforms = meshFiltersInPrefab[i].transform;

                    Vector3[] verticesOS = instance.vertices;
                    Vector3[] verticesWS = new Vector3[instance.vertices.Length];

                    // Transform vertioces OS pos to WS pos
                    for (int j = 0; j < verticesOS.Length; j++)
                    {
                        var trans = transforms.TransformDirection(verticesOS[j]);

                        verticesWS[j] = new Vector3(transforms.lossyScale.x * trans.x + transforms.position.x, transforms.lossyScale.y * trans.y + transforms.position.y, transforms.lossyScale.z * trans.z + transforms.position.z);
                    }

                    meshInstances[i].vertices = verticesWS;

                    //Some meshes don't have normals, check is needed
                    if (instance.normals != null && instance.normals.Length > 0)
                    {
                        Vector3[] normalsOS = instance.normals;
                        Vector3[] normalsWS = new Vector3[instance.vertices.Length];

                        for (int j = 0; j < normalsOS.Length; j++)
                        {
                            var trans = transforms.TransformDirection(normalsOS[j]);

                            normalsWS[j] = new Vector3(transforms.lossyScale.x * trans.x, transforms.lossyScale.y * trans.y, transforms.lossyScale.z * trans.z);
                        }

                        meshInstances[i].normals = normalsWS;
                    }

                    //Some meshes don't have tangenst, check is needed
                    if (instance.tangents != null && instance.tangents.Length > 0)
                    {
                        Vector4[] tangentsOS = instance.tangents;
                        Vector4[] tangentsWS = new Vector4[instance.vertices.Length];

                        for (int j = 0; j < tangentsOS.Length; j++)
                        {
                            tangentsWS[j] = transforms.TransformDirection(tangentsOS[j]);
                        }

                        meshInstances[i].tangents = tangentsWS;
                    }

                    meshInstances[i].RecalculateBounds();
                }
            }

            for (int i = 0; i < colliderInstances.Count; i++)
            {
                if (colliderInstances[i] != null)
                {
                    var instance = colliderInstances[i];
                    var transforms = meshCollidersInPrefab[i].gameObject.transform;

                    Vector3[] verticesOS = instance.vertices;
                    Vector3[] verticesWS = new Vector3[instance.vertices.Length];

                    // Transform vertioces OS pos to WS pos
                    for (int j = 0; j < verticesOS.Length; j++)
                    {
                        var trans = transforms.TransformDirection(verticesOS[j]);

                        verticesWS[j] = verticesWS[j] = new Vector3(transforms.lossyScale.x * trans.x + transforms.position.x, transforms.lossyScale.y * trans.y + transforms.position.y, transforms.lossyScale.z * trans.z + transforms.position.z);
                    }

                    colliderInstances[i].vertices = verticesWS;

                    // Some meshes don't have normals, check is needed
                    if (instance.normals != null && instance.normals.Length > 0)
                    {
                        Vector3[] normalsOS = instance.normals;
                        Vector3[] normalsWS = new Vector3[instance.vertices.Length];

                        for (int j = 0; j < normalsOS.Length; j++)
                        {
                            var trans = transforms.TransformDirection(normalsOS[j]);

                            normalsWS[j] = new Vector3(transforms.lossyScale.x * trans.x, transforms.lossyScale.y * trans.y, transforms.lossyScale.z * trans.z);
                        }

                        colliderInstances[i].normals = normalsWS;
                    }

                    colliderInstances[i].RecalculateTangents();
                    colliderInstances[i].RecalculateBounds();
                }
            }

            for (int i = 0; i < gameObjectsInPrefab.Count; i++)
            {
                //if (meshInstances[i] != null)
                {
                    gameObjectsInPrefab[i].transform.localPosition = Vector3.zero;
                    gameObjectsInPrefab[i].transform.localEulerAngles = Vector3.zero;
                    gameObjectsInPrefab[i].transform.localScale = Vector3.one;
                }
            }
        }

        void GetMaxBoundsInPrefab()
        {
            maxBoundsInfo = Vector4.zero;

            var bounds = new Bounds(Vector3.zero, Vector3.zero);

            for (int i = 0; i < meshInstances.Count; i++)
            {
                if (meshInstances[i] != null)
                {
                    bounds.Encapsulate(meshInstances[i].bounds);
                }
            }

            var maxX = Mathf.Max(Mathf.Abs(bounds.min.x), Mathf.Abs(bounds.max.x));
            var maxZ = Mathf.Max(Mathf.Abs(bounds.min.z), Mathf.Abs(bounds.max.z));

            var maxR = Mathf.Max(maxX, maxZ);
            var maxH = Mathf.Max(Mathf.Abs(bounds.min.y), Mathf.Abs(bounds.max.y));
            var maxS = Mathf.Max(maxR, maxH);

            maxBoundsInfo = new Vector4(maxR, maxH, maxS, 0.0f);
        }

        bool IsValidGameObject(GameObject gameObject)
        {
            bool valid = true;

            if (gameObject.activeInHierarchy == false)
            {
                valid = false;
            }

            return valid;
        }

        /// <summary>
        /// Mesh Packing Macros
        /// </summary>

        void ConvertColliders()
        {
            for (int i = 0; i < meshCollidersInPrefab.Count; i++)
            {
                if (meshCollidersInPrefab[i] != null && colliderInstances[i] != null)
                {
                    bool meshUnique = true;

                    for (int j = 0; j < meshesInPrefab.Count; j++)
                    {
                        if (collidersInPrefab[i] == meshesInPrefab[j])
                        {
                            meshCollidersInPrefab[i].sharedMesh = meshInstances[j];
                            meshUnique = false;

                            break;
                        }
                    }

                    if (meshUnique)
                    {
                        //SaveMesh(colliderInstances[i]);
                        meshCollidersInPrefab[i].sharedMesh = SaveMesh(colliderInstances[i], false, true);
                    }
                }
            }
        }

        void ConvertMeshes()
        {
            if (outputMeshIndex == OutputMesh.Off)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        GetMeshConversionWithTextures(i);
                        ConvertMeshOff(meshInstances[i], i);
                        ConvertMeshNormals(meshInstances[i], i, sourceNormals, optionNormals);
                        ConvertMeshBounds(meshInstances[i], sourceBounds, optionBounds);

                        //SaveMesh(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = SaveMesh(meshInstances[i], false, true);
                    }
                }
            }
            else if (outputMeshIndex == OutputMesh.Default)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        GetMeshConversionWithTextures(i);
                        ConvertMeshDefault(meshInstances[i], i);
                        ConvertMeshNormals(meshInstances[i], i, sourceNormals, optionNormals);
                        ConvertMeshBounds(meshInstances[i], sourceBounds, optionBounds);

                        //SaveMesh(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = SaveMesh(meshInstances[i], false, true);
                    }
                }
            }
            else if (outputMeshIndex == OutputMesh.Custom)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        GetMeshConversionWithTextures(i);
                        ConvertMeshCustom(meshInstances[i], i);
                        ConvertMeshNormals(meshInstances[i], i, sourceNormals, optionNormals);
                        ConvertMeshBounds(meshInstances[i], sourceBounds, optionBounds);

                        //SaveMesh(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = SaveMesh(meshInstances[i], false, true);
                    }
                }
            }
            else if (outputMeshIndex == OutputMesh.DEEnvironment)
            {
                for (int i = 0; i < meshInstances.Count; i++)
                {
                    if (meshInstances[i] != null)
                    {
                        GetMeshConversionWithTextures(i);
                        ConvertMeshDEEnvironment(meshInstances[i], i);
                        ConvertMeshNormals(meshInstances[i], i, sourceNormals, optionNormals);
                        ConvertMeshBounds(meshInstances[i], sourceBounds, optionBounds);

                        //SaveMesh(meshInstances[i]);
                        meshFiltersInPrefab[i].sharedMesh = SaveMesh(meshInstances[i], false, true);
                    }
                }
            }
        }

        void ConvertMeshOff(Mesh mesh, int index)
        {
            var vertexCount = mesh.vertexCount;

            var colors = GetVertexColors(mesh);
            var UV0 = GetCoordData(mesh, 0, 0);
            var UV2 = GetCoordData(mesh, 1, 1);
            var UV4 = GetCoordData(mesh, 0, 0);

            var mainCoord = GetCoordData(mesh, sourceMainCoord, optionMainCoord);
            var detailCoord = GetCoordData(mesh, sourceDetailCoord, optionDetailCoord);

            var height = GetMaskData(mesh, index, 2, 4, 0, null, null, 0, 1.0f);
            var detailMask = GetMaskData(mesh, index, sourceDetail, optionDetail, coordDetail, textureDetail, textureDetailList, actionDetail, 1f);

            var pivots = GetPivotsData(mesh, sourcePivots, optionPivots);

            for (int i = 0; i < vertexCount; i++)
            {
                colors[i] = new Color(1, 1, detailMask[i], height[i]);
                UV0[i] = new Vector4(mainCoord[i].x, mainCoord[i].y, TVEUtils.MathVector2ToFloat(1f, 1f), TVEUtils.MathVector2ToFloat(maxBoundsInfo.y / 100f, maxBoundsInfo.x / 100f));
                UV2[i] = new Vector4(UV2[i].x, UV2[i].y, detailCoord[i].x, detailCoord[i].y);
                UV4[i] = pivots[i];
            }

            mesh.SetColors(colors);
            mesh.SetUVs(0, UV0);
            mesh.SetUVs(1, UV2);
            mesh.SetUVs(3, UV4);
        }

        void ConvertMeshDefault(Mesh mesh, int index)
        {
            var vertexCount = mesh.vertexCount;

            var colors = new Color[vertexCount];
            var UV0 = GetCoordData(mesh, 0, 0);
            var UV2 = GetCoordData(mesh, 1, 1);
            var UV4 = GetCoordData(mesh, 0, 0);

            var mainCoord = GetCoordData(mesh, sourceMainCoord, optionMainCoord);
            var detailCoord = GetCoordData(mesh, sourceDetailCoord, optionDetailCoord);

            List<float> height;

            if (sourceHeight == 0)
            {
                height = GetMaskData(mesh, index, 2, 4, 0, null, null, 0, 1.0f);
            }
            else
            {
                height = GetMaskData(mesh, index, sourceHeight, optionHeight, coordHeight, textureHeight, textureHeightList, actionHeight, 1.0f);
            }

            var occlusion = GetMaskData(mesh, index, sourceOcclusion, optionOcclusion, coordOcclusion, textureOcclusion, textureOcclusionList, actionOcclusion, 1.0f);
            var variation = GetMaskData(mesh, index, sourceVariation, optionVariation, coordVariation, textureVariation, textureVariationList, actionVariation, 1.0f);
            var detailMask = GetMaskData(mesh, index, sourceDetail, optionDetail, coordDetail, textureDetail, textureDetailList, actionDetail, 1.0f);

            var motion2 = GetMaskData(mesh, index, sourceMotion2, optionMotion2, coordMotion2, textureMotion2, textureMotion2List, actionMotion2, 1.0f);
            var motion3 = GetMaskData(mesh, index, sourceMotion3, optionMotion3, coordMotion3, textureMotion3, textureMotion3List, actionMotion3, 1.0f);

            var pivots = GetPivotsData(mesh, sourcePivots, optionPivots);

            for (int i = 0; i < vertexCount; i++)
            {
                colors[i] = new Color(variation[i], occlusion[i], detailMask[i], height[i]);
                UV0[i] = new Vector4(mainCoord[i].x, mainCoord[i].y, TVEUtils.MathVector2ToFloat(motion2[i], motion3[i]), TVEUtils.MathVector2ToFloat(maxBoundsInfo.y / 100f, maxBoundsInfo.x / 100f));
                UV2[i] = new Vector4(UV2[i].x, UV2[i].y, detailCoord[i].x, detailCoord[i].y);
                UV4[i] = pivots[i];
            }


            mesh.SetColors(colors);
            mesh.SetUVs(0, UV0);
            mesh.SetUVs(1, UV2);
            mesh.SetUVs(3, UV4);
        }

        void ConvertMeshCustom(Mesh mesh, int index)
        {
            var vertexCount = mesh.vertexCount;

            var colors = new Color[vertexCount];

            var red = GetMaskData(mesh, index, sourceVariation, optionVariation, coordVariation, textureVariation, textureVariationList, actionVariation, 1.0f);
            var green = GetMaskData(mesh, index, sourceOcclusion, optionOcclusion, coordOcclusion, textureOcclusion, textureOcclusionList, actionOcclusion, 1.0f);
            var blue = GetMaskData(mesh, index, sourceDetail, optionDetail, coordDetail, textureDetail, textureDetailList, actionDetail, 1.0f);
            var alpha = GetMaskData(mesh, index, sourceHeight, optionHeight, coordHeight, textureHeight, textureHeightList, actionHeight, 1.0f);

            for (int i = 0; i < vertexCount; i++)
            {
                colors[i] = new Color(red[i], green[i], blue[i], alpha[i]);
            }

            mesh.SetColors(colors);
        }

        void ConvertMeshDEEnvironment(Mesh mesh, int index)
        {
            var vertexCount = mesh.vertexCount;

            var colors = new Color[vertexCount];

            var occlusion = GetMaskData(mesh, index, sourceOcclusion, optionOcclusion, coordOcclusion, textureOcclusion, textureOcclusionList, actionOcclusion, 1.0f);
            var variation = GetMaskData(mesh, index, sourceVariation, optionVariation, coordVariation, textureVariation, textureVariationList, actionVariation, 1.0f);
            var height = GetMaskData(mesh, index, sourceHeight, optionHeight, coordHeight, textureHeight, textureHeightList, actionHeight, 1.0f);
            var motion3 = GetMaskData(mesh, index, sourceMotion3, optionMotion3, coordMotion3, textureMotion3, textureMotion3List, actionMotion3, 1.0f);

            for (int i = 0; i < vertexCount; i++)
            {
                colors[i] = new Color(height[i], variation[i], motion3[i], occlusion[i]);
            }

            mesh.SetColors(colors);
        }

        void GetMeshConversionFromPreset()
        {
            if (presetIndex == 0)
            {
                return;
            }

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(presetLines[i]);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Mesh"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));
                        string name = "";
                        string source = "";
                        int sourceIndex = 0;
                        string option = "";
                        int optionIndex = 0;
                        string action = "";
                        int actionIndex = 0;
                        int coordIndex = 0;

                        if (splitLine.Length > 1)
                        {
                            name = splitLine[1];
                        }

                        if (splitLine.Length > 2)
                        {
                            source = splitLine[2];

                            if (source == "NONE")
                            {
                                sourceIndex = 0;
                            }

                            if (source == "AUTO")
                            {
                                sourceIndex = 0;
                            }

                            // Available options for Float masks
                            if (source == "GET_MASK_FROM_CHANNEL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_MASK_PROCEDURAL")
                            {
                                sourceIndex = 2;
                            }

                            if (source == "GET_MASK_FROM_TEXTURE")
                            {
                                sourceIndex = 3;
                            }

                            if (source == "GET_MASK_3RD_PARTY")
                            {
                                sourceIndex = 4;
                            }

                            // Available options for Coord masks
                            if (source == "GET_COORD_FROM_CHANNEL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_COORD_PROCEDURAL")
                            {
                                sourceIndex = 2;
                            }

                            if (source == "GET_COORD_3RD_PARTY")
                            {
                                sourceIndex = 3;
                            }

                            if (source == "GET_NORMALS_PROCEDURAL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_BOUNDS_PROCEDURAL")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "MARK_MESHES_AS_NON_READABLE")
                            {
                                sourceIndex = 0;
                            }

                            if (source == "MARK_MESHES_AS_READABLE")
                            {
                                sourceIndex = 1;
                            }

                            if (source == "GET_PIVOTS_PROCEDURAL")
                            {
                                sourceIndex = 1;
                            }
                        }

                        if (splitLine.Length > 3)
                        {
                            option = splitLine[3];

                            if (splitLine[3] == "GET_RED")
                            {
                                optionIndex = 1;
                            }
                            else if (option == "GET_GREEN")
                            {
                                optionIndex = 2;
                            }
                            else if (option == "GET_BLUE")
                            {
                                optionIndex = 3;
                            }
                            else if (option == "GET_ALPHA")
                            {
                                optionIndex = 4;
                            }
                            else
                            {
                                optionIndex = int.Parse(option);
                            }
                        }

                        if (splitLine.Length > 5)
                        {
                            if (splitLine[5] == "GET_COORD")
                            {
                                coordIndex = int.Parse(splitLine[6]);
                            }
                        }

                        action = splitLine[splitLine.Length - 1];

                        if (action == "ACTION_ONE_MINUS")
                        {
                            actionIndex = 1;
                        }

                        if (action == "ACTION_NEGATIVE")
                        {
                            actionIndex = 2;
                        }

                        if (action == "ACTION_REMAP_01")
                        {
                            actionIndex = 3;
                        }

                        if (action == "ACTION_POWER_2")
                        {
                            actionIndex = 4;
                        }

                        if (action == "ACTION_MULTIPLY_BY_HEIGHT")
                        {
                            actionIndex = 5;
                        }

                        if (action == "ACTION_APPLY_VARIATION_ID")
                        {
                            actionIndex = 6;
                        }

                        if (name == "SetVariation" || name == "SetRed")
                        {
                            sourceVariation = sourceIndex;
                            optionVariation = optionIndex;
                            actionVariation = actionIndex;
                            coordVariation = coordIndex;
                        }

                        if (name == "SetOcclusion" || name == "SetGreen")
                        {
                            sourceOcclusion = sourceIndex;
                            optionOcclusion = optionIndex;
                            actionOcclusion = actionIndex;
                            coordOcclusion = coordIndex;
                        }

                        if (name == "SetDetailMask" || name == "SetBlue")
                        {
                            sourceDetail = sourceIndex;
                            optionDetail = optionIndex;
                            actionDetail = actionIndex;
                            coordDetail = coordIndex;
                        }

                        if (name == "SetDetailCoord")
                        {
                            sourceDetailCoord = sourceIndex;
                            optionDetailCoord = optionIndex;
                        }

                        if (name == "SetHeight" || name == "SetAlpha")
                        {
                            sourceHeight = sourceIndex;
                            optionHeight = optionIndex;
                            actionHeight = actionIndex;
                            coordHeight = coordIndex;
                        }

                        if (name == "SetMotion2")
                        {
                            sourceMotion2 = sourceIndex;
                            optionMotion2 = optionIndex;
                            actionMotion2 = actionIndex;
                            coordMotion2 = coordIndex;
                        }

                        if (name == "SetMotion3")
                        {
                            sourceMotion3 = sourceIndex;
                            optionMotion3 = optionIndex;
                            actionMotion3 = actionIndex;
                            coordMotion3 = coordIndex;
                        }

                        if (name == "SetPivots")
                        {
                            sourcePivots = sourceIndex;
                            optionPivots = optionIndex;
                        }

                        if (name == "SetNormals")
                        {
                            sourceNormals = sourceIndex;
                            optionNormals = optionIndex;
                        }

                        if (name == "SetBounds")
                        {
                            sourceBounds = sourceIndex;
                            optionBounds = optionIndex;
                        }

                        if (name == "SetReadWrite")
                        {
                            readWriteMode = sourceIndex;
                        }
                    }
                }

            }
        }

        void GetMeshConversionWithTextures(int index)
        {
            if (presetIndex == 0)
            {
                return;
            }

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(presetLines[i]);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Mesh"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));
                        string name = "";
                        string source = "";

                        string prop = "";
                        List<Texture2D> textures = new List<Texture2D>();

                        if (splitLine.Length > 1)
                        {
                            name = splitLine[1];
                        }

                        if (splitLine.Length > 4)
                        {
                            source = splitLine[2];
                            prop = splitLine[4];

                            if (source == "GET_MASK_FROM_TEXTURE")
                            {
                                for (int t = 0; t < materialArraysInPrefab[index].Length; t++)
                                {
                                    if (materialArraysInPrefab[index] != null)
                                    {
                                        var material = materialArraysInPrefab[index][t];

                                        if (material != null && material.HasProperty(prop))
                                        {
                                            textures.Add((Texture2D)material.GetTexture(prop));
                                        }
                                        else
                                        {
                                            textures.Add(null);
                                        }
                                    }
                                }

                                if (name == "SetVariation" || name == "SetRed")
                                {
                                    textureVariationList = textures;
                                }

                                if (name == "SetOcclusion" || name == "SetGreen")
                                {
                                    textureOcclusionList = textures;
                                }

                                if (name == "SetDetailMask" || name == "SetBlue")
                                {
                                    textureDetailList = textures;
                                }

                                if (name == "SetMultiMask" || name == "SetAlpha")
                                {
                                    textureHeightList = textures;
                                }

                                if (name == "SetMotion2")
                                {
                                    textureMotion2List = textures;
                                }

                                if (name == "SetMotion3")
                                {
                                    textureMotion3List = textures;
                                }
                            }
                        }
                    }
                }
            }
        }

        Mesh SaveMesh(Mesh mesh, bool isCollected, bool setLabel)
        {
            string dataPath;
            string savePath = "/" + mesh.name + ".asset";

            if (isCollected)
            {
                dataPath = projectDataFolder + PREFABS_DATA_PATH + "/" + prefabName + savePath;
            }
            else
            {
                if (readWriteMode == 0)
                {
                    mesh.UploadMeshData(true);
                }

                dataPath = prefabDataFolder + savePath;
            }

            if (!File.Exists(dataPath))
            {
                AssetDatabase.CreateAsset(mesh, dataPath);
            }
            else
            {
                var asset = AssetDatabase.LoadAssetAtPath<Mesh>(dataPath);
                asset.Clear();
                EditorUtility.CopySerialized(mesh, asset);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            if (setLabel)
            {
                AssetDatabase.SetLabels(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(dataPath), new string[] { outputSuffix + " Model" });
            }

            return AssetDatabase.LoadAssetAtPath<Mesh>(dataPath);
        }

        // Get Float data
        List<float> GetMaskData(Mesh mesh, int index, int source, int option, int coord, Texture2D texture, List<Texture2D> textures, int action, float defaulValue)
        {
            var meshChannel = new List<float>();

            if (source == 0)
            {
                meshChannel = GetMaskDefaultValue(mesh, defaulValue);
            }

            else if (source == 1)
            {
                meshChannel = GetMaskMeshData(mesh, option, defaulValue);
            }

            else if (source == 2)
            {
                meshChannel = GetMaskProceduralData(mesh, option);
            }

            else if (source == 3)
            {
                meshChannel = GetMaskFromTextureData(mesh, index, option, coord, texture, textures);
            }

            else if (source == 4)
            {
                meshChannel = GetMask3rdPartyData(mesh, option);
            }

            if (action > 0)
            {
                meshChannel = MeshAction(meshChannel, mesh, action);
            }

            return meshChannel;
        }

        List<float> GetMaskDefaultValue(Mesh mesh, float defaulValue)
        {
            var vertexCount = mesh.vertexCount;

            var meshChannel = new List<float>(vertexCount);

            for (int i = 0; i < vertexCount; i++)
            {
                meshChannel.Add(defaulValue);
            }

            return meshChannel;
        }

        List<float> GetMaskMeshData(Mesh mesh, int option, float defaulValue)
        {
            var vertexCount = mesh.vertexCount;

            var meshChannel = new List<float>(vertexCount);

            // Vertex Color Data
            if (option == 0)
            {
                var channel = new List<Color>(vertexCount);
                mesh.GetColors(channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].r);
                }
            }

            else if (option == 1)
            {
                var channel = new List<Color>(vertexCount);
                mesh.GetColors(channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].g);
                }
            }

            else if (option == 2)
            {
                var channel = new List<Color>(vertexCount);
                mesh.GetColors(channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].b);
                }
            }

            else if (option == 3)
            {
                var channel = new List<Color>(vertexCount);
                mesh.GetColors(channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].a);
                }
            }

            // UV 0 Data
            else if (option == 4)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(0, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].x);
                }
            }

            else if (option == 5)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(0, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].y);
                }
            }

            else if (option == 6)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(0, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].z);
                }
            }

            else if (option == 7)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(0, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].w);
                }
            }

            // UV 2 Data
            else if (option == 8)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(1, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].x);
                }
            }

            else if (option == 9)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(1, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].y);
                }
            }

            else if (option == 10)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(1, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].z);
                }
            }

            else if (option == 11)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(1, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].w);
                }
            }

            // UV 3 Data
            else if (option == 12)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(2, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].x);
                }
            }

            else if (option == 13)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(2, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].y);
                }
            }

            else if (option == 14)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(2, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].z);
                }
            }

            else if (option == 15)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(2, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].w);
                }
            }

            // UV 4 Data
            else if (option == 16)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(3, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].x);
                }
            }

            else if (option == 17)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(3, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].y);
                }
            }

            else if (option == 18)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(3, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].z);
                }
            }

            else if (option == 19)
            {
                var channel = new List<Vector4>(vertexCount);
                mesh.GetUVs(3, channel);
                var channelCount = channel.Count;

                for (int i = 0; i < channelCount; i++)
                {
                    meshChannel.Add(channel[i].w);
                }
            }

            if (meshChannel.Count == 0)
            {
                meshChannel = GetMaskDefaultValue(mesh, defaulValue);
            }

            return meshChannel;
        }

        List<float> GetMaskProceduralData(Mesh mesh, int option)
        {
            var vertexCount = mesh.vertexCount;
            var vertices = mesh.vertices;
            var normals = mesh.normals;

            var meshChannel = new List<float>(vertexCount);

            if (option == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshChannel.Add(0.0f);
                }
            }
            else if (option == 1)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshChannel.Add(1.0f);
                }
            }
            // Random Variation
            else if (option == 2)
            {
                // Good Enough approach
                var triangles = mesh.triangles;
                var trianglesCount = mesh.triangles.Length;

                for (int i = 0; i < vertexCount; i++)
                {
                    meshChannel.Add(-99);
                }

                for (int i = 0; i < trianglesCount; i += 3)
                {
                    var index1 = triangles[i + 0];
                    var index2 = triangles[i + 1];
                    var index3 = triangles[i + 2];

                    float variation = 0;

                    if (meshChannel[index1] != -99)
                    {
                        variation = meshChannel[index1];
                    }
                    else if (meshChannel[index2] != -99)
                    {
                        variation = meshChannel[index2];
                    }
                    else if (meshChannel[index3] != -99)
                    {
                        variation = meshChannel[index3];
                    }
                    else
                    {
                        variation = UnityEngine.Random.Range(0.0f, 1.0f);
                    }

                    meshChannel[index1] = variation;
                    meshChannel[index2] = variation;
                    meshChannel[index3] = variation;
                }
            }
            // Predictive Variation
            else if (option == 3)
            {
                var triangles = mesh.triangles;
                var trianglesCount = mesh.triangles.Length;

                var elementIndices = new List<int>(vertexCount);
                int elementCount = 0;

                for (int i = 0; i < vertexCount; i++)
                {
                    elementIndices.Add(-99);
                }

                for (int i = 0; i < trianglesCount; i += 3)
                {
                    var index1 = triangles[i + 0];
                    var index2 = triangles[i + 1];
                    var index3 = triangles[i + 2];

                    int element = 0;

                    if (elementIndices[index1] != -99)
                    {
                        element = elementIndices[index1];
                    }
                    else if (elementIndices[index2] != -99)
                    {
                        element = elementIndices[index2];
                    }
                    else if (elementIndices[index3] != -99)
                    {
                        element = elementIndices[index3];
                    }
                    else
                    {
                        element = elementCount;
                        elementCount++;
                    }

                    elementIndices[index1] = element;
                    elementIndices[index2] = element;
                    elementIndices[index3] = element;
                }

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    var variation = (float)elementIndices[i] / elementCount;
                    variation = Mathf.Repeat(variation * seed, 1.0f);
                    meshChannel.Add(variation);
                }
            }
            // Normalized in bounds height
            else if (option == 4)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                    meshChannel.Add(mask);
                }
            }
            // Procedural Sphere
            else if (option == 5)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Distance(vertices[i], Vector3.zero) / maxBoundsInfo.x);

                    meshChannel.Add(mask);
                }
            }
            // Procedural Cylinder no Cap
            else if (option == 6)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(TVEUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));

                    meshChannel.Add(mask);
                }
            }
            // Procedural Capsule
            else if (option == 7)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var maskCyl = Mathf.Clamp01(TVEUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                    var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(TVEUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                    var maskBase = Mathf.Clamp01(TVEUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                    var mask = Mathf.Clamp01(maskCyl + maskCap) * maskBase;

                    meshChannel.Add(mask);
                }
            }
            // Base To Top
            else if (option == 8)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = 1.0f - Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                    meshChannel.Add(mask);
                }
            }
            // Bottom Projection
            else if (option == 9)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Dot(new Vector3(0, -1, 0), normals[i]) * 0.5f + 0.5f);

                    meshChannel.Add(mask);
                }
            }
            // Top Projection
            else if (option == 10)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = Mathf.Clamp01(Vector3.Dot(new Vector3(0, 1, 0), normals[i]) * 0.5f + 0.5f);

                    meshChannel.Add(mask);
                }
            }
            // Normalized in bounds height with black Offset at the bottom
            else if (option == 11)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var mask = Mathf.Clamp01((height - 0.2f) / (1 - 0.2f));

                    meshChannel.Add(mask);
                }
            }
            // Normalized in bounds height with black Offset at the bottom
            else if (option == 12)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var mask = Mathf.Clamp01((height - 0.4f) / (1 - 0.4f));

                    meshChannel.Add(mask);
                }
            }
            // Normalized in bounds height with black Offset at the bottom
            else if (option == 13)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var mask = Mathf.Clamp01((height - 0.6f) / (1 - 0.6f));

                    meshChannel.Add(mask);
                }
            }
            // Height Grass
            else if (option == 14)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var oneMinusMask = 1 - Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);
                    var powerMask = oneMinusMask * oneMinusMask * oneMinusMask * oneMinusMask;
                    var mask = 1 - powerMask;

                    meshChannel.Add(mask);
                }
            }
            // Procedural Sphere
            else if (option == 15)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var sphere = Mathf.Clamp01(Vector3.Distance(vertices[i], Vector3.zero) / maxBoundsInfo.x);
                    var mask = sphere * sphere;

                    meshChannel.Add(mask);
                }
            }
            // Procedural Cylinder no Cap
            else if (option == 16)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var cylinder = Mathf.Clamp01(TVEUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                    var mask = cylinder * cylinder;

                    meshChannel.Add(mask);
                }
            }
            // Procedural Capsule
            else if (option == 17)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var maskCyl = Mathf.Clamp01(TVEUtils.MathRemap(Vector3.Distance(vertices[i], new Vector3(0, vertices[i].y, 0)), maxBoundsInfo.x * 0.1f, maxBoundsInfo.x, 0f, 1f));
                    var maskCap = Vector3.Magnitude(new Vector3(0, Mathf.Clamp01(TVEUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0.8f, 1f, 0f, 1f)), 0));
                    var maskBase = Mathf.Clamp01(TVEUtils.MathRemap(vertices[i].y / maxBoundsInfo.y, 0f, 0.1f, 0f, 1f));
                    var maskFinal = Mathf.Clamp01(maskCyl + maskCap) * maskBase;
                    var mask = maskFinal * maskFinal;

                    meshChannel.Add(mask);
                }
            }
            // Normalized pos X
            else if (option == 18)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = vertices[i].x / maxBoundsInfo.x;

                    meshChannel.Add(mask);
                }
            }
            // Normalized pos Y
            else if (option == 19)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = vertices[i].y / maxBoundsInfo.y;

                    meshChannel.Add(mask);
                }
            }
            // Normalized pos Z
            else if (option == 19)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = vertices[i].z / maxBoundsInfo.x;

                    meshChannel.Add(mask);
                }
            }

            return meshChannel;
        }

        List<float> GetMask3rdPartyData(Mesh mesh, int option)
        {
            var vertexCount = mesh.vertexCount;
            var vertices = mesh.vertices;

            var meshChannel = new List<float>();

            // CTI Leaves Mask
            if (option == 0)
            {
                var UV3 = mesh.uv3;

                if (UV3 != null && UV3.Length > 0)
                {
                    for (int i = 0; i < vertexCount; i++)
                    {
                        var pivotX = (Mathf.Repeat(UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotZ = (Mathf.Repeat(32768.0f * UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotY = Mathf.Sqrt(1.0f - Mathf.Clamp01(Vector2.Dot(new Vector2(pivotX, pivotZ), new Vector2(pivotX, pivotZ))));

                        var pivot = new Vector3(pivotX * UV3[i].y, pivotY * UV3[i].y, pivotZ * UV3[i].y);
                        var pos = vertices[i];

                        var mask = Vector3.Magnitude(pos - pivot) / (maxBoundsInfo.x * 1f);

                        meshChannel.Add(mask);
                    }
                }
                else
                {
                    Debug.Log("<b>[The Vegetation Engine]</b> " + "The current mesh does not use CTI masks! Please use a procedural mask for flutter!");
                }
            }
            // CTI Leaves Variation
            else if (option == 1)
            {
                var UV3 = mesh.uv3;

                if (UV3 != null && UV3.Length > 0)
                {
                    for (int i = 0; i < vertexCount; i++)
                    {
                        var pivotX = (Mathf.Repeat(UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotZ = (Mathf.Repeat(32768.0f * UV3[i].x, 1.0f) * 2.0f) - 1.0f;
                        var pivotY = Mathf.Sqrt(1.0f - Mathf.Clamp01(Vector2.Dot(new Vector2(pivotX, pivotZ), new Vector2(pivotX, pivotZ))));

                        var pivot = new Vector3(pivotX * UV3[i].y, pivotY * UV3[i].y, pivotZ * UV3[i].y);

                        var variX = Mathf.Repeat(pivot.x * 33.3f, 1.0f);
                        var variY = Mathf.Repeat(pivot.y * 33.3f, 1.0f);
                        var variZ = Mathf.Repeat(pivot.z * 33.3f, 1.0f);

                        var mask = variX + variY + variZ;

                        if (UV3[i].x < 0.01f)
                        {
                            mask = 0.0f;
                        }

                        meshChannel.Add(mask);
                    }
                }
                else
                {
                    Debug.Log("<b>[The Vegetation Engine]</b> " + "The current mesh does not use CTI masks! Please use a procedural mask for variation!");
                }
            }
            // ST8 Leaves Mask
            else if (option == 2)
            {
                var UV2 = new List<Vector4>();
                var UV3 = new List<Vector4>();
                var UV4 = new List<Vector4>();

                mesh.GetUVs(1, UV2);
                mesh.GetUVs(2, UV3);
                mesh.GetUVs(3, UV4);

                if (UV4.Count != 0)
                {
                    for (int i = 0; i < vertexCount; i++)
                    {
                        var anchor = new Vector3(UV2[i].z - vertices[i].x, UV2[i].w - vertices[i].y, UV3[i].w - vertices[i].z);
                        var length = Vector3.Magnitude(anchor);
                        var leaves = UV2[i].w * UV4[i].w;

                        var mask = (length * leaves) / maxBoundsInfo.x;

                        meshChannel.Add(mask);
                    }
                }
                else
                {
                    for (int i = 0; i < vertexCount; i++)
                    {
                        var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        meshChannel.Add(mask);
                    }
                }
            }
            // NM Leaves Mask
            else if (option == 3)
            {
                var colors = new List<Color>(vertexCount);
                mesh.GetColors(colors);

                if (colors.Count != 0)
                {
                    for (int i = 0; i < vertexCount; i++)
                    {
                        if (colors[i].a > 0.99f)
                        {
                            meshChannel.Add(0.0f);
                        }
                        else
                        {
                            meshChannel.Add(colors[i].a);
                        }
                    }
                }
                else
                {
                    for (int i = 0; i < vertexCount; i++)
                    {
                        var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                        meshChannel.Add(mask);
                    }
                }
            }

            // Nicrom Leaves Mask
            else if (option == 4)
            {
                var UV0 = new List<Vector4>();

                mesh.GetUVs(0, UV0);

                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = 0;

                    if (UV0[i].x > 1.5)
                    {
                        mask = 1;
                    }

                    meshChannel.Add(mask);
                }
            }

            // Nicrom Detail Mask
            else if (option == 5)
            {
                var UV0 = new List<Vector4>();

                mesh.GetUVs(0, UV0);

                for (int i = 0; i < vertexCount; i++)
                {
                    var mask = 0;

                    if (UV0[i].y > 0)
                    {
                        mask = 1;
                    }

                    meshChannel.Add(1 - mask);
                }
            }

            return meshChannel;
        }

        List<float> GetMaskFromTextureData(Mesh mesh, int index, int option, int coord, Texture2D userTexture, List<Texture2D> textures)
        {
            var vertexCount = mesh.vertexCount;
            var subMeshMaterials = materialArraysInstances[index];
            var subMeshIndices = new List<int>(subMeshMaterials.Length + 1);

            for (int i = 0; i < subMeshMaterials.Length; i++)
            {
                var subMeshDescriptor = mesh.GetSubMesh(i);

                subMeshIndices.Add(subMeshDescriptor.firstVertex);
            }

            subMeshIndices.Add(vertexCount);

            var meshChannel = new List<float>(vertexCount);

            if (textures == null || textures.Count == 0)
            {
                textures = new List<Texture2D>(subMeshMaterials.Length);

                if (userTexture != null)
                {
                    for (int i = 0; i < subMeshMaterials.Length; i++)
                    {
                        textures.Add(userTexture);
                    }
                }
                else
                {
                    textures.Add(null);
                }
            }

            for (int i = 0; i < vertexCount; i++)
            {
                meshChannel.Add(0);
            }

            for (int s = 0; s < subMeshIndices.Count - 1; s++)
            {
                var texture = textures[s];

                if (texture != null)
                {
                    string texPath = AssetDatabase.GetAssetPath(texture);
                    TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                    texImporter.isReadable = true;
                    texImporter.SaveAndReimport();
                    AssetDatabase.Refresh();

                    var meshCoord = GetCoordMeshData(mesh, coord);

                    if (meshCoord.Count == 0)
                    {
                        for (int i = 0; i < vertexCount; i++)
                        {
                            meshCoord.Add(Vector4.zero);
                        }
                    }

                    if (option == 0)
                    {
                        for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                        {
                            var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                            meshChannel[i] = pixel.r;
                        }
                    }
                    else if (option == 1)
                    {
                        for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                        {
                            var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                            meshChannel[i] = pixel.g;
                        }
                    }
                    else if (option == 2)
                    {
                        for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                        {
                            var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                            meshChannel[i] = pixel.b;
                        }
                    }
                    else if (option == 3)
                    {
                        for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                        {
                            var pixel = texture.GetPixelBilinear(meshCoord[i].x, meshCoord[i].y);
                            meshChannel[i] = pixel.a;
                        }
                    }

                    texImporter.isReadable = false;
                    texImporter.SaveAndReimport();
                    AssetDatabase.Refresh();
                }
            }

            return meshChannel;
        }

        List<Color> GetVertexColors(Mesh mesh)
        {
            var vertexCount = mesh.vertexCount;

            var colors = new List<Color>(vertexCount);

            mesh.GetColors(colors);

            if (colors.Count == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    colors.Add(Color.white);
                }
            }

            return colors;
        }

        List<Vector4> GetCoordData(Mesh mesh, int source, int option)
        {
            var vertexCount = mesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            if (source == 0)
            {
                mesh.GetUVs(0, meshCoord);
            }
            else if (source == 1)
            {
                meshCoord = GetCoordMeshData(mesh, option);
            }
            else if (source == 2)
            {
                meshCoord = GetCoordProceduralData(mesh, option);
            }
            else if (source == 3)
            {
                meshCoord = GetCoord3rdPartyData(mesh, option);
            }

            if (meshCoord.Count == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(Vector4.zero);
                }

                //if (vertexCount != 0)
                //{
                //    Unwrapping.GenerateSecondaryUVSet(mesh);
                //    mesh.GetUVs(1, meshCoord);
                //}
            }

            return meshCoord;
        }

        List<Vector4> GetCoordMeshData(Mesh mesh, int option)
        {
            var vertexCount = mesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            if (option == 0)
            {
                mesh.GetUVs(0, meshCoord);
            }

            else if (option == 1)
            {
                mesh.GetUVs(1, meshCoord);
            }

            else if (option == 2)
            {
                mesh.GetUVs(2, meshCoord);
            }

            else if (option == 3)
            {
                mesh.GetUVs(3, meshCoord);
            }

            return meshCoord;
        }

        List<Vector4> GetCoordProceduralData(Mesh mesh, int option)
        {
            var vertexCount = mesh.vertexCount;
            var vertices = mesh.vertices;

            var meshCoord = new List<Vector4>(vertexCount);

            // Automatic (Get LightmapUV)
            if (option == 0)
            {
                mesh.GetUVs(1, meshCoord);

                if (meshCoord.Count == 0)
                {
                    if (vertexCount != 0)
                    {
                        Unwrapping.GenerateSecondaryUVSet(mesh);
                        mesh.GetUVs(1, meshCoord);
                    }
                }
            }
            // Planar XZ
            else if (option == 1)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(vertices[i].x, vertices[i].z, 0, 0));
                }
            }
            // Planar XY
            else if (option == 2)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(vertices[i].x, vertices[i].y, 0, 0));
                }
            }
            // Planar ZY
            else if (option == 3)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshCoord.Add(new Vector4(vertices[i].z, vertices[i].y, 0, 0));
                }
            }

            return meshCoord;
        }

        List<Vector4> GetCoord3rdPartyData(Mesh mesh, int option)
        {
            var vertexCount = mesh.vertexCount;

            var meshCoord = new List<Vector4>(vertexCount);

            // NM Trunk Blend
            if (option == 0)
            {
                mesh.GetUVs(2, meshCoord);

                if (meshCoord.Count == 0)
                {
                    mesh.GetUVs(1, meshCoord);
                }
            }

            return meshCoord;
        }

        List<Vector4> GetPivotsData(Mesh mesh, int source, int option)
        {
            var vertexCount = mesh.vertexCount;

            var meshPivots = new List<Vector4>(vertexCount);

            if (source == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshPivots.Add(Vector4.zero);
                }
            }
            else if (source == 1)
            {
                meshPivots = GetPivotsProceduralData(mesh, option);
            }

            if (meshPivots.Count == 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    meshPivots.Add(Vector4.zero);
                }
            }

            return meshPivots;
        }

        List<Vector4> GetPivotsProceduralData(Mesh mesh, int option)
        {
            var vertexCount = mesh.vertexCount;

            var meshPivots = new List<Vector4>(vertexCount);

            // Procedural Pivots XZ
            if (option == 0)
            {
                meshPivots = GenerateElementPivots(mesh);
            }

            return meshPivots;
        }

        List<float> GeneratePredictiveVariation(Mesh mesh)
        {
            var vertexCount = mesh.vertexCount;
            var meshChannel = new List<float>(vertexCount);

            var triangles = mesh.triangles;
            var trianglesCount = mesh.triangles.Length;

            var elementIndices = new List<int>(vertexCount);
            int elementCount = 0;

            for (int i = 0; i < vertexCount; i++)
            {
                elementIndices.Add(-99);
            }

            for (int i = 0; i < trianglesCount; i += 3)
            {
                var index1 = triangles[i + 0];
                var index2 = triangles[i + 1];
                var index3 = triangles[i + 2];

                int element = 0;

                if (elementIndices[index1] != -99)
                {
                    element = elementIndices[index1];
                }
                else if (elementIndices[index2] != -99)
                {
                    element = elementIndices[index2];
                }
                else if (elementIndices[index3] != -99)
                {
                    element = elementIndices[index3];
                }
                else
                {
                    element = elementCount;
                    elementCount++;
                }

                elementIndices[index1] = element;
                elementIndices[index2] = element;
                elementIndices[index3] = element;
            }

            for (int i = 0; i < elementIndices.Count; i++)
            {
                var variation = (float)elementIndices[i] / elementCount;
                variation = Mathf.Repeat(variation * seed, 1.0f);
                meshChannel.Add(variation);
            }

            return meshChannel;
        }

        List<Vector4> GenerateElementPivots(Mesh mesh)
        {
            var vertexCount = mesh.vertexCount;
            var vertices = mesh.vertices;
            var triangles = mesh.triangles;
            var trianglesCount = mesh.triangles.Length;

            var elementIndices = new List<int>(vertexCount);
            var meshPivots = new List<Vector4>(vertexCount);
            int elementCount = 0;

            for (int i = 0; i < vertexCount; i++)
            {
                elementIndices.Add(-99);
            }

            for (int i = 0; i < vertexCount; i++)
            {
                meshPivots.Add(Vector4.zero);
            }

            for (int i = 0; i < trianglesCount; i += 3)
            {
                var index1 = triangles[i + 0];
                var index2 = triangles[i + 1];
                var index3 = triangles[i + 2];

                int element = 0;

                if (elementIndices[index1] != -99)
                {
                    element = elementIndices[index1];
                }
                else if (elementIndices[index2] != -99)
                {
                    element = elementIndices[index2];
                }
                else if (elementIndices[index3] != -99)
                {
                    element = elementIndices[index3];
                }
                else
                {
                    element = elementCount;
                    elementCount++;
                }

                elementIndices[index1] = element;
                elementIndices[index2] = element;
                elementIndices[index3] = element;
            }

            for (int e = 0; e < elementCount; e++)
            {
                var positions = new List<Vector3>();

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    if (elementIndices[i] == e)
                    {
                        positions.Add(vertices[i]);
                    }
                }

                float x = 0;
                float z = 0;

                for (int p = 0; p < positions.Count; p++)
                {
                    x = x + positions[p].x;
                    z = z + positions[p].z;
                }

                for (int i = 0; i < elementIndices.Count; i++)
                {
                    if (elementIndices[i] == e)
                    {
                        meshPivots[i] = new Vector4(x / positions.Count, z / positions.Count, 0, 0);
                    }
                }
            }

            return meshPivots;
        }

        void ConvertMeshNormals(Mesh mesh, int index, int source, int option)
        {
            if (source == 1)
            {
                var vertexCount = mesh.vertexCount;
                var vertices = mesh.vertices;
                var normals = mesh.normals;
                var subMeshMaterials = materialArraysInstances[index];
                var subMeshIndices = new List<int>(subMeshMaterials.Length + 1);

                for (int i = 0; i < subMeshMaterials.Length; i++)
                {
                    var subMeshDescriptor = mesh.GetSubMesh(i);

                    subMeshIndices.Add(subMeshDescriptor.firstVertex);
                }

                subMeshIndices.Add(vertexCount);

                if (option == 0 || normals == null)
                {
                    mesh.RecalculateNormals();
                }

                Vector3[] customNormals = mesh.normals;

                for (int s = 0; s < subMeshIndices.Count - 1; s++)
                {
                    //Debug.Log(subMeshIndices[s] + "  " + subMeshIndices[s + 1] + "  " + subMeshMaterials[s].shader.name);

                    if (subMeshMaterials[s] == null)
                    {
                        continue;
                    }

                    if (subMeshMaterials[s].shader.name.Contains("Bark") || subMeshMaterials[s].shader.name.Contains("Prop"))
                    {
                        for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                        {
                            customNormals[i] = normals[i];
                        }
                    }
                    else
                    {
                        // Flat Shading Low
                        if (option == 1)
                        {
                            for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                            {
                                var height = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                                customNormals[i] = Vector3.Lerp(normals[i], new Vector3(0, 1, 0), height);
                            }
                        }

                        // Flat Shading Medium
                        else if (option == 2)
                        {
                            for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                            {
                                var height = Mathf.Clamp01(Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y) + 0.5f);

                                customNormals[i] = Vector3.Lerp(normals[i], new Vector3(0, 1, 0), height);
                            }
                        }

                        // Flat Shading Full
                        else if (option == 3)
                        {
                            for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                            {
                                customNormals[i] = new Vector3(0, 1, 0);
                            }
                        }

                        // Spherical Shading Low
                        else if (option == 4)
                        {
                            for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                            {
                                var spherical = Vector3.Normalize(vertices[i]);

                                customNormals[i] = Vector3.Lerp(normals[i], spherical, 0.5f);
                            }
                        }

                        // Spherical Shading Medium
                        else if (option == 5)
                        {
                            for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                            {
                                var spherical = Vector3.Normalize(vertices[i]);

                                customNormals[i] = Vector3.Lerp(normals[i], spherical, 0.75f);
                            }
                        }

                        // Spherical Shading Full
                        else if (option == 6)
                        {
                            for (int i = subMeshIndices[s]; i < subMeshIndices[s + 1]; i++)
                            {
                                customNormals[i] = Vector3.Normalize(vertices[i]);
                            }
                        }
                    }
                }

                mesh.normals = customNormals;
                mesh.RecalculateTangents();
            }
        }

        void ConvertMeshBounds(Mesh mesh, int source, int option)
        {
            if (source == 1)
            {
                float expand = 1.0f;

                if (option == 0)
                    expand = 1.2f;

                if (option == 1)
                    expand = 1.4f;

                if (option == 2)
                    expand = 1.6f;

                if (option == 3)
                    expand = 2.0f;

                Bounds bounds = new Bounds();
                Vector3 min = new Vector3(-maxBoundsInfo.x * expand, mesh.bounds.min.y, -maxBoundsInfo.x * expand);
                Vector3 max = new Vector3(maxBoundsInfo.x * expand, maxBoundsInfo.y + (maxBoundsInfo.y * 0.25f), maxBoundsInfo.x * expand);
                bounds.SetMinMax(min, max);

                mesh.bounds = bounds;
            }
        }

        /// <summary>
        /// Mesh Actions
        /// </summary>

        List<float> MeshAction(List<float> source, Mesh mesh, int action)
        {
            if (action == 1)
            {
                source = MeshActionInvert(source);
            }
            else if (action == 2)
            {
                source = MeshActionNegate(source);
            }
            else if (action == 3)
            {
                source = MeshActionRemap01(source);
            }
            else if (action == 4)
            {
                source = MeshActionPower2(source);
            }
            else if (action == 5)
            {
                source = MeshActionMultiplyByHeight(source, mesh);
            }
            else if (action == 6)
            {
                source = MeshActionUseBranchID(source, mesh);
            }

            return source;
        }

        List<float> MeshActionInvert(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = 1.0f - source[i];
            }

            return source;
        }

        List<float> MeshActionNegate(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = source[i] * -1.0f;
            }

            return source;
        }

        List<float> MeshActionRemap01(List<float> source)
        {
            float min = source[0];
            float max = source[0];

            for (int i = 0; i < source.Count; i++)
            {
                if (source[i] < min)
                    min = source[i];

                if (source[i] > max)
                    max = source[i];
            }

            // Avoid divide by 0
            if (min != max)
            {
                for (int i = 0; i < source.Count; i++)
                {
                    source[i] = (source[i] - min) / (max - min);
                }
            }
            else
            {
                for (int i = 0; i < source.Count; i++)
                {
                    source[i] = 0.0f;
                }
            }

            return source;
        }

        List<float> MeshActionPower2(List<float> source)
        {
            for (int i = 0; i < source.Count; i++)
            {
                source[i] = Mathf.Pow(source[i], 2.0f);
            }

            return source;
        }

        List<float> MeshActionMultiplyByHeight(List<float> source, Mesh mesh)
        {
            var vertices = mesh.vertices;

            for (int i = 0; i < source.Count; i++)
            {
                var mask = Mathf.Clamp01(vertices[i].y / maxBoundsInfo.y);

                source[i] = source[i] * mask;
            }

            return source;
        }

        List<float> MeshActionUseBranchID(List<float> source, Mesh mesh)
        {
            var variation = GeneratePredictiveVariation(mesh);

            for (int i = 0; i < source.Count; i++)
            {
                source[i] = source[i] * 99 + variation[i] + 1;
            }

            return source;
        }

        /// <summary>
        /// Convert Macros
        /// </summary>

        void ConvertMaterials()
        {
            packedTextureNames = new List<string>();
            packedTextureObjects = new List<Texture>();

            for (int i = 0; i < materialArraysInPrefab.Count; i++)
            {
                if (materialArraysInPrefab[i] != null)
                {
                    for (int j = 0; j < materialArraysInPrefab[i].Length; j++)
                    {
                        var originalMaterial = materialArraysInPrefab[i][j];
                        var instanceMaterial = materialArraysInstances[i][j];

                        if (IsValidMaterial(instanceMaterial))
                        {
                            ConvertMaterial(originalMaterial, instanceMaterial);

                            materialArraysInstances[i][j] = SaveMaterial(instanceMaterial, false, true);
                        }
                    }
                }
            }

            for (int i = 0; i < meshRenderersInPrefab.Count; i++)
            {
                if (meshRenderersInPrefab[i] != null)
                {
                    meshRenderersInPrefab[i].sharedMaterials = materialArraysInstances[i];
                }
            }
        }

        void ConvertMaterial(Material originalMaterial, Material instanceMaterial)
        {
            GetMaterialConversionFromPreset(originalMaterial, instanceMaterial);
            SetMaterialPostSettings(instanceMaterial);
            TVEUtils.SetMaterialSettings(instanceMaterial);
            //SaveMaterial(instanceMaterial);
        }

        void GetDefaultShadersFromPreset()
        {
            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("Shader"))
                {
                    string[] splitLine = presetLines[i].Split(char.Parse(" "));

                    var type = "";

                    if (splitLine.Length > 1)
                    {
                        type = splitLine[1];
                    }

                    if (type == "SHADER_DEFAULT_CROSS")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_DEFAULT_CROSS ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderCross = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_DEFAULT_LEAF")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_DEFAULT_LEAF ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderLeaf = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_DEFAULT_BARK")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_DEFAULT_BARK ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderBark = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_DEFAULT_GRASS")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_DEFAULT_GRASS ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderGrass = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_DEFAULT_PROP")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_DEFAULT_PROP ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderProp = Shader.Find(shader);
                        }
                    }
                    else if (type == "SHADER_DEFAULT_UBER")
                    {
                        var shader = presetLines[i].Replace("Shader SHADER_DEFAULT_UBER ", "");

                        if (Shader.Find(shader) != null)
                        {
                            shaderUber = Shader.Find(shader);
                        }
                    }
                }
            }
        }

        void GetMaterialConversionFromPreset(Material originalMaterial, Material instanceMaterial)
        {
            if (presetIndex == 0)
            {
                return;
            }

            bool doConversion = false;
            bool doPacking = false;

            if (!EditorUtility.IsPersistent(instanceMaterial))
            {
                doConversion = true;
            }

            var material = originalMaterial;
            var texName = "_MainMaskTex";
            var importType = TextureImporterType.Default;
            var importSRGB = true;

            int maskIndex = 0;
            int packChannel = 0;
            int coordChannel = 0;
            //int layerChannel = 0;
            int action0Index = 0;
            int action1Index = 0;
            int action2Index = 0;

            InitMaterialConditionFromLine();
            InitTextureStorage();

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(presetLines[i], material);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("Utility"))
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";
                        var file = "";

                        if (splitLine.Length > 1)
                        {
                            type = splitLine[1];
                        }

                        if (splitLine.Length > 2)
                        {
                            file = splitLine[2];
                        }

                        // Create a copy of the material instance at this point
                        if (type == "USE_CONVERTED_MATERIAL_AS_BASE")
                        {
                            material = new Material(instanceMaterial);
                        }

                        // Use the currently converted material
                        if (type == "USE_CURRENT_MATERIAL_AS_BASE")
                        {
                            material = instanceMaterial;
                        }

                        // Reset material to original
                        if (type == "USE_ORIGINAL_MATERIAL_AS_BASE")
                        {
                            material = originalMaterial;
                        }

                        // Allow material conversion even if Keep Converted is on
                        if (type == "USE_MATERIAL_POST_PROCESSING")
                        {
                            doConversion = true;
                        }

                        if (type == "START_TEXTURE_PACKING")
                        {
                            doPacking = true;
                        }

                        if (type == "DELETE_FILES_BY_NAME")
                        {
                            string dataPath;

                            dataPath = prefabDataFolder;

                            if (Directory.Exists(dataPath) && file != "")
                            {
                                var allFolderFiles = Directory.GetFiles(dataPath);

                                for (int f = 0; f < allFolderFiles.Length; f++)
                                {
                                    if (allFolderFiles[f].Contains(file))
                                    {
                                        FileUtil.DeleteFileOrDirectory(allFolderFiles[f]);
                                    }
                                }

                                AssetDatabase.Refresh();
                            }
                        }
                    }

                    if (presetLines[i].StartsWith("Material") && doConversion)
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));

                        var type = "";
                        var src = "";
                        var dst = "";
                        var val = "";
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
                            dst = splitLine[3];
                            x = splitLine[3];
                        }

                        if (splitLine.Length > 4)
                        {
                            val = splitLine[4];
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

                        if (type == "SET_SHADER")
                        {
                            instanceMaterial.shader = GetShaderFromPreset(set);
                        }
                        else if (type == "SET_SHADER_BY_NAME")
                        {
                            var shader = presetLines[i].Replace("Material SET_SHADER_BY_NAME ", "");

                            if (Shader.Find(shader) != null)
                            {
                                instanceMaterial.shader = Shader.Find(shader);
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
                        else if (type == "SET_FLOAT")
                        {
                            instanceMaterial.SetFloat(set, float.Parse(x, CultureInfo.InvariantCulture));
                        }
                        else if (type == "SET_COLOR")
                        {
                            instanceMaterial.SetColor(set, new Color(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "SET_VECTOR")
                        {
                            instanceMaterial.SetVector(set, new Vector4(float.Parse(x, CultureInfo.InvariantCulture), float.Parse(y, CultureInfo.InvariantCulture), float.Parse(z, CultureInfo.InvariantCulture), float.Parse(w, CultureInfo.InvariantCulture)));
                        }
                        else if (type == "COPY_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetFloat(dst, material.GetFloat(src));
                            }
                        }
                        else if (type == "COPY_TEX")
                        {
                            if (material.HasProperty(src) && material.GetTexture(src) != null)
                            {
                                GetOrCopyTexture(material, instanceMaterial, src, dst);
                            }
                        }
                        else if (type == "COPY_TEX_FIRST_VALID")
                        {
                            var shader = material.shader;

                            for (int s = 0; s < ShaderUtil.GetPropertyCount(material.shader); s++)
                            {
                                var propName = ShaderUtil.GetPropertyName(shader, s);
                                var propType = ShaderUtil.GetPropertyType(shader, s);

                                if (propType == ShaderUtil.ShaderPropertyType.TexEnv)
                                {
                                    if (material.GetTexture(propName) != null)
                                    {
                                        GetOrCopyTexture(material, instanceMaterial, propName, set);
                                        break;
                                    }
                                }
                            }
                        }
                        else if (type == "COPY_TEX_BY_NAME")
                        {
                            var shader = material.shader;

                            for (int s = 0; s < ShaderUtil.GetPropertyCount(material.shader); s++)
                            {
                                var propName = ShaderUtil.GetPropertyName(shader, s);
                                var propType = ShaderUtil.GetPropertyType(shader, s);

                                if (propType == ShaderUtil.ShaderPropertyType.TexEnv)
                                {
                                    var propNameCheck = propName.ToUpperInvariant();

                                    if (propNameCheck.Contains(src.ToUpperInvariant()) && material.GetTexture(propName) != null)
                                    {
                                        GetOrCopyTexture(material, instanceMaterial, propName, dst);
                                    }
                                }
                            }
                        }
                        else if (type == "COPY_COLOR")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetColor(dst, material.GetColor(src).linear);
                            }
                        }
                        else if (type == "COPY_VECTOR")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetVector(dst, material.GetVector(src));
                            }
                        }
                        else if (type == "COPY_ST_AS_VECTOR")
                        {
                            if (material.HasProperty(src))
                            {
                                Vector4 uvs = new Vector4(material.GetTextureScale(src).x, material.GetTextureScale(src).y,
                                                          material.GetTextureOffset(src).x, material.GetTextureOffset(src).y);

                                instanceMaterial.SetVector(dst, uvs);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_X")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var vec = instanceMaterial.GetVector(dst);
                                vec.x = material.GetFloat(src);
                                instanceMaterial.SetVector(dst, vec);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_Y")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var vec = instanceMaterial.GetVector(dst);
                                vec.y = material.GetFloat(src);
                                instanceMaterial.SetVector(dst, vec);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_Z")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var vec = instanceMaterial.GetVector(dst);
                                vec.z = material.GetFloat(src);
                                instanceMaterial.SetVector(dst, vec);
                            }
                        }
                        else if (type == "COPY_FLOAT_AS_VECTOR_W")
                        {
                            if (material.HasProperty(src) && instanceMaterial.HasProperty(dst))
                            {
                                var vec = instanceMaterial.GetVector(dst);
                                vec.w = material.GetFloat(src);
                                instanceMaterial.SetVector(dst, vec);
                            }
                        }
                        else if (type == "COPY_VECTOR_X_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetFloat(dst, material.GetVector(src).x);
                            }
                        }
                        else if (type == "COPY_VECTOR_Y_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetFloat(dst, material.GetVector(src).y);
                            }
                        }
                        else if (type == "COPY_VECTOR_Z_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetFloat(dst, material.GetVector(src).z);
                            }
                        }
                        else if (type == "COPY_VECTOR_W_AS_FLOAT")
                        {
                            if (material.HasProperty(src))
                            {
                                instanceMaterial.SetFloat(dst, material.GetVector(src).w);
                            }
                        }
                        else if (type == "ENABLE_KEYWORD")
                        {
                            instanceMaterial.EnableKeyword(set);
                        }
                        else if (type == "DISABLE_KEYWORD")
                        {
                            instanceMaterial.DisableKeyword(set);
                        }
                        else if (type == "ENABLE_INSTANCING")
                        {
                            instanceMaterial.enableInstancing = true;
                        }
                        else if (type == "DISABLE_INSTANCING")
                        {
                            instanceMaterial.enableInstancing = false;
                        }
                    }

                    if (presetLines[i].StartsWith("Texture") && doConversion)
                    {
                        string[] splitLine = presetLines[i].Split(char.Parse(" "));
                        string type = "";
                        string value = "";
                        string pack = "";
                        string tex = "";

                        if (splitLine.Length > 2)
                        {
                            type = splitLine[1];
                            value = splitLine[2];

                            if (type == "PropName")
                            {
                                if (value != "")
                                {
                                    texName = value;
                                }
                            }

                            if (type == "ImportType")
                            {
                                if (value == "DEFAULT")
                                {
                                    importType = TextureImporterType.Default;
                                }
                                else if (value == "NORMALMAP")
                                {
                                    importType = TextureImporterType.NormalMap;
                                }
                            }

                            if (type == "ImportSpace")
                            {
                                if (value == "SRGB")
                                {
                                    importSRGB = true;
                                }
                                else if (value == "LINEAR")
                                {
                                    importSRGB = false;
                                }
                            }
                        }

                        if (splitLine.Length > 3)
                        {
                            tex = splitLine[3];
                        }

                        if (material.HasProperty(tex) && material.GetTexture(tex) != null)
                        {
                            if (splitLine.Length > 1)
                            {
                                type = splitLine[1];

                                if (type == "SetRed")
                                {
                                    maskIndex = 0;
                                }
                                else if (type == "SetGreen")
                                {
                                    maskIndex = 1;
                                }

                                else if (type == "SetBlue")
                                {
                                    maskIndex = 2;
                                }
                                else if (type == "SetAlpha")
                                {
                                    maskIndex = 3;
                                }
                            }

                            if (splitLine.Length > 2)
                            {
                                pack = splitLine[2];

                                if (pack == "NONE")
                                {
                                    packChannel = 0;
                                }
                                else if (pack == "GET_RED")
                                {
                                    packChannel = 1;
                                }
                                else if (pack == "GET_GREEN")
                                {
                                    packChannel = 2;
                                }
                                else if (pack == "GET_BLUE")
                                {
                                    packChannel = 3;
                                }
                                else if (pack == "GET_ALPHA")
                                {
                                    packChannel = 4;
                                }
                                else if (pack == "GET_GRAY")
                                {
                                    packChannel = 555;
                                }
                                else if (pack == "GET_GREY")
                                {
                                    packChannel = 555;
                                }
                                else
                                {
                                    packChannel = int.Parse(pack);
                                }
                            }

                            if (splitLine.Length > 4)
                            {
                                if (splitLine[4] == "GET_COORD")
                                {
                                    coordChannel = int.Parse(splitLine[5]);
                                }
                            }

                            //if (splitLine.Length > 6)
                            //{
                            //    if (splitLine[6] == "GET_LAYER")
                            //    {
                            //        layerChannel = int.Parse(splitLine[7]);
                            //    }
                            //}

                            if (presetLines[i].Contains("ACTION_ONE_MINUS"))
                            {
                                action0Index = 1;
                            }

                            if (presetLines[i].Contains("ACTION_MULTIPLY_0"))
                            {
                                action1Index = 1;
                            }

                            if (presetLines[i].Contains("ACTION_MULTIPLY_2"))
                            {
                                action1Index = 2;
                            }

                            if (presetLines[i].Contains("ACTION_MULTIPLY_3"))
                            {
                                action1Index = 3;
                            }

                            if (presetLines[i].Contains("ACTION_MULTIPLY_05"))
                            {
                                action1Index = 5;
                            }

                            if (presetLines[i].Contains("ACTION_POWER_0"))
                            {
                                action2Index = 1;
                            }

                            if (presetLines[i].Contains("ACTION_POWER_2"))
                            {
                                action2Index = 2;
                            }

                            if (presetLines[i].Contains("ACTION_POWER_3"))
                            {
                                action2Index = 3;
                            }

                            if (presetLines[i].Contains("ACTION_POWER_4"))
                            {
                                action2Index = 4;
                            }

                            maskChannels[maskIndex] = packChannel;
                            maskCoords[maskIndex] = coordChannel;
                            //maskLayers[maskIndex] = layerChannel;
                            maskActions0[maskIndex] = action0Index;
                            maskActions1[maskIndex] = action1Index;
                            maskActions2[maskIndex] = action2Index;
                            maskTextures[maskIndex] = material.GetTexture(tex);
                        }
                    }
                }

                if (doPacking)
                {
                    if (maskTextures[0] != null || maskTextures[1] != null || maskTextures[2] != null || maskTextures[3] != null)
                    {
                        var internalName = GetPackedTextureName(maskTextures[0], maskChannels[0], maskTextures[1], maskChannels[1], maskTextures[2], maskChannels[2], maskTextures[3], maskChannels[3]);
                        bool exist = false;

                        for (int n = 0; n < packedTextureNames.Count; n++)
                        {
                            if (packedTextureNames[n] == internalName)
                            {
                                instanceMaterial.SetTexture(texName, packedTextureObjects[n]);
                                exist = true;
                            }
                        }

                        if (exist == false)
                        {
                            PackTexture(instanceMaterial, internalName, texName, importType, importSRGB);
                        }
                    }

                    InitTextureStorage();

                    texName = "_MainMaskTex";
                    importType = TextureImporterType.Default;
                    importSRGB = true;

                    doPacking = false;
                }
            }
        }

        Shader GetShaderFromPreset(string check)
        {
            var shader = shaderLeaf;

            if (check == "SHADER_DEFAULT_CROSS")
            {
                shader = shaderCross;
            }
            else if (check == "SHADER_DEFAULT_LEAF")
            {
                shader = shaderLeaf;
            }
            else if (check == "SHADER_DEFAULT_BARK")
            {
                shader = shaderBark;
            }
            else if (check == "SHADER_DEFAULT_GRASS")
            {
                shader = shaderGrass;
            }
            else if (check == "SHADER_DEFAULT_PROP")
            {
                shader = shaderProp;
            }
            else if (check == "SHADER_DEFAULT_UBER")
            {
                shader = shaderUber;
            }

            return shader;
        }

        void SetMaterialPostSettings(Material material)
        {
            if (sourcePivots > 0 && optionPivots == 0)
            {
                material.SetFloat("_VertexPivotMode", 1);
            }

            if (sourceVariation > 0 && (optionVariation == 2 || optionVariation == 3))
            {
                material.SetFloat("_VertexVariationMode", 1);
                material.SetFloat("_MotionVariation_20", 0);
            }

            // Guess best values for squash motion
            var scale = Mathf.Round(1.0f / maxBoundsInfo.y * 10.0f * 0.5f * 10);

            if (scale > 1)
            {
                scale = Mathf.FloorToInt(scale);
            }

            material.SetFloat("_MotionScale_20", scale);

            material.SetVector("_MaxBoundsInfo", maxBoundsInfo);
        }

        void GetOrCopyTexture(Material material, Material instanceMaterial, string src, string dst)
        {
            var srcTex = material.GetTexture(src);

            instanceMaterial.SetTexture(dst, srcTex);
        }

        Material SaveMaterial(Material material, bool isCollected, bool setLabel)
        {
            string dataPath;
            string savePath = "/" + material.name + ".mat";

            if (isCollected)
            {
                if (material.name.Contains("_Impostor"))
                {
                    dataPath = projectDataFolder + PREFABS_DATA_PATH + "/" + prefabName + savePath;
                }
                else
                {
                    if (shareCommonMaterials)
                    {
                        dataPath = projectDataFolder + SHARED_DATA_PATH + savePath;

                        material.SetInt("_IsShared", 1);
                    }
                    else
                    {
                        dataPath = projectDataFolder + PREFABS_DATA_PATH + "/" + prefabName + savePath;
                    }
                }
            }
            else
            {
                dataPath = prefabDataFolder + savePath;
            }

            if (File.Exists(dataPath))
            {
                var asset = AssetDatabase.LoadAssetAtPath<Material>(dataPath);

                EditorUtility.CopySerialized(material, asset);
            }
            else
            {
                AssetDatabase.CreateAsset(material, dataPath);
            }

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            if (setLabel)
            {
                AssetDatabase.SetLabels(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(dataPath), new string[] { outputSuffix + " Material" });

                //convertedMaterial = AssetDatabase.LoadAssetAtPath<Material>(dataPath);

                //TVEUtils.SetMaterialSettings(convertedMaterial);
            }

            return AssetDatabase.LoadAssetAtPath<Material>(dataPath);
        }

        bool IsValidMaterial(Material material)
        {
            bool valid = true;
            int i = 0;

            if (material == null)
            {
                i++;
            }

            if (material != null && material.name.Contains("Impostor") == true)
            {
                i++;
            }

            if (i > 0)
            {
                valid = false;
            }

            return valid;
        }

        /// <summary>
        /// Packed Texture Utils
        /// </summary>

        void InitTexturePacker()
        {
            blitTexture = Texture2D.whiteTexture;
            blitMaterial = new Material(Shader.Find("Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer"));

            sourceTexCompressions = new TextureImporterCompression[4];
            sourceimportSizes = new int[4];
            sourceTexImporters = new TextureImporter[4];
            sourceTexSettings = new TextureImporterSettings[4];

            for (int i = 0; i < 4; i++)
            {
                sourceTexCompressions[i] = new TextureImporterCompression();
                sourceTexImporters[i] = new TextureImporter();
                sourceTexSettings[i] = new TextureImporterSettings();
            }
        }

        void InitTextureStorage()
        {
            maskChannels = new int[4];
            maskCoords = new int[4];
            //maskLayers = new int[4];
            maskActions0 = new int[4];
            maskActions1 = new int[4];
            maskActions2 = new int[4];
            maskTextures = new Texture[4];

            for (int i = 0; i < 4; i++)
            {
                maskChannels[i] = 0;
                maskCoords[i] = 0;
                //maskLayers[i] = 0;
                maskActions0[i] = 0;
                maskActions1[i] = 0;
                maskActions2[i] = 0;
                maskTextures[i] = null;
            }
        }

        void PackTexture(Material materialInstance, string internalName, string texName, TextureImporterType importType, bool importSRGB)
        {
            string saveName = texName.Replace("_", "");
            string materialName = materialInstance.name.Replace(" (" + outputSuffix + " Material)", "");

            string dataPath;
            string savePath = "/" + materialName + " - " + saveName + " (" + outputSuffix + " Texture).png";

            dataPath = prefabDataFolder + savePath;

            int initSize = GetPackedInitSize(maskTextures[0], maskTextures[1], maskTextures[2], maskTextures[3]);

            ResetBlitMaterial();

            //Set Packer Metallic channel
            if (maskTextures[0] != null)
            {
                PrepareSourceTexture(maskTextures[0], 0);

                blitMaterial.SetTexture("_Packer_TexR", maskTextures[0]);
                blitMaterial.SetInt("_Packer_ChannelR", maskChannels[0]);
                blitMaterial.SetInt("_Packer_CoordR", maskCoords[0]);
                //blitMaterial.SetInt("_Packer_LayerR", maskLayers[0]);
                blitMaterial.SetInt("_Packer_Action0R", maskActions0[0]);
                blitMaterial.SetInt("_Packer_Action1R", maskActions1[0]);
                blitMaterial.SetInt("_Packer_Action2R", maskActions2[0]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelR", NONE);
                blitMaterial.SetFloat("_Packer_FloatR", 1.0f);
            }

            //Set Packer Occlusion channel
            if (maskTextures[1] != null)
            {
                PrepareSourceTexture(maskTextures[1], 1);

                blitMaterial.SetTexture("_Packer_TexG", maskTextures[1]);
                blitMaterial.SetInt("_Packer_ChannelG", maskChannels[1]);
                blitMaterial.SetInt("_Packer_CoordG", maskCoords[1]);
                //blitMaterial.SetInt("_Packer_LayerG", maskLayers[1]);
                blitMaterial.SetInt("_Packer_Action0G", maskActions0[1]);
                blitMaterial.SetInt("_Packer_Action1G", maskActions1[1]);
                blitMaterial.SetInt("_Packer_Action2G", maskActions2[1]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelG", NONE);
                blitMaterial.SetFloat("_Packer_FloatG", 1.0f);
            }

            //Set Packer Mask channel
            if (maskTextures[2] != null)
            {
                PrepareSourceTexture(maskTextures[2], 2);

                blitMaterial.SetTexture("_Packer_TexB", maskTextures[2]);
                blitMaterial.SetInt("_Packer_ChannelB", maskChannels[2]);
                blitMaterial.SetInt("_Packer_CoordB", maskCoords[2]);
                //blitMaterial.SetInt("_Packer_LayerB", maskLayers[2]);
                blitMaterial.SetInt("_Packer_Action0B", maskActions0[2]);
                blitMaterial.SetInt("_Packer_Action1B", maskActions1[2]);
                blitMaterial.SetInt("_Packer_Action2B", maskActions2[2]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelB", NONE);
                blitMaterial.SetFloat("_Packer_FloatB", 1.0f);
            }

            //Set Packer Smothness channel
            if (maskTextures[3] != null)
            {
                PrepareSourceTexture(maskTextures[3], 3);

                blitMaterial.SetTexture("_Packer_TexA", maskTextures[3]);
                blitMaterial.SetInt("_Packer_ChannelA", maskChannels[3]);
                blitMaterial.SetInt("_Packer_CoordA", maskCoords[3]);
                //blitMaterial.SetInt("_Packer_LayerA", maskLayers[3]);
                blitMaterial.SetInt("_Packer_Action0A", maskActions0[3]);
                blitMaterial.SetInt("_Packer_Action1A", maskActions1[3]);
                blitMaterial.SetInt("_Packer_Action2A", maskActions2[3]);
            }
            else
            {
                blitMaterial.SetInt("_Packer_ChannelA", NONE);
                blitMaterial.SetFloat("_Packer_FloatA", 1.0f);
            }

            Vector2 pixelSize = GetPackedPixelSize(maskTextures[0], maskTextures[1], maskTextures[2], maskTextures[3]);
            int importSize = GetPackedImportSize(initSize, pixelSize);

            Texture savedPacked = SavePackedTexture(dataPath, pixelSize);

            packedTextureNames.Add(internalName);
            packedTextureObjects.Add(savedPacked);

            SetTextureImporterSettings(savedPacked, importSize, importType, importSRGB);

            materialInstance.SetTexture(texName, savedPacked);

            if (maskTextures[0] != null)
            {
                ResetSourceTexture(0);
            }

            if (maskTextures[1] != null)
            {
                ResetSourceTexture(1);
            }

            if (maskTextures[2] != null)
            {
                ResetSourceTexture(2);
            }

            if (maskTextures[3] != null)
            {
                ResetSourceTexture(3);
            }
        }

        string GetPackedTextureName(Texture tex1, int ch1, Texture tex2, int ch2, Texture tex3, int ch3, Texture tex4, int ch4)
        {
            var texName1 = "NULL";
            var texName2 = "NULL";
            var texName3 = "NULL";
            var texName4 = "NULL";

            if (tex1 != null)
            {
                texName1 = tex1.name;
            }

            if (tex2 != null)
            {
                texName2 = tex2.name;
            }

            if (tex3 != null)
            {
                texName3 = tex3.name;
            }

            if (tex4 != null)
            {
                texName4 = tex4.name;
            }

            var name = texName1 + ch1 + texName2 + ch2 + texName3 + ch3 + texName4 + ch4;

            return name;
        }

        Vector2 GetPackedPixelSize(Texture tex1, Texture tex2, Texture tex3, Texture tex4)
        {
            int x = 32;
            int y = 32;

            if (tex1 != null)
            {
                x = Mathf.Max(x, tex1.width);
                y = Mathf.Max(y, tex1.height);
            }

            if (tex2 != null)
            {
                x = Mathf.Max(x, tex2.width);
                y = Mathf.Max(y, tex2.height);
            }

            if (tex3 != null)
            {
                x = Mathf.Max(x, tex3.width);
                y = Mathf.Max(y, tex3.height);
            }

            if (tex4 != null)
            {
                x = Mathf.Max(x, tex4.width);
                y = Mathf.Max(y, tex4.height);
            }

            return new Vector2(x, y);
        }

        int GetPackedInitSize(Texture tex1, Texture tex2, Texture tex3, Texture tex4)
        {
            if (outputTextureIndex == OutputTexture.UsePreviewResolution)
            {
                return 256;
            }
            else
            {
                int initSize = 32;

                if (tex1 != null)
                {
                    string texPath = AssetDatabase.GetAssetPath(tex1);
                    TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                    initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
                }

                if (tex2 != null)
                {
                    string texPath = AssetDatabase.GetAssetPath(tex2);
                    TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                    initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
                }

                if (tex3 != null)
                {
                    string texPath = AssetDatabase.GetAssetPath(tex3);
                    TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                    initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
                }

                if (tex4 != null)
                {
                    string texPath = AssetDatabase.GetAssetPath(tex4);
                    TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                    initSize = Mathf.Max(initSize, texImporter.maxTextureSize);
                }

                return initSize;
            }
        }

        int GetPackedImportSize(int initTexImportSize, Vector2 pixelTexSize)
        {
            if (outputTextureIndex == OutputTexture.UsePreviewResolution)
            {
                return 256;
            }
            else
            {
                int pixelSize = (int)Mathf.Max(pixelTexSize.x, pixelTexSize.y);
                int importSize = initTexImportSize;

                if (pixelSize < importSize)
                {
                    importSize = pixelSize;
                }

                for (int i = 1; i < MaxTextureSizes.Length - 1; i++)
                {
                    int a;
                    int b;

                    if ((importSize > MaxTextureSizes[i]) && (importSize < MaxTextureSizes[i + 1]))
                    {
                        a = Mathf.Abs(MaxTextureSizes[i] - importSize);
                        b = Mathf.Abs(MaxTextureSizes[i + 1] - importSize);

                        if (a < b)
                        {
                            importSize = MaxTextureSizes[i];
                        }
                        else
                        {
                            importSize = MaxTextureSizes[i + 1];
                        }

                        break;
                    }
                }

                return importSize;
            }
        }

        Texture SavePackedTexture(string path, Vector2 size)
        {
            if (File.Exists(path))
            {
                FileUtil.DeleteFileOrDirectory(path);
                FileUtil.DeleteFileOrDirectory(path + ".meta");
            }

            RenderTexture renderTexure = new RenderTexture((int)size.x, (int)size.y, 0, RenderTextureFormat.ARGB32);

            Graphics.Blit(blitTexture, renderTexure, blitMaterial, 0);

            RenderTexture.active = renderTexure;
            Texture2D packedTexure = new Texture2D(renderTexure.width, renderTexure.height, TextureFormat.ARGB32, false);
            packedTexure.ReadPixels(new Rect(0, 0, renderTexure.width, renderTexure.height), 0, 0);
            packedTexure.Apply();
            RenderTexture.active = null;

            renderTexure.Release();

            byte[] bytes;
            bytes = packedTexure.EncodeToPNG();

            File.WriteAllBytes(path, bytes);

            AssetDatabase.ImportAsset(path);
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();

            AssetDatabase.SetLabels(AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(path), new string[] { outputSuffix + " Texture" });

            return AssetDatabase.LoadAssetAtPath<Texture>(path);
        }

        Texture SaveTexture(Texture texture, bool isCollected)
        {
            var assetName = Path.GetFileName(AssetDatabase.GetAssetPath(texture));

            string dataPath;
            string savePath = "/" + assetName;

            if (isCollected)
            {
                if (assetName.Contains("TVE Texture"))
                {
                    dataPath = projectDataFolder + TEXTURE_DATA_PATH + savePath;

                    //if (shareCommonMaterials)
                    //{
                    //    dataPath = projectDataFolder + SHARED_DATA_PATH + savePath;
                    //}
                    //else
                    //{
                    //    dataPath = projectDataFolder + PREFABS_DATA_PATH + "/" + prefabName + savePath;
                    //}
                }
                else
                {
                    if (assetName.Contains("_Impostor"))
                    {
                        dataPath = projectDataFolder + PREFABS_DATA_PATH + "/" + prefabName + savePath;
                    }
                    else
                    {
                        var srcPath = AssetDatabase.GetAssetPath(texture);
                        var dataName = Path.GetFileNameWithoutExtension(srcPath);
                        var dataExt = Path.GetExtension(srcPath);
                        var dataGUID = AssetDatabase.AssetPathToGUID(srcPath).Substring(0, 2).ToUpper();

                        dataPath = projectDataFolder + TEXTURE_DATA_PATH + "/" + dataName + " " + dataGUID + dataExt;
                    }
                }
            }
            else
            {
                dataPath = prefabDataFolder + savePath;
            }

            if (!File.Exists(dataPath))
            {
                AssetDatabase.CopyAsset(AssetDatabase.GetAssetPath(texture), dataPath);
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }

            return AssetDatabase.LoadAssetAtPath<Texture>(dataPath);
        }

        void SetTextureImporterSettings(Texture texture, int importSize, TextureImporterType importType, bool importSRGB)
        {
            string texPath = AssetDatabase.GetAssetPath(texture);
            TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

            texImporter.textureType = importType;
            texImporter.maxTextureSize = importSize;
            texImporter.sRGBTexture = importSRGB;
            texImporter.alphaSource = TextureImporterAlphaSource.FromInput;

            texImporter.SaveAndReimport();
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        void ResetBlitMaterial()
        {
            blitMaterial = new Material(Shader.Find("Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer"));
        }

        void PrepareSourceTexture(Texture texture, int channel)
        {
            if (outputTextureIndex == OutputTexture.UseHighestResolution)
            {
                string texPath = AssetDatabase.GetAssetPath(texture);
                TextureImporter texImporter = AssetImporter.GetAtPath(texPath) as TextureImporter;

                sourceTexCompressions[channel] = texImporter.textureCompression;
                sourceimportSizes[channel] = texImporter.maxTextureSize;

                texImporter.ReadTextureSettings(sourceTexSettings[channel]);

                texImporter.textureType = TextureImporterType.Default;
                texImporter.sRGBTexture = false;
                texImporter.maxTextureSize = 8192;
                texImporter.textureCompression = TextureImporterCompression.Uncompressed;

                sourceTexImporters[channel] = texImporter;

                texImporter.SaveAndReimport();
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }
        }

        void ResetSourceTexture(int index)
        {
            if (outputTextureIndex == OutputTexture.UseHighestResolution)
            {
                sourceTexImporters[index].textureCompression = sourceTexCompressions[index];
                sourceTexImporters[index].maxTextureSize = sourceimportSizes[index];
                sourceTexImporters[index].SetTextureSettings(sourceTexSettings[index]);
                sourceTexImporters[index].SaveAndReimport();
                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();
            }
        }

        /// <summary>
        /// Collect Utils
        /// </summary>

        void CollectMaterials()
        {
            for (int i = 0; i < meshRenderersInPrefab.Count; i++)
            {
                var meshRenderer = meshRenderersInPrefab[i];

                if (meshRenderer != null)
                {
                    var sharedMaterials = meshRenderer.sharedMaterials;

                    if (sharedMaterials != null)
                    {
                        for (int m = 0; m < sharedMaterials.Length; m++)
                        {
                            if (sharedMaterials[m] != null)
                            {
                                var instanceMaterial = Instantiate(sharedMaterials[m]);
                                instanceMaterial.name = sharedMaterials[m].name;
                                instanceMaterial.SetInt("_IsCollected", 1);

                                sharedMaterials[m] = SaveMaterial(instanceMaterial, true, false);

                                var shader = sharedMaterials[m].shader;

                                for (int s = 0; s < ShaderUtil.GetPropertyCount(shader); s++)
                                {
                                    var propName = ShaderUtil.GetPropertyName(shader, s);
                                    var propType = ShaderUtil.GetPropertyType(shader, s);

                                    if (propType == ShaderUtil.ShaderPropertyType.TexEnv)
                                    {
                                        var texture = sharedMaterials[m].GetTexture(propName);

                                        if (texture != null)
                                        {
                                            sharedMaterials[m].SetTexture(propName, SaveTexture(texture, true));
                                        }
                                    }
                                }
                            }
                        }

                        meshRenderer.sharedMaterials = sharedMaterials;
                    }
                }
            }
        }

        void CollectMeshes()
        {
            for (int i = 0; i < meshFiltersInPrefab.Count; i++)
            {
                var meshFilter = meshFiltersInPrefab[i];

                if (meshFilter != null)
                {
                    if (meshesInPrefab[i] != null)
                    {
                        var instanceMesh = Instantiate(meshesInPrefab[i]);
                        instanceMesh.name = meshesInPrefab[i].name;

                        meshFiltersInPrefab[i].sharedMesh = SaveMesh(instanceMesh, true, false);
                    }
                }
            }
        }

        void CollectColliders()
        {
            for (int i = 0; i < meshCollidersInPrefab.Count; i++)
            {
                var meshCollider = meshCollidersInPrefab[i];

                if (meshCollider != null)
                {
                    if (collidersInPrefab[i] != null)
                    {
                        var instanceMesh = Instantiate(collidersInPrefab[i]);
                        instanceMesh.name = collidersInPrefab[i].name;

                        meshCollider.sharedMesh = SaveMesh(instanceMesh, true, false);
                    }
                }
            }
        }

        /// <summary>
        /// Get Project Presets
        /// </summary>

        void GetDefaultShaders()
        {
            shaderProp = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Default/Prop Standard Lit");
            shaderBark = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Default/Bark Standard Lit");
            shaderCross = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Default/Cross Subsurface Lit");
            shaderGrass = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Default/Grass Subsurface Lit");
            shaderLeaf = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Default/Leaf Subsurface Lit");
            shaderUber = Shader.Find("BOXOPHOBIC/The Vegetation Engine/Default/Uber Subsurface Lit");
        }

        void GetPresets()
        {
            presetPaths = new List<string>();
            presetPaths.Insert(0, "");

            overridePaths = new List<string>();
            overridePaths.Insert(0, "");

            detectLines = new List<string>();

            // FindObjectsOfTypeAll not working properly for unloaded assets
            allPresetPaths = Directory.GetFiles(Application.dataPath, "*.tvepreset", SearchOption.AllDirectories);
            allPresetPaths = allPresetPaths.OrderBy(f => new FileInfo(f).Name).ToArray();

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                string assetPath = "Assets" + allPresetPaths[i].Replace(Application.dataPath, "").Replace('\\', '/');

                if (assetPath.Contains("[PRESET]"))
                {
                    presetPaths.Add(assetPath);
                }

                if (assetPath.Contains("[OVERRIDE]") == true)
                {
                    overridePaths.Add(assetPath);
                }

                if (assetPath.Contains("[DETECT]") == true)
                {
                    StreamReader reader = new StreamReader(assetPath);

                    while (!reader.EndOfStream)
                    {
                        detectLines.Add(reader.ReadLine());
                    }

                    reader.Close();
                }
            }

            PresetsEnum = new string[presetPaths.Count];
            PresetsEnum[0] = "Choose a preset";

            OverridesEnum = new string[overridePaths.Count];
            OverridesEnum[0] = "None";

            for (int i = 1; i < presetPaths.Count; i++)
            {
                PresetsEnum[i] = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(presetPaths[i]).name;
                PresetsEnum[i] = PresetsEnum[i].Replace("[PRESET] ", "");
                PresetsEnum[i] = PresetsEnum[i].Replace(" - ", "/");
            }

            for (int i = 1; i < overridePaths.Count; i++)
            {
                OverridesEnum[i] = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(overridePaths[i]).name;
                OverridesEnum[i] = OverridesEnum[i].Replace("[OVERRIDE] ", "");
                OverridesEnum[i] = OverridesEnum[i].Replace(" - ", "/");
            }
        }

        void GetPresetLines()
        {
            presetLines = new List<string>();

            StreamReader reader = new StreamReader(presetPaths[presetIndex]);

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine().TrimStart();

                presetLines.Add(line);

                if (line.Contains("Include"))
                {
                    GetIncludeLines(line);
                }
            }

            reader.Close();

            for (int i = 0; i < overrideIndices.Count; i++)
            {
                if (overrideIndices[i] != 0)
                {
                    reader = new StreamReader(overridePaths[overrideIndices[i]]);

                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine().TrimStart();

                        presetLines.Add(line);

                        if (line.Contains("Include"))
                        {
                            GetIncludeLines(line);
                        }
                    }

                    reader.Close();
                }
            }
        }

        void GetIncludeLines(string include)
        {
            var import = include.Replace("Include ", "");

            for (int i = 0; i < allPresetPaths.Length; i++)
            {
                if (allPresetPaths[i].Contains(import))
                {
                    StreamReader reader = new StreamReader(allPresetPaths[i]);

                    while (!reader.EndOfStream)
                    {
                        var line = reader.ReadLine().TrimStart();

                        presetLines.Add(line);
                    }

                    reader.Close();
                }
            }
        }

        void GetOptionsFromPreset(bool usePrefered)
        {
            if (presetIndex == 0)
            {
                return;
            }

            useOptionLines = new List<bool>();
            useOptionLines.Add(true);

            var options = new List<string>();
            var splitPrefered = new string[0];

            for (int i = 0; i < presetLines.Count; i++)
            {
                if (presetLines[i].StartsWith("OutputOptions"))
                {
                    var splitLine = presetLines[i].Replace("OutputOptions ", "").Split(char.Parse("/"));
                    splitPrefered = presetLines[i].Split(char.Parse(" "));

                    for (int j = 0; j < splitLine.Length; j++)
                    {
                        options.Add(splitLine[j]);
                    }
                }
            }

            if (options.Count == 0)
            {
                options.Add("");

                OptionsEnum = options.ToArray();


            }
            else
            {
                int prefered = 0;

                if (int.TryParse(splitPrefered[splitPrefered.Length - 1], out prefered))
                {
                    if (usePrefered)
                    {
                        optionIndex = prefered;
                    }

                    options[options.Count - 1] = options[options.Count - 1].Replace(" " + prefered, "");
                }

                OptionsEnum = new string[options.Count];

                for (int i = 0; i < options.Count; i++)
                {
                    OptionsEnum[i] = options[i];
                }
            }

            if (optionIndex >= OptionsEnum.Length)
            {
                optionIndex = 0;
            }

            //for (int i = 0; i < ModelOptions.Length; i++)
            //{
            //    Debug.Log(ModelOptions[i]);
            //}
        }

        void GetDescriptionFromPreset()
        {
            infoTitle = "Preset";
            infoPreset = "";
            infoStatus = "";
            infoOnline = "";
            infoMessage = "";
            infoWarning = "";
            infoError = "";

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(presetLines[i]);

                if (useLine)
                {
                    if (presetLines[i].StartsWith("InfoTitle"))
                    {
                        infoTitle = presetLines[i].Replace("InfoTitle ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoPreset"))
                    {
                        infoPreset = presetLines[i].Replace("InfoPreset ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoStatus"))
                    {
                        infoStatus = presetLines[i].Replace("InfoStatus ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoOnline"))
                    {
                        infoOnline = presetLines[i].Replace("InfoOnline ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoMessage"))
                    {
                        infoMessage = presetLines[i].Replace("InfoMessage ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoWarning"))
                    {
                        infoWarning = presetLines[i].Replace("InfoWarning ", "");
                    }
                    else if (presetLines[i].StartsWith("InfoError"))
                    {
                        infoError = presetLines[i].Replace("InfoError ", "");
                    }
                }
            }

            if (presetAutoDetected)
            {
                infoTitle = infoTitle + " (Auto Detected)";
            }
        }

        void GetOutputsFromPreset()
        {
            if (presetIndex == 0)
            {
                return;
            }

            outputValid = true;

            for (int i = 0; i < presetLines.Count; i++)
            {
                var useLine = GetConditionFromLine(presetLines[i]);

                if (useLine)
                {

                    if (presetLines[i].StartsWith("OutputMesh"))
                    {
                        string source = presetLines[i].Replace("OutputMesh ", "");

                        if (source == "NONE")
                        {
                            outputMeshIndex = OutputMesh.Off;
                        }
                        else if (source == "DEFAULT")
                        {
                            outputMeshIndex = OutputMesh.Default;
                        }
                        else if (source == "CUSTOM")
                        {
                            outputMeshIndex = OutputMesh.Custom;
                        }
                        else if (source == "DE_ENVIRONMENT")
                        {
                            outputMeshIndex = OutputMesh.DEEnvironment;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputTransform"))
                    {
                        string source = presetLines[i].Replace("OutputTransform ", "");

                        if (source == "USE_ORIGINAL_TRANSFORMS")
                        {
                            outputTransformIndex = OutputTransform.UseOriginalTransforms;
                        }
                        else if (source == "TRANSFORM_TO_WORLD_SPACE")
                        {
                            outputTransformIndex = OutputTransform.TransformToWorldSpace;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputMaterial"))
                    {
                        string source = presetLines[i].Replace("OutputMaterial ", "");

                        if (source == "NONE")
                        {
                            outputMaterialIndex = OutputMaterial.Off;
                        }
                        else if (source == "DEFAULT")
                        {
                            outputMaterialIndex = OutputMaterial.Default;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputTexture"))
                    {
                        string source = presetLines[i].Replace("OutputTexture ", "");

                        if (source == "USE_CURRENT_RESOLUTION")
                        {
                            outputTextureIndex = OutputTexture.UseCurrentResolution;
                        }
                        else if (source == "USE_HIGHEST_RESOLUTION")
                        {
                            outputTextureIndex = OutputTexture.UseHighestResolution;
                        }
                        else if (source == "USE_PREVIEW_RESOLUTION")
                        {
                            outputTextureIndex = OutputTexture.UsePreviewResolution;
                        }
                    }
                    else if (presetLines[i].StartsWith("OutputPipelines"))
                    {
                        outputPipeline = presetLines[i].Replace("OutputPipelines ", "");
                    }
                    else if (presetLines[i].StartsWith("OutputSuffix"))
                    {
                        outputSuffix = presetLines[i].Replace("OutputSuffix ", "");
                    }
                    else if (presetLines[i].StartsWith("OutputValid"))
                    {
                        string source = presetLines[i].Replace("OutputValid ", "");

                        if (source == "TRUE")
                        {
                            outputValid = true;
                        }
                        else if (source == "FALSE")
                        {
                            outputValid = false;
                        }
                    }

                    if (outputPipeline != "")
                    {
                        if (outputPipeline.Contains(renderPipeline))
                        {
                            outputValid = true;
                            infoError = "";
                        }
                        else
                        {
                            outputValid = false;
                            infoError = "The current asset can only be converted in the " + outputPipeline + " render pipeline and then exported to you project using the Collect Converted Data feature!";
                        }
                    }
                }
            }
        }

        void GetAllPresetInfo()
        {
            GetAllPresetInfo(false);
        }

        void GetAllPresetInfo(bool usePrefered)
        {
            if (presetIndex == 0)
            {
                return;
            }

            outputMeshIndex = OutputMesh.Default;
            outputMaterialIndex = OutputMaterial.Default;
            outputPipeline = "";
            outputSuffix = "TVE";

            sourceNormals = 0;

            GetDefaultShaders();

            GetPresetLines();
            GetOptionsFromPreset(usePrefered);
            GetDescriptionFromPreset();

            if (!hasOutputModifications)
            {
                GetOutputsFromPreset();
            }

            if (!hasMeshModifications)
            {
                GetMeshConversionFromPreset();
            }

            GetDefaultShadersFromPreset();
        }

        void SaveGlobalOverrides()
        {
            var globalOverrides = "";

            for (int i = 0; i < overrideIndices.Count; i++)
            {
                if (overrideGlobals[i])
                {
                    globalOverrides = globalOverrides + OverridesEnum[overrideIndices[i]] + ";";
                }
            }

            globalOverrides.Replace("None", "");

            SettingsUtils.SaveSettingsData(userFolder + "Converter Overrides.asset", globalOverrides);
        }

        void GetGlobalOverrides()
        {
            var globalOverrides = SettingsUtils.LoadSettingsData(userFolder + "Converter Overrides.asset", "");

            if (globalOverrides != "")
            {
                var splitLine = globalOverrides.Split(char.Parse(";"));

                for (int o = 0; o < OverridesEnum.Length; o++)
                {
                    for (int s = 0; s < splitLine.Length; s++)
                    {
                        if (OverridesEnum[o] == splitLine[s])
                        {
                            if (!overrideIndices.Contains(o))
                            {
                                overrideIndices.Add(o);
                                overrideGlobals.Add(true);
                            }
                        }
                    }
                }
            }
        }

        void InitMaterialConditionFromLine()
        {
            useMaterialLines = new List<bool>();
            useMaterialLines.Add(true);
        }

        bool GetConditionFromLine(string line)
        {
            var valid = true;

            if (line.StartsWith("if"))
            {
                valid = false;

                string[] splitLine = line.Split(char.Parse(" "));

                var type = "";
                var check = "";

                if (splitLine.Length > 1)
                {
                    type = splitLine[1];
                }

                if (splitLine.Length > 2)
                {
                    check = splitLine[2];
                }

                if (type.Contains("PREFAB_PATH_CONTAINS"))
                {
                    var path = AssetDatabase.GetAssetPath(prefabObject).ToUpperInvariant();

                    if (path.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("OUTPUT_OPTION_CONTAINS"))
                {
                    if (OptionsEnum[optionIndex].Contains(check))
                    {
                        valid = true;
                    }
                }

                useOptionLines.Add(valid);
            }

            if (line.StartsWith("if") && line.Contains("!"))
            {
                valid = !valid;
                useOptionLines[useOptionLines.Count - 1] = valid;
            }

            if (line.StartsWith("endif") || line.StartsWith("}"))
            {
                useOptionLines.RemoveAt(useOptionLines.Count - 1);
            }

            var useLine = true;

            for (int i = 1; i < useOptionLines.Count; i++)
            {
                if (useOptionLines[i] == false)
                {
                    useLine = false;
                    break;
                }
            }

            return useLine;
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

                if (type.Contains("PREFAB_PATH_CONTAINS"))
                {
                    var path = AssetDatabase.GetAssetPath(prefabObject).ToUpperInvariant();

                    if (path.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("OUTPUT_OPTION_CONTAINS"))
                {
                    if (OptionsEnum[optionIndex].Contains(check))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("SHADER_NAME_CONTAINS"))
                {
                    var name = material.shader.name.ToUpperInvariant();

                    if (name.Contains(check.ToUpperInvariant()))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("SHADER_IS_UNITY_LIT"))
                {
                    var name = material.shader.name;

                    if (name.StartsWith("Standard") || name.StartsWith("Universal Render Pipeline") || name.StartsWith("HDRP"))
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("SHADER_PIPELINE_IS_STANDARD"))
                {
                    if (material.GetTag("RenderPipeline", false) == "")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("SHADER_PIPELINE_IS_UNIVERSAL"))
                {
                    if (material.GetTag("RenderPipeline", false) == "UniversalPipeline")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("SHADER_PIPELINE_IS_HD"))
                {
                    if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline")
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("SHADER_PIPELINE_IS_SRP"))
                {
                    if (material.GetTag("RenderPipeline", false) == "HDRenderPipeline" || material.GetTag("RenderPipeline", false) == "UniversalPipeline")
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
                else if (type.Contains("MATERIAL_HAS_TEX"))
                {
                    if (material.HasProperty(check))
                    {
                        if (material.GetTexture(check) != null)
                        {
                            valid = true;
                        }
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
                else if (type.Contains("MATERIAL_FLOAT_SMALLER"))
                {
                    var value = float.Parse(val, CultureInfo.InvariantCulture);

                    if (material.HasProperty(check) && material.GetFloat(check) < value)
                    {
                        valid = true;
                    }
                }
                else if (type.Contains("MATERIAL_FLOAT_GREATER"))
                {
                    var value = float.Parse(val, CultureInfo.InvariantCulture);

                    if (material.HasProperty(check) && material.GetFloat(check) > value)
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

                useMaterialLines.Add(valid);
            }

            if (line.StartsWith("if") && line.Contains("!"))
            {
                valid = !valid;
                useMaterialLines[useMaterialLines.Count - 1] = valid;
            }

            if (line.StartsWith("endif") || line.StartsWith("}"))
            {
                useMaterialLines.RemoveAt(useMaterialLines.Count - 1);
            }

            var useLine = true;

            for (int i = 1; i < useMaterialLines.Count; i++)
            {
                if (useMaterialLines[i] == false)
                {
                    useLine = false;
                    break;
                }
            }

            return useLine;
        }
    }
}

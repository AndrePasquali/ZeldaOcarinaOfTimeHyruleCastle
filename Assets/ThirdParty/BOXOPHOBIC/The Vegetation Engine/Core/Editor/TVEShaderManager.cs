// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic.StyledGUI;
using Boxophobic.Utils;
using System.IO;
using System.Collections.Generic;

namespace TheVegetationEngine
{
    public class TVEShaderManager : EditorWindow
    {
        float GUI_HALF_EDITOR_WIDTH = 220;
        float GUI_HALF_OPTION_WIDTH = 220;
        const int GUI_SELECTION_HEIGHT = 24;

        string userFolder = "Assets/BOXOPHOBIC/User";

        List<string> coreShaderPaths;
        List<int> engineOverridesIndices;

        int engineIndex = 0;
        bool showMixedValues = false;
        bool showSelection = true;

        GUIStyle stylePopup;
        GUIStyle styleLabel;
        GUIStyle styleHelpBox;
        GUIStyle styleCenteredHelpBox;

        Color bannerColor;
        string bannerText;
        static TVEShaderManager window;
        Vector2 scrollPosition = Vector2.zero;

        [MenuItem("Window/BOXOPHOBIC/The Vegetation Engine/Shader Manager", false, 2002)]
        public static void ShowWindow()
        {
            window = GetWindow<TVEShaderManager>(false, "Shader Manager", true);
            window.minSize = new Vector2(389, 220);
        }

        void OnEnable()
        {
            string[] searchFolders;

            searchFolders = AssetDatabase.FindAssets("User");

            for (int i = 0; i < searchFolders.Length; i++)
            {
                if (AssetDatabase.GUIDToAssetPath(searchFolders[i]).EndsWith("User.pdf"))
                {
                    userFolder = AssetDatabase.GUIDToAssetPath(searchFolders[i]);
                    userFolder = userFolder.Replace("/User.pdf", "");
                    userFolder += "/The Vegetation Engine";
                }
            }

            coreShaderPaths = new List<string>();
            engineOverridesIndices = new List<int>();

            coreShaderPaths = TVEShaderUtils.GetCoreShaderPaths();

            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                engineOverridesIndices.Add(0);
            }

            GetRenderEngineFromShaders();
            GetRenderEngineMixedValues();

            bannerColor = new Color(0.890f, 0.745f, 0.309f);
            bannerText = "Shader Manager";
        }

        void OnGUI()
        {
            SetGUIStyles();

            GUI_HALF_EDITOR_WIDTH = this.position.width / 2.0f - 24;
            GUI_HALF_OPTION_WIDTH = GUI_HALF_EDITOR_WIDTH - 38;

            StyledGUI.DrawWindowBanner(bannerColor, bannerText);

            GUILayout.BeginHorizontal();
            GUILayout.Space(15);

            GUILayout.BeginVertical();

            scrollPosition = GUILayout.BeginScrollView(scrollPosition, false, false, GUILayout.Width(this.position.width - 28), GUILayout.Height(this.position.height - 80));

            EditorGUILayout.HelpBox("Choose the shader render engine to enable instanced indirect support when working with 3rd party tools! The option can be set for each shader individually!", MessageType.Info, true);
            EditorGUILayout.HelpBox("GPU Instancer and Quadro Renderer create compatible shaders automatically and adding support is not required. You can still enable the support if you need the instanced indirect to be added to the original shaders specifically!", MessageType.Warning, true);

            GUILayout.Space(15);

            GUILayout.BeginHorizontal();

            EditorGUI.showMixedValue = showMixedValues;

            if (showMixedValues)
            {
                engineIndex = -1;
            }

            EditorGUI.BeginChangeCheck();

            GUILayout.Label("Render Engine Support (All)", GUILayout.Width(GUI_HALF_EDITOR_WIDTH));
            engineIndex = EditorGUILayout.Popup(engineIndex, TVEShaderUtils.RenderEngineOptions, stylePopup, GUILayout.Height(GUI_SELECTION_HEIGHT));

            if (EditorGUI.EndChangeCheck())
            {
                showMixedValues = false;

                SettingsUtils.SaveSettingsData(userFolder + "/Engine.asset", TVEShaderUtils.RenderEngineOptions[engineIndex]);

                UpdateShaders();

                GetRenderEngineFromShaders();
                GetRenderEngineMixedValues();

                GUIUtility.ExitGUI();
            }

            EditorGUI.showMixedValue = false;

            GUILayout.EndHorizontal();

            GUILayout.Space(10);

            if (showSelection)
            {
                if (StyledButton("Hide Shader Selection"))
                    showSelection = !showSelection;
            }
            else
            {
                if (StyledButton("Show Shader Selection"))
                    showSelection = !showSelection;
            }

            if (showSelection)
            {
                for (int i = 0; i < coreShaderPaths.Count; i++)
                {
                    StyledShader(i);
                }
            }

            GUILayout.FlexibleSpace();
            GUI.enabled = false;

            GUILayout.Space(20);

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

            styleLabel = new GUIStyle(GUI.skin.GetStyle("Label"))
            {
                richText = true,
                alignment = TextAnchor.MiddleRight,
                fontSize = 10
            };

            styleHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleLeft,
            };

            styleCenteredHelpBox = new GUIStyle(GUI.skin.GetStyle("HelpBox"))
            {
                richText = true,
                alignment = TextAnchor.MiddleCenter,
            };
        }

        void StyledShader(int index)
        {
            //string color;

            //if (EditorGUIUtility.isProSkin)
            //{
            //    color = "<color=#96f3f0>";
            //}
            //else
            //{
            //    color = "<color=#0b448b>";
            //}

            var label = Path.GetFileNameWithoutExtension(coreShaderPaths[index]);

            GUILayout.Label("<size=10><b>" + "  " + label + "</b></size>", styleHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            var lastRect = GUILayoutUtility.GetLastRect();
            var popupRect = new Rect(lastRect.width / 2, lastRect.y + 3, lastRect.width / 2, lastRect.height);
            var selectionRect = new Rect(lastRect.x, lastRect.y, lastRect.width / 2, lastRect.height);
            //var arrowRect = new Rect(lastRect.xMax - GUI_SELECTION_HEIGHT, lastRect.yMax - GUI_SELECTION_HEIGHT, GUI_SELECTION_HEIGHT, GUI_SELECTION_HEIGHT);

            //GUI.Label(arrowRect, TVEShaderUtils.RenderEngineOptions[engineOverridesIndices[index]]);

            if (GUI.Button(selectionRect, "", GUIStyle.none))
            {
                var shader = AssetDatabase.LoadAssetAtPath<Shader>(coreShaderPaths[index]);
                EditorGUIUtility.PingObject(shader);
            }

            GUILayout.BeginHorizontal();

            EditorGUI.BeginChangeCheck();

            engineOverridesIndices[index] = EditorGUI.Popup(popupRect, engineOverridesIndices[index], TVEShaderUtils.RenderEngineOptions, stylePopup);

            if (EditorGUI.EndChangeCheck())
            {
                var shader = AssetDatabase.LoadAssetAtPath<Shader>(coreShaderPaths[index]);
                SettingsUtils.SaveSettingsData(userFolder + "/Shaders/Engine " + shader.name.Replace("/", "__") + ".asset", TVEShaderUtils.RenderEngineOptions[engineOverridesIndices[index]]);

                TVEShaderUtils.InjectShaderFeatures(coreShaderPaths[index], TVEShaderUtils.RenderEngineOptions[engineOverridesIndices[index]]);

                AssetDatabase.SaveAssets();
                AssetDatabase.Refresh();

                GetRenderEngineMixedValues();

                GUIUtility.ExitGUI();
            }

            //if (GUILayout.Button("Install", GUILayout.Width(80)))
            //{
            //    var shader = AssetDatabase.LoadAssetAtPath<Shader>(coreShaderPaths[index]);
            //    SettingsUtils.SaveSettingsData(userFolder + "/Shaders/Engine " + shader.name.Replace("/", "__") + ".asset", TVEShaderUtils.RenderEngineOptions[engineOverridesIndices[index]]);

            //    TVEShaderUtils.InjectShaderFeatures(coreShaderPaths[index], TVEShaderUtils.RenderEngineOptions[engineOverridesIndices[index]]);

            //    AssetDatabase.SaveAssets();
            //    AssetDatabase.Refresh();

            //    GetRenderEngineMixedValues();

            //    GUIUtility.ExitGUI();
            //}

            GUILayout.EndHorizontal();
        }

        bool StyledButton(string text)
        {
            bool value = GUILayout.Button("<b>" + text + "</b>", styleCenteredHelpBox, GUILayout.Height(GUI_SELECTION_HEIGHT));

            return value;
        }

        void UpdateShaders()
        {
            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                var shader = AssetDatabase.LoadAssetAtPath<Shader>(coreShaderPaths[i]);
                SettingsUtils.SaveSettingsData(userFolder + "/Shaders/Engine " + shader.name.Replace("/", "__") + ".asset", TVEShaderUtils.RenderEngineOptions[engineIndex]);

                TVEShaderUtils.InjectShaderFeatures(coreShaderPaths[i], TVEShaderUtils.RenderEngineOptions[engineIndex]);
            }

            Debug.Log("<b>[The Vegetation Engine]</b> " + "Shader features updated!");

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
        }

        void GetRenderEngineFromShaders()
        {
            for (int i = 0; i < coreShaderPaths.Count; i++)
            {
                engineOverridesIndices[i] = TVEShaderUtils.GetRenderEngineIndexFromShader(coreShaderPaths[i]);
                engineIndex = engineOverridesIndices[i];
            }
        }

        void GetRenderEngineMixedValues()
        {
            showMixedValues = false;

            for (int e = 1; e < engineOverridesIndices.Count; e++)
            {
                if (engineOverridesIndices[e - 1] != engineOverridesIndices[e])
                {
                    showMixedValues = true;
                    break;
                }
            }
        }
    }
}

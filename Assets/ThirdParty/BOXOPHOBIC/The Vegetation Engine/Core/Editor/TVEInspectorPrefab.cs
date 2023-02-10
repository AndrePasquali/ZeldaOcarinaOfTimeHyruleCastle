//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;

namespace TheVegetationEngine
{
    [CanEditMultipleObjects]
    [CustomEditor(typeof(TVEPrefab))]
    public class TVEInspectorPrefab : Editor
    {
        private static readonly string excludeProps = "m_Script";
        private TVEPrefab targetScript;

        void OnEnable()
        {
            targetScript = (TVEPrefab)target;
        }

        public override void OnInspectorGUI()
        {
            DrawInspector();

            var hasOverrides = false;
            var isStatic = false;

            if (!Application.isPlaying && PrefabUtility.IsPartOfPrefabInstance(targetScript.gameObject))
            {
                var overrides = PrefabUtility.GetObjectOverrides(targetScript.gameObject);
                var overridesCount = 0;

                for (int i = 0; i < overrides.Count; i++)
                {
                    if (overrides[i].instanceObject.GetType() != typeof(UnityEngine.Transform) && overrides[i].instanceObject.GetType() != typeof(UnityEngine.GameObject))
                    {
                        overridesCount++;
                    }
                }

                if (overridesCount > 0)
                {
                    hasOverrides = true;
                    EditorGUILayout.HelpBox("Prefab Instance has overrides. The Vegetation Engine works on the prefab root level and not on individual prefab instances. Make sure to apply/revert all overrides to avoid any issues!", MessageType.Warning);
                }
            }

            var staticFlags = GameObjectUtility.GetStaticEditorFlags(targetScript.gameObject);

            if (staticFlags.HasFlag(StaticEditorFlags.BatchingStatic))
            {
                isStatic = true;
                EditorGUILayout.HelpBox("Prefabs set to batching static flag requires materials with Enable Batching Support enabled! Please consider to disable the static flag to be able to use high-quality motion and features!", MessageType.Info);
            }

            if (hasOverrides || isStatic)
            {
                GUILayout.Space(10);
            }

            GUILayout.BeginHorizontal();

            if (targetScript.isCollected)
            {
                if (GUILayout.Button("Select Parent Prefab"/*, GUILayout.Width(160)*/))
                {
                    var prefab = AssetDatabase.LoadAssetAtPath<GameObject>(AssetDatabase.GUIDToAssetPath(targetScript.storedPrefabBackupGUID));

                    if (prefab != null)
                    {
                        EditorGUIUtility.PingObject(prefab);
                        Selection.activeGameObject = prefab;
                    }
                    else
                    {
                        Debug.Log("<b>[The Vegetation Engine]</b> " + "The parent prefab cannot be found!");
                    }
                }
            }
            else
            {
                if (GUILayout.Button("Open Prefab Converter"/*, GUILayout.Width(160)*/))
                {
                    TVEPrefabConverter window = EditorWindow.GetWindow<TVEPrefabConverter>(false, "Prefab Converter", true);
                    window.minSize = new Vector2(480, 280);
                    window.Show();
                }
            }



            if (GUILayout.Button("Open Material Manager"/*, GUILayout.Width(160)*/))
            {
                TVEMaterialManager window = EditorWindow.GetWindow<TVEMaterialManager>(false, "Material Manager", true);
                window.minSize = new Vector2(389, 200);
                window.Show();
            }

            GUILayout.EndHorizontal();

            GUILayout.Space(5);
        }

        void DrawInspector()
        {
            serializedObject.Update();

            DrawPropertiesExcluding(serializedObject, excludeProps);

            serializedObject.ApplyModifiedProperties();
        }
    }
}



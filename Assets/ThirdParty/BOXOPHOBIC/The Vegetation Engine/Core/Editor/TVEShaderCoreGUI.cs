//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.IO;
using System.Collections.Generic;
using TheVegetationEngine;
using Boxophobic.StyledGUI;

public class TVEShaderCoreGUI : ShaderGUI
{
    bool multiSelection = false;
    bool showInternalProperties = false;
    bool showHiddenProperties = false;
    bool showAdditionalInfo = false;

    public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader)
    {
        base.AssignNewShaderToMaterial(material, oldShader, newShader);

        TVEUtils.SetMaterialSettings(material);
    }

    public override void OnClosed(Material material)
    {
        base.OnClosed(material);

        // Used for debugging shared materials
        if (material.HasProperty("_IsIdentifier"))
        {
            Shader.SetGlobalInt("TVE_DEBUG_Identifier", -1);
        }
    }

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var material0 = materialEditor.target as Material;
        var materials = materialEditor.targets;

        if (materials.Length > 1)
            multiSelection = true;

        // Used for impostors only
        if (material0.HasProperty("_IsInitialized"))
        {
            if (material0.GetFloat("_IsInitialized") > 0)
            {
                DrawDynamicInspector(material0, materialEditor, props);
            }
            else
            {
                DrawInitInspector(material0);
            }
        }
        else
        {
            DrawDynamicInspector(material0, materialEditor, props);
        }

        foreach (Material material in materials)
        {
            TVEUtils.SetMaterialSettings(material);
        }
    }

    void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var bannerText = Path.GetFileNameWithoutExtension(material.shader.name);

        StyledGUI.DrawInspectorBanner(bannerText);

        var customPropsList = new List<MaterialProperty>();

        if (multiSelection)
        {
            for (int i = 0; i < props.Length; i++)
            {
                var prop = props[i];

                if (prop.flags == MaterialProperty.PropFlags.HideInInspector)
                    continue;

                if (prop.name == "unity_Lightmaps")
                    continue;

                if (prop.name == "unity_LightmapsInd")
                    continue;

                if (prop.name == "unity_ShadowMasks")
                    continue;

                customPropsList.Add(prop);
            }
        }
        else
        {
            for (int i = 0; i < props.Length; i++)
            {
                var prop = props[i];
                var internalName = prop.name;

                if (prop.flags == MaterialProperty.PropFlags.HideInInspector && !showHiddenProperties)
                {
                    continue;
                }

                if (TVEShaderUtils.GetPropertyVisibility(material, internalName))
                {
                    customPropsList.Add(prop);
                }

                //if (prop.name.Contains("Category"))
                //{
                //    if (material.GetInt(prop.name) == 0)
                //    {
                //        showCategory = false;
                //    }
                //    else
                //    {
                //        showCategory = true;
                //        customPropsList.Add(prop);
                //    }
                //}
                //else
                //{
                //    if (showCategory)
                //    {
                //        if (TVEShaderUtils.GetPropertyVisibility(material, internalName))
                //        {
                //            customPropsList.Add(prop);
                //        }
                //    }
                //}
            }
        }

        //Draw Custom GUI
        for (int i = 0; i < customPropsList.Count; i++)
        {
            var property = customPropsList[i];
            var displayName = TVEShaderUtils.GetPropertyDisplay(material, property);

            var debug = "";

            if (showInternalProperties)
            {
                debug = "  (" + customPropsList[i].name + ")";
            }

            if (customPropsList[i].type == MaterialProperty.PropType.Texture)
            {
                materialEditor.TexturePropertySingleLine(new GUIContent(displayName + debug, ""), customPropsList[i]);
            }
            else
            {
                materialEditor.ShaderProperty(customPropsList[i], displayName + debug);
            }
        }

        GUILayout.Space(10);

        StyledGUI.DrawInspectorCategory("Advanced Settings");

        GUILayout.Space(10);

        if (material.HasProperty("_VertexDataMode"))
        {
            var batching = material.GetInt("_VertexDataMode");

            if (batching == 0)
            {
                TVEShaderUtils.DrawPivotsSupport(material);
                TVEShaderUtils.DrawDynamicSupport(material);
            }
        }
        else
        {
            TVEShaderUtils.DrawPivotsSupport(material);
            TVEShaderUtils.DrawDynamicSupport(material);
        }

        TVEShaderUtils.DrawBatchingSupport(material);
        materialEditor.EnableInstancingField();

        GUILayout.Space(10);

        TVEShaderUtils.DrawCopySettingsFromGameObject(material);
        TVEShaderUtils.DrawRenderQueue(material, materialEditor);

        GUILayout.Space(10);

        showInternalProperties = EditorGUILayout.Toggle("Show Internal Properties", showInternalProperties);
        showHiddenProperties = EditorGUILayout.Toggle("Show Hidden Properties", showHiddenProperties);
        showAdditionalInfo = EditorGUILayout.Toggle("Show Additional Info", showAdditionalInfo);

        if (showAdditionalInfo)
        {
            GUILayout.Space(10);

            TVEShaderUtils.DrawTechnicalDetails(material);
        }

        GUILayout.Space(15);

        TVEShaderUtils.DrawPoweredByTheVegetationEngine();
    }

    void DrawInitInspector(Material material)
    {
        var shaderName = material.shader.name;

        var bannerText = Path.GetFileNameWithoutExtension(shaderName);

        StyledGUI.DrawInspectorBanner(bannerText);

        GUILayout.Space(5);

        EditorGUILayout.HelpBox("The original material properties are not copied to the Impostor material. Drag the game object the impostor is baked from to the field below to copy the properties!", MessageType.Error, true);

        GUILayout.Space(10);

        TVEShaderUtils.DrawCopySettingsFromGameObject(material);

        GUILayout.Space(10);
    }
}


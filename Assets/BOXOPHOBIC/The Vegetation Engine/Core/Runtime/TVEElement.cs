// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic.StyledGUI;
using System.Collections.Generic;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
    public enum ElementVisibility
    {
        UseGlobalVolumeSettings = -1,
        AlwaysHidden = 0,
        AlwaysVisible = 10,
        HiddenAtRuntime = 20,
    }

    [HelpURL("https://docs.google.com/document/d/145JOVlJ1tE-WODW45YoJ6Ixg23mFc56EnB_8Tbwloz8/edit#heading=h.fd5y8rbb7aia")]
    [ExecuteInEditMode]
    [AddComponentMenu("BOXOPHOBIC/The Vegetation Engine/TVE Element")]
    public class TVEElement : StyledMonoBehaviour
    {
        [StyledBanner(0.890f, 0.745f, 0.309f, "Element")]
        public bool styledBanner;

#if UNITY_EDITOR
        [StyledMessage("Error", "The current element is outside the Global Volume / Follow Main Camera Volume or the material is missing the ElementType tag and it is not rendered! Activate the scene Gizmos to see the volume bounds!", 0, 10)]
        public bool showValidMessage;
#endif

        [Tooltip("Sets the element visibility.")]
        public ElementVisibility customVisibility = ElementVisibility.UseGlobalVolumeSettings;
        [Tooltip("Sets a custom material for element rendering.")]
        public Material customMaterial;

        [Tooltip("Sets the terrain height or splat map as element textures.")]
        public Terrain terrainData;

        [HideInInspector]
        public TVEElementMaterialData materialData;
        [System.NonSerialized]
        public TVEElementData elementData;
        [System.NonSerialized]
        public Renderer elementRenderer;
        [System.NonSerialized]
        public Material elementMaterial;
        [System.NonSerialized]
        public Mesh elementMesh;
        [System.NonSerialized]
        public float elementFadeValue = 1;

        new ParticleSystem particleSystem;

        int useVertexColorDirection = 0;
        int useRaycastFading = 0;
        Vector3 lastPosition;

        LayerMask raycastMask;
        float raycastEnd = 0;

        bool isSelected = false;
        bool isValid = true;

        void OnEnable()
        {
            particleSystem = gameObject.GetComponent<ParticleSystem>();
            elementRenderer = gameObject.GetComponent<Renderer>();

            if (customMaterial != null)
            {
                elementMaterial = customMaterial;
            }
            else
            {
                elementMaterial = elementRenderer.sharedMaterial;
            }

            if (elementMaterial == null || elementMaterial.name == TVEConstants.ElementName)
            {
                if (materialData == null)
                {
                    materialData = new TVEElementMaterialData();
                }

                if (materialData.shader == null)
                {
#if UNITY_EDITOR
                    elementMaterial = new Material(Resources.Load<Material>("Internal Colors"));
                    SaveMaterialData(elementMaterial);
#endif
                }
                else
                {
                    elementMaterial = new Material(materialData.shader);
                    LoadMaterialData(elementMaterial);
                }

                elementMaterial.name = TVEConstants.ElementName;
                gameObject.GetComponent<Renderer>().sharedMaterial = elementMaterial;
            }
        }

        void OnDestroy()
        {
            TVEUtils.RemoveElementDataFromVolume(elementData);
            elementData = null;
        }

        void OnDisable()
        {
            TVEUtils.RemoveElementDataFromVolume(elementData);
            elementData = null;
        }

        void Update()
        {
            if (TVEManager.Instance == null)
            {
                return;
            }

#if UNITY_EDITOR
            if (Selection.Contains(gameObject))
            {
                isSelected = true;
            }
            else
            {
                isSelected = false;
            }
#endif

            if (elementData == null || isSelected)
            {
                if (customMaterial != null)
                {
                    elementMaterial = customMaterial;
                }
                else
                {
                    elementMaterial = elementRenderer.sharedMaterial;
                }

                if (elementMaterial != null)
                {
                    TVEUtils.SetElementSettings(elementMaterial);
                    TVEUtils.CopyTerrainDataToElement(terrainData, elementMaterial);

                    GetMaterialParameters();

#if UNITY_EDITOR
                    if (!EditorUtility.IsPersistent(elementMaterial))
                    {
                        SaveMaterialData(elementMaterial);
                    }
#endif
                }

                var meshFilter = gameObject.GetComponent<MeshFilter>();

                if (meshFilter != null)
                {
                    elementMesh = gameObject.GetComponent<MeshFilter>().sharedMesh;
                }

                elementData = TVEUtils.CreateElementData(this);

                TVEUtils.AddElementDataToVolume(elementData);
                TVEUtils.SetElementVisibility(elementData, customVisibility);

#if UNITY_EDITOR
                TVEManager.Instance.globalVolume.SortElementObjects();

                // Needed when gizmos is not enabled
                isValid = TVEUtils.IsValidElement(elementData);

                if (isValid)
                {
                    showValidMessage = false;
                }
                else
                {
                    showValidMessage = true;
                }
#endif
            }

            if (particleSystem != null)
            {
                var particleModule = particleSystem.main;
                var particleColor = particleModule.startColor.color;

                if (useVertexColorDirection > 0)
                {
                    var direction = transform.position - lastPosition;
                    var localDirection = transform.InverseTransformDirection(direction);
                    var worldDirection = transform.TransformVector(localDirection);
                    lastPosition = transform.position;

                    var worldDirectionX = Mathf.Clamp01(worldDirection.x * 10 * 0.5f + 0.5f);
                    var worldDirectionZ = Mathf.Clamp01(worldDirection.z * 10 * 0.5f + 0.5f);

                    particleColor = new Color(worldDirectionX, worldDirectionZ, particleColor.b, particleColor.a);
                }

                if (useRaycastFading > 0)
                {
                    var fade = GetRacastFading();
                    particleColor = new Color(particleColor.r, particleColor.g, particleColor.b, fade);
                }
                else
                {
                    particleColor = new Color(particleColor.r, particleColor.g, particleColor.b, particleColor.a);
                }

                particleModule.startColor = particleColor;
            }
            else
            {
                if (useRaycastFading > 0)
                {
                    var fade = GetRacastFading();

                    elementFadeValue = fade;
                }
                else
                {
                    elementFadeValue = 1.0f;
                }
            }
        }


#if UNITY_EDITOR
        void SaveMaterialData(Material material)
        {
            materialData = new TVEElementMaterialData();
            materialData.props = new List<TVEElementPropertyData>();

            materialData.shader = material.shader;
            materialData.shaderName = material.shader.name;

            for (int i = 0; i < ShaderUtil.GetPropertyCount(material.shader); i++)
            {
                var type = ShaderUtil.GetPropertyType(material.shader, i);
                var prop = ShaderUtil.GetPropertyName(material.shader, i);

                if (type == ShaderUtil.ShaderPropertyType.TexEnv)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = PropertyType.Texture;
                    propData.prop = prop;
                    propData.texture = material.GetTexture(prop);

                    materialData.props.Add(propData);
                }

                if (type == ShaderUtil.ShaderPropertyType.Vector || type == ShaderUtil.ShaderPropertyType.Color)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = PropertyType.Vector;
                    propData.prop = prop;
                    propData.vector = material.GetVector(prop);

                    materialData.props.Add(propData);
                }

                if (type == ShaderUtil.ShaderPropertyType.Float || type == ShaderUtil.ShaderPropertyType.Range)
                {
                    var propData = new TVEElementPropertyData();
                    propData.type = PropertyType.Value;
                    propData.prop = prop;
                    propData.value = material.GetFloat(prop);

                    materialData.props.Add(propData);
                }
            }
        }
#endif

        void LoadMaterialData(Material material)
        {
            material.shader = materialData.shader;

            for (int i = 0; i < materialData.props.Count; i++)
            {
                if (materialData.props[i].type == PropertyType.Texture)
                {
                    material.SetTexture(materialData.props[i].prop, materialData.props[i].texture);
                }

                if (materialData.props[i].type == PropertyType.Vector)
                {
                    material.SetVector(materialData.props[i].prop, materialData.props[i].vector);
                }

                if (materialData.props[i].type == PropertyType.Value)
                {
                    material.SetFloat(materialData.props[i].prop, materialData.props[i].value);
                }
            }
        }

        void GetMaterialParameters()
        {
            if (elementMaterial.HasProperty(TVEConstants.ElementDirectionMode))
            {
                if (elementMaterial.GetInt(TVEConstants.ElementDirectionMode) == 30)
                {
                    useVertexColorDirection = 1;
                }
                else
                {
                    useVertexColorDirection = 0;
                }
            }

            if (elementMaterial.HasProperty(TVEConstants.ElementRaycastMode))
            {
                useRaycastFading = elementMaterial.GetInt(TVEConstants.ElementRaycastMode);
                raycastMask = elementMaterial.GetInt(TVEConstants.RaycastLayerMask);
                raycastEnd = elementMaterial.GetInt(TVEConstants.RaycastDistanceEndValue);
            }
        }

        float GetRacastFading()
        {
            raycastEnd = elementMaterial.GetInt(TVEConstants.RaycastDistanceEndValue);

            RaycastHit hit;
            bool raycastHit = Physics.Raycast(transform.position, -Vector3.up, out hit, Mathf.Infinity, raycastMask);

            if (hit.distance > 0)
            {
                return 1 - Mathf.Clamp01(hit.distance / raycastEnd);
            }
            else
            {
                return 0;
            }
        }

        void OnDrawGizmosSelected()
        {
            DrawGizmos(true);
        }

        void OnDrawGizmos()
        {
            DrawGizmos(false);
        }

        void DrawGizmos(bool selected)
        {
            if (TVEManager.Instance == null || elementData == null)
            {
                return;
            }

            var genericColor = new Color(0.0f, 0.0f, 0.0f, 0.1f);
            var invalidColor = new Color(1.0f, 0.0f, 0.0f, 0.1f);

            if (selected)
            {
                genericColor = new Color(0.0f, 0.0f, 0.0f, 1.0f);
                //genericColor = new Color(0.890f, 0.745f, 0.309f, 1.0f);
                invalidColor = new Color(1.0f, 0.0f, 0.0f, 1.0f);
            }

            isValid = TVEUtils.IsValidElement(elementData);

            if (isValid)
            {
                Gizmos.color = genericColor;
            }
            else
            {
                Gizmos.color = invalidColor;
            }

            if (isSelected)
            {
                if (useRaycastFading > 0)
                {
                    Gizmos.DrawLine(transform.position, new Vector3(transform.position.x, transform.position.y - raycastEnd, transform.position.z));
                }
            }

            Bounds gizmoBounds;

            if (elementData.element.elementMesh != null)
            {
                gizmoBounds = elementData.element.elementMesh.bounds;
                Gizmos.matrix = transform.localToWorldMatrix;
            }
            else
            {
                gizmoBounds = elementData.element.elementRenderer.bounds;
            }

            Gizmos.DrawWireCube(gizmoBounds.center, gizmoBounds.size);
        }
    }
}

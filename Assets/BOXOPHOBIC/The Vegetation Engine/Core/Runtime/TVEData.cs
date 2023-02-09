// Cristian Pop - https://boxophobic.com/

using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
#if UNITY_EDITOR
using UnityEditor;
#endif

namespace TheVegetationEngine
{
    public enum PropertyType
    {
        Texture = 0,
        Vector = 1,
        Value = 2,
    }

    public enum ElementsVisibility
    {
        AlwaysHidden = 0,
        AlwaysVisible = 10,
        HiddenAtRuntime = 20,
    }

    public enum ElementsSorting
    {
        SortInEditMode = 0,
        SortAtRuntime = 10,
    }

    public enum RenderDataMode
    {
        Off = -1,
        FollowMainCamera256 = 8,
        FollowMainCamera512 = 9,
        FollowMainCamera1024 = 10,
        FollowMainCamera2048 = 11,
        FollowMainCamera4096 = 12,
        InsideGlobalVolume256 = 256,
        InsideGlobalVolume512 = 512,
        InsideGlobalVolume1024 = 1024,
        InsideGlobalVolume2048 = 2048,
        InsideGlobalVolume4096 = 4096,
    }

#if UNITY_EDITOR
    public enum PrefabStatus
    {
        Undefined = -1,
        Converted = 10,
        Supported = 20,
        Backup = 25,
        Unsupported = 30,
        ConvertedMissingBackup = 40,
        ConvertedAndCollected = 50,
    }
#endif

    public class TVEConstants
    {
        public const string ElementName = "Element";
        public const string ElementTypeTag = "ElementType";
        public const string ElementLayerMask = "_ElementLayerMask";
        public const string ElementDirectionMode = "_ElementDirectionMode";
        public const string ElementRaycastMode = "_ElementRaycastMode";
        public const string RaycastLayerMask = "_RaycastLayerMask";
        public const string RaycastDistanceEndValue = "_RaycastDistanceEndValue";
    }

#if UNITY_EDITOR
    [System.Serializable]
    public class TVEPrefabData
    {
        public GameObject gameObject;
        public PrefabStatus status;
        public string attributes = "";

        public TVEPrefabData()
        {

        }
    }

    [System.Serializable]
    public class TVEMaterialData
    {
        public enum PropertyType
        {
            Value = 0,
            Range = 1,
            Vector = 2,
            Color = 3,
            Enum = 4,
            Toggle = 5,
            Space = 90,
            Category = 91,
            Message = 92,
        }

        public PropertyType type;
        public string prop;
        public string name;
        public float value;
        public float min;
        public float max;
        public bool snap;
        public Vector4 vector;
        public string file;
        public string options;
        public bool hdr;
        public bool space;
        public int spaceTop;
        public int spaceDown;
        public string category;
        public string message;
        public MessageType messageType = MessageType.Info;

        public TVEMaterialData(string prop)
        {
            type = PropertyType.Space;
            this.prop = prop;
            //this.valid = valid;
        }

        public TVEMaterialData(string prop, string category)
        {
            type = PropertyType.Category;
            this.prop = prop;
            this.category = category;
            //this.valid = valid;
        }

        public TVEMaterialData(string prop, string message, int spaceTop, int spaceDown, MessageType messageType)
        {
            type = PropertyType.Message;
            this.prop = prop;
            this.message = message;
            this.spaceTop = spaceTop;
            this.spaceDown = spaceDown;
            this.messageType = messageType;
        }

        public TVEMaterialData(string prop, string name, float value, bool snap, bool space)
        {
            type = PropertyType.Value;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.snap = snap;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, int min, int max, bool snap, bool space)
        {
            type = PropertyType.Range;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.min = min;
            this.max = max;
            this.snap = snap;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, Vector4 vector, bool space)
        {
            type = PropertyType.Vector;
            this.prop = prop;
            this.name = name;
            this.vector = vector;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, Vector4 vector, bool hdr, bool space)
        {
            type = PropertyType.Color;
            this.prop = prop;
            this.name = name;
            this.vector = vector;
            this.hdr = hdr;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, string options, bool space)
        {
            type = PropertyType.Enum;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.options = options;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, string file, string options, bool space)
        {
            type = PropertyType.Enum;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.file = file;
            this.options = options;
            this.space = space;
        }

        public TVEMaterialData(string prop, string name, float value, bool space)
        {
            type = PropertyType.Toggle;
            this.prop = prop;
            this.name = name;
            this.value = value;
            this.space = space;
        }
    }
#endif

    [System.Serializable]
    public class TVEMeshData
    {
        public Mesh mesh;
        public List<float> variationMask;
        public List<float> occlusionMask;
        public List<float> detailMask;
        public List<float> heightMask;
        public List<Vector2> detailCoord;
        public List<float> motion2Mask;
        public List<float> motion3Mask;
        public List<Vector3> pivotPositions;

        public TVEMeshData()
        {

        }
    }

#if UNITY_EDITOR
    public class TVEMeshSettings
    {
        public bool isReadable = false;
        public bool keepQuads = false;
        public ModelImporterMeshCompression meshCompression;

        public TVEMeshSettings()
        {

        }
    }
#endif

    [System.Serializable]
    public class TVEElementMaterialData
    {
        public Shader shader;
        public string shaderName = "";
        public List<TVEElementPropertyData> props;

        public TVEElementMaterialData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementPropertyData
    {
        public PropertyType type;
        public string prop;
        public Texture texture;
        public Vector4 vector;
        public float value;

        public TVEElementPropertyData()
        {

        }
    }

    [System.Serializable]
    public class TVEElementData
    {
        public TVEElement element;
        public int elementDataID = 0;
        public int instancedDataID = 0;
        public int renderDataID = 0;
        public List<int> layers;
        public bool useGlobalVolumeVisibility = true;

        public TVEElementData()
        {

        }
    }

    [System.Serializable]
    public class TVEInstancedData
    {
        public int instancedDataID = 0;
        public int renderDataID = 0;
        public List<int> layers;
        public Material material;
        public Mesh mesh;
        public List<TVEElement> elements = new List<TVEElement>();
        public List<Renderer> renderers = new List<Renderer>();
        public MaterialPropertyBlock propertyBlock = new MaterialPropertyBlock();

        public TVEInstancedData()
        {

        }
    }

    [System.Serializable]
    public class TVERenderData
    {
        [Tooltip("When enabled, the render texture will be created and rendered.")]
        public bool isEnabled = true;
        [Tooltip("When enabled, the elements are rendered in realtime.")]
        public bool isRendering = true;
        [Tooltip("When enabled, the global volume follows the main camera.")]
        public bool isFollowing = false;
        [Tooltip("When enabled, the elements are rendered by the main camera.")]
        public bool isProjected = false;

        [Space(10)]
        public string rendererName = "CustomRenderer";

        [Space(10)]
        [Tooltip("Sets the render texture format.")]
        public RenderTextureFormat texureFormat = RenderTextureFormat.ARGBHalf;
        [Tooltip("Sets the render texture width.")]
        public int textureWidth = 1024;
        [Tooltip("Sets the render texture height.")]
        public int textureHeight = 1024;
        [Tooltip("Sets the render texture resolution scale.")]
        public float textureScale = 1;
        [ColorUsage(true, true)]
        [Tooltip("Sets render texture background color.")]
        public Color textureColor = Color.black;

        [Space(10)]
        [Tooltip("The material ElementType tag used for elements filtering.")]
        public string materialTag = "CustomElement";
        [Tooltip("Sets the shader rendering passes.")]
        public int materialPass = 0;

        [Space(10)]
        [Tooltip("When enabled, the render texture resolution will match the screen resolution.")]
        public bool useScreenResolution = false;
        [Tooltip("When enabled, the active color space will be applied to the background color.")]
        public bool useActiveColorSpace = true;
        [Tooltip("When enabled, the render texture will render elements based on their layer.")]
        public bool useRenderTextureArray = true;

        [System.NonSerialized]
        public int renderDataID = 0;
        [System.NonSerialized]
        public int bufferSize = 0;
        [System.NonSerialized]
        public float[] bufferUsage;
        [System.NonSerialized]
        public RenderTexture texObject;
        [System.NonSerialized]
        public CommandBuffer[] commandBuffers;
        [System.NonSerialized]
        public Vector3 volumePosition;
        [System.NonSerialized]
        public Vector3 volumeScale;

        [HideInInspector]
        public string texName;
        [HideInInspector]
        public string texCoords;
        [HideInInspector]
        public string texParams;
        [HideInInspector]
        public string texLayers;
        [HideInInspector]
        public string texUsage;

        public TVERenderData()
        {

        }
    }
}
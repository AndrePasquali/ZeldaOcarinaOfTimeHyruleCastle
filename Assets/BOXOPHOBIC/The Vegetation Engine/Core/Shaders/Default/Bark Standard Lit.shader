// Made with Amplify Shader Editor v1.9.1.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/The Vegetation Engine/Default/Bark Standard Lit"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[StyledCategory(Render Settings, 5, 10)]_CategoryRender("[ Category Render ]", Float) = 1
		[Enum(Opaque,0,Transparent,1)]_RenderMode("Render Mode", Float) = 0
		[Enum(Off,0,On,1)]_RenderZWrite("Render ZWrite", Float) = 1
		[Enum(Both,0,Back,1,Front,2)]_RenderCull("Render Faces", Float) = 0
		[Enum(Flip,0,Mirror,1,Same,2)]_RenderNormals("Render Normals", Float) = 0
		[HideInInspector]_RenderQueue("Render Queue", Float) = 0
		[HideInInspector]_RenderPriority("Render Priority", Float) = 0
		[Enum(Off,0,On,1)]_RenderSpecular("Render Specular", Float) = 1
		[Enum(Off,0,On,1)]_RenderDecals("Render Decals", Float) = 0
		[Enum(Off,0,On,1)]_RenderSSR("Render SSR", Float) = 0
		[Space(10)]_RenderDirect("Render Direct", Range( 0 , 1)) = 1
		_RenderShadow("Render Shadow", Range( 0 , 1)) = 1
		_RenderAmbient("Render Ambient", Range( 0 , 1)) = 1
		[Enum(Off,0,On,1)][Space(10)]_RenderClip("Alpha Clipping", Float) = 1
		[Enum(Off,0,On,1)]_RenderCoverage("Alpha To Mask", Float) = 0
		_AlphaClipValue("Alpha Treshold", Range( 0 , 1)) = 0.5
		[StyledSpace(10)]_SpaceRenderFade("# Space Render Fade", Float) = 0
		_FadeConstantValue("Fade Constant Value", Range( 0 , 1)) = 0
		_FadeCameraValue("Fade Camera Distance", Range( 0 , 1)) = 1
		[StyledCategory(Global Settings)]_CategoryGlobals("[ Category Globals ]", Float) = 1
		[StyledMessage(Info, Procedural Variation in use. The Variation might not work as expected when switching from one LOD to another., 0, 10)]_MessageGlobalsVariation("# Message Globals Variation", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerExtrasValue("Layer Extras", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerMotionValue("Layer Motion", Float) = 0
		[StyledEnum(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_LayerVertexValue("Layer Vertex", Float) = 0
		[StyledSpace(10)]_SpaceGlobalLayers("# Space Global Layers", Float) = 0
		_GlobalOverlay("Global Overlay", Range( 0 , 1)) = 1
		_GlobalWetness("Global Wetness", Range( 0 , 1)) = 1
		_GlobalEmissive("Global Emissive", Range( 0 , 1)) = 1
		_GlobalSize("Global Size Fade", Range( 0 , 1)) = 1
		[StyledSpace(10)]_SpaceGlobalLocals("# Space Global Locals", Float) = 0
		[StyledSpace(10)]_SpaceGlobalExtras("# Space Global Options", Float) = 0
		[StyledToggle]_ExtrasPositionMode("Use Pivot Position for Extras", Float) = 0
		[StyledCategory(Main Settings)]_CategoryMain("[Category Main ]", Float) = 1
		[StyledMessage(Info, Use the Main Mask remap sliders to control the mask for Global Color__ Gradient Tinting and Subsurface Effect. The mask is stored in Main Mask Blue channel. , 0, 10)]_MessageMainMask("# Message Main Mask", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainAlbedoTex("Main Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainNormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_MainMaskTex("Main Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[HDR]_MainColor("Main Color", Color) = (1,1,1,1)
		_MainAlbedoValue("Main Albedo", Range( 0 , 1)) = 1
		_MainNormalValue("Main Normal", Range( -8 , 8)) = 1
		_MainOcclusionValue("Main Occlusion", Range( 0 , 1)) = 0
		_MainSmoothnessValue("Main Smoothness", Range( 0 , 1)) = 0
		[StyledRemapSlider(_MainMaskMinValue, _MainMaskMaxValue, 0, 1, 0, 0)]_MainMaskRemap("Main Mask Remap", Vector) = (0,0,0,0)
		[StyledCategory(Detail Settings)]_CategoryDetail("[ Category Detail ]", Float) = 1
		[StyledMessage(Info, Use the Detail Mask remap sliders to control the mask for Global Color__ Gradient Tinting and Subsurface Effect. The mask is stored in Detail Mask Blue channel., 0, 10)]_MessageSecondMask("# Message Second Mask", Float) = 0
		[Enum(Off,0,On,1)]_DetailMode("Detail Mode", Float) = 0
		[Enum(Overlay,0,Replace,1)]_DetailBlendMode("Detail Blend", Float) = 1
		[Enum(UV 0,0,Baked,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Enum(Off,0,On,1)]_DetailOpaqueMode("Detail Opaque", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_SecondAlbedoTex("Detail Albedo", 2D) = "white" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondNormalTex("Detail Normal", 2D) = "bump" {}
		[NoScaleOffset][StyledTextureSingleLine]_SecondMaskTex("Detail Mask", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[HDR]_SecondColor("Detail Color", Color) = (1,1,1,1)
		_SecondAlbedoValue("Detail Albedo", Range( 0 , 1)) = 1
		_SecondNormalValue("Detail Normal", Range( -8 , 8)) = 1
		_SecondOcclusionValue("Detail Occlusion", Range( 0 , 1)) = 0
		_SecondSmoothnessValue("Detail Smoothness", Range( 0 , 1)) = 0
		[StyledRemapSlider(_SecondMaskMinValue, _SecondMaskMaxValue, 0, 1, 0, 0)]_SecondMaskRemap("Detail Mask Remap", Vector) = (0,0,0,0)
		[Space(10)]_DetailNormalValue("Detail Blend Normals", Range( 0 , 1)) = 0.5
		[Enum(Main Mask,0,Detail Mask,1)][Space(10)]_DetailMaskMode("Blend Mask Mode", Float) = 0
		[Enum(Off,0,On,1)]_DetailMaskInvertMode("Blend Mask Invert", Float) = 0
		[StyledRemapSlider(_DetailBlendMinValue, _DetailBlendMaxValue,0,1)]_DetailBlendRemap("Blend Remap", Vector) = (0,0,0,0)
		[HideInInspector]_DetailBlendMinValue("Detail Blend Min", Range( 0 , 1)) = 0.4
		[HideInInspector]_DetailBlendMaxValue("Detail Blend Max", Range( 0 , 1)) = 0.6
		[StyledCategory(Occlusion Settings)]_CategoryOcclusion("[ Category Occlusion ]", Float) = 1
		[StyledMessage(Info, Use the Occlusion Color for tinting and the Occlusion Alpha as Global Color and Global Overlay mask control. The mask is stored in Vertex Green channel. , 0, 10)]_MessageOcclusion("# Message Occlusion", Float) = 0
		[HDR]_VertexOcclusionColor("Occlusion Color", Color) = (1,1,1,0.5019608)
		[StyledRemapSlider(_VertexOcclusionMinValue, _VertexOcclusionMaxValue, 0, 1, 0, 0)]_VertexOcclusionRemap("Occlusion Remap", Vector) = (0,0,0,0)
		[HideInInspector]_VertexOcclusionMinValue("Occlusion Min", Range( 0 , 1)) = 0
		[HideInInspector]_VertexOcclusionMaxValue("Occlusion Max", Range( 0 , 1)) = 1
		[StyledCategory(Gradient Settings)]_CategoryGradient("[ Category Gradient ]", Float) = 1
		[StyledRemapSlider(_GradientMinValue, _GradientMaxValue, 0, 1)]_GradientMaskRemap("Gradient Mask Remap", Vector) = (0,0,0,0)
		[StyledCategory(Noise Settings)]_CategoryNoise("[ Category Noise ]", Float) = 1
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1)]_NoiseMaskRemap("Noise Mask Remap", Vector) = (0,0,0,0)
		[StyledCategory(Subsurface Settings)]_CategorySubsurface("[ Category Subsurface ]", Float) = 1
		[StyledMessage(Info, In HDRP__ the Subsurface Color and Power are fake effects used for artistic control. For physically correct subsurface scattering the Power slider need to be set to 0., 0, 10)]_MessageSubsurface("# Message Subsurface", Float) = 0
		[DiffusionProfile]_SubsurfaceDiffusion("Subsurface Diffusion", Float) = 0
		[HideInInspector]_SubsurfaceDiffusion_Asset("Subsurface Diffusion", Vector) = (0,0,0,0)
		[StyledSpace(10)]_SpaceSubsurface("# SpaceSubsurface", Float) = 0
		_SubsurfaceScatteringValue("Subsurface Power", Range( 0 , 16)) = 2
		_SubsurfaceAngleValue("Subsurface Angle", Range( 1 , 16)) = 8
		_SubsurfaceDirectValue("Subsurface Direct", Range( 0 , 1)) = 1
		_SubsurfaceNormalValue("Subsurface Normal", Range( 0 , 1)) = 0
		_SubsurfaceAmbientValue("Subsurface Ambient", Range( 0 , 1)) = 0.2
		_SubsurfaceShadowValue("Subsurface Shadow", Range( 0 , 1)) = 1
		[StyledCategory(Emissive Settings)]_CategoryEmissive("[ Category Emissive]", Float) = 1
		[NoScaleOffset][Space(10)][StyledTextureSingleLine]_EmissiveTex("Emissive Texture", 2D) = "white" {}
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		[StyledEmissiveIntensity]_EmissiveIntensityParams("Emissive Intensity", Vector) = (1,1,1,0)
		_EmissiveExposureValue("Emissive Weight", Range( 0 , 1)) = 1
		[HDR]_EmissiveColor("Emissive Color", Color) = (0,0,0,0)
		[Enum(None,0,Any,10,Baked,20,Realtime,30)]_EmissiveFlagMode("Emissive Mode", Float) = 0
		[StyledCategory(Perspective Settings)]_CategoryPerspective("[ Category Perspective ]", Float) = 1
		[StyledCategory(Size Fade Settings)]_CategorySizeFade("[ Category Size Fade ]", Float) = 1
		[StyledCategory(Motion Settings)]_CategoryMotion("[ Category Motion ]", Float) = 1
		[StyledMessage(Info, Procedural variation in use. Use the Scale settings if the Variation is splitting the mesh., 0, 10)]_MessageMotionVariation("# Message Motion Variation", Float) = 0
		_MotionFacingValue("Motion Directional Mask", Range( 0 , 1)) = 1
		_MotionObjectVariation("Motion Object Variation", Range( 0 , 1)) = 0
		[StyledSpace(10)]_SpaceMotionGlobals("# SpaceMotionGlobals", Float) = 0
		_MotionAmplitude_10("Motion Bending", Range( 0 , 2)) = 0.2
		[IntRange]_MotionSpeed_10("Motion Speed", Range( 0 , 40)) = 2
		_MotionScale_10("Motion Scale", Range( 0 , 20)) = 0
		_MotionVariation_10("Motion Variation", Range( 0 , 20)) = 0
		[Space(10)]_MotionAmplitude_20("Motion Squash", Range( 0 , 2)) = 0.2
		_MotionAmplitude_22("Motion Rolling", Range( 0 , 2)) = 0.2
		[IntRange]_MotionSpeed_20("Motion Speed", Range( 0 , 40)) = 6
		_MotionScale_20("Motion Scale", Range( 0 , 20)) = 0.5
		_MotionVariation_20("Motion Variation", Range( 0 , 20)) = 0
		[Space(10)]_InteractionAmplitude("Interaction Amplitude", Range( 0 , 2)) = 1
		_InteractionMaskValue("Interaction Use Mask", Range( 0 , 1)) = 0
		[StyledSpace(10)]_SpaceMotionLocals("# SpaceMotionLocals", Float) = 0
		[ASEEnd][StyledToggle]_MotionValue_20("Use Branch Motion Settings", Float) = 1
		[HideInInspector][StyledToggle]_VertexPivotMode("Enable Pre Baked Pivots", Float) = 0
		[HideInInspector][StyledToggle]_VertexDataMode("Enable Batching Support", Float) = 0
		[HideInInspector][StyledToggle]_VertexDynamicMode("Enable Dynamic Support", Float) = 0
		[HideInInspector]_render_normals("_render_normals", Vector) = (1,1,1,0)
		[HideInInspector]_Cutoff("Legacy Cutoff", Float) = 0.5
		[HideInInspector]_Color("Legacy Color", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("Legacy MainTex", 2D) = "white" {}
		[HideInInspector]_BumpMap("Legacy BumpMap", 2D) = "white" {}
		[HideInInspector]_MaxBoundsInfo("Legacy Bounds Info", Vector) = (1,1,1,1)
		[HideInInspector]_ColorsMaskMinValue("_ColorsMaskMinValue", Range( 0 , 1)) = 0
		[HideInInspector]_ColorsMaskMaxValue("_ColorsMaskMaxValue", Range( 0 , 1)) = 0
		[HideInInspector]_SubsurfaceMaskMinValue("_SubsurfaceMaskMinValue", Range( 0 , 1)) = 0
		[HideInInspector]_SubsurfaceMaskMaxValue("_SubsurfaceMaskMaxValue", Range( 0 , 1)) = 1
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 1
		[HideInInspector]_IsVersion("_IsVersion", Float) = 820
		[HideInInspector]_IsIdentifier("_IsIdentifier", Float) = 0
		[HideInInspector]_IsCollected("_IsCollected", Float) = 0
		[HideInInspector]_IsShared("_IsShared", Float) = 0
		[HideInInspector]_HasEmissive("_HasEmissive", Float) = 0
		[HideInInspector]_HasGradient("_HasGradient", Float) = 0
		[HideInInspector]_HasOcclusion("_HasOcclusion", Float) = 0
		[HideInInspector]_VertexVariationMode("_VertexVariationMode", Float) = 0
		[HideInInspector]_IsBarkShader("_IsBarkShader", Float) = 1
		[HideInInspector]_IsStandardShader("_IsStandardShader", Float) = 1
		[HideInInspector]_render_cull("_render_cull", Float) = 0
		[HideInInspector]_render_src("_render_src", Float) = 1
		[HideInInspector]_render_dst("_render_dst", Float) = 0
		[HideInInspector]_render_zw("_render_zw", Float) = 1

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector][ToggleUI] _SupportDecals("Support Decals", Float) = 1.0
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0 // StencilUsage.Clear
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 0 // Nothing
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8 // StencilUsage.TraceReflectionRay
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 4 				// DEPRECATED
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 4	// DEPRECATED
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 2 // StencilUsage.RequiresDeferredLighting
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector][ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector][ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector][ToggleUI] _ReceivesSSRTransparent("Receives SSR Transparent", Float) = 0
		[HideInInspector] _SurfaceType("Surface Type", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector][ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector][ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 0
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Float) = 0
		[HideInInspector][ToggleUI] _EnableFogOnTransparent("Enable Fog", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2 // This mode is dedicated to Forward to correctly handle backface then front face rendering thin transparent
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.TransparentCullMode)] _TransparentCullMode("Transparent Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4 // Less equal
		[HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Int) = 4 // Less equal
		[HideInInspector][ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector][ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 0
		[HideInInspector][ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 0
		[HideInInspector][ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 0
		[HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleUI] _TransparentWritingMotionVec("Transparent Writing MotionVec", Float) = 0
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)] _OpaqueCullMode("Opaque Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector][ToggleUI] _EnableBlendModePreserveSpecularLighting("Enable Blend Mode Preserve Specular Lighting", Float) = 1
		[HideInInspector] _EmissionColor("Color", Color) = (1, 1, 1)

		[HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		[HideInInspector][Enum(Auto, 0, On, 1, Off, 2)] _DoubleSidedGIMode("Double sided GI mode", Float) = 0 //DoubleSidedGIMode added in api 12x and higher

		[HideInInspector][ToggleUI] _AlphaToMaskInspectorValue("_AlphaToMaskInspectorValue", Float) = 0 // Property used to save the alpha to mask state in the inspector
        [HideInInspector][ToggleUI] _AlphaToMask("__alphaToMask", Float) = 0
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma exclude_renderers glcore gles gles3 

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		struct GlobalSurfaceDescription // GBuffer Forward META TransparentBackface
		{
			float3 BaseColor;
			float3 Normal;
			float3 BentNormal;
			float3 Specular;
			float CoatMask;
			float Metallic;
			float3 Emission;
			float Smoothness;
			float Occlusion;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float AlphaClipThresholdDepthPostpass;
			float SpecularAAScreenSpaceVariance;
			float SpecularAAThreshold;
			float SpecularOcclusion;
			float DepthOffset;
			//Refraction
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			//SSS/Translucent
			float DiffusionProfile;
			float TransmissionMask;
			// Transmission + Diffusion Profile
			float Thickness;
			float SubsurfaceMask;
			//Anisotropy
			float Anisotropy;
			float3 Tangent;
			//Iridescent
			float IridescenceMask;
			float IridescenceThickness;
			//BakedGI
			float3 BakedGI;
			float3 BakedBackGI;
			//Virtual Texturing
			float4 VTPackedFeedback;
		};

		struct AlphaSurfaceDescription // ShadowCaster
		{
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float DepthOffset;
		};

		struct SceneSurfaceDescription // SceneSelection
		{
			float Alpha;
			float AlphaClipThreshold;
			float DepthOffset;
		};

		struct PrePassSurfaceDescription // DepthPrePass
		{
			float3 Normal;
			float Smoothness;
			float Alpha;
			float AlphaClipThresholdDepthPrepass;
			float DepthOffset;
		};

		struct PostPassSurfaceDescription //DepthPostPass
		{
			float Alpha;
			float AlphaClipThresholdDepthPostpass;
			float DepthOffset;
		};

		struct SmoothSurfaceDescription // MotionVectors DepthOnly
		{
			float3 Normal;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float DepthOffset;
		};

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="GBuffer" }

			Cull [_CullMode]
			ZTest [_ZTestGBuffer]

			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			ColorMask [_LightLayersMaskBuffer4] 4
			ColorMask [_LightLayersMaskBuffer5] 5

			HLSLPROGRAM

            #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _ENERGY_CONSERVING_SPECULAR 1
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #define _AMBIENT_OCCLUSION 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140005
            #if !defined(ASE_NEED_CULLFACE)
            #define ASE_NEED_CULLFACE 1
            #endif //ASE_NEED_CULLFACE
            #define ASE_USING_SAMPLING_MACROS 1


            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
			#pragma multi_compile_fragment _ LIGHT_LAYERS
			#pragma multi_compile_fragment PROBE_VOLUMES_OFF PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
			#pragma multi_compile _ DEBUG_DISPLAY
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
			#pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_GBUFFER

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

		    // Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half4 TVE_OverlayColor;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			half TVE_WetnessContrast;
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_SecondNormalTex);
			half TVE_OverlayNormalValue;
			half TVE_WetnessNormalValue;
			TEXTURE2D(_EmissiveTex);
			half TVE_OverlaySmoothness;
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_VFACE
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_color : COLOR;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};


			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			
			half2 NormalUnpack( half4 packed )
			{
				    #if defined(UNITY_NO_DXT5nm)
				        half2 unpacked = packed.xyz * 2 - 1;
				        return unpacked;
				    #elif defined(UNITY_ASTC_NORMALMAP_ENCODING)
				        half2 unpacked;
				        unpacked.xy = (packed.wy * 2 - 1);
				        return unpacked;
				    #else
				        // This do the trick
				        packed.x *= packed.w;
				        half2 unpacked;
				        unpacked.xy = (packed.xy * 2 - 1);
				        return unpacked;
				    #endif
			}
			
			float3 ASEGetEmissionHDRColor(float3 ldrColor, float luminanceIntensity, float exposureWeight, float inverseCurrentExposureMultiplier)
			{
				float3 hdrColor = ldrColor * luminanceIntensity;
				hdrColor = lerp( hdrColor* inverseCurrentExposureMultiplier, hdrColor, exposureWeight);
				return hdrColor;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

				#ifdef _ALPHATEST_ON
				builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

				#ifdef UNITY_VIRTUAL_TEXTURING
                builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
				builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
				builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord6.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord6.yzw = vertexToFrag3890_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = vertexToFrag4224_g71633;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 vertexToFrag5058_g71633 = ase_worldNormal;
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = vertexToFrag5058_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord5 = inputMesh.ase_texcoord;
				outputPackedVaryingsMeshToPS.ase_color = inputMesh.ase_color;
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput,
						OUTPUT_GBUFFER(outGBuffer)
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : SV_Depth
						#endif
						
						)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.uv1.xyzw;
				input.texCoord2 = packedInput.uv2.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);
				SurfaceData surfaceData;
				BuiltinData builtinData;

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord5.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				float3 lerpResult6223_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode29_g71633).rgb , _MainAlbedoValue);
				half3 Main_Albedo99_g71633 = ( (_MainColor).rgb * lerpResult6223_g71633 );
				float2 appendResult21_g75853 = (float2(packedInput.uv1.z , packedInput.uv1.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord5.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				float3 lerpResult6225_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode89_g71633).rgb , _SecondAlbedoValue);
				half3 Second_Albedo153_g71633 = ( (_SecondColor).rgb * lerpResult6225_g71633 );
				float3 lerpResult4834_g71633 = lerp( ( Main_Albedo99_g71633 * Second_Albedo153_g71633 * 4.594794 ) , Second_Albedo153_g71633 , _DetailBlendMode);
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord6.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float3 lerpResult235_g71633 = lerp( Main_Albedo99_g71633 , lerpResult4834_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch255_g71633 = lerpResult235_g71633;
				#else
				float3 staticSwitch255_g71633 = Main_Albedo99_g71633;
				#endif
				half3 Blend_Albedo265_g71633 = staticSwitch255_g71633;
				half3 Blend_Albedo_Gradient5769_g71633 = float3(1,1,1);
				half3 Blend_Albedo_Noise5770_g71633 = float3(1,1,1);
				float Mesh_Occlusion318_g71633 = packedInput.ase_color.g;
				float clampResult6091_g71633 = clamp( Mesh_Occlusion318_g71633 , 0.01 , 0.99 );
				float temp_output_7_0_g75800 = _VertexOcclusionMinValue;
				half Occlusion_Mask6432_g71633 = saturate( ( ( clampResult6091_g71633 - temp_output_7_0_g75800 ) / ( ( _VertexOcclusionMaxValue - temp_output_7_0_g75800 ) + 0.01 ) ) );
				float3 lerpResult2945_g71633 = lerp( (_VertexOcclusionColor).rgb , float3( 1,1,1 ) , Occlusion_Mask6432_g71633);
				half3 Occlusion_Color648_g71633 = lerpResult2945_g71633;
				half3 Blend_Albedo_Tinted2808_g71633 = ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 * Occlusion_Color648_g71633 );
				half3 Blend_Albedo_Colored863_g71633 = Blend_Albedo_Tinted2808_g71633;
				half3 Global_OverlayColor1758_g71633 = (TVE_OverlayColor).rgb;
				float temp_output_84_0_g75904 = _LayerExtrasValue;
				float4 temp_output_93_19_g75904 = TVE_ExtrasCoords;
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord6.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				float3 vertexToFrag4224_g71633 = packedInput.ase_texcoord7.xyz;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 lerpResult4827_g71633 = lerp( WorldPosition3905_g71633 , ObjectPosition4223_g71633 , _ExtrasPositionMode);
				half2 UV96_g75904 = ( (temp_output_93_19_g75904).zw + ( (temp_output_93_19_g75904).xy * (lerpResult4827_g71633).xz ) );
				float4 tex2DArrayNode48_g75904 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g75904,temp_output_84_0_g75904, 0.0 );
				float4 temp_output_94_85_g75904 = TVE_ExtrasParams;
				float4 ifLocalVar18_g75908 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] > 0.5 )
				ifLocalVar18_g75908 = tex2DArrayNode48_g75904;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] < 0.5 )
				ifLocalVar18_g75908 = temp_output_94_85_g75904;
				half4 Global_Extras_Params5440_g71633 = ifLocalVar18_g75908;
				float4 break456_g75748 = Global_Extras_Params5440_g71633;
				half Global_Extras_Overlay156_g71633 = break456_g75748.z;
				half Overlay_Variation4560_g71633 = 1.0;
				half Overlay_Value5738_g71633 = ( _GlobalOverlay * Global_Extras_Overlay156_g71633 * Overlay_Variation4560_g71633 );
				float3 vertexToFrag5058_g71633 = packedInput.ase_texcoord8.xyz;
				half3 World_Normal4101_g71633 = vertexToFrag5058_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				float lerpResult5730_g71633 = lerp( (World_Normal4101_g71633).y , packedInput.ase_normal.y , Global_DynamicMode5112_g71633);
				float lerpResult5885_g71633 = lerp( 0.4 , 1.0 , saturate( lerpResult5730_g71633 ));
				half Overlay_Projection6081_g71633 = lerpResult5885_g71633;
				float dotResult6416_g71633 = dot( ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 ) , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Globals6410_g71633 = dotResult6416_g71633;
				half Overlay_Shading6688_g71633 = saturate( ( Blend_Albedo_Globals6410_g71633 * 5.0 ) );
				half Overlay_Custom6707_g71633 = 1.0;
				half Occlusion_Alpha6463_g71633 = _VertexOcclusionColor.a;
				float lerpResult6467_g71633 = lerp( Occlusion_Alpha6463_g71633 , 1.0 , Occlusion_Mask6432_g71633);
				half Occlusion_Overlay6471_g71633 = lerpResult6467_g71633;
				float temp_output_7_0_g75888 = 0.1;
				half Overlay_Mask_High6064_g71633 = saturate( ( ( ( Overlay_Value5738_g71633 * Overlay_Projection6081_g71633 * Overlay_Shading6688_g71633 * Overlay_Custom6707_g71633 * Occlusion_Overlay6471_g71633 ) - temp_output_7_0_g75888 ) / ( ( 0.2 - temp_output_7_0_g75888 ) + 0.01 ) ) );
				half Overlay_Mask269_g71633 = Overlay_Mask_High6064_g71633;
				float3 lerpResult336_g71633 = lerp( Blend_Albedo_Colored863_g71633 , Global_OverlayColor1758_g71633 , Overlay_Mask269_g71633);
				half3 Blend_Albedo_Overlay359_g71633 = lerpResult336_g71633;
				half Global_WetnessContrast6502_g71633 = TVE_WetnessContrast;
				half Global_Extras_Wetness305_g71633 = break456_g75748.y;
				half Wetness_Value6343_g71633 = ( Global_Extras_Wetness305_g71633 * _GlobalWetness );
				float3 lerpResult6367_g71633 = lerp( Blend_Albedo_Overlay359_g71633 , ( Blend_Albedo_Overlay359_g71633 * Blend_Albedo_Overlay359_g71633 ) , ( Global_WetnessContrast6502_g71633 * Wetness_Value6343_g71633 ));
				half3 Blend_Albedo_Wetness6351_g71633 = lerpResult6367_g71633;
				float3 _Vector10 = float3(1,1,1);
				half3 Blend_Albedo_Highlight5771_g71633 = _Vector10;
				float3 temp_output_6309_0_g71633 = ( Blend_Albedo_Wetness6351_g71633 * Blend_Albedo_Highlight5771_g71633 );
				half3 Blend_Albedo_Subsurface149_g71633 = temp_output_6309_0_g71633;
				
				half4 packed34_g75830 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half2 localNormalUnpack34_g75830 = NormalUnpack( packed34_g75830 );
				half2 Main_Normal137_g71633 = ( localNormalUnpack34_g75830 * _MainNormalValue );
				float2 lerpResult3372_g71633 = lerp( float2( 0,0 ) , Main_Normal137_g71633 , _DetailNormalValue);
				half4 packed34_g75832 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half2 localNormalUnpack34_g75832 = NormalUnpack( packed34_g75832 );
				half2 Second_Normal179_g71633 = ( localNormalUnpack34_g75832 * _SecondNormalValue );
				float2 temp_output_36_0_g75857 = ( lerpResult3372_g71633 + Second_Normal179_g71633 );
				float2 lerpResult3376_g71633 = lerp( Main_Normal137_g71633 , temp_output_36_0_g75857 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float2 staticSwitch267_g71633 = lerpResult3376_g71633;
				#else
				float2 staticSwitch267_g71633 = Main_Normal137_g71633;
				#endif
				half2 Blend_Normal312_g71633 = staticSwitch267_g71633;
				half Global_OverlayNormalScale6581_g71633 = TVE_OverlayNormalValue;
				float lerpResult6585_g71633 = lerp( 1.0 , Global_OverlayNormalScale6581_g71633 , Overlay_Mask269_g71633);
				half2 Blend_Normal_Overlay366_g71633 = ( Blend_Normal312_g71633 * lerpResult6585_g71633 );
				half Global_WetnessNormalScale6571_g71633 = TVE_WetnessNormalValue;
				float lerpResult6579_g71633 = lerp( 1.0 , Global_WetnessNormalScale6571_g71633 , ( Wetness_Value6343_g71633 * Wetness_Value6343_g71633 ));
				half2 Blend_Normal_Wetness6372_g71633 = ( Blend_Normal_Overlay366_g71633 * lerpResult6579_g71633 );
				float3 appendResult6568_g71633 = (float3(Blend_Normal_Wetness6372_g71633 , 1.0));
				float3 temp_output_13_0_g75855 = appendResult6568_g71633;
				float3 switchResult12_g75855 = (((isFrontFace>0)?(temp_output_13_0_g75855):(( temp_output_13_0_g75855 * _render_normals ))));
				
				half Render_Specular4861_g71633 = _RenderSpecular;
				float3 temp_cast_5 = (( 0.04 * Render_Specular4861_g71633 )).xxx;
				
				float3 hdEmission4189_g71633 = ASEGetEmissionHDRColor(_EmissiveColor.rgb,_EmissiveIntensityParams.x,_EmissiveExposureValue,GetInverseCurrentExposureMultiplier());
				half2 Emissive_UVs2468_g71633 = ( ( packedInput.ase_texcoord5.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				half Global_Extras_Emissive4203_g71633 = break456_g75748.x;
				float lerpResult4206_g71633 = lerp( 1.0 , Global_Extras_Emissive4203_g71633 , _GlobalEmissive);
				half3 Final_Emissive2476_g71633 = ( (( float4( hdEmission4189_g71633 , 0.0 ) * SAMPLE_TEXTURE2D( _EmissiveTex, sampler_Linear_Repeat, Emissive_UVs2468_g71633 ) )).rgb * lerpResult4206_g71633 );
				
				half Main_Smoothness227_g71633 = ( tex2DNode35_g71633.a * _MainSmoothnessValue );
				half Second_Smoothness236_g71633 = ( tex2DNode33_g71633.a * _SecondSmoothnessValue );
				float lerpResult266_g71633 = lerp( Main_Smoothness227_g71633 , Second_Smoothness236_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch297_g71633 = lerpResult266_g71633;
				#else
				float staticSwitch297_g71633 = Main_Smoothness227_g71633;
				#endif
				half Blend_Smoothness314_g71633 = staticSwitch297_g71633;
				half Global_OverlaySmoothness311_g71633 = TVE_OverlaySmoothness;
				float lerpResult343_g71633 = lerp( Blend_Smoothness314_g71633 , Global_OverlaySmoothness311_g71633 , Overlay_Mask269_g71633);
				half Blend_Smoothness_Overlay371_g71633 = lerpResult343_g71633;
				float temp_output_6499_0_g71633 = ( 1.0 - Wetness_Value6343_g71633 );
				half Blend_Smoothness_Wetness4130_g71633 = saturate( ( Blend_Smoothness_Overlay371_g71633 + ( 1.0 - ( temp_output_6499_0_g71633 * temp_output_6499_0_g71633 ) ) ) );
				
				float lerpResult240_g71633 = lerp( 1.0 , tex2DNode35_g71633.g , _MainOcclusionValue);
				half Main_Occlusion247_g71633 = lerpResult240_g71633;
				float lerpResult239_g71633 = lerp( 1.0 , tex2DNode33_g71633.g , _SecondOcclusionValue);
				half Second_Occlusion251_g71633 = lerpResult239_g71633;
				float lerpResult294_g71633 = lerp( Main_Occlusion247_g71633 , Second_Occlusion251_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch310_g71633 = lerpResult294_g71633;
				#else
				float staticSwitch310_g71633 = Main_Occlusion247_g71633;
				#endif
				half Blend_Occlusion323_g71633 = staticSwitch310_g71633;
				
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.BaseColor = Blend_Albedo_Subsurface149_g71633;
				surfaceDescription.Normal = switchResult12_g75855;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = temp_cast_5;
				#endif

				surfaceDescription.Emission = Final_Emissive2476_g71633;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g71633;
				surfaceDescription.Occlusion = Blend_Occlusion323_g71633;
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				surfaceDescription.AlphaClipThresholdDepthPrepass = 0.5;
				surfaceDescription.AlphaClipThresholdDepthPostpass = 0.5;

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 0;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );
				ENCODE_INTO_GBUFFER( surfaceData, builtinData, posInput.positionSS, outGBuffer );
				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140005
			#if !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif //ASE_NEED_CULLFACE
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma shader_feature _ EDITOR_VISUALIZATION

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_LIGHT_TRANSPORT

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			// Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half4 TVE_OverlayColor;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			half TVE_WetnessContrast;
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_SecondNormalTex);
			half TVE_OverlayNormalValue;
			half TVE_WetnessNormalValue;
			TEXTURE2D(_EmissiveTex);
			half TVE_OverlaySmoothness;
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_VFACE
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				#ifdef EDITOR_VISUALIZATION
				float2 VizUV : TEXCOORD0;
				float4 LightCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_color : COLOR;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			
			half2 NormalUnpack( half4 packed )
			{
				    #if defined(UNITY_NO_DXT5nm)
				        half2 unpacked = packed.xyz * 2 - 1;
				        return unpacked;
				    #elif defined(UNITY_ASTC_NORMALMAP_ENCODING)
				        half2 unpacked;
				        unpacked.xy = (packed.wy * 2 - 1);
				        return unpacked;
				    #else
				        // This do the trick
				        packed.x *= packed.w;
				        half2 unpacked;
				        unpacked.xy = (packed.xy * 2 - 1);
				        return unpacked;
				    #endif
			}
			
			float3 ASEGetEmissionHDRColor(float3 ldrColor, float luminanceIntensity, float exposureWeight, float inverseCurrentExposureMultiplier)
			{
				float3 hdrColor = ldrColor * luminanceIntensity;
				hdrColor = lerp( hdrColor* inverseCurrentExposureMultiplier, hdrColor, exposureWeight);
				return hdrColor;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif

				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			#if SHADERPASS == SHADERPASS_LIGHT_TRANSPORT
			#define SCENEPICKINGPASS
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/MetaPass.hlsl"

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh  )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);

				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.uv3.x , inputMesh.uv3.z , inputMesh.uv3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.uv0.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.uv0.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord4.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord4.yzw = vertexToFrag3890_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord5.xyz = vertexToFrag4224_g71633;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 vertexToFrag5058_g71633 = ase_worldNormal;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag5058_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = ase_worldPos;
				
				outputPackedVaryingsMeshToPS.ase_texcoord2 = inputMesh.uv0;
				outputPackedVaryingsMeshToPS.ase_texcoord3 = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.ase_color = inputMesh.ase_color;
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord5.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				outputPackedVaryingsMeshToPS.positionCS = UnityMetaVertexPosition(inputMesh.positionOS, inputMesh.uv1.xy, inputMesh.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);


				#ifdef EDITOR_VISUALIZATION
					float2 vizUV = 0;
					float4 lightCoord = 0;
					UnityEditorVizData(inputMesh.positionOS.xyz, inputMesh.uv0.xy, inputMesh.uv1.xy, inputMesh.uv2.xy, vizUV, lightCoord);

					outputPackedVaryingsMeshToPS.VizUV.xy = vizUV;
					outputPackedVaryingsMeshToPS.LightCoord = lightCoord;
				#endif

				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.uv3 = v.uv3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.uv3 = patch[0].uv3 * bary.x + patch[1].uv3 * bary.y + patch[2].uv3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag(PackedVaryingsMeshToPS packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord2.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				float3 lerpResult6223_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode29_g71633).rgb , _MainAlbedoValue);
				half3 Main_Albedo99_g71633 = ( (_MainColor).rgb * lerpResult6223_g71633 );
				float2 appendResult21_g75853 = (float2(packedInput.ase_texcoord3.z , packedInput.ase_texcoord3.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord2.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				float3 lerpResult6225_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode89_g71633).rgb , _SecondAlbedoValue);
				half3 Second_Albedo153_g71633 = ( (_SecondColor).rgb * lerpResult6225_g71633 );
				float3 lerpResult4834_g71633 = lerp( ( Main_Albedo99_g71633 * Second_Albedo153_g71633 * 4.594794 ) , Second_Albedo153_g71633 , _DetailBlendMode);
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord4.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float3 lerpResult235_g71633 = lerp( Main_Albedo99_g71633 , lerpResult4834_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch255_g71633 = lerpResult235_g71633;
				#else
				float3 staticSwitch255_g71633 = Main_Albedo99_g71633;
				#endif
				half3 Blend_Albedo265_g71633 = staticSwitch255_g71633;
				half3 Blend_Albedo_Gradient5769_g71633 = float3(1,1,1);
				half3 Blend_Albedo_Noise5770_g71633 = float3(1,1,1);
				float Mesh_Occlusion318_g71633 = packedInput.ase_color.g;
				float clampResult6091_g71633 = clamp( Mesh_Occlusion318_g71633 , 0.01 , 0.99 );
				float temp_output_7_0_g75800 = _VertexOcclusionMinValue;
				half Occlusion_Mask6432_g71633 = saturate( ( ( clampResult6091_g71633 - temp_output_7_0_g75800 ) / ( ( _VertexOcclusionMaxValue - temp_output_7_0_g75800 ) + 0.01 ) ) );
				float3 lerpResult2945_g71633 = lerp( (_VertexOcclusionColor).rgb , float3( 1,1,1 ) , Occlusion_Mask6432_g71633);
				half3 Occlusion_Color648_g71633 = lerpResult2945_g71633;
				half3 Blend_Albedo_Tinted2808_g71633 = ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 * Occlusion_Color648_g71633 );
				half3 Blend_Albedo_Colored863_g71633 = Blend_Albedo_Tinted2808_g71633;
				half3 Global_OverlayColor1758_g71633 = (TVE_OverlayColor).rgb;
				float temp_output_84_0_g75904 = _LayerExtrasValue;
				float4 temp_output_93_19_g75904 = TVE_ExtrasCoords;
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord4.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				float3 vertexToFrag4224_g71633 = packedInput.ase_texcoord5.xyz;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 lerpResult4827_g71633 = lerp( WorldPosition3905_g71633 , ObjectPosition4223_g71633 , _ExtrasPositionMode);
				half2 UV96_g75904 = ( (temp_output_93_19_g75904).zw + ( (temp_output_93_19_g75904).xy * (lerpResult4827_g71633).xz ) );
				float4 tex2DArrayNode48_g75904 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g75904,temp_output_84_0_g75904, 0.0 );
				float4 temp_output_94_85_g75904 = TVE_ExtrasParams;
				float4 ifLocalVar18_g75908 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] > 0.5 )
				ifLocalVar18_g75908 = tex2DArrayNode48_g75904;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] < 0.5 )
				ifLocalVar18_g75908 = temp_output_94_85_g75904;
				half4 Global_Extras_Params5440_g71633 = ifLocalVar18_g75908;
				float4 break456_g75748 = Global_Extras_Params5440_g71633;
				half Global_Extras_Overlay156_g71633 = break456_g75748.z;
				half Overlay_Variation4560_g71633 = 1.0;
				half Overlay_Value5738_g71633 = ( _GlobalOverlay * Global_Extras_Overlay156_g71633 * Overlay_Variation4560_g71633 );
				float3 vertexToFrag5058_g71633 = packedInput.ase_texcoord6.xyz;
				half3 World_Normal4101_g71633 = vertexToFrag5058_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				float lerpResult5730_g71633 = lerp( (World_Normal4101_g71633).y , packedInput.ase_normal.y , Global_DynamicMode5112_g71633);
				float lerpResult5885_g71633 = lerp( 0.4 , 1.0 , saturate( lerpResult5730_g71633 ));
				half Overlay_Projection6081_g71633 = lerpResult5885_g71633;
				float dotResult6416_g71633 = dot( ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 ) , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Globals6410_g71633 = dotResult6416_g71633;
				half Overlay_Shading6688_g71633 = saturate( ( Blend_Albedo_Globals6410_g71633 * 5.0 ) );
				half Overlay_Custom6707_g71633 = 1.0;
				half Occlusion_Alpha6463_g71633 = _VertexOcclusionColor.a;
				float lerpResult6467_g71633 = lerp( Occlusion_Alpha6463_g71633 , 1.0 , Occlusion_Mask6432_g71633);
				half Occlusion_Overlay6471_g71633 = lerpResult6467_g71633;
				float temp_output_7_0_g75888 = 0.1;
				half Overlay_Mask_High6064_g71633 = saturate( ( ( ( Overlay_Value5738_g71633 * Overlay_Projection6081_g71633 * Overlay_Shading6688_g71633 * Overlay_Custom6707_g71633 * Occlusion_Overlay6471_g71633 ) - temp_output_7_0_g75888 ) / ( ( 0.2 - temp_output_7_0_g75888 ) + 0.01 ) ) );
				half Overlay_Mask269_g71633 = Overlay_Mask_High6064_g71633;
				float3 lerpResult336_g71633 = lerp( Blend_Albedo_Colored863_g71633 , Global_OverlayColor1758_g71633 , Overlay_Mask269_g71633);
				half3 Blend_Albedo_Overlay359_g71633 = lerpResult336_g71633;
				half Global_WetnessContrast6502_g71633 = TVE_WetnessContrast;
				half Global_Extras_Wetness305_g71633 = break456_g75748.y;
				half Wetness_Value6343_g71633 = ( Global_Extras_Wetness305_g71633 * _GlobalWetness );
				float3 lerpResult6367_g71633 = lerp( Blend_Albedo_Overlay359_g71633 , ( Blend_Albedo_Overlay359_g71633 * Blend_Albedo_Overlay359_g71633 ) , ( Global_WetnessContrast6502_g71633 * Wetness_Value6343_g71633 ));
				half3 Blend_Albedo_Wetness6351_g71633 = lerpResult6367_g71633;
				float3 _Vector10 = float3(1,1,1);
				half3 Blend_Albedo_Highlight5771_g71633 = _Vector10;
				float3 temp_output_6309_0_g71633 = ( Blend_Albedo_Wetness6351_g71633 * Blend_Albedo_Highlight5771_g71633 );
				half3 Blend_Albedo_Subsurface149_g71633 = temp_output_6309_0_g71633;
				
				half4 packed34_g75830 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half2 localNormalUnpack34_g75830 = NormalUnpack( packed34_g75830 );
				half2 Main_Normal137_g71633 = ( localNormalUnpack34_g75830 * _MainNormalValue );
				float2 lerpResult3372_g71633 = lerp( float2( 0,0 ) , Main_Normal137_g71633 , _DetailNormalValue);
				half4 packed34_g75832 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half2 localNormalUnpack34_g75832 = NormalUnpack( packed34_g75832 );
				half2 Second_Normal179_g71633 = ( localNormalUnpack34_g75832 * _SecondNormalValue );
				float2 temp_output_36_0_g75857 = ( lerpResult3372_g71633 + Second_Normal179_g71633 );
				float2 lerpResult3376_g71633 = lerp( Main_Normal137_g71633 , temp_output_36_0_g75857 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float2 staticSwitch267_g71633 = lerpResult3376_g71633;
				#else
				float2 staticSwitch267_g71633 = Main_Normal137_g71633;
				#endif
				half2 Blend_Normal312_g71633 = staticSwitch267_g71633;
				half Global_OverlayNormalScale6581_g71633 = TVE_OverlayNormalValue;
				float lerpResult6585_g71633 = lerp( 1.0 , Global_OverlayNormalScale6581_g71633 , Overlay_Mask269_g71633);
				half2 Blend_Normal_Overlay366_g71633 = ( Blend_Normal312_g71633 * lerpResult6585_g71633 );
				half Global_WetnessNormalScale6571_g71633 = TVE_WetnessNormalValue;
				float lerpResult6579_g71633 = lerp( 1.0 , Global_WetnessNormalScale6571_g71633 , ( Wetness_Value6343_g71633 * Wetness_Value6343_g71633 ));
				half2 Blend_Normal_Wetness6372_g71633 = ( Blend_Normal_Overlay366_g71633 * lerpResult6579_g71633 );
				float3 appendResult6568_g71633 = (float3(Blend_Normal_Wetness6372_g71633 , 1.0));
				float3 temp_output_13_0_g75855 = appendResult6568_g71633;
				float3 switchResult12_g75855 = (((isFrontFace>0)?(temp_output_13_0_g75855):(( temp_output_13_0_g75855 * _render_normals ))));
				
				half Render_Specular4861_g71633 = _RenderSpecular;
				float3 temp_cast_5 = (( 0.04 * Render_Specular4861_g71633 )).xxx;
				
				float3 hdEmission4189_g71633 = ASEGetEmissionHDRColor(_EmissiveColor.rgb,_EmissiveIntensityParams.x,_EmissiveExposureValue,GetInverseCurrentExposureMultiplier());
				half2 Emissive_UVs2468_g71633 = ( ( packedInput.ase_texcoord2.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				half Global_Extras_Emissive4203_g71633 = break456_g75748.x;
				float lerpResult4206_g71633 = lerp( 1.0 , Global_Extras_Emissive4203_g71633 , _GlobalEmissive);
				half3 Final_Emissive2476_g71633 = ( (( float4( hdEmission4189_g71633 , 0.0 ) * SAMPLE_TEXTURE2D( _EmissiveTex, sampler_Linear_Repeat, Emissive_UVs2468_g71633 ) )).rgb * lerpResult4206_g71633 );
				
				half Main_Smoothness227_g71633 = ( tex2DNode35_g71633.a * _MainSmoothnessValue );
				half Second_Smoothness236_g71633 = ( tex2DNode33_g71633.a * _SecondSmoothnessValue );
				float lerpResult266_g71633 = lerp( Main_Smoothness227_g71633 , Second_Smoothness236_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch297_g71633 = lerpResult266_g71633;
				#else
				float staticSwitch297_g71633 = Main_Smoothness227_g71633;
				#endif
				half Blend_Smoothness314_g71633 = staticSwitch297_g71633;
				half Global_OverlaySmoothness311_g71633 = TVE_OverlaySmoothness;
				float lerpResult343_g71633 = lerp( Blend_Smoothness314_g71633 , Global_OverlaySmoothness311_g71633 , Overlay_Mask269_g71633);
				half Blend_Smoothness_Overlay371_g71633 = lerpResult343_g71633;
				float temp_output_6499_0_g71633 = ( 1.0 - Wetness_Value6343_g71633 );
				half Blend_Smoothness_Wetness4130_g71633 = saturate( ( Blend_Smoothness_Overlay371_g71633 + ( 1.0 - ( temp_output_6499_0_g71633 * temp_output_6499_0_g71633 ) ) ) );
				
				float lerpResult240_g71633 = lerp( 1.0 , tex2DNode35_g71633.g , _MainOcclusionValue);
				half Main_Occlusion247_g71633 = lerpResult240_g71633;
				float lerpResult239_g71633 = lerp( 1.0 , tex2DNode33_g71633.g , _SecondOcclusionValue);
				half Second_Occlusion251_g71633 = lerpResult239_g71633;
				float lerpResult294_g71633 = lerp( Main_Occlusion247_g71633 , Second_Occlusion251_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch310_g71633 = lerpResult294_g71633;
				#else
				float staticSwitch310_g71633 = Main_Occlusion247_g71633;
				#endif
				half Blend_Occlusion323_g71633 = staticSwitch310_g71633;
				
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = packedInput.ase_texcoord7.xyz;
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.BaseColor = Blend_Albedo_Subsurface149_g71633;
				surfaceDescription.Normal = switchResult12_g75855;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = temp_cast_5;
				#endif

				surfaceDescription.Emission = Final_Emissive2476_g71633;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g71633;
				surfaceDescription.Occlusion = Blend_Occlusion323_g71633;
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);
				LightTransportData lightTransportData = GetLightTransportData(surfaceData, builtinData, bsdfData);

				float4 res = float4( 0.0, 0.0, 0.0, 1.0 );
				UnityMetaInput metaInput;
				metaInput.Albedo = lightTransportData.diffuseColor.rgb;
				metaInput.Emission = lightTransportData.emissiveColor;

			#ifdef EDITOR_VISUALIZATION
				metaInput.VizUV = packedInput.VizUV;
				metaInput.LightCoord = packedInput.LightCoord;
			#endif
				res = UnityMetaFragment(metaInput);

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ZTest LEqual
			ColorMask 0

			HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140005
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			//#define USE_LEGACY_UNITY_MATRIX_VARIABLES

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_SHADOWS

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
			#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			// Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout AlphaSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(AlphaSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				#ifdef _ALPHATEST_SHADOW_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow );
				#else
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord3.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord3.yzw = vertexToFrag3890_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1 = inputMesh.ase_texcoord;
				outputPackedVaryingsMeshToPS.ase_texcoord2 = inputMesh.ase_texcoord1;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				AlphaSurfaceDescription surfaceDescription = (AlphaSurfaceDescription)0;
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord1.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				float2 appendResult21_g75853 = (float2(packedInput.ase_texcoord2.z , packedInput.ase_texcoord2.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord1.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord3.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord3.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
				outputDepth += bias;
				#endif

				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.vmesh.positionCS.z;

				#ifdef _ALPHATOMASK_ON
				depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif
				#endif

				#if defined(WRITE_NORMAL_BUFFER)
				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

				#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				DecalPrepassData decalPrepassData;
				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off

			HLSLPROGRAM

            #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _ENERGY_CONSERVING_SPECULAR 1
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #define _AMBIENT_OCCLUSION 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140005
            #define ASE_USING_SAMPLING_MACROS 1


            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma editor_sync_compilation

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
		    #define SCENESELECTIONPASS 1

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			// Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SceneSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SceneSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord3.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord3.yzw = vertexToFrag3890_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1 = inputMesh.ase_texcoord;
				outputPackedVaryingsMeshToPS.ase_texcoord2 = inputMesh.ase_texcoord1;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						, out float4 outColor : SV_Target0
						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SceneSurfaceDescription surfaceDescription = (SceneSurfaceDescription)0;
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord1.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				float2 appendResult21_g75853 = (float2(packedInput.ase_texcoord2.z , packedInput.ase_texcoord2.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord1.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord3.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord3.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

            #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _ENERGY_CONSERVING_SPECULAR 1
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #define _AMBIENT_OCCLUSION 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140005
            #if !defined(ASE_NEED_CULLFACE)
            #define ASE_NEED_CULLFACE 1
            #endif //ASE_NEED_CULLFACE
            #define ASE_USING_SAMPLING_MACROS 1


            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile _ WRITE_NORMAL_BUFFER
			#pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
			#pragma multi_compile _ WRITE_DECAL_BUFFER

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_DEPTH_ONLY

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			// Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_SecondNormalTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half TVE_OverlayNormalValue;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			half TVE_WetnessNormalValue;
			half TVE_OverlaySmoothness;
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_VFACE
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			
			half2 NormalUnpack( half4 packed )
			{
				    #if defined(UNITY_NO_DXT5nm)
				        half2 unpacked = packed.xyz * 2 - 1;
				        return unpacked;
				    #elif defined(UNITY_ASTC_NORMALMAP_ENCODING)
				        half2 unpacked;
				        unpacked.xy = (packed.wy * 2 - 1);
				        return unpacked;
				    #else
				        // This do the trick
				        packed.x *= packed.w;
				        half2 unpacked;
				        unpacked.xy = (packed.xy * 2 - 1);
				        return unpacked;
				    #endif
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalPrepassBuffer.hlsl"
			#endif
			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord5.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord5.yzw = vertexToFrag3890_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag4224_g71633;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 vertexToFrag5058_g71633 = ase_worldNormal;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = vertexToFrag5058_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord3 = inputMesh.ase_texcoord;
				outputPackedVaryingsMeshToPS.ase_texcoord4 = inputMesh.ase_texcoord1;
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				outputPackedVaryingsMeshToPS.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : SV_Depth
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord3.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				half4 packed34_g75830 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half2 localNormalUnpack34_g75830 = NormalUnpack( packed34_g75830 );
				half2 Main_Normal137_g71633 = ( localNormalUnpack34_g75830 * _MainNormalValue );
				float2 lerpResult3372_g71633 = lerp( float2( 0,0 ) , Main_Normal137_g71633 , _DetailNormalValue);
				float2 appendResult21_g75853 = (float2(packedInput.ase_texcoord4.z , packedInput.ase_texcoord4.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord3.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				half4 packed34_g75832 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half2 localNormalUnpack34_g75832 = NormalUnpack( packed34_g75832 );
				half2 Second_Normal179_g71633 = ( localNormalUnpack34_g75832 * _SecondNormalValue );
				float2 temp_output_36_0_g75857 = ( lerpResult3372_g71633 + Second_Normal179_g71633 );
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord5.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float2 lerpResult3376_g71633 = lerp( Main_Normal137_g71633 , temp_output_36_0_g75857 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float2 staticSwitch267_g71633 = lerpResult3376_g71633;
				#else
				float2 staticSwitch267_g71633 = Main_Normal137_g71633;
				#endif
				half2 Blend_Normal312_g71633 = staticSwitch267_g71633;
				half Global_OverlayNormalScale6581_g71633 = TVE_OverlayNormalValue;
				float temp_output_84_0_g75904 = _LayerExtrasValue;
				float4 temp_output_93_19_g75904 = TVE_ExtrasCoords;
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord5.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				float3 vertexToFrag4224_g71633 = packedInput.ase_texcoord6.xyz;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 lerpResult4827_g71633 = lerp( WorldPosition3905_g71633 , ObjectPosition4223_g71633 , _ExtrasPositionMode);
				half2 UV96_g75904 = ( (temp_output_93_19_g75904).zw + ( (temp_output_93_19_g75904).xy * (lerpResult4827_g71633).xz ) );
				float4 tex2DArrayNode48_g75904 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g75904,temp_output_84_0_g75904, 0.0 );
				float4 temp_output_94_85_g75904 = TVE_ExtrasParams;
				float4 ifLocalVar18_g75908 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] > 0.5 )
				ifLocalVar18_g75908 = tex2DArrayNode48_g75904;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] < 0.5 )
				ifLocalVar18_g75908 = temp_output_94_85_g75904;
				half4 Global_Extras_Params5440_g71633 = ifLocalVar18_g75908;
				float4 break456_g75748 = Global_Extras_Params5440_g71633;
				half Global_Extras_Overlay156_g71633 = break456_g75748.z;
				half Overlay_Variation4560_g71633 = 1.0;
				half Overlay_Value5738_g71633 = ( _GlobalOverlay * Global_Extras_Overlay156_g71633 * Overlay_Variation4560_g71633 );
				float3 vertexToFrag5058_g71633 = packedInput.ase_texcoord7.xyz;
				half3 World_Normal4101_g71633 = vertexToFrag5058_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				float lerpResult5730_g71633 = lerp( (World_Normal4101_g71633).y , packedInput.ase_normal.y , Global_DynamicMode5112_g71633);
				float lerpResult5885_g71633 = lerp( 0.4 , 1.0 , saturate( lerpResult5730_g71633 ));
				half Overlay_Projection6081_g71633 = lerpResult5885_g71633;
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				float3 lerpResult6223_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode29_g71633).rgb , _MainAlbedoValue);
				half3 Main_Albedo99_g71633 = ( (_MainColor).rgb * lerpResult6223_g71633 );
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				float3 lerpResult6225_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode89_g71633).rgb , _SecondAlbedoValue);
				half3 Second_Albedo153_g71633 = ( (_SecondColor).rgb * lerpResult6225_g71633 );
				float3 lerpResult4834_g71633 = lerp( ( Main_Albedo99_g71633 * Second_Albedo153_g71633 * 4.594794 ) , Second_Albedo153_g71633 , _DetailBlendMode);
				float3 lerpResult235_g71633 = lerp( Main_Albedo99_g71633 , lerpResult4834_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch255_g71633 = lerpResult235_g71633;
				#else
				float3 staticSwitch255_g71633 = Main_Albedo99_g71633;
				#endif
				half3 Blend_Albedo265_g71633 = staticSwitch255_g71633;
				half3 Blend_Albedo_Gradient5769_g71633 = float3(1,1,1);
				half3 Blend_Albedo_Noise5770_g71633 = float3(1,1,1);
				float dotResult6416_g71633 = dot( ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 ) , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Globals6410_g71633 = dotResult6416_g71633;
				half Overlay_Shading6688_g71633 = saturate( ( Blend_Albedo_Globals6410_g71633 * 5.0 ) );
				half Overlay_Custom6707_g71633 = 1.0;
				half Occlusion_Alpha6463_g71633 = _VertexOcclusionColor.a;
				float Mesh_Occlusion318_g71633 = packedInput.ase_color.g;
				float clampResult6091_g71633 = clamp( Mesh_Occlusion318_g71633 , 0.01 , 0.99 );
				float temp_output_7_0_g75800 = _VertexOcclusionMinValue;
				half Occlusion_Mask6432_g71633 = saturate( ( ( clampResult6091_g71633 - temp_output_7_0_g75800 ) / ( ( _VertexOcclusionMaxValue - temp_output_7_0_g75800 ) + 0.01 ) ) );
				float lerpResult6467_g71633 = lerp( Occlusion_Alpha6463_g71633 , 1.0 , Occlusion_Mask6432_g71633);
				half Occlusion_Overlay6471_g71633 = lerpResult6467_g71633;
				float temp_output_7_0_g75888 = 0.1;
				half Overlay_Mask_High6064_g71633 = saturate( ( ( ( Overlay_Value5738_g71633 * Overlay_Projection6081_g71633 * Overlay_Shading6688_g71633 * Overlay_Custom6707_g71633 * Occlusion_Overlay6471_g71633 ) - temp_output_7_0_g75888 ) / ( ( 0.2 - temp_output_7_0_g75888 ) + 0.01 ) ) );
				half Overlay_Mask269_g71633 = Overlay_Mask_High6064_g71633;
				float lerpResult6585_g71633 = lerp( 1.0 , Global_OverlayNormalScale6581_g71633 , Overlay_Mask269_g71633);
				half2 Blend_Normal_Overlay366_g71633 = ( Blend_Normal312_g71633 * lerpResult6585_g71633 );
				half Global_WetnessNormalScale6571_g71633 = TVE_WetnessNormalValue;
				half Global_Extras_Wetness305_g71633 = break456_g75748.y;
				half Wetness_Value6343_g71633 = ( Global_Extras_Wetness305_g71633 * _GlobalWetness );
				float lerpResult6579_g71633 = lerp( 1.0 , Global_WetnessNormalScale6571_g71633 , ( Wetness_Value6343_g71633 * Wetness_Value6343_g71633 ));
				half2 Blend_Normal_Wetness6372_g71633 = ( Blend_Normal_Overlay366_g71633 * lerpResult6579_g71633 );
				float3 appendResult6568_g71633 = (float3(Blend_Normal_Wetness6372_g71633 , 1.0));
				float3 temp_output_13_0_g75855 = appendResult6568_g71633;
				float3 switchResult12_g75855 = (((isFrontFace>0)?(temp_output_13_0_g75855):(( temp_output_13_0_g75855 * _render_normals ))));
				
				half Main_Smoothness227_g71633 = ( tex2DNode35_g71633.a * _MainSmoothnessValue );
				half Second_Smoothness236_g71633 = ( tex2DNode33_g71633.a * _SecondSmoothnessValue );
				float lerpResult266_g71633 = lerp( Main_Smoothness227_g71633 , Second_Smoothness236_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch297_g71633 = lerpResult266_g71633;
				#else
				float staticSwitch297_g71633 = Main_Smoothness227_g71633;
				#endif
				half Blend_Smoothness314_g71633 = staticSwitch297_g71633;
				half Global_OverlaySmoothness311_g71633 = TVE_OverlaySmoothness;
				float lerpResult343_g71633 = lerp( Blend_Smoothness314_g71633 , Global_OverlaySmoothness311_g71633 , Overlay_Mask269_g71633);
				half Blend_Smoothness_Overlay371_g71633 = lerpResult343_g71633;
				float temp_output_6499_0_g71633 = ( 1.0 - Wetness_Value6343_g71633 );
				half Blend_Smoothness_Wetness4130_g71633 = saturate( ( Blend_Smoothness_Overlay371_g71633 + ( 1.0 - ( temp_output_6499_0_g71633 * temp_output_6499_0_g71633 ) ) ) );
				
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.Normal = switchResult12_g75855;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g71633;
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_MSAA_DEPTH
					depthColor = packedInput.positionCS.z;
					#ifdef _ALPHATOMASK_ON
						depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
					#endif
				#endif

				#if defined(WRITE_NORMAL_BUFFER)
				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

				#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				DecalPrepassData decalPrepassData;
				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Motion Vectors"
			Tags { "LightMode"="MotionVectors" }

			Cull [_CullMode]

			ZWrite On

			Stencil
			{
				Ref [_StencilRefMV]
				WriteMask [_StencilWriteMaskMV]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			HLSLPROGRAM

            #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _ENERGY_CONSERVING_SPECULAR 1
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #define _AMBIENT_OCCLUSION 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140005
            #define ASE_USING_SAMPLING_MACROS 1


            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile _ WRITE_NORMAL_BUFFER
			#pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
			#pragma multi_compile _ WRITE_DECAL_BUFFER

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_MOTION_VECTORS

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			// Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_SecondNormalTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half TVE_OverlayNormalValue;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			half TVE_WetnessNormalValue;
			half TVE_OverlaySmoothness;
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 vmeshPositionCS : SV_Position;
				float3 vmeshInterp00 : TEXCOORD0;
				float3 vpassInterpolators0 : TEXCOORD1; //interpolators0
				float3 vpassInterpolators1 : TEXCOORD2; //interpolators1
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float3 ase_normal : NORMAL;
				float4 ase_color : COLOR;
				float4 ase_texcoord8 : TEXCOORD8;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			
			half2 NormalUnpack( half4 packed )
			{
				    #if defined(UNITY_NO_DXT5nm)
				        half2 unpacked = packed.xyz * 2 - 1;
				        return unpacked;
				    #elif defined(UNITY_ASTC_NORMALMAP_ENCODING)
				        half2 unpacked;
				        unpacked.xy = (packed.wy * 2 - 1);
				        return unpacked;
				    #else
				        // This do the trick
				        packed.x *= packed.w;
				        half2 unpacked;
				        unpacked.xy = (packed.xy * 2 - 1);
				        return unpacked;
				    #endif
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif

				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord5.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord5.yzw = vertexToFrag3890_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord6.xyz = vertexToFrag4224_g71633;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 vertexToFrag5058_g71633 = ase_worldNormal;
				outputPackedVaryingsMeshToPS.ase_texcoord7.xyz = vertexToFrag5058_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord8.xyz = ase_worldPos;
				
				outputPackedVaryingsMeshToPS.ase_texcoord3 = inputMesh.ase_texcoord;
				outputPackedVaryingsMeshToPS.ase_texcoord4 = inputMesh.ase_texcoord1;
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				outputPackedVaryingsMeshToPS.ase_color = inputMesh.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord6.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord7.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS =  inputMesh.normalOS ;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);

				float3 VMESHpositionRWS = positionRWS;
				float4 VMESHpositionCS = TransformWorldToHClip(positionRWS);

				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(VMESHpositionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						if (_TransparentCameraOnlyMotionVectors > 0)
						{
							previousPositionRWS = VMESHpositionRWS.xyz;
						}
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}

				outputPackedVaryingsMeshToPS.vmeshPositionCS = VMESHpositionCS;
				outputPackedVaryingsMeshToPS.vmeshInterp00.xyz = VMESHpositionRWS;

				outputPackedVaryingsMeshToPS.vpassInterpolators0 = float3(VPASSpositionCS.xyw);
				outputPackedVaryingsMeshToPS.vpassInterpolators1 = float3(VPASSpreviousPositionCS.xyw);
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalPrepassBuffer.hlsl"
			#endif

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float3 previousPositionOS : TEXCOORD4;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					float3 precomputedVelocity : TEXCOORD5;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.previousPositionOS = v.previousPositionOS;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
				o.precomputedVelocity = v.precomputedVelocity;
				#endif
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
				#if defined (_ADD_PRECOMPUTED_VELOCITY)
					o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
				#endif
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_DECAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_NORMAL SV_Target3
			#elif defined(WRITE_DECAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_NORMAL SV_Target2
			#else
			#define SV_TARGET_NORMAL SV_Target1
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
				#ifdef WRITE_MSAA_DEPTH
					, out float4 depthColor : SV_Target0
					, out float4 outMotionVector : SV_Target1
						#ifdef WRITE_DECAL_BUFFER
						, out float4 outDecalBuffer : SV_Target2
						#endif
					#else
					, out float4 outMotionVector : SV_Target0
						#ifdef WRITE_DECAL_BUFFER
						, out float4 outDecalBuffer : SV_Target1
						#endif
					#endif

					#ifdef WRITE_NORMAL_BUFFER
					, out float4 outNormalBuffer : SV_TARGET_NORMAL
					#endif

					#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
					#endif
				, bool ase_vface : SV_IsFrontFace
				)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.vmeshPositionCS;
				input.positionRWS = packedInput.vmeshInterp00.xyz;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SurfaceData surfaceData;
				BuiltinData builtinData;

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord3.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				half4 packed34_g75830 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half2 localNormalUnpack34_g75830 = NormalUnpack( packed34_g75830 );
				half2 Main_Normal137_g71633 = ( localNormalUnpack34_g75830 * _MainNormalValue );
				float2 lerpResult3372_g71633 = lerp( float2( 0,0 ) , Main_Normal137_g71633 , _DetailNormalValue);
				float2 appendResult21_g75853 = (float2(packedInput.ase_texcoord4.z , packedInput.ase_texcoord4.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord3.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				half4 packed34_g75832 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half2 localNormalUnpack34_g75832 = NormalUnpack( packed34_g75832 );
				half2 Second_Normal179_g71633 = ( localNormalUnpack34_g75832 * _SecondNormalValue );
				float2 temp_output_36_0_g75857 = ( lerpResult3372_g71633 + Second_Normal179_g71633 );
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord5.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float2 lerpResult3376_g71633 = lerp( Main_Normal137_g71633 , temp_output_36_0_g75857 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float2 staticSwitch267_g71633 = lerpResult3376_g71633;
				#else
				float2 staticSwitch267_g71633 = Main_Normal137_g71633;
				#endif
				half2 Blend_Normal312_g71633 = staticSwitch267_g71633;
				half Global_OverlayNormalScale6581_g71633 = TVE_OverlayNormalValue;
				float temp_output_84_0_g75904 = _LayerExtrasValue;
				float4 temp_output_93_19_g75904 = TVE_ExtrasCoords;
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord5.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				float3 vertexToFrag4224_g71633 = packedInput.ase_texcoord6.xyz;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 lerpResult4827_g71633 = lerp( WorldPosition3905_g71633 , ObjectPosition4223_g71633 , _ExtrasPositionMode);
				half2 UV96_g75904 = ( (temp_output_93_19_g75904).zw + ( (temp_output_93_19_g75904).xy * (lerpResult4827_g71633).xz ) );
				float4 tex2DArrayNode48_g75904 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g75904,temp_output_84_0_g75904, 0.0 );
				float4 temp_output_94_85_g75904 = TVE_ExtrasParams;
				float4 ifLocalVar18_g75908 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] > 0.5 )
				ifLocalVar18_g75908 = tex2DArrayNode48_g75904;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] < 0.5 )
				ifLocalVar18_g75908 = temp_output_94_85_g75904;
				half4 Global_Extras_Params5440_g71633 = ifLocalVar18_g75908;
				float4 break456_g75748 = Global_Extras_Params5440_g71633;
				half Global_Extras_Overlay156_g71633 = break456_g75748.z;
				half Overlay_Variation4560_g71633 = 1.0;
				half Overlay_Value5738_g71633 = ( _GlobalOverlay * Global_Extras_Overlay156_g71633 * Overlay_Variation4560_g71633 );
				float3 vertexToFrag5058_g71633 = packedInput.ase_texcoord7.xyz;
				half3 World_Normal4101_g71633 = vertexToFrag5058_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				float lerpResult5730_g71633 = lerp( (World_Normal4101_g71633).y , packedInput.ase_normal.y , Global_DynamicMode5112_g71633);
				float lerpResult5885_g71633 = lerp( 0.4 , 1.0 , saturate( lerpResult5730_g71633 ));
				half Overlay_Projection6081_g71633 = lerpResult5885_g71633;
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				float3 lerpResult6223_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode29_g71633).rgb , _MainAlbedoValue);
				half3 Main_Albedo99_g71633 = ( (_MainColor).rgb * lerpResult6223_g71633 );
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				float3 lerpResult6225_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode89_g71633).rgb , _SecondAlbedoValue);
				half3 Second_Albedo153_g71633 = ( (_SecondColor).rgb * lerpResult6225_g71633 );
				float3 lerpResult4834_g71633 = lerp( ( Main_Albedo99_g71633 * Second_Albedo153_g71633 * 4.594794 ) , Second_Albedo153_g71633 , _DetailBlendMode);
				float3 lerpResult235_g71633 = lerp( Main_Albedo99_g71633 , lerpResult4834_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch255_g71633 = lerpResult235_g71633;
				#else
				float3 staticSwitch255_g71633 = Main_Albedo99_g71633;
				#endif
				half3 Blend_Albedo265_g71633 = staticSwitch255_g71633;
				half3 Blend_Albedo_Gradient5769_g71633 = float3(1,1,1);
				half3 Blend_Albedo_Noise5770_g71633 = float3(1,1,1);
				float dotResult6416_g71633 = dot( ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 ) , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Globals6410_g71633 = dotResult6416_g71633;
				half Overlay_Shading6688_g71633 = saturate( ( Blend_Albedo_Globals6410_g71633 * 5.0 ) );
				half Overlay_Custom6707_g71633 = 1.0;
				half Occlusion_Alpha6463_g71633 = _VertexOcclusionColor.a;
				float Mesh_Occlusion318_g71633 = packedInput.ase_color.g;
				float clampResult6091_g71633 = clamp( Mesh_Occlusion318_g71633 , 0.01 , 0.99 );
				float temp_output_7_0_g75800 = _VertexOcclusionMinValue;
				half Occlusion_Mask6432_g71633 = saturate( ( ( clampResult6091_g71633 - temp_output_7_0_g75800 ) / ( ( _VertexOcclusionMaxValue - temp_output_7_0_g75800 ) + 0.01 ) ) );
				float lerpResult6467_g71633 = lerp( Occlusion_Alpha6463_g71633 , 1.0 , Occlusion_Mask6432_g71633);
				half Occlusion_Overlay6471_g71633 = lerpResult6467_g71633;
				float temp_output_7_0_g75888 = 0.1;
				half Overlay_Mask_High6064_g71633 = saturate( ( ( ( Overlay_Value5738_g71633 * Overlay_Projection6081_g71633 * Overlay_Shading6688_g71633 * Overlay_Custom6707_g71633 * Occlusion_Overlay6471_g71633 ) - temp_output_7_0_g75888 ) / ( ( 0.2 - temp_output_7_0_g75888 ) + 0.01 ) ) );
				half Overlay_Mask269_g71633 = Overlay_Mask_High6064_g71633;
				float lerpResult6585_g71633 = lerp( 1.0 , Global_OverlayNormalScale6581_g71633 , Overlay_Mask269_g71633);
				half2 Blend_Normal_Overlay366_g71633 = ( Blend_Normal312_g71633 * lerpResult6585_g71633 );
				half Global_WetnessNormalScale6571_g71633 = TVE_WetnessNormalValue;
				half Global_Extras_Wetness305_g71633 = break456_g75748.y;
				half Wetness_Value6343_g71633 = ( Global_Extras_Wetness305_g71633 * _GlobalWetness );
				float lerpResult6579_g71633 = lerp( 1.0 , Global_WetnessNormalScale6571_g71633 , ( Wetness_Value6343_g71633 * Wetness_Value6343_g71633 ));
				half2 Blend_Normal_Wetness6372_g71633 = ( Blend_Normal_Overlay366_g71633 * lerpResult6579_g71633 );
				float3 appendResult6568_g71633 = (float3(Blend_Normal_Wetness6372_g71633 , 1.0));
				float3 temp_output_13_0_g75855 = appendResult6568_g71633;
				float3 switchResult12_g75855 = (((ase_vface>0)?(temp_output_13_0_g75855):(( temp_output_13_0_g75855 * _render_normals ))));
				
				half Main_Smoothness227_g71633 = ( tex2DNode35_g71633.a * _MainSmoothnessValue );
				half Second_Smoothness236_g71633 = ( tex2DNode33_g71633.a * _SecondSmoothnessValue );
				float lerpResult266_g71633 = lerp( Main_Smoothness227_g71633 , Second_Smoothness236_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch297_g71633 = lerpResult266_g71633;
				#else
				float staticSwitch297_g71633 = Main_Smoothness227_g71633;
				#endif
				half Blend_Smoothness314_g71633 = staticSwitch297_g71633;
				half Global_OverlaySmoothness311_g71633 = TVE_OverlaySmoothness;
				float lerpResult343_g71633 = lerp( Blend_Smoothness314_g71633 , Global_OverlaySmoothness311_g71633 , Overlay_Mask269_g71633);
				half Blend_Smoothness_Overlay371_g71633 = lerpResult343_g71633;
				float temp_output_6499_0_g71633 = ( 1.0 - Wetness_Value6343_g71633 );
				half Blend_Smoothness_Wetness4130_g71633 = saturate( ( Blend_Smoothness_Overlay371_g71633 + ( 1.0 - ( temp_output_6499_0_g71633 * temp_output_6499_0_g71633 ) ) ) );
				
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = packedInput.ase_texcoord8.xyz;
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.Normal = switchResult12_g75855;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g71633;
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );

				float4 VPASSpositionCS = float4(packedInput.vpassInterpolators0.xy, 0.0, packedInput.vpassInterpolators0.z);
				float4 VPASSpreviousPositionCS = float4(packedInput.vpassInterpolators1.xy, 0.0, packedInput.vpassInterpolators1.z);

				#ifdef _DEPTHOFFSET_ON
				VPASSpositionCS.w += builtinData.depthOffset;
				VPASSpreviousPositionCS.w += builtinData.depthOffset;
				#endif

				float2 motionVector = CalculateMotionVector( VPASSpositionCS, VPASSpreviousPositionCS );
				EncodeMotionVector( motionVector * 0.5, outMotionVector );

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if( forceNoMotion )
					outMotionVector = float4( 2.0, 0.0, 0.0, 0.0 );

				// Depth and Alpha to coverage
				#ifdef WRITE_MSAA_DEPTH
					// In case we are rendering in MSAA, reading the an MSAA depth buffer is way too expensive. To avoid that, we export the depth to a color buffer
					depthColor = packedInput.vmeshPositionCS.z;

					// Alpha channel is used for alpha to coverage
					depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif

				// Normal Buffer Processing
				#ifdef WRITE_NORMAL_BUFFER
					EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

				#if defined(WRITE_DECAL_BUFFER)
					DecalPrepassData decalPrepassData;
					#ifdef _DISABLE_DECALS
					ZERO_INITIALIZE(DecalPrepassData, decalPrepassData);
					#else
					decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
					decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
					#endif
					EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);

					// make sure we don't overwrite light layers
					outDecalBuffer.w = (GetMeshRenderingLightLayer() & 0x000000FF) / 255.0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="Forward" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Blend 1 SrcAlpha OneMinusSrcAlpha

			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


            ColorMask [_ColorMaskTransparentVelOne] 1
            ColorMask [_ColorMaskTransparentVelTwo] 2

			HLSLPROGRAM

            #define _MATERIAL_FEATURE_SPECULAR_COLOR 1
            #define _ENERGY_CONSERVING_SPECULAR 1
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #pragma multi_compile _ DOTS_INSTANCING_ON
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define ASE_ABSOLUTE_VERTEX_POS 1
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #define _AMBIENT_OCCLUSION 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140005
            #if !defined(ASE_NEED_CULLFACE)
            #define ASE_NEED_CULLFACE 1
            #endif //ASE_NEED_CULLFACE
            #define ASE_USING_SAMPLING_MACROS 1


            #pragma shader_feature _SURFACE_TYPE_TRANSPARENT
			#pragma shader_feature_local _TRANSPARENT_WRITES_MOTION_VEC
			#pragma shader_feature_local_fragment _ENABLE_FOG_ON_TRANSPARENT
			//#pragma shader_feature_local _DOUBLESIDED_ON
			//#pragma shader_feature_local _ALPHATEST_ON

			#pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
			#pragma multi_compile_fragment SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH
			#pragma multi_compile_fragment AREA_SHADOW_MEDIUM AREA_SHADOW_HIGH
			#pragma multi_compile_fragment PROBE_VOLUMES_OFF PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
            #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST
			#pragma multi_compile _ DEBUG_DISPLAY
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON
			#pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
			#pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT

			#ifndef SHADER_STAGE_FRAGMENT
			#define SHADOW_LOW
			#define USE_FPTL_LIGHTLIST
			#endif

			#pragma vertex Vert
			#pragma fragment Frag

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_FORWARD
		    #define HAS_LIGHTLOOP 1

			// Setup for Fog Enabled to apply in sky refletions in LightLoopDef.hlsl
            #define APPLY_FOG_ON_SKY_REFLECTIONS

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			// Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

			// Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half4 TVE_OverlayColor;
			float TVE_ExtrasUsage[10];
			TEXTURE2D_ARRAY(TVE_ExtrasTex);
			half4 TVE_ExtrasCoords;
			half4 TVE_ExtrasParams;
			half TVE_WetnessContrast;
			TEXTURE2D(_MainNormalTex);
			TEXTURE2D(_SecondNormalTex);
			half TVE_OverlayNormalValue;
			half TVE_WetnessNormalValue;
			TEXTURE2D(_EmissiveTex);
			half TVE_OverlaySmoothness;
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			// Setup DECALS_OFF so the shader stripper can remove variants
            #define HAVE_DECALS ( (defined(DECALS_3RT) || defined(DECALS_4RT)) && !defined(_DISABLE_DECALS) )
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/CommonLighting.hlsl"
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_VFACE
			#define ASE_NEEDS_FRAG_RELATIVE_WORLD_POS
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif

			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 previousPositionOS : TEXCOORD4;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						float3 precomputedVelocity : TEXCOORD5;
					#endif
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_color : COLOR;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			
			half2 NormalUnpack( half4 packed )
			{
				    #if defined(UNITY_NO_DXT5nm)
				        half2 unpacked = packed.xyz * 2 - 1;
				        return unpacked;
				    #elif defined(UNITY_ASTC_NORMALMAP_ENCODING)
				        half2 unpacked;
				        unpacked.xy = (packed.wy * 2 - 1);
				        return unpacked;
				    #else
				        // This do the trick
				        packed.x *= packed.w;
				        half2 unpacked;
				        unpacked.xy = (packed.xy * 2 - 1);
				        return unpacked;
				    #endif
			}
			
			float3 ASEGetEmissionHDRColor(float3 ldrColor, float luminanceIntensity, float exposureWeight, float inverseCurrentExposureMultiplier)
			{
				float3 hdrColor = ldrColor * luminanceIntensity;
				hdrColor = lerp( hdrColor* inverseCurrentExposureMultiplier, hdrColor, exposureWeight);
				return hdrColor;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// surface data
				surfaceData.baseColor =                 surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif
				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif
				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif
				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
				#ifdef _HAS_REFRACTION
				if( _EnableSSRefraction )
				{
					surfaceData.ior = surfaceDescription.RefractionIndex;
					surfaceData.transmittanceColor = surfaceDescription.RefractionColor;
					surfaceData.atDistance = surfaceDescription.RefractionDistance;

					surfaceData.transmittanceMask = ( 1.0 - surfaceDescription.Alpha );
					surfaceDescription.Alpha = 1.0;
				}
				else
				{
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
					surfaceDescription.Alpha = 1.0;
				}
				#else
				surfaceData.ior = 1.0;
				surfaceData.transmittanceColor = float3( 1.0, 1.0, 1.0 );
				surfaceData.atDistance = 1.0;
				surfaceData.transmittanceMask = 0.0;
				#endif


				// material features
				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
				surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				// others
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
				surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif
				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				// normals
				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
				GetNormalWS( fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants );

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
				surfaceData.tangentWS = normalize( fragInputs.tangentToWorld[ 0 ].xyz );

				// decals
				#if HAVE_DECALS
				if( _EnableDecals )
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
				GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.tangentWS = TransformTangentToWorld( surfaceDescription.Tangent, fragInputs.tangentToWorld );
				#endif
				surfaceData.tangentWS = Orthonormalize( surfaceData.tangentWS, surfaceData.normalWS );


                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceData.perceptualSmoothness = GeometricNormalFiltering( surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[ 2 ], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold );
				#endif

				// debug
				#if defined(DEBUG_DISPLAY)
				if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				{
					surfaceData.metallic = 0;
				}
				ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif
			}

			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				ApplyDoubleSidedFlipOrMirror( fragInputs, doubleSidedConstants );

				#ifdef _ALPHATEST_ON
				DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
				ApplyDepthOffsetPositionInput( V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput );
				#endif

				float3 bentNormalWS;
				BuildSurfaceData( fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS );

				InitBuiltinData( posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[ 2 ], fragInputs.texCoord1, fragInputs.texCoord2, builtinData );

				#ifdef _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

				#ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

				#ifdef UNITY_VIRTUAL_TEXTURING
                builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
				builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
				builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

				builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord8.x = vertexToFrag11_g75584;
				outputPackedVaryingsMeshToPS.ase_texcoord8.yzw = vertexToFrag3890_g71633;
				outputPackedVaryingsMeshToPS.ase_texcoord9.xyz = vertexToFrag4224_g71633;
				float3 ase_worldNormal = TransformObjectToWorldNormal(inputMesh.normalOS);
				float3 vertexToFrag5058_g71633 = ase_worldNormal;
				outputPackedVaryingsMeshToPS.ase_texcoord10.xyz = vertexToFrag5058_g71633;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7 = inputMesh.ase_texcoord;
				outputPackedVaryingsMeshToPS.ase_color = inputMesh.ase_color;
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord9.w = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord10.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = Final_VertexPosition890_g71633;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = inputMesh.normalOS;
				inputMesh.tangentOS = inputMesh.tangentOS;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						//ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 previousPositionOS : TEXCOORD4;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						float3 precomputedVelocity : TEXCOORD5;
					#endif
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					o.previousPositionOS = v.previousPositionOS;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						o.precomputedVelocity = v.precomputedVelocity;
					#endif
				#endif
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					o.previousPositionOS = patch[0].previousPositionOS * bary.x + patch[1].previousPositionOS * bary.y + patch[2].previousPositionOS * bary.z;
					#if defined (_ADD_PRECOMPUTED_VELOCITY)
						o.precomputedVelocity = patch[0].precomputedVelocity * bary.x + patch[1].precomputedVelocity * bary.y + patch[2].precomputedVelocity * bary.z;
					#endif
				#endif
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

            #ifdef UNITY_VIRTUAL_TEXTURING
            #ifdef OUTPUT_SPLIT_LIGHTING
            #define DIFFUSE_LIGHTING_TARGET SV_Target2
            #define SSS_BUFFER_TARGET SV_Target3
            #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
            #define MOTION_VECTOR_TARGET SV_Target2
            #endif
            #if defined(SHADER_API_PSSL)

            #pragma PSSL_target_output_format(target 1 FMT_32_ABGR)
            #endif
            #else
            #ifdef OUTPUT_SPLIT_LIGHTING
            #define DIFFUSE_LIGHTING_TARGET SV_Target1
            #define SSS_BUFFER_TARGET SV_Target2
            #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
            #define MOTION_VECTOR_TARGET SV_Target1
            #endif
            #endif

			void Frag(PackedVaryingsMeshToPS packedInput
				, out float4 outColor:SV_Target0
            #ifdef UNITY_VIRTUAL_TEXTURING
				, out float4 outVTFeedback : SV_Target1
            #endif
            #ifdef OUTPUT_SPLIT_LIGHTING
				, out float4 outDiffuseLighting : DIFFUSE_LIGHTING_TARGET
				, OUTPUT_SSSBUFFER(outSSSBuffer) : SSS_BUFFER_TARGET
            #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
				, out float4 outMotionVec : MOTION_VECTOR_TARGET
            #endif

            #ifdef _DEPTHOFFSET_ON
				, out float outputDepth : DEPTH_OFFSET_SEMANTIC
            #endif

		    
						)
			{
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outMotionVec = float4(2.0, 0.0, 0.0, 0.0);
				#endif

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.uv1.xyzw;
				input.texCoord2 = packedInput.uv2.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				input.positionSS.xy = _OffScreenRendering > 0 ? (uint2)round(input.positionSS.xy * _OffScreenDownsampleFactor) : input.positionSS.xy;
				uint2 tileIndex = uint2(input.positionSS.xy) / GetTileSize ();

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz, tileIndex );

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord7.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				float3 lerpResult6223_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode29_g71633).rgb , _MainAlbedoValue);
				half3 Main_Albedo99_g71633 = ( (_MainColor).rgb * lerpResult6223_g71633 );
				float2 appendResult21_g75853 = (float2(packedInput.uv1.z , packedInput.uv1.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord7.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				float3 lerpResult6225_g71633 = lerp( float3( 1,1,1 ) , (tex2DNode89_g71633).rgb , _SecondAlbedoValue);
				half3 Second_Albedo153_g71633 = ( (_SecondColor).rgb * lerpResult6225_g71633 );
				float3 lerpResult4834_g71633 = lerp( ( Main_Albedo99_g71633 * Second_Albedo153_g71633 * 4.594794 ) , Second_Albedo153_g71633 , _DetailBlendMode);
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord8.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float3 lerpResult235_g71633 = lerp( Main_Albedo99_g71633 , lerpResult4834_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float3 staticSwitch255_g71633 = lerpResult235_g71633;
				#else
				float3 staticSwitch255_g71633 = Main_Albedo99_g71633;
				#endif
				half3 Blend_Albedo265_g71633 = staticSwitch255_g71633;
				half3 Blend_Albedo_Gradient5769_g71633 = float3(1,1,1);
				half3 Blend_Albedo_Noise5770_g71633 = float3(1,1,1);
				float Mesh_Occlusion318_g71633 = packedInput.ase_color.g;
				float clampResult6091_g71633 = clamp( Mesh_Occlusion318_g71633 , 0.01 , 0.99 );
				float temp_output_7_0_g75800 = _VertexOcclusionMinValue;
				half Occlusion_Mask6432_g71633 = saturate( ( ( clampResult6091_g71633 - temp_output_7_0_g75800 ) / ( ( _VertexOcclusionMaxValue - temp_output_7_0_g75800 ) + 0.01 ) ) );
				float3 lerpResult2945_g71633 = lerp( (_VertexOcclusionColor).rgb , float3( 1,1,1 ) , Occlusion_Mask6432_g71633);
				half3 Occlusion_Color648_g71633 = lerpResult2945_g71633;
				half3 Blend_Albedo_Tinted2808_g71633 = ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 * Occlusion_Color648_g71633 );
				half3 Blend_Albedo_Colored863_g71633 = Blend_Albedo_Tinted2808_g71633;
				half3 Global_OverlayColor1758_g71633 = (TVE_OverlayColor).rgb;
				float temp_output_84_0_g75904 = _LayerExtrasValue;
				float4 temp_output_93_19_g75904 = TVE_ExtrasCoords;
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord8.yzw;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				float3 vertexToFrag4224_g71633 = packedInput.ase_texcoord9.xyz;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 lerpResult4827_g71633 = lerp( WorldPosition3905_g71633 , ObjectPosition4223_g71633 , _ExtrasPositionMode);
				half2 UV96_g75904 = ( (temp_output_93_19_g75904).zw + ( (temp_output_93_19_g75904).xy * (lerpResult4827_g71633).xz ) );
				float4 tex2DArrayNode48_g75904 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, UV96_g75904,temp_output_84_0_g75904, 0.0 );
				float4 temp_output_94_85_g75904 = TVE_ExtrasParams;
				float4 ifLocalVar18_g75908 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] > 0.5 )
				ifLocalVar18_g75908 = tex2DArrayNode48_g75904;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g75904] < 0.5 )
				ifLocalVar18_g75908 = temp_output_94_85_g75904;
				half4 Global_Extras_Params5440_g71633 = ifLocalVar18_g75908;
				float4 break456_g75748 = Global_Extras_Params5440_g71633;
				half Global_Extras_Overlay156_g71633 = break456_g75748.z;
				half Overlay_Variation4560_g71633 = 1.0;
				half Overlay_Value5738_g71633 = ( _GlobalOverlay * Global_Extras_Overlay156_g71633 * Overlay_Variation4560_g71633 );
				float3 vertexToFrag5058_g71633 = packedInput.ase_texcoord10.xyz;
				half3 World_Normal4101_g71633 = vertexToFrag5058_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				float lerpResult5730_g71633 = lerp( (World_Normal4101_g71633).y , packedInput.ase_normal.y , Global_DynamicMode5112_g71633);
				float lerpResult5885_g71633 = lerp( 0.4 , 1.0 , saturate( lerpResult5730_g71633 ));
				half Overlay_Projection6081_g71633 = lerpResult5885_g71633;
				float dotResult6416_g71633 = dot( ( Blend_Albedo265_g71633 * Blend_Albedo_Gradient5769_g71633 * Blend_Albedo_Noise5770_g71633 ) , float3(0.2126,0.7152,0.0722) );
				half Blend_Albedo_Globals6410_g71633 = dotResult6416_g71633;
				half Overlay_Shading6688_g71633 = saturate( ( Blend_Albedo_Globals6410_g71633 * 5.0 ) );
				half Overlay_Custom6707_g71633 = 1.0;
				half Occlusion_Alpha6463_g71633 = _VertexOcclusionColor.a;
				float lerpResult6467_g71633 = lerp( Occlusion_Alpha6463_g71633 , 1.0 , Occlusion_Mask6432_g71633);
				half Occlusion_Overlay6471_g71633 = lerpResult6467_g71633;
				float temp_output_7_0_g75888 = 0.1;
				half Overlay_Mask_High6064_g71633 = saturate( ( ( ( Overlay_Value5738_g71633 * Overlay_Projection6081_g71633 * Overlay_Shading6688_g71633 * Overlay_Custom6707_g71633 * Occlusion_Overlay6471_g71633 ) - temp_output_7_0_g75888 ) / ( ( 0.2 - temp_output_7_0_g75888 ) + 0.01 ) ) );
				half Overlay_Mask269_g71633 = Overlay_Mask_High6064_g71633;
				float3 lerpResult336_g71633 = lerp( Blend_Albedo_Colored863_g71633 , Global_OverlayColor1758_g71633 , Overlay_Mask269_g71633);
				half3 Blend_Albedo_Overlay359_g71633 = lerpResult336_g71633;
				half Global_WetnessContrast6502_g71633 = TVE_WetnessContrast;
				half Global_Extras_Wetness305_g71633 = break456_g75748.y;
				half Wetness_Value6343_g71633 = ( Global_Extras_Wetness305_g71633 * _GlobalWetness );
				float3 lerpResult6367_g71633 = lerp( Blend_Albedo_Overlay359_g71633 , ( Blend_Albedo_Overlay359_g71633 * Blend_Albedo_Overlay359_g71633 ) , ( Global_WetnessContrast6502_g71633 * Wetness_Value6343_g71633 ));
				half3 Blend_Albedo_Wetness6351_g71633 = lerpResult6367_g71633;
				float3 _Vector10 = float3(1,1,1);
				half3 Blend_Albedo_Highlight5771_g71633 = _Vector10;
				float3 temp_output_6309_0_g71633 = ( Blend_Albedo_Wetness6351_g71633 * Blend_Albedo_Highlight5771_g71633 );
				half3 Blend_Albedo_Subsurface149_g71633 = temp_output_6309_0_g71633;
				
				half4 packed34_g75830 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half2 localNormalUnpack34_g75830 = NormalUnpack( packed34_g75830 );
				half2 Main_Normal137_g71633 = ( localNormalUnpack34_g75830 * _MainNormalValue );
				float2 lerpResult3372_g71633 = lerp( float2( 0,0 ) , Main_Normal137_g71633 , _DetailNormalValue);
				half4 packed34_g75832 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half2 localNormalUnpack34_g75832 = NormalUnpack( packed34_g75832 );
				half2 Second_Normal179_g71633 = ( localNormalUnpack34_g75832 * _SecondNormalValue );
				float2 temp_output_36_0_g75857 = ( lerpResult3372_g71633 + Second_Normal179_g71633 );
				float2 lerpResult3376_g71633 = lerp( Main_Normal137_g71633 , temp_output_36_0_g75857 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float2 staticSwitch267_g71633 = lerpResult3376_g71633;
				#else
				float2 staticSwitch267_g71633 = Main_Normal137_g71633;
				#endif
				half2 Blend_Normal312_g71633 = staticSwitch267_g71633;
				half Global_OverlayNormalScale6581_g71633 = TVE_OverlayNormalValue;
				float lerpResult6585_g71633 = lerp( 1.0 , Global_OverlayNormalScale6581_g71633 , Overlay_Mask269_g71633);
				half2 Blend_Normal_Overlay366_g71633 = ( Blend_Normal312_g71633 * lerpResult6585_g71633 );
				half Global_WetnessNormalScale6571_g71633 = TVE_WetnessNormalValue;
				float lerpResult6579_g71633 = lerp( 1.0 , Global_WetnessNormalScale6571_g71633 , ( Wetness_Value6343_g71633 * Wetness_Value6343_g71633 ));
				half2 Blend_Normal_Wetness6372_g71633 = ( Blend_Normal_Overlay366_g71633 * lerpResult6579_g71633 );
				float3 appendResult6568_g71633 = (float3(Blend_Normal_Wetness6372_g71633 , 1.0));
				float3 temp_output_13_0_g75855 = appendResult6568_g71633;
				float3 switchResult12_g75855 = (((isFrontFace>0)?(temp_output_13_0_g75855):(( temp_output_13_0_g75855 * _render_normals ))));
				
				half Render_Specular4861_g71633 = _RenderSpecular;
				float3 temp_cast_5 = (( 0.04 * Render_Specular4861_g71633 )).xxx;
				
				float3 hdEmission4189_g71633 = ASEGetEmissionHDRColor(_EmissiveColor.rgb,_EmissiveIntensityParams.x,_EmissiveExposureValue,GetInverseCurrentExposureMultiplier());
				half2 Emissive_UVs2468_g71633 = ( ( packedInput.ase_texcoord7.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				half Global_Extras_Emissive4203_g71633 = break456_g75748.x;
				float lerpResult4206_g71633 = lerp( 1.0 , Global_Extras_Emissive4203_g71633 , _GlobalEmissive);
				half3 Final_Emissive2476_g71633 = ( (( float4( hdEmission4189_g71633 , 0.0 ) * SAMPLE_TEXTURE2D( _EmissiveTex, sampler_Linear_Repeat, Emissive_UVs2468_g71633 ) )).rgb * lerpResult4206_g71633 );
				
				half Main_Smoothness227_g71633 = ( tex2DNode35_g71633.a * _MainSmoothnessValue );
				half Second_Smoothness236_g71633 = ( tex2DNode33_g71633.a * _SecondSmoothnessValue );
				float lerpResult266_g71633 = lerp( Main_Smoothness227_g71633 , Second_Smoothness236_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch297_g71633 = lerpResult266_g71633;
				#else
				float staticSwitch297_g71633 = Main_Smoothness227_g71633;
				#endif
				half Blend_Smoothness314_g71633 = staticSwitch297_g71633;
				half Global_OverlaySmoothness311_g71633 = TVE_OverlaySmoothness;
				float lerpResult343_g71633 = lerp( Blend_Smoothness314_g71633 , Global_OverlaySmoothness311_g71633 , Overlay_Mask269_g71633);
				half Blend_Smoothness_Overlay371_g71633 = lerpResult343_g71633;
				float temp_output_6499_0_g71633 = ( 1.0 - Wetness_Value6343_g71633 );
				half Blend_Smoothness_Wetness4130_g71633 = saturate( ( Blend_Smoothness_Overlay371_g71633 + ( 1.0 - ( temp_output_6499_0_g71633 * temp_output_6499_0_g71633 ) ) ) );
				
				float lerpResult240_g71633 = lerp( 1.0 , tex2DNode35_g71633.g , _MainOcclusionValue);
				half Main_Occlusion247_g71633 = lerpResult240_g71633;
				float lerpResult239_g71633 = lerp( 1.0 , tex2DNode33_g71633.g , _SecondOcclusionValue);
				half Second_Occlusion251_g71633 = lerpResult239_g71633;
				float lerpResult294_g71633 = lerp( Main_Occlusion247_g71633 , Second_Occlusion251_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch310_g71633 = lerpResult294_g71633;
				#else
				float staticSwitch310_g71633 = Main_Occlusion247_g71633;
				#endif
				half Blend_Occlusion323_g71633 = staticSwitch310_g71633;
				
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = GetAbsolutePositionWS( positionRWS );
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.BaseColor = Blend_Albedo_Subsurface149_g71633;
				surfaceDescription.Normal = switchResult12_g75855;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = temp_cast_5;
				#endif

				surfaceDescription.Emission = Final_Emissive2476_g71633;
				surfaceDescription.Smoothness = Blend_Smoothness_Wetness4130_g71633;
				surfaceDescription.Occlusion = Blend_Occlusion323_g71633;
				surfaceDescription.Alpha = Final_Alpha914_g71633;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = 1;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = 0;
				#endif
				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = 0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

				PreLightData preLightData = GetPreLightData(V, posInput, bsdfData);

				outColor = float4(0.0, 0.0, 0.0, 0.0);

            #ifdef DEBUG_DISPLAY
            #ifdef OUTPUT_SPLIT_LIGHTING
				outDiffuseLighting = float4(0, 0, 0, 1);
				ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
                #endif

				bool viewMaterial = false;
				int bufferSize = _DebugViewMaterialArray[0].x;
				if (bufferSize != 0)
				{
					bool needLinearToSRGB = false;
					float3 result = float3(1.0, 0.0, 1.0);

					for (int index = 1; index <= bufferSize; index++)
					{
						int indexMaterialProperty = _DebugViewMaterialArray[index].x;

						if (indexMaterialProperty != 0)
						{
							viewMaterial = true;

							GetPropertiesDataDebug(indexMaterialProperty, result, needLinearToSRGB);
							GetVaryingsDataDebug(indexMaterialProperty, input, result, needLinearToSRGB);
							GetBuiltinDataDebug(indexMaterialProperty, builtinData, posInput, result, needLinearToSRGB);
							GetSurfaceDataDebug(indexMaterialProperty, surfaceData, result, needLinearToSRGB);
							GetBSDFDataDebug(indexMaterialProperty, bsdfData, result, needLinearToSRGB);
						}
					}

					if (!needLinearToSRGB && _DebugAOVOutput == 0)
						result = SRGBToLinear(max(0, result));

					outColor = float4(result, 1.0);
				}

				if (!viewMaterial)
				{
					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_DIFFUSE_COLOR || _DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_SPECULAR_COLOR)
					{
						float3 result = float3(0.0, 0.0, 0.0);
						GetPBRValidatorDebug(surfaceData, result);
						outColor = float4(result, 1.0f);
					}
					else if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
					else
                #endif
					{
                #ifdef _SURFACE_TYPE_TRANSPARENT
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_TRANSPARENT;
                #else
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_OPAQUE;
                #endif
						LightLoopOutput lightLoopOutput;
						LightLoop(V, posInput, preLightData, bsdfData, builtinData, featureFlags, lightLoopOutput);

						// Alias
						float3 diffuseLighting = lightLoopOutput.diffuseLighting;
						float3 specularLighting = lightLoopOutput.specularLighting;

						diffuseLighting *= GetCurrentExposureMultiplier();
						specularLighting *= GetCurrentExposureMultiplier();

                #ifdef OUTPUT_SPLIT_LIGHTING
						if (_EnableSubsurfaceScattering != 0 && ShouldOutputSplitLighting(bsdfData))
						{
							outColor = float4(specularLighting, 1.0);
							outDiffuseLighting = float4(TagLightingForSSS(diffuseLighting), 1.0);
						}
						else
						{
							outColor = float4(diffuseLighting + specularLighting, 1.0);
							outDiffuseLighting = float4(0, 0, 0, 1);
						}
						ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
                #else
						outColor = ApplyBlendMode(diffuseLighting, specularLighting, builtinData.opacity);
						outColor = EvaluateAtmosphericScattering(posInput, V, outColor);
                #endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						float4 VPASSpositionCS = float4(packedInput.vpassPositionCS.xy, 0.0, packedInput.vpassPositionCS.z);
						float4 VPASSpreviousPositionCS = float4(packedInput.vpassPreviousPositionCS.xy, 0.0, packedInput.vpassPreviousPositionCS.z);

						bool forceNoMotion = any(unity_MotionVectorsParams.yw == 0.0);
						if (!forceNoMotion)
						{
							float2 motionVec = CalculateMotionVector(VPASSpositionCS, VPASSpreviousPositionCS);
							EncodeMotionVector(motionVec * 0.5, outMotionVec);
							outMotionVec.zw = 1.0;
						}
				#endif
				}

				#ifdef DEBUG_DISPLAY
				}
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
					outVTFeedback = builtinData.vtPackedFeedback;
				#endif

                #ifdef UNITY_VIRTUAL_TEXTURING
				    float vtAlphaValue = builtinData.opacity;
                    #if defined(HAS_REFRACTION) && HAS_REFRACTION
					vtAlphaValue = 1.0f - bsdfData.transmittanceMask;
                #endif
				outVTFeedback = PackVTFeedbackWithAlpha(builtinData.vtPackedFeedback, input.positionSS.xy, vtAlphaValue);
                #endif
			}
			ENDHLSL
		}

		
		Pass
        {
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }

            Cull [_CullMode]

            HLSLPROGRAM

			#define _MATERIAL_FEATURE_SPECULAR_COLOR 1
			#define _ENERGY_CONSERVING_SPECULAR 1
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#pragma multi_compile _ DOTS_INSTANCING_ON
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define ASE_ABSOLUTE_VERTEX_POS 1
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#define _AMBIENT_OCCLUSION 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140005
			#define ASE_USING_SAMPLING_MACROS 1


			#pragma editor_sync_compilation

			#pragma vertex Vert
			#pragma fragment Frag

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_TANGENT_TO_WORLD

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENEPICKINGPASS 1

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
		    #define VARYINGS_NEED_CULLFACE
			#endif
			#endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
			#define WRITE_NORMAL_BUFFER
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

			float4 _SelectionID;
            CBUFFER_START( UnityPerMaterial )
			float4 _EmissiveIntensityParams;
			float4 _NoiseMaskRemap;
			half4 _DetailBlendRemap;
			float4 _Color;
			half4 _EmissiveColor;
			half4 _VertexOcclusionColor;
			half4 _MainColor;
			float4 _GradientMaskRemap;
			half4 _EmissiveUVs;
			half4 _SecondUVs;
			float4 _SubsurfaceDiffusion_Asset;
			half4 _SecondMaskRemap;
			half4 _MainMaskRemap;
			half4 _SecondColor;
			half4 _MainUVs;
			float4 _MaxBoundsInfo;
			half4 _VertexOcclusionRemap;
			half3 _render_normals;
			half _MotionFacingValue;
			half _render_zw;
			half _MotionAmplitude_22;
			half _MotionAmplitude_20;
			half _MotionValue_20;
			half _InteractionMaskValue;
			half _MotionVariation_20;
			half _MotionScale_20;
			half _InteractionAmplitude;
			half _MotionAmplitude_10;
			half _LayerMotionValue;
			half _MotionObjectVariation;
			half _VertexDynamicMode;
			half _VertexPivotMode;
			half _MotionVariation_10;
			float _MotionSpeed_10;
			float _MotionScale_10;
			half _MessageGlobalsVariation;
			half _MessageMotionVariation;
			half _MessageSecondMask;
			half _MotionSpeed_20;
			half _VertexDataMode;
			half _DetailCoordMode;
			half _GlobalSize;
			half _FadeConstantValue;
			half _FadeCameraValue;
			half _SecondOcclusionValue;
			half _MainOcclusionValue;
			half _SecondSmoothnessValue;
			half _MainSmoothnessValue;
			half _GlobalEmissive;
			half _EmissiveExposureValue;
			half _RenderSpecular;
			half _SecondNormalValue;
			half _DetailNormalValue;
			half _MainNormalValue;
			half _LayerVertexValue;
			half _GlobalWetness;
			half _LayerExtrasValue;
			half _GlobalOverlay;
			half _VertexOcclusionMaxValue;
			half _VertexOcclusionMinValue;
			half _DetailMode;
			half _DetailBlendMaxValue;
			half _DetailBlendMinValue;
			half _DetailMaskInvertMode;
			half _DetailMaskMode;
			half _SecondAlbedoValue;
			half _MessageMainMask;
			half _MainAlbedoValue;
			half _ExtrasPositionMode;
			half _MessageSubsurface;
			half _SubsurfaceAmbientValue;
			half _SubsurfaceScatteringValue;
			half _CategoryGlobals;
			half _CategoryRender;
			half _RenderMode;
			half _SpaceRenderFade;
			half _SpaceGlobalLayers;
			half _ColorsMaskMaxValue;
			half _ColorsMaskMinValue;
			half _SubsurfaceMaskMaxValue;
			half _SubsurfaceMaskMinValue;
			half _RenderPriority;
			half _RenderQueue;
			half _EmissiveFlagMode;
			half _Cutoff;
			half _RenderCull;
			half _RenderCoverage;
			half _RenderShadow;
			half _RenderAmbient;
			half _RenderClip;
			half _RenderZWrite;
			half _RenderDirect;
			half _RenderSSR;
			half _RenderDecals;
			half _render_dst;
			half _render_src;
			half _IsStandardShader;
			half _IsBarkShader;
			half _render_cull;
			half _CategoryMain;
			half _SpaceGlobalLocals;
			half _DetailBlendMode;
			half _CategoryDetail;
			half _SubsurfaceAngleValue;
			half _SubsurfaceDirectValue;
			half _AlphaClipValue;
			half _SubsurfaceShadowValue;
			half _SubsurfaceNormalValue;
			float _SubsurfaceDiffusion;
			half _RenderNormals;
			half _IsVersion;
			half _IsShared;
			half _IsCollected;
			half _VertexVariationMode;
			half _HasEmissive;
			half _HasGradient;
			half _MessageOcclusion;
			half _HasOcclusion;
			half _IsTVEShader;
			half _SpaceSubsurface;
			half _SpaceMotionGlobals;
			half _SpaceMotionLocals;
			half _SpaceGlobalExtras;
			half _CategoryMotion;
			half _CategorySizeFade;
			half _CategoryPerspective;
			half _CategoryEmissive;
			half _CategorySubsurface;
			half _CategoryNoise;
			half _CategoryGradient;
			half _CategoryOcclusion;
			half _IsIdentifier;
			half _DetailOpaqueMode;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			float _TessPhongStrength;
			float _TessValue;
			float _TessMin;
			float _TessMax;
			float _TessEdgeLength;
			float _TessMaxDisp;
			#endif
			CBUFFER_END

			TEXTURE2D(_MainTex);
			SAMPLER(sampler_MainTex);
			TEXTURE2D(_BumpMap);
			SAMPLER(sampler_BumpMap);
			half TVE_Enabled;
			TEXTURE2D(TVE_NoiseTex);
			half4 TVE_NoiseParams;
			half4 TVE_MotionParams;
			SAMPLER(sampler_Linear_Repeat);
			float TVE_MotionUsage[10];
			TEXTURE2D_ARRAY(TVE_MotionTex);
			half4 TVE_MotionCoords;
			SAMPLER(sampler_Linear_Clamp);
			float TVE_VertexUsage[10];
			TEXTURE2D_ARRAY(TVE_VertexTex);
			half4 TVE_VertexCoords;
			half4 TVE_VertexParams;
			half _DisableSRPBatcher;
			TEXTURE2D(_MainAlbedoTex);
			SAMPLER(sampler_MainAlbedoTex);
			TEXTURE2D(_SecondAlbedoTex);
			SAMPLER(sampler_SecondAlbedoTex);
			TEXTURE2D(_MainMaskTex);
			TEXTURE2D(_SecondMaskTex);
			half TVE_CameraFadeMin;
			half TVE_CameraFadeMax;
			TEXTURE3D(TVE_NoiseTex3D);
			half TVE_NoiseTex3DTilling;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#pragma shader_feature_local TVE_FEATURE_CLIP
			#pragma shader_feature_local TVE_FEATURE_BATCHING
			#pragma shader_feature_local TVE_FEATURE_DETAIL
			//TVE Shader Type Defines
			#define TVE_IS_VEGETATION_SHADER
			//TVE Pipeline Defines
			#define THE_VEGETATION_ENGINE
			#define TVE_IS_HD_PIPELINE
			//TVE HD Pipeline Defines
			#pragma shader_feature_local _DISABLE_DECALS
			#pragma shader_feature_local _DISABLE_SSR
			//TVE Injection Defines
			//SHADER INJECTION POINT BEGIN
			//SHADER INJECTION POINT END


			struct VertexInput
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 positionCS : SV_POSITION;
				float3 normalWS : TEXCOORD0;
				float4 tangentWS : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			float3 ObjectPosition_UNITY_MATRIX_M(  )
			{
				return float3(UNITY_MATRIX_M[0].w, UNITY_MATRIX_M[1].w, UNITY_MATRIX_M[2].w );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

            struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};
			struct SurfaceDescriptionInputs
			{
				float3 ObjectSpaceNormal;
				float3 WorldSpaceNormal;
				float3 TangentSpaceNormal;
				float3 ObjectSpaceViewDirection;
				float3 WorldSpaceViewDirection;
				float3 ObjectSpacePosition;
			};


            void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {

                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE
				LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif

                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
				float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
				ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
                #endif

                #ifdef _ALPHATEST_ON
				float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
				alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                #endif
				GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif

                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
				ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif

                #ifdef FRAG_INPUTS_USE_TEXCOORD1
				float4 lightmapTexCoord1 = fragInputs.texCoord1;
                #else
				float4 lightmapTexCoord1 = float4(0, 0, 0, 0);
                #endif

                #ifdef FRAG_INPUTS_USE_TEXCOORD2
				float4 lightmapTexCoord2 = fragInputs.texCoord2;
                #else
				float4 lightmapTexCoord2 = float4(0, 0, 0, 0);
                #endif

				//InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], lightmapTexCoord1, lightmapTexCoord2, builtinData);

                //#else
                //BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);

                ZERO_INITIALIZE(SurfaceData, surfaceData);

                ZERO_BUILTIN_INITIALIZE(builtinData);
                builtinData.opacity = surfaceDescription.Alpha;

                #if defined(DEBUG_DISPLAY)
				builtinData.renderingLayers = GetMeshRenderingLightLayer();
                #endif

                #ifdef _ALPHATEST_ON
				builtinData.alphaClipTreshold = alphaCutoff;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                #endif

                #if _DEPTHOFFSET_ON
				builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif

                #if (SHADERPASS == SHADERPASS_DISTORTION)
				builtinData.distortion = surfaceDescription.Distortion;
				builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif

                #ifndef SHADER_UNLIT
				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
				ApplyDebugToBuiltinData(builtinData);
                #endif

				RAY_TRACING_OPTIONAL_ALPHA_TEST_PASS

            }


			VertexOutput VertexFunction(VertexInput inputMesh  )
			{

				VertexOutput o;
				ZERO_INITIALIZE(VertexOutput, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, o );

				float3 VertexPosition3588_g71633 = inputMesh.positionOS;
				half3 Mesh_PivotsOS2291_g71633 = half3(0,0,0);
				float3 temp_output_2283_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				half3 VertexPos40_g74554 = temp_output_2283_0_g71633;
				float3 appendResult74_g74554 = (float3(VertexPos40_g74554.x , 0.0 , 0.0));
				half3 VertexPosRotationAxis50_g74554 = appendResult74_g74554;
				float3 break84_g74554 = VertexPos40_g74554;
				float3 appendResult81_g74554 = (float3(0.0 , break84_g74554.y , break84_g74554.z));
				half3 VertexPosOtherAxis82_g74554 = appendResult81_g74554;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 vertexToFrag3890_g71633 = ase_worldPos;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half3 Input_Position419_g75769 = WorldPosition3905_g71633;
				float Input_MotionScale287_g75769 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g75769 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g75769 = (( Input_Position419_g75769 * Input_MotionScale287_g75769 * Global_NoiseScale448_g75769 * 0.0075 )).xz;
				float2 temp_output_447_0_g75525 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Global_Wind_DirectionWS4683_g71633 = temp_output_447_0_g75525;
				half2 Input_DirectionWS423_g75769 = Global_Wind_DirectionWS4683_g71633;
				half Input_MotionSpeed62_g75769 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g75769 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g75769 = _MotionVariation_10;
				float3 localObjectPosition_UNITY_MATRIX_M14_g74703 = ObjectPosition_UNITY_MATRIX_M();
				float3 appendResult60_g74709 = (float3(inputMesh.ase_texcoord3.x , inputMesh.ase_texcoord3.z , inputMesh.ase_texcoord3.y));
				half3 Mesh_PivotsData2831_g71633 = ( appendResult60_g74709 * _VertexPivotMode );
				float3 temp_output_122_0_g74703 = Mesh_PivotsData2831_g71633;
				float3 PivotsOnly105_g74703 = (mul( GetObjectToWorldMatrix(), float4( temp_output_122_0_g74703 , 0.0 ) ).xyz).xyz;
				#ifdef SHADEROPTIONS_CAMERA_RELATIVE_RENDERING
				float3 staticSwitch13_g74703 = ( ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 ) + _WorldSpaceCameraPos );
				#else
				float3 staticSwitch13_g74703 = ( localObjectPosition_UNITY_MATRIX_M14_g74703 + PivotsOnly105_g74703 );
				#endif
				half3 ObjectData20_g74704 = staticSwitch13_g74703;
				half3 WorldData19_g74704 = ase_worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74704 = WorldData19_g74704;
				#else
				float3 staticSwitch14_g74704 = ObjectData20_g74704;
				#endif
				float3 temp_output_114_0_g74703 = staticSwitch14_g74704;
				float3 vertexToFrag4224_g71633 = temp_output_114_0_g74703;
				half3 ObjectData20_g74630 = vertexToFrag4224_g71633;
				half3 WorldData19_g74630 = vertexToFrag3890_g71633;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74630 = WorldData19_g74630;
				#else
				float3 staticSwitch14_g74630 = ObjectData20_g74630;
				#endif
				float3 ObjectPosition4223_g71633 = staticSwitch14_g74630;
				float3 break111_g75859 = ObjectPosition4223_g71633;
				half Global_DynamicMode5112_g71633 = _VertexDynamicMode;
				half Input_DynamicMode120_g75859 = Global_DynamicMode5112_g71633;
				float Postion_Sum142_g75859 = ( ( break111_g75859.x + break111_g75859.y + break111_g75859.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g75859 ) );
				float Mesh_Variation16_g71633 = inputMesh.ase_color.r;
				half Input_Variation124_g75859 = Mesh_Variation16_g71633;
				half ObjectData20_g75861 = ( Postion_Sum142_g75859 + Input_Variation124_g75859 );
				half WorldData19_g75861 = Input_Variation124_g75859;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75861 = WorldData19_g75861;
				#else
				float staticSwitch14_g75861 = ObjectData20_g75861;
				#endif
				float clampResult129_g75859 = clamp( frac( staticSwitch14_g75861 ) , 0.01 , 0.99 );
				float Global_MeshVariation5104_g71633 = clampResult129_g75859;
				half Input_GlobalMeshVariation569_g75769 = Global_MeshVariation5104_g71633;
				half Input_ObjectVariation694_g75769 = _MotionObjectVariation;
				half ObjectData20_g75862 = Postion_Sum142_g75859;
				half WorldData19_g75862 = 0.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75862 = WorldData19_g75862;
				#else
				float staticSwitch14_g75862 = ObjectData20_g75862;
				#endif
				float Global_ObjectVariation6217_g71633 = staticSwitch14_g75862;
				half Input_GlobalObjectVariation692_g75769 = Global_ObjectVariation6217_g71633;
				float temp_output_630_0_g75769 = ( ( ( _TimeParameters.x * Input_MotionSpeed62_g75769 * Global_NoiseSpeed449_g75769 ) + ( Input_MotionVariation284_g75769 * Input_GlobalMeshVariation569_g75769 ) + ( Input_ObjectVariation694_g75769 * Input_GlobalObjectVariation692_g75769 ) ) * 0.03 );
				float temp_output_607_0_g75769 = frac( temp_output_630_0_g75769 );
				float4 lerpResult590_g75769 = lerp( SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * temp_output_607_0_g75769 ) ), 0.0 ) , SAMPLE_TEXTURE2D_LOD( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g75769 + ( -Input_DirectionWS423_g75769 * frac( ( temp_output_630_0_g75769 + 0.5 ) ) ) ), 0.0 ) , ( abs( ( temp_output_607_0_g75769 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g75769 = ((lerpResult590_g75769).rg*2.0 + -1.0);
				float2 break650_g75769 = temp_output_645_0_g75769;
				float3 appendResult649_g75769 = (float3(break650_g75769.x , 0.0 , break650_g75769.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( GetWorldToObjectMatrix()[ 0 ].xyz ), length( GetWorldToObjectMatrix()[ 1 ].xyz ), length( GetWorldToObjectMatrix()[ 2 ].xyz ) ) );
				half2 Global_Noise_OS5548_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult649_g75769 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Noise_DirectionOS487_g75927 = Global_Noise_OS5548_g71633;
				float2 break448_g75525 = temp_output_447_0_g75525;
				float3 appendResult452_g75525 = (float3(break448_g75525.x , 0.0 , break448_g75525.y));
				half2 Global_Wind_DirectionOS5692_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult452_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_Wind_DirectionOS458_g75927 = Global_Wind_DirectionOS5692_g71633;
				float temp_output_84_0_g75889 = _LayerMotionValue;
				float4 temp_output_91_19_g75889 = TVE_MotionCoords;
				half2 UV94_g75889 = ( (temp_output_91_19_g75889).zw + ( (temp_output_91_19_g75889).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75889 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, UV94_g75889,temp_output_84_0_g75889, 0.0 );
				float4 temp_output_112_19_g75889 = TVE_MotionParams;
				float4 ifLocalVar18_g75893 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g75889] > 0.5 )
				ifLocalVar18_g75893 = tex2DArrayNode50_g75889;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g75889] < 0.5 )
				ifLocalVar18_g75893 = temp_output_112_19_g75889;
				half4 Global_Motion_Params3909_g71633 = ifLocalVar18_g75893;
				float4 break322_g75525 = Global_Motion_Params3909_g71633;
				half Global_Wind_Power2223_g71633 = break322_g75525.z;
				half Input_WindPower449_g75927 = Global_Wind_Power2223_g71633;
				float temp_output_565_0_g75927 = ( 1.0 - Input_WindPower449_g75927 );
				float2 lerpResult516_g75927 = lerp( Input_Noise_DirectionOS487_g75927 , Input_Wind_DirectionOS458_g75927 , ( ( 1.0 - ( temp_output_565_0_g75927 * temp_output_565_0_g75927 * temp_output_565_0_g75927 ) ) * 0.6 ));
				half Mesh_Height1524_g71633 = inputMesh.ase_color.a;
				half Input_MeshHeight388_g75927 = Mesh_Height1524_g71633;
				half ObjectData20_g75928 = Input_MeshHeight388_g75927;
				float enc62_g75853 = inputMesh.ase_texcoord.w;
				float2 localDecodeFloatToVector262_g75853 = DecodeFloatToVector2( enc62_g75853 );
				float2 break63_g75853 = ( localDecodeFloatToVector262_g75853 * 100.0 );
				float Bounds_Height5230_g71633 = break63_g75853.x;
				half Input_BoundsHeight390_g75927 = Bounds_Height5230_g71633;
				half WorldData19_g75928 = ( Input_MeshHeight388_g75927 * Input_MeshHeight388_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75928 = WorldData19_g75928;
				#else
				float staticSwitch14_g75928 = ObjectData20_g75928;
				#endif
				half Final_Motion10_Mask321_g75927 = ( staticSwitch14_g75928 * 2.0 );
				half Motion_10_Amplitude2258_g71633 = _MotionAmplitude_10;
				half Input_BendingAmplitude376_g75927 = Motion_10_Amplitude2258_g71633;
				float2 appendResult433_g75525 = (float2(break322_g75525.x , break322_g75525.y));
				float2 temp_output_436_0_g75525 = (appendResult433_g75525*2.0 + -1.0);
				float2 break441_g75525 = temp_output_436_0_g75525;
				float3 appendResult440_g75525 = (float3(break441_g75525.x , 0.0 , break441_g75525.y));
				half2 Global_React_DirectionOS39_g71633 = (( mul( GetWorldToObjectMatrix(), float4( appendResult440_g75525 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				half2 Input_React_DirectionOS358_g75927 = Global_React_DirectionOS39_g71633;
				float clampResult601_g75927 = clamp( Input_MeshHeight388_g75927 , 0.01 , 0.99 );
				float temp_output_7_0_g75930 = 0.0;
				half Input_InteractionUseMask62_g75927 = _InteractionMaskValue;
				half Final_InteractionRemap594_g75927 = saturate( ( ( clampResult601_g75927 - temp_output_7_0_g75930 ) / ( ( Input_InteractionUseMask62_g75927 - temp_output_7_0_g75930 ) + 0.01 ) ) );
				half ObjectData20_g75929 = Final_InteractionRemap594_g75927;
				half WorldData19_g75929 = ( Final_InteractionRemap594_g75927 * Final_InteractionRemap594_g75927 * Input_BoundsHeight390_g75927 );
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75929 = WorldData19_g75929;
				#else
				float staticSwitch14_g75929 = ObjectData20_g75929;
				#endif
				half Final_InteractionMask373_g75927 = ( staticSwitch14_g75929 * 2.0 );
				half Input_InteractionAmplitude58_g75927 = _InteractionAmplitude;
				half Global_Interaction_Mask66_g71633 = ( break322_g75525.w * break322_g75525.w * break322_g75525.w * break322_g75525.w );
				float Input_InteractionGlobalMask330_g75927 = Global_Interaction_Mask66_g71633;
				half Final_InteractionValue525_g75927 = saturate( ( Input_InteractionAmplitude58_g75927 * Input_InteractionGlobalMask330_g75927 ) );
				float2 lerpResult551_g75927 = lerp( ( lerpResult516_g75927 * ( Final_Motion10_Mask321_g75927 * Input_BendingAmplitude376_g75927 * Input_WindPower449_g75927 * Input_WindPower449_g75927 ) ) , ( Input_React_DirectionOS358_g75927 * Final_InteractionMask373_g75927 * Input_InteractionAmplitude58_g75927 ) , Final_InteractionValue525_g75927);
				float2 break364_g75927 = lerpResult551_g75927;
				half Motion_10_BendingZ190_g71633 = break364_g75927.y;
				half Angle44_g74554 = Motion_10_BendingZ190_g71633;
				half3 VertexPos40_g74583 = ( VertexPosRotationAxis50_g74554 + ( VertexPosOtherAxis82_g74554 * cos( Angle44_g74554 ) ) + ( cross( float3(1,0,0) , VertexPosOtherAxis82_g74554 ) * sin( Angle44_g74554 ) ) );
				float3 appendResult74_g74583 = (float3(0.0 , 0.0 , VertexPos40_g74583.z));
				half3 VertexPosRotationAxis50_g74583 = appendResult74_g74583;
				float3 break84_g74583 = VertexPos40_g74583;
				float3 appendResult81_g74583 = (float3(break84_g74583.x , break84_g74583.y , 0.0));
				half3 VertexPosOtherAxis82_g74583 = appendResult81_g74583;
				half Motion_10_BendingX216_g71633 = break364_g75927.x;
				half Angle44_g74583 = -Motion_10_BendingX216_g71633;
				float Sum_Position446_g75817 = ( ase_worldPos.x + ase_worldPos.y + ase_worldPos.z );
				half Input_MotionScale321_g75817 = ( _MotionScale_20 * 0.1 );
				half Input_MotionVariation330_g75817 = _MotionVariation_20;
				half Input_GlobalVariation400_g75817 = Global_MeshVariation5104_g71633;
				half Input_MotionSpeed62_g75817 = _MotionSpeed_20;
				float temp_output_404_0_g75817 = ( _TimeParameters.x * Input_MotionSpeed62_g75817 );
				half Motion_20_SineA450_g75817 = sin( ( ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) + ( Input_MotionVariation330_g75817 * Input_GlobalVariation400_g75817 ) + temp_output_404_0_g75817 ) );
				half Motion_20_SineB395_g75817 = sin( ( ( temp_output_404_0_g75817 * 0.7562 ) + ( Sum_Position446_g75817 * Input_MotionScale321_g75817 ) ) );
				half3 Input_Position419_g75628 = VertexPosition3588_g71633;
				float3 normalizeResult518_g75628 = normalize( Input_Position419_g75628 );
				half2 Input_DirectionOS423_g75628 = Global_React_DirectionOS39_g71633;
				float2 break521_g75628 = -Input_DirectionOS423_g75628;
				float3 appendResult522_g75628 = (float3(break521_g75628.x , 0.0 , break521_g75628.y));
				float dotResult519_g75628 = dot( normalizeResult518_g75628 , appendResult522_g75628 );
				half Input_Mask62_g75628 = _MotionFacingValue;
				float lerpResult524_g75628 = lerp( 1.0 , (dotResult519_g75628*0.5 + 0.5) , Input_Mask62_g75628);
				half ObjectData20_g75629 = max( lerpResult524_g75628 , 0.001 );
				half WorldData19_g75629 = 1.0;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g75629 = WorldData19_g75629;
				#else
				float staticSwitch14_g75629 = ObjectData20_g75629;
				#endif
				half Motion_FacingMask5214_g71633 = staticSwitch14_g75629;
				half Motion_20_Amplitude4381_g71633 = ( _MotionValue_20 * Motion_FacingMask5214_g71633 );
				half Input_MotionAmplitude384_g75817 = Motion_20_Amplitude4381_g71633;
				half Input_GlobalWind407_g75817 = Global_Wind_Power2223_g71633;
				float4 break638_g75769 = abs( lerpResult590_g75769 );
				half Global_Noise_B5526_g71633 = break638_g75769.b;
				half Input_GlobalNoise411_g75817 = Global_Noise_B5526_g71633;
				float lerpResult413_g75817 = lerp( 1.4 , 0.4 , Input_GlobalWind407_g75817);
				half Final_MotionAmplitude418_g75817 = ( Input_MotionAmplitude384_g75817 * Input_GlobalWind407_g75817 * pow( Input_GlobalNoise411_g75817 , lerpResult413_g75817 ) );
				half Input_Squash58_g75817 = _MotionAmplitude_20;
				float enc59_g75853 = inputMesh.ase_texcoord.z;
				float2 localDecodeFloatToVector259_g75853 = DecodeFloatToVector2( enc59_g75853 );
				float2 break61_g75853 = localDecodeFloatToVector259_g75853;
				half Mesh_Motion_2060_g71633 = break61_g75853.x;
				half Input_MeshMotion_20388_g75817 = Mesh_Motion_2060_g71633;
				float Bounds_Radius5231_g71633 = break63_g75853.y;
				half Input_BoundsRadius390_g75817 = Bounds_Radius5231_g71633;
				half2 Input_DirectionOS366_g75817 = Global_React_DirectionOS39_g71633;
				float2 break371_g75817 = Input_DirectionOS366_g75817;
				float3 appendResult372_g75817 = (float3(break371_g75817.x , ( Motion_20_SineA450_g75817 * 0.1 ) , break371_g75817.y));
				half3 Motion_20_Squash4418_g71633 = ( ( (max( Motion_20_SineA450_g75817 , Motion_20_SineB395_g75817 )*0.2 + 1.0) * Final_MotionAmplitude418_g75817 * Input_Squash58_g75817 * Input_MeshMotion_20388_g75817 * Input_BoundsRadius390_g75817 ) * appendResult372_g75817 );
				half3 VertexPos40_g74516 = ( ( VertexPosRotationAxis50_g74583 + ( VertexPosOtherAxis82_g74583 * cos( Angle44_g74583 ) ) + ( cross( float3(0,0,1) , VertexPosOtherAxis82_g74583 ) * sin( Angle44_g74583 ) ) ) + Motion_20_Squash4418_g71633 );
				float3 appendResult74_g74516 = (float3(0.0 , VertexPos40_g74516.y , 0.0));
				float3 VertexPosRotationAxis50_g74516 = appendResult74_g74516;
				float3 break84_g74516 = VertexPos40_g74516;
				float3 appendResult81_g74516 = (float3(break84_g74516.x , 0.0 , break84_g74516.z));
				float3 VertexPosOtherAxis82_g74516 = appendResult81_g74516;
				half Input_Rolling379_g75817 = _MotionAmplitude_22;
				half Motion_20_Rolling5257_g71633 = ( Motion_20_SineA450_g75817 * Final_MotionAmplitude418_g75817 * Input_Rolling379_g75817 * Input_MeshMotion_20388_g75817 );
				half Angle44_g74516 = Motion_20_Rolling5257_g71633;
				float3 Vertex_Motion_Object833_g71633 = ( VertexPosRotationAxis50_g74516 + ( VertexPosOtherAxis82_g74516 * cos( Angle44_g74516 ) ) + ( cross( float3(0,1,0) , VertexPosOtherAxis82_g74516 ) * sin( Angle44_g74516 ) ) );
				float3 temp_output_3474_0_g71633 = ( VertexPosition3588_g71633 - Mesh_PivotsOS2291_g71633 );
				float3 appendResult2043_g71633 = (float3(Motion_10_BendingX216_g71633 , 0.0 , Motion_10_BendingZ190_g71633));
				float3 Vertex_Motion_World1118_g71633 = ( ( temp_output_3474_0_g71633 + appendResult2043_g71633 ) + Motion_20_Squash4418_g71633 );
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch4976_g71633 = Vertex_Motion_World1118_g71633;
				#else
				float3 staticSwitch4976_g71633 = ( Vertex_Motion_Object833_g71633 + ( _VertexDataMode * 0.0 ) );
				#endif
				half3 Grass_Perspective2661_g71633 = half3(0,0,0);
				float temp_output_84_0_g75894 = _LayerVertexValue;
				float4 temp_output_94_19_g75894 = TVE_VertexCoords;
				half2 UV97_g75894 = ( (temp_output_94_19_g75894).zw + ( (temp_output_94_19_g75894).xy * (ObjectPosition4223_g71633).xz ) );
				float4 tex2DArrayNode50_g75894 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, UV97_g75894,temp_output_84_0_g75894, 0.0 );
				float4 temp_output_111_19_g75894 = TVE_VertexParams;
				float4 ifLocalVar18_g75898 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g75894] > 0.5 )
				ifLocalVar18_g75898 = tex2DArrayNode50_g75894;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g75894] < 0.5 )
				ifLocalVar18_g75898 = temp_output_111_19_g75894;
				half4 Global_Vertex_Params4173_g71633 = ifLocalVar18_g75898;
				half Global_VertexSize174_g71633 = saturate( Global_Vertex_Params4173_g71633.w );
				float lerpResult346_g71633 = lerp( 1.0 , Global_VertexSize174_g71633 , _GlobalSize);
				float3 appendResult3480_g71633 = (float3(lerpResult346_g71633 , lerpResult346_g71633 , lerpResult346_g71633));
				half3 ObjectData20_g74589 = appendResult3480_g71633;
				half3 _Vector11 = half3(1,1,1);
				half3 WorldData19_g74589 = _Vector11;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g74589 = WorldData19_g74589;
				#else
				float3 staticSwitch14_g74589 = ObjectData20_g74589;
				#endif
				half3 Vertex_Size1741_g71633 = staticSwitch14_g74589;
				half3 _Vector5 = half3(1,1,1);
				float3 Vertex_SizeFade1740_g71633 = _Vector5;
				float3 lerpResult16_g75881 = lerp( VertexPosition3588_g71633 , ( ( ( staticSwitch4976_g71633 + Grass_Perspective2661_g71633 ) * Vertex_Size1741_g71633 * Vertex_SizeFade1740_g71633 ) + Mesh_PivotsOS2291_g71633 ) , TVE_Enabled);
				float3 Final_VertexPosition890_g71633 = ( lerpResult16_g75881 + _DisableSRPBatcher );
				
				half Mesh_DetailMask90_g71633 = inputMesh.ase_color.b;
				float vertexToFrag11_g75584 = Mesh_DetailMask90_g71633;
				o.ase_texcoord4.x = vertexToFrag11_g75584;
				o.ase_texcoord4.yzw = ase_worldPos;
				o.ase_texcoord5.xyz = vertexToFrag3890_g71633;
				
				o.ase_texcoord2 = inputMesh.ase_texcoord;
				o.ase_texcoord3 = inputMesh.ase_texcoord1;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord5.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  Final_VertexPosition890_g71633;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS =  inputMesh.normalOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				o.positionCS = TransformWorldToHClip(positionRWS);
				o.normalWS.xyz =  normalWS;
				o.tangentWS.xyzw =  tangentWS;

				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput Vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag(	VertexOutput packedInput
						, out float4 outColor : SV_Target0
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				UNITY_SETUP_INSTANCE_ID(packedInput);

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.tangentToWorld = BuildTangentToWorld(packedInput.tangentWS.xyzw, packedInput.normalWS.xyz);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				SurfaceDescription surfaceDescription = (SurfaceDescription)0;
				float localCustomAlphaClip19_g75868 = ( 0.0 );
				half2 Main_UVs15_g71633 = ( ( packedInput.ase_texcoord2.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode29_g71633 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs15_g71633 );
				half Main_Alpha316_g71633 = tex2DNode29_g71633.a;
				float2 appendResult21_g75853 = (float2(packedInput.ase_texcoord3.z , packedInput.ase_texcoord3.w));
				float2 Mesh_DetailCoord3_g71633 = appendResult21_g75853;
				float2 lerpResult1545_g71633 = lerp( packedInput.ase_texcoord2.xy , Mesh_DetailCoord3_g71633 , _DetailCoordMode);
				float2 temp_output_14_0_g71633 = ( ( lerpResult1545_g71633 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				half2 Second_UVs17_g71633 = temp_output_14_0_g71633;
				float4 tex2DNode89_g71633 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs17_g71633 );
				half Second_Alpha5007_g71633 = tex2DNode89_g71633.a;
				float4 tex2DNode35_g71633 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_Linear_Repeat, Main_UVs15_g71633 );
				half Main_Mask57_g71633 = tex2DNode35_g71633.b;
				float4 tex2DNode33_g71633 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_Linear_Repeat, Second_UVs17_g71633 );
				half Second_Mask81_g71633 = tex2DNode33_g71633.b;
				float lerpResult1327_g71633 = lerp( Main_Mask57_g71633 , Second_Mask81_g71633 , _DetailMaskMode);
				float lerpResult4058_g71633 = lerp( lerpResult1327_g71633 , ( 1.0 - lerpResult1327_g71633 ) , _DetailMaskInvertMode);
				float vertexToFrag11_g75584 = packedInput.ase_texcoord4.x;
				half Blend_Source1540_g71633 = vertexToFrag11_g75584;
				float clampResult6215_g71633 = clamp( ( lerpResult4058_g71633 * Blend_Source1540_g71633 ) , 0.01 , 0.99 );
				float temp_output_7_0_g75796 = _DetailBlendMinValue;
				half Blend_Mask147_g71633 = ( saturate( ( ( clampResult6215_g71633 - temp_output_7_0_g75796 ) / ( ( _DetailBlendMaxValue - temp_output_7_0_g75796 ) + 0.01 ) ) ) * _DetailMode );
				float lerpResult6153_g71633 = lerp( Main_Alpha316_g71633 , Second_Alpha5007_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6158_g71633 = lerpResult6153_g71633;
				#else
				float staticSwitch6158_g71633 = Main_Alpha316_g71633;
				#endif
				half Blend_Alpha6157_g71633 = staticSwitch6158_g71633;
				half Global_Alpha315_g71633 = 1.0;
				half Fade_Effects_A5360_g71633 = 1.0;
				float3 ase_worldPos = packedInput.ase_texcoord4.yzw;
				float temp_output_7_0_g75798 = TVE_CameraFadeMin;
				float lerpResult4755_g71633 = lerp( 1.0 , saturate( saturate( ( ( distance( ase_worldPos , _WorldSpaceCameraPos ) - temp_output_7_0_g75798 ) / ( ( TVE_CameraFadeMax - temp_output_7_0_g75798 ) + 0.01 ) ) ) ) , _FadeCameraValue);
				half Fade_Camera3743_g71633 = lerpResult4755_g71633;
				half Fade_Effects_B6228_g71633 = ( ( Fade_Effects_A5360_g71633 * Fade_Camera3743_g71633 ) * ( 1.0 - _FadeConstantValue ) );
				float3 vertexToFrag3890_g71633 = packedInput.ase_texcoord5.xyz;
				float3 WorldPosition3905_g71633 = vertexToFrag3890_g71633;
				half AlphaTreshold2132_g71633 = _AlphaClipValue;
				float temp_output_5865_0_g71633 = saturate( ( ( Fade_Effects_B6228_g71633 - SAMPLE_TEXTURE3D( TVE_NoiseTex3D, sampler_Linear_Repeat, ( TVE_NoiseTex3DTilling * WorldPosition3905_g71633 ) ).r ) + AlphaTreshold2132_g71633 ) );
				float lerpResult6613_g71633 = lerp( 1.0 , ( 1.0 - Blend_Mask147_g71633 ) , _DetailOpaqueMode);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6612_g71633 = lerpResult6613_g71633;
				#else
				float staticSwitch6612_g71633 = 1.0;
				#endif
				half Blend_Mask_Invert6260_g71633 = staticSwitch6612_g71633;
				half Fade_Mask5149_g71633 = ( 1.0 * Blend_Mask_Invert6260_g71633 );
				float lerpResult5141_g71633 = lerp( 1.0 , temp_output_5865_0_g71633 , Fade_Mask5149_g71633);
				half Fade_Alpha3727_g71633 = lerpResult5141_g71633;
				float temp_output_6678_0_g71633 = min( ( Blend_Alpha6157_g71633 * Global_Alpha315_g71633 ) , Fade_Alpha3727_g71633 );
				half Alpha34_g75873 = temp_output_6678_0_g71633;
				float temp_output_3_0_g75868 = Alpha34_g75873;
				float Alpha19_g75868 = temp_output_3_0_g75868;
				float temp_output_15_0_g75868 = AlphaTreshold2132_g71633;
				float Treshold19_g75868 = temp_output_15_0_g75868;
				{
				#if defined (TVE_FEATURE_CLIP)
				#if defined (TVE_IS_HD_PIPELINE)
				#if !defined (SHADERPASS_FORWARD_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#if !defined (SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST)
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#else
				clip(Alpha19_g75868 - Treshold19_g75868);
				#endif
				#endif
				}
				half Main_Color_Alpha6121_g71633 = _MainColor.a;
				half Second_Color_Alpha6152_g71633 = _SecondColor.a;
				float lerpResult6168_g71633 = lerp( Main_Color_Alpha6121_g71633 , Second_Color_Alpha6152_g71633 , Blend_Mask147_g71633);
				#ifdef TVE_FEATURE_DETAIL
				float staticSwitch6174_g71633 = lerpResult6168_g71633;
				#else
				float staticSwitch6174_g71633 = Main_Color_Alpha6121_g71633;
				#endif
				half Blend_Color_Alpha6167_g71633 = staticSwitch6174_g71633;
				half Final_Alpha914_g71633 = saturate( ( Alpha19_g75868 * Blend_Color_Alpha6167_g71633 ) );
				
				surfaceDescription.Alpha = Final_Alpha914_g71633;
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;


				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);
				outColor = _SelectionID;
			}

            ENDHLSL
		}

        Pass
        {

            Name "FullScreenDebug"
            Tags { "LightMode" = "FullScreenDebug" }

            Cull [_CullMode]
			ZTest LEqual
			ZWrite Off

            HLSLPROGRAM

			/*ase_pragma_before*/

			// BOXOPHOBIC: Bypass unity bug with instanced properties
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer

			#pragma vertex Vert
			#pragma fragment Frag


			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphHeader.hlsl"

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
		    #define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if !( (SHADERPASS == SHADERPASS_FORWARD) || (SHADERPASS == SHADERPASS_LIGHT_TRANSPORT) \
               || (SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT) || (SHADERPASS == SHADERPASS == SHADERPASS_RAYTRACING_INDIRECT)\
               || (SHADERPASS == SHADERPASS_PATH_TRACING) || (SHADERPASS == SHADERPASS_RAYTRACING_SUB_SURFACE) \
               || (SHADERPASS == SHADERPASS_RAYTRACING_GBUFFER) )

		    #define DISABLE_MODIFY_BAKED_DIFFUSE_LIGHTING
		    #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

			#if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define _DEFERRED_CAPABLE_MATERIAL
			#endif

			#if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
			#define _WRITE_TRANSPARENT_MOTION_VECTOR
			#endif

            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
				#endif
			};

			struct VaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

			struct VertexDescriptionInputs
			{
				 float3 ObjectSpaceNormal;
				 float3 ObjectSpaceTangent;
				 float3 ObjectSpacePosition;
			};

			struct SurfaceDescriptionInputs
			{
				 float3 TangentSpaceNormal;
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
			{
				PackedVaryingsMeshToPS output;
				ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

			VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
			{
				VaryingsMeshToPS output;
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

            struct VertexDescription
			{
				float3 Position;
				float3 Normal;
				float3 Tangent;
			};

			VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
			{
				VertexDescription description = (VertexDescription)0;
				description.Position = IN.ObjectSpacePosition;
				description.Normal = IN.ObjectSpaceNormal;
				description.Tangent = IN.ObjectSpaceTangent;
				return description;
			}

            struct SurfaceDescription
			{
				float3 BaseColor;
				float3 Emission;
				float Alpha;
				float3 BentNormal;
				float Smoothness;
				float Occlusion;
				float3 NormalTS;
				float Metallic;
			};

			SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
			{
				SurfaceDescription surface = (SurfaceDescription)0;
				surface.BaseColor = IsGammaSpace() ? float3(0.5, 0.5, 0.5) : SRGBToLinear(float3(0.5, 0.5, 0.5));
				surface.Emission = float3(0, 0, 0);
				surface.Alpha = 1;
				surface.BentNormal = IN.TangentSpaceNormal;
				surface.Smoothness = 0.5;
				surface.Occlusion = 1;
				surface.NormalTS = IN.TangentSpaceNormal;
				surface.Metallic = 0;
				return surface;
			}

			VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
			{
				VertexDescriptionInputs output;
				ZERO_INITIALIZE(VertexDescriptionInputs, output);

				output.ObjectSpaceNormal =                          input.normalOS;
				output.ObjectSpaceTangent =                         input.tangentOS.xyz;
				output.ObjectSpacePosition =                        input.positionOS;

				return output;
			}

			AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters  )
			{
				VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);

				VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);

				input.positionOS = vertexDescription.Position;
				input.normalOS = vertexDescription.Normal;
				input.tangentOS.xyz = vertexDescription.Tangent;
				return input;
			}

			FragInputs BuildFragInputs(VaryingsMeshToPS input)
			{
				FragInputs output;
				ZERO_INITIALIZE(FragInputs, output);

				output.tangentToWorld = k_identity3x3;
				output.positionSS = input.positionCS;

				return output;
			}


			FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
			{
				UNITY_SETUP_INSTANCE_ID(input);
				VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
				return BuildFragInputs(unpacked);
			}


            SurfaceDescriptionInputs FragInputsToSurfaceDescriptionInputs(FragInputs input, float3 viewWS)
			{
				SurfaceDescriptionInputs output;
				ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

				#if defined(SHADER_STAGE_RAY_TRACING)
				#else
				#endif
				output.TangentSpaceNormal =                         float3(0.0f, 0.0f, 1.0f);
				return output;
			}

			void BuildSurfaceData(FragInputs fragInputs, inout SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =                 surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =      surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =          surfaceDescription.Occlusion;
				surfaceData.metallic =                  surfaceDescription.Metallic;

				#if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
					if (_EnableSSRefraction)
					{

						surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
						surfaceDescription.Alpha = 1.0;
					}
					else
					{
						surfaceData.ior = 1.0;
						surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
						surfaceData.atDistance = 1.0;
						surfaceData.transmittanceMask = 0.0;
						surfaceDescription.Alpha = 1.0;
					}
				#else
					surfaceData.ior = 1.0;
					surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
					surfaceData.atDistance = 1.0;
					surfaceData.transmittanceMask = 0.0;
				#endif


				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;
				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
					surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif
				#ifdef _MATERIAL_FEATURE_TRANSMISSION
					surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif
                #ifdef _MATERIAL_FEATURE_ANISOTROPY
					surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
					surfaceData.normalWS = float3(0, 1, 0);
                #endif
				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
					surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif
				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
					surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif
				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
					surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif
				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
					surfaceData.baseColor *= (1.0 - Max3(surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b));
				#endif
				#ifdef _DOUBLESIDED_ON
					float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
					float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
				#endif


				GetNormalWS(fragInputs, surfaceDescription.NormalTS, surfaceData.normalWS, doubleSidedConstants);

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];

				surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz);


				#if HAVE_DECALS
					if (_EnableDecals)
					{
						DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
						ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
					}
				#endif

				bentNormalWS = surfaceData.normalWS;

				surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				#ifdef DEBUG_DISPLAY
					if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
					{

						surfaceData.metallic = 0;
					}

					ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
				surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif
			}

            void GetSurfaceAndBuiltinData(FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData RAY_TRACING_OPTIONAL_PARAMETERS)
            {

                #if !defined(SHADER_STAGE_RAY_TRACING) && !defined(_TESSELLATION_DISPLACEMENT)
                #ifdef LOD_FADE_CROSSFADE
                LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
                #endif
                #endif

                #ifndef SHADER_UNLIT
                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif

                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);
                #endif

                SurfaceDescriptionInputs surfaceDescriptionInputs = FragInputsToSurfaceDescriptionInputs(fragInputs, V);

                SurfaceDescription surfaceDescription = SurfaceDescriptionFunction(surfaceDescriptionInputs);

                #ifdef _ALPHATEST_ON
				float alphaCutoff = surfaceDescription.AlphaClipThreshold;
                #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
                #elif SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_POSTPASS
				alphaCutoff = surfaceDescription.AlphaClipThresholdDepthPostpass;
                #elif (SHADERPASS == SHADERPASS_SHADOWS) || (SHADERPASS == SHADERPASS_RAYTRACING_VISIBILITY)
                #endif
				GENERIC_ALPHA_TEST(surfaceDescription.Alpha, alphaCutoff);
                #endif

                #if !defined(SHADER_STAGE_RAY_TRACING) && _DEPTHOFFSET_ON
                ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
                #endif

                #ifndef SHADER_UNLIT
                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);

                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

                #else
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);

                ZERO_BUILTIN_INITIALIZE(builtinData);
                builtinData.opacity = surfaceDescription.Alpha;

                #if defined(DEBUG_DISPLAY)
                    builtinData.renderingLayers = GetMeshRenderingLightLayer();
                #endif

                #endif

                #ifdef _ALPHATEST_ON

                    builtinData.alphaClipTreshold = alphaCutoff;
                #endif


                builtinData.emissiveColor = surfaceDescription.Emission;

                #if _DEPTHOFFSET_ON
                builtinData.depthOffset = surfaceDescription.DepthOffset;
                #endif


                #if (SHADERPASS == SHADERPASS_DISTORTION)
                builtinData.distortion = surfaceDescription.Distortion;
                builtinData.distortionBlur = surfaceDescription.DistortionBlur;
                #endif

                #ifndef SHADER_UNLIT

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
                #else
                ApplyDebugToBuiltinData(builtinData);
                #endif

            }

			#define DEBUG_DISPLAY
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/FullScreenDebug.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/VertMesh.hlsl"

			PackedVaryingsType Vert(AttributesMesh inputMesh)
			{
				VaryingsType varyingsType;
				varyingsType.vmesh = VertMesh(inputMesh);
				return PackVaryingsType(varyingsType);
			}

			#if !defined(_DEPTHOFFSET_ON)
			[earlydepthstencil]
			#endif
			void Frag(PackedVaryingsToPS packedInput)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				FragInputs input = UnpackVaryingsToFragInputs(packedInput);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz);

			#ifdef PLATFORM_SUPPORTS_PRIMITIVE_ID_IN_PIXEL_SHADER
				if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_QUAD_OVERDRAW)
				{
					IncrementQuadOverdrawCounter(posInput.positionSS.xy, input.primitiveID);
				}
			#endif
			}
            ENDHLSL
        }
		
	}
	
	CustomEditor "TVEShaderCoreGUI"
	
	Fallback "Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback"
}
/*ASEBEGIN
Version=19103
Node;AmplifyShaderEditor.RangedFloatNode;17;-1600,-768;Half;False;Property;_render_zw;_render_zw;207;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;383;-1344,-896;Inherit;False;Compile All Shaders;-1;;71629;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;307;-2176,384;Inherit;False;Define Shader Vegetation;-1;;71630;b458122dd75182d488380bd0f592b9e6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-2176,-768;Half;False;Property;_render_cull;_render_cull;204;1;[HideInInspector];Create;True;0;3;Both;0;Back;1;Front;2;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;127;-2176,-896;Half;False;Property;_IsBarkShader;_IsBarkShader;202;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;382;-1856,384;Inherit;False;Define Pipeline HD;-1;;71631;7af1bc24c286d754db63fb6a44aba77b;0;0;1;FLOAT;529
Node;AmplifyShaderEditor.RangedFloatNode;134;-1984,-896;Half;False;Property;_IsStandardShader;_IsStandardShader;203;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;384;-1536,-896;Inherit;False;Compile Core;-1;;71632;634b02fd1f32e6a4c875d8fc2c450956;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1984,-768;Half;False;Property;_render_src;_render_src;205;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1792,-768;Half;False;Property;_render_dst;_render_dst;206;1;[HideInInspector];Create;True;0;2;Opaque;0;Transparent;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;379;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;TransparentDepthPrepass;0;7;TransparentDepthPrepass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;1;False;;1;False;;7;False;;3;False;;1;False;;1;False;;False;True;1;False;;False;False;True;1;LightMode=TransparentDepthPrepass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;372;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;META;0;1;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;373;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;374;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;376;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Motion Vectors;0;5;Motion Vectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefMV;255;False;;255;True;_StencilWriteMaskMV;7;False;;3;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;False;False;True;1;LightMode=MotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;375;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;DepthOnly;0;4;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;385;-1376,-274;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;ScenePickingPass;0;10;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;378;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;TransparentBackface;0;6;TransparentBackface;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelOne;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelTwo;False;False;False;False;False;True;0;True;_ZWrite;True;0;True;_ZTestTransparent;False;True;1;LightMode=TransparentBackface;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;371;-1376,-384;Float;False;True;-1;2;TVEShaderCoreGUI;0;23;BOXOPHOBIC/The Vegetation Engine/Default/Bark Standard Lit;28cd5599e02859647ae1798e4fcaef6c;True;GBuffer;0;0;GBuffer;34;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;9;d3d11;metal;vulkan;xboxone;xboxseries;playstation;ps4;ps5;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;_CullMode;False;True;True;True;True;True;0;True;_LightLayersMaskBuffer4;False;False;False;False;False;False;True;True;True;0;True;_StencilRefGBuffer;255;False;;255;True;_StencilWriteMaskGBuffer;7;False;;3;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;False;True;0;True;_ZTestGBuffer;False;True;1;LightMode=GBuffer;False;False;0;Hidden/BOXOPHOBIC/The Vegetation Engine/Fallback;0;0;Standard;39;Surface Type;0;0;  Rendering Pass;1;0;  Refraction Model;0;0;    Blending Mode;0;0;    Blend Preserves Specular;1;0;  Back Then Front Rendering;0;0;  Transparent Depth Prepass;0;0;  Transparent Depth Postpass;0;0;  ZWrite;0;0;  Z Test;4;0;Double-Sided;0;637921061174210627;Alpha Clipping;0;0;  Use Shadow Threshold;0;0;Material Type,InvertActionOnDeselection;4;0;  Energy Conserving Specular;1;0;  Transmission,InvertActionOnDeselection;0;0;Forward Only;0;0;Receive Decals;1;0;Receives SSR;1;0;Receive SSR Transparent;0;0;Motion Vectors;1;0;  Add Precomputed Velocity;0;0;Specular AA;0;0;Specular Occlusion Mode;1;638036732122370465;Override Baked GI;0;0;Depth Offset;0;0;DOTS Instancing;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position;0;0;0;11;True;True;True;True;True;True;False;False;False;True;True;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;380;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;TransparentDepthPostpass;0;8;TransparentDepthPostpass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=TransparentDepthPostpass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;381;-1376,-384;Float;False;False;-1;2;Rendering.HighDefinition.LitShaderGraphGUI;0;14;New Amplify Shader;28cd5599e02859647ae1798e4fcaef6c;True;Forward;0;9;Forward;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;True;_CullModeForward;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelOne;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelTwo;False;False;False;True;True;0;True;_StencilRef;255;False;;255;True;_StencilWriteMask;7;False;;3;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;0;True;_ZWrite;True;0;True;_ZTestDepthEqualForOpaque;False;True;1;LightMode=Forward;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.CommentaryNode;285;-2176,256;Inherit;False;1026.438;100;Features;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-2176,-512;Inherit;False;1022.896;100;Final;0;;0,1,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-2176,-1024;Inherit;False;1026.438;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.FunctionNode;350;-2176,-384;Inherit;False;Base Shader;0;;71633;856f7164d1c579d43a5cf4968a75ca43;84,3880,1,4028,1,3900,1,3908,1,4172,1,1300,1,1298,1,4179,1,3586,0,4499,1,1708,0,6056,1,3509,1,3873,1,893,0,6230,0,5156,1,5345,0,5075,1,1718,1,6116,1,1717,1,1714,1,1715,1,6076,1,6592,1,6068,1,6692,0,6729,1,1776,0,3475,1,6378,1,6352,1,6655,1,4210,1,1745,1,3479,0,1646,0,3501,1,2807,0,6206,0,4999,0,6194,0,3887,0,3957,1,6647,0,6257,0,5357,0,2172,0,3883,0,3728,1,5350,0,2658,0,1742,0,3484,0,1733,1,1734,1,1737,1,6320,1,4837,1,5079,1,1735,1,1736,1,6166,1,6161,1,6622,1,1550,0,878,0,6721,1,860,1,2261,1,2260,1,2032,1,2054,1,5258,1,2039,0,2062,0,3243,0,5220,1,4217,1,6699,1,5090,1,4242,0,5339,0;8;6196;FLOAT;1;False;6693;FLOAT;1;False;6201;FLOAT;1;False;6205;FLOAT;1;False;5143;FLOAT;1;False;6231;FLOAT;1;False;6198;FLOAT;1;False;5340;FLOAT3;0,0,0;False;23;FLOAT3;0;FLOAT3;528;FLOAT3;2489;FLOAT;531;FLOAT;4842;FLOAT;529;FLOAT;3678;FLOAT;530;FLOAT;4122;FLOAT;4134;FLOAT;1235;FLOAT;532;FLOAT;5389;FLOAT;721;FLOAT3;1230;FLOAT;5296;FLOAT;1461;FLOAT;1290;FLOAT;629;FLOAT3;534;FLOAT;4867;FLOAT4;5246;FLOAT4;4841
WireConnection;371;0;350;0
WireConnection;371;1;350;528
WireConnection;371;5;350;3678
WireConnection;371;6;350;2489
WireConnection;371;7;350;530
WireConnection;371;8;350;531
WireConnection;371;9;350;532
WireConnection;371;11;350;534
ASEEND*/
//CHKSM=3933ADE9D6452086CB78BD94BF00E79F070227D1
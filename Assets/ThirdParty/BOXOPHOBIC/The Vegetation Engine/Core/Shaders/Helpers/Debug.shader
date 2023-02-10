// Made with Amplify Shader Editor v1.9.1.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug"
{
	Properties
	{
		[StyledBanner(Debug)]_Banner("Banner", Float) = 0
		_IsVertexShader("_IsVertexShader", Float) = 0
		_IsSimpleShader("_IsSimpleShader", Float) = 0
		[HideInInspector]_IsTVEShader("_IsTVEShader", Float) = 0
		_IsStandardShader("_IsStandardShader", Float) = 0
		_IsSubsurfaceShader("_IsSubsurfaceShader", Float) = 0
		_IsPropShader("_IsPropShader", Float) = 0
		_IsBarkShader("_IsBarkShader", Float) = 0
		_IsImpostorShader("_IsImpostorShader", Float) = 0
		_IsVegetationShader("_IsVegetationShader", Float) = 0
		_IsGrassShader("_IsGrassShader", Float) = 0
		_IsLeafShader("_IsLeafShader", Float) = 0
		_IsCrossShader("_IsCrossShader", Float) = 0
		[NoScaleOffset]_MainNormalTex("_MainNormalTex", 2D) = "black" {}
		[NoScaleOffset]_EmissiveTex("_EmissiveTex", 2D) = "black" {}
		[NoScaleOffset]_SecondMaskTex("_SecondMaskTex", 2D) = "black" {}
		[NoScaleOffset]_SecondNormalTex("_SecondNormalTex", 2D) = "black" {}
		[NoScaleOffset]_SecondAlbedoTex("_SecondAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainAlbedoTex("_MainAlbedoTex", 2D) = "black" {}
		[NoScaleOffset]_MainMaskTex("_MainMaskTex", 2D) = "black" {}
		_RenderClip("_RenderClip", Float) = 0
		_IsElementShader("_IsElementShader", Float) = 0
		_IsHelperShader("_IsHelperShader", Float) = 0
		_Cutoff("_Cutoff", Float) = 0
		_DetailMode("_DetailMode", Float) = 0
		_EmissiveCat("_EmissiveCat", Float) = 0
		[HDR]_EmissiveColor("_EmissiveColor", Color) = (0,0,0,0)
		[HideInInspector][Enum(Single Pivot,0,Baked Pivots,1)]_VertexPivotMode("_VertexPivotMode", Float) = 0
		_IsPolygonalShader("_IsPolygonalShader", Float) = 0
		[IntRange]_MotionSpeed_10("Primary Speed", Range( 0 , 40)) = 40
		[IntRange]_MotionVariation_10("Primary Speed", Range( 0 , 40)) = 40
		_MotionScale_10("Primary Scale", Range( 0 , 20)) = 0
		[HideInInspector][StyledToggle]_VertexDynamicMode("Enable Dynamic Support", Float) = 0
		[Space(10)][StyledVector(9)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[Enum(UV 0,0,Baked,1)]_DetailCoordMode("Detail Coord", Float) = 0
		[Space(10)][StyledVector(9)]_SecondUVs("Detail UVs", Vector) = (1,1,0,0)
		[Space(10)][StyledVector(9)]_EmissiveUVs("Emissive UVs", Vector) = (1,1,0,0)
		_IsIdentifier("_IsIdentifier", Float) = 0
		_IsCollected("_IsCollected", Float) = 0
		[ASEEnd][StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0)]_Message("Message", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
		//[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		//[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		
		Tags { "RenderType"="Opaque" "Queue"="Geometry" "DisableBatching"="True" }
	LOD 0

		Cull Off
		AlphaToMask Off
		ZWrite On
		ZTest LEqual
		ColorMask RGBA
		
		Blend Off
		

		CGINCLUDE
		#pragma target 5.0

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

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
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
		ENDCG

		
		Pass
		{
			
			Name "ForwardBase"
			Tags { "LightMode"="ForwardBase" }

			Blend One Zero

			CGPROGRAM
			#define ASE_NO_AMBIENT 1
			#pragma multi_compile_instancing
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			#ifndef UNITY_PASS_FORWARDBASE
				#define UNITY_PASS_FORWARDBASE
			#endif
			#include "HLSLSupport.cginc"
			#ifndef UNITY_INSTANCED_LOD_FADE
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#ifndef UNITY_INSTANCED_SH
				#define UNITY_INSTANCED_SH
			#endif
			#ifndef UNITY_INSTANCED_LIGHTMAPSTS
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			#include "AutoLight.cginc"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				#if defined(LIGHTMAP_ON) || (!defined(LIGHTMAP_ON) && SHADER_TARGET >= 30)
					float4 lmap : TEXCOORD0;
				#endif
				#if !defined(LIGHTMAP_ON) && UNITY_SHOULD_SAMPLE_SH
					half3 sh : TEXCOORD1;
				#endif
				#if defined(UNITY_HALF_PRECISION_FRAGMENT_SHADER_REGISTERS) && UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHTING_COORDS(2,3)
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_SHADOW_COORDS(2)
					#else
						SHADOW_COORDS(2)
					#endif
				#endif
				#ifdef ASE_FOG
					UNITY_FOG_COORDS(4)
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 screenPos : TEXCOORD8;
				#endif
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_texcoord12 : TEXCOORD12;
				float4 ase_color : COLOR;
				float4 ase_texcoord13 : TEXCOORD13;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Banner;
			uniform half _Message;
			uniform float _IsSimpleShader;
			uniform float _IsVertexShader;
			uniform half _IsTVEShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsCollected;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
			uniform float4 _MainAlbedoTex_ST;
			SamplerState sampler_MainAlbedoTex;
			uniform half TVE_DEBUG_Clip;
			uniform float _IsBarkShader;
			uniform float _IsCrossShader;
			uniform float _IsGrassShader;
			uniform float _IsLeafShader;
			uniform float _IsPropShader;
			uniform float _IsImpostorShader;
			uniform float _IsPolygonalShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform float _IsIdentifier;
			uniform half TVE_DEBUG_Index;
			uniform half4 _MainUVs;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
			SamplerState sampler_MainNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
			SamplerState sampler_MainMaskTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
			uniform half _DetailCoordMode;
			uniform half4 _SecondUVs;
			SamplerState sampler_SecondAlbedoTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
			SamplerState sampler_SecondNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
			SamplerState sampler_SecondMaskTex;
			uniform float _DetailMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
			uniform half4 _EmissiveUVs;
			SamplerState sampler_EmissiveTex;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_DEBUG_MipTex);
			SamplerState samplerTVE_DEBUG_MipTex;
			uniform float4 _MainNormalTex_ST;
			uniform float4 _MainMaskTex_ST;
			uniform float4 _SecondAlbedoTex_ST;
			uniform float4 _SecondMaskTex_ST;
			uniform float4 _EmissiveTex_ST;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
			uniform float _MotionScale_10;
			uniform half4 TVE_NoiseParams;
			uniform half4 TVE_MotionParams;
			uniform float _MotionSpeed_10;
			uniform float _MotionVariation_10;
			uniform half _VertexPivotMode;
			uniform half _VertexDynamicMode;
			SamplerState sampler_Linear_Repeat;
			uniform half TVE_DEBUG_Layer;
			uniform float TVE_ColorsUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoords;
			SamplerState sampler_Linear_Clamp;
			uniform half4 TVE_ColorsParams;
			uniform float TVE_ExtrasUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_ExtrasParams;
			uniform float TVE_MotionUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoords;
			uniform float TVE_VertexUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
			uniform half4 TVE_VertexCoords;
			uniform half4 TVE_VertexParams;
			uniform float _IsVegetationShader;
			uniform half TVE_DEBUG_Filter;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;


			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 customSurfaceDepth676_g80801 = v.vertex.xyz;
				float customEye676_g80801 = -UnityObjectToViewPos( customSurfaceDepth676_g80801 ).z;
				o.ase_texcoord9.x = customEye676_g80801;
				float3 customSurfaceDepth1399_g80801 = v.vertex.xyz;
				float customEye1399_g80801 = -UnityObjectToViewPos( customSurfaceDepth1399_g80801 ).z;
				o.ase_texcoord9.y = customEye1399_g80801;
				float Debug_Index464_g80801 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g80807 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80807 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g80826 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80826 = v.normal;
				float3 ifLocalVar40_g80840 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80840 = v.tangent.xyz;
				float ifLocalVar40_g80822 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80822 = saturate( v.tangent.w );
				float ifLocalVar40_g80958 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80958 = v.ase_color.r;
				float ifLocalVar40_g80959 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80959 = v.ase_color.g;
				float ifLocalVar40_g80960 = 0;
				if( Debug_Index464_g80801 == 7.0 )
				ifLocalVar40_g80960 = v.ase_color.b;
				float ifLocalVar40_g80961 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80961 = v.ase_color.a;
				float3 appendResult1147_g80801 = (float3(v.ase_texcoord.x , v.ase_texcoord.y , 0.0));
				float3 ifLocalVar40_g80967 = 0;
				if( Debug_Index464_g80801 == 9.0 )
				ifLocalVar40_g80967 = appendResult1147_g80801;
				float3 appendResult1148_g80801 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
				float3 ifLocalVar40_g80968 = 0;
				if( Debug_Index464_g80801 == 10.0 )
				ifLocalVar40_g80968 = appendResult1148_g80801;
				float3 appendResult1149_g80801 = (float3(v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float3 ifLocalVar40_g80969 = 0;
				if( Debug_Index464_g80801 == 11.0 )
				ifLocalVar40_g80969 = appendResult1149_g80801;
				float3 break111_g80962 = float3( 0,0,0 );
				half Input_DynamicMode120_g80962 = 0.0;
				float Postion_Sum142_g80962 = ( ( break111_g80962.x + break111_g80962.y + break111_g80962.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g80962 ) );
				half Input_Variation124_g80962 = v.ase_color.r;
				half ObjectData20_g80964 = ( Postion_Sum142_g80962 + Input_Variation124_g80962 );
				half WorldData19_g80964 = Input_Variation124_g80962;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g80964 = WorldData19_g80964;
				#else
				float staticSwitch14_g80964 = ObjectData20_g80964;
				#endif
				float clampResult129_g80962 = clamp( frac( staticSwitch14_g80964 ) , 0.01 , 0.99 );
				float ifLocalVar40_g80970 = 0;
				if( Debug_Index464_g80801 == 12.0 )
				ifLocalVar40_g80970 = clampResult129_g80962;
				float ifLocalVar40_g80971 = 0;
				if( Debug_Index464_g80801 == 13.0 )
				ifLocalVar40_g80971 = v.ase_color.g;
				float ifLocalVar40_g80972 = 0;
				if( Debug_Index464_g80801 == 14.0 )
				ifLocalVar40_g80972 = v.ase_color.b;
				float ifLocalVar40_g80973 = 0;
				if( Debug_Index464_g80801 == 15.0 )
				ifLocalVar40_g80973 = v.ase_color.a;
				float3 break111_g80978 = float3( 0,0,0 );
				half Input_DynamicMode120_g80978 = 0.0;
				float Postion_Sum142_g80978 = ( ( break111_g80978.x + break111_g80978.y + break111_g80978.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g80978 ) );
				half Input_Variation124_g80978 = v.ase_color.r;
				half ObjectData20_g80980 = ( Postion_Sum142_g80978 + Input_Variation124_g80978 );
				half WorldData19_g80980 = Input_Variation124_g80978;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g80980 = WorldData19_g80980;
				#else
				float staticSwitch14_g80980 = ObjectData20_g80980;
				#endif
				float clampResult129_g80978 = clamp( frac( staticSwitch14_g80980 ) , 0.01 , 0.99 );
				float temp_output_1451_19_g80801 = clampResult129_g80978;
				float3 temp_cast_0 = (temp_output_1451_19_g80801).xxx;
				float3 hsvTorgb260_g80801 = HSVToRGB( float3(temp_output_1451_19_g80801,1.0,1.0) );
				float3 gammaToLinear266_g80801 = GammaToLinearSpace( hsvTorgb260_g80801 );
				float _IsBarkShader347_g80801 = _IsBarkShader;
				float _IsLeafShader360_g80801 = _IsLeafShader;
				float _IsCrossShader342_g80801 = _IsCrossShader;
				float _IsGrassShader341_g80801 = _IsGrassShader;
				float _IsVegetationShader1101_g80801 = _IsVegetationShader;
				float _IsAnyVegetationShader362_g80801 = saturate( ( _IsBarkShader347_g80801 + _IsLeafShader360_g80801 + _IsCrossShader342_g80801 + _IsGrassShader341_g80801 + _IsVegetationShader1101_g80801 ) );
				float3 lerpResult290_g80801 = lerp( temp_cast_0 , gammaToLinear266_g80801 , _IsAnyVegetationShader362_g80801);
				float3 ifLocalVar40_g80974 = 0;
				if( Debug_Index464_g80801 == 16.0 )
				ifLocalVar40_g80974 = lerpResult290_g80801;
				float enc1154_g80801 = v.ase_texcoord.z;
				float2 localDecodeFloatToVector21154_g80801 = DecodeFloatToVector2( enc1154_g80801 );
				float2 break1155_g80801 = localDecodeFloatToVector21154_g80801;
				float ifLocalVar40_g80975 = 0;
				if( Debug_Index464_g80801 == 17.0 )
				ifLocalVar40_g80975 = break1155_g80801.x;
				float ifLocalVar40_g80976 = 0;
				if( Debug_Index464_g80801 == 18.0 )
				ifLocalVar40_g80976 = break1155_g80801.y;
				float3 appendResult60_g80966 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 ifLocalVar40_g80977 = 0;
				if( Debug_Index464_g80801 == 19.0 )
				ifLocalVar40_g80977 = appendResult60_g80966;
				float3 vertexToFrag328_g80801 = ( ( ifLocalVar40_g80807 + ifLocalVar40_g80826 + ifLocalVar40_g80840 + ifLocalVar40_g80822 ) + ( ifLocalVar40_g80958 + ifLocalVar40_g80959 + ifLocalVar40_g80960 + ifLocalVar40_g80961 ) + ( ifLocalVar40_g80967 + ifLocalVar40_g80968 + ifLocalVar40_g80969 ) + ( ifLocalVar40_g80970 + ifLocalVar40_g80971 + ifLocalVar40_g80972 + ifLocalVar40_g80973 ) + ( ifLocalVar40_g80974 + ifLocalVar40_g80975 + ifLocalVar40_g80976 + ifLocalVar40_g80977 ) );
				o.ase_texcoord13.xyz = vertexToFrag328_g80801;
				
				o.ase_texcoord10 = v.ase_texcoord;
				o.ase_texcoord11 = v.texcoord1.xyzw;
				o.ase_texcoord12 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord9.zw = 0;
				o.ase_texcoord13.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
				o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif
				#ifdef LIGHTMAP_ON
				o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						#ifdef VERTEXLIGHT_ON
						o.sh += Shade4PointLights (
							unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
							unity_LightColor[0].rgb, unity_LightColor[1].rgb, unity_LightColor[2].rgb, unity_LightColor[3].rgb,
							unity_4LightAtten0, worldPos, worldNormal);
						#endif
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif

				#if UNITY_VERSION >= 201810 && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_TRANSFER_LIGHTING(o, v.texcoord1.xy);
				#elif defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if UNITY_VERSION >= 201710
						UNITY_TRANSFER_SHADOW(o, v.texcoord1.xy);
					#else
						TRANSFER_SHADOW(o);
					#endif
				#endif

				#ifdef ASE_FOG
					UNITY_TRANSFER_FOG(o,o.pos);
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
					o.screenPos = ComputeScreenPos(o.pos);
				#endif
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif

			fixed4 frag (v2f IN , bool ase_vface : SV_IsFrontFace
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
				) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					UNITY_LIGHT_ATTENUATION(atten, IN, worldPos)
				#else
					half atten = 1;
				#endif
				#if defined(ASE_NEEDS_FRAG_SCREEN_POSITION)
				float4 ScreenPos = IN.screenPos;
				#endif

				float Debug_Type367_g80801 = TVE_DEBUG_Type;
				float4 color646_g80801 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float4 color1359_g80801 = IsGammaSpace() ? float4(0.6196079,0.7686275,0.1490196,0) : float4(0.3419145,0.5520116,0.01938236,0);
				float _IsCollected1458_g80801 = _IsCollected;
				float4 lerpResult1360_g80801 = lerp( color646_g80801 , color1359_g80801 , _IsCollected1458_g80801);
				float customEye676_g80801 = IN.ase_texcoord9.x;
				float temp_output_1371_0_g80801 = saturate( (0.0 + (customEye676_g80801 - 300.0) * (1.0 - 0.0) / (0.0 - 300.0)) );
				float temp_output_1373_0_g80801 = (( temp_output_1371_0_g80801 * temp_output_1371_0_g80801 )*0.5 + 0.5);
				float Shading_Distance655_g80801 = temp_output_1373_0_g80801;
				float2 uv_MainAlbedoTex = IN.ase_texcoord10.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float temp_output_1411_0_g80801 = saturate( ( saturate( ( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a * 1.1 ) ) - SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a ) );
				float customEye1399_g80801 = IN.ase_texcoord9.y;
				float Debug_Clip623_g80801 = TVE_DEBUG_Clip;
				float Shading_Outline1403_g80801 = ( temp_output_1411_0_g80801 * saturate( (0.0 + (customEye1399_g80801 - 30.0) * (1.0 - 0.0) / (0.0 - 30.0)) ) * Debug_Clip623_g80801 );
				float4 Output_Converted717_g80801 = saturate( ( ( lerpResult1360_g80801 * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80824 = 0;
				if( Debug_Type367_g80801 == 0.0 )
				ifLocalVar40_g80824 = Output_Converted717_g80801;
				float4 color466_g80801 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g80801 = _IsBarkShader;
				float4 color469_g80801 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsCrossShader342_g80801 = _IsCrossShader;
				float4 color472_g80801 = IsGammaSpace() ? float4(0.7100264,0.8018868,0.2231666,0) : float4(0.4623997,0.6070304,0.0407874,0);
				float _IsGrassShader341_g80801 = _IsGrassShader;
				float4 color475_g80801 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsLeafShader360_g80801 = _IsLeafShader;
				float4 color478_g80801 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g80801 = _IsPropShader;
				float4 color1114_g80801 = IsGammaSpace() ? float4(0.9716981,0.3162602,0.4816265,0) : float4(0.9368213,0.08154967,0.1974273,0);
				float _IsImpostorShader1110_g80801 = _IsImpostorShader;
				float4 color1117_g80801 = IsGammaSpace() ? float4(0.257921,0.8679245,0.8361252,0) : float4(0.05410501,0.7254258,0.6668791,0);
				float _IsPolygonalShader1112_g80801 = _IsPolygonalShader;
				float4 Output_Shader445_g80801 = saturate( ( ( ( ( color466_g80801 * _IsBarkShader347_g80801 ) + ( color469_g80801 * _IsCrossShader342_g80801 ) + ( color472_g80801 * _IsGrassShader341_g80801 ) + ( color475_g80801 * _IsLeafShader360_g80801 ) + ( color478_g80801 * _IsPropShader346_g80801 ) + ( color1114_g80801 * _IsImpostorShader1110_g80801 ) + ( color1117_g80801 * _IsPolygonalShader1112_g80801 ) ) * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80896 = 0;
				if( Debug_Type367_g80801 == 1.0 )
				ifLocalVar40_g80896 = Output_Shader445_g80801;
				float4 color529_g80801 = IsGammaSpace() ? float4(0.62,0.77,0.15,0) : float4(0.3423916,0.5542217,0.01960665,0);
				float _IsVertexShader1158_g80801 = _IsVertexShader;
				float4 color544_g80801 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g80801 = _IsSimpleShader;
				float4 color521_g80801 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g80801 = _IsStandardShader;
				float4 color1121_g80801 = IsGammaSpace() ? float4(0.9245283,0.8421515,0.1788003,0) : float4(0.8368256,0.677754,0.02687956,0);
				float _IsSubsurfaceShader548_g80801 = _IsSubsurfaceShader;
				float4 Output_Lighting525_g80801 = saturate( ( ( ( ( color529_g80801 * _IsVertexShader1158_g80801 ) + ( color544_g80801 * _IsSimpleShader359_g80801 ) + ( color521_g80801 * _IsStandardShader344_g80801 ) + ( color1121_g80801 * _IsSubsurfaceShader548_g80801 ) ) * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80876 = 0;
				if( Debug_Type367_g80801 == 2.0 )
				ifLocalVar40_g80876 = Output_Lighting525_g80801;
				float4 color1455_g80801 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float3 hsvTorgb1452_g80801 = HSVToRGB( float3(( _IsIdentifier / 1000.0 ),1.0,1.0) );
				float3 gammaToLinear1453_g80801 = GammaToLinearSpace( hsvTorgb1452_g80801 );
				float4 lerpResult1456_g80801 = lerp( color1455_g80801 , float4( gammaToLinear1453_g80801 , 0.0 ) , _IsCollected1458_g80801);
				float3 Output_Sharing1355_g80801 = (lerpResult1456_g80801).rgb;
				float3 ifLocalVar40_g80933 = 0;
				if( Debug_Type367_g80801 == 3.0 )
				ifLocalVar40_g80933 = Output_Sharing1355_g80801;
				float Debug_Index464_g80801 = TVE_DEBUG_Index;
				half2 Main_UVs1219_g80801 = ( ( IN.ase_texcoord10.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode586_g80801 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g80801 );
				float3 appendResult637_g80801 = (float3(tex2DNode586_g80801.r , tex2DNode586_g80801.g , tex2DNode586_g80801.b));
				float3 ifLocalVar40_g80825 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80825 = appendResult637_g80801;
				float ifLocalVar40_g80830 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80830 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g80801 ).a;
				float4 tex2DNode604_g80801 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, Main_UVs1219_g80801 );
				float3 appendResult876_g80801 = (float3(tex2DNode604_g80801.a , tex2DNode604_g80801.g , 1.0));
				float3 gammaToLinear878_g80801 = GammaToLinearSpace( appendResult876_g80801 );
				float3 ifLocalVar40_g80861 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80861 = gammaToLinear878_g80801;
				float ifLocalVar40_g80810 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80810 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).r;
				float ifLocalVar40_g80898 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80898 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).g;
				float ifLocalVar40_g80832 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80832 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).b;
				float ifLocalVar40_g80808 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80808 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).a;
				float2 appendResult1251_g80801 = (float2(IN.ase_texcoord11.z , IN.ase_texcoord11.w));
				float2 Mesh_DetailCoord1254_g80801 = appendResult1251_g80801;
				float2 lerpResult1231_g80801 = lerp( IN.ase_texcoord10.xy , Mesh_DetailCoord1254_g80801 , _DetailCoordMode);
				half2 Second_UVs1234_g80801 = ( ( lerpResult1231_g80801 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				float4 tex2DNode854_g80801 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g80801 );
				float3 appendResult839_g80801 = (float3(tex2DNode854_g80801.r , tex2DNode854_g80801.g , tex2DNode854_g80801.b));
				float3 ifLocalVar40_g80821 = 0;
				if( Debug_Index464_g80801 == 7.0 )
				ifLocalVar40_g80821 = appendResult839_g80801;
				float ifLocalVar40_g80839 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80839 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g80801 ).a;
				float4 tex2DNode841_g80801 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondNormalTex, Second_UVs1234_g80801 );
				float3 appendResult880_g80801 = (float3(tex2DNode841_g80801.a , tex2DNode841_g80801.g , 1.0));
				float3 gammaToLinear879_g80801 = GammaToLinearSpace( appendResult880_g80801 );
				float3 ifLocalVar40_g80884 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80884 = gammaToLinear879_g80801;
				float ifLocalVar40_g80862 = 0;
				if( Debug_Index464_g80801 == 10.0 )
				ifLocalVar40_g80862 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).r;
				float ifLocalVar40_g80829 = 0;
				if( Debug_Index464_g80801 == 11.0 )
				ifLocalVar40_g80829 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).g;
				float ifLocalVar40_g80875 = 0;
				if( Debug_Index464_g80801 == 12.0 )
				ifLocalVar40_g80875 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).b;
				float ifLocalVar40_g80883 = 0;
				if( Debug_Index464_g80801 == 13.0 )
				ifLocalVar40_g80883 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).a;
				half2 Emissive_UVs1245_g80801 = ( ( IN.ase_texcoord10.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				float4 tex2DNode858_g80801 = SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, Emissive_UVs1245_g80801 );
				float3 appendResult867_g80801 = (float3(tex2DNode858_g80801.r , tex2DNode858_g80801.g , tex2DNode858_g80801.b));
				float3 ifLocalVar40_g80828 = 0;
				if( Debug_Index464_g80801 == 14.0 )
				ifLocalVar40_g80828 = appendResult867_g80801;
				float Debug_Min721_g80801 = TVE_DEBUG_Min;
				float temp_output_7_0_g80869 = Debug_Min721_g80801;
				float4 temp_cast_5 = (temp_output_7_0_g80869).xxxx;
				float Debug_Max723_g80801 = TVE_DEBUG_Max;
				float4 Output_Maps561_g80801 = saturate( ( ( ( float4( ( ( ifLocalVar40_g80825 + ifLocalVar40_g80830 + ifLocalVar40_g80861 ) + ( ifLocalVar40_g80810 + ifLocalVar40_g80898 + ifLocalVar40_g80832 + ifLocalVar40_g80808 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g80821 + ifLocalVar40_g80839 + ifLocalVar40_g80884 ) + ( ifLocalVar40_g80862 + ifLocalVar40_g80829 + ifLocalVar40_g80875 + ifLocalVar40_g80883 ) ) * _DetailMode ) , 0.0 ) + ( ( float4( ifLocalVar40_g80828 , 0.0 ) * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_5 ) / ( ( Debug_Max723_g80801 - temp_output_7_0_g80869 ) + 0.01 ) ) );
				float4 ifLocalVar40_g80932 = 0;
				if( Debug_Type367_g80801 == 4.0 )
				ifLocalVar40_g80932 = Output_Maps561_g80801;
				float Resolution44_g80917 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g80917 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80917 = 0;
				if( Resolution44_g80917 <= 256.0 )
				ifLocalVar61_g80917 = color62_g80917;
				float4 color55_g80917 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80917 = 0;
				if( Resolution44_g80917 == 512.0 )
				ifLocalVar56_g80917 = color55_g80917;
				float4 color42_g80917 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80917 = 0;
				if( Resolution44_g80917 == 1024.0 )
				ifLocalVar40_g80917 = color42_g80917;
				float4 color48_g80917 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80917 = 0;
				if( Resolution44_g80917 == 2048.0 )
				ifLocalVar47_g80917 = color48_g80917;
				float4 color51_g80917 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80917 = 0;
				if( Resolution44_g80917 >= 4096.0 )
				ifLocalVar52_g80917 = color51_g80917;
				float4 ifLocalVar40_g80903 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80903 = ( ifLocalVar61_g80917 + ifLocalVar56_g80917 + ifLocalVar40_g80917 + ifLocalVar47_g80917 + ifLocalVar52_g80917 );
				float Resolution44_g80916 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g80916 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80916 = 0;
				if( Resolution44_g80916 <= 256.0 )
				ifLocalVar61_g80916 = color62_g80916;
				float4 color55_g80916 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80916 = 0;
				if( Resolution44_g80916 == 512.0 )
				ifLocalVar56_g80916 = color55_g80916;
				float4 color42_g80916 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80916 = 0;
				if( Resolution44_g80916 == 1024.0 )
				ifLocalVar40_g80916 = color42_g80916;
				float4 color48_g80916 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80916 = 0;
				if( Resolution44_g80916 == 2048.0 )
				ifLocalVar47_g80916 = color48_g80916;
				float4 color51_g80916 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80916 = 0;
				if( Resolution44_g80916 >= 4096.0 )
				ifLocalVar52_g80916 = color51_g80916;
				float4 ifLocalVar40_g80901 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80901 = ( ifLocalVar61_g80916 + ifLocalVar56_g80916 + ifLocalVar40_g80916 + ifLocalVar47_g80916 + ifLocalVar52_g80916 );
				float Resolution44_g80915 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g80915 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80915 = 0;
				if( Resolution44_g80915 <= 256.0 )
				ifLocalVar61_g80915 = color62_g80915;
				float4 color55_g80915 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80915 = 0;
				if( Resolution44_g80915 == 512.0 )
				ifLocalVar56_g80915 = color55_g80915;
				float4 color42_g80915 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80915 = 0;
				if( Resolution44_g80915 == 1024.0 )
				ifLocalVar40_g80915 = color42_g80915;
				float4 color48_g80915 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80915 = 0;
				if( Resolution44_g80915 == 2048.0 )
				ifLocalVar47_g80915 = color48_g80915;
				float4 color51_g80915 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80915 = 0;
				if( Resolution44_g80915 >= 4096.0 )
				ifLocalVar52_g80915 = color51_g80915;
				float4 ifLocalVar40_g80902 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80902 = ( ifLocalVar61_g80915 + ifLocalVar56_g80915 + ifLocalVar40_g80915 + ifLocalVar47_g80915 + ifLocalVar52_g80915 );
				float Resolution44_g80922 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g80922 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80922 = 0;
				if( Resolution44_g80922 <= 256.0 )
				ifLocalVar61_g80922 = color62_g80922;
				float4 color55_g80922 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80922 = 0;
				if( Resolution44_g80922 == 512.0 )
				ifLocalVar56_g80922 = color55_g80922;
				float4 color42_g80922 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80922 = 0;
				if( Resolution44_g80922 == 1024.0 )
				ifLocalVar40_g80922 = color42_g80922;
				float4 color48_g80922 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80922 = 0;
				if( Resolution44_g80922 == 2048.0 )
				ifLocalVar47_g80922 = color48_g80922;
				float4 color51_g80922 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80922 = 0;
				if( Resolution44_g80922 >= 4096.0 )
				ifLocalVar52_g80922 = color51_g80922;
				float4 ifLocalVar40_g80909 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80909 = ( ifLocalVar61_g80922 + ifLocalVar56_g80922 + ifLocalVar40_g80922 + ifLocalVar47_g80922 + ifLocalVar52_g80922 );
				float Resolution44_g80921 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g80921 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80921 = 0;
				if( Resolution44_g80921 <= 256.0 )
				ifLocalVar61_g80921 = color62_g80921;
				float4 color55_g80921 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80921 = 0;
				if( Resolution44_g80921 == 512.0 )
				ifLocalVar56_g80921 = color55_g80921;
				float4 color42_g80921 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80921 = 0;
				if( Resolution44_g80921 == 1024.0 )
				ifLocalVar40_g80921 = color42_g80921;
				float4 color48_g80921 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80921 = 0;
				if( Resolution44_g80921 == 2048.0 )
				ifLocalVar47_g80921 = color48_g80921;
				float4 color51_g80921 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80921 = 0;
				if( Resolution44_g80921 >= 4096.0 )
				ifLocalVar52_g80921 = color51_g80921;
				float4 ifLocalVar40_g80907 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80907 = ( ifLocalVar61_g80921 + ifLocalVar56_g80921 + ifLocalVar40_g80921 + ifLocalVar47_g80921 + ifLocalVar52_g80921 );
				float Resolution44_g80923 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g80923 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80923 = 0;
				if( Resolution44_g80923 <= 256.0 )
				ifLocalVar61_g80923 = color62_g80923;
				float4 color55_g80923 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80923 = 0;
				if( Resolution44_g80923 == 512.0 )
				ifLocalVar56_g80923 = color55_g80923;
				float4 color42_g80923 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80923 = 0;
				if( Resolution44_g80923 == 1024.0 )
				ifLocalVar40_g80923 = color42_g80923;
				float4 color48_g80923 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80923 = 0;
				if( Resolution44_g80923 == 2048.0 )
				ifLocalVar47_g80923 = color48_g80923;
				float4 color51_g80923 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80923 = 0;
				if( Resolution44_g80923 >= 4096.0 )
				ifLocalVar52_g80923 = color51_g80923;
				float4 ifLocalVar40_g80908 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80908 = ( ifLocalVar61_g80923 + ifLocalVar56_g80923 + ifLocalVar40_g80923 + ifLocalVar47_g80923 + ifLocalVar52_g80923 );
				float Resolution44_g80920 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g80920 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80920 = 0;
				if( Resolution44_g80920 <= 256.0 )
				ifLocalVar61_g80920 = color62_g80920;
				float4 color55_g80920 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80920 = 0;
				if( Resolution44_g80920 == 512.0 )
				ifLocalVar56_g80920 = color55_g80920;
				float4 color42_g80920 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80920 = 0;
				if( Resolution44_g80920 == 1024.0 )
				ifLocalVar40_g80920 = color42_g80920;
				float4 color48_g80920 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80920 = 0;
				if( Resolution44_g80920 == 2048.0 )
				ifLocalVar47_g80920 = color48_g80920;
				float4 color51_g80920 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80920 = 0;
				if( Resolution44_g80920 >= 4096.0 )
				ifLocalVar52_g80920 = color51_g80920;
				float4 ifLocalVar40_g80910 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80910 = ( ifLocalVar61_g80920 + ifLocalVar56_g80920 + ifLocalVar40_g80920 + ifLocalVar47_g80920 + ifLocalVar52_g80920 );
				float4 Output_Resolution737_g80801 = saturate( ( ( ( ( ifLocalVar40_g80903 + ifLocalVar40_g80901 + ifLocalVar40_g80902 ) + ( ifLocalVar40_g80909 + ifLocalVar40_g80907 + ifLocalVar40_g80908 ) + ifLocalVar40_g80910 ) * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80929 = 0;
				if( Debug_Type367_g80801 == 5.0 )
				ifLocalVar40_g80929 = Output_Resolution737_g80801;
				float2 UVs72_g80928 = Main_UVs1219_g80801;
				float Resolution44_g80928 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g80928 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80928 * ( Resolution44_g80928 / 8.0 ) ) );
				float4 lerpResult78_g80928 = lerp( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ) , tex2DNode77_g80928 , tex2DNode77_g80928.a);
				float4 ifLocalVar40_g80906 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80906 = lerpResult78_g80928;
				float2 uv_MainNormalTex = IN.ase_texcoord10.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float2 UVs72_g80919 = Main_UVs1219_g80801;
				float Resolution44_g80919 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 tex2DNode77_g80919 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80919 * ( Resolution44_g80919 / 8.0 ) ) );
				float4 lerpResult78_g80919 = lerp( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, uv_MainNormalTex ) , tex2DNode77_g80919 , tex2DNode77_g80919.a);
				float4 ifLocalVar40_g80904 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80904 = lerpResult78_g80919;
				float2 uv_MainMaskTex = IN.ase_texcoord10.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float2 UVs72_g80918 = Main_UVs1219_g80801;
				float Resolution44_g80918 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 tex2DNode77_g80918 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80918 * ( Resolution44_g80918 / 8.0 ) ) );
				float4 lerpResult78_g80918 = lerp( SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, uv_MainMaskTex ) , tex2DNode77_g80918 , tex2DNode77_g80918.a);
				float4 ifLocalVar40_g80905 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80905 = lerpResult78_g80918;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord10.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float2 UVs72_g80926 = Second_UVs1234_g80801;
				float Resolution44_g80926 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g80926 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80926 * ( Resolution44_g80926 / 8.0 ) ) );
				float4 lerpResult78_g80926 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g80926 , tex2DNode77_g80926.a);
				float4 ifLocalVar40_g80913 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80913 = lerpResult78_g80926;
				float2 uv_SecondMaskTex = IN.ase_texcoord10.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float2 UVs72_g80925 = Second_UVs1234_g80801;
				float Resolution44_g80925 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 tex2DNode77_g80925 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80925 * ( Resolution44_g80925 / 8.0 ) ) );
				float4 lerpResult78_g80925 = lerp( SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, uv_SecondMaskTex ) , tex2DNode77_g80925 , tex2DNode77_g80925.a);
				float4 ifLocalVar40_g80911 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80911 = lerpResult78_g80925;
				float2 UVs72_g80927 = Second_UVs1234_g80801;
				float Resolution44_g80927 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g80927 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80927 * ( Resolution44_g80927 / 8.0 ) ) );
				float4 lerpResult78_g80927 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g80927 , tex2DNode77_g80927.a);
				float4 ifLocalVar40_g80912 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80912 = lerpResult78_g80927;
				float2 uv_EmissiveTex = IN.ase_texcoord10.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float2 UVs72_g80924 = Emissive_UVs1245_g80801;
				float Resolution44_g80924 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 tex2DNode77_g80924 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80924 * ( Resolution44_g80924 / 8.0 ) ) );
				float4 lerpResult78_g80924 = lerp( SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, uv_EmissiveTex ) , tex2DNode77_g80924 , tex2DNode77_g80924.a);
				float4 ifLocalVar40_g80914 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80914 = lerpResult78_g80924;
				float4 Output_MipLevel1284_g80801 = ( ( ifLocalVar40_g80906 + ifLocalVar40_g80904 + ifLocalVar40_g80905 ) + ( ifLocalVar40_g80913 + ifLocalVar40_g80911 + ifLocalVar40_g80912 ) + ifLocalVar40_g80914 );
				float4 ifLocalVar40_g80930 = 0;
				if( Debug_Type367_g80801 == 6.0 )
				ifLocalVar40_g80930 = Output_MipLevel1284_g80801;
				float3 WorldPosition893_g80801 = worldPos;
				half3 Input_Position419_g80935 = WorldPosition893_g80801;
				float Input_MotionScale287_g80935 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g80935 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g80935 = (( Input_Position419_g80935 * Input_MotionScale287_g80935 * Global_NoiseScale448_g80935 * 0.0075 )).xz;
				float2 temp_output_447_0_g80942 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Wind_DirectionWS1031_g80801 = temp_output_447_0_g80942;
				half2 Input_DirectionWS423_g80935 = Wind_DirectionWS1031_g80801;
				half Input_MotionSpeed62_g80935 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g80935 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g80935 = _MotionVariation_10;
				float4x4 break19_g80945 = unity_ObjectToWorld;
				float3 appendResult20_g80945 = (float3(break19_g80945[ 0 ][ 3 ] , break19_g80945[ 1 ][ 3 ] , break19_g80945[ 2 ][ 3 ]));
				float3 appendResult60_g80944 = (float3(IN.ase_texcoord12.x , IN.ase_texcoord12.z , IN.ase_texcoord12.y));
				float3 temp_output_122_0_g80945 = ( appendResult60_g80944 * _VertexPivotMode );
				float3 PivotsOnly105_g80945 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g80945 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g80946 = ( appendResult20_g80945 + PivotsOnly105_g80945 );
				half3 WorldData19_g80946 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g80946 = WorldData19_g80946;
				#else
				float3 staticSwitch14_g80946 = ObjectData20_g80946;
				#endif
				float3 temp_output_114_0_g80945 = staticSwitch14_g80946;
				half3 ObjectData20_g80934 = temp_output_114_0_g80945;
				half3 WorldData19_g80934 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g80934 = WorldData19_g80934;
				#else
				float3 staticSwitch14_g80934 = ObjectData20_g80934;
				#endif
				float3 ObjectPosition890_g80801 = staticSwitch14_g80934;
				float3 break111_g80953 = ObjectPosition890_g80801;
				half Input_DynamicMode120_g80953 = _VertexDynamicMode;
				float Postion_Sum142_g80953 = ( ( break111_g80953.x + break111_g80953.y + break111_g80953.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g80953 ) );
				half Input_Variation124_g80953 = IN.ase_color.r;
				half ObjectData20_g80955 = ( Postion_Sum142_g80953 + Input_Variation124_g80953 );
				half WorldData19_g80955 = Input_Variation124_g80953;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g80955 = WorldData19_g80955;
				#else
				float staticSwitch14_g80955 = ObjectData20_g80955;
				#endif
				float clampResult129_g80953 = clamp( frac( staticSwitch14_g80955 ) , 0.01 , 0.99 );
				half Global_MeshVariation1176_g80801 = clampResult129_g80953;
				half Input_GlobalMeshVariation569_g80935 = Global_MeshVariation1176_g80801;
				half Input_ObjectVariation694_g80935 = 0.0;
				half Input_GlobalObjectVariation692_g80935 = 0.0;
				float temp_output_630_0_g80935 = ( ( ( _Time.y * Input_MotionSpeed62_g80935 * Global_NoiseSpeed449_g80935 ) + ( Input_MotionVariation284_g80935 * Input_GlobalMeshVariation569_g80935 ) + ( Input_ObjectVariation694_g80935 * Input_GlobalObjectVariation692_g80935 ) ) * 0.03 );
				float temp_output_607_0_g80935 = frac( temp_output_630_0_g80935 );
				float4 lerpResult590_g80935 = lerp( SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g80935 + ( -Input_DirectionWS423_g80935 * temp_output_607_0_g80935 ) ) ) , SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g80935 + ( -Input_DirectionWS423_g80935 * frac( ( temp_output_630_0_g80935 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_607_0_g80935 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g80935 = ((lerpResult590_g80935).rg*2.0 + -1.0);
				float2 break650_g80935 = temp_output_645_0_g80935;
				float3 appendResult649_g80935 = (float3(break650_g80935.x , 0.0 , break650_g80935.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
				half2 Motion_Noise915_g80801 = (( mul( unity_WorldToObject, float4( appendResult649_g80935 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				float3 appendResult1180_g80801 = (float3(Motion_Noise915_g80801 , 0.0));
				float3 ifLocalVar40_g80811 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80811 = appendResult1180_g80801;
				float Debug_Layer885_g80801 = TVE_DEBUG_Layer;
				float temp_output_82_0_g80856 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80856 = TVE_ColorsCoords;
				half2 UV94_g80856 = ( (temp_output_91_19_g80856).zw + ( (temp_output_91_19_g80856).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode83_g80856 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g80856,temp_output_82_0_g80856), 0.0 );
				float4 temp_output_92_86_g80856 = TVE_ColorsParams;
				float4 ifLocalVar18_g80860 = 0;
				UNITY_BRANCH 
				if( TVE_ColorsUsage[(int)temp_output_82_0_g80856] > 0.5 )
				ifLocalVar18_g80860 = tex2DArrayNode83_g80856;
				else if( TVE_ColorsUsage[(int)temp_output_82_0_g80856] < 0.5 )
				ifLocalVar18_g80860 = temp_output_92_86_g80856;
				float3 ifLocalVar40_g80827 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80827 = (ifLocalVar18_g80860).rgb;
				float temp_output_82_0_g80841 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80841 = TVE_ColorsCoords;
				half2 UV94_g80841 = ( (temp_output_91_19_g80841).zw + ( (temp_output_91_19_g80841).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode83_g80841 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g80841,temp_output_82_0_g80841), 0.0 );
				float4 temp_output_92_86_g80841 = TVE_ColorsParams;
				float4 ifLocalVar18_g80845 = 0;
				UNITY_BRANCH 
				if( TVE_ColorsUsage[(int)temp_output_82_0_g80841] > 0.5 )
				ifLocalVar18_g80845 = tex2DArrayNode83_g80841;
				else if( TVE_ColorsUsage[(int)temp_output_82_0_g80841] < 0.5 )
				ifLocalVar18_g80845 = temp_output_92_86_g80841;
				float ifLocalVar40_g80838 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80838 = saturate( (ifLocalVar18_g80845).a );
				float temp_output_84_0_g80851 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80851 = TVE_ExtrasCoords;
				half2 UV96_g80851 = ( (temp_output_93_19_g80851).zw + ( (temp_output_93_19_g80851).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80851 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80851,temp_output_84_0_g80851), 0.0 );
				float4 temp_output_94_85_g80851 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80855 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80851] > 0.5 )
				ifLocalVar18_g80855 = tex2DArrayNode48_g80851;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80851] < 0.5 )
				ifLocalVar18_g80855 = temp_output_94_85_g80851;
				float ifLocalVar40_g80819 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80819 = (ifLocalVar18_g80855).r;
				float temp_output_84_0_g80802 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80802 = TVE_ExtrasCoords;
				half2 UV96_g80802 = ( (temp_output_93_19_g80802).zw + ( (temp_output_93_19_g80802).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80802 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80802,temp_output_84_0_g80802), 0.0 );
				float4 temp_output_94_85_g80802 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80806 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80802] > 0.5 )
				ifLocalVar18_g80806 = tex2DArrayNode48_g80802;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80802] < 0.5 )
				ifLocalVar18_g80806 = temp_output_94_85_g80802;
				float ifLocalVar40_g80897 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80897 = (ifLocalVar18_g80806).g;
				float temp_output_84_0_g80863 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80863 = TVE_ExtrasCoords;
				half2 UV96_g80863 = ( (temp_output_93_19_g80863).zw + ( (temp_output_93_19_g80863).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80863 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80863,temp_output_84_0_g80863), 0.0 );
				float4 temp_output_94_85_g80863 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80867 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80863] > 0.5 )
				ifLocalVar18_g80867 = tex2DArrayNode48_g80863;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80863] < 0.5 )
				ifLocalVar18_g80867 = temp_output_94_85_g80863;
				float ifLocalVar40_g80820 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80820 = (ifLocalVar18_g80867).b;
				float temp_output_84_0_g80885 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80885 = TVE_ExtrasCoords;
				half2 UV96_g80885 = ( (temp_output_93_19_g80885).zw + ( (temp_output_93_19_g80885).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80885,temp_output_84_0_g80885), 0.0 );
				float4 temp_output_94_85_g80885 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80889 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80885] > 0.5 )
				ifLocalVar18_g80889 = tex2DArrayNode48_g80885;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80885] < 0.5 )
				ifLocalVar18_g80889 = temp_output_94_85_g80885;
				float ifLocalVar40_g80813 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80813 = saturate( (ifLocalVar18_g80889).a );
				float temp_output_84_0_g80846 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80846 = TVE_MotionCoords;
				half2 UV94_g80846 = ( (temp_output_91_19_g80846).zw + ( (temp_output_91_19_g80846).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80846 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80846,temp_output_84_0_g80846), 0.0 );
				float4 temp_output_112_19_g80846 = TVE_MotionParams;
				float4 ifLocalVar18_g80850 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g80846] > 0.5 )
				ifLocalVar18_g80850 = tex2DArrayNode50_g80846;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g80846] < 0.5 )
				ifLocalVar18_g80850 = temp_output_112_19_g80846;
				float3 appendResult1012_g80801 = (float3((ifLocalVar18_g80850).rg , 0.0));
				float3 ifLocalVar40_g80809 = 0;
				if( Debug_Index464_g80801 == 7.0 )
				ifLocalVar40_g80809 = appendResult1012_g80801;
				float temp_output_84_0_g80870 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80870 = TVE_MotionCoords;
				half2 UV94_g80870 = ( (temp_output_91_19_g80870).zw + ( (temp_output_91_19_g80870).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80870 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80870,temp_output_84_0_g80870), 0.0 );
				float4 temp_output_112_19_g80870 = TVE_MotionParams;
				float4 ifLocalVar18_g80874 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g80870] > 0.5 )
				ifLocalVar18_g80874 = tex2DArrayNode50_g80870;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g80870] < 0.5 )
				ifLocalVar18_g80874 = temp_output_112_19_g80870;
				float ifLocalVar40_g80823 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80823 = (ifLocalVar18_g80874).b;
				float temp_output_84_0_g80877 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80877 = TVE_MotionCoords;
				half2 UV94_g80877 = ( (temp_output_91_19_g80877).zw + ( (temp_output_91_19_g80877).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80877,temp_output_84_0_g80877), 0.0 );
				float4 temp_output_112_19_g80877 = TVE_MotionParams;
				float4 ifLocalVar18_g80881 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g80877] > 0.5 )
				ifLocalVar18_g80881 = tex2DArrayNode50_g80877;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g80877] < 0.5 )
				ifLocalVar18_g80881 = temp_output_112_19_g80877;
				float ifLocalVar40_g80882 = 0;
				if( Debug_Index464_g80801 == 9.0 )
				ifLocalVar40_g80882 = saturate( (ifLocalVar18_g80881).a );
				float temp_output_84_0_g80891 = Debug_Layer885_g80801;
				float4 temp_output_94_19_g80891 = TVE_VertexCoords;
				half2 UV97_g80891 = ( (temp_output_94_19_g80891).zw + ( (temp_output_94_19_g80891).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80891 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g80891,temp_output_84_0_g80891), 0.0 );
				float4 temp_output_111_19_g80891 = TVE_VertexParams;
				float4 ifLocalVar18_g80895 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g80891] > 0.5 )
				ifLocalVar18_g80895 = tex2DArrayNode50_g80891;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g80891] < 0.5 )
				ifLocalVar18_g80895 = temp_output_111_19_g80891;
				float ifLocalVar40_g80831 = 0;
				if( Debug_Index464_g80801 == 10.0 )
				ifLocalVar40_g80831 = saturate( (ifLocalVar18_g80895).a );
				float temp_output_7_0_g80900 = Debug_Min721_g80801;
				float3 temp_cast_30 = (temp_output_7_0_g80900).xxx;
				float3 Output_Globals888_g80801 = saturate( ( ( ( ifLocalVar40_g80811 + ( ifLocalVar40_g80827 + ifLocalVar40_g80838 ) + ( ifLocalVar40_g80819 + ifLocalVar40_g80897 + ifLocalVar40_g80820 + ifLocalVar40_g80813 ) + ( ifLocalVar40_g80809 + ifLocalVar40_g80823 + ifLocalVar40_g80882 ) + ( ifLocalVar40_g80831 + 0.0 ) ) - temp_cast_30 ) / ( ( Debug_Max723_g80801 - temp_output_7_0_g80900 ) + 0.01 ) ) );
				float3 ifLocalVar40_g80931 = 0;
				if( Debug_Type367_g80801 == 7.0 )
				ifLocalVar40_g80931 = Output_Globals888_g80801;
				float3 vertexToFrag328_g80801 = IN.ase_texcoord13.xyz;
				float4 color1016_g80801 = IsGammaSpace() ? float4(0.5831653,0.6037736,0.2135992,0) : float4(0.2992498,0.3229691,0.03750122,0);
				float4 color1017_g80801 = IsGammaSpace() ? float4(0.8117647,0.3488252,0.2627451,0) : float4(0.6239604,0.0997834,0.05612849,0);
				float4 switchResult1015_g80801 = (((ase_vface>0)?(color1016_g80801):(color1017_g80801)));
				float3 ifLocalVar40_g80812 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80812 = (switchResult1015_g80801).rgb;
				float temp_output_7_0_g80899 = Debug_Min721_g80801;
				float3 temp_cast_31 = (temp_output_7_0_g80899).xxx;
				float3 Output_Mesh316_g80801 = saturate( ( ( ( vertexToFrag328_g80801 + ifLocalVar40_g80812 ) - temp_cast_31 ) / ( ( Debug_Max723_g80801 - temp_output_7_0_g80899 ) + 0.01 ) ) );
				float3 ifLocalVar40_g80957 = 0;
				if( Debug_Type367_g80801 == 10.0 )
				ifLocalVar40_g80957 = Output_Mesh316_g80801;
				float4 temp_output_459_0_g80801 = ( ( ifLocalVar40_g80824 + ifLocalVar40_g80896 + ifLocalVar40_g80876 + float4( ifLocalVar40_g80933 , 0.0 ) ) + ( ifLocalVar40_g80932 + ifLocalVar40_g80929 + ifLocalVar40_g80930 ) + float4( ( ifLocalVar40_g80931 + ifLocalVar40_g80957 ) , 0.0 ) );
				float4 color690_g80801 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float _IsTVEShader647_g80801 = _IsTVEShader;
				float4 lerpResult689_g80801 = lerp( color690_g80801 , temp_output_459_0_g80801 , _IsTVEShader647_g80801);
				float Debug_Filter322_g80801 = TVE_DEBUG_Filter;
				float4 lerpResult326_g80801 = lerp( temp_output_459_0_g80801 , lerpResult689_g80801 , Debug_Filter322_g80801);
				float lerpResult622_g80801 = lerp( 1.0 , SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g80801 * _RenderClip ));
				clip( lerpResult622_g80801 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = lerpResult326_g80801.rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				fixed4 c = 0;
				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = _LightColor0.rgb;
				gi.light.dir = lightDir;

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI(o, giInput, gi);
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					c += LightingStandardSpecular (o, worldViewDir, gi);
				#else
					c += LightingStandard( o, worldViewDir, gi );
				#endif

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;
					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 transmission = max(0 , -dot(o.Normal, gi.light.dir)) * lightAtten * Transmission;
					c.rgb += o.Albedo * transmission;
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#ifdef DIRECTIONAL
						float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, shadow );
					#else
						float3 lightAtten = gi.light.color;
					#endif
					half3 lightDir = gi.light.dir + o.Normal * normal;
					half transVdotL = pow( saturate( dot( worldViewDir, -lightDir ) ), scattering );
					half3 translucency = lightAtten * (transVdotL * direct + gi.indirect.diffuse * ambient) * Translucency;
					c.rgb += o.Albedo * translucency * strength;
				}
				#endif

				//#ifdef ASE_REFRACTION
				//	float4 projScreenPos = ScreenPos / ScreenPos.w;
				//	float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, WorldNormal ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
				//	projScreenPos.xy += refractionOffset.xy;
				//	float3 refraction = UNITY_SAMPLE_SCREENSPACE_TEXTURE( _GrabTexture, projScreenPos ) * RefractionColor;
				//	color.rgb = lerp( refraction, color.rgb, color.a );
				//	color.a = 1;
				//#endif

				c.rgb += o.Emission;

				#ifdef ASE_FOG
					UNITY_APPLY_FOG(IN.fogCoord, c);
				#endif
				return c;
			}
			ENDCG
		}

		
		Pass
		{
			
			Name "Deferred"
			Tags { "LightMode"="Deferred" }

			AlphaToMask Off

			CGPROGRAM
			#define ASE_NO_AMBIENT 1
			#pragma multi_compile_instancing
			#define ASE_USING_SAMPLING_MACROS 1

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#pragma multi_compile_prepassfinal
			#ifndef UNITY_PASS_DEFERRED
				#define UNITY_PASS_DEFERRED
			#endif
			#include "HLSLSupport.cginc"
			#if !defined( UNITY_INSTANCED_LOD_FADE )
				#define UNITY_INSTANCED_LOD_FADE
			#endif
			#if !defined( UNITY_INSTANCED_SH )
				#define UNITY_INSTANCED_SH
			#endif
			#if !defined( UNITY_INSTANCED_LIGHTMAPSTS )
				#define UNITY_INSTANCED_LIGHTMAPSTS
			#endif
			#include "UnityShaderVariables.cginc"
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#if defined(SHADER_API_D3D11) || defined(SHADER_API_XBOXONE) || defined(UNITY_COMPILER_HLSLCC) || defined(SHADER_API_PSSL) || (defined(SHADER_TARGET_SURFACE_ANALYSIS) && !defined(SHADER_TARGET_SURFACE_ANALYSIS_MOJOSHADER))//ASE Sampler Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex.Sample(samplerTex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex.SampleBias(samplerTex,coord,bias)
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex.SampleGrad(samplerTex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplerTex,coord,lod) tex.SampleLevel(samplerTex,coord, lod)
			#else//ASE Sampling Macros
			#define SAMPLE_TEXTURE2D(tex,samplerTex,coord) tex2D(tex,coord)
			#define SAMPLE_TEXTURE2D_LOD(tex,samplerTex,coord,lod) tex2Dlod(tex,float4(coord,0,lod))
			#define SAMPLE_TEXTURE2D_BIAS(tex,samplerTex,coord,bias) tex2Dbias(tex,float4(coord,0,bias))
			#define SAMPLE_TEXTURE2D_GRAD(tex,samplerTex,coord,ddx,ddy) tex2Dgrad(tex,coord,ddx,ddy)
			#define SAMPLE_TEXTURE2D_ARRAY_LOD(tex,samplertex,coord,lod) tex2DArraylod(tex, float4(coord,lod))
			#endif//ASE Sampling Macros
			

			struct appdata {
				float4 vertex : POSITION;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				#if UNITY_VERSION >= 201810
					UNITY_POSITION(pos);
				#else
					float4 pos : SV_POSITION;
				#endif
				float4 lmap : TEXCOORD2;
				#ifndef LIGHTMAP_ON
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						half3 sh : TEXCOORD3;
					#endif
				#else
					#ifdef DIRLIGHTMAP_OFF
						float4 lmapFadePos : TEXCOORD4;
					#endif
				#endif
				float4 tSpace0 : TEXCOORD5;
				float4 tSpace1 : TEXCOORD6;
				float4 tSpace2 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_texcoord11 : TEXCOORD11;
				float4 ase_color : COLOR;
				float4 ase_texcoord12 : TEXCOORD12;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			#ifdef LIGHTMAP_ON
			float4 unity_LightmapFade;
			#endif
			fixed4 unity_Ambient;
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			uniform half _Banner;
			uniform half _Message;
			uniform float _IsSimpleShader;
			uniform float _IsVertexShader;
			uniform half _IsTVEShader;
			uniform half TVE_DEBUG_Type;
			uniform float _IsCollected;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainAlbedoTex);
			uniform float4 _MainAlbedoTex_ST;
			SamplerState sampler_MainAlbedoTex;
			uniform half TVE_DEBUG_Clip;
			uniform float _IsBarkShader;
			uniform float _IsCrossShader;
			uniform float _IsGrassShader;
			uniform float _IsLeafShader;
			uniform float _IsPropShader;
			uniform float _IsImpostorShader;
			uniform float _IsPolygonalShader;
			uniform float _IsStandardShader;
			uniform float _IsSubsurfaceShader;
			uniform float _IsIdentifier;
			uniform half TVE_DEBUG_Index;
			uniform half4 _MainUVs;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainNormalTex);
			SamplerState sampler_MainNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_MainMaskTex);
			SamplerState sampler_MainMaskTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondAlbedoTex);
			uniform half _DetailCoordMode;
			uniform half4 _SecondUVs;
			SamplerState sampler_SecondAlbedoTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondNormalTex);
			SamplerState sampler_SecondNormalTex;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_SecondMaskTex);
			SamplerState sampler_SecondMaskTex;
			uniform float _DetailMode;
			UNITY_DECLARE_TEX2D_NOSAMPLER(_EmissiveTex);
			uniform half4 _EmissiveUVs;
			SamplerState sampler_EmissiveTex;
			uniform float4 _EmissiveColor;
			uniform float _EmissiveCat;
			uniform half TVE_DEBUG_Min;
			uniform half TVE_DEBUG_Max;
			float4 _MainAlbedoTex_TexelSize;
			float4 _MainNormalTex_TexelSize;
			float4 _MainMaskTex_TexelSize;
			float4 _SecondAlbedoTex_TexelSize;
			float4 _SecondMaskTex_TexelSize;
			float4 _EmissiveTex_TexelSize;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_DEBUG_MipTex);
			SamplerState samplerTVE_DEBUG_MipTex;
			uniform float4 _MainNormalTex_ST;
			uniform float4 _MainMaskTex_ST;
			uniform float4 _SecondAlbedoTex_ST;
			uniform float4 _SecondMaskTex_ST;
			uniform float4 _EmissiveTex_ST;
			UNITY_DECLARE_TEX2D_NOSAMPLER(TVE_NoiseTex);
			uniform float _MotionScale_10;
			uniform half4 TVE_NoiseParams;
			uniform half4 TVE_MotionParams;
			uniform float _MotionSpeed_10;
			uniform float _MotionVariation_10;
			uniform half _VertexPivotMode;
			uniform half _VertexDynamicMode;
			SamplerState sampler_Linear_Repeat;
			uniform half TVE_DEBUG_Layer;
			uniform float TVE_ColorsUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ColorsTex);
			uniform half4 TVE_ColorsCoords;
			SamplerState sampler_Linear_Clamp;
			uniform half4 TVE_ColorsParams;
			uniform float TVE_ExtrasUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_ExtrasTex);
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_ExtrasParams;
			uniform float TVE_MotionUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_MotionTex);
			uniform half4 TVE_MotionCoords;
			uniform float TVE_VertexUsage[10];
			UNITY_DECLARE_TEX2DARRAY_NOSAMPLER(TVE_VertexTex);
			uniform half4 TVE_VertexCoords;
			uniform half4 TVE_VertexParams;
			uniform float _IsVegetationShader;
			uniform half TVE_DEBUG_Filter;
			uniform float _RenderClip;
			uniform float _Cutoff;
			uniform float _IsElementShader;
			uniform float _IsHelperShader;


			float3 HSVToRGB( float3 c )
			{
				float4 K = float4( 1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0 );
				float3 p = abs( frac( c.xxx + K.xyz ) * 6.0 - K.www );
				return c.z * lerp( K.xxx, saturate( p - K.xxx ), c.y );
			}
			
			float2 DecodeFloatToVector2( float enc )
			{
				float2 result ;
				result.y = enc % 2048;
				result.x = floor(enc / 2048);
				return result / (2048 - 1);
			}
			

			v2f VertexFunction (appdata v  ) {
				UNITY_SETUP_INSTANCE_ID(v);
				v2f o;
				UNITY_INITIALIZE_OUTPUT(v2f,o);
				UNITY_TRANSFER_INSTANCE_ID(v,o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float3 customSurfaceDepth676_g80801 = v.vertex.xyz;
				float customEye676_g80801 = -UnityObjectToViewPos( customSurfaceDepth676_g80801 ).z;
				o.ase_texcoord8.x = customEye676_g80801;
				float3 customSurfaceDepth1399_g80801 = v.vertex.xyz;
				float customEye1399_g80801 = -UnityObjectToViewPos( customSurfaceDepth1399_g80801 ).z;
				o.ase_texcoord8.y = customEye1399_g80801;
				float Debug_Index464_g80801 = TVE_DEBUG_Index;
				float3 ifLocalVar40_g80807 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80807 = saturate( v.vertex.xyz );
				float3 ifLocalVar40_g80826 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80826 = v.normal;
				float3 ifLocalVar40_g80840 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80840 = v.tangent.xyz;
				float ifLocalVar40_g80822 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80822 = saturate( v.tangent.w );
				float ifLocalVar40_g80958 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80958 = v.ase_color.r;
				float ifLocalVar40_g80959 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80959 = v.ase_color.g;
				float ifLocalVar40_g80960 = 0;
				if( Debug_Index464_g80801 == 7.0 )
				ifLocalVar40_g80960 = v.ase_color.b;
				float ifLocalVar40_g80961 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80961 = v.ase_color.a;
				float3 appendResult1147_g80801 = (float3(v.ase_texcoord.x , v.ase_texcoord.y , 0.0));
				float3 ifLocalVar40_g80967 = 0;
				if( Debug_Index464_g80801 == 9.0 )
				ifLocalVar40_g80967 = appendResult1147_g80801;
				float3 appendResult1148_g80801 = (float3(v.texcoord1.xyzw.x , v.texcoord1.xyzw.y , 0.0));
				float3 ifLocalVar40_g80968 = 0;
				if( Debug_Index464_g80801 == 10.0 )
				ifLocalVar40_g80968 = appendResult1148_g80801;
				float3 appendResult1149_g80801 = (float3(v.texcoord1.xyzw.z , v.texcoord1.xyzw.w , 0.0));
				float3 ifLocalVar40_g80969 = 0;
				if( Debug_Index464_g80801 == 11.0 )
				ifLocalVar40_g80969 = appendResult1149_g80801;
				float3 break111_g80962 = float3( 0,0,0 );
				half Input_DynamicMode120_g80962 = 0.0;
				float Postion_Sum142_g80962 = ( ( break111_g80962.x + break111_g80962.y + break111_g80962.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g80962 ) );
				half Input_Variation124_g80962 = v.ase_color.r;
				half ObjectData20_g80964 = ( Postion_Sum142_g80962 + Input_Variation124_g80962 );
				half WorldData19_g80964 = Input_Variation124_g80962;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g80964 = WorldData19_g80964;
				#else
				float staticSwitch14_g80964 = ObjectData20_g80964;
				#endif
				float clampResult129_g80962 = clamp( frac( staticSwitch14_g80964 ) , 0.01 , 0.99 );
				float ifLocalVar40_g80970 = 0;
				if( Debug_Index464_g80801 == 12.0 )
				ifLocalVar40_g80970 = clampResult129_g80962;
				float ifLocalVar40_g80971 = 0;
				if( Debug_Index464_g80801 == 13.0 )
				ifLocalVar40_g80971 = v.ase_color.g;
				float ifLocalVar40_g80972 = 0;
				if( Debug_Index464_g80801 == 14.0 )
				ifLocalVar40_g80972 = v.ase_color.b;
				float ifLocalVar40_g80973 = 0;
				if( Debug_Index464_g80801 == 15.0 )
				ifLocalVar40_g80973 = v.ase_color.a;
				float3 break111_g80978 = float3( 0,0,0 );
				half Input_DynamicMode120_g80978 = 0.0;
				float Postion_Sum142_g80978 = ( ( break111_g80978.x + break111_g80978.y + break111_g80978.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g80978 ) );
				half Input_Variation124_g80978 = v.ase_color.r;
				half ObjectData20_g80980 = ( Postion_Sum142_g80978 + Input_Variation124_g80978 );
				half WorldData19_g80980 = Input_Variation124_g80978;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g80980 = WorldData19_g80980;
				#else
				float staticSwitch14_g80980 = ObjectData20_g80980;
				#endif
				float clampResult129_g80978 = clamp( frac( staticSwitch14_g80980 ) , 0.01 , 0.99 );
				float temp_output_1451_19_g80801 = clampResult129_g80978;
				float3 temp_cast_0 = (temp_output_1451_19_g80801).xxx;
				float3 hsvTorgb260_g80801 = HSVToRGB( float3(temp_output_1451_19_g80801,1.0,1.0) );
				float3 gammaToLinear266_g80801 = GammaToLinearSpace( hsvTorgb260_g80801 );
				float _IsBarkShader347_g80801 = _IsBarkShader;
				float _IsLeafShader360_g80801 = _IsLeafShader;
				float _IsCrossShader342_g80801 = _IsCrossShader;
				float _IsGrassShader341_g80801 = _IsGrassShader;
				float _IsVegetationShader1101_g80801 = _IsVegetationShader;
				float _IsAnyVegetationShader362_g80801 = saturate( ( _IsBarkShader347_g80801 + _IsLeafShader360_g80801 + _IsCrossShader342_g80801 + _IsGrassShader341_g80801 + _IsVegetationShader1101_g80801 ) );
				float3 lerpResult290_g80801 = lerp( temp_cast_0 , gammaToLinear266_g80801 , _IsAnyVegetationShader362_g80801);
				float3 ifLocalVar40_g80974 = 0;
				if( Debug_Index464_g80801 == 16.0 )
				ifLocalVar40_g80974 = lerpResult290_g80801;
				float enc1154_g80801 = v.ase_texcoord.z;
				float2 localDecodeFloatToVector21154_g80801 = DecodeFloatToVector2( enc1154_g80801 );
				float2 break1155_g80801 = localDecodeFloatToVector21154_g80801;
				float ifLocalVar40_g80975 = 0;
				if( Debug_Index464_g80801 == 17.0 )
				ifLocalVar40_g80975 = break1155_g80801.x;
				float ifLocalVar40_g80976 = 0;
				if( Debug_Index464_g80801 == 18.0 )
				ifLocalVar40_g80976 = break1155_g80801.y;
				float3 appendResult60_g80966 = (float3(v.ase_texcoord3.x , v.ase_texcoord3.z , v.ase_texcoord3.y));
				float3 ifLocalVar40_g80977 = 0;
				if( Debug_Index464_g80801 == 19.0 )
				ifLocalVar40_g80977 = appendResult60_g80966;
				float3 vertexToFrag328_g80801 = ( ( ifLocalVar40_g80807 + ifLocalVar40_g80826 + ifLocalVar40_g80840 + ifLocalVar40_g80822 ) + ( ifLocalVar40_g80958 + ifLocalVar40_g80959 + ifLocalVar40_g80960 + ifLocalVar40_g80961 ) + ( ifLocalVar40_g80967 + ifLocalVar40_g80968 + ifLocalVar40_g80969 ) + ( ifLocalVar40_g80970 + ifLocalVar40_g80971 + ifLocalVar40_g80972 + ifLocalVar40_g80973 ) + ( ifLocalVar40_g80974 + ifLocalVar40_g80975 + ifLocalVar40_g80976 + ifLocalVar40_g80977 ) );
				o.ase_texcoord12.xyz = vertexToFrag328_g80801;
				
				o.ase_texcoord9 = v.ase_texcoord;
				o.ase_texcoord10 = v.texcoord1.xyzw;
				o.ase_texcoord11 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord8.zw = 0;
				o.ase_texcoord12.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.vertex.w = 1;
				v.normal = v.normal;
				v.tangent = v.tangent;

				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);

				#ifdef DYNAMICLIGHTMAP_ON
					o.lmap.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#else
					o.lmap.zw = 0;
				#endif
				#ifdef LIGHTMAP_ON
					o.lmap.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					#ifdef DIRLIGHTMAP_OFF
						o.lmapFadePos.xyz = (mul(unity_ObjectToWorld, v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w;
						o.lmapFadePos.w = (-UnityObjectToViewPos(v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w);
					#endif
				#else
					o.lmap.xy = 0;
					#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
						o.sh = 0;
						o.sh = ShadeSHPerVertex (worldNormal, o.sh);
					#endif
				#endif
				return o;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( appdata v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.tangent = v.tangent;
				o.normal = v.normal;
				o.texcoord1 = v.texcoord1;
				o.texcoord2 = v.texcoord2;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord3 = v.ase_texcoord3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, UNITY_MATRIX_M, _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, UNITY_MATRIX_M, _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
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
			v2f DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				appdata o = (appdata) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.tangent = patch[0].tangent * bary.x + patch[1].tangent * bary.y + patch[2].tangent * bary.z;
				o.normal = patch[0].normal * bary.x + patch[1].normal * bary.y + patch[2].normal * bary.z;
				o.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				o.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord3 = patch[0].ase_texcoord3 * bary.x + patch[1].ase_texcoord3 * bary.y + patch[2].ase_texcoord3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].normal * (dot(o.vertex.xyz, patch[i].normal) - dot(patch[i].vertex.xyz, patch[i].normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			v2f vert ( appdata v )
			{
				return VertexFunction( v );
			}
			#endif

			void frag (v2f IN , bool ase_vface : SV_IsFrontFace
				, out half4 outGBuffer0 : SV_Target0
				, out half4 outGBuffer1 : SV_Target1
				, out half4 outGBuffer2 : SV_Target2
				, out half4 outEmission : SV_Target3
				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
				, out half4 outShadowMask : SV_Target4
				#endif
				#ifdef _DEPTHOFFSET_ON
				, out float outputDepth : SV_Depth
				#endif
			)
			{
				UNITY_SETUP_INSTANCE_ID(IN);

				#ifdef LOD_FADE_CROSSFADE
					UNITY_APPLY_DITHER_CROSSFADE(IN.pos.xy);
				#endif

				#if defined(_SPECULAR_SETUP)
					SurfaceOutputStandardSpecular o = (SurfaceOutputStandardSpecular)0;
				#else
					SurfaceOutputStandard o = (SurfaceOutputStandard)0;
				#endif
				float3 WorldTangent = float3(IN.tSpace0.x,IN.tSpace1.x,IN.tSpace2.x);
				float3 WorldBiTangent = float3(IN.tSpace0.y,IN.tSpace1.y,IN.tSpace2.y);
				float3 WorldNormal = float3(IN.tSpace0.z,IN.tSpace1.z,IN.tSpace2.z);
				float3 worldPos = float3(IN.tSpace0.w,IN.tSpace1.w,IN.tSpace2.w);
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				half atten = 1;

				float Debug_Type367_g80801 = TVE_DEBUG_Type;
				float4 color646_g80801 = IsGammaSpace() ? float4(0.9245283,0.7969696,0.4142933,1) : float4(0.8368256,0.5987038,0.1431069,1);
				float4 color1359_g80801 = IsGammaSpace() ? float4(0.6196079,0.7686275,0.1490196,0) : float4(0.3419145,0.5520116,0.01938236,0);
				float _IsCollected1458_g80801 = _IsCollected;
				float4 lerpResult1360_g80801 = lerp( color646_g80801 , color1359_g80801 , _IsCollected1458_g80801);
				float customEye676_g80801 = IN.ase_texcoord8.x;
				float temp_output_1371_0_g80801 = saturate( (0.0 + (customEye676_g80801 - 300.0) * (1.0 - 0.0) / (0.0 - 300.0)) );
				float temp_output_1373_0_g80801 = (( temp_output_1371_0_g80801 * temp_output_1371_0_g80801 )*0.5 + 0.5);
				float Shading_Distance655_g80801 = temp_output_1373_0_g80801;
				float2 uv_MainAlbedoTex = IN.ase_texcoord9.xy * _MainAlbedoTex_ST.xy + _MainAlbedoTex_ST.zw;
				float temp_output_1411_0_g80801 = saturate( ( saturate( ( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a * 1.1 ) ) - SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a ) );
				float customEye1399_g80801 = IN.ase_texcoord8.y;
				float Debug_Clip623_g80801 = TVE_DEBUG_Clip;
				float Shading_Outline1403_g80801 = ( temp_output_1411_0_g80801 * saturate( (0.0 + (customEye1399_g80801 - 30.0) * (1.0 - 0.0) / (0.0 - 30.0)) ) * Debug_Clip623_g80801 );
				float4 Output_Converted717_g80801 = saturate( ( ( lerpResult1360_g80801 * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80824 = 0;
				if( Debug_Type367_g80801 == 0.0 )
				ifLocalVar40_g80824 = Output_Converted717_g80801;
				float4 color466_g80801 = IsGammaSpace() ? float4(0.8113208,0.4952317,0.264062,0) : float4(0.6231937,0.2096542,0.05668841,0);
				float _IsBarkShader347_g80801 = _IsBarkShader;
				float4 color469_g80801 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsCrossShader342_g80801 = _IsCrossShader;
				float4 color472_g80801 = IsGammaSpace() ? float4(0.7100264,0.8018868,0.2231666,0) : float4(0.4623997,0.6070304,0.0407874,0);
				float _IsGrassShader341_g80801 = _IsGrassShader;
				float4 color475_g80801 = IsGammaSpace() ? float4(0.3267961,0.7264151,0.3118103,0) : float4(0.08721471,0.4865309,0.07922345,0);
				float _IsLeafShader360_g80801 = _IsLeafShader;
				float4 color478_g80801 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsPropShader346_g80801 = _IsPropShader;
				float4 color1114_g80801 = IsGammaSpace() ? float4(0.9716981,0.3162602,0.4816265,0) : float4(0.9368213,0.08154967,0.1974273,0);
				float _IsImpostorShader1110_g80801 = _IsImpostorShader;
				float4 color1117_g80801 = IsGammaSpace() ? float4(0.257921,0.8679245,0.8361252,0) : float4(0.05410501,0.7254258,0.6668791,0);
				float _IsPolygonalShader1112_g80801 = _IsPolygonalShader;
				float4 Output_Shader445_g80801 = saturate( ( ( ( ( color466_g80801 * _IsBarkShader347_g80801 ) + ( color469_g80801 * _IsCrossShader342_g80801 ) + ( color472_g80801 * _IsGrassShader341_g80801 ) + ( color475_g80801 * _IsLeafShader360_g80801 ) + ( color478_g80801 * _IsPropShader346_g80801 ) + ( color1114_g80801 * _IsImpostorShader1110_g80801 ) + ( color1117_g80801 * _IsPolygonalShader1112_g80801 ) ) * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80896 = 0;
				if( Debug_Type367_g80801 == 1.0 )
				ifLocalVar40_g80896 = Output_Shader445_g80801;
				float4 color529_g80801 = IsGammaSpace() ? float4(0.62,0.77,0.15,0) : float4(0.3423916,0.5542217,0.01960665,0);
				float _IsVertexShader1158_g80801 = _IsVertexShader;
				float4 color544_g80801 = IsGammaSpace() ? float4(0.3252937,0.6122813,0.8113208,0) : float4(0.08639329,0.3330702,0.6231937,0);
				float _IsSimpleShader359_g80801 = _IsSimpleShader;
				float4 color521_g80801 = IsGammaSpace() ? float4(0.6566009,0.3404236,0.8490566,0) : float4(0.3886527,0.09487338,0.6903409,0);
				float _IsStandardShader344_g80801 = _IsStandardShader;
				float4 color1121_g80801 = IsGammaSpace() ? float4(0.9245283,0.8421515,0.1788003,0) : float4(0.8368256,0.677754,0.02687956,0);
				float _IsSubsurfaceShader548_g80801 = _IsSubsurfaceShader;
				float4 Output_Lighting525_g80801 = saturate( ( ( ( ( color529_g80801 * _IsVertexShader1158_g80801 ) + ( color544_g80801 * _IsSimpleShader359_g80801 ) + ( color521_g80801 * _IsStandardShader344_g80801 ) + ( color1121_g80801 * _IsSubsurfaceShader548_g80801 ) ) * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80876 = 0;
				if( Debug_Type367_g80801 == 2.0 )
				ifLocalVar40_g80876 = Output_Lighting525_g80801;
				float4 color1455_g80801 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float3 hsvTorgb1452_g80801 = HSVToRGB( float3(( _IsIdentifier / 1000.0 ),1.0,1.0) );
				float3 gammaToLinear1453_g80801 = GammaToLinearSpace( hsvTorgb1452_g80801 );
				float4 lerpResult1456_g80801 = lerp( color1455_g80801 , float4( gammaToLinear1453_g80801 , 0.0 ) , _IsCollected1458_g80801);
				float3 Output_Sharing1355_g80801 = (lerpResult1456_g80801).rgb;
				float3 ifLocalVar40_g80933 = 0;
				if( Debug_Type367_g80801 == 3.0 )
				ifLocalVar40_g80933 = Output_Sharing1355_g80801;
				float Debug_Index464_g80801 = TVE_DEBUG_Index;
				half2 Main_UVs1219_g80801 = ( ( IN.ase_texcoord9.xy * (_MainUVs).xy ) + (_MainUVs).zw );
				float4 tex2DNode586_g80801 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g80801 );
				float3 appendResult637_g80801 = (float3(tex2DNode586_g80801.r , tex2DNode586_g80801.g , tex2DNode586_g80801.b));
				float3 ifLocalVar40_g80825 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80825 = appendResult637_g80801;
				float ifLocalVar40_g80830 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80830 = SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, Main_UVs1219_g80801 ).a;
				float4 tex2DNode604_g80801 = SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, Main_UVs1219_g80801 );
				float3 appendResult876_g80801 = (float3(tex2DNode604_g80801.a , tex2DNode604_g80801.g , 1.0));
				float3 gammaToLinear878_g80801 = GammaToLinearSpace( appendResult876_g80801 );
				float3 ifLocalVar40_g80861 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80861 = gammaToLinear878_g80801;
				float ifLocalVar40_g80810 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80810 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).r;
				float ifLocalVar40_g80898 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80898 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).g;
				float ifLocalVar40_g80832 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80832 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).b;
				float ifLocalVar40_g80808 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80808 = SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, Main_UVs1219_g80801 ).a;
				float2 appendResult1251_g80801 = (float2(IN.ase_texcoord10.z , IN.ase_texcoord10.w));
				float2 Mesh_DetailCoord1254_g80801 = appendResult1251_g80801;
				float2 lerpResult1231_g80801 = lerp( IN.ase_texcoord9.xy , Mesh_DetailCoord1254_g80801 , _DetailCoordMode);
				half2 Second_UVs1234_g80801 = ( ( lerpResult1231_g80801 * (_SecondUVs).xy ) + (_SecondUVs).zw );
				float4 tex2DNode854_g80801 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g80801 );
				float3 appendResult839_g80801 = (float3(tex2DNode854_g80801.r , tex2DNode854_g80801.g , tex2DNode854_g80801.b));
				float3 ifLocalVar40_g80821 = 0;
				if( Debug_Index464_g80801 == 7.0 )
				ifLocalVar40_g80821 = appendResult839_g80801;
				float ifLocalVar40_g80839 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80839 = SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, Second_UVs1234_g80801 ).a;
				float4 tex2DNode841_g80801 = SAMPLE_TEXTURE2D( _SecondNormalTex, sampler_SecondNormalTex, Second_UVs1234_g80801 );
				float3 appendResult880_g80801 = (float3(tex2DNode841_g80801.a , tex2DNode841_g80801.g , 1.0));
				float3 gammaToLinear879_g80801 = GammaToLinearSpace( appendResult880_g80801 );
				float3 ifLocalVar40_g80884 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80884 = gammaToLinear879_g80801;
				float ifLocalVar40_g80862 = 0;
				if( Debug_Index464_g80801 == 10.0 )
				ifLocalVar40_g80862 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).r;
				float ifLocalVar40_g80829 = 0;
				if( Debug_Index464_g80801 == 11.0 )
				ifLocalVar40_g80829 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).g;
				float ifLocalVar40_g80875 = 0;
				if( Debug_Index464_g80801 == 12.0 )
				ifLocalVar40_g80875 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).b;
				float ifLocalVar40_g80883 = 0;
				if( Debug_Index464_g80801 == 13.0 )
				ifLocalVar40_g80883 = SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, Second_UVs1234_g80801 ).a;
				half2 Emissive_UVs1245_g80801 = ( ( IN.ase_texcoord9.xy * (_EmissiveUVs).xy ) + (_EmissiveUVs).zw );
				float4 tex2DNode858_g80801 = SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, Emissive_UVs1245_g80801 );
				float3 appendResult867_g80801 = (float3(tex2DNode858_g80801.r , tex2DNode858_g80801.g , tex2DNode858_g80801.b));
				float3 ifLocalVar40_g80828 = 0;
				if( Debug_Index464_g80801 == 14.0 )
				ifLocalVar40_g80828 = appendResult867_g80801;
				float Debug_Min721_g80801 = TVE_DEBUG_Min;
				float temp_output_7_0_g80869 = Debug_Min721_g80801;
				float4 temp_cast_5 = (temp_output_7_0_g80869).xxxx;
				float Debug_Max723_g80801 = TVE_DEBUG_Max;
				float4 Output_Maps561_g80801 = saturate( ( ( ( float4( ( ( ifLocalVar40_g80825 + ifLocalVar40_g80830 + ifLocalVar40_g80861 ) + ( ifLocalVar40_g80810 + ifLocalVar40_g80898 + ifLocalVar40_g80832 + ifLocalVar40_g80808 ) ) , 0.0 ) + float4( ( ( ( ifLocalVar40_g80821 + ifLocalVar40_g80839 + ifLocalVar40_g80884 ) + ( ifLocalVar40_g80862 + ifLocalVar40_g80829 + ifLocalVar40_g80875 + ifLocalVar40_g80883 ) ) * _DetailMode ) , 0.0 ) + ( ( float4( ifLocalVar40_g80828 , 0.0 ) * _EmissiveColor ) * _EmissiveCat ) ) - temp_cast_5 ) / ( ( Debug_Max723_g80801 - temp_output_7_0_g80869 ) + 0.01 ) ) );
				float4 ifLocalVar40_g80932 = 0;
				if( Debug_Type367_g80801 == 4.0 )
				ifLocalVar40_g80932 = Output_Maps561_g80801;
				float Resolution44_g80917 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 color62_g80917 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80917 = 0;
				if( Resolution44_g80917 <= 256.0 )
				ifLocalVar61_g80917 = color62_g80917;
				float4 color55_g80917 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80917 = 0;
				if( Resolution44_g80917 == 512.0 )
				ifLocalVar56_g80917 = color55_g80917;
				float4 color42_g80917 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80917 = 0;
				if( Resolution44_g80917 == 1024.0 )
				ifLocalVar40_g80917 = color42_g80917;
				float4 color48_g80917 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80917 = 0;
				if( Resolution44_g80917 == 2048.0 )
				ifLocalVar47_g80917 = color48_g80917;
				float4 color51_g80917 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80917 = 0;
				if( Resolution44_g80917 >= 4096.0 )
				ifLocalVar52_g80917 = color51_g80917;
				float4 ifLocalVar40_g80903 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80903 = ( ifLocalVar61_g80917 + ifLocalVar56_g80917 + ifLocalVar40_g80917 + ifLocalVar47_g80917 + ifLocalVar52_g80917 );
				float Resolution44_g80916 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 color62_g80916 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80916 = 0;
				if( Resolution44_g80916 <= 256.0 )
				ifLocalVar61_g80916 = color62_g80916;
				float4 color55_g80916 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80916 = 0;
				if( Resolution44_g80916 == 512.0 )
				ifLocalVar56_g80916 = color55_g80916;
				float4 color42_g80916 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80916 = 0;
				if( Resolution44_g80916 == 1024.0 )
				ifLocalVar40_g80916 = color42_g80916;
				float4 color48_g80916 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80916 = 0;
				if( Resolution44_g80916 == 2048.0 )
				ifLocalVar47_g80916 = color48_g80916;
				float4 color51_g80916 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80916 = 0;
				if( Resolution44_g80916 >= 4096.0 )
				ifLocalVar52_g80916 = color51_g80916;
				float4 ifLocalVar40_g80901 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80901 = ( ifLocalVar61_g80916 + ifLocalVar56_g80916 + ifLocalVar40_g80916 + ifLocalVar47_g80916 + ifLocalVar52_g80916 );
				float Resolution44_g80915 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 color62_g80915 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80915 = 0;
				if( Resolution44_g80915 <= 256.0 )
				ifLocalVar61_g80915 = color62_g80915;
				float4 color55_g80915 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80915 = 0;
				if( Resolution44_g80915 == 512.0 )
				ifLocalVar56_g80915 = color55_g80915;
				float4 color42_g80915 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80915 = 0;
				if( Resolution44_g80915 == 1024.0 )
				ifLocalVar40_g80915 = color42_g80915;
				float4 color48_g80915 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80915 = 0;
				if( Resolution44_g80915 == 2048.0 )
				ifLocalVar47_g80915 = color48_g80915;
				float4 color51_g80915 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80915 = 0;
				if( Resolution44_g80915 >= 4096.0 )
				ifLocalVar52_g80915 = color51_g80915;
				float4 ifLocalVar40_g80902 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80902 = ( ifLocalVar61_g80915 + ifLocalVar56_g80915 + ifLocalVar40_g80915 + ifLocalVar47_g80915 + ifLocalVar52_g80915 );
				float Resolution44_g80922 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g80922 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80922 = 0;
				if( Resolution44_g80922 <= 256.0 )
				ifLocalVar61_g80922 = color62_g80922;
				float4 color55_g80922 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80922 = 0;
				if( Resolution44_g80922 == 512.0 )
				ifLocalVar56_g80922 = color55_g80922;
				float4 color42_g80922 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80922 = 0;
				if( Resolution44_g80922 == 1024.0 )
				ifLocalVar40_g80922 = color42_g80922;
				float4 color48_g80922 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80922 = 0;
				if( Resolution44_g80922 == 2048.0 )
				ifLocalVar47_g80922 = color48_g80922;
				float4 color51_g80922 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80922 = 0;
				if( Resolution44_g80922 >= 4096.0 )
				ifLocalVar52_g80922 = color51_g80922;
				float4 ifLocalVar40_g80909 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80909 = ( ifLocalVar61_g80922 + ifLocalVar56_g80922 + ifLocalVar40_g80922 + ifLocalVar47_g80922 + ifLocalVar52_g80922 );
				float Resolution44_g80921 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 color62_g80921 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80921 = 0;
				if( Resolution44_g80921 <= 256.0 )
				ifLocalVar61_g80921 = color62_g80921;
				float4 color55_g80921 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80921 = 0;
				if( Resolution44_g80921 == 512.0 )
				ifLocalVar56_g80921 = color55_g80921;
				float4 color42_g80921 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80921 = 0;
				if( Resolution44_g80921 == 1024.0 )
				ifLocalVar40_g80921 = color42_g80921;
				float4 color48_g80921 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80921 = 0;
				if( Resolution44_g80921 == 2048.0 )
				ifLocalVar47_g80921 = color48_g80921;
				float4 color51_g80921 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80921 = 0;
				if( Resolution44_g80921 >= 4096.0 )
				ifLocalVar52_g80921 = color51_g80921;
				float4 ifLocalVar40_g80907 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80907 = ( ifLocalVar61_g80921 + ifLocalVar56_g80921 + ifLocalVar40_g80921 + ifLocalVar47_g80921 + ifLocalVar52_g80921 );
				float Resolution44_g80923 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 color62_g80923 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80923 = 0;
				if( Resolution44_g80923 <= 256.0 )
				ifLocalVar61_g80923 = color62_g80923;
				float4 color55_g80923 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80923 = 0;
				if( Resolution44_g80923 == 512.0 )
				ifLocalVar56_g80923 = color55_g80923;
				float4 color42_g80923 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80923 = 0;
				if( Resolution44_g80923 == 1024.0 )
				ifLocalVar40_g80923 = color42_g80923;
				float4 color48_g80923 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80923 = 0;
				if( Resolution44_g80923 == 2048.0 )
				ifLocalVar47_g80923 = color48_g80923;
				float4 color51_g80923 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80923 = 0;
				if( Resolution44_g80923 >= 4096.0 )
				ifLocalVar52_g80923 = color51_g80923;
				float4 ifLocalVar40_g80908 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80908 = ( ifLocalVar61_g80923 + ifLocalVar56_g80923 + ifLocalVar40_g80923 + ifLocalVar47_g80923 + ifLocalVar52_g80923 );
				float Resolution44_g80920 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 color62_g80920 = IsGammaSpace() ? float4(0.484069,0.862666,0.9245283,0) : float4(0.1995908,0.7155456,0.8368256,0);
				float4 ifLocalVar61_g80920 = 0;
				if( Resolution44_g80920 <= 256.0 )
				ifLocalVar61_g80920 = color62_g80920;
				float4 color55_g80920 = IsGammaSpace() ? float4(0.1933962,0.7383016,1,0) : float4(0.03108436,0.5044825,1,0);
				float4 ifLocalVar56_g80920 = 0;
				if( Resolution44_g80920 == 512.0 )
				ifLocalVar56_g80920 = color55_g80920;
				float4 color42_g80920 = IsGammaSpace() ? float4(0.4431373,0.7921569,0.1764706,0) : float4(0.1651322,0.5906189,0.02624122,0);
				float4 ifLocalVar40_g80920 = 0;
				if( Resolution44_g80920 == 1024.0 )
				ifLocalVar40_g80920 = color42_g80920;
				float4 color48_g80920 = IsGammaSpace() ? float4(1,0.6889491,0.07075471,0) : float4(1,0.4324122,0.006068094,0);
				float4 ifLocalVar47_g80920 = 0;
				if( Resolution44_g80920 == 2048.0 )
				ifLocalVar47_g80920 = color48_g80920;
				float4 color51_g80920 = IsGammaSpace() ? float4(1,0.2066492,0.0990566,0) : float4(1,0.03521443,0.009877041,0);
				float4 ifLocalVar52_g80920 = 0;
				if( Resolution44_g80920 >= 4096.0 )
				ifLocalVar52_g80920 = color51_g80920;
				float4 ifLocalVar40_g80910 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80910 = ( ifLocalVar61_g80920 + ifLocalVar56_g80920 + ifLocalVar40_g80920 + ifLocalVar47_g80920 + ifLocalVar52_g80920 );
				float4 Output_Resolution737_g80801 = saturate( ( ( ( ( ifLocalVar40_g80903 + ifLocalVar40_g80901 + ifLocalVar40_g80902 ) + ( ifLocalVar40_g80909 + ifLocalVar40_g80907 + ifLocalVar40_g80908 ) + ifLocalVar40_g80910 ) * Shading_Distance655_g80801 ) + Shading_Outline1403_g80801 ) );
				float4 ifLocalVar40_g80929 = 0;
				if( Debug_Type367_g80801 == 5.0 )
				ifLocalVar40_g80929 = Output_Resolution737_g80801;
				float2 UVs72_g80928 = Main_UVs1219_g80801;
				float Resolution44_g80928 = max( _MainAlbedoTex_TexelSize.z , _MainAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g80928 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80928 * ( Resolution44_g80928 / 8.0 ) ) );
				float4 lerpResult78_g80928 = lerp( SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ) , tex2DNode77_g80928 , tex2DNode77_g80928.a);
				float4 ifLocalVar40_g80906 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80906 = lerpResult78_g80928;
				float2 uv_MainNormalTex = IN.ase_texcoord9.xy * _MainNormalTex_ST.xy + _MainNormalTex_ST.zw;
				float2 UVs72_g80919 = Main_UVs1219_g80801;
				float Resolution44_g80919 = max( _MainNormalTex_TexelSize.z , _MainNormalTex_TexelSize.w );
				float4 tex2DNode77_g80919 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80919 * ( Resolution44_g80919 / 8.0 ) ) );
				float4 lerpResult78_g80919 = lerp( SAMPLE_TEXTURE2D( _MainNormalTex, sampler_MainNormalTex, uv_MainNormalTex ) , tex2DNode77_g80919 , tex2DNode77_g80919.a);
				float4 ifLocalVar40_g80904 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80904 = lerpResult78_g80919;
				float2 uv_MainMaskTex = IN.ase_texcoord9.xy * _MainMaskTex_ST.xy + _MainMaskTex_ST.zw;
				float2 UVs72_g80918 = Main_UVs1219_g80801;
				float Resolution44_g80918 = max( _MainMaskTex_TexelSize.z , _MainMaskTex_TexelSize.w );
				float4 tex2DNode77_g80918 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80918 * ( Resolution44_g80918 / 8.0 ) ) );
				float4 lerpResult78_g80918 = lerp( SAMPLE_TEXTURE2D( _MainMaskTex, sampler_MainMaskTex, uv_MainMaskTex ) , tex2DNode77_g80918 , tex2DNode77_g80918.a);
				float4 ifLocalVar40_g80905 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80905 = lerpResult78_g80918;
				float2 uv_SecondAlbedoTex = IN.ase_texcoord9.xy * _SecondAlbedoTex_ST.xy + _SecondAlbedoTex_ST.zw;
				float2 UVs72_g80926 = Second_UVs1234_g80801;
				float Resolution44_g80926 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g80926 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80926 * ( Resolution44_g80926 / 8.0 ) ) );
				float4 lerpResult78_g80926 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g80926 , tex2DNode77_g80926.a);
				float4 ifLocalVar40_g80913 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80913 = lerpResult78_g80926;
				float2 uv_SecondMaskTex = IN.ase_texcoord9.xy * _SecondMaskTex_ST.xy + _SecondMaskTex_ST.zw;
				float2 UVs72_g80925 = Second_UVs1234_g80801;
				float Resolution44_g80925 = max( _SecondMaskTex_TexelSize.z , _SecondMaskTex_TexelSize.w );
				float4 tex2DNode77_g80925 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80925 * ( Resolution44_g80925 / 8.0 ) ) );
				float4 lerpResult78_g80925 = lerp( SAMPLE_TEXTURE2D( _SecondMaskTex, sampler_SecondMaskTex, uv_SecondMaskTex ) , tex2DNode77_g80925 , tex2DNode77_g80925.a);
				float4 ifLocalVar40_g80911 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80911 = lerpResult78_g80925;
				float2 UVs72_g80927 = Second_UVs1234_g80801;
				float Resolution44_g80927 = max( _SecondAlbedoTex_TexelSize.z , _SecondAlbedoTex_TexelSize.w );
				float4 tex2DNode77_g80927 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80927 * ( Resolution44_g80927 / 8.0 ) ) );
				float4 lerpResult78_g80927 = lerp( SAMPLE_TEXTURE2D( _SecondAlbedoTex, sampler_SecondAlbedoTex, uv_SecondAlbedoTex ) , tex2DNode77_g80927 , tex2DNode77_g80927.a);
				float4 ifLocalVar40_g80912 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80912 = lerpResult78_g80927;
				float2 uv_EmissiveTex = IN.ase_texcoord9.xy * _EmissiveTex_ST.xy + _EmissiveTex_ST.zw;
				float2 UVs72_g80924 = Emissive_UVs1245_g80801;
				float Resolution44_g80924 = max( _EmissiveTex_TexelSize.z , _EmissiveTex_TexelSize.w );
				float4 tex2DNode77_g80924 = SAMPLE_TEXTURE2D( TVE_DEBUG_MipTex, samplerTVE_DEBUG_MipTex, ( UVs72_g80924 * ( Resolution44_g80924 / 8.0 ) ) );
				float4 lerpResult78_g80924 = lerp( SAMPLE_TEXTURE2D( _EmissiveTex, sampler_EmissiveTex, uv_EmissiveTex ) , tex2DNode77_g80924 , tex2DNode77_g80924.a);
				float4 ifLocalVar40_g80914 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80914 = lerpResult78_g80924;
				float4 Output_MipLevel1284_g80801 = ( ( ifLocalVar40_g80906 + ifLocalVar40_g80904 + ifLocalVar40_g80905 ) + ( ifLocalVar40_g80913 + ifLocalVar40_g80911 + ifLocalVar40_g80912 ) + ifLocalVar40_g80914 );
				float4 ifLocalVar40_g80930 = 0;
				if( Debug_Type367_g80801 == 6.0 )
				ifLocalVar40_g80930 = Output_MipLevel1284_g80801;
				float3 WorldPosition893_g80801 = worldPos;
				half3 Input_Position419_g80935 = WorldPosition893_g80801;
				float Input_MotionScale287_g80935 = ( _MotionScale_10 + 0.2 );
				half Global_NoiseScale448_g80935 = TVE_NoiseParams.x;
				float2 temp_output_597_0_g80935 = (( Input_Position419_g80935 * Input_MotionScale287_g80935 * Global_NoiseScale448_g80935 * 0.0075 )).xz;
				float2 temp_output_447_0_g80942 = ((TVE_MotionParams).xy*2.0 + -1.0);
				half2 Wind_DirectionWS1031_g80801 = temp_output_447_0_g80942;
				half2 Input_DirectionWS423_g80935 = Wind_DirectionWS1031_g80801;
				half Input_MotionSpeed62_g80935 = _MotionSpeed_10;
				half Global_NoiseSpeed449_g80935 = TVE_NoiseParams.y;
				half Input_MotionVariation284_g80935 = _MotionVariation_10;
				float4x4 break19_g80945 = unity_ObjectToWorld;
				float3 appendResult20_g80945 = (float3(break19_g80945[ 0 ][ 3 ] , break19_g80945[ 1 ][ 3 ] , break19_g80945[ 2 ][ 3 ]));
				float3 appendResult60_g80944 = (float3(IN.ase_texcoord11.x , IN.ase_texcoord11.z , IN.ase_texcoord11.y));
				float3 temp_output_122_0_g80945 = ( appendResult60_g80944 * _VertexPivotMode );
				float3 PivotsOnly105_g80945 = (mul( unity_ObjectToWorld, float4( temp_output_122_0_g80945 , 0.0 ) ).xyz).xyz;
				half3 ObjectData20_g80946 = ( appendResult20_g80945 + PivotsOnly105_g80945 );
				half3 WorldData19_g80946 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g80946 = WorldData19_g80946;
				#else
				float3 staticSwitch14_g80946 = ObjectData20_g80946;
				#endif
				float3 temp_output_114_0_g80945 = staticSwitch14_g80946;
				half3 ObjectData20_g80934 = temp_output_114_0_g80945;
				half3 WorldData19_g80934 = worldPos;
				#ifdef TVE_FEATURE_BATCHING
				float3 staticSwitch14_g80934 = WorldData19_g80934;
				#else
				float3 staticSwitch14_g80934 = ObjectData20_g80934;
				#endif
				float3 ObjectPosition890_g80801 = staticSwitch14_g80934;
				float3 break111_g80953 = ObjectPosition890_g80801;
				half Input_DynamicMode120_g80953 = _VertexDynamicMode;
				float Postion_Sum142_g80953 = ( ( break111_g80953.x + break111_g80953.y + break111_g80953.z + 0.001271 ) * ( 1.0 - Input_DynamicMode120_g80953 ) );
				half Input_Variation124_g80953 = IN.ase_color.r;
				half ObjectData20_g80955 = ( Postion_Sum142_g80953 + Input_Variation124_g80953 );
				half WorldData19_g80955 = Input_Variation124_g80953;
				#ifdef TVE_FEATURE_BATCHING
				float staticSwitch14_g80955 = WorldData19_g80955;
				#else
				float staticSwitch14_g80955 = ObjectData20_g80955;
				#endif
				float clampResult129_g80953 = clamp( frac( staticSwitch14_g80955 ) , 0.01 , 0.99 );
				half Global_MeshVariation1176_g80801 = clampResult129_g80953;
				half Input_GlobalMeshVariation569_g80935 = Global_MeshVariation1176_g80801;
				half Input_ObjectVariation694_g80935 = 0.0;
				half Input_GlobalObjectVariation692_g80935 = 0.0;
				float temp_output_630_0_g80935 = ( ( ( _Time.y * Input_MotionSpeed62_g80935 * Global_NoiseSpeed449_g80935 ) + ( Input_MotionVariation284_g80935 * Input_GlobalMeshVariation569_g80935 ) + ( Input_ObjectVariation694_g80935 * Input_GlobalObjectVariation692_g80935 ) ) * 0.03 );
				float temp_output_607_0_g80935 = frac( temp_output_630_0_g80935 );
				float4 lerpResult590_g80935 = lerp( SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g80935 + ( -Input_DirectionWS423_g80935 * temp_output_607_0_g80935 ) ) ) , SAMPLE_TEXTURE2D( TVE_NoiseTex, sampler_Linear_Repeat, ( temp_output_597_0_g80935 + ( -Input_DirectionWS423_g80935 * frac( ( temp_output_630_0_g80935 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_607_0_g80935 - 0.5 ) ) / 0.5 ));
				float2 temp_output_645_0_g80935 = ((lerpResult590_g80935).rg*2.0 + -1.0);
				float2 break650_g80935 = temp_output_645_0_g80935;
				float3 appendResult649_g80935 = (float3(break650_g80935.x , 0.0 , break650_g80935.y));
				float3 ase_parentObjectScale = ( 1.0 / float3( length( unity_WorldToObject[ 0 ].xyz ), length( unity_WorldToObject[ 1 ].xyz ), length( unity_WorldToObject[ 2 ].xyz ) ) );
				half2 Motion_Noise915_g80801 = (( mul( unity_WorldToObject, float4( appendResult649_g80935 , 0.0 ) ).xyz * ase_parentObjectScale )).xz;
				float3 appendResult1180_g80801 = (float3(Motion_Noise915_g80801 , 0.0));
				float3 ifLocalVar40_g80811 = 0;
				if( Debug_Index464_g80801 == 0.0 )
				ifLocalVar40_g80811 = appendResult1180_g80801;
				float Debug_Layer885_g80801 = TVE_DEBUG_Layer;
				float temp_output_82_0_g80856 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80856 = TVE_ColorsCoords;
				half2 UV94_g80856 = ( (temp_output_91_19_g80856).zw + ( (temp_output_91_19_g80856).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode83_g80856 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g80856,temp_output_82_0_g80856), 0.0 );
				float4 temp_output_92_86_g80856 = TVE_ColorsParams;
				float4 ifLocalVar18_g80860 = 0;
				UNITY_BRANCH 
				if( TVE_ColorsUsage[(int)temp_output_82_0_g80856] > 0.5 )
				ifLocalVar18_g80860 = tex2DArrayNode83_g80856;
				else if( TVE_ColorsUsage[(int)temp_output_82_0_g80856] < 0.5 )
				ifLocalVar18_g80860 = temp_output_92_86_g80856;
				float3 ifLocalVar40_g80827 = 0;
				if( Debug_Index464_g80801 == 1.0 )
				ifLocalVar40_g80827 = (ifLocalVar18_g80860).rgb;
				float temp_output_82_0_g80841 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80841 = TVE_ColorsCoords;
				half2 UV94_g80841 = ( (temp_output_91_19_g80841).zw + ( (temp_output_91_19_g80841).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode83_g80841 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ColorsTex, sampler_Linear_Clamp, float3(UV94_g80841,temp_output_82_0_g80841), 0.0 );
				float4 temp_output_92_86_g80841 = TVE_ColorsParams;
				float4 ifLocalVar18_g80845 = 0;
				UNITY_BRANCH 
				if( TVE_ColorsUsage[(int)temp_output_82_0_g80841] > 0.5 )
				ifLocalVar18_g80845 = tex2DArrayNode83_g80841;
				else if( TVE_ColorsUsage[(int)temp_output_82_0_g80841] < 0.5 )
				ifLocalVar18_g80845 = temp_output_92_86_g80841;
				float ifLocalVar40_g80838 = 0;
				if( Debug_Index464_g80801 == 2.0 )
				ifLocalVar40_g80838 = saturate( (ifLocalVar18_g80845).a );
				float temp_output_84_0_g80851 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80851 = TVE_ExtrasCoords;
				half2 UV96_g80851 = ( (temp_output_93_19_g80851).zw + ( (temp_output_93_19_g80851).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80851 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80851,temp_output_84_0_g80851), 0.0 );
				float4 temp_output_94_85_g80851 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80855 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80851] > 0.5 )
				ifLocalVar18_g80855 = tex2DArrayNode48_g80851;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80851] < 0.5 )
				ifLocalVar18_g80855 = temp_output_94_85_g80851;
				float ifLocalVar40_g80819 = 0;
				if( Debug_Index464_g80801 == 3.0 )
				ifLocalVar40_g80819 = (ifLocalVar18_g80855).r;
				float temp_output_84_0_g80802 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80802 = TVE_ExtrasCoords;
				half2 UV96_g80802 = ( (temp_output_93_19_g80802).zw + ( (temp_output_93_19_g80802).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80802 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80802,temp_output_84_0_g80802), 0.0 );
				float4 temp_output_94_85_g80802 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80806 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80802] > 0.5 )
				ifLocalVar18_g80806 = tex2DArrayNode48_g80802;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80802] < 0.5 )
				ifLocalVar18_g80806 = temp_output_94_85_g80802;
				float ifLocalVar40_g80897 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80897 = (ifLocalVar18_g80806).g;
				float temp_output_84_0_g80863 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80863 = TVE_ExtrasCoords;
				half2 UV96_g80863 = ( (temp_output_93_19_g80863).zw + ( (temp_output_93_19_g80863).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80863 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80863,temp_output_84_0_g80863), 0.0 );
				float4 temp_output_94_85_g80863 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80867 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80863] > 0.5 )
				ifLocalVar18_g80867 = tex2DArrayNode48_g80863;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80863] < 0.5 )
				ifLocalVar18_g80867 = temp_output_94_85_g80863;
				float ifLocalVar40_g80820 = 0;
				if( Debug_Index464_g80801 == 5.0 )
				ifLocalVar40_g80820 = (ifLocalVar18_g80867).b;
				float temp_output_84_0_g80885 = Debug_Layer885_g80801;
				float4 temp_output_93_19_g80885 = TVE_ExtrasCoords;
				half2 UV96_g80885 = ( (temp_output_93_19_g80885).zw + ( (temp_output_93_19_g80885).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode48_g80885 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_ExtrasTex, sampler_Linear_Clamp, float3(UV96_g80885,temp_output_84_0_g80885), 0.0 );
				float4 temp_output_94_85_g80885 = TVE_ExtrasParams;
				float4 ifLocalVar18_g80889 = 0;
				UNITY_BRANCH 
				if( TVE_ExtrasUsage[(int)temp_output_84_0_g80885] > 0.5 )
				ifLocalVar18_g80889 = tex2DArrayNode48_g80885;
				else if( TVE_ExtrasUsage[(int)temp_output_84_0_g80885] < 0.5 )
				ifLocalVar18_g80889 = temp_output_94_85_g80885;
				float ifLocalVar40_g80813 = 0;
				if( Debug_Index464_g80801 == 6.0 )
				ifLocalVar40_g80813 = saturate( (ifLocalVar18_g80889).a );
				float temp_output_84_0_g80846 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80846 = TVE_MotionCoords;
				half2 UV94_g80846 = ( (temp_output_91_19_g80846).zw + ( (temp_output_91_19_g80846).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80846 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80846,temp_output_84_0_g80846), 0.0 );
				float4 temp_output_112_19_g80846 = TVE_MotionParams;
				float4 ifLocalVar18_g80850 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g80846] > 0.5 )
				ifLocalVar18_g80850 = tex2DArrayNode50_g80846;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g80846] < 0.5 )
				ifLocalVar18_g80850 = temp_output_112_19_g80846;
				float3 appendResult1012_g80801 = (float3((ifLocalVar18_g80850).rg , 0.0));
				float3 ifLocalVar40_g80809 = 0;
				if( Debug_Index464_g80801 == 7.0 )
				ifLocalVar40_g80809 = appendResult1012_g80801;
				float temp_output_84_0_g80870 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80870 = TVE_MotionCoords;
				half2 UV94_g80870 = ( (temp_output_91_19_g80870).zw + ( (temp_output_91_19_g80870).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80870 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80870,temp_output_84_0_g80870), 0.0 );
				float4 temp_output_112_19_g80870 = TVE_MotionParams;
				float4 ifLocalVar18_g80874 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g80870] > 0.5 )
				ifLocalVar18_g80874 = tex2DArrayNode50_g80870;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g80870] < 0.5 )
				ifLocalVar18_g80874 = temp_output_112_19_g80870;
				float ifLocalVar40_g80823 = 0;
				if( Debug_Index464_g80801 == 8.0 )
				ifLocalVar40_g80823 = (ifLocalVar18_g80874).b;
				float temp_output_84_0_g80877 = Debug_Layer885_g80801;
				float4 temp_output_91_19_g80877 = TVE_MotionCoords;
				half2 UV94_g80877 = ( (temp_output_91_19_g80877).zw + ( (temp_output_91_19_g80877).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80877 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_MotionTex, sampler_Linear_Clamp, float3(UV94_g80877,temp_output_84_0_g80877), 0.0 );
				float4 temp_output_112_19_g80877 = TVE_MotionParams;
				float4 ifLocalVar18_g80881 = 0;
				UNITY_BRANCH 
				if( TVE_MotionUsage[(int)temp_output_84_0_g80877] > 0.5 )
				ifLocalVar18_g80881 = tex2DArrayNode50_g80877;
				else if( TVE_MotionUsage[(int)temp_output_84_0_g80877] < 0.5 )
				ifLocalVar18_g80881 = temp_output_112_19_g80877;
				float ifLocalVar40_g80882 = 0;
				if( Debug_Index464_g80801 == 9.0 )
				ifLocalVar40_g80882 = saturate( (ifLocalVar18_g80881).a );
				float temp_output_84_0_g80891 = Debug_Layer885_g80801;
				float4 temp_output_94_19_g80891 = TVE_VertexCoords;
				half2 UV97_g80891 = ( (temp_output_94_19_g80891).zw + ( (temp_output_94_19_g80891).xy * (WorldPosition893_g80801).xz ) );
				float4 tex2DArrayNode50_g80891 = SAMPLE_TEXTURE2D_ARRAY_LOD( TVE_VertexTex, sampler_Linear_Clamp, float3(UV97_g80891,temp_output_84_0_g80891), 0.0 );
				float4 temp_output_111_19_g80891 = TVE_VertexParams;
				float4 ifLocalVar18_g80895 = 0;
				UNITY_BRANCH 
				if( TVE_VertexUsage[(int)temp_output_84_0_g80891] > 0.5 )
				ifLocalVar18_g80895 = tex2DArrayNode50_g80891;
				else if( TVE_VertexUsage[(int)temp_output_84_0_g80891] < 0.5 )
				ifLocalVar18_g80895 = temp_output_111_19_g80891;
				float ifLocalVar40_g80831 = 0;
				if( Debug_Index464_g80801 == 10.0 )
				ifLocalVar40_g80831 = saturate( (ifLocalVar18_g80895).a );
				float temp_output_7_0_g80900 = Debug_Min721_g80801;
				float3 temp_cast_30 = (temp_output_7_0_g80900).xxx;
				float3 Output_Globals888_g80801 = saturate( ( ( ( ifLocalVar40_g80811 + ( ifLocalVar40_g80827 + ifLocalVar40_g80838 ) + ( ifLocalVar40_g80819 + ifLocalVar40_g80897 + ifLocalVar40_g80820 + ifLocalVar40_g80813 ) + ( ifLocalVar40_g80809 + ifLocalVar40_g80823 + ifLocalVar40_g80882 ) + ( ifLocalVar40_g80831 + 0.0 ) ) - temp_cast_30 ) / ( ( Debug_Max723_g80801 - temp_output_7_0_g80900 ) + 0.01 ) ) );
				float3 ifLocalVar40_g80931 = 0;
				if( Debug_Type367_g80801 == 7.0 )
				ifLocalVar40_g80931 = Output_Globals888_g80801;
				float3 vertexToFrag328_g80801 = IN.ase_texcoord12.xyz;
				float4 color1016_g80801 = IsGammaSpace() ? float4(0.5831653,0.6037736,0.2135992,0) : float4(0.2992498,0.3229691,0.03750122,0);
				float4 color1017_g80801 = IsGammaSpace() ? float4(0.8117647,0.3488252,0.2627451,0) : float4(0.6239604,0.0997834,0.05612849,0);
				float4 switchResult1015_g80801 = (((ase_vface>0)?(color1016_g80801):(color1017_g80801)));
				float3 ifLocalVar40_g80812 = 0;
				if( Debug_Index464_g80801 == 4.0 )
				ifLocalVar40_g80812 = (switchResult1015_g80801).rgb;
				float temp_output_7_0_g80899 = Debug_Min721_g80801;
				float3 temp_cast_31 = (temp_output_7_0_g80899).xxx;
				float3 Output_Mesh316_g80801 = saturate( ( ( ( vertexToFrag328_g80801 + ifLocalVar40_g80812 ) - temp_cast_31 ) / ( ( Debug_Max723_g80801 - temp_output_7_0_g80899 ) + 0.01 ) ) );
				float3 ifLocalVar40_g80957 = 0;
				if( Debug_Type367_g80801 == 10.0 )
				ifLocalVar40_g80957 = Output_Mesh316_g80801;
				float4 temp_output_459_0_g80801 = ( ( ifLocalVar40_g80824 + ifLocalVar40_g80896 + ifLocalVar40_g80876 + float4( ifLocalVar40_g80933 , 0.0 ) ) + ( ifLocalVar40_g80932 + ifLocalVar40_g80929 + ifLocalVar40_g80930 ) + float4( ( ifLocalVar40_g80931 + ifLocalVar40_g80957 ) , 0.0 ) );
				float4 color690_g80801 = IsGammaSpace() ? float4(0.1226415,0.1226415,0.1226415,0) : float4(0.01390275,0.01390275,0.01390275,0);
				float _IsTVEShader647_g80801 = _IsTVEShader;
				float4 lerpResult689_g80801 = lerp( color690_g80801 , temp_output_459_0_g80801 , _IsTVEShader647_g80801);
				float Debug_Filter322_g80801 = TVE_DEBUG_Filter;
				float4 lerpResult326_g80801 = lerp( temp_output_459_0_g80801 , lerpResult689_g80801 , Debug_Filter322_g80801);
				float lerpResult622_g80801 = lerp( 1.0 , SAMPLE_TEXTURE2D( _MainAlbedoTex, sampler_MainAlbedoTex, uv_MainAlbedoTex ).a , ( Debug_Clip623_g80801 * _RenderClip ));
				clip( lerpResult622_g80801 - _Cutoff);
				clip( ( 1.0 - saturate( ( _IsElementShader + _IsHelperShader ) ) ) - 1.0);
				
				o.Albedo = fixed3( 0.5, 0.5, 0.5 );
				o.Normal = fixed3( 0, 0, 1 );
				o.Emission = lerpResult326_g80801.rgb;
				#if defined(_SPECULAR_SETUP)
					o.Specular = fixed3( 0, 0, 0 );
				#else
					o.Metallic = 0;
				#endif
				o.Smoothness = 0;
				o.Occlusion = 1;
				o.Alpha = 1;
				float AlphaClipThreshold = 0.5;
				float3 BakedGI = 0;

				#ifdef _ALPHATEST_ON
					clip( o.Alpha - AlphaClipThreshold );
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = IN.pos.z;
				#endif

				#ifndef USING_DIRECTIONAL_LIGHT
					fixed3 lightDir = normalize(UnityWorldSpaceLightDir(worldPos));
				#else
					fixed3 lightDir = _WorldSpaceLightPos0.xyz;
				#endif

				float3 worldN;
				worldN.x = dot(IN.tSpace0.xyz, o.Normal);
				worldN.y = dot(IN.tSpace1.xyz, o.Normal);
				worldN.z = dot(IN.tSpace2.xyz, o.Normal);
				worldN = normalize(worldN);
				o.Normal = worldN;

				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT(UnityGI, gi);
				gi.indirect.diffuse = 0;
				gi.indirect.specular = 0;
				gi.light.color = 0;
				gi.light.dir = half3(0,1,0);

				UnityGIInput giInput;
				UNITY_INITIALIZE_OUTPUT(UnityGIInput, giInput);
				giInput.light = gi.light;
				giInput.worldPos = worldPos;
				giInput.worldViewDir = worldViewDir;
				giInput.atten = atten;
				#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
					giInput.lightmapUV = IN.lmap;
				#else
					giInput.lightmapUV = 0.0;
				#endif
				#if UNITY_SHOULD_SAMPLE_SH && !UNITY_SAMPLE_FULL_SH_PER_PIXEL
					giInput.ambient = IN.sh;
				#else
					giInput.ambient.rgb = 0.0;
				#endif
				giInput.probeHDR[0] = unity_SpecCube0_HDR;
				giInput.probeHDR[1] = unity_SpecCube1_HDR;
				#if defined(UNITY_SPECCUBE_BLENDING) || defined(UNITY_SPECCUBE_BOX_PROJECTION)
					giInput.boxMin[0] = unity_SpecCube0_BoxMin;
				#endif
				#ifdef UNITY_SPECCUBE_BOX_PROJECTION
					giInput.boxMax[0] = unity_SpecCube0_BoxMax;
					giInput.probePosition[0] = unity_SpecCube0_ProbePosition;
					giInput.boxMax[1] = unity_SpecCube1_BoxMax;
					giInput.boxMin[1] = unity_SpecCube1_BoxMin;
					giInput.probePosition[1] = unity_SpecCube1_ProbePosition;
				#endif

				#if defined(_SPECULAR_SETUP)
					LightingStandardSpecular_GI( o, giInput, gi );
				#else
					LightingStandard_GI( o, giInput, gi );
				#endif

				#ifdef ASE_BAKEDGI
					gi.indirect.diffuse = BakedGI;
				#endif

				#if UNITY_SHOULD_SAMPLE_SH && !defined(LIGHTMAP_ON) && defined(ASE_NO_AMBIENT)
					gi.indirect.diffuse = 0;
				#endif

				#if defined(_SPECULAR_SETUP)
					outEmission = LightingStandardSpecular_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#else
					outEmission = LightingStandard_Deferred( o, worldViewDir, gi, outGBuffer0, outGBuffer1, outGBuffer2 );
				#endif

				#if defined(SHADOWS_SHADOWMASK) && (UNITY_ALLOWED_MRT_COUNT > 4)
					outShadowMask = UnityGetRawBakedOcclusions (IN.lmap.xy, float3(0, 0, 0));
				#endif
				#ifndef UNITY_HDR_ON
					outEmission.rgb = exp2(-outEmission.rgb);
				#endif
			}
			ENDCG
		}

	
	}
	
	
	Dependency "LightMode"="ForwardBase"

	Fallback Off
}
/*ASEBEGIN
Version=19103
Node;AmplifyShaderEditor.RangedFloatNode;2069;-1792,-4992;Half;False;Global;TVE_DEBUG_Min;TVE_DEBUG_Min;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2155;-1792,-5248;Half;False;Global;TVE_DEBUG_Layer;TVE_DEBUG_Layer;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2013;-1792,-5312;Half;False;Global;TVE_DEBUG_Index;TVE_DEBUG_Index;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1908;-1792,-5376;Half;False;Global;TVE_DEBUG_Type;TVE_DEBUG_Type;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1953;-1792,-5120;Half;False;Global;TVE_DEBUG_Filter;TVE_DEBUG_Filter;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2032;-1792,-5056;Half;False;Global;TVE_DEBUG_Clip;TVE_DEBUG_Clip;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2070;-1792,-4928;Half;False;Global;TVE_DEBUG_Max;TVE_DEBUG_Max;4;0;Create;True;0;5;Vertex Colors;100;Texture Coords;200;Vertex Postion;300;Vertex Normals;301;Vertex Tangents;302;0;True;2;Space(10);StyledEnum (Vertex Position _Vertex Normals _VertexTangents _Vertex Sign _Vertex Red (Variation) _Vertex Green (Occlusion) _Vertex Blue (Blend) _Vertex Alpha (Height) _Motion Bending _Motion Rolling _Motion Flutter);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1774;-880,2944;Inherit;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;1803;-1344,2944;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.7;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1878;-1792,-5632;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Debug);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1772;-1088,3072;Float;False;Constant;_Float3;Float 3;31;0;Create;True;0;0;0;False;0;False;24;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1931;-1408,-5632;Half;False;Property;_DebugCategory;[ Debug Category ];100;0;Create;True;0;0;0;False;1;StyledCategory(Debug Settings, 5, 10);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1843;-1632,2944;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1771;-1088,2944;Inherit;False;-1;;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1800;-1472,2944;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1804;-1792,2944;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1881;-1600,-5632;Half;False;Property;_Message;Message;101;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use this shader to debug the original mesh or the converted mesh attributes., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2109;-896,-5376;Float;False;True;-1;2;;0;4;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Debug;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardBase;0;1;ForwardBase;18;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;True;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=True=DisableBatching;True;7;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;False;0;;1;LightMode=ForwardBase;0;Standard;40;Workflow,InvertActionOnDeselection;1;0;Surface;0;0;  Blend;0;0;  Refraction Model;0;0;  Dither Shadows;1;0;Two Sided;0;638071577106831206;Deferred Pass;1;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;0;0;  Use Shadow Threshold;0;0;Receive Shadows;0;0;GPU Instancing;1;638071577280007126;LOD CrossFade;0;0;Built-in Fog;0;0;Ambient Light;0;0;Meta Pass;0;0;Add Pass;0;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Fwd Specular Highlights Toggle;0;0;Fwd Reflections Toggle;0;0;Disable Batching;1;0;Vertex Position,InvertActionOnDeselection;1;0;0;6;False;True;False;True;False;False;False;;True;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2112;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Meta;0;4;Meta;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2113;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ShadowCaster;0;5;ShadowCaster;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;True;1;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2110;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ForwardAdd;0;2;ForwardAdd;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;True;4;1;False;;1;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;True;1;LightMode=ForwardAdd;False;False;0;True;1;LightMode=ForwardAdd;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2108;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;ExtraPrePass;0;0;ExtraPrePass;6;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;True;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=ForwardBase;False;False;0;-1;59;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;=;LightMode=ForwardBase;=;=;=;=;=;=;=;=;=;=;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2111;-896,-5376;Float;False;False;-1;2;ASEMaterialInspector;0;4;New Amplify Shader;ed95fe726fd7b4644bb42f4d1ddd2bcd;True;Deferred;0;3;Deferred;0;False;True;0;1;False;;0;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;1;False;;True;3;False;;False;True;3;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;DisableBatching=False=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;True;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Deferred;True;2;False;0;False;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.FunctionNode;2203;-896,-5632;Inherit;False;Compile All Shaders;-1;;73162;e67c8238031dbf04ab79a5d4d63d1b4f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2269;-1408,-5376;Inherit;False;Tool Debug;1;;80801;d48cde928c5068141abea1713047719b;1,1236,0;7;336;FLOAT;0;False;465;FLOAT;0;False;884;FLOAT;0;False;337;FLOAT;0;False;624;FLOAT;0;False;720;FLOAT;0;False;722;FLOAT;0;False;1;COLOR;338
WireConnection;1774;0;1771;0
WireConnection;1774;1;1772;0
WireConnection;1774;3;1803;0
WireConnection;1803;0;1800;0
WireConnection;1843;0;1804;0
WireConnection;1800;0;1843;0
WireConnection;2109;2;2269;338
WireConnection;2269;336;1908;0
WireConnection;2269;465;2013;0
WireConnection;2269;884;2155;0
WireConnection;2269;337;1953;0
WireConnection;2269;624;2032;0
WireConnection;2269;720;2069;0
WireConnection;2269;722;2070;0
ASEEND*/
//CHKSM=E668C9B83652B4767956054A1456EDD59CCB3365
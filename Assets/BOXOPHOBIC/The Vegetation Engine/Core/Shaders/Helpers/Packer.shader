// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer"
{
	Properties
	{
		[HideInInspector]_MainTex("Dummy Texture", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexR("Packer_TexR", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexG("Packer_TexG", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexB("Packer_TexB", 2D) = "white" {}
		[NoScaleOffset]_Packer_TexA("Packer_TexA", 2D) = "white" {}
		[Space(10)]_Packer_FloatR("Packer_FloatR", Range( 0 , 1)) = 0
		_Packer_FloatG("Packer_FloatG", Range( 0 , 1)) = 0
		_Packer_FloatB("Packer_FloatB", Range( 0 , 1)) = 0
		_Packer_FloatA("Packer_FloatA", Range( 0 , 1)) = 0
		[Space(10)]_Packer_Action0B("Packer_Action0B", Float) = 0
		[Space(10)]_Packer_Action1B("Packer_Action1B", Float) = 0
		[Space(10)]_Packer_Action0G("Packer_Action0G", Float) = 0
		[Space(10)]_Packer_Action2B("Packer_Action2B", Float) = 0
		[Space(10)]_Packer_Action2R("Packer_Action2R", Float) = 0
		[Space(10)]_Packer_Action1R("Packer_Action1R", Float) = 0
		[Space(10)]_Packer_Action0A("Packer_Action0A", Float) = 0
		[Space(10)]_Packer_Action2G("Packer_Action2G", Float) = 0
		[Space(10)]_Packer_Action1G("Packer_Action1G", Float) = 0
		[Space(10)]_Packer_Action2A("Packer_Action2A", Float) = 0
		[Space(10)]_Packer_Action0R("Packer_Action0R", Float) = 0
		[Space(10)]_Packer_Action1A("Packer_Action1A", Float) = 0
		[IntRange]_Packer_CoordR("Packer_CoordR", Range( 0 , 4)) = 0
		[IntRange]_Packer_CoordB("Packer_CoordB", Range( 0 , 4)) = 0
		[IntRange]_Packer_CoordG("Packer_CoordG", Range( 0 , 4)) = 0
		[IntRange]_Packer_CoordA("Packer_CoordA", Range( 0 , 4)) = 0
		[IntRange][Space(10)]_Packer_ChannelR("Packer_ChannelR", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelG("Packer_ChannelG", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelB("Packer_ChannelB", Range( 0 , 4)) = 0
		[IntRange]_Packer_ChannelA("Packer_ChannelA", Range( 0 , 4)) = 0
		[Space(10)]_Packer_TexR_Space("Packer_TexR_Space", Float) = 1
		_Packer_TexG_Space("Packer_TexG_Space", Float) = 1
		_Packer_TexB_Space("Packer_TexB_Space", Float) = 1
		[ASEEnd]_Packer_TexA_Space("Packer_TexA_Space", Float) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" "PreviewType"="Plane" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform sampler2D _MainTex;
			uniform float _Packer_TexR_Space;
			uniform float _Packer_Action2R;
			uniform float _Packer_Action1R;
			uniform float _Packer_Action0R;
			uniform float _Packer_ChannelR;
			uniform float _Packer_FloatR;
			uniform sampler2D _Packer_TexR;
			uniform float _Packer_CoordR;
			uniform float _Packer_TexG_Space;
			uniform float _Packer_Action2G;
			uniform float _Packer_Action1G;
			uniform float _Packer_Action0G;
			uniform float _Packer_ChannelG;
			uniform float _Packer_FloatG;
			uniform sampler2D _Packer_TexG;
			uniform float _Packer_CoordG;
			uniform float _Packer_TexB_Space;
			uniform float _Packer_Action2B;
			uniform float _Packer_Action1B;
			uniform float _Packer_Action0B;
			uniform float _Packer_ChannelB;
			uniform float _Packer_FloatB;
			uniform sampler2D _Packer_TexB;
			uniform float _Packer_CoordB;
			uniform float _Packer_TexA_Space;
			uniform float _Packer_Action2A;
			uniform float _Packer_Action1A;
			uniform float _Packer_Action0A;
			uniform float _Packer_ChannelA;
			uniform float _Packer_FloatA;
			uniform sampler2D _Packer_TexA;
			uniform float _Packer_CoordA;
			inline float GammaToLinearFloat100_g20( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g20( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g21( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g21( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g23( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g23( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			
			inline float GammaToLinearFloat100_g22( float value )
			{
				return GammaToLinearSpaceExact(value);
			}
			
			inline float LinearToGammaFloat102_g22( float value )
			{
				return LinearToGammaSpaceExact(value);
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_texcoord1.zw = v.ase_texcoord1.xy;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				int Storage114_g20 = (int)_Packer_TexR_Space;
				int Action2189_g20 = (int)_Packer_Action2R;
				int Action1187_g20 = (int)_Packer_Action1R;
				int Action0173_g20 = (int)_Packer_Action0R;
				int Channel31_g20 = (int)_Packer_ChannelR;
				float ifLocalVar24_g20 = 0;
				if( Channel31_g20 == 0 )
				ifLocalVar24_g20 = _Packer_FloatR;
				int Index42_g18 = (int)_Packer_CoordR;
				float2 ifLocalVar40_g18 = 0;
				if( Index42_g18 == 0.0 )
				ifLocalVar40_g18 = i.ase_texcoord1.xy;
				float2 ifLocalVar47_g18 = 0;
				if( Index42_g18 == 1.0 )
				ifLocalVar47_g18 = i.ase_texcoord1.zw;
				float2 ifLocalVar50_g18 = 0;
				if( Index42_g18 == 2.0 )
				ifLocalVar50_g18 = i.ase_texcoord1.zw;
				float2 ifLocalVar54_g18 = 0;
				if( Index42_g18 == 3.0 )
				ifLocalVar54_g18 = i.ase_texcoord1.zw;
				float4 break23_g20 = tex2Dlod( _Packer_TexR, float4( ( ifLocalVar40_g18 + ifLocalVar47_g18 + ifLocalVar50_g18 + ifLocalVar54_g18 ), 0, 0.0) );
				float R39_g20 = break23_g20.r;
				float ifLocalVar13_g20 = 0;
				if( Channel31_g20 == 1 )
				ifLocalVar13_g20 = R39_g20;
				float G40_g20 = break23_g20.g;
				float ifLocalVar12_g20 = 0;
				if( Channel31_g20 == 2 )
				ifLocalVar12_g20 = G40_g20;
				float B41_g20 = break23_g20.b;
				float ifLocalVar11_g20 = 0;
				if( Channel31_g20 == 3 )
				ifLocalVar11_g20 = B41_g20;
				float A42_g20 = break23_g20.a;
				float ifLocalVar17_g20 = 0;
				if( Channel31_g20 == 4 )
				ifLocalVar17_g20 = A42_g20;
				float GRAY135_g20 = ( ( R39_g20 * 0.3 ) + ( G40_g20 * 0.59 ) + ( B41_g20 * 0.11 ) );
				float ifLocalVar62_g20 = 0;
				if( Channel31_g20 == 555 )
				ifLocalVar62_g20 = GRAY135_g20;
				float ifLocalVar154_g20 = 0;
				if( Channel31_g20 == 14 )
				ifLocalVar154_g20 = ( R39_g20 * A42_g20 );
				float ifLocalVar159_g20 = 0;
				if( Channel31_g20 == 24 )
				ifLocalVar159_g20 = ( G40_g20 * A42_g20 );
				float ifLocalVar165_g20 = 0;
				if( Channel31_g20 == 34 )
				ifLocalVar165_g20 = ( B41_g20 * A42_g20 );
				float ifLocalVar147_g20 = 0;
				if( Channel31_g20 == 5554 )
				ifLocalVar147_g20 = ( GRAY135_g20 * A42_g20 );
				float Packed_Raw182_g20 = ( ifLocalVar24_g20 + ifLocalVar13_g20 + ifLocalVar12_g20 + ifLocalVar11_g20 + ifLocalVar17_g20 + ifLocalVar62_g20 + ifLocalVar154_g20 + ifLocalVar159_g20 + ifLocalVar165_g20 + ifLocalVar147_g20 );
				float ifLocalVar180_g20 = 0;
				if( Action0173_g20 == 0 )
				ifLocalVar180_g20 = Packed_Raw182_g20;
				float ifLocalVar171_g20 = 0;
				if( Action0173_g20 == 1 )
				ifLocalVar171_g20 = ( 1.0 - Packed_Raw182_g20 );
				float Packed_Action0185_g20 = saturate( ( ifLocalVar180_g20 + ifLocalVar171_g20 ) );
				float ifLocalVar193_g20 = 0;
				if( Action1187_g20 == 0 )
				ifLocalVar193_g20 = Packed_Action0185_g20;
				float ifLocalVar197_g20 = 0;
				if( Action1187_g20 == 1 )
				ifLocalVar197_g20 = ( Packed_Action0185_g20 * 0.0 );
				float ifLocalVar207_g20 = 0;
				if( Action1187_g20 == 2 )
				ifLocalVar207_g20 = ( Packed_Action0185_g20 * 2.0 );
				float ifLocalVar248_g20 = 0;
				if( Action1187_g20 == 3 )
				ifLocalVar248_g20 = ( Packed_Action0185_g20 * 3.0 );
				float ifLocalVar211_g20 = 0;
				if( Action1187_g20 == 5 )
				ifLocalVar211_g20 = ( Packed_Action0185_g20 * 5.0 );
				float Packed_Action1202_g20 = saturate( ( ifLocalVar193_g20 + ifLocalVar197_g20 + ifLocalVar207_g20 + ifLocalVar248_g20 + ifLocalVar211_g20 ) );
				float ifLocalVar220_g20 = 0;
				if( Action2189_g20 == 0 )
				ifLocalVar220_g20 = Packed_Action1202_g20;
				float ifLocalVar254_g20 = 0;
				if( Action2189_g20 == 1 )
				ifLocalVar254_g20 = pow( Packed_Action1202_g20 , 0.0 );
				float ifLocalVar225_g20 = 0;
				if( Action2189_g20 == 2 )
				ifLocalVar225_g20 = pow( Packed_Action1202_g20 , 2.0 );
				float ifLocalVar229_g20 = 0;
				if( Action2189_g20 == 3 )
				ifLocalVar229_g20 = pow( Packed_Action1202_g20 , 3.0 );
				float ifLocalVar234_g20 = 0;
				if( Action2189_g20 == 4 )
				ifLocalVar234_g20 = pow( Packed_Action1202_g20 , 4.0 );
				float Packed_Action2237_g20 = saturate( ( ifLocalVar220_g20 + ifLocalVar254_g20 + ifLocalVar225_g20 + ifLocalVar229_g20 + ifLocalVar234_g20 ) );
				float Packed_Final112_g20 = Packed_Action2237_g20;
				float ifLocalVar105_g20 = 0;
				if( Storage114_g20 == 0.0 )
				ifLocalVar105_g20 = Packed_Final112_g20;
				float value100_g20 = Packed_Final112_g20;
				float localGammaToLinearFloat100_g20 = GammaToLinearFloat100_g20( value100_g20 );
				float ifLocalVar93_g20 = 0;
				if( Storage114_g20 == 1.0 )
				ifLocalVar93_g20 = localGammaToLinearFloat100_g20;
				float value102_g20 = Packed_Final112_g20;
				float localLinearToGammaFloat102_g20 = LinearToGammaFloat102_g20( value102_g20 );
				float ifLocalVar107_g20 = 0;
				if( Storage114_g20 == 2.0 )
				ifLocalVar107_g20 = localLinearToGammaFloat102_g20;
				float R74 = ( ifLocalVar105_g20 + ifLocalVar93_g20 + ifLocalVar107_g20 );
				int Storage114_g21 = (int)_Packer_TexG_Space;
				int Action2189_g21 = (int)_Packer_Action2G;
				int Action1187_g21 = (int)_Packer_Action1G;
				int Action0173_g21 = (int)_Packer_Action0G;
				int Channel31_g21 = (int)_Packer_ChannelG;
				float ifLocalVar24_g21 = 0;
				if( Channel31_g21 == 0 )
				ifLocalVar24_g21 = _Packer_FloatG;
				int Index42_g19 = (int)_Packer_CoordG;
				float2 ifLocalVar40_g19 = 0;
				if( Index42_g19 == 0.0 )
				ifLocalVar40_g19 = i.ase_texcoord1.xy;
				float2 ifLocalVar47_g19 = 0;
				if( Index42_g19 == 1.0 )
				ifLocalVar47_g19 = i.ase_texcoord1.zw;
				float2 ifLocalVar50_g19 = 0;
				if( Index42_g19 == 2.0 )
				ifLocalVar50_g19 = i.ase_texcoord1.zw;
				float2 ifLocalVar54_g19 = 0;
				if( Index42_g19 == 3.0 )
				ifLocalVar54_g19 = i.ase_texcoord1.zw;
				float4 break23_g21 = tex2Dlod( _Packer_TexG, float4( ( ifLocalVar40_g19 + ifLocalVar47_g19 + ifLocalVar50_g19 + ifLocalVar54_g19 ), 0, 0.0) );
				float R39_g21 = break23_g21.r;
				float ifLocalVar13_g21 = 0;
				if( Channel31_g21 == 1 )
				ifLocalVar13_g21 = R39_g21;
				float G40_g21 = break23_g21.g;
				float ifLocalVar12_g21 = 0;
				if( Channel31_g21 == 2 )
				ifLocalVar12_g21 = G40_g21;
				float B41_g21 = break23_g21.b;
				float ifLocalVar11_g21 = 0;
				if( Channel31_g21 == 3 )
				ifLocalVar11_g21 = B41_g21;
				float A42_g21 = break23_g21.a;
				float ifLocalVar17_g21 = 0;
				if( Channel31_g21 == 4 )
				ifLocalVar17_g21 = A42_g21;
				float GRAY135_g21 = ( ( R39_g21 * 0.3 ) + ( G40_g21 * 0.59 ) + ( B41_g21 * 0.11 ) );
				float ifLocalVar62_g21 = 0;
				if( Channel31_g21 == 555 )
				ifLocalVar62_g21 = GRAY135_g21;
				float ifLocalVar154_g21 = 0;
				if( Channel31_g21 == 14 )
				ifLocalVar154_g21 = ( R39_g21 * A42_g21 );
				float ifLocalVar159_g21 = 0;
				if( Channel31_g21 == 24 )
				ifLocalVar159_g21 = ( G40_g21 * A42_g21 );
				float ifLocalVar165_g21 = 0;
				if( Channel31_g21 == 34 )
				ifLocalVar165_g21 = ( B41_g21 * A42_g21 );
				float ifLocalVar147_g21 = 0;
				if( Channel31_g21 == 5554 )
				ifLocalVar147_g21 = ( GRAY135_g21 * A42_g21 );
				float Packed_Raw182_g21 = ( ifLocalVar24_g21 + ifLocalVar13_g21 + ifLocalVar12_g21 + ifLocalVar11_g21 + ifLocalVar17_g21 + ifLocalVar62_g21 + ifLocalVar154_g21 + ifLocalVar159_g21 + ifLocalVar165_g21 + ifLocalVar147_g21 );
				float ifLocalVar180_g21 = 0;
				if( Action0173_g21 == 0 )
				ifLocalVar180_g21 = Packed_Raw182_g21;
				float ifLocalVar171_g21 = 0;
				if( Action0173_g21 == 1 )
				ifLocalVar171_g21 = ( 1.0 - Packed_Raw182_g21 );
				float Packed_Action0185_g21 = saturate( ( ifLocalVar180_g21 + ifLocalVar171_g21 ) );
				float ifLocalVar193_g21 = 0;
				if( Action1187_g21 == 0 )
				ifLocalVar193_g21 = Packed_Action0185_g21;
				float ifLocalVar197_g21 = 0;
				if( Action1187_g21 == 1 )
				ifLocalVar197_g21 = ( Packed_Action0185_g21 * 0.0 );
				float ifLocalVar207_g21 = 0;
				if( Action1187_g21 == 2 )
				ifLocalVar207_g21 = ( Packed_Action0185_g21 * 2.0 );
				float ifLocalVar248_g21 = 0;
				if( Action1187_g21 == 3 )
				ifLocalVar248_g21 = ( Packed_Action0185_g21 * 3.0 );
				float ifLocalVar211_g21 = 0;
				if( Action1187_g21 == 5 )
				ifLocalVar211_g21 = ( Packed_Action0185_g21 * 5.0 );
				float Packed_Action1202_g21 = saturate( ( ifLocalVar193_g21 + ifLocalVar197_g21 + ifLocalVar207_g21 + ifLocalVar248_g21 + ifLocalVar211_g21 ) );
				float ifLocalVar220_g21 = 0;
				if( Action2189_g21 == 0 )
				ifLocalVar220_g21 = Packed_Action1202_g21;
				float ifLocalVar254_g21 = 0;
				if( Action2189_g21 == 1 )
				ifLocalVar254_g21 = pow( Packed_Action1202_g21 , 0.0 );
				float ifLocalVar225_g21 = 0;
				if( Action2189_g21 == 2 )
				ifLocalVar225_g21 = pow( Packed_Action1202_g21 , 2.0 );
				float ifLocalVar229_g21 = 0;
				if( Action2189_g21 == 3 )
				ifLocalVar229_g21 = pow( Packed_Action1202_g21 , 3.0 );
				float ifLocalVar234_g21 = 0;
				if( Action2189_g21 == 4 )
				ifLocalVar234_g21 = pow( Packed_Action1202_g21 , 4.0 );
				float Packed_Action2237_g21 = saturate( ( ifLocalVar220_g21 + ifLocalVar254_g21 + ifLocalVar225_g21 + ifLocalVar229_g21 + ifLocalVar234_g21 ) );
				float Packed_Final112_g21 = Packed_Action2237_g21;
				float ifLocalVar105_g21 = 0;
				if( Storage114_g21 == 0.0 )
				ifLocalVar105_g21 = Packed_Final112_g21;
				float value100_g21 = Packed_Final112_g21;
				float localGammaToLinearFloat100_g21 = GammaToLinearFloat100_g21( value100_g21 );
				float ifLocalVar93_g21 = 0;
				if( Storage114_g21 == 1.0 )
				ifLocalVar93_g21 = localGammaToLinearFloat100_g21;
				float value102_g21 = Packed_Final112_g21;
				float localLinearToGammaFloat102_g21 = LinearToGammaFloat102_g21( value102_g21 );
				float ifLocalVar107_g21 = 0;
				if( Storage114_g21 == 2.0 )
				ifLocalVar107_g21 = localLinearToGammaFloat102_g21;
				float G78 = ( ifLocalVar105_g21 + ifLocalVar93_g21 + ifLocalVar107_g21 );
				int Storage114_g23 = (int)_Packer_TexB_Space;
				int Action2189_g23 = (int)_Packer_Action2B;
				int Action1187_g23 = (int)_Packer_Action1B;
				int Action0173_g23 = (int)_Packer_Action0B;
				int Channel31_g23 = (int)_Packer_ChannelB;
				float ifLocalVar24_g23 = 0;
				if( Channel31_g23 == 0 )
				ifLocalVar24_g23 = _Packer_FloatB;
				int Index42_g17 = (int)_Packer_CoordB;
				float2 ifLocalVar40_g17 = 0;
				if( Index42_g17 == 0.0 )
				ifLocalVar40_g17 = i.ase_texcoord1.xy;
				float2 ifLocalVar47_g17 = 0;
				if( Index42_g17 == 1.0 )
				ifLocalVar47_g17 = i.ase_texcoord1.zw;
				float2 ifLocalVar50_g17 = 0;
				if( Index42_g17 == 2.0 )
				ifLocalVar50_g17 = i.ase_texcoord1.zw;
				float2 ifLocalVar54_g17 = 0;
				if( Index42_g17 == 3.0 )
				ifLocalVar54_g17 = i.ase_texcoord1.zw;
				float4 break23_g23 = tex2Dlod( _Packer_TexB, float4( ( ifLocalVar40_g17 + ifLocalVar47_g17 + ifLocalVar50_g17 + ifLocalVar54_g17 ), 0, 0.0) );
				float R39_g23 = break23_g23.r;
				float ifLocalVar13_g23 = 0;
				if( Channel31_g23 == 1 )
				ifLocalVar13_g23 = R39_g23;
				float G40_g23 = break23_g23.g;
				float ifLocalVar12_g23 = 0;
				if( Channel31_g23 == 2 )
				ifLocalVar12_g23 = G40_g23;
				float B41_g23 = break23_g23.b;
				float ifLocalVar11_g23 = 0;
				if( Channel31_g23 == 3 )
				ifLocalVar11_g23 = B41_g23;
				float A42_g23 = break23_g23.a;
				float ifLocalVar17_g23 = 0;
				if( Channel31_g23 == 4 )
				ifLocalVar17_g23 = A42_g23;
				float GRAY135_g23 = ( ( R39_g23 * 0.3 ) + ( G40_g23 * 0.59 ) + ( B41_g23 * 0.11 ) );
				float ifLocalVar62_g23 = 0;
				if( Channel31_g23 == 555 )
				ifLocalVar62_g23 = GRAY135_g23;
				float ifLocalVar154_g23 = 0;
				if( Channel31_g23 == 14 )
				ifLocalVar154_g23 = ( R39_g23 * A42_g23 );
				float ifLocalVar159_g23 = 0;
				if( Channel31_g23 == 24 )
				ifLocalVar159_g23 = ( G40_g23 * A42_g23 );
				float ifLocalVar165_g23 = 0;
				if( Channel31_g23 == 34 )
				ifLocalVar165_g23 = ( B41_g23 * A42_g23 );
				float ifLocalVar147_g23 = 0;
				if( Channel31_g23 == 5554 )
				ifLocalVar147_g23 = ( GRAY135_g23 * A42_g23 );
				float Packed_Raw182_g23 = ( ifLocalVar24_g23 + ifLocalVar13_g23 + ifLocalVar12_g23 + ifLocalVar11_g23 + ifLocalVar17_g23 + ifLocalVar62_g23 + ifLocalVar154_g23 + ifLocalVar159_g23 + ifLocalVar165_g23 + ifLocalVar147_g23 );
				float ifLocalVar180_g23 = 0;
				if( Action0173_g23 == 0 )
				ifLocalVar180_g23 = Packed_Raw182_g23;
				float ifLocalVar171_g23 = 0;
				if( Action0173_g23 == 1 )
				ifLocalVar171_g23 = ( 1.0 - Packed_Raw182_g23 );
				float Packed_Action0185_g23 = saturate( ( ifLocalVar180_g23 + ifLocalVar171_g23 ) );
				float ifLocalVar193_g23 = 0;
				if( Action1187_g23 == 0 )
				ifLocalVar193_g23 = Packed_Action0185_g23;
				float ifLocalVar197_g23 = 0;
				if( Action1187_g23 == 1 )
				ifLocalVar197_g23 = ( Packed_Action0185_g23 * 0.0 );
				float ifLocalVar207_g23 = 0;
				if( Action1187_g23 == 2 )
				ifLocalVar207_g23 = ( Packed_Action0185_g23 * 2.0 );
				float ifLocalVar248_g23 = 0;
				if( Action1187_g23 == 3 )
				ifLocalVar248_g23 = ( Packed_Action0185_g23 * 3.0 );
				float ifLocalVar211_g23 = 0;
				if( Action1187_g23 == 5 )
				ifLocalVar211_g23 = ( Packed_Action0185_g23 * 5.0 );
				float Packed_Action1202_g23 = saturate( ( ifLocalVar193_g23 + ifLocalVar197_g23 + ifLocalVar207_g23 + ifLocalVar248_g23 + ifLocalVar211_g23 ) );
				float ifLocalVar220_g23 = 0;
				if( Action2189_g23 == 0 )
				ifLocalVar220_g23 = Packed_Action1202_g23;
				float ifLocalVar254_g23 = 0;
				if( Action2189_g23 == 1 )
				ifLocalVar254_g23 = pow( Packed_Action1202_g23 , 0.0 );
				float ifLocalVar225_g23 = 0;
				if( Action2189_g23 == 2 )
				ifLocalVar225_g23 = pow( Packed_Action1202_g23 , 2.0 );
				float ifLocalVar229_g23 = 0;
				if( Action2189_g23 == 3 )
				ifLocalVar229_g23 = pow( Packed_Action1202_g23 , 3.0 );
				float ifLocalVar234_g23 = 0;
				if( Action2189_g23 == 4 )
				ifLocalVar234_g23 = pow( Packed_Action1202_g23 , 4.0 );
				float Packed_Action2237_g23 = saturate( ( ifLocalVar220_g23 + ifLocalVar254_g23 + ifLocalVar225_g23 + ifLocalVar229_g23 + ifLocalVar234_g23 ) );
				float Packed_Final112_g23 = Packed_Action2237_g23;
				float ifLocalVar105_g23 = 0;
				if( Storage114_g23 == 0.0 )
				ifLocalVar105_g23 = Packed_Final112_g23;
				float value100_g23 = Packed_Final112_g23;
				float localGammaToLinearFloat100_g23 = GammaToLinearFloat100_g23( value100_g23 );
				float ifLocalVar93_g23 = 0;
				if( Storage114_g23 == 1.0 )
				ifLocalVar93_g23 = localGammaToLinearFloat100_g23;
				float value102_g23 = Packed_Final112_g23;
				float localLinearToGammaFloat102_g23 = LinearToGammaFloat102_g23( value102_g23 );
				float ifLocalVar107_g23 = 0;
				if( Storage114_g23 == 2.0 )
				ifLocalVar107_g23 = localLinearToGammaFloat102_g23;
				float B79 = ( ifLocalVar105_g23 + ifLocalVar93_g23 + ifLocalVar107_g23 );
				int Storage114_g22 = (int)_Packer_TexA_Space;
				int Action2189_g22 = (int)_Packer_Action2A;
				int Action1187_g22 = (int)_Packer_Action1A;
				int Action0173_g22 = (int)_Packer_Action0A;
				int Channel31_g22 = (int)_Packer_ChannelA;
				float ifLocalVar24_g22 = 0;
				if( Channel31_g22 == 0 )
				ifLocalVar24_g22 = _Packer_FloatA;
				int Index42_g16 = (int)_Packer_CoordA;
				float2 ifLocalVar40_g16 = 0;
				if( Index42_g16 == 0.0 )
				ifLocalVar40_g16 = i.ase_texcoord1.xy;
				float2 ifLocalVar47_g16 = 0;
				if( Index42_g16 == 1.0 )
				ifLocalVar47_g16 = i.ase_texcoord1.zw;
				float2 ifLocalVar50_g16 = 0;
				if( Index42_g16 == 2.0 )
				ifLocalVar50_g16 = i.ase_texcoord1.zw;
				float2 ifLocalVar54_g16 = 0;
				if( Index42_g16 == 3.0 )
				ifLocalVar54_g16 = i.ase_texcoord1.zw;
				float4 break23_g22 = tex2Dlod( _Packer_TexA, float4( ( ifLocalVar40_g16 + ifLocalVar47_g16 + ifLocalVar50_g16 + ifLocalVar54_g16 ), 0, 0.0) );
				float R39_g22 = break23_g22.r;
				float ifLocalVar13_g22 = 0;
				if( Channel31_g22 == 1 )
				ifLocalVar13_g22 = R39_g22;
				float G40_g22 = break23_g22.g;
				float ifLocalVar12_g22 = 0;
				if( Channel31_g22 == 2 )
				ifLocalVar12_g22 = G40_g22;
				float B41_g22 = break23_g22.b;
				float ifLocalVar11_g22 = 0;
				if( Channel31_g22 == 3 )
				ifLocalVar11_g22 = B41_g22;
				float A42_g22 = break23_g22.a;
				float ifLocalVar17_g22 = 0;
				if( Channel31_g22 == 4 )
				ifLocalVar17_g22 = A42_g22;
				float GRAY135_g22 = ( ( R39_g22 * 0.3 ) + ( G40_g22 * 0.59 ) + ( B41_g22 * 0.11 ) );
				float ifLocalVar62_g22 = 0;
				if( Channel31_g22 == 555 )
				ifLocalVar62_g22 = GRAY135_g22;
				float ifLocalVar154_g22 = 0;
				if( Channel31_g22 == 14 )
				ifLocalVar154_g22 = ( R39_g22 * A42_g22 );
				float ifLocalVar159_g22 = 0;
				if( Channel31_g22 == 24 )
				ifLocalVar159_g22 = ( G40_g22 * A42_g22 );
				float ifLocalVar165_g22 = 0;
				if( Channel31_g22 == 34 )
				ifLocalVar165_g22 = ( B41_g22 * A42_g22 );
				float ifLocalVar147_g22 = 0;
				if( Channel31_g22 == 5554 )
				ifLocalVar147_g22 = ( GRAY135_g22 * A42_g22 );
				float Packed_Raw182_g22 = ( ifLocalVar24_g22 + ifLocalVar13_g22 + ifLocalVar12_g22 + ifLocalVar11_g22 + ifLocalVar17_g22 + ifLocalVar62_g22 + ifLocalVar154_g22 + ifLocalVar159_g22 + ifLocalVar165_g22 + ifLocalVar147_g22 );
				float ifLocalVar180_g22 = 0;
				if( Action0173_g22 == 0 )
				ifLocalVar180_g22 = Packed_Raw182_g22;
				float ifLocalVar171_g22 = 0;
				if( Action0173_g22 == 1 )
				ifLocalVar171_g22 = ( 1.0 - Packed_Raw182_g22 );
				float Packed_Action0185_g22 = saturate( ( ifLocalVar180_g22 + ifLocalVar171_g22 ) );
				float ifLocalVar193_g22 = 0;
				if( Action1187_g22 == 0 )
				ifLocalVar193_g22 = Packed_Action0185_g22;
				float ifLocalVar197_g22 = 0;
				if( Action1187_g22 == 1 )
				ifLocalVar197_g22 = ( Packed_Action0185_g22 * 0.0 );
				float ifLocalVar207_g22 = 0;
				if( Action1187_g22 == 2 )
				ifLocalVar207_g22 = ( Packed_Action0185_g22 * 2.0 );
				float ifLocalVar248_g22 = 0;
				if( Action1187_g22 == 3 )
				ifLocalVar248_g22 = ( Packed_Action0185_g22 * 3.0 );
				float ifLocalVar211_g22 = 0;
				if( Action1187_g22 == 5 )
				ifLocalVar211_g22 = ( Packed_Action0185_g22 * 5.0 );
				float Packed_Action1202_g22 = saturate( ( ifLocalVar193_g22 + ifLocalVar197_g22 + ifLocalVar207_g22 + ifLocalVar248_g22 + ifLocalVar211_g22 ) );
				float ifLocalVar220_g22 = 0;
				if( Action2189_g22 == 0 )
				ifLocalVar220_g22 = Packed_Action1202_g22;
				float ifLocalVar254_g22 = 0;
				if( Action2189_g22 == 1 )
				ifLocalVar254_g22 = pow( Packed_Action1202_g22 , 0.0 );
				float ifLocalVar225_g22 = 0;
				if( Action2189_g22 == 2 )
				ifLocalVar225_g22 = pow( Packed_Action1202_g22 , 2.0 );
				float ifLocalVar229_g22 = 0;
				if( Action2189_g22 == 3 )
				ifLocalVar229_g22 = pow( Packed_Action1202_g22 , 3.0 );
				float ifLocalVar234_g22 = 0;
				if( Action2189_g22 == 4 )
				ifLocalVar234_g22 = pow( Packed_Action1202_g22 , 4.0 );
				float Packed_Action2237_g22 = saturate( ( ifLocalVar220_g22 + ifLocalVar254_g22 + ifLocalVar225_g22 + ifLocalVar229_g22 + ifLocalVar234_g22 ) );
				float Packed_Final112_g22 = Packed_Action2237_g22;
				float ifLocalVar105_g22 = 0;
				if( Storage114_g22 == 0.0 )
				ifLocalVar105_g22 = Packed_Final112_g22;
				float value100_g22 = Packed_Final112_g22;
				float localGammaToLinearFloat100_g22 = GammaToLinearFloat100_g22( value100_g22 );
				float ifLocalVar93_g22 = 0;
				if( Storage114_g22 == 1.0 )
				ifLocalVar93_g22 = localGammaToLinearFloat100_g22;
				float value102_g22 = Packed_Final112_g22;
				float localLinearToGammaFloat102_g22 = LinearToGammaFloat102_g22( value102_g22 );
				float ifLocalVar107_g22 = 0;
				if( Storage114_g22 == 2.0 )
				ifLocalVar107_g22 = localLinearToGammaFloat102_g22;
				float A80 = ( ifLocalVar105_g22 + ifLocalVar93_g22 + ifLocalVar107_g22 );
				float4 appendResult48 = (float4(R74 , G78 , B79 , A80));
				
				
				finalColor = appendResult48;
				return finalColor;
			}
			ENDCG
		}
	}
	
	
	
}
/*ASEBEGIN
Version=18935
1920;12;1920;1017;1558.656;-2023.536;1.633594;True;False
Node;AmplifyShaderEditor.RangedFloatNode;323;-768,2688;Float;False;Property;_Packer_CoordA;Packer_CoordA;28;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;320;-768,1792;Float;False;Property;_Packer_CoordB;Packer_CoordB;24;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;317;-768,896;Float;False;Property;_Packer_CoordG;Packer_CoordG;26;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;309;-768,0;Float;False;Property;_Packer_CoordR;Packer_CoordR;21;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;322;-384,2688;Inherit;False;Tool Coords;-1;;16;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;INT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;319;-384,1792;Inherit;False;Tool Coords;-1;;17;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;INT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;314;-384,0;Inherit;False;Tool Coords;-1;;18;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;INT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;316;-384,896;Inherit;False;Tool Coords;-1;;19;da63d4e23383c5c4298f6ecca9db7d6f;0;1;34;INT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;283;-128,512;Float;False;Property;_Packer_Action2R;Packer_Action2R;13;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-128,3328;Float;False;Property;_Packer_TexA_Space;Packer_TexA_Space;36;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;289;-128,2304;Float;False;Property;_Packer_Action2B;Packer_Action2B;12;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;-128,2176;Float;False;Property;_Packer_Action0B;Packer_Action0B;9;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;-128,2688;Inherit;True;Property;_Packer_TexA;Packer_TexA;4;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER3D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;285;-128,1344;Float;False;Property;_Packer_Action1G;Packer_Action1G;17;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-128,1984;Float;False;Property;_Packer_FloatB;Packer_FloatB;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-128,1168;Float;False;Property;_Packer_ChannelG;Packer_ChannelG;30;1;[IntRange];Create;True;0;0;0;False;0;False;0;2;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;282;-128,448;Float;False;Property;_Packer_Action1R;Packer_Action1R;14;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;257;-128,384;Float;False;Property;_Packer_Action0R;Packer_Action0R;19;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-128,192;Float;False;Property;_Packer_FloatR;Packer_FloatR;5;0;Create;True;0;0;0;False;1;Space(10);False;0;0.519;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;140;-128,2432;Float;False;Property;_Packer_TexB_Space;Packer_TexB_Space;35;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-128,2064;Float;False;Property;_Packer_ChannelB;Packer_ChannelB;31;1;[IntRange];Create;True;0;0;0;False;0;False;0;3;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-128,272;Float;False;Property;_Packer_ChannelR;Packer_ChannelR;29;1;[IntRange];Create;True;0;0;0;False;1;Space(10);False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-128,2960;Float;False;Property;_Packer_ChannelA;Packer_ChannelA;32;1;[IntRange];Create;True;0;0;0;False;0;False;0;4;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-128,2880;Float;False;Property;_Packer_FloatA;Packer_FloatA;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;51;-128,896;Inherit;True;Property;_Packer_TexG;Packer_TexG;2;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER3D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;26;-128,0;Inherit;True;Property;_Packer_TexR;Packer_TexR;1;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER3D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;288;-128,2240;Float;False;Property;_Packer_Action1B;Packer_Action1B;10;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;290;-128,3072;Float;False;Property;_Packer_Action0A;Packer_Action0A;15;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;284;-128,1280;Float;False;Property;_Packer_Action0G;Packer_Action0G;11;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;291;-128,3136;Float;False;Property;_Packer_Action1A;Packer_Action1A;20;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;-128,1792;Inherit;True;Property;_Packer_TexB;Packer_TexB;3;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;LockedToTexture2D;False;Object;-1;MipLevel;Texture2D;8;0;SAMPLER3D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;50;-128,1088;Float;False;Property;_Packer_FloatG;Packer_FloatG;6;0;Create;True;0;0;0;False;0;False;0;0.356;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;286;-128,1408;Float;False;Property;_Packer_Action2G;Packer_Action2G;16;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;292;-128,3200;Float;False;Property;_Packer_Action2A;Packer_Action2A;18;0;Create;True;0;0;0;False;1;Space(10);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-128,1536;Float;False;Property;_Packer_TexG_Space;Packer_TexG_Space;34;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-128,640;Float;False;Property;_Packer_TexR_Space;Packer_TexR_Space;33;0;Create;True;0;0;0;False;1;Space(10);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;310;384,1792;Inherit;False;Tool Packer;-1;;23;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;312;384,2688;Inherit;False;Tool Packer;-1;;22;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;313;384,0;Inherit;False;Tool Packer;-1;;20;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;311;384,896;Inherit;False;Tool Packer;-1;;21;7c427933118005a479c95a1271b737a6;0;8;19;COLOR;0,0,0,0;False;25;FLOAT;0;False;10;INT;0;False;172;INT;0;False;241;INT;0;False;242;INT;0;False;243;INT;0;False;56;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;704,0;Float;False;R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;704,896;Float;False;G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;79;704,1792;Float;False;B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;704,2688;Float;False;A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;1536,0;Inherit;False;74;R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;1536,80;Inherit;False;78;G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;1536,160;Inherit;False;79;B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;1536,240;Inherit;False;80;A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;318;-768,960;Float;False;Property;_Packer_LayerG;Packer_LayerG;22;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;324;-768,2752;Float;False;Property;_Packer_LayerA;Packer_LayerA;27;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;321;-768,1856;Float;False;Property;_Packer_LayerB;Packer_LayerB;25;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;315;-768,64;Float;False;Property;_Packer_LayerR;Packer_LayerR;23;1;[IntRange];Create;True;0;0;0;False;0;False;0;1;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;155;2304,0;Inherit;True;Property;_MainTex;Dummy Texture;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;48;1792,0;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1984,0;Float;False;True;-1;2;;0;1;Hidden/BOXOPHOBIC/The Vegetation Engine/Helpers/Packer;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;2;RenderType=Opaque=RenderType;PreviewType=Plane;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
WireConnection;322;34;323;0
WireConnection;319;34;320;0
WireConnection;314;34;309;0
WireConnection;316;34;317;0
WireConnection;60;1;322;0
WireConnection;51;1;316;0
WireConnection;26;1;314;0
WireConnection;57;1;319;0
WireConnection;310;19;57;0
WireConnection;310;25;59;0
WireConnection;310;10;67;0
WireConnection;310;172;287;0
WireConnection;310;241;288;0
WireConnection;310;242;289;0
WireConnection;310;56;140;0
WireConnection;312;19;60;0
WireConnection;312;25;64;0
WireConnection;312;10;68;0
WireConnection;312;172;290;0
WireConnection;312;241;291;0
WireConnection;312;242;292;0
WireConnection;312;56;142;0
WireConnection;313;19;26;0
WireConnection;313;25;47;0
WireConnection;313;10;65;0
WireConnection;313;172;257;0
WireConnection;313;241;282;0
WireConnection;313;242;283;0
WireConnection;313;56;72;0
WireConnection;311;19;51;0
WireConnection;311;25;50;0
WireConnection;311;10;66;0
WireConnection;311;172;284;0
WireConnection;311;241;285;0
WireConnection;311;242;286;0
WireConnection;311;56;138;0
WireConnection;74;0;313;0
WireConnection;78;0;311;0
WireConnection;79;0;310;0
WireConnection;80;0;312;0
WireConnection;48;0;143;0
WireConnection;48;1;144;0
WireConnection;48;2;146;0
WireConnection;48;3;145;0
WireConnection;0;0;48;0
ASEEND*/
//CHKSM=DEA636D04FE2B9E82BCBD365008FFE0A8B9EC40E
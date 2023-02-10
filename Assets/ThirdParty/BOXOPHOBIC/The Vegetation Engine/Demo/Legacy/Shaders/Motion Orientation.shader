// Made with Amplify Shader Editor v1.9.1.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Orientation"
{
	Properties
	{
		[StyledBanner(Motion Orientation Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Motion Orientation elements to change the motion direction based on the Element Texture. Element Texture RG is used a World XZ direction and Texture A is used as alpha mask. Particle Color A is used as Element Intensity multiplier., 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_CategoryRender("[ Category Render ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Render Layer Warning", Float) = 0
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Render Layer Message", Float) = 0
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[Enum(Affect Material Interaction,13,Affect Interaction and Wind Power,15)]_ElementMotionMode("Render Effect", Float) = 15
		[StyledCategory(Element Settings)]_CategoryElement("[ Category Element ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainTex("Element Texture", 2D) = "white" {}
		[Space(10)][StyledRemapSlider(_MainTexColorMinValue, _MainTexColorMaxValue, 0, 1)]_MainTexColorRemap("Element Color", Vector) = (0,0,0,0)
		[StyledRemapSlider(_MainTexAlphaMinValue, _MainTexAlphaMaxValue, 0, 1)]_MainTexAlphaRemap("Element Alpha", Vector) = (0,0,0,0)
		[HideInInspector]_MainTexColorMinValue("Element Color Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexColorMaxValue("Element Color Max", Range( 0 , 1)) = 1
		[HideInInspector]_MainTexAlphaMinValue("Element Alpha Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexAlphaMaxValue("Element Alpha Max", Range( 0 , 1)) = 1
		[StyledVector(9)]_MainUVs("Element UVs", Vector) = (1,1,0,0)
		[StyledTextureSingleLine]_NoiseTex("Noise Texture", 2D) = "gray" {}
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1, 10, 0)]_NoiseRemap("Noise Remap", Vector) = (0,0,0,0)
		[HideInInspector]_NoiseMinValue("Noise Min", Range( 0 , 1)) = 0
		[HideInInspector]_NoiseMaxValue("Noise Max", Range( 0 , 1)) = 1
		_NoiseIntensityValue("Noise Intensity", Range( 0 , 1)) = 0
		_NoiseScaleValue("Noise Scale", Range( 0 , 20)) = 1
		_NoiseSpeedValue("Noise Speed", Range( 0 , 2)) = 1
		_MotionPower("Wind Power", Range( 0 , 1)) = 0
		[StyledMessage(Info, The Particle Velocity mode requires the particle to have custom vertex streams for Velocity and Speed set after the UV stream under the particle Renderer module. , _ElementDirectionMode, 40, 10, 0)]_ElementDirectionMessage("Element Direction Message", Float) = 0
		[Enum(Element Forward,10,Element Texture,20,Particle Translate,30,Particle Velocity,40)][Space(10)]_ElementDirectionMode("Direction Mode", Float) = 20
		[Space(10)][StyledToggle]_ElementInvertMode("Use Inverted Element Direction", Float) = 0
		[StyledCategory(Fading Settings)]_CategoryFade("[ Category Fade ]", Float) = 0
		[HDR][StyledToggle]_ElementRaycastMode("Enable Raycast Fading", Float) = 0
		[StyledToggle]_ElementVolumeFadeMode("Enable Volume Edge Fading", Float) = 0
		[HideInInspector]_RaycastFadeValue("Raycast Fade Mask", Float) = 1
		[Space(10)][StyledLayers()]_RaycastLayerMask("Raycast Layer", Float) = 1
		_RaycastDistanceEndValue("Raycast Distance", Float) = 2
		[ASEEnd][StyledCategory(Advanced Settings)]_CategoryAdvanced("[ Category Advanced ]", Float) = 0
		[HideInInspector]_ElementLayerValue("Legacy Layer Value", Float) = -1
		[HideInInspector]_InvertX("Legacy Invert Mode", Float) = 0
		[HideInInspector]_ElementFadeSupport("Legacy Edge Fading", Float) = 0
		[HideInInspector]_IsVersion("_IsVersion", Float) = 820
		[HideInInspector]_IsElementShader("_IsElementShader", Float) = 1
		[HideInInspector]_element_direction_mode("_element_direction_mode", Vector) = (0,0,0,0)
		[HideInInspector]_IsMotionElement("_IsMotionElement", Float) = 1
		[HideInInspector]_render_colormask("_render_colormask", Float) = 15

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" "DisableBatching"="True" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha, One One
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite Off
		ZTest LEqual
		
		
		
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
			#include "UnityShaderVariables.cginc"
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			// Element Type Define
			#define TVE_IS_MOTION_ELEMENT


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
				float4 ase_color : COLOR;
				float4 ase_texcoord2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _IsMotionElement;
			uniform half _Banner;
			uniform half _Message;
			uniform half _render_colormask;
			uniform half _IsElementShader;
			uniform float _ElementFadeSupport;
			uniform half _ElementLayerValue;
			uniform float _InvertX;
			uniform half _CategoryRender;
			uniform half _CategoryElement;
			uniform half _CategoryFade;
			uniform half _ElementLayerMask;
			uniform half _RaycastDistanceEndValue;
			uniform half _RaycastLayerMask;
			uniform half _ElementLayerMessage;
			uniform half _ElementLayerWarning;
			uniform half _ElementRaycastMode;
			uniform float _IsVersion;
			uniform half4 _MainTexAlphaRemap;
			uniform half4 _NoiseRemap;
			uniform half _ElementDirectionMessage;
			uniform float _ElementDirectionMode;
			uniform half4 _MainTexColorRemap;
			uniform half _CategoryAdvanced;
			uniform half4 _element_direction_mode;
			uniform sampler2D _MainTex;
			uniform half4 _MainUVs;
			uniform half _MainTexColorMinValue;
			uniform half _MainTexColorMaxValue;
			uniform float _ElementInvertMode;
			uniform sampler2D _NoiseTex;
			uniform half _NoiseScaleValue;
			uniform half _NoiseSpeedValue;
			uniform half _NoiseMinValue;
			uniform half _NoiseMaxValue;
			uniform half _NoiseIntensityValue;
			uniform half _MotionPower;
			uniform half _MainTexAlphaMinValue;
			uniform half _MainTexAlphaMaxValue;
			uniform float _ElementIntensity;
			uniform half4 TVE_ColorsCoords;
			uniform half4 TVE_ExtrasCoords;
			uniform half4 TVE_MotionCoords;
			uniform half4 TVE_VertexCoords;
			uniform half TVE_ElementsFadeValue;
			uniform float _ElementVolumeFadeMode;
			uniform half _RaycastFadeValue;
			uniform half _ElementMotionMode;
			half4 IS_ELEMENT( half4 Colors, half4 Extras, half4 Motion, half4 Vertex )
			{
				#if defined (TVE_IS_COLORS_ELEMENT)
				return Colors;
				#elif defined (TVE_IS_EXTRAS_ELEMENT)
				return Extras;
				#elif defined (TVE_IS_MOTION_ELEMENT)
				return Motion;
				#elif defined (TVE_IS_VERTEX_ELEMENT)
				return Vertex;
				#else
				return Colors;
				#endif
			}
			

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1 = v.ase_texcoord;
				o.ase_color = v.color;
				o.ase_texcoord2 = v.ase_texcoord1;
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
				float3 ase_objectScale = float3( length( unity_ObjectToWorld[ 0 ].xyz ), length( unity_ObjectToWorld[ 1 ].xyz ), length( unity_ObjectToWorld[ 2 ].xyz ) );
				half2 Direction_Transform1406_g20879 = (( mul( unity_ObjectToWorld, float4( float3(0,0,1) , 0.0 ) ).xyz / ase_objectScale )).xz;
				half4 MainTex_RGBA587_g20879 = tex2D( _MainTex, ( ( ( 1.0 - i.ase_texcoord1.xy ) * (_MainUVs).xy ) + (_MainUVs).zw ) );
				float temp_output_7_0_g20897 = _MainTexColorMinValue;
				float3 temp_cast_2 = (temp_output_7_0_g20897).xxx;
				float3 break1524_g20879 = saturate( saturate( ( ( (MainTex_RGBA587_g20879).rgb - temp_cast_2 ) / ( _MainTexColorMaxValue - temp_output_7_0_g20897 ) ) ) );
				half MainTex_R_Remap73_g20879 = break1524_g20879.x;
				half MainTex_G_Remap265_g20879 = break1524_g20879.y;
				float3 appendResult274_g20879 = (float3((MainTex_R_Remap73_g20879*2.0 + -1.0) , 0.0 , (MainTex_G_Remap265_g20879*2.0 + -1.0)));
				float3 break281_g20879 = ( mul( unity_ObjectToWorld, float4( appendResult274_g20879 , 0.0 ) ).xyz / ase_objectScale );
				float2 appendResult1403_g20879 = (float2(break281_g20879.x , break281_g20879.z));
				half2 Direction_Texture284_g20879 = appendResult1403_g20879;
				float2 appendResult1404_g20879 = (float2(i.ase_color.r , i.ase_color.g));
				half2 Direction_VertexColor1150_g20879 = (appendResult1404_g20879*2.0 + -1.0);
				float2 appendResult1382_g20879 = (float2(i.ase_texcoord1.z , i.ase_texcoord2.x));
				half2 Direction_Velocity1394_g20879 = ( appendResult1382_g20879 / i.ase_texcoord2.y );
				float2 temp_output_1452_0_g20879 = ( ( _element_direction_mode.x * Direction_Transform1406_g20879 ) + ( _element_direction_mode.y * Direction_Texture284_g20879 ) + ( _element_direction_mode.z * Direction_VertexColor1150_g20879 ) + ( _element_direction_mode.w * Direction_Velocity1394_g20879 ) );
				half Element_InvertMode489_g20879 = _ElementInvertMode;
				float2 lerpResult1468_g20879 = lerp( temp_output_1452_0_g20879 , -temp_output_1452_0_g20879 , Element_InvertMode489_g20879);
				half2 Direction_Advanced1454_g20879 = lerpResult1468_g20879;
				float2 appendResult1347_g20879 = (float2(WorldPosition.x , WorldPosition.z));
				half Noise_Scale892_g20879 = _NoiseScaleValue;
				half2 Noise_Coords1409_g20879 = ( -( appendResult1347_g20879 * 0.1 ) * Noise_Scale892_g20879 );
				float2 temp_output_3_0_g20893 = Noise_Coords1409_g20879;
				float2 temp_output_21_0_g20893 = Direction_Advanced1454_g20879;
				half Noise_Speed898_g20879 = _NoiseSpeedValue;
				float temp_output_15_0_g20893 = ( _Time.y * Noise_Speed898_g20879 );
				float temp_output_23_0_g20893 = frac( temp_output_15_0_g20893 );
				float4 lerpResult39_g20893 = lerp( tex2D( _NoiseTex, ( temp_output_3_0_g20893 + ( temp_output_21_0_g20893 * temp_output_23_0_g20893 ) ) ) , tex2D( _NoiseTex, ( temp_output_3_0_g20893 + ( temp_output_21_0_g20893 * frac( ( temp_output_15_0_g20893 + 0.5 ) ) ) ) ) , ( abs( ( temp_output_23_0_g20893 - 0.5 ) ) / 0.5 ));
				half Noise_Min893_g20879 = _NoiseMinValue;
				float temp_output_7_0_g20894 = Noise_Min893_g20879;
				float4 temp_cast_5 = (temp_output_7_0_g20894).xxxx;
				half Noise_Max894_g20879 = _NoiseMaxValue;
				half2 Noise_Advanced1427_g20879 = (saturate( ( ( lerpResult39_g20893 - temp_cast_5 ) / ( Noise_Max894_g20879 - temp_output_7_0_g20894 ) ) )).rg;
				half Noise_Intensity965_g20879 = _NoiseIntensityValue;
				float2 lerpResult1435_g20879 = lerp( (Direction_Advanced1454_g20879*0.5 + 0.5) , Noise_Advanced1427_g20879 , Noise_Intensity965_g20879);
				half Motion_Power1000_g20879 = _MotionPower;
				float3 appendResult1436_g20879 = (float3(lerpResult1435_g20879 , Motion_Power1000_g20879));
				half3 Final_MotionAdvanced_RGB1438_g20879 = appendResult1436_g20879;
				float temp_output_7_0_g20896 = _MainTexAlphaMinValue;
				half MainTex_A_Remap74_g20879 = saturate( saturate( ( ( (MainTex_RGBA587_g20879).a - temp_output_7_0_g20896 ) / ( _MainTexAlphaMaxValue - temp_output_7_0_g20896 ) ) ) );
				half4 Colors37_g20884 = TVE_ColorsCoords;
				half4 Extras37_g20884 = TVE_ExtrasCoords;
				half4 Motion37_g20884 = TVE_MotionCoords;
				half4 Vertex37_g20884 = TVE_VertexCoords;
				half4 localIS_ELEMENT37_g20884 = IS_ELEMENT( Colors37_g20884 , Extras37_g20884 , Motion37_g20884 , Vertex37_g20884 );
				float4 temp_output_35_0_g20885 = localIS_ELEMENT37_g20884;
				float temp_output_7_0_g20890 = TVE_ElementsFadeValue;
				float2 temp_cast_6 = (temp_output_7_0_g20890).xx;
				float2 temp_output_846_0_g20879 = saturate( ( ( abs( (( (temp_output_35_0_g20885).zw + ( (temp_output_35_0_g20885).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_6 ) / ( 1.0 - temp_output_7_0_g20890 ) ) );
				float2 break852_g20879 = ( temp_output_846_0_g20879 * temp_output_846_0_g20879 );
				float lerpResult842_g20879 = lerp( 1.0 , ( 1.0 - saturate( ( break852_g20879.x + break852_g20879.y ) ) ) , _ElementVolumeFadeMode);
				half Fade_EdgeMask656_g20879 = lerpResult842_g20879;
				half Element_Intensity56_g20879 = ( _ElementIntensity * i.ase_color.a * Fade_EdgeMask656_g20879 * _RaycastFadeValue );
				half Final_MotionAdvanced_A1439_g20879 = ( MainTex_A_Remap74_g20879 * Element_Intensity56_g20879 );
				float4 appendResult1463_g20879 = (float4(Final_MotionAdvanced_RGB1438_g20879 , Final_MotionAdvanced_A1439_g20879));
				half Element_EffectMotion946_g20879 = _ElementMotionMode;
				
				
				finalColor = ( appendResult1463_g20879 + ( Element_EffectMotion946_g20879 * 0.0 ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "TVEShaderElementGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19103
Node;AmplifyShaderEditor.FunctionNode;117;-640,-1280;Inherit;False;Define Element Motion;71;;19417;6eebc31017d99e84e811285e6a5d199d;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-384,-1280;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Motion Orientation Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-256,-1280;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Motion Orientation elements to change the motion direction based on the Element Texture. Element Texture RG is used a World XZ direction and Texture A is used as alpha mask. Particle Color A is used as Element Intensity multiplier., 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;-640,-1152;Half;False;Property;_render_colormask;_render_colormask;73;1;[HideInInspector];Create;True;0;0;0;True;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-1024;Float;False;True;-1;2;TVEShaderElementGUI;0;5;Hidden/BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Orientation;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;True;2;5;False;;10;False;;4;1;False;;1;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;True;True;True;True;True;True;0;False;_render_colormask;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;4;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;DisableBatching=True=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.FunctionNode;166;-638,-1024;Inherit;False;Base Element;2;;20879;0e972c73cae2ee54ea51acc9738801d0;5,477,2,478,0,145,3,481,2,491,1;0;1;FLOAT4;0
WireConnection;0;0;166;0
ASEEND*/
//CHKSM=71AC67BA6475FF2909C4723D3706929E34FA47D7
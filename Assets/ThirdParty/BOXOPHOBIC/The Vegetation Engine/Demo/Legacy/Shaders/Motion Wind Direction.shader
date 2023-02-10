// Made with Amplify Shader Editor v1.9.1.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hidden/BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Wind Direction"
{
	Properties
	{
		[StyledBanner(Motion Direction Element)]_Banner("Banner", Float) = 0
		[StyledMessage(Info, Use the Motion Direction elements to change the wind direction based on the element forward direction. Element Texture A is used as alpha mask. Particle Color A is used as Element Intensity multiplier. , 0,0)]_Message("Message", Float) = 0
		[StyledCategory(Render Settings)]_CategoryRender("[ Category Render ]", Float) = 0
		_ElementIntensity("Render Intensity", Range( 0 , 1)) = 1
		[StyledMessage(Warning, When using all layers the Global Volume will create one render texture for each layer to render the elements. Try using fewer layers when possible., _ElementLayerWarning, 1, 10, 10)]_ElementLayerWarning("Render Layer Warning", Float) = 0
		[StyledMessage(Info, When using a higher Layer number the Global Volume will create more render textures to render the elements. Try using fewer layers when possible., _ElementLayerMessage, 1, 10, 10)]_ElementLayerMessage("Render Layer Message", Float) = 0
		[StyledMask(TVELayers, Default 0 Layer_1 1 Layer_2 2 Layer_3 3 Layer_4 4 Layer_5 5 Layer_6 6 Layer_7 7 Layer_8 8, 0, 0)]_ElementLayerMask("Render Layer", Float) = 1
		[Enum(Constant,0,Seasons,1)]_ElementMode("Render Mode", Float) = 0
		[StyledCategory(Element Settings)]_CategoryElement("[ Category Element ]", Float) = 0
		[NoScaleOffset][StyledTextureSingleLine]_MainTex("Element Texture", 2D) = "white" {}
		[Space(10)][StyledRemapSlider(_MainTexColorMinValue, _MainTexColorMaxValue, 0, 1)]_MainTexColorRemap("Element Color", Vector) = (0,0,0,0)
		[StyledRemapSlider(_MainTexAlphaMinValue, _MainTexAlphaMaxValue, 0, 1)]_MainTexAlphaRemap("Element Alpha", Vector) = (0,0,0,0)
		[HideInInspector]_MainTexColorMinValue("Element Color Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexColorMaxValue("Element Color Max", Range( 0 , 1)) = 1
		[HideInInspector]_MainTexAlphaMinValue("Element Alpha Min", Range( 0 , 1)) = 0
		[HideInInspector]_MainTexAlphaMaxValue("Element Alpha Max", Range( 0 , 1)) = 1
		[StyledVector(9)]_MainUVs("Element UVs", Vector) = (1,1,0,0)
		_MainValue("Element Value", Range( 0 , 1)) = 1
		_AdditionalValue1("Winter Value", Range( 0 , 1)) = 1
		_AdditionalValue2("Spring Value", Range( 0 , 1)) = 1
		_AdditionalValue3("Summer Value", Range( 0 , 1)) = 1
		_AdditionalValue4("Autumn Value", Range( 0 , 1)) = 1
		[StyledRemapSlider(_NoiseMinValue, _NoiseMaxValue, 0, 1, 10, 0)]_NoiseRemap("Noise Remap", Vector) = (0,0,0,0)
		[StyledMessage(Info, The Particle Velocity mode requires the particle to have custom vertex streams for Velocity and Speed set after the UV stream under the particle Renderer module. , _ElementDirectionMode, 40, 10, 0)]_ElementDirectionMessage("Element Direction Message", Float) = 0
		[Enum(Element Forward,10,Element Texture,20,Particle Translate,30,Particle Velocity,40)][Space(10)]_ElementDirectionMode("Direction Mode", Float) = 20
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
		[HideInInspector]_IsMotionElement("_IsMotionElement", Float) = 1

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Transparent" "Queue"="Transparent" "PreviewType"="Plane" "DisableBatching"="True" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask RG
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
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			// Element Type Define
			#define TVE_IS_MOTION_ELEMENT


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
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
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _Banner;
			uniform half _IsMotionElement;
			uniform half _Message;
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
			uniform half _MainValue;
			uniform half4 TVE_SeasonOptions;
			uniform half _AdditionalValue1;
			uniform half _AdditionalValue2;
			uniform half TVE_SeasonLerp;
			uniform half _AdditionalValue3;
			uniform half _AdditionalValue4;
			uniform float _ElementMode;
			uniform sampler2D _MainTex;
			uniform half4 _MainUVs;
			uniform half _MainTexColorMinValue;
			uniform half _MainTexColorMaxValue;
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

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				o.ase_color = v.color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
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
				half Value_Main157_g53336 = _MainValue;
				half TVE_SeasonOptions_X50_g53336 = TVE_SeasonOptions.x;
				half Value_Winter158_g53336 = _AdditionalValue1;
				half Value_Spring159_g53336 = _AdditionalValue2;
				half TVE_SeasonLerp54_g53336 = TVE_SeasonLerp;
				float lerpResult168_g53336 = lerp( Value_Winter158_g53336 , Value_Spring159_g53336 , TVE_SeasonLerp54_g53336);
				half TVE_SeasonOptions_Y51_g53336 = TVE_SeasonOptions.y;
				half Value_Summer160_g53336 = _AdditionalValue3;
				float lerpResult167_g53336 = lerp( Value_Spring159_g53336 , Value_Summer160_g53336 , TVE_SeasonLerp54_g53336);
				half TVE_SeasonOptions_Z52_g53336 = TVE_SeasonOptions.z;
				half Value_Autumn161_g53336 = _AdditionalValue4;
				float lerpResult166_g53336 = lerp( Value_Summer160_g53336 , Value_Autumn161_g53336 , TVE_SeasonLerp54_g53336);
				half TVE_SeasonOptions_W53_g53336 = TVE_SeasonOptions.w;
				float lerpResult165_g53336 = lerp( Value_Autumn161_g53336 , Value_Winter158_g53336 , TVE_SeasonLerp54_g53336);
				half Element_Mode55_g53336 = _ElementMode;
				float lerpResult181_g53336 = lerp( Value_Main157_g53336 , ( ( TVE_SeasonOptions_X50_g53336 * lerpResult168_g53336 ) + ( TVE_SeasonOptions_Y51_g53336 * lerpResult167_g53336 ) + ( TVE_SeasonOptions_Z52_g53336 * lerpResult166_g53336 ) + ( TVE_SeasonOptions_W53_g53336 * lerpResult165_g53336 ) ) , Element_Mode55_g53336);
				half4 MainTex_RGBA587_g53336 = tex2D( _MainTex, ( ( ( 1.0 - i.ase_texcoord1.xy ) * (_MainUVs).xy ) + (_MainUVs).zw ) );
				float temp_output_7_0_g53354 = _MainTexColorMinValue;
				float3 temp_cast_0 = (temp_output_7_0_g53354).xxx;
				float3 break1524_g53336 = saturate( saturate( ( ( (MainTex_RGBA587_g53336).rgb - temp_cast_0 ) / ( _MainTexColorMaxValue - temp_output_7_0_g53354 ) ) ) );
				half MainTex_R_Remap73_g53336 = break1524_g53336.x;
				half Base_Extras_RGB213_g53336 = ( lerpResult181_g53336 * MainTex_R_Remap73_g53336 * i.ase_color.r );
				float3 appendResult1191_g53336 = (float3(1.0 , 0.0 , Base_Extras_RGB213_g53336));
				half3 Final_MotionPower_RGB1190_g53336 = appendResult1191_g53336;
				float temp_output_7_0_g53353 = _MainTexAlphaMinValue;
				half MainTex_A_Remap74_g53336 = saturate( saturate( ( ( (MainTex_RGBA587_g53336).a - temp_output_7_0_g53353 ) / ( _MainTexAlphaMaxValue - temp_output_7_0_g53353 ) ) ) );
				half4 Colors37_g53341 = TVE_ColorsCoords;
				half4 Extras37_g53341 = TVE_ExtrasCoords;
				half4 Motion37_g53341 = TVE_MotionCoords;
				half4 Vertex37_g53341 = TVE_VertexCoords;
				half4 localIS_ELEMENT37_g53341 = IS_ELEMENT( Colors37_g53341 , Extras37_g53341 , Motion37_g53341 , Vertex37_g53341 );
				float4 temp_output_35_0_g53342 = localIS_ELEMENT37_g53341;
				float temp_output_7_0_g53347 = TVE_ElementsFadeValue;
				float2 temp_cast_1 = (temp_output_7_0_g53347).xx;
				float2 temp_output_846_0_g53336 = saturate( ( ( abs( (( (temp_output_35_0_g53342).zw + ( (temp_output_35_0_g53342).xy * (WorldPosition).xz ) )*2.002 + -1.001) ) - temp_cast_1 ) / ( 1.0 - temp_output_7_0_g53347 ) ) );
				float2 break852_g53336 = ( temp_output_846_0_g53336 * temp_output_846_0_g53336 );
				float lerpResult842_g53336 = lerp( 1.0 , ( 1.0 - saturate( ( break852_g53336.x + break852_g53336.y ) ) ) , _ElementVolumeFadeMode);
				half Fade_EdgeMask656_g53336 = lerpResult842_g53336;
				half Element_Intensity56_g53336 = ( _ElementIntensity * i.ase_color.a * Fade_EdgeMask656_g53336 * _RaycastFadeValue );
				half Final_MotionControl_A523_g53336 = ( MainTex_A_Remap74_g53336 * Element_Intensity56_g53336 );
				float4 appendResult1193_g53336 = (float4(Final_MotionPower_RGB1190_g53336 , Final_MotionControl_A523_g53336));
				
				
				finalColor = appendResult1193_g53336;
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
Node;AmplifyShaderEditor.RangedFloatNode;95;-384,-1280;Half;False;Property;_Banner;Banner;0;0;Create;True;0;0;0;True;1;StyledBanner(Motion Direction Element);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;117;-640,-1280;Inherit;False;Define Element Motion;71;;19292;6eebc31017d99e84e811285e6a5d199d;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-256,-1280;Half;False;Property;_Message;Message;1;0;Create;True;0;0;0;True;1;StyledMessage(Info, Use the Motion Direction elements to change the wind direction based on the element forward direction. Element Texture A is used as alpha mask. Particle Color A is used as Element Intensity multiplier. , 0,0);False;0;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;-304,-1024;Float;False;True;-1;2;TVEShaderElementGUI;0;5;Hidden/BOXOPHOBIC/The Vegetation Engine/Elements/Default/Motion Wind Direction;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;2;5;False;;10;False;;0;1;False;;0;False;;True;0;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;True;True;True;True;False;False;0;False;;False;False;False;False;False;False;False;True;False;255;False;;255;False;;255;False;;7;False;;1;False;;1;False;;1;False;;7;False;;1;False;;1;False;;1;False;;False;True;2;False;;True;0;False;;True;False;0;False;;0;False;;True;4;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;PreviewType=Plane;DisableBatching=True=DisableBatching;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.FunctionNode;199;-640,-1024;Inherit;False;Base Element;2;;53336;0e972c73cae2ee54ea51acc9738801d0;5,477,2,478,0,145,3,481,0,491,1;0;1;FLOAT4;0
WireConnection;0;0;199;0
ASEEND*/
//CHKSM=FB67517AE182C286EC473807AF77493BAE4A750C
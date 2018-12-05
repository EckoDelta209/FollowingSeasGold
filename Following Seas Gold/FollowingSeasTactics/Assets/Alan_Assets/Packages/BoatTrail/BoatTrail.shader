// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AlanNight/BoatTrail"
{
	Properties
	{
		_FoamLayer("Foam Layer", 2D) = "white" {}
		_BoatTrail_2("BoatTrail_2", 2D) = "white" {}
		_PanningDirSpeed("Panning Dir/Speed", Vector) = (0,0,0,0)
		_OpacityStrength1("Opacity Strength 1", Float) = 0.6
		_OpacityStrength2("Opacity Strength 2", Float) = 0.6
		_EmissiveStrength("Emissive Strength", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		struct Input
		{
			float2 uv_texcoord;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _EmissiveStrength;
		uniform sampler2D _FoamLayer;
		uniform float2 _PanningDirSpeed;
		uniform float4 _FoamLayer_ST;
		uniform float _OpacityStrength1;
		uniform float _OpacityStrength2;
		uniform sampler2D _BoatTrail_2;
		uniform float4 _BoatTrail_2_ST;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float2 uv_FoamLayer = i.uv_texcoord * _FoamLayer_ST.xy + _FoamLayer_ST.zw;
			float2 panner11 = ( _Time.y * _PanningDirSpeed + uv_FoamLayer);
			float temp_output_27_0 = ( pow( ( 1.0 - i.uv_texcoord.x ) , 1.5 ) * pow( ( ( 1.0 - i.uv_texcoord.y ) * i.uv_texcoord.y ) , 1.5 ) );
			float2 uv_BoatTrail_2 = i.uv_texcoord * _BoatTrail_2_ST.xy + _BoatTrail_2_ST.zw;
			float temp_output_38_0 = ( ( tex2D( _FoamLayer, panner11 ).a * pow( temp_output_27_0 , _OpacityStrength1 ) ) + ( pow( temp_output_27_0 , _OpacityStrength2 ) * tex2D( _BoatTrail_2, uv_BoatTrail_2 ).a ) );
			float clampResult42 = clamp( temp_output_38_0 , 0.0 , 1.0 );
			c.rgb = 0;
			c.a = clampResult42;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			float2 uv_FoamLayer = i.uv_texcoord * _FoamLayer_ST.xy + _FoamLayer_ST.zw;
			float2 panner11 = ( _Time.y * _PanningDirSpeed + uv_FoamLayer);
			float temp_output_27_0 = ( pow( ( 1.0 - i.uv_texcoord.x ) , 1.5 ) * pow( ( ( 1.0 - i.uv_texcoord.y ) * i.uv_texcoord.y ) , 1.5 ) );
			float2 uv_BoatTrail_2 = i.uv_texcoord * _BoatTrail_2_ST.xy + _BoatTrail_2_ST.zw;
			float temp_output_38_0 = ( ( tex2D( _FoamLayer, panner11 ).a * pow( temp_output_27_0 , _OpacityStrength1 ) ) + ( pow( temp_output_27_0 , _OpacityStrength2 ) * tex2D( _BoatTrail_2, uv_BoatTrail_2 ).a ) );
			float3 temp_cast_0 = (( _EmissiveStrength * temp_output_38_0 )).xxx;
			o.Emission = temp_cast_0;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15700
290;560;1776;498;1489.388;-224.0132;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-2271.169,272.6317;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;25;-1957.858,355.8329;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;28;-1993.362,454.2312;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1778.464,357.1314;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;21;-1775.865,266.1314;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1807.061,544.3317;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1783.659,439.0327;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;12;-1851.391,56.30729;Float;False;Property;_PanningDirSpeed;Panning Dir/Speed;2;0;Create;True;0;0;False;0;0,0;0,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PowerNode;22;-1595.162,263.5316;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1859.391,-59.69262;Float;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;35;-1604.262,427.3318;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;13;-1811.693,179.4073;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;11;-1593.692,18.60737;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1414.46,294.7324;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-1429.563,399.1309;Float;False;Property;_OpacityStrength1;Opacity Strength 1;3;0;Create;True;0;0;False;0;0.6;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1438.951,549.4023;Float;False;Property;_OpacityStrength2;Opacity Strength 2;4;0;Create;True;0;0;False;0;0.6;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;40;-1210.151,479.0027;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-1391.094,-8.592626;Float;True;Property;_FoamLayer;Foam Layer;0;0;Create;True;0;0;False;0;None;cacc8ed90b7b9e24aaeff6548c04fc3b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;31;-1217.36,311.3314;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-1718.954,643.8021;Float;True;Property;_BoatTrail_2;BoatTrail_2;1;0;Create;True;0;0;False;0;17e696b99d311914c844c5dceb0dc11b;17e696b99d311914c844c5dceb0dc11b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1027.162,189.5312;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1045.351,523.8029;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-793.9557,127.2311;Float;False;Property;_EmissiveStrength;Emissive Strength;5;0;Create;True;0;0;False;0;0;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-813.3513,275.8026;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;42;-514.3878,272.0132;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-532.6561,146.7312;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;18;-320.1001,58.10002;Float;False;True;7;Float;ASEMaterialInspector;0;0;CustomLighting;AlanNight/BoatTrail;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;25;0;19;2
WireConnection;28;0;19;2
WireConnection;21;0;19;1
WireConnection;26;0;25;0
WireConnection;26;1;28;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;35;0;26;0
WireConnection;35;1;36;0
WireConnection;11;0;10;0
WireConnection;11;2;12;0
WireConnection;11;1;13;0
WireConnection;27;0;22;0
WireConnection;27;1;35;0
WireConnection;40;0;27;0
WireConnection;40;1;41;0
WireConnection;8;1;11;0
WireConnection;31;0;27;0
WireConnection;31;1;32;0
WireConnection;20;0;8;4
WireConnection;20;1;31;0
WireConnection;39;0;40;0
WireConnection;39;1;37;4
WireConnection;38;0;20;0
WireConnection;38;1;39;0
WireConnection;42;0;38;0
WireConnection;33;0;34;0
WireConnection;33;1;38;0
WireConnection;18;2;33;0
WireConnection;18;9;42;0
ASEEND*/
//CHKSM=0CB0CDA488CFB8DE5BF3E29DE306045F58CE9391
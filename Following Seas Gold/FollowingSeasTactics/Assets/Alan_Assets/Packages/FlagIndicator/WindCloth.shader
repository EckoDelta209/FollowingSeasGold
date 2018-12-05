// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AlanNight/WindCloth"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
		_OpacityStrength("Opacity Strength", Float) = 0
		_EmissiveStrength("Emissive Strength", Float) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_WindAltitude("Wind Altitude", Range( 0 , 5)) = 0
		_Windspeeddirection("Wind speed/direction", Vector) = (-2,0,0,0)
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Waveheight("Wave height", 2D) = "white" {}
		_CutoutMask("Cutout Mask", 2D) = "white" {}
		_AmibientOcclusion("Amibient Occlusion", 2D) = "white" {}
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Waveheight;
		uniform float2 _Windspeeddirection;
		uniform float _WindAltitude;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float4 _Color;
		uniform float _EmissiveStrength;
		uniform float _Smoothness;
		uniform sampler2D _AmibientOcclusion;
		uniform float4 _AmibientOcclusion_ST;
		uniform sampler2D _CutoutMask;
		uniform float4 _CutoutMask_ST;
		uniform float _OpacityStrength;
		uniform float _TessValue;

		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float2 panner10 = ( 1.0 * _Time.y * _Windspeeddirection + v.texcoord.xy);
			float3 ase_vertexNormal = v.normal.xyz;
			v.vertex.xyz += ( tex2Dlod( _Waveheight, float4( panner10, 0, 0.0) ) * float4( ( ase_vertexNormal * _WindAltitude ) , 0.0 ) ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float4 temp_output_2_0 = _Color;
			o.Albedo = temp_output_2_0.rgb;
			o.Emission = ( _Color * _EmissiveStrength ).rgb;
			o.Smoothness = _Smoothness;
			float2 uv_AmibientOcclusion = i.uv_texcoord * _AmibientOcclusion_ST.xy + _AmibientOcclusion_ST.zw;
			o.Occlusion = tex2D( _AmibientOcclusion, uv_AmibientOcclusion ).r;
			float2 uv_CutoutMask = i.uv_texcoord * _CutoutMask_ST.xy + _CutoutMask_ST.zw;
			o.Alpha = ( tex2D( _CutoutMask, uv_CutoutMask ) * _OpacityStrength ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc tessellate:tessFunction 

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
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
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
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
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
Version=15600
234;487;1762;571;2129.098;-30.70809;1.81818;True;False
Node;AmplifyShaderEditor.Vector2Node;12;-1547.002,329.9954;Float;False;Property;_Windspeeddirection;Wind speed/direction;5;0;Create;True;0;0;False;0;-2,0;-2,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1541.566,200.3958;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;10;-1194.364,256.3961;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-856.7521,559.0825;Float;False;Property;_WindAltitude;Wind Altitude;4;0;Create;True;0;0;False;0;0;2;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;6;-778.3534,402.2829;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-642.1981,675.2994;Float;True;Property;_CutoutMask;Cutout Mask;8;0;Create;True;0;0;False;0;ea35518fd1b4b6f4abb61da653b92b67;ea35518fd1b4b6f4abb61da653b92b67;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-507.9546,402.2823;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-298.1812,770.7073;Float;False;Property;_OpacityStrength;Opacity Strength;1;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-581.8411,-450.1459;Float;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;0,0,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-483.6436,-222.0182;Float;False;Property;_EmissiveStrength;Emissive Strength;2;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-883.9528,205.4823;Float;True;Property;_Waveheight;Wave height;7;0;Create;True;0;0;False;0;fb5c749625d1d754ab17438d9299b422;fb5c749625d1d754ab17438d9299b422;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1186.836,-227.3725;Float;True;Property;_NormalMap;Normal Map;6;0;Create;True;0;0;False;0;c570b4dcbdfdcaf4b86ba66f617c2e7b;c570b4dcbdfdcaf4b86ba66f617c2e7b;True;0;True;bump;LockedToTexture2D;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-376.6227,-64.62441;Float;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-309.5544,199.0822;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-232.7349,-247.4727;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-56.36331,548.8893;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-1253.601,30.89998;Float;True;Property;_AmibientOcclusion;Amibient Occlusion;9;0;Create;True;0;0;False;0;b3928187f62307d40b85f74fa2c19b74;b3928187f62307d40b85f74fa2c19b74;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;236,-154;Float;False;True;7;Float;ASEMaterialInspector;0;0;Standard;AlanNight/WindCloth;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;5;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;1;1,1,1,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;10;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;11;0
WireConnection;10;2;12;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;5;1;10;0
WireConnection;9;0;5;0
WireConnection;9;1;7;0
WireConnection;18;0;2;0
WireConnection;18;1;19;0
WireConnection;16;0;1;0
WireConnection;16;1;17;0
WireConnection;0;0;2;0
WireConnection;0;1;3;0
WireConnection;0;2;18;0
WireConnection;0;4;15;0
WireConnection;0;5;4;0
WireConnection;0;9;16;0
WireConnection;0;11;9;0
ASEEND*/
//CHKSM=F2A4ED367D94780C9423CAB4F718335C1771EAA7
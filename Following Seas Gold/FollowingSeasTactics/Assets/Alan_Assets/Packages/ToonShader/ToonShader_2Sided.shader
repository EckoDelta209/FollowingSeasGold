// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AlanNight/ToonShader_2Sided"
{
	Properties
	{
		_BaseColor("Base Color", 2D) = "white" {}
		_BaseRockTint("Base Rock Tint", Color) = (0,0,0,0)
		_BaseCellOffset("Base Cell Offset", Range( -1 , 1)) = 0
		_BaseCellSoftness("Base Cell Softness", Range( 0 , 1)) = 0
		_IndirectDiffuseContribution("Indirect Diffuse Contribution", Range( 0 , 1)) = 0
		_ShadowContribution("Shadow Contribution", Range( 0 , 1)) = 0
		_MetallicSmoothnessMap("Metallic Smoothness Map", 2D) = "white" {}
		_HighlightTint("Highlight Tint", Color) = (0,0,0,0)
		_HighlightCellSoftness("Highlight Cell Softness", Range( 0 , 1)) = 0
		_HighlightCellOffset("Highlight Cell Offset", Range( -1 , -0.5)) = 0
		_IndirectSpecularDistribution("Indirect Specular Distribution", Range( 0 , 1)) = 0
		[Toggle(_STATICHIGHLIGHTS_ON)] _StaticHighLights("Static HighLights", Float) = 0
		_RimColor("Rim Color", Color) = (0,0,0,0)
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_RimOffset("Rim Offset", Range( 0 , 1)) = 0
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 10)) = 0
		[Toggle(_GRASSENABLED_ON)] _GrassEnabled("Grass Enabled", Float) = 0
		_BaseGrassColor("Base Grass Color", 2D) = "white" {}
		_BaseGrassTint("Base Grass Tint", Color) = (0,0,0,0)
		_FalloffSharpness("Falloff Sharpness", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _GRASSENABLED_ON
		#pragma shader_feature _STATICHIGHLIGHTS_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldPos;
			half ASEVFace : VFACE;
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

		uniform float _IndirectDiffuseContribution;
		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _BaseCellOffset;
		uniform float _BaseCellSoftness;
		uniform float _ShadowContribution;
		uniform sampler2D _BaseColor;
		uniform float4 _BaseColor_ST;
		uniform float4 _BaseRockTint;
		uniform float _FalloffSharpness;
		uniform sampler2D _BaseGrassColor;
		uniform float4 _BaseGrassTint;
		uniform float4 _HighlightTint;
		uniform sampler2D _MetallicSmoothnessMap;
		uniform float4 _MetallicSmoothnessMap_ST;
		uniform float _IndirectSpecularDistribution;
		uniform float _HighlightCellOffset;
		uniform float _HighlightCellSoftness;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float4 _RimColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float3 temp_cast_2 = (1.0).xxx;
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 normalizeResult5 = normalize( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalScale ) )) );
			float3 newNormal6 = normalizeResult5;
			float3 indirectNormal82 = newNormal6;
			float2 uv_MetallicSmoothnessMap = i.uv_texcoord * _MetallicSmoothnessMap_ST.xy + _MetallicSmoothnessMap_ST.zw;
			float temp_output_72_0 = (( _HighlightTint * tex2D( _MetallicSmoothnessMap, uv_MetallicSmoothnessMap ) )).a;
			Unity_GlossyEnvironmentData g82 = UnityGlossyEnvironmentSetup( temp_output_72_0, data.worldViewDir, indirectNormal82, float3(0,0,0));
			float3 indirectSpecular82 = UnityGI_IndirectSpecular( data, 1.0, indirectNormal82, g82 );
			float3 lerpResult84 = lerp( temp_cast_2 , indirectSpecular82 , _IndirectSpecularDistribution);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 lightColorFalloff16 = ( ase_lightColor * ase_lightAtten );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult4_g1 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult59 = dot( normalizeResult4_g1 , newNormal6 );
			float dotResult10 = dot( newNormal6 , ase_worldlightDir );
			float NdotL11 = dotResult10;
			#ifdef _STATICHIGHLIGHTS_ON
				float staticSwitch61 = NdotL11;
			#else
				float staticSwitch61 = dotResult59;
			#endif
			float3 temp_cast_4 = (1.0).xxx;
			UnityGI gi18 = gi;
			float3 diffNorm18 = newNormal6;
			gi18 = UnityGI_Base( data, 1, diffNorm18 );
			float3 indirectDiffuse18 = gi18.indirect.diffuse + diffNorm18 * 0.0001;
			float3 lerpResult21 = lerp( temp_cast_4 , indirectDiffuse18 , _IndirectDiffuseContribution);
			float temp_output_36_0 = ( 1.0 - ( ( 1.0 - ase_lightAtten ) * _WorldSpaceLightPos0.w ) );
			float lerpResult32 = lerp( temp_output_36_0 , ( saturate( ( ( NdotL11 + _BaseCellOffset ) / _BaseCellSoftness ) ) * ase_lightAtten ) , _ShadowContribution);
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float4 temp_output_44_0 = ( tex2D( _BaseColor, uv_BaseColor ) * _BaseRockTint );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_cast_5 = (_FalloffSharpness).xxx;
			float3 temp_output_137_0 = pow( abs( ase_worldNormal ) , temp_cast_5 );
			float3 temp_output_118_0 = ( temp_output_137_0 / ( ( (temp_output_137_0).x + (temp_output_137_0).y ) + (temp_output_137_0).z ) );
			float4 GrassBaseColor143 = ( (temp_output_118_0).x + ( (temp_output_118_0).z + ( (temp_output_118_0).y * ( tex2D( _BaseGrassColor, (ase_worldPos).xz ) * _BaseGrassTint ) ) ) );
			#ifdef _GRASSENABLED_ON
				float4 staticSwitch149 = ( temp_output_44_0 * GrassBaseColor143 );
			#else
				float4 staticSwitch149 = temp_output_44_0;
			#endif
			float3 baseColor48 = ( ( ( lerpResult21 * ase_lightColor.a * temp_output_36_0 ) + ( ase_lightColor.rgb * lerpResult32 ) ) * (staticSwitch149).rgb );
			float dotResult89 = dot( newNormal6 , ase_worldViewDir );
			float4 temp_output_81_0 = ( ( float4( lerpResult84 , 0.0 ) * lightColorFalloff16 * pow( temp_output_72_0 , 1.5 ) * saturate( ( ( staticSwitch61 + _HighlightCellOffset ) / ( ( 1.0 - temp_output_72_0 ) * _HighlightCellSoftness ) ) ) ) + float4( baseColor48 , 0.0 ) + ( ( saturate( NdotL11 ) * pow( ( 1.0 - saturate( ( dotResult89 + _RimOffset ) ) ) , _RimPower ) ) * lightColorFalloff16 * float4( (_RimColor).rgb , 0.0 ) ) );
			float4 switchResult150 = (((i.ASEVFace>0)?(temp_output_81_0):(temp_output_81_0)));
			c.rgb = switchResult150.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
			float3 temp_cast_0 = (1.0).xxx;
			float3 lerpResult21 = lerp( temp_cast_0 , float3(0,0,0) , _IndirectDiffuseContribution);
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float temp_output_36_0 = ( 1.0 - ( ( 1.0 - 1 ) * _WorldSpaceLightPos0.w ) );
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 normalizeResult5 = normalize( (WorldNormalVector( i , UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalScale ) )) );
			float3 newNormal6 = normalizeResult5;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult10 = dot( newNormal6 , ase_worldlightDir );
			float NdotL11 = dotResult10;
			float lerpResult32 = lerp( temp_output_36_0 , ( saturate( ( ( NdotL11 + _BaseCellOffset ) / _BaseCellSoftness ) ) * 1 ) , _ShadowContribution);
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float4 temp_output_44_0 = ( tex2D( _BaseColor, uv_BaseColor ) * _BaseRockTint );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_cast_1 = (_FalloffSharpness).xxx;
			float3 temp_output_137_0 = pow( abs( ase_worldNormal ) , temp_cast_1 );
			float3 temp_output_118_0 = ( temp_output_137_0 / ( ( (temp_output_137_0).x + (temp_output_137_0).y ) + (temp_output_137_0).z ) );
			float4 GrassBaseColor143 = ( (temp_output_118_0).x + ( (temp_output_118_0).z + ( (temp_output_118_0).y * ( tex2D( _BaseGrassColor, (ase_worldPos).xz ) * _BaseGrassTint ) ) ) );
			#ifdef _GRASSENABLED_ON
				float4 staticSwitch149 = ( temp_output_44_0 * GrassBaseColor143 );
			#else
				float4 staticSwitch149 = temp_output_44_0;
			#endif
			float3 baseColor48 = ( ( ( lerpResult21 * ase_lightColor.a * temp_output_36_0 ) + ( ase_lightColor.rgb * lerpResult32 ) ) * (staticSwitch149).rgb );
			float3 switchResult152 = (((i.ASEVFace>0)?(baseColor48):(baseColor48)));
			o.Albedo = switchResult152;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15900
232;468;1937;572;1010.604;67.40525;1.822348;True;False
Node;AmplifyShaderEditor.CommentaryNode;7;-3227.741,-359.2977;Float;False;1320.264;281.6672;Comment;5;1;4;5;3;6;Normal Map;0,0.3188677,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;142;-3364.91,1172.714;Float;False;2875.02;743.1572;Comment;24;139;143;131;130;128;129;126;124;127;123;125;118;122;117;120;136;121;119;116;135;134;137;138;133;Grass Projection;0.6247332,0.9245283,0.5625668,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-3177.74,-260.9304;Float;False;Property;_NormalScale;Normal Scale;16;0;Create;True;0;0;False;0;0;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;139;-3321.233,1296.749;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.AbsOpNode;133;-3101.246,1297.525;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-3207.232,1447.391;Float;False;Property;_FalloffSharpness;Falloff Sharpness;20;0;Create;True;0;0;False;0;0;3.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2871.342,-307.6304;Float;True;Property;_NormalMap;Normal Map;15;0;Create;True;0;0;False;0;None;efcc98a7a6869c54d8037ff91dd05e26;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;137;-2923.691,1301.925;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;4;-2538.77,-302.7977;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;134;-2701.173,1255.743;Float;False;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;5;-2319.07,-302.7977;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;135;-2699.774,1328.516;Float;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-2150.471,-309.2976;Float;False;newNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;12;-3233.231,-7.601795;Float;False;722.1504;337.2007;Comment;4;8;9;10;11;Normal dot Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;136;-2701.174,1408.286;Float;False;False;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;119;-2720.459,1222.714;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;121;-2617.969,1528.816;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;116;-2425.864,1272.497;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;120;-2113.506,1246.656;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;9;-3145.085,42.39854;Float;False;6;newNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;122;-2372.243,1522.097;Float;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;8;-3183.231,150.5992;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-2239.295,1354.964;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;10;-2899.352,88.05765;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;125;-1983.724,1697.258;Float;False;Property;_BaseGrassTint;Base Grass Tint;19;0;Create;True;0;0;False;0;0,0,0,0;0.01811683,1,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;118;-2006.294,1280.149;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;123;-2071.128,1499.607;Float;True;Property;_BaseGrassColor;Base Grass Color;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;50;-2424.698,185.5738;Float;False;2475.403;945.1205;Comment;28;26;25;24;31;28;27;34;33;35;29;37;30;36;43;45;39;41;32;44;38;40;42;46;47;48;132;144;149;Base Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;80;-2231.254,-1324.068;Float;False;2203.34;846.8748;Comment;21;64;61;60;58;62;63;59;76;77;66;65;67;75;69;72;68;74;70;78;71;79;Hightlight;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1714.025,1503.67;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;127;-1824.882,1308.427;Float;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-2754.081,84.95682;Float;False;NdotL;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;25;-2280.899,243.7948;Float;False;11;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;69;-1680.322,-1274.068;Float;False;Property;_HighlightTint;Highlight Tint;7;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;68;-1766.423,-1088.365;Float;True;Property;_MetallicSmoothnessMap;Metallic Smoothness Map;6;0;Create;True;0;0;False;0;None;b6292c120f0b6014184cea4594c0dce6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;126;-1824.881,1384.539;Float;False;False;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-1542.921,1315.947;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2374.698,334.0978;Float;False;Property;_BaseCellOffset;Base Cell Offset;2;0;Create;True;0;0;False;0;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;-1377.109,1382.754;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1396.705,-1179.529;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;104;-1128.148,-390.2284;Float;False;1621.658;481.9691;Comment;16;89;90;99;98;97;88;92;93;96;94;91;95;100;101;102;103;Rim Light;0.5594963,0.9339623,0.5986277,1;0;0
Node;AmplifyShaderEditor.ComponentMaskNode;128;-1819.919,1225.698;Float;False;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2035.895,248.679;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-2036.785,350.3676;Float;False;Property;_BaseCellSoftness;Base Cell Softness;3;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;31;-2090.601,463.006;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;131;-1225.923,1248.863;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;88;-1059.359,-173.3727;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;90;-1078.149,-274.8343;Float;False;6;newNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;72;-1194.115,-1184.594;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-1745.175,250.2446;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;33;-1768.956,528.0859;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;23;-1880.222,-246.5056;Float;False;734;335.1848;Comment;5;19;22;18;20;21;Indirect Diffuse;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;34;-2111.875,589.4114;Float;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;76;-1108.82,-1014.286;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;58;-2181.254,-786.1757;Float;False;Blinn-Phong Half Vector;-1;;1;91a149ac9d615be429126c95e20753ce;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-2120.144,-688.3447;Float;False;6;newNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;92;-880.8613,-115.1244;Float;False;Property;_RimOffset;Rim Offset;14;0;Create;True;0;0;False;0;0;0.65;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;89;-843.2813,-237.255;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;143;-1032.733,1240.255;Float;False;GrassBaseColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;45;-1464.712,838.909;Float;False;Property;_BaseRockTint;Base Rock Tint;1;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1572.468,586.9085;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;-1830.222,-111.5053;Float;False;6;newNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;29;-1573.715,248.993;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;43;-1810.18,754.4781;Float;True;Property;_BaseColor;Base Color;0;0;Create;True;0;0;False;0;None;566f294de39e31441af2e9eb3176187d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;62;-1916.938,-848.1832;Float;False;11;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;75;-1147.247,-908.4413;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;36;-1408.514,590.6628;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;17;-3232.634,366.9926;Float;False;699.6106;285.694;Comment;4;13;14;15;16;Light Color Falloff;0.9811321,0.9642003,0.1527234,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;91;-612.1747,-235.3759;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;59;-1882.788,-750.1301;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1520.593,680.0051;Float;False;Property;_ShadowContribution;Shadow Contribution;5;0;Create;True;0;0;False;0;0;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1393.494,250.2446;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1145.446,763.7523;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1510.222,-196.5055;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-1256.602,927.9229;Float;False;143;GrassBaseColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1652.222,-26.32054;Float;False;Property;_IndirectDiffuseContribution;Indirect Diffuse Contribution;4;0;Create;True;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;18;-1597.339,-107.1774;Float;False;World;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;61;-1682.897,-819.6849;Float;False;Property;_StaticHighLights;Static HighLights;11;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1179.912,-1787.209;Float;False;859.7782;403.5071;Comment;5;85;84;83;86;82;Indirect Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1703.821,-701.9744;Float;False;Property;_HighlightCellOffset;Highlight Cell Offset;9;0;Create;True;0;0;False;0;0;-0.8;-1;-0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;77;-1074.44,-729.4226;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;14;-3182.634,542.687;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-1433.46,-592.1925;Float;False;Property;_HighlightCellSoftness;Highlight Cell Softness;8;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;93;-471.1777,-236.0329;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;21;-1330.222,-130.5053;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;41;-1127.915,347.8375;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;39;-1080.396,368.1053;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightColorNode;13;-3138.857,416.9926;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;32;-1063.813,590.4093;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;132;-988.0927,824.1135;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-428.5522,-154.3332;Float;False;Property;_RimPower;Rim Power;13;0;Create;True;0;0;False;0;0;0.6;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;97;-317.2462,-340.2285;Float;False;11;NdotL;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-1369.277,-812.2509;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-1087.026,-624.1039;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;94;-316.0683,-234.8483;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-850.5471,475.8117;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;149;-838.2386,721.9656;Float;False;Property;_GrassEnabled;Grass Enabled;17;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-846.5125,235.5738;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;-1129.912,-1645.516;Float;False;6;newNormal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2945.375,457.9475;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;65;-902.6198,-818.7325;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;102;-142.0065,-115.2596;Float;False;Property;_RimColor;Rim Color;12;0;Create;True;0;0;False;0;0,0,0,0;0.462264,0.3315096,0.2202294,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;98;-115.9586,-336.6768;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-750.8605,-1737.209;Float;False;Constant;_Float1;Float 1;15;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;95;-118.3312,-234.8485;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;82;-859.4901,-1640.828;Float;False;World;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-627.8112,357.6549;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;46;-578.7076,585.8373;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;16;-2790.023,453.7113;Float;False;lightColorFalloff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-893.2928,-1498.702;Float;False;Property;_IndirectSpecularDistribution;Indirect Specular Distribution;10;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-691.6305,-1063.464;Float;False;16;lightColorFalloff;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;84;-504.1345,-1665.064;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;74;-883.485,-1177.842;Float;False;2;0;FLOAT;0;False;1;FLOAT;1.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;68.75243,-301.1554;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;79;-713.7754,-818.6339;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-348.4744,439.7008;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;46.25515,-195.7756;Float;False;16;lightColorFalloff;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;103;65.20309,-116.4441;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;324.508,-295.2353;Float;False;3;3;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;2;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-263.9143,-1120.442;Float;True;4;4;0;FLOAT3;1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-192.2957,436.2039;Float;False;baseColor;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;49;809.6196,-549.6322;Float;False;48;baseColor;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;603.2058,-306.4532;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode;150;985.9021,-314.9611;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwitchByFaceNode;152;1146.939,-561.1068;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1496.626,-547.6483;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;AlanNight/ToonShader_2Sided;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;1;4;10;25;True;0.4;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0.1;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;133;0;139;0
WireConnection;1;5;3;0
WireConnection;137;0;133;0
WireConnection;137;1;138;0
WireConnection;4;0;1;0
WireConnection;134;0;137;0
WireConnection;5;0;4;0
WireConnection;135;0;137;0
WireConnection;6;0;5;0
WireConnection;136;0;137;0
WireConnection;119;0;137;0
WireConnection;116;0;134;0
WireConnection;116;1;135;0
WireConnection;120;0;119;0
WireConnection;122;0;121;0
WireConnection;117;0;116;0
WireConnection;117;1;136;0
WireConnection;10;0;9;0
WireConnection;10;1;8;0
WireConnection;118;0;120;0
WireConnection;118;1;117;0
WireConnection;123;1;122;0
WireConnection;124;0;123;0
WireConnection;124;1;125;0
WireConnection;127;0;118;0
WireConnection;11;0;10;0
WireConnection;126;0;118;0
WireConnection;129;0;127;0
WireConnection;129;1;124;0
WireConnection;130;0;126;0
WireConnection;130;1;129;0
WireConnection;70;0;69;0
WireConnection;70;1;68;0
WireConnection;128;0;118;0
WireConnection;24;0;25;0
WireConnection;24;1;26;0
WireConnection;131;0;128;0
WireConnection;131;1;130;0
WireConnection;72;0;70;0
WireConnection;27;0;24;0
WireConnection;27;1;28;0
WireConnection;33;0;31;0
WireConnection;76;0;72;0
WireConnection;89;0;90;0
WireConnection;89;1;88;0
WireConnection;143;0;131;0
WireConnection;35;0;33;0
WireConnection;35;1;34;2
WireConnection;29;0;27;0
WireConnection;75;0;76;0
WireConnection;36;0;35;0
WireConnection;91;0;89;0
WireConnection;91;1;92;0
WireConnection;59;0;58;0
WireConnection;59;1;60;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;44;0;43;0
WireConnection;44;1;45;0
WireConnection;18;0;19;0
WireConnection;61;1;59;0
WireConnection;61;0;62;0
WireConnection;77;0;75;0
WireConnection;93;0;91;0
WireConnection;21;0;20;0
WireConnection;21;1;18;0
WireConnection;21;2;22;0
WireConnection;41;0;36;0
WireConnection;32;0;36;0
WireConnection;32;1;30;0
WireConnection;32;2;37;0
WireConnection;132;0;44;0
WireConnection;132;1;144;0
WireConnection;63;0;61;0
WireConnection;63;1;64;0
WireConnection;67;0;77;0
WireConnection;67;1;66;0
WireConnection;94;0;93;0
WireConnection;38;0;39;1
WireConnection;38;1;32;0
WireConnection;149;1;44;0
WireConnection;149;0;132;0
WireConnection;40;0;21;0
WireConnection;40;1;39;2
WireConnection;40;2;41;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;65;0;63;0
WireConnection;65;1;67;0
WireConnection;98;0;97;0
WireConnection;95;0;94;0
WireConnection;95;1;96;0
WireConnection;82;0;83;0
WireConnection;82;1;72;0
WireConnection;42;0;40;0
WireConnection;42;1;38;0
WireConnection;46;0;149;0
WireConnection;16;0;15;0
WireConnection;84;0;85;0
WireConnection;84;1;82;0
WireConnection;84;2;86;0
WireConnection;74;0;72;0
WireConnection;99;0;98;0
WireConnection;99;1;95;0
WireConnection;79;0;65;0
WireConnection;47;0;42;0
WireConnection;47;1;46;0
WireConnection;103;0;102;0
WireConnection;100;0;99;0
WireConnection;100;1;101;0
WireConnection;100;2;103;0
WireConnection;71;0;84;0
WireConnection;71;1;78;0
WireConnection;71;2;74;0
WireConnection;71;3;79;0
WireConnection;48;0;47;0
WireConnection;81;0;71;0
WireConnection;81;1;48;0
WireConnection;81;2;100;0
WireConnection;150;0;81;0
WireConnection;150;1;81;0
WireConnection;152;0;49;0
WireConnection;152;1;49;0
WireConnection;0;0;152;0
WireConnection;0;13;150;0
ASEEND*/
//CHKSM=2B66BDAC8C7ADE0C6EB40708CFB7F5310D91B133
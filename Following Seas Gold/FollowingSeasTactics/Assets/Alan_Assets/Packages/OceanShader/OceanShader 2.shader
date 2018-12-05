// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AlanNight/OceanShader2"
{
	Properties
	{
		_OceanShallowColor("Ocean Shallow Color", Color) = (0,0,0,0)
		_OceanDepthColor("Ocean Depth Color", Color) = (0,0,0,0)
		_WaterDepth("Water Depth", Float) = 0
		_WaterFalloff("Water Falloff", Float) = 0
		_FoamColor("Foam Color", Color) = (0,0,0,0)
		_OceanTexture("Ocean Texture", 2D) = "white" {}
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_DiffuseBoost("Diffuse Boost", Range( 0 , 10)) = 1
		_FoamLayer1Scale("Foam Layer 1 Scale", Float) = 0
		_Foam1DirSpeed("Foam 1 Dir/Speed", Vector) = (0,0,0,0)
		_FoamLayer2Scale("Foam Layer 2 Scale", Float) = 0.1
		_Foam2DirSpeed("Foam 2 Dir/Speed", Vector) = (0.02,0.02,0,0)
		_OceanNormal("Ocean Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 1
		_Distortion("Distortion", Float) = 0
		_Foam("Foam", 2D) = "white" {}
		_FoamDepth("Foam Depth", Float) = 0
		_FoamFalloff("Foam Falloff", Float) = 0
		_EdgeDepth("Edge Depth", Float) = 0
		_EdgeFalloff("Edge Falloff", Float) = 0
		_NoiseScale("Noise Scale", Float) = 1.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma surface surf StandardCustomLighting keepalpha exclude_path:deferred 
		struct Input
		{
			float4 screenPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldPos;
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

		uniform sampler2D _CameraDepthTexture;
		uniform float _EdgeDepth;
		uniform float _EdgeFalloff;
		uniform sampler2D _ToonRamp;
		uniform float _NormalScale;
		uniform sampler2D _OceanNormal;
		uniform float4 _OceanNormal_ST;
		uniform float4 _OceanDepthColor;
		uniform float4 _OceanShallowColor;
		uniform float _WaterDepth;
		uniform float _WaterFalloff;
		uniform float4 _FoamColor;
		uniform float _NoiseScale;
		uniform sampler2D _OceanTexture;
		uniform float2 _Foam1DirSpeed;
		uniform float _FoamLayer1Scale;
		uniform float2 _Foam2DirSpeed;
		uniform float _FoamLayer2Scale;
		uniform float _FoamDepth;
		uniform float _FoamFalloff;
		uniform sampler2D _Foam;
		uniform float4 _Foam_ST;
		uniform sampler2D _GrabTexture;
		uniform float _Distortion;
		uniform float _DiffuseBoost;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


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
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float eyeDepth68 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPos ))));
			float DepthFade104 = abs( ( eyeDepth68 - ase_screenPos.w ) );
			float2 uv_OceanNormal = i.uv_texcoord * _OceanNormal_ST.xy + _OceanNormal_ST.zw;
			float2 panner80 = ( 1.0 * _Time.y * float2( -0.02,0 ) + uv_OceanNormal);
			float2 panner81 = ( 1.0 * _Time.y * float2( 0.01,0.01 ) + uv_OceanNormal);
			float3 temp_output_83_0 = BlendNormals( UnpackScaleNormal( tex2D( _OceanNormal, panner80 ), _NormalScale ) , UnpackScaleNormal( tex2D( _OceanNormal, panner81 ), _NormalScale ) );
			float3 Normal85 = temp_output_83_0;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult25 = dot( (WorldNormalVector( i , Normal85 )) , ase_worldlightDir );
			float2 temp_cast_0 = (saturate( (dotResult25*0.5 + 0.5) )).xx;
			float temp_output_76_0 = saturate( pow( ( DepthFade104 + _WaterDepth ) , _WaterFalloff ) );
			float4 lerpResult78 = lerp( _OceanDepthColor , _OceanShallowColor , temp_output_76_0);
			float mulTime144 = _Time.y * -0.1;
			float2 temp_output_46_0 = (ase_worldPos).xz;
			float simplePerlin2D138 = snoise( ( mulTime144 + ( _NoiseScale * temp_output_46_0 ) ) );
			float2 panner44 = ( 1.0 * _Time.y * _Foam1DirSpeed + ( _FoamLayer1Scale * temp_output_46_0 ));
			float2 panner60 = ( 1.0 * _Time.y * _Foam2DirSpeed + ( temp_output_46_0 * _FoamLayer2Scale ));
			float blendOpSrc64 = tex2D( _OceanTexture, panner44 ).a;
			float blendOpDest64 = ( tex2D( _OceanTexture, panner60 ).a / 5.0 );
			float blendOpSrc139 = simplePerlin2D138;
			float blendOpDest139 = ( saturate( abs( blendOpSrc64 - blendOpDest64 ) ));
			float4 temp_cast_1 = (( saturate( min( blendOpSrc139 , blendOpDest139 ) ))).xxxx;
			float temp_output_112_0 = saturate( pow( ( DepthFade104 + _FoamDepth ) , _FoamFalloff ) );
			float2 uv_Foam = i.uv_texcoord * _Foam_ST.xy + _Foam_ST.zw;
			float2 panner101 = ( 1.0 * _Time.y * float2( -0.01,0.01 ) + uv_Foam);
			float4 lerpResult114 = lerp( temp_cast_1 , ( temp_output_112_0 * tex2D( _Foam, panner101 ) ) , temp_output_112_0);
			float4 FoamAlpha98 = lerpResult114;
			float4 lerpResult34 = lerp( lerpResult78 , _FoamColor , FoamAlpha98);
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float3 Distortion124 = ( temp_output_83_0 * _Distortion );
			float4 screenColor95 = tex2D( _GrabTexture, ( float3( (ase_grabScreenPosNorm).xy ,  0.0 ) + Distortion124 ).xy );
			float4 lerpResult96 = lerp( lerpResult34 , screenColor95 , temp_output_76_0);
			float4 blendOpSrc38 = tex2D( _ToonRamp, temp_cast_0 );
			float4 blendOpDest38 = lerpResult96;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			UnityGI gi28 = gi;
			float3 diffNorm28 = ase_worldNormal;
			gi28 = UnityGI_Base( data, 1, diffNorm28 );
			float3 indirectDiffuse28 = gi28.indirect.diffuse + diffNorm28 * 0.0001;
			c.rgb = ( ( saturate( ( blendOpSrc38 + blendOpDest38 ) )) * ( ( ase_lightColor * float4( ( indirectDiffuse28 + ase_lightAtten ) , 0.0 ) ) * _DiffuseBoost ) ).rgb;
			c.a = saturate( pow( ( DepthFade104 + _EdgeDepth ) , _EdgeFalloff ) );
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
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15900
233;468;1935;572;6606.503;721.4583;4.202977;True;False
Node;AmplifyShaderEditor.ScreenPosInputsNode;67;-3571.063,-1045.503;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;68;-3301.639,-1046.927;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;45;-5352.118,-269.9452;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;69;-3062.285,-971.425;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;70;-2895.218,-971.4249;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-5225.384,-29.59842;Float;False;Property;_FoamLayer2Scale;Foam Layer 2 Scale;10;0;Create;True;0;0;False;0;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;46;-5128.11,-277.1589;Float;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;104;-2743.159,-971.2114;Float;False;DepthFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-4861.313,-303.2213;Float;False;Property;_FoamLayer1Scale;Foam Layer 1 Scale;8;0;Create;True;0;0;False;0;0;0.08;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;82;-5314.05,-1236.66;Float;False;0;66;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;62;-4926.393,73.1828;Float;False;Property;_Foam2DirSpeed;Foam 2 Dir/Speed;11;0;Create;True;0;0;False;0;0.02,0.02;-0.01,0.01;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-4902.309,-44.23201;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-4315.542,-389.1114;Float;False;Constant;_Float3;Float 3;20;0;Create;True;0;0;False;0;-0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;141;-4403.773,-313.3773;Float;False;Property;_NoiseScale;Noise Scale;20;0;Create;True;0;0;False;0;1.5;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;49;-4682.008,-172.9742;Float;False;Property;_Foam1DirSpeed;Foam 1 Dir/Speed;9;0;Create;True;0;0;False;0;0,0;0.02,0.02;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;109;-4591.03,415.7631;Float;False;Property;_FoamDepth;Foam Depth;16;0;Create;True;0;0;False;0;0;0.98;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;60;-4699.092,32.53951;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;81;-4994.903,-1068.389;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-4597.338,327.3657;Float;False;104;DepthFade;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-4605.125,-295.5156;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-4989.31,-911.9171;Float;False;Property;_NormalScale;Normal Scale;13;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;80;-4990.932,-1245.019;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.02,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;79;-4707.29,-1066.686;Float;True;Property;_TextureSample1;Texture Sample 1;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;True;Instance;66;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;66;-4708.709,-1271.528;Float;True;Property;_OceanNormal;Ocean Normal;12;0;Create;True;0;0;False;0;None;8ec53a74170188d4c8f0f4accd6aea10;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;44;-4406.087,-186.075;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-4378.723,458.9615;Float;False;Property;_FoamFalloff;Foam Falloff;17;0;Create;True;0;0;False;0;0;-1.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;57;-4510.922,3.938205;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;102;-4605.457,598.2895;Float;False;0;100;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;59;-4307.331,194.2309;Float;False;Constant;_Float1;Float 1;7;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;106;-4370.036,346.3081;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;144;-4135.542,-384.1114;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;-4214.624,-309.2813;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;58;-4105.143,77.9514;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;101;-4339.358,606.171;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;142;-3938.878,-331.3775;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendNormalsNode;83;-4331.75,-1170.418;Float;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;17;-4180.757,-213.3554;Float;True;Property;_OceanTexture;Ocean Texture;5;0;Create;True;0;0;False;0;None;cacc8ed90b7b9e24aaeff6548c04fc3b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;110;-4190.877,383.1926;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;138;-3780.911,-293.8732;Float;True;Simplex2D;1;0;FLOAT2;512,512;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;105;-2689.487,-682.4246;Float;False;104;DepthFade;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-4244.022,-919.0454;Float;False;Property;_Distortion;Distortion;14;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;-3889.182,-1178.28;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-2679.725,-583.3143;Float;False;Property;_WaterDepth;Water Depth;2;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;112;-4011.167,383.2698;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;100;-4136.844,581.2967;Float;True;Property;_Foam;Foam;15;0;Create;True;0;0;False;0;None;2c5e6fd135ab69b4ab7b31cb1cc0a87b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;64;-3814.625,-52.38321;Float;True;Difference;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-4037.542,-985.5808;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2441.408,-574.9814;Float;False;Property;_WaterFalloff;Water Falloff;3;0;Create;True;0;0;False;0;0;-1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;-2476.405,-674.9741;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-3771.112,473.0752;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;86;-2477.119,-183.7175;Float;False;85;Normal;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;139;-3472.169,-117.1646;Float;True;Darken;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;74;-2258.089,-674.9739;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;23;-2231.139,-180.9899;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;24;-2276.865,-21.08991;Float;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;114;-3169.03,255.0742;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-3871.009,-989.6609;Float;False;Distortion;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GrabScreenPosition;89;-1922.979,-998.8721;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;77;-2368.257,-1021.847;Float;False;Property;_OceanDepthColor;Ocean Depth Color;1;0;Create;True;0;0;False;0;0,0,0,0;0.01962443,0.1774754,0.5943396,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;90;-1633.482,-1013.588;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;98;-2854.548,198.4323;Float;False;FoamAlpha;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;25;-2014.258,-112.09;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;88;-1990.47,-873.8299;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;92;-1622.585,-901.2037;Float;False;124;Distortion;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;33;-2239.033,-847.4131;Float;False;Property;_OceanShallowColor;Ocean Shallow Color;0;0;Create;True;0;0;False;0;0,0,0,0;0,0.4275099,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;76;-2079.77,-674.9738;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1896.712,-51.62487;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;29;-1547.382,347.1459;Float;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;28;-1345.888,315.9458;Float;False;World;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;78;-1753.805,-701.8691;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;94;-1343.467,-985.8716;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;20;-1696.808,-113.7248;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;-1666.571,-313.8489;Float;False;98;FoamAlpha;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;35;-1750.196,-484.85;Float;False;Property;_FoamColor;Foam Color;4;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;26;-1497.982,224.9456;Float;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;97;-1699.778,-540.1495;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-1093.687,317.2458;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenColorNode;95;-1180.893,-985.8716;Float;False;Global;_GrabScreen0;Grab Screen 0;15;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;132;-401.9313,-219.7728;Float;False;104;DepthFade;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-379.0664,-125.9006;Float;False;Property;_EdgeDepth;Edge Depth;18;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-1470.608,-116.3247;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;34;-1398.969,-453.446;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-951.9808,223.6456;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;133;-193.3025,-196.6645;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;136;-197.5948,-86.68787;Float;False;Property;_EdgeFalloff;Edge Falloff;19;0;Create;True;0;0;False;0;0;-0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1289.901,-157.9243;Float;True;Property;_ToonRamp;Toon Ramp;6;0;Create;True;0;0;False;0;None;d043920c7fd64d5408dc5e8405764c7f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;96;-952.674,-598.3271;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-950.0978,335.562;Float;False;Property;_DiffuseBoost;Diffuse Boost;7;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;38;-753.2552,-212.5229;Float;True;LinearDodge;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-686.7346,223.8301;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;135;-16.59485,-189.6879;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-466.7986,33.71135;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;137;162.2395,-152.0357;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;432.6003,-188.479;Float;False;True;7;Float;ASEMaterialInspector;0;0;CustomLighting;AlanNight/OceanShader2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;False;0;False;Opaque;;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0.05;1,1,1,0;VertexScale;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;87;-5364.051,-1321.528;Float;False;1720.236;574.3519;Comment;0;Ocean Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;71;-3585.978,-1096.726;Float;False;1088.899;270.9573;Screen depth difference to get intersection and fading effect with terrain and objects;0;Depth Fade;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;103;-5402.118,-431.0334;Float;False;2791.464;1210.817;Foam Control and Texture;0;Foam Control;1,1,1,1;0;0
WireConnection;68;0;67;0
WireConnection;69;0;68;0
WireConnection;69;1;67;4
WireConnection;70;0;69;0
WireConnection;46;0;45;0
WireConnection;104;0;70;0
WireConnection;61;0;46;0
WireConnection;61;1;63;0
WireConnection;60;0;61;0
WireConnection;60;2;62;0
WireConnection;81;0;82;0
WireConnection;47;0;48;0
WireConnection;47;1;46;0
WireConnection;80;0;82;0
WireConnection;79;1;81;0
WireConnection;79;5;84;0
WireConnection;66;1;80;0
WireConnection;66;5;84;0
WireConnection;44;0;47;0
WireConnection;44;2;49;0
WireConnection;57;1;60;0
WireConnection;106;0;107;0
WireConnection;106;1;109;0
WireConnection;144;0;145;0
WireConnection;140;0;141;0
WireConnection;140;1;46;0
WireConnection;58;0;57;4
WireConnection;58;1;59;0
WireConnection;101;0;102;0
WireConnection;142;0;144;0
WireConnection;142;1;140;0
WireConnection;83;0;66;0
WireConnection;83;1;79;0
WireConnection;17;1;44;0
WireConnection;110;0;106;0
WireConnection;110;1;111;0
WireConnection;138;0;142;0
WireConnection;85;0;83;0
WireConnection;112;0;110;0
WireConnection;100;1;101;0
WireConnection;64;0;17;4
WireConnection;64;1;58;0
WireConnection;91;0;83;0
WireConnection;91;1;93;0
WireConnection;72;0;105;0
WireConnection;72;1;73;0
WireConnection;113;0;112;0
WireConnection;113;1;100;0
WireConnection;139;0;138;0
WireConnection;139;1;64;0
WireConnection;74;0;72;0
WireConnection;74;1;75;0
WireConnection;23;0;86;0
WireConnection;114;0;139;0
WireConnection;114;1;113;0
WireConnection;114;2;112;0
WireConnection;124;0;91;0
WireConnection;90;0;89;0
WireConnection;98;0;114;0
WireConnection;25;0;23;0
WireConnection;25;1;24;0
WireConnection;88;0;77;0
WireConnection;76;0;74;0
WireConnection;78;0;88;0
WireConnection;78;1;33;0
WireConnection;78;2;76;0
WireConnection;94;0;90;0
WireConnection;94;1;92;0
WireConnection;20;0;25;0
WireConnection;20;1;21;0
WireConnection;20;2;21;0
WireConnection;97;0;76;0
WireConnection;30;0;28;0
WireConnection;30;1;29;0
WireConnection;95;0;94;0
WireConnection;22;0;20;0
WireConnection;34;0;78;0
WireConnection;34;1;35;0
WireConnection;34;2;99;0
WireConnection;27;0;26;0
WireConnection;27;1;30;0
WireConnection;133;0;132;0
WireConnection;133;1;134;0
WireConnection;18;1;22;0
WireConnection;96;0;34;0
WireConnection;96;1;95;0
WireConnection;96;2;97;0
WireConnection;38;0;18;0
WireConnection;38;1;96;0
WireConnection;52;0;27;0
WireConnection;52;1;51;0
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;31;0;38;0
WireConnection;31;1;52;0
WireConnection;137;0;135;0
WireConnection;0;9;137;0
WireConnection;0;13;31;0
ASEEND*/
//CHKSM=5CAE796EDEF98EC4E6C91BE948001CD1EC5EC877
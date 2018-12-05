// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AlanNight/OceanCurrent"
{
	Properties
	{
		_CurrentColor("Current Color", Color) = (0,0,0,0)
		_EmissiveStrength("Emissive Strength", Range( 0 , 15)) = 0
		[Toggle(_EDGEFADE_ON)] _EdgeFade("Edge Fade", Float) = 0
		_TextueScale("Textue Scale", Range( 0 , 1)) = 0.08
		_CurrentFlow("Current Flow", 2D) = "white" {}
		_CurrentFlowWarpNoise("Current Flow WarpNoise", 2D) = "white" {}
		_FlowSpeedDirection("Flow Speed/Direction", Vector) = (-1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma shader_feature _EDGEFADE_ON
		#pragma surface surf StandardCustomLighting alpha:fade keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
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

		uniform float4 _CurrentColor;
		uniform float _EmissiveStrength;
		uniform sampler2D _CurrentFlow;
		uniform float2 _FlowSpeedDirection;
		uniform float _TextueScale;
		uniform sampler2D _CurrentFlowWarpNoise;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float2 temp_output_13_0 = ( _TextueScale * (ase_vertex3Pos).xz );
			float2 panner5 = ( _Time.y * _FlowSpeedDirection + temp_output_13_0);
			float4 tex2DNode1 = tex2D( _CurrentFlow, panner5 );
			#ifdef _EDGEFADE_ON
				float4 staticSwitch41 = ( tex2DNode1 * ( 4.0 * ( i.uv_texcoord.x * ( 1.0 - i.uv_texcoord.x ) ) ) );
			#else
				float4 staticSwitch41 = tex2DNode1;
			#endif
			float4 blendOpSrc3 = staticSwitch41;
			float4 blendOpDest3 = tex2D( _CurrentFlowWarpNoise, temp_output_13_0 );
			c.rgb = 0;
			c.a = ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest3) / blendOpSrc3) ) )).r;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			float4 temp_output_2_0 = _CurrentColor;
			o.Albedo = temp_output_2_0.rgb;
			o.Emission = ( _CurrentColor * _EmissiveStrength ).rgb;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
234;487;1937;571;2671.245;647.5239;2.629817;True;False
Node;AmplifyShaderEditor.PosVertexDataNode;51;-1707.608,-236.7428;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-1446.162,196.9225;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1473.212,-362.9193;Float;False;Property;_TextueScale;Textue Scale;3;0;Create;True;0;0;False;0;0.08;0.187;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;12;-1433.588,-257.0443;Float;False;True;False;True;False;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1161.087,-270.7943;Float;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;9;-1254.568,-128.4298;Float;False;Property;_FlowSpeedDirection;Flow Speed/Direction;6;0;Create;True;0;0;False;0;-1,0;-1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;10;-1184.955,21.97021;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-1103.402,338.8399;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-843.2468,87.49892;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-875.2468,199.4991;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;5;-953.3444,-114.9596;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-619.2464,23.49892;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-656.278,-218.0452;Float;True;Property;_CurrentFlow;Current Flow;4;0;Create;True;0;0;False;0;None;7172dada873b5554f8a33fc64316b5a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-299.1375,-34.25763;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-272,208;Float;True;Property;_CurrentFlowWarpNoise;Current Flow WarpNoise;5;0;Create;True;0;0;False;0;c4749a4a64627a444a800c7036f06234;c4749a4a64627a444a800c7036f06234;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;41;-137.9475,-203.1842;Float;False;Property;_EdgeFade;Edge Fade;2;0;Create;True;0;0;False;0;0;0;1;True;;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2;-63.40812,-494.2047;Float;False;Property;_CurrentColor;Current Color;0;0;Create;True;0;0;False;0;0,0,0,0;0,0.9202383,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-56.73732,-313.6946;Float;False;Property;_EmissiveStrength;Emissive Strength;1;0;Create;True;0;0;False;0;0;1.5;0;15;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;3;197.2998,-201.8162;Float;True;ColorBurn;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;283.1424,-357.6447;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;659.4835,-401.7571;Float;False;True;7;Float;ASEMaterialInspector;0;0;CustomLighting;AlanNight/OceanCurrent;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;51;0
WireConnection;13;0;14;0
WireConnection;13;1;12;0
WireConnection;30;0;27;1
WireConnection;36;0;27;1
WireConnection;36;1;30;0
WireConnection;5;0;13;0
WireConnection;5;2;9;0
WireConnection;5;1;10;0
WireConnection;37;0;38;0
WireConnection;37;1;36;0
WireConnection;1;1;5;0
WireConnection;29;0;1;0
WireConnection;29;1;37;0
WireConnection;4;1;13;0
WireConnection;41;1;1;0
WireConnection;41;0;29;0
WireConnection;3;0;41;0
WireConnection;3;1;4;0
WireConnection;15;0;2;0
WireConnection;15;1;16;0
WireConnection;0;0;2;0
WireConnection;0;2;15;0
WireConnection;0;9;3;0
ASEEND*/
//CHKSM=FB013E2C780575BDE2D2CCB54BB45CE063BBC6BA
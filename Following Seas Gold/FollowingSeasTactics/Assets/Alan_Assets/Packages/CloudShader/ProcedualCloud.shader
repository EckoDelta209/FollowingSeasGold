// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AlanNight/ProcedualCloud"
{
	Properties
	{
		_CloudColor("Cloud Color", Color) = (0,0,0,0)
		_NoiseScale1("Noise Scale 1", Float) = 0
		_NoiseScale2("Noise Scale 2", Float) = 0
		_CloudCutoff("Cloud Cutoff", Range( 0 , 1)) = 0
		_CloudSoftness("Cloud Softness", Range( 0 , 5)) = 0
		_CloudSpeed("Cloud Speed", Float) = 0
		_MidYValue("Mid Y Value", Float) = 0
		_CloudHeight("Cloud Height", Float) = 0
		_TaperPower("Taper Power", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float4 _CloudColor;
		uniform float _NoiseScale2;
		uniform float _CloudSpeed;
		uniform float _NoiseScale1;
		uniform float _MidYValue;
		uniform float _CloudHeight;
		uniform float _TaperPower;
		uniform float _CloudCutoff;
		uniform float _CloudSoftness;


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _CloudColor.rgb;
			float3 ase_worldPos = i.worldPos;
			float mulTime10 = _Time.y * _CloudSpeed;
			float3 appendResult57 = (float3(mulTime10 , mulTime10 , mulTime10));
			float simplePerlin3D64 = snoise( ( ( 0.01 * _NoiseScale2 ) * ( ase_worldPos - appendResult57 ) ) );
			float simplePerlin3D1 = snoise( ( ( _NoiseScale1 * 0.01 ) * ( ase_worldPos + appendResult57 ) ) );
			float blendOpSrc71 = simplePerlin3D64;
			float blendOpDest71 = simplePerlin3D1;
			float temp_output_15_0 = saturate( (0.0 + (( ( saturate( ( blendOpSrc71 + blendOpDest71 ) )) * ( 1.0 - pow( saturate( ( abs( ( _MidYValue - ase_worldPos.y ) ) / ( _CloudHeight * 0.5 ) ) ) , _TaperPower ) ) * pow( ( 1.0 - length( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) ) , 0.5 ) ) - _CloudCutoff) * (1.0 - 0.0) / (1.0 - _CloudCutoff)) );
			o.Occlusion = ( ( temp_output_15_0 * UNITY_LIGHTMODEL_AMBIENT ) + ( ( 1.0 - temp_output_15_0 ) * UNITY_LIGHTMODEL_AMBIENT ) ).r;
			o.Alpha = pow( temp_output_15_0 , _CloudSoftness );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15600
234;484;1989;574;2015.246;144.4107;1.447066;True;False
Node;AmplifyShaderEditor.RangedFloatNode;22;-2808.381,206.3235;Float;False;Property;_CloudSpeed;Cloud Speed;5;0;Create;True;0;0;False;0;0;0.25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2452.531,342.4873;Float;False;Property;_MidYValue;Mid Y Value;6;0;Create;True;0;0;False;0;0;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;5;-2621.751,49.68743;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;10;-2635.177,215.4239;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;24;-2261.869,346.9237;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2316.679,440.5971;Float;False;Property;_CloudHeight;Cloud Height;7;0;Create;True;0;0;False;0;0;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;57;-2451.999,201.2891;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2629.992,-133.1321;Float;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2636.285,-217.1768;Float;False;Property;_NoiseScale1;Noise Scale 1;1;0;Create;True;0;0;False;0;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-2122.512,437.3039;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-2343.531,536.6754;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;25;-2110.465,351.2294;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-2643.091,-40.51094;Float;False;Property;_NoiseScale2;Noise Scale 2;2;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-2229.571,110.1231;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;26;-1964.864,349.6298;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-2454.59,-75.61098;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;37;-2095.522,538.2754;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;-2251.791,-15.81105;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-2458.29,-178.5322;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;29;-1823.279,348.0295;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-2069.974,63.32342;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LengthOpNode;35;-1887.717,538.2747;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2061.987,-121.111;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-1861.231,443.3819;Float;False;Property;_TaperPower;Taper Power;8;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;49;-1732,539.7733;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;64;-1895.587,-138.0111;Float;True;Simplex3D;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-1901.842,105.133;Float;True;Simplex3D;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;30;-1656.907,347.2143;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;71;-1652.494,-6.711134;Float;False;LinearDodge;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;52;-1563.557,541.1771;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;53;-1506.006,351.679;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1457.542,195.5897;Float;False;Property;_CloudCutoff;Cloud Cutoff;3;0;Create;True;0;0;False;0;0;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-1300.838,316.8136;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;13;-1119.467,314.9954;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;-847.1473,315.7636;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;75;-673.9651,423.3384;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FogAndAmbientColorsNode;72;-835.0618,524.1841;Float;False;UNITY_LIGHTMODEL_AMBIENT;0;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-969.7531,233.0873;Float;False;Property;_CloudSoftness;Cloud Softness;4;0;Create;True;0;0;False;0;0;1.25;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;73;-491.3652,490.2971;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-494.2632,365.6814;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;16;-690.2169,257.305;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;43;-497.0389,-35.91899;Float;False;Property;_CloudColor;Cloud Color;0;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-326.197,412.0484;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;7;Float;ASEMaterialInspector;0;0;Standard;AlanNight/ProcedualCloud;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;22;0
WireConnection;24;0;23;0
WireConnection;24;1;5;2
WireConnection;57;0;10;0
WireConnection;57;1;10;0
WireConnection;57;2;10;0
WireConnection;47;0;27;0
WireConnection;25;0;24;0
WireConnection;8;0;5;0
WireConnection;8;1;57;0
WireConnection;26;0;25;0
WireConnection;26;1;47;0
WireConnection;67;0;55;0
WireConnection;67;1;66;0
WireConnection;37;0;34;0
WireConnection;65;0;5;0
WireConnection;65;1;57;0
WireConnection;54;0;19;0
WireConnection;54;1;55;0
WireConnection;29;0;26;0
WireConnection;18;0;54;0
WireConnection;18;1;8;0
WireConnection;35;0;37;0
WireConnection;68;0;67;0
WireConnection;68;1;65;0
WireConnection;49;0;35;0
WireConnection;64;0;68;0
WireConnection;1;0;18;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;71;0;64;0
WireConnection;71;1;1;0
WireConnection;52;0;49;0
WireConnection;53;0;30;0
WireConnection;33;0;71;0
WireConnection;33;1;53;0
WireConnection;33;2;52;0
WireConnection;13;0;33;0
WireConnection;13;1;14;0
WireConnection;15;0;13;0
WireConnection;75;0;15;0
WireConnection;73;0;75;0
WireConnection;73;1;72;0
WireConnection;74;0;15;0
WireConnection;74;1;72;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;76;0;74;0
WireConnection;76;1;73;0
WireConnection;0;0;43;0
WireConnection;0;5;76;0
WireConnection;0;9;16;0
ASEEND*/
//CHKSM=1DC83B4C5619094538EF629C9FB70D1601D788AD
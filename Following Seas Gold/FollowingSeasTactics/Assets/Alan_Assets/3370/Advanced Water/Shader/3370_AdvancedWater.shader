// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:1,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:3,bdst:7,dpts:2,wrdp:False,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:33574,y:32756,varname:node_2865,prsc:2|diff-5109-OUT,spec-358-OUT,gloss-1813-OUT,normal-9326-OUT,alpha-4907-OUT,refract-3962-OUT;n:type:ShaderForge.SFN_Tex2d,id:7736,x:32325,y:32059,ptovrint:True,ptlb:ReflectionTex,ptin:_ReflectionTex,varname:_ReflectionTex,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-6211-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:5964,x:32525,y:32721,varname:_BumpMap1,prsc:2,tex:2dd3788f8589b40bf82a92d76ffc5091,ntxv:3,isnm:True|UVIN-4857-UVOUT,TEX-8699-TEX;n:type:ShaderForge.SFN_Slider,id:358,x:32790,y:32531,ptovrint:False,ptlb:Metallic,ptin:_Metallic,varname:_Metallic,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1813,x:32790,y:32642,ptovrint:False,ptlb:Roughness,ptin:_Roughness,varname:_Roughness,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_ScreenPos,id:6211,x:32145,y:32059,varname:node_6211,prsc:2,sctp:2;n:type:ShaderForge.SFN_Slider,id:9828,x:32422,y:33228,ptovrint:False,ptlb:Opacity,ptin:_Opacity,varname:_Opacity,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Panner,id:4857,x:32281,y:32632,varname:node_4857,prsc:2,spu:1,spv:1|UVIN-9175-OUT,DIST-9089-OUT;n:type:ShaderForge.SFN_TexCoord,id:998,x:31714,y:32423,varname:node_998,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Time,id:2014,x:31777,y:32640,varname:node_2014,prsc:2;n:type:ShaderForge.SFN_Tex2d,id:2747,x:32525,y:32896,varname:_BumpMap2,prsc:2,tex:2dd3788f8589b40bf82a92d76ffc5091,ntxv:3,isnm:True|UVIN-2153-UVOUT,TEX-8699-TEX;n:type:ShaderForge.SFN_Panner,id:2153,x:32272,y:33011,varname:node_2153,prsc:2,spu:1,spv:1|UVIN-9175-OUT,DIST-7857-OUT;n:type:ShaderForge.SFN_Time,id:7350,x:31784,y:33008,varname:node_7350,prsc:2;n:type:ShaderForge.SFN_NormalBlend,id:1589,x:32790,y:32814,varname:node_1589,prsc:2|BSE-5964-RGB,DTL-2747-RGB;n:type:ShaderForge.SFN_ComponentMask,id:6435,x:33040,y:32959,varname:node_6435,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-1589-OUT;n:type:ShaderForge.SFN_Multiply,id:3962,x:33234,y:33053,varname:node_3962,prsc:2|A-6435-OUT,B-4248-OUT,C-5339-OUT;n:type:ShaderForge.SFN_Slider,id:4248,x:32883,y:33115,ptovrint:False,ptlb:Refraction Strength,ptin:_RefractionStrength,varname:_RefractionStrength,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1,max:1;n:type:ShaderForge.SFN_DepthBlend,id:9074,x:32589,y:33335,varname:node_9074,prsc:2|DIST-2546-OUT;n:type:ShaderForge.SFN_Multiply,id:4907,x:33302,y:33370,varname:node_4907,prsc:2|A-9828-OUT,B-9074-OUT,C-5436-OUT;n:type:ShaderForge.SFN_Slider,id:2546,x:32252,y:33336,ptovrint:False,ptlb:Intersection Fade,ptin:_IntersectionFade,varname:_IntersectionFade,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.3,max:3;n:type:ShaderForge.SFN_Vector1,id:5339,x:33040,y:33182,varname:node_5339,prsc:2,v1:0.1;n:type:ShaderForge.SFN_Multiply,id:9089,x:32013,y:32707,varname:node_9089,prsc:2|A-2014-TSL,B-6130-OUT,C-7602-OUT;n:type:ShaderForge.SFN_Multiply,id:7857,x:32001,y:33050,varname:node_7857,prsc:2|A-6130-OUT,B-7350-TSL,C-6786-OUT;n:type:ShaderForge.SFN_Slider,id:6130,x:31673,y:32897,ptovrint:False,ptlb:Water Speed Global,ptin:_WaterSpeedGlobal,varname:_WaterSpeedGlobal,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1,max:1;n:type:ShaderForge.SFN_Multiply,id:5109,x:32938,y:32214,varname:node_5109,prsc:2|A-7800-OUT,B-7838-RGB;n:type:ShaderForge.SFN_Color,id:7838,x:32669,y:32296,ptovrint:False,ptlb:Water Color,ptin:_WaterColor,varname:_WaterColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Slider,id:3345,x:32179,y:32269,ptovrint:False,ptlb:Reflection Power,ptin:_ReflectionPower,varname:_ReflectionPower,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:1,cur:1,max:5;n:type:ShaderForge.SFN_Power,id:7800,x:32555,y:32132,varname:node_7800,prsc:2|VAL-7736-RGB,EXP-3345-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:8699,x:32272,y:32812,ptovrint:False,ptlb:Water Normal,ptin:_WaterNormal,varname:_WaterNormal,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:2dd3788f8589b40bf82a92d76ffc5091,ntxv:3,isnm:True;n:type:ShaderForge.SFN_SceneDepth,id:311,x:32252,y:33428,varname:node_311,prsc:2;n:type:ShaderForge.SFN_Multiply,id:3578,x:32791,y:33519,varname:node_3578,prsc:2|A-8867-OUT,B-9896-OUT,C-7205-OUT;n:type:ShaderForge.SFN_Slider,id:7205,x:32297,y:33723,ptovrint:False,ptlb:Depth Range,ptin:_DepthRange,varname:_DepthFade,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.01,cur:1,max:20;n:type:ShaderForge.SFN_Depth,id:6108,x:32252,y:33552,varname:node_6108,prsc:2;n:type:ShaderForge.SFN_Subtract,id:8867,x:32486,y:33461,varname:node_8867,prsc:2|A-311-OUT,B-6108-OUT;n:type:ShaderForge.SFN_Clamp01,id:6475,x:32970,y:33519,varname:node_6475,prsc:2|IN-3578-OUT;n:type:ShaderForge.SFN_Vector1,id:9896,x:32367,y:33623,varname:node_9896,prsc:2,v1:0.01;n:type:ShaderForge.SFN_ComponentMask,id:1180,x:33134,y:32640,varname:node_1180,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-1589-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9020,x:33182,y:32867,varname:node_9020,prsc:2,cc1:2,cc2:-1,cc3:-1,cc4:-1|IN-1589-OUT;n:type:ShaderForge.SFN_Append,id:9326,x:33404,y:32827,varname:node_9326,prsc:2|A-9405-OUT,B-9020-OUT;n:type:ShaderForge.SFN_Multiply,id:9405,x:33296,y:32731,varname:node_9405,prsc:2|A-1180-OUT,B-9433-OUT;n:type:ShaderForge.SFN_Slider,id:9433,x:32961,y:32814,ptovrint:False,ptlb:Wave Strength,ptin:_WaveStrength,varname:_WaveStrength,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:9175,x:32000,y:32502,varname:node_9175,prsc:2|A-998-UVOUT,B-3674-OUT;n:type:ShaderForge.SFN_ValueProperty,id:3674,x:31704,y:32587,ptovrint:False,ptlb:Water Tiling,ptin:_WaterTiling,varname:_WaterTiling,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:6786,x:31803,y:33143,varname:node_6786,prsc:2|A-754-OUT,B-8500-OUT;n:type:ShaderForge.SFN_ValueProperty,id:754,x:31576,y:33110,ptovrint:False,ptlb:Water 2 U Speed,ptin:_Water2USpeed,varname:_Water2USpeed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:-1;n:type:ShaderForge.SFN_ValueProperty,id:8500,x:31576,y:33220,ptovrint:False,ptlb:Water 2 V Speed,ptin:_Water2VSpeed,varname:_Water2VSpeed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:549,x:31533,y:32828,ptovrint:True,ptlb:Water 1 V Speed,ptin:_Water1VSpeed,varname:_Water1VSpeed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ValueProperty,id:3963,x:31533,y:32674,ptovrint:True,ptlb:Water 1 U Speed,ptin:_Water1USpeed,varname:_Water1USpeed,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Append,id:7602,x:31752,y:32757,varname:node_7602,prsc:2|A-3963-OUT,B-549-OUT;n:type:ShaderForge.SFN_Append,id:5694,x:31931,y:33271,varname:node_5694,prsc:2;n:type:ShaderForge.SFN_SwitchProperty,id:5436,x:33116,y:33519,ptovrint:False,ptlb:Use Depth Opacity,ptin:_UseDepthOpacity,varname:node_5436,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-9820-OUT,B-6475-OUT;n:type:ShaderForge.SFN_Vector1,id:9820,x:32939,y:33458,varname:node_9820,prsc:2,v1:1;proporder:7838-9828-2546-5436-7205-3345-4248-358-1813-9433-3674-6130-3963-549-754-8500-8699-7736;pass:END;sub:END;*/

Shader "3370/AdvancedWater" {
    Properties {
        _WaterColor ("Water Color", Color) = (1,1,1,1)
        _Opacity ("Opacity", Range(0, 1)) = 0.5
        _IntersectionFade ("Intersection Fade", Range(0, 3)) = 0.3
        [MaterialToggle] _UseDepthOpacity ("Use Depth Opacity", Float ) = 1
        _DepthRange ("Depth Range", Range(0.01, 20)) = 1
        _ReflectionPower ("Reflection Power", Range(1, 5)) = 1
        _RefractionStrength ("Refraction Strength", Range(0, 1)) = 0.1
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Roughness ("Roughness", Range(0, 1)) = 0
        _WaveStrength ("Wave Strength", Range(0, 1)) = 1
        _WaterTiling ("Water Tiling", Float ) = 1
        _WaterSpeedGlobal ("Water Speed Global", Range(0, 1)) = 0.1
        _Water1USpeed ("Water 1 U Speed", Float ) = 1
        _Water1VSpeed ("Water 1 V Speed", Float ) = 1
        _Water2USpeed ("Water 2 U Speed", Float ) = -1
        _Water2VSpeed ("Water 2 V Speed", Float ) = 1
        _WaterNormal ("Water Normal", 2D) = "bump" {}
        _ReflectionTex ("ReflectionTex", 2D) = "white" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        GrabPass{ }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _ReflectionTex; uniform float4 _ReflectionTex_ST;
            uniform float _Metallic;
            uniform float _Roughness;
            uniform float _Opacity;
            uniform float _RefractionStrength;
            uniform float _IntersectionFade;
            uniform float _WaterSpeedGlobal;
            uniform float4 _WaterColor;
            uniform float _ReflectionPower;
            uniform sampler2D _WaterNormal; uniform float4 _WaterNormal_ST;
            uniform float _DepthRange;
            uniform float _WaveStrength;
            uniform float _WaterTiling;
            uniform float _Water2USpeed;
            uniform float _Water2VSpeed;
            uniform float _Water1VSpeed;
            uniform float _Water1USpeed;
            uniform fixed _UseDepthOpacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                float4 projPos : TEXCOORD5;
                UNITY_FOG_COORDS(6)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_2014 = _Time;
                float2 node_9175 = (i.uv0*_WaterTiling);
                float2 node_4857 = (node_9175+(node_2014.r*_WaterSpeedGlobal*float2(_Water1USpeed,_Water1VSpeed))*float2(1,1));
                float3 _BumpMap1 = UnpackNormal(tex2D(_WaterNormal,TRANSFORM_TEX(node_4857, _WaterNormal)));
                float4 node_7350 = _Time;
                float2 node_2153 = (node_9175+(_WaterSpeedGlobal*node_7350.r*float2(_Water2USpeed,_Water2VSpeed))*float2(1,1));
                float3 _BumpMap2 = UnpackNormal(tex2D(_WaterNormal,TRANSFORM_TEX(node_2153, _WaterNormal)));
                float3 node_1589_nrm_base = _BumpMap1.rgb + float3(0,0,1);
                float3 node_1589_nrm_detail = _BumpMap2.rgb * float3(-1,-1,1);
                float3 node_1589_nrm_combined = node_1589_nrm_base*dot(node_1589_nrm_base, node_1589_nrm_detail)/node_1589_nrm_base.z - node_1589_nrm_detail;
                float3 node_1589 = node_1589_nrm_combined;
                float3 normalLocal = float3((node_1589.rg*_WaveStrength),node_1589.b);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + (node_1589.rg*_RefractionStrength*0.1);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = 1.0 - _Roughness; // Convert roughness to gloss
                float perceptualRoughness = _Roughness;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float4 _ReflectionTex_var = tex2D(_ReflectionTex,TRANSFORM_TEX(sceneUVs.rg, _ReflectionTex));
                float3 diffuseColor = (pow(_ReflectionTex_var.rgb,_ReflectionPower)*_WaterColor.rgb); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += UNITY_LIGHTMODEL_AMBIENT.rgb; // Ambient Light
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                float node_6475 = saturate(((max(0, LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sceneUVs)) - _ProjectionParams.g)-partZ)*0.01*_DepthRange));
                float node_4907 = (_Opacity*saturate((sceneZ-partZ)/_IntersectionFade)*lerp( 1.0, node_6475, _UseDepthOpacity ));
                fixed4 finalRGBA = fixed4(lerp(sceneColor.rgb, finalColor,node_4907),1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _GrabTexture;
            uniform sampler2D _CameraDepthTexture;
            uniform sampler2D _ReflectionTex; uniform float4 _ReflectionTex_ST;
            uniform float _Metallic;
            uniform float _Roughness;
            uniform float _Opacity;
            uniform float _RefractionStrength;
            uniform float _IntersectionFade;
            uniform float _WaterSpeedGlobal;
            uniform float4 _WaterColor;
            uniform float _ReflectionPower;
            uniform sampler2D _WaterNormal; uniform float4 _WaterNormal_ST;
            uniform float _DepthRange;
            uniform float _WaveStrength;
            uniform float _WaterTiling;
            uniform float _Water2USpeed;
            uniform float _Water2VSpeed;
            uniform float _Water1VSpeed;
            uniform float _Water1USpeed;
            uniform fixed _UseDepthOpacity;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                float4 projPos : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float4 node_2014 = _Time;
                float2 node_9175 = (i.uv0*_WaterTiling);
                float2 node_4857 = (node_9175+(node_2014.r*_WaterSpeedGlobal*float2(_Water1USpeed,_Water1VSpeed))*float2(1,1));
                float3 _BumpMap1 = UnpackNormal(tex2D(_WaterNormal,TRANSFORM_TEX(node_4857, _WaterNormal)));
                float4 node_7350 = _Time;
                float2 node_2153 = (node_9175+(_WaterSpeedGlobal*node_7350.r*float2(_Water2USpeed,_Water2VSpeed))*float2(1,1));
                float3 _BumpMap2 = UnpackNormal(tex2D(_WaterNormal,TRANSFORM_TEX(node_2153, _WaterNormal)));
                float3 node_1589_nrm_base = _BumpMap1.rgb + float3(0,0,1);
                float3 node_1589_nrm_detail = _BumpMap2.rgb * float3(-1,-1,1);
                float3 node_1589_nrm_combined = node_1589_nrm_base*dot(node_1589_nrm_base, node_1589_nrm_detail)/node_1589_nrm_base.z - node_1589_nrm_detail;
                float3 node_1589 = node_1589_nrm_combined;
                float3 normalLocal = float3((node_1589.rg*_WaveStrength),node_1589.b);
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float2 sceneUVs = (i.projPos.xy / i.projPos.w) + (node_1589.rg*_RefractionStrength*0.1);
                float4 sceneColor = tex2D(_GrabTexture, sceneUVs);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float gloss = 1.0 - _Roughness; // Convert roughness to gloss
                float perceptualRoughness = _Roughness;
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = _Metallic;
                float specularMonochrome;
                float4 _ReflectionTex_var = tex2D(_ReflectionTex,TRANSFORM_TEX(sceneUVs.rg, _ReflectionTex));
                float3 diffuseColor = (pow(_ReflectionTex_var.rgb,_ReflectionPower)*_WaterColor.rgb); // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                float node_6475 = saturate(((max(0, LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sceneUVs)) - _ProjectionParams.g)-partZ)*0.01*_DepthRange));
                float node_4907 = (_Opacity*saturate((sceneZ-partZ)/_IntersectionFade)*lerp( 1.0, node_6475, _UseDepthOpacity ));
                fixed4 finalRGBA = fixed4(finalColor * node_4907,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

// Shader created with Shader Forge v1.38 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:1,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:32747,y:32696,varname:node_2865,prsc:2|diff-698-OUT,spec-5734-OUT,gloss-5379-OUT,emission-5188-OUT;n:type:ShaderForge.SFN_Slider,id:358,x:31911,y:32630,ptovrint:False,ptlb:Background Metallic,ptin:_BackgroundMetallic,varname:_Metallic,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:1813,x:31881,y:32811,ptovrint:False,ptlb:Background Roughness,ptin:_BackgroundRoughness,varname:_Roughness,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Color,id:8862,x:31923,y:31973,ptovrint:False,ptlb:Background Color,ptin:_BackgroundColor,varname:_SecondaryColorBackground,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.1284602,c2:0.455074,c3:0.7279412,c4:1;n:type:ShaderForge.SFN_FragmentPosition,id:8523,x:30281,y:32104,varname:node_8523,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:5896,x:30752,y:31651,prsc:2,pt:False;n:type:ShaderForge.SFN_Abs,id:391,x:31096,y:31740,varname:node_391,prsc:2|IN-5896-OUT;n:type:ShaderForge.SFN_Multiply,id:7364,x:31370,y:31809,varname:node_7364,prsc:2|A-391-OUT,B-391-OUT;n:type:ShaderForge.SFN_Append,id:774,x:30824,y:31958,varname:node_774,prsc:2|A-8200-OUT,B-3959-OUT;n:type:ShaderForge.SFN_Append,id:4089,x:30824,y:32103,varname:node_4089,prsc:2|A-3959-OUT,B-1602-OUT;n:type:ShaderForge.SFN_Append,id:4018,x:30824,y:32283,varname:node_4018,prsc:2|A-1602-OUT,B-8200-OUT;n:type:ShaderForge.SFN_ChannelBlend,id:6999,x:31629,y:32017,varname:node_6999,prsc:2,chbt:0|M-7364-OUT,R-9683-RGB,G-6891-RGB,B-8982-RGB;n:type:ShaderForge.SFN_Tex2d,id:9683,x:31358,y:31954,varname:node_6577,prsc:2,tex:bf13d3f815bc7f14ba9144b9ad09e326,ntxv:0,isnm:False|UVIN-4131-OUT,TEX-276-TEX;n:type:ShaderForge.SFN_Tex2d,id:6891,x:31364,y:32149,varname:node_8437,prsc:2,tex:bf13d3f815bc7f14ba9144b9ad09e326,ntxv:0,isnm:False|UVIN-4811-OUT,TEX-276-TEX;n:type:ShaderForge.SFN_Tex2d,id:8982,x:31364,y:32336,varname:node_3820,prsc:2,tex:bf13d3f815bc7f14ba9144b9ad09e326,ntxv:0,isnm:False|UVIN-956-OUT,TEX-276-TEX;n:type:ShaderForge.SFN_Tex2dAsset,id:276,x:31200,y:32492,ptovrint:False,ptlb:Grid Texture,ptin:_GridTexture,varname:_TextureMask,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:bf13d3f815bc7f14ba9144b9ad09e326,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:8200,x:30598,y:31975,varname:node_8200,prsc:2|A-8523-Y,B-2328-OUT;n:type:ShaderForge.SFN_Multiply,id:1602,x:30616,y:32103,varname:node_1602,prsc:2|A-8523-X,B-2328-OUT;n:type:ShaderForge.SFN_Multiply,id:3959,x:30616,y:32245,varname:node_3959,prsc:2|A-8523-Z,B-2328-OUT;n:type:ShaderForge.SFN_Sign,id:5193,x:30742,y:31829,varname:node_5193,prsc:2|IN-5896-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1541,x:31026,y:31849,varname:node_1541,prsc:2,cc1:0,cc2:1,cc3:2,cc4:-1|IN-1452-OUT;n:type:ShaderForge.SFN_RemapRange,id:1452,x:30878,y:31787,varname:node_1452,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-5193-OUT;n:type:ShaderForge.SFN_Lerp,id:4131,x:31199,y:31986,varname:node_4131,prsc:2|A-774-OUT,B-8986-OUT,T-1541-R;n:type:ShaderForge.SFN_Lerp,id:4811,x:31173,y:32130,varname:node_4811,prsc:2|A-4089-OUT,B-2563-OUT,T-1541-G;n:type:ShaderForge.SFN_Lerp,id:956,x:31173,y:32326,varname:node_956,prsc:2|A-4018-OUT,B-8662-OUT,T-1541-B;n:type:ShaderForge.SFN_ComponentMask,id:8986,x:30995,y:32018,varname:node_8986,prsc:2,cc1:1,cc2:0,cc3:-1,cc4:-1|IN-774-OUT;n:type:ShaderForge.SFN_ComponentMask,id:2563,x:30994,y:32177,varname:node_2563,prsc:2,cc1:1,cc2:0,cc3:-1,cc4:-1|IN-4089-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8662,x:30977,y:32343,varname:node_8662,prsc:2,cc1:1,cc2:0,cc3:-1,cc4:-1|IN-4018-OUT;n:type:ShaderForge.SFN_ValueProperty,id:2328,x:30281,y:32281,ptovrint:False,ptlb:Grid Tiling,ptin:_GridTiling,varname:_Tiling,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:2;n:type:ShaderForge.SFN_SwitchProperty,id:3399,x:31857,y:32189,ptovrint:False,ptlb:Use TriPlaner Mapping,ptin:_UseTriPlanerMapping,varname:_UseTriPlanerMapping,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-7636-RGB,B-6999-OUT;n:type:ShaderForge.SFN_TexCoord,id:573,x:30587,y:32687,varname:node_573,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Multiply,id:3301,x:30883,y:32668,varname:node_3301,prsc:2|A-2328-OUT,B-573-UVOUT;n:type:ShaderForge.SFN_Tex2d,id:7636,x:31551,y:32505,varname:node_7636,prsc:2,tex:bf13d3f815bc7f14ba9144b9ad09e326,ntxv:0,isnm:False|UVIN-3301-OUT,TEX-276-TEX;n:type:ShaderForge.SFN_Lerp,id:698,x:32389,y:32032,varname:node_698,prsc:2|A-5735-RGB,B-8862-RGB,T-2928-OUT;n:type:ShaderForge.SFN_Color,id:5735,x:31923,y:31816,ptovrint:False,ptlb:Grid Color,ptin:_GridColor,varname:_PrimaryColorGridLine,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Color,id:7785,x:31926,y:33280,ptovrint:False,ptlb:Background Emission Color,ptin:_BackgroundEmissionColor,varname:_EmissionSecondaryColorBackground,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:9259,x:32251,y:33270,varname:node_9259,prsc:2|A-7785-RGB,B-9430-OUT;n:type:ShaderForge.SFN_Multiply,id:6510,x:32226,y:33070,varname:node_6510,prsc:2|A-6639-RGB,B-2715-OUT;n:type:ShaderForge.SFN_Lerp,id:5188,x:32493,y:33033,varname:node_5188,prsc:2|A-6510-OUT,B-9259-OUT,T-2928-OUT;n:type:ShaderForge.SFN_Slider,id:9430,x:31769,y:33442,ptovrint:False,ptlb:Background Emission Power,ptin:_BackgroundEmissionPower,varname:_EmissionSecondaryPowerBackground,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:20;n:type:ShaderForge.SFN_Slider,id:2715,x:31769,y:33176,ptovrint:False,ptlb:Grid Emission Power,ptin:_GridEmissionPower,varname:_EmissionPrimaryPowerGridLine,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:20;n:type:ShaderForge.SFN_Color,id:6639,x:31926,y:33001,ptovrint:False,ptlb:Grid Emission Color,ptin:_GridEmissionColor,varname:_EmissionPrimaryColorGridLine,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Lerp,id:5734,x:32467,y:32616,varname:node_5734,prsc:2|A-9030-OUT,B-358-OUT,T-1076-OUT;n:type:ShaderForge.SFN_Lerp,id:5379,x:32467,y:32766,varname:node_5379,prsc:2|A-7311-OUT,B-1813-OUT,T-1076-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1076,x:32298,y:32284,varname:node_1076,prsc:2,cc1:0,cc2:-1,cc3:-1,cc4:-1|IN-2928-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:2928,x:32068,y:32258,ptovrint:False,ptlb:Use Grid,ptin:_UseGrid,varname:node_2928,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:True|A-9222-OUT,B-3399-OUT;n:type:ShaderForge.SFN_Vector1,id:9222,x:31911,y:32369,varname:node_9222,prsc:2,v1:1;n:type:ShaderForge.SFN_Slider,id:9030,x:31911,y:32539,ptovrint:False,ptlb:Grid Metallic,ptin:_GridMetallic,varname:node_9030,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Slider,id:7311,x:31881,y:32727,ptovrint:False,ptlb:Grid Roughness,ptin:_GridRoughness,varname:node_7311,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;proporder:8862-358-1813-7785-9430-2928-2328-5735-9030-7311-6639-2715-276-3399;pass:END;sub:END;*/

Shader "3370/PrototypeShader" {
    Properties {
        _BackgroundColor ("Background Color", Color) = (0.1284602,0.455074,0.7279412,1)
        _BackgroundMetallic ("Background Metallic", Range(0, 1)) = 0
        _BackgroundRoughness ("Background Roughness", Range(0, 1)) = 1
        _BackgroundEmissionColor ("Background Emission Color", Color) = (0,0,0,1)
        _BackgroundEmissionPower ("Background Emission Power", Range(0, 20)) = 1
        [MaterialToggle] _UseGrid ("Use Grid", Float ) = 0
        _GridTiling ("Grid Tiling", Float ) = 2
        _GridColor ("Grid Color", Color) = (0,0,0,1)
        _GridMetallic ("Grid Metallic", Range(0, 1)) = 1
        _GridRoughness ("Grid Roughness", Range(0, 1)) = 0
        _GridEmissionColor ("Grid Emission Color", Color) = (0,0,0,1)
        _GridEmissionPower ("Grid Emission Power", Range(0, 20)) = 1
        _GridTexture ("Grid Texture", 2D) = "white" {}
        [MaterialToggle] _UseTriPlanerMapping ("Use TriPlaner Mapping", Float ) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _BackgroundMetallic;
            uniform float _BackgroundRoughness;
            uniform float4 _BackgroundColor;
            uniform sampler2D _GridTexture; uniform float4 _GridTexture_ST;
            uniform float _GridTiling;
            uniform fixed _UseTriPlanerMapping;
            uniform float4 _GridColor;
            uniform float4 _BackgroundEmissionColor;
            uniform float _BackgroundEmissionPower;
            uniform float _GridEmissionPower;
            uniform float4 _GridEmissionColor;
            uniform fixed _UseGrid;
            uniform float _GridMetallic;
            uniform float _GridRoughness;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD10;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float2 node_3301 = (_GridTiling*i.uv0);
                float4 node_7636 = tex2D(_GridTexture,TRANSFORM_TEX(node_3301, _GridTexture));
                float3 node_391 = abs(i.normalDir);
                float3 node_7364 = (node_391*node_391);
                float node_8200 = (i.posWorld.g*_GridTiling);
                float node_3959 = (i.posWorld.b*_GridTiling);
                float2 node_774 = float2(node_8200,node_3959);
                float3 node_1541 = (sign(i.normalDir)*0.5+0.5).rgb;
                float2 node_4131 = lerp(node_774,node_774.gr,node_1541.r);
                float4 node_6577 = tex2D(_GridTexture,TRANSFORM_TEX(node_4131, _GridTexture));
                float node_1602 = (i.posWorld.r*_GridTiling);
                float2 node_4089 = float2(node_3959,node_1602);
                float2 node_4811 = lerp(node_4089,node_4089.gr,node_1541.g);
                float4 node_8437 = tex2D(_GridTexture,TRANSFORM_TEX(node_4811, _GridTexture));
                float2 node_4018 = float2(node_1602,node_8200);
                float2 node_956 = lerp(node_4018,node_4018.gr,node_1541.b);
                float4 node_3820 = tex2D(_GridTexture,TRANSFORM_TEX(node_956, _GridTexture));
                float3 _UseGrid_var = lerp( 1.0, lerp( node_7636.rgb, (node_7364.r*node_6577.rgb + node_7364.g*node_8437.rgb + node_7364.b*node_3820.rgb), _UseTriPlanerMapping ), _UseGrid );
                float node_1076 = _UseGrid_var.r;
                float gloss = 1.0 - lerp(_GridRoughness,_BackgroundRoughness,node_1076); // Convert roughness to gloss
                float perceptualRoughness = lerp(_GridRoughness,_BackgroundRoughness,node_1076);
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
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
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
                float3 specularColor = lerp(_GridMetallic,_BackgroundMetallic,node_1076);
                float specularMonochrome;
                float3 diffuseColor = lerp(_GridColor.rgb,_BackgroundColor.rgb,_UseGrid_var); // Need this for specular when using metallic
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
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
////// Emissive:
                float3 emissive = lerp((_GridEmissionColor.rgb*_GridEmissionPower),(_BackgroundEmissionColor.rgb*_BackgroundEmissionPower),_UseGrid_var);
/// Final Color:
                float3 finalColor = diffuse + specular + emissive;
                fixed4 finalRGBA = fixed4(finalColor,1);
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
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _BackgroundMetallic;
            uniform float _BackgroundRoughness;
            uniform float4 _BackgroundColor;
            uniform sampler2D _GridTexture; uniform float4 _GridTexture_ST;
            uniform float _GridTiling;
            uniform fixed _UseTriPlanerMapping;
            uniform float4 _GridColor;
            uniform float4 _BackgroundEmissionColor;
            uniform float _BackgroundEmissionPower;
            uniform float _GridEmissionPower;
            uniform float4 _GridEmissionColor;
            uniform fixed _UseGrid;
            uniform float _GridMetallic;
            uniform float _GridRoughness;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                LIGHTING_COORDS(7,8)
                UNITY_FOG_COORDS(9)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float2 node_3301 = (_GridTiling*i.uv0);
                float4 node_7636 = tex2D(_GridTexture,TRANSFORM_TEX(node_3301, _GridTexture));
                float3 node_391 = abs(i.normalDir);
                float3 node_7364 = (node_391*node_391);
                float node_8200 = (i.posWorld.g*_GridTiling);
                float node_3959 = (i.posWorld.b*_GridTiling);
                float2 node_774 = float2(node_8200,node_3959);
                float3 node_1541 = (sign(i.normalDir)*0.5+0.5).rgb;
                float2 node_4131 = lerp(node_774,node_774.gr,node_1541.r);
                float4 node_6577 = tex2D(_GridTexture,TRANSFORM_TEX(node_4131, _GridTexture));
                float node_1602 = (i.posWorld.r*_GridTiling);
                float2 node_4089 = float2(node_3959,node_1602);
                float2 node_4811 = lerp(node_4089,node_4089.gr,node_1541.g);
                float4 node_8437 = tex2D(_GridTexture,TRANSFORM_TEX(node_4811, _GridTexture));
                float2 node_4018 = float2(node_1602,node_8200);
                float2 node_956 = lerp(node_4018,node_4018.gr,node_1541.b);
                float4 node_3820 = tex2D(_GridTexture,TRANSFORM_TEX(node_956, _GridTexture));
                float3 _UseGrid_var = lerp( 1.0, lerp( node_7636.rgb, (node_7364.r*node_6577.rgb + node_7364.g*node_8437.rgb + node_7364.b*node_3820.rgb), _UseTriPlanerMapping ), _UseGrid );
                float node_1076 = _UseGrid_var.r;
                float gloss = 1.0 - lerp(_GridRoughness,_BackgroundRoughness,node_1076); // Convert roughness to gloss
                float perceptualRoughness = lerp(_GridRoughness,_BackgroundRoughness,node_1076);
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = lerp(_GridMetallic,_BackgroundMetallic,node_1076);
                float specularMonochrome;
                float3 diffuseColor = lerp(_GridColor.rgb,_BackgroundColor.rgb,_UseGrid_var); // Need this for specular when using metallic
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
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform float _BackgroundMetallic;
            uniform float _BackgroundRoughness;
            uniform float4 _BackgroundColor;
            uniform sampler2D _GridTexture; uniform float4 _GridTexture_ST;
            uniform float _GridTiling;
            uniform fixed _UseTriPlanerMapping;
            uniform float4 _GridColor;
            uniform float4 _BackgroundEmissionColor;
            uniform float _BackgroundEmissionPower;
            uniform float _GridEmissionPower;
            uniform float4 _GridEmissionColor;
            uniform fixed _UseGrid;
            uniform float _GridMetallic;
            uniform float _GridRoughness;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                float2 node_3301 = (_GridTiling*i.uv0);
                float4 node_7636 = tex2D(_GridTexture,TRANSFORM_TEX(node_3301, _GridTexture));
                float3 node_391 = abs(i.normalDir);
                float3 node_7364 = (node_391*node_391);
                float node_8200 = (i.posWorld.g*_GridTiling);
                float node_3959 = (i.posWorld.b*_GridTiling);
                float2 node_774 = float2(node_8200,node_3959);
                float3 node_1541 = (sign(i.normalDir)*0.5+0.5).rgb;
                float2 node_4131 = lerp(node_774,node_774.gr,node_1541.r);
                float4 node_6577 = tex2D(_GridTexture,TRANSFORM_TEX(node_4131, _GridTexture));
                float node_1602 = (i.posWorld.r*_GridTiling);
                float2 node_4089 = float2(node_3959,node_1602);
                float2 node_4811 = lerp(node_4089,node_4089.gr,node_1541.g);
                float4 node_8437 = tex2D(_GridTexture,TRANSFORM_TEX(node_4811, _GridTexture));
                float2 node_4018 = float2(node_1602,node_8200);
                float2 node_956 = lerp(node_4018,node_4018.gr,node_1541.b);
                float4 node_3820 = tex2D(_GridTexture,TRANSFORM_TEX(node_956, _GridTexture));
                float3 _UseGrid_var = lerp( 1.0, lerp( node_7636.rgb, (node_7364.r*node_6577.rgb + node_7364.g*node_8437.rgb + node_7364.b*node_3820.rgb), _UseTriPlanerMapping ), _UseGrid );
                o.Emission = lerp((_GridEmissionColor.rgb*_GridEmissionPower),(_BackgroundEmissionColor.rgb*_BackgroundEmissionPower),_UseGrid_var);
                
                float3 diffColor = lerp(_GridColor.rgb,_BackgroundColor.rgb,_UseGrid_var);
                float specularMonochrome;
                float3 specColor;
                float node_1076 = _UseGrid_var.r;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, lerp(_GridMetallic,_BackgroundMetallic,node_1076), specColor, specularMonochrome );
                float roughness = lerp(_GridRoughness,_BackgroundRoughness,node_1076);
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

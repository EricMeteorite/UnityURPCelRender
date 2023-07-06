Shader "Toon/CelTest1.2"
{
    Properties
    {
        [Header(Shader Setting)]
        [Space(5)]
        [KeywordEnum(Base,Hair,Face,NoneSDFFace)] _ShaderEnum("Shader类型",int) = 0
        [Toggle] _IsNight ("In Night", int) = 0
        [Toggle(_AdditionalLights)] _AddLights ("AddLights", Float) = 1
        [Space(5)]

        [Header(High Level Setting)]
        [ToggleUI]_IsFace("Is Face? (please turn on if this is a face material)", Float) = 0

        [Space(5)]
        [Header(Stencil)]
        _StencilRef ("_StencilRef", Range(0, 255)) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("_StencilComp", Float) = 0

        [Space(5)]
        [Header(Main Texture Setting)]
        [Space(5)]
        [MainTexture] _MainTex ("Texture", 2D) = "white" {}
        [HDR][MainColor] _MainColor ("Main Color", Color) = (1.0, 1.0, 1.0, 1.0)
        [Space(30)]

        [Header(Bloom)]
        [Space(5)]
        [Toggle(ENABLE_BLOOM_MASK)]_EnableBloomMask ("Enable Bloom", float) = 0.0
        [NoScaleOffset]_BloomMap ("Bloom/Emission Map", 2D) = "black" { }
        _BloomFactor ("Common Bloom Factor", range(0.0, 1.0)) = 1.0

        [Header(Emission)]
        [Toggle]_EnableEmission ("Enable Emission", Float) = 0
        _Emission ("Emission", range(0.0, 20.0)) = 1.0
        _EmissionMap ("EmissionMap", 2D) = "black" {}
        [HDR]_EmissionColors ("Emission Color", color) = (0, 0, 0, 0)
        _EmissionBloomFactor ("Emission Bloom Factor", range(0.0, 10.0)) = 1.0
        [HideInInspector]_EmissionMapChannelMask ("_EmissionMapChannelMask", Vector) = (1, 1, 1, 0)
        [Space(30)]

        [Header(Shadow Setting)]
        [Space(5)]
        _LightMap ("LightMap", 2D) = "grey" {}
        _SDF ("SDF", 2D) = "grey" {}
        _RampMap ("RampMap", 2D) = "white" {}
        _ShadowSmooth ("Shadow Smooth", Range(0, 1)) = 0.5
        _RampShadowRange ("Ramp Shadow Range", Range(0.5, 1.0)) = 0.8
        _RangeAO ("AO Range", Range(1, 2)) = 1.5
        _ShadowColor ("Shadow Color", Color) = (1.0, 1.0, 1.0, 1.0)
        [Space(30)]

        [Header(CelHairSpecular Setting)]
        [Space(5)]
        [Toggle]_EnableHairSpecular ("Enable Hair Specular", Float) = 0
        _Exponent("Exponent", float) = 1
        _HairSpecularPower("Hair Specular Power", float) = 1
        _Scale("Scale", Range(0, 1)) = 1

        [Header(Face Setting)]
        [Space(5)]
        _FaceShadowOffset ("Face Shadow Offset", range(0.0, 1.0)) = 0.1
        _FaceShadowPow ("Face Shadow Pow", range(0.001, 1)) = 0.1
        [Space(30)]

        [Header(Specular Setting)]
        [Space(5)]
        [Toggle] _EnableSpecular ("Enable Specular", int) = 1
        _MetalMap ("Metal Map", 2D) = "white" {}
        [HDR] _SpecularColor ("Specular Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _BlinnPhongSpecularGloss ("Blinn Phong Specular Gloss", Range(0.01, 10)) = 5
        _BlinnPhongSpecularIntensity ("Blinn Phong Specular Intensity", Range(0, 1)) = 1
        _StepSpecularGloss ("Step Specular Gloss", Range(0, 1)) = 0.5
        _StepSpecularIntensity ("Step Specular Intensity", Range(0, 1)) = 0.5
        _MetalSpecularGloss ("Metal Specular Gloss", Range(0, 1)) = 0.5
        _MetalSpecularIntensity ("Metal Specular Intensity", Range(0, 1)) = 1
        [Space(30)]

        [Header(Rim Setting)]
        [Space(5)]
        [Toggle]_EnableRim ("Enable Rim", float) = 1
        [HDR]_RimColor ("Rim Color", Color) = (1, 1, 1, 1)
        _RimSmooth ("Rim Smooth", Range(0.001, 1.0)) = 0.01
        _RimPow ("Rim Pow", Range(0.0, 10.0)) = 1.0
        [Space(5)]

        [Header(Rim Setting (Screen Space))]
        [Space(5)]
        [Toggle] _EnableRims ("Enable Rim", int) = 1
        [HDR] _RimColors ("Rim Color", Color) = (1.0, 1.0, 1.0, 1.0)
        _RimOffsets ("Rim Offset", Range(0, 0.5)) = 0.1    //粗细
        _RimThresholds ("Rim Threshold", Range(0, 2)) = 1  //细致程度
        [Space(5)]
        [Toggle]_EnableRimDS ("Enable Dark Side Rim", int) = 1
        [HDR]_DarkSideRimColor ("DarkSide Rim Color", Color) = (1, 1, 1, 1)
        _DarkSideRimSmooth ("DarkSide Rim Smooth", Range(0.001, 1.0)) = 0.01
        _DarkSideRimPow ("DarkSide Rim Pow", Range(0.0, 10.0)) = 1.0
        [HideInInspector][Toggle]_EnableRimOther ("Enable Other Rim", int) = 0
        [HideInInspector][HDR]_OtherRimColor ("Other Rim Color", Color) = (1, 1, 1, 1)
        [HideInInspector]_OtherRimSmooth ("Other Rim Smooth", Range(0.001, 1.0)) = 0.01
        [HideInInspector]_OtherRimPow ("Other Rim Pow", Range(0.001, 50.0)) = 10.0
        [Space(30)]

        [Header(Outline Setting)]
        [Space(5)]
        [Toggle] _EnableOutline ("Enable Outline", float) = 1
        _OutlineWidth("_OutlineWidth (World Space)", Range(0,4)) = 1
        _OutlineColor("_OutlineColor", Color) = (0.5,0.5,0.5,1)
        _OutlineZOffset("_OutlineZOffset (View Space)", Range(0,1)) = 0.0001
        [NoScaleOffset]_OutlineZOffsetMaskTex("_OutlineZOffsetMask (black is apply ZOffset)", 2D) = "black" {}
        _OutlineZOffsetMaskRemapStart("_OutlineZOffsetMaskRemapStart", Range(0,1)) = 0
        _OutlineZOffsetMaskRemapEnd("_OutlineZOffsetMaskRemapEnd", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque"}

        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        //#include "NiloOutlineUtil.hlsl"
        #pragma shader_feature _SHADERENUM_BASE _SHADERENUM_HAIR _SHADERENUM_FACE _SHADERENUM_NONESDFFACE

        int _IsNight;
        float3 _LightDirection;
        TEXTURE2D(_MainTex);            SAMPLER(sampler_MainTex);
        TEXTURE2D(_EmissionMap);        SAMPLER(sampler_EmissionMap);
        TEXTURE2D(_LightMap);           SAMPLER(sampler_LightMap);
        TEXTURE2D(_SDF);                SAMPLER(sampler_SDF);
        TEXTURE2D(_RampMap);            SAMPLER(sampler_RampMap);
        TEXTURE2D(_MetalMap);           SAMPLER(sampler_MetalMap);
        TEXTURE2D(_CameraDepthTexture); SAMPLER(sampler_CameraDepthTexture);
        sampler2D _OutlineZOffsetMaskTex;

        // 单个材质独有的参数尽量放在 CBUFFER 中，以提高性能
        CBUFFER_START(UnityPerMaterial)
        float _IsFace;
        float4 _MainTex_ST;
        half4 _MainColor;

        float _EnableBloomMask;
        float4 _BloomMap_ST;
        float _BloomFactor;
        float _EnableEmission;
        float4 _EmissionMap_ST;
        half4 _EmissionColors;
        float _Emission;
        float _EmissionBloomFactor;
        half _EmissionMulByBaseColor;
        half3 _EmissionMapChannelMask;

        float4 _LightMap_ST;
        float4 _SDF_ST;
        float4 _RampMap_ST;
        half _ShadowSmooth;
        half _RampShadowRange;
        half _RangeAO;
        half4 _ShadowColor;

        int _EnableSpecular;
        float4 _MetalMap_ST;
        half4 _SpecularColor;
        half _BlinnPhongSpecularGloss;
        half _BlinnPhongSpecularIntensity;
        half _StepSpecularGloss;
        half _StepSpecularIntensity;
        half _MetalSpecularGloss;
        half _MetalSpecularIntensity;

        float _EnableHairSpecular;
        float _Exponent;
        float _HairSpecularPower;
        float _Scale;

        float _FaceShadowOffset;
        float _FaceShadowPow;

        float _EnableRim;
        half4 _RimColor;
        float _RimSmooth;
        float _RimPow;

        int _EnableRims;
        half4 _RimColors;
        half _RimOffsets;
        half _RimThresholds;

        float _EnableRimDS;
        half4 _DarkSideRimColor;
        float _DarkSideRimSmooth;
        float _DarkSideRimPow;
        float _EnableRimOther;
        half4 _OtherRimColor;
        float _OtherRimSmooth;
        float _OtherRimPow;

        float _EnableOutline;
        float _OutlineWidth;
        half4 _OutlineColor;
        float _OutlineZOffset;
        float _OutlineZOffsetMaskRemapStart;
        float _OutlineZOffsetMaskRemapEnd;
        CBUFFER_END

        struct a2v{
            float3 vertex : POSITION;       //顶点坐标
            half4 color : COLOR0;           //顶点色
            half3 normal : NORMAL;          //法线
            half4 tangent : TANGENT;        //切线
            float2 texCoord : TEXCOORD0;    //纹理坐标
        };
        struct v2f{
            float4 pos : POSITION;              //裁剪空间顶点坐标
            float2 uv : TEXCOORD0;              //uv
            float3 worldPos : TEXCOORD1;        //世界坐标
            float3 worldNormal : TEXCOORD2;     //世界空间法线
            float3 worldTangent : TEXCOORD3;    //世界空间切线
            float3 worldBiTangent : TEXCOORD4;  //世界空间副切线
            float4 positionWSAndFogFactor: TEXCOORD5; // xyz: positionWS, w: vertex fog factor
            half4 color : COLOR0;               //平滑Rim所需顶点色
        };

        float GetCameraFOV()
        {
            //https://answers.unity.com/questions/770838/how-can-i-extract-the-fov-information-from-the-pro.html
            float t = unity_CameraProjection._m11;
            float Rad2Deg = 180 / 3.1415;
            float fov = atan(1.0f / t) * 2.0 * Rad2Deg;
            return fov;
        }
        float ApplyOutlineDistanceFadeOut(float inputMulFix)
        {
            //make outline "fadeout" if character is too small in camera's view
            return saturate(inputMulFix);
        }
        float GetOutlineCameraFovAndDistanceFixMultiplier(float positionVS_Z)
        {
            float cameraMulFix;
            if(unity_OrthoParams.w == 0)
            {
                ////////////////////////////////
                // Perspective camera case
                ////////////////////////////////

                // keep outline similar width on screen accoss all camera distance       
                cameraMulFix = abs(positionVS_Z);

                // can replace to a tonemap function if a smooth stop is needed
                cameraMulFix = ApplyOutlineDistanceFadeOut(cameraMulFix);

                // keep outline similar width on screen accoss all camera fov
                cameraMulFix *= GetCameraFOV();       
            }
            else
            {
                ////////////////////////////////
                // Orthographic camera case
                ////////////////////////////////
                float orthoSize = abs(unity_OrthoParams.y);
                orthoSize = ApplyOutlineDistanceFadeOut(orthoSize);
                cameraMulFix = orthoSize * 50; // 50 is a magic number to match perspective camera's outline width
            }

            return cameraMulFix * 0.00005; // mul a const to make return result = default normal expand amount WS
        }

        float4 NiloGetNewClipPosWithZOffset(float4 originalPositionCS, float viewSpaceZOffsetAmount)
        {
            if(unity_OrthoParams.w == 0)
            {
                ////////////////////////////////
                //Perspective camera case
                ////////////////////////////////
                float2 ProjM_ZRow_ZW = UNITY_MATRIX_P[2].zw;
                float modifiedPositionVS_Z = -originalPositionCS.w + -viewSpaceZOffsetAmount; // push imaginary vertex
                float modifiedPositionCS_Z = modifiedPositionVS_Z * ProjM_ZRow_ZW[0] + ProjM_ZRow_ZW[1];
                originalPositionCS.z = modifiedPositionCS_Z * originalPositionCS.w / (-modifiedPositionVS_Z); // overwrite positionCS.z
                return originalPositionCS;    
            }
            else
            {
                ////////////////////////////////
                //Orthographic camera case
                ////////////////////////////////
                originalPositionCS.z += -viewSpaceZOffsetAmount / _ProjectionParams.z; // push imaginary vertex and overwrite positionCS.z
                return originalPositionCS;
            }
        }

        float3 TransformPositionWSToOutlinePositionWS(float3 positionWS, float positionVS_Z, float3 normalWS)
        {
            //you can replace it to your own method! Here we will write a simple world space method for tutorial reason, it is not the best method!
            float outlineExpandAmount = _OutlineWidth * GetOutlineCameraFovAndDistanceFixMultiplier(positionVS_Z) * _EnableOutline;
            return positionWS + normalWS * outlineExpandAmount; 
        }

        //计算各向异性光照系数，基于Kajyiya-Kay Model
        float StrandSpecular(float3 V, float3 T, float3 L, float3 N, float exponent,float scale, float hairSpecularPower){
            //V：点到相机方向
            //T：副切削方向
            //L：点到光源方向，如果是直射光就是光的照射方向的反方向
            //N：法线方向

            float nl = saturate(dot(N, L));//影响反射
            float3 H = normalize(L + V);//光源方向和相机方向是高光模型的一部分
            T = normalize((scale * 2 - 1) * N + T);//这个地方是为了调整天使环位置
            float dotTH = dot(T, H);
            float sinTH = sqrt(1.0 - dotTH * dotTH);
            float dirAtten = smoothstep(-1.0, 0.0, dotTH);
            float factor = dirAtten * pow(sinTH, exponent) * hairSpecularPower;
            factor *= nl;
            return factor;
        }
        ENDHLSL

        Pass
        {
            Tags {"LightMode"="UniversalForward" "RenderType"="Opaque"}

            Stencil
            {
                Ref [_StencilRef]
                Comp [_StencilComp]
                Pass replace
            }
            
            HLSLPROGRAM
            #pragma shader_feature _AdditionalLights
            #pragma vertex ToonPassVert
            #pragma fragment ToonPassFrag

            v2f ToonPassVert(a2v v)
            {
                v2f o;
                o.pos = TransformObjectToHClip(v.vertex);
                o.uv = TRANSFORM_TEX(v.texCoord, _MainTex);
                o.worldPos = TransformObjectToWorld(v.vertex);
                // 使用URP自带函数计算世界空间法线
                VertexNormalInputs vertexNormalInput = GetVertexNormalInputs(v.normal, v.tangent);
                o.worldNormal = vertexNormalInput.normalWS;
                o.worldTangent = vertexNormalInput.tangentWS;
                o.worldBiTangent = vertexNormalInput.bitangentWS;
                o.color = v.color;
                return o;
            }

            half4 ToonPassFrag(v2f i) : SV_TARGET
            {
                float4 BaseColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv) * _MainColor;
                float4 LightMapColor = SAMPLE_TEXTURE2D(_LightMap, sampler_LightMap, i.uv);
                Light mainLight = GetMainLight();
                half4 LightColor = half4(mainLight.color, 1.0);
                half3 lightDir = normalize(mainLight.direction);
                half3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);
                half3 halfDir = normalize(viewDir + lightDir);

                half halfLambert = dot(lightDir, i.worldNormal) * 0.5 + 0.5;

                //==========================================================================================
                // Base Ramp
                // 依据原来的lambert值，保留0到一定数值的smooth渐变，大于这一数值的全部采样ramp最右边的颜色，从而形成硬边
                halfLambert = smoothstep(0.0, _ShadowSmooth, halfLambert);
                // 常暗阴影
                float ShadowAO = smoothstep(0.1, LightMapColor.g, 0.7) * _RangeAO;

                float RampPixelX = 0.00390625;  //0.00390625 = 1/256
                float RampPixelY = 0.03125;     //0.03125 = 1/16/2   尽量采样到ramp条带的正中间，以避免精度误差
                float RampX, RampY;
                // 对X做一步Clamp，防止采样到边界
                RampX = clamp(halfLambert*ShadowAO, RampPixelX, 1-RampPixelX);

                // 灰度0.0-0.2  硬Ramp
                // 灰度0.2-0.4  软Ramp
                // 灰度0.4-0.6  金属层
                // 灰度0.6-0.8  布料层，主要为silk类
                // 灰度0.8-1.0  皮肤/头发层
                // 白天采样上半，晚上采样下半

                //— — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — —
                // Base Ramp
                if (_IsNight == 0.0)
                    RampY = RampPixelY * (33 - 2 * (LightMapColor.a * 4 + 1));
                else
                    RampY = RampPixelY * (17 - 2 * (LightMapColor.a * 4 + 1));

                float2 RampUV = float2(RampX, RampY);
                float4 rampColor = SAMPLE_TEXTURE2D(_RampMap, sampler_RampMap, RampUV);
                half4 FinalRamp = lerp(rampColor * BaseColor * _ShadowColor, BaseColor, step(_RampShadowRange, halfLambert * ShadowAO));

                //— — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — —
                // Hair Ramp
                #if _SHADERENUM_HAIR
                    if (_IsNight == 0.0)
                        RampY = RampPixelY * (33 - 2 * lerp(1, 3, step(0.5, LightMapColor.a)));
                    else
                        RampY = RampPixelY * (17 - 2 * lerp(1, 3, step(0.5, LightMapColor.a)));
                    RampUV = float2(RampX, RampY);
                    rampColor = SAMPLE_TEXTURE2D(_RampMap, sampler_RampMap, RampUV);
                    FinalRamp = lerp(rampColor * BaseColor * _ShadowColor, BaseColor, step(_RampShadowRange, halfLambert * ShadowAO));
                #endif

                //— — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — —
                // SDF脸部阴影
                #if _SHADERENUM_FACE
                    float4 upDir = mul(unity_ObjectToWorld, float4(0,1,0,0));  
                    float4 frontDir = mul(unity_ObjectToWorld, float4(0,0,1,0));
                    float3 rightDir = cross(upDir, frontDir);

                    float FdotL = dot(normalize(frontDir.xz), normalize(lightDir.xz));
                    float RdotL = dot(normalize(rightDir.xz), normalize(lightDir.xz));
                    // 切换贴图正反
                    float2 FaceMapUV = float2(lerp(i.uv.x, 1-i.uv.x, step(0, RdotL)), i.uv.y);
                    float FaceMap = SAMPLE_TEXTURE2D(_SDF, sampler_SDF, FaceMapUV).r;
                    // 下面这句话是错的
                    //float FaceMap = lerp(LightMapColor.r, 1-LightMapColor.r, step(0, RdotL)) * step(0, FdotL);

                    // 调整变化曲线，使得中间大部分变化速度趋于平缓
                    FaceMap = pow(FaceMap, _FaceShadowPow);

                    // 直接用采样的结果和FdotL比较判断，头发阴影和面部阴影会对不上，需要手动调整偏移
                    // 但是直接在LightMap数据上±Offset会导致光照进入边缘时产生阴影跳变
                    float sinx = sin(_FaceShadowOffset);
                    float cosx = cos(_FaceShadowOffset);
                    float2x2 rotationOffset1 = float2x2(cosx, sinx, -sinx, cosx); //顺时针偏移
                    float2x2 rotationOffset2 = float2x2(cosx, -sinx, sinx, cosx); //逆时针偏移
                    float2 FaceLightDir = lerp(mul(rotationOffset1, lightDir.xz), mul(rotationOffset2, lightDir.xz), step(0, RdotL));
                    FdotL = dot(normalize(frontDir.xz), normalize(FaceLightDir));

                    //FinalRamp = float4(FaceMap, FaceMap, FaceMap, 1);
                    FinalRamp = lerp(BaseColor, _ShadowColor * BaseColor, step(FaceMap, 1-FdotL));
                #endif

                //==========================================================================================
                // 高光
                half4 BlinnPhongSpecular;
                half4 MetalSpecular;
                half4 StepSpecular;
                half4 FinalSpecular;
                // ILM的R通道，灰色为裁边视角高光
                half StepMask = step(0.2, LightMapColor.r) - step(0.8, LightMapColor.r);
                StepSpecular = step(1 - _StepSpecularGloss, saturate(dot(i.worldNormal, viewDir))) * _StepSpecularIntensity * StepMask;
                // ILM的R通道，白色为 Blinn-Phong + 金属高光
                half MetalMask = step(0.9, LightMapColor.r);
                // Blinn-Phong
                BlinnPhongSpecular = pow(max(0, dot(i.worldNormal, halfDir)), _BlinnPhongSpecularGloss) * _BlinnPhongSpecularIntensity * MetalMask;
                // 金属高光
                float2 MetalMapUV = mul((float3x3) UNITY_MATRIX_V, i.worldNormal).xy * 0.5 + 0.5;
                float MetalMap = SAMPLE_TEXTURE2D(_MetalMap, sampler_MetalMap, MetalMapUV).r;
                MetalMap = step(_MetalSpecularGloss, MetalMap);
                MetalSpecular = MetalMap * _MetalSpecularIntensity * MetalMask;
                
                FinalSpecular = StepSpecular + BlinnPhongSpecular + MetalSpecular;
                FinalSpecular = lerp(0, BaseColor * FinalSpecular * _SpecularColor, LightMapColor.b) ;
                FinalSpecular *= halfLambert * ShadowAO * _EnableSpecular;

                half4 SpecDiffuse;
                SpecDiffuse.rgb = FinalSpecular.rgb + BaseColor.rgb;
                SpecDiffuse.rgb *= _MainColor.rgb;
                SpecDiffuse.a = FinalSpecular.a * _BloomFactor * 10;

                //==========================================================================================
                // 屏幕空间深度等宽边缘光
                // 屏幕空间UV
                float2 RimScreenUV = float2(i.pos.x / _ScreenParams.x, i.pos.y / _ScreenParams.y);
                // 法线外扩偏移UV，把worldNormal转换到NDC空间
                float3 smoothNormal = normalize(UnpackNormalmapRGorAG(i.color));
                float3x3 tangentTransform = float3x3(i.worldTangent, i.worldBiTangent, i.worldNormal);
                float3 worldRimNormal = normalize(mul(smoothNormal, tangentTransform));
                float2 RimOffsetUV = float2(mul((float3x3) UNITY_MATRIX_V, worldRimNormal).xy * _RimOffsets * 0.01 / i.pos.w);
                RimOffsetUV += RimScreenUV;
                
                float ScreenDepth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_CameraDepthTexture, RimScreenUV);
                float Linear01ScreenDepth = LinearEyeDepth(ScreenDepth, _ZBufferParams);
                float OffsetDepth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_CameraDepthTexture, RimOffsetUV);
                float Linear01OffsetDepth = LinearEyeDepth(OffsetDepth, _ZBufferParams);

                float diff = Linear01OffsetDepth - Linear01ScreenDepth;
                float rimMask = step(_RimThresholds * 0.1, diff);
                // 边缘光颜色的a通道用来控制边缘光强弱
                half4 RimColors = float4(rimMask * _RimColors.rgb * _RimColors.a, 1) * _EnableRims;

                //------------------------------------------------------------------------------------------
                // Rim Light
                float lambertF = dot(mainLight.direction, i.worldNormal);
                float lambertD = max(0, -lambertF);
                lambertF = max(0, lambertF);
                float rim = 1 - saturate(dot(viewDir, i.worldNormal));

                float rimDot = pow(rim, _RimPow);
                rimDot = lambertF * rimDot + rimDot;
                float rimIntensity = smoothstep(0, _RimSmooth, rimDot);
                half4 Rim = _EnableRim * pow(rimIntensity, 5) * _RimColor * BaseColor;
                Rim.a = _EnableRim * rimIntensity * _BloomFactor;

                rimDot = pow(rim, _DarkSideRimPow);
                rimDot = lambertD * rimDot + rimDot;
                rimIntensity = smoothstep(0, _DarkSideRimSmooth, rimDot);
                half4 RimDS = _EnableRimDS * pow(rimIntensity, 5) * _DarkSideRimColor * BaseColor;
                RimDS.a = _EnableRimDS * rimIntensity * _BloomFactor;

                // Emission & Bloom
                half4 Emission;
                Emission.rgb = _Emission * _ShadowColor.rgb * _EmissionColors.rgb * SAMPLE_TEXTURE2D(_EmissionMap, sampler_EmissionMap, i.uv) - SpecDiffuse.rgb;
                Emission.a = _EmissionBloomFactor * BaseColor.a;

                half4 SpecRimEmission;
                SpecRimEmission.rgb = pow(_ShadowColor, 1) * _Emission;
                SpecRimEmission.a = (SpecDiffuse.a + Rim.a + RimDS.a);

                half4 SpecRimColor = SpecDiffuse + Rim + RimColors + Emission.a * Emission + SpecRimEmission.a * SpecRimEmission;

                //half4 FinalColor = (0.1 * LightColor * SpecRimColor + 0.9 * SpecRimColor);

                //return FinalSpecular;
                //return half4(1,1,1,1);
                //return FinalRamp + FinalSpecular + RimColors;
                //return (LightColor * SpecRimColor + SpecRimColor) + FinalRamp;

                // 计算其他光源
                #ifdef _AdditionalLights
                    uint pixelLightCount = GetAdditionalLightsCount();
                    for (uint lightIndex = 0u; lightIndex < pixelLightCount; ++ lightIndex)
                    {
                        // 获取其他光源
                        Light light = GetAdditionalLight(lightIndex, i.worldPos);
                        LightColor += half4(light.color, 1.0) * (light.distanceAttenuation * light.shadowAttenuation);
                    }
                #endif

                #if _SHADERENUM_HAIR
                    float factor = StrandSpecular(viewDir, i.worldBiTangent, lightDir, i.worldNormal, _Exponent, _Scale, _HairSpecularPower) * _EnableHairSpecular;
                    LightColor = LightColor + factor * BaseColor;
                #endif

                return (LightColor * SpecRimColor) + FinalRamp * LightColor;
            }
            ENDHLSL
        }

        Pass
        {
            Name "OUTLINE_PASS"
            Tags {}
            Cull Front

            HLSLPROGRAM
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT

            // #pragma shader_feature_local ENABLE_AUTOCOLOR
            #pragma shader_feature_local_fragment ENABLE_ALPHA_CLIPPING
            
            #pragma vertex OutlinePassVertex
            #pragma fragment OutlinePassFragment

            v2f OutlinePassVertex(a2v input)
            {
                v2f output = (v2f)0;
                // VertexPositionInputs contains position in multiple spaces (world, view, homogeneous clip space, ndc)
                // Unity compiler will strip all unused references (say you don't use view space).
                // Therefore there is more flexibility at no additional cost with this struct.
                VertexPositionInputs vertexInput = GetVertexPositionInputs(input.vertex);

                // Similar to VertexPositionInputs, VertexNormalInputs will contain normal, tangent and bitangent
                // in world space. If not used it will be stripped.
                VertexNormalInputs vertexNormalInput = GetVertexNormalInputs(input.normal, input.tangent);

                float3 positionWS = vertexInput.positionWS;

                positionWS = TransformPositionWSToOutlinePositionWS(vertexInput.positionWS, vertexInput.positionVS.z, vertexNormalInput.normalWS);

                // Computes fog factor per-vertex.
                float fogFactor = ComputeFogFactor(vertexInput.positionCS.z);

                // TRANSFORM_TEX is the same as the old shader library.
                output.uv.xy = TRANSFORM_TEX(input.texCoord, _MainTex);
                

                // packing positionWS(xyz) & fog(w) into a vector4
                output.positionWSAndFogFactor = float4(positionWS, fogFactor);
                output.worldNormal = vertexNormalInput.normalWS; //normlaized already by GetVertexNormalInputs(...)

                output.pos = TransformWorldToHClip(positionWS);

                // [Read ZOffset mask texture]
                // we can't use tex2D() in vertex shader because ddx & ddy is unknown before rasterization, 
                // so use tex2Dlod() with an explict mip level 0, put explict mip level 0 inside the 4th component of param uv)
                float outlineZOffsetMaskTexExplictMipLevel = 0;
                float outlineZOffsetMask = tex2Dlod(_OutlineZOffsetMaskTex, float4(input.texCoord,0,outlineZOffsetMaskTexExplictMipLevel)).r; //we assume it is a Black/White texture

                // [Remap ZOffset texture value]
                // flip texture read value so default black area = apply ZOffset, because usually outline mask texture are using this format(black = hide outline)
                outlineZOffsetMask = 1-outlineZOffsetMask;
                outlineZOffsetMask = saturate((outlineZOffsetMask - _OutlineZOffsetMaskRemapStart) / (_OutlineZOffsetMaskRemapEnd - _OutlineZOffsetMaskRemapStart));// allow user to flip value or remap

                // [Apply ZOffset, Use remapped value as ZOffset mask]
                output.pos = NiloGetNewClipPosWithZOffset(output.pos, _OutlineZOffset * outlineZOffsetMask + 0.03 * _IsFace);

                // ShadowCaster pass needs special process to positionCS, else shadow artifact will appear
                //--------------------------------------------------------------------------------------

                // see GetShadowPositionHClip() in URP/Shaders/ShadowCasterPass.hlsl
                // https://github.com/Unity-Technologies/Graphics/blob/master/com.unity.render-pipelines.universal/Shaders/ShadowCasterPass.hlsl
                float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, output.worldNormal, _LightDirection));


                //--------------------------------------------------------------------------------------    

                return output;
            }

            half4 OutlinePassFragment(v2f i): COLOR
            {
                half4 col = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv);
                return _OutlineColor * col;
            }
            ENDHLSL
        }

        Pass
        {
            Tags {"LightMode" = "DepthOnly"}
        }

        UsePass "Universal Render Pipeline/Lit/ShadowCaster"
    }
}

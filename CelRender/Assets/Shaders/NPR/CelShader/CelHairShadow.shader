Shader "Custom/HairShadow"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _Offset ("Offset", float) = 0.02
        [Header(Stencil)]
        _StencilRef ("_StencilRef", Range(0, 255)) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp ("_StencilComp", float) = 0
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "RenderPipeline" = "UniversalRenderPipeline" }

        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

        CBUFFER_START(UnityPerMaterial)
        float4 _Color;
        float _Offset;
        float4 _LightDirSS;
        CBUFFER_END
        ENDHLSL

        Pass
        {
            Name "HairShadow"
            Tags { "LightMode" = "UniversalForward" }

            Stencil
            {
                Ref [_StencilRef]
                Comp [_StencilComp]
                Pass Zero
            }

            ZTest LEqual
            ZWrite Off
            ColorMask 0

            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            struct a2v
            {
                float4 positionOS: POSITION;
                float4 color: COLOR;
            };

            struct v2f
            {
                float4 positionCS: SV_POSITION;
                float4 color: COLOR;
            };


            v2f vert(a2v v)
            {
                v2f o;

                VertexPositionInputs positionInputs = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = positionInputs.positionCS;

                float2 lightOffset = normalize(_LightDirSS.xy);
                //乘以_ProjectionParams.x是考虑裁剪空间y轴是否因为DX与OpenGL的差异而被翻转
                //参照https://docs.unity3d.com/Manual/SL-PlatformDifferences.html
                //"Similar to Texture coordinates, the clip space coordinates differ between Direct3D-like and OpenGL-like platforms"
                lightOffset.y = lightOffset.y * _ProjectionParams.x;
                o.positionCS.xy += lightOffset * _Offset;

                o.color = v.color;
                return o;
            }

            half4 frag(v2f i): SV_Target
            {
                return _Color;
            }
            ENDHLSL

        }

        Pass
        {
            Name "HairShadow_Face"
            Tags { "LightMode" = "UniversalForward" }

            Stencil
            {
                Ref 0
                Comp [_StencilComp]
                Pass keep
            }

            ZTest LEqual
            ZWrite Off

            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            struct a2v
            {
                float4 positionOS: POSITION;
                float4 color: COLOR;
                float2 uv: TEXCOORD;
            };

            struct v2f
            {
                float4 positionCS: SV_POSITION;
                float4 color: COLOR;
                float2 uv: TEXCOORD0;
            };


            v2f vert(a2v v)
            {
                v2f o;

                VertexPositionInputs positionInputs = GetVertexPositionInputs(v.positionOS.xyz);
                o.positionCS = positionInputs.positionCS;

                o.color = v.color;
                o.uv = v.uv;
                return o;
            }

            TEXTURE2D(_FaceTex);
            SAMPLER(sampler_FaceTex);

            half4 frag(v2f i): SV_Target
            {
                return SAMPLE_TEXTURE2D(_FaceTex, sampler_FaceTex, i.uv) * _Color;
            }
            ENDHLSL

        }
    }
}
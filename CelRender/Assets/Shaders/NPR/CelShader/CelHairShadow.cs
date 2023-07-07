using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CelHairShadow : ScriptableRendererFeature
{
    [System.Serializable]
    public class Setting
    {
        public Color hairShadowColor;
        [Range(0, 0.1f)]
        public float offset = 0.02f;
        [Range(0, 255)]
        public int stencilReference = 1;
        public CompareFunction stencilComparison;

        public RenderPassEvent passEvent = RenderPassEvent.BeforeRenderingTransparents;
        public LayerMask hairLayer;
        [Range(1000, 5000)]
        public int queueMin = 2000;

        [Range(1000, 5000)]
        public int queueMax = 3000;
        public Material material;

        public Texture faceTex;
        public LayerMask faceLayer;

    }
    public Setting setting = new Setting();
    class CustomRenderPass : ScriptableRenderPass
    {
        // This method is called before executing the render pass.
        // It can be used to configure render targets and their clear state. Also to create temporary render target textures.
        // When empty this render pass will render to the active camera render target.
        // You should never call CommandBuffer.SetRenderTarget. Instead call <c>ConfigureTarget</c> and <c>ConfigureClear</c>.
        // The render pipeline will ensure target setup and clearing happens in a performant manner.
        public ShaderTagId shaderTag = new ShaderTagId("UniversalForward");
        public Setting setting;

        FilteringSettings filtering;
        FilteringSettings filtering2;
        public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
        {
        }

        // Here you can implement the rendering logic.
        // Use <c>ScriptableRenderContext</c> to issue drawing commands or execute command buffers
        // https://docs.unity3d.com/ScriptReference/Rendering.ScriptableRenderContext.html
        // You don't have to call ScriptableRenderContext.submit, the render pipeline will call it at specific points in the pipeline.
        public CustomRenderPass(Setting setting)
        {
            this.setting = setting;

            RenderQueueRange queue = new RenderQueueRange();
            queue.lowerBound = Mathf.Min(setting.queueMax, setting.queueMin);
            queue.upperBound = Mathf.Max(setting.queueMax, setting.queueMin);
            filtering = new FilteringSettings(queue, setting.hairLayer);
            filtering2 = new FilteringSettings(queue, setting.faceLayer);
        }

        public override void Configure(CommandBuffer cmd, RenderTextureDescriptor cameraTextureDescriptor)
        {
            setting.material.SetColor("_Color", setting.hairShadowColor);
            setting.material.SetInt("_StencilRef", setting.stencilReference);
            setting.material.SetInt("_StencilComp", (int)setting.stencilComparison);
            setting.material.SetFloat("_Offset", setting.offset);

        }
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            var draw = CreateDrawingSettings(shaderTag, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
            draw.overrideMaterial = setting.material;
            draw.overrideMaterialPassIndex = 0;

            //获取主光源方向，并转换到相机空间
            var visibleLight = renderingData.cullResults.visibleLights[0];
            Vector2 lightDirSS = renderingData.cameraData.camera.worldToCameraMatrix * (visibleLight.localToWorldMatrix.GetColumn(2));
            setting.material.SetVector("_LightDirSS", lightDirSS);

            CommandBuffer cmd = CommandBufferPool.Get("DrawHairShadow");
            context.ExecuteCommandBuffer(cmd);
            context.DrawRenderers(renderingData.cullResults, ref draw, ref filtering);

            setting.material.SetTexture("_FaceTex", setting.faceTex);
            draw.overrideMaterialPassIndex = 1;
            context.DrawRenderers(renderingData.cullResults, ref draw, ref filtering2);
        }

        public override void FrameCleanup(CommandBuffer cmd)
        {

        }

        // Cleanup any allocated resources that were created during the execution of this render pass.
        public override void OnCameraCleanup(CommandBuffer cmd)
        {
        }
    }

    CustomRenderPass m_ScriptablePass;

    /// <inheritdoc/>
    public override void Create()
    {
        m_ScriptablePass = new CustomRenderPass(setting);

        // Configures where the render pass should be injected.
        //m_ScriptablePass.renderPassEvent = RenderPassEvent.BeforeRenderingOpaques;
        m_ScriptablePass.renderPassEvent = setting.passEvent;
    }

    // Here you can inject one or multiple render passes in the renderer.
    // This method is called when setting up the renderer once per-camera.
    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        if (setting.material != null)
            renderer.EnqueuePass(m_ScriptablePass);
    }
}



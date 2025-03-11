using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]

public class ExemploSlidesIE : MonoBehaviour 
{ 
    public Shader imageEffectShader;
    private Material imageEffectMaterial;

    void Start()
    {
        imageEffectMaterial = new Material(imageEffectShader);
    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        if (imageEffectMaterial != null)
        {
            Graphics.Blit(src, dest, imageEffectMaterial);
        }
    }
}


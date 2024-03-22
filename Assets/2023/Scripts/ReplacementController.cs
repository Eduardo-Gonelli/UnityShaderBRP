using UnityEngine;

[ExecuteInEditMode]
public class ReplacementController : MonoBehaviour
{
    // Shader Replacement
    public Shader replacementShader;

    private void OnEnable()
    {
        if(replacementShader != null)
        {
            GetComponent<Camera>().SetReplacementShader(replacementShader, "RenderType");
        }
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}

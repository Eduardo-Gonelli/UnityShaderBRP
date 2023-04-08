using UnityEngine;

public class ChangeShaderProperty : MonoBehaviour
{
    public Material material;
    public int colorOption = 0;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            // Desabilita a Keyword atual
            DisableCurrentKeyword();

            // Atualiza a opção de cor (ciclando entre 0, 1 e 2)
            colorOption = (colorOption + 1) % 3;

            // Habilita a nova Keyword
            EnableCurrentKeyword();
        }
    }

    private void DisableCurrentKeyword()
    {
        switch (colorOption)
        {
            case 0:
                material.DisableKeyword("_OPTIONS_OFF");
                break;
            case 1:
                material.DisableKeyword("_OPTIONS_RED");
                break;
            case 2:
                material.DisableKeyword("_OPTIONS_BLUE");
                break;
        }
    }

    private void EnableCurrentKeyword()
    {
        switch (colorOption)
        {
            case 0:
                material.EnableKeyword("_OPTIONS_OFF");
                break;
            case 1:
                material.EnableKeyword("_OPTIONS_RED");
                break;
            case 2:
                material.EnableKeyword("_OPTIONS_BLUE");
                break;
        }
    }
}


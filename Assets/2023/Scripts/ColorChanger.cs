using UnityEngine;

public class ColorChanger : MonoBehaviour
{
    public Material material;
    [SerializeField] float intervalTime = 0;
    public bool changeColors = false;
    public string colorPropertyName = "_Color"; // Nome da propriedade do shader que controla a cor
    private Color currentColor;
    private Color targetColor;
    private float interpolationTime;

    void Start()
    {
        // Inicialize as cores e o tempo de interpolação
        currentColor = material.GetColor(colorPropertyName);
        targetColor = GetRandomColor();
        interpolationTime = 0f;
    }

    void Update()
    {
        if (!changeColors) return;
        // Incremente o tempo de interpolação
        interpolationTime += Time.deltaTime;

        // Atualize a cor do material
        Color newColor = Color.Lerp(currentColor, targetColor, interpolationTime);
        material.SetColor(colorPropertyName, newColor);

        // Verifique se a interpolação terminou
        if (interpolationTime >= intervalTime)
        {
            // Atualize a cor atual, gere uma nova cor alvo e redefina o tempo de interpolação
            currentColor = newColor;
            targetColor = GetRandomColor();
            interpolationTime = 0f;
        }
    }

    private Color GetRandomColor()
    {
        return new Color(Random.value, Random.value, Random.value, 1);
    }
}

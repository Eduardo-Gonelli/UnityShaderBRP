using UnityEngine;
public class AlternateColor : MonoBehaviour
{
    Material material;    
    void Start()
    {
        material = GetComponent<Renderer>().material;
    }
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            // Random.value retorna um valor entre 0 e 1 (inclusive)
            float red = Random.value;
            float green = Random.value;
            float blue = Random.value;
            material.SetColor("_Color", new Color(red, green, blue));
        }
    }
}

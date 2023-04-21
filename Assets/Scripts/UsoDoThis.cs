using UnityEngine;

public class UsoDoThis : MonoBehaviour
{
    public int meuInteiro = 10;
    public float minhaFracao = 25.3f;
    // Start is called before the first frame update
    void Start()
    {
        SomaValores(35, 10.1f);
    }

    void SomaValores(int meuInteiro, float minhaFracao)
    {
        float resultadoSoma = meuInteiro + minhaFracao;
        float resultadoSoma2 = this.meuInteiro + this.minhaFracao;
                
        print("Sem this: " + resultadoSoma); // Exibe 35 + 10.1 = 45.1
        print("");
        print("Com this: " + resultadoSoma2); //Exibe 10 + 25.3 = 35.3
    }
}

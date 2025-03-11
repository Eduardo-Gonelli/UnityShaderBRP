using UnityEngine;

public class SetFaceCullingExample : MonoBehaviour
{

    public Material material;
    public int faceCullingValue = 0;

    private void Start(){ material = GetComponent<Renderer>().material;}

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
        {
            faceCullingValue = (faceCullingValue + 1) % 3;
            // 0 = Off, 1 = Front, 2 = Back
            material.SetFloat("_Face", faceCullingValue);
        }
    }
}

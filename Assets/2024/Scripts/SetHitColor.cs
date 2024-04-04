using UnityEngine;

public class SetHitColor : MonoBehaviour
{
    private Material material;
    private int colorOption = 0;
    private bool isHit = false;
    private bool hitInterpolation = false;
    private float hitInterpolationTime = 0.1f;
    private float hitTime = 2.0f;
    void Start()
    {
        material = GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space))
        {
            isHit = true;            
        }

        if (isHit)
        {                        
            if(hitTime > 0)
            {
                hitTime -= Time.deltaTime;
                if(hitInterpolation == false && hitInterpolationTime < 0)
                {
                    DisableCurrentKeyword();
                    colorOption = 1;
                    material.SetFloat("_Options", colorOption);
                    hitInterpolationTime = 0.1f;
                    hitInterpolation = true;                    
                    EnableCurrentKeyword();
                }
                else if(hitInterpolation == true && hitInterpolationTime < 0)
                {
                    DisableCurrentKeyword();
                    colorOption = 0;
                    material.SetFloat("_Options", colorOption);
                    hitInterpolationTime = 0.1f;
                    hitInterpolation = false;                    
                    EnableCurrentKeyword();
                }
                else
                {
                    hitInterpolationTime -= Time.deltaTime;
                }
            }
            else
            {
                isHit = false;
                hitInterpolation = false;
                hitInterpolationTime = 0.2f;
                hitTime = 2.0f;
                DisableCurrentKeyword();
                colorOption = 0;
                material.SetFloat("_Options", colorOption);
                EnableCurrentKeyword();
            }
        }
    }

    void DisableCurrentKeyword()
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

    void EnableCurrentKeyword()
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

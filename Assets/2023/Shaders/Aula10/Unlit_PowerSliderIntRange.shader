Shader "2023/Custom/PowerSliderIntRange"
{
    // Neste exemplo o Brightness ajusta o brilho do objeto 
    // O Samples não é usado para cor, apenas para um ajuste fino
    // do brilho, aumentando ou diminuindo dentro de um range específico
    Properties
    {
        [PowerSlider(3.0)] _Brightness("Brightness", Range(0.01, 1.0)) = 0.08
        [IntRange] _Samples("Samples", Range(0, 255)) = 100
        _MainTex("Texture", 2D) = "white" {}
    }
        SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _Brightness;
            int _Samples;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                float luminance = dot(col.rgb, float3(0.299, 0.587, 0.114));
                float invertedBrightness = 1.0 - _Brightness;                
                float glow = pow(luminance, invertedBrightness * 5.0 ) * _Samples * 0.01;
                col.rgb += glow;
                return col;
            }
            ENDCG
        }
    }
}

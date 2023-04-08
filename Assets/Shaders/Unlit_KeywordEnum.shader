Shader "Custom/Unlit_KeywordEnum"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
    // declara o drawer keywordenum
    [KeywordEnum(Off, Red, Blue)]
    _Options("Color Options", Float) = 0
    }
        SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // declara o pragma e as condições
            #pragma multi_compile _OPTIONS_OFF _OPTIONS_RED _OPTIONS_BLUE

            // Estrutura dos dados de entrada do shader de vértice
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

    // Estrutura dos dados de saída do shader de vértice e entrada do shader de fragmento
    struct v2f
    {
        float2 uv : TEXCOORD0;
        float4 vertex : SV_POSITION;
    };

    sampler2D _MainTex;

    // Função do shader de vértice
    v2f vert(appdata v)
    {
        v2f o;
        o.vertex = UnityObjectToClipPos(v.vertex);
        o.uv = v.uv;
        return o;
    }

    // Função do shader de fragmento
    half4 frag(v2f i) : SV_Target
    {
        half4 col = tex2D(_MainTex, i.uv);
        // gera as condicoes
        #if _OPTIONS_OFF
            return col;
        #elif _OPTIONS_RED
            return col * float4(1, 0, 0, 1);
        #elif _OPTIONS_BLUE
            return col * float4(0, 0, 1, 1);
        #endif
    }
    ENDCG
}
    }
}


Shader "Custom/Unlit_ExVariaveis"
{
    Properties
    {
        // declarações das variáveis
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1, 1, 1, 1)
    }
        SubShader
        {
            Pass
            {
                CGPROGRAM
                // Defina as pragmas de shader
                #pragma vertex vert
                #pragma fragment frag

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

        // adiciona as conexões com as variáveis
        sampler2D _MainTex;
        float4 _Color;

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
            return col * _Color;
        }
        ENDCG
    }
        }
}


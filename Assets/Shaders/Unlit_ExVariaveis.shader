Shader "Custom/Unlit_ExVariaveis"
{
    Properties
    {
        // declara��es das vari�veis
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

                // Estrutura dos dados de entrada do shader de v�rtice
                struct appdata
                {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                };

        // Estrutura dos dados de sa�da do shader de v�rtice e entrada do shader de fragmento
        struct v2f
        {
            float2 uv : TEXCOORD0;
            float4 vertex : SV_POSITION;
        };

        // adiciona as conex�es com as vari�veis
        sampler2D _MainTex;
        float4 _Color;

        // Fun��o do shader de v�rtice
        v2f vert(appdata v)
        {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv = v.uv;
            return o;
        }

        // Fun��o do shader de fragmento
        half4 frag(v2f i) : SV_Target
        {
            half4 col = tex2D(_MainTex, i.uv);
            return col * _Color;
        }
        ENDCG
    }
        }
}


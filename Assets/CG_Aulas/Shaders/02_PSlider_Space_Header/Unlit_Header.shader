Shader "CG_Aulas/02/Header"
{
    // ATEN��O, ESTE SHADER N�O VAI FUNCIONAR
    // Ele serve apenas para ilustrar a propriedade Header
    // o Unlit n�o possui specular.
    Properties
    {
        [Header(Specular properties)]
        _Specularity("Speculariry", Range(0.01, 1)) = 0.08
        _Brightness("Brightness", Range(0.01, 1)) = 0.08
        _SpecularColor("Specular Color", Color) = (1, 1, 1, 1)
        [Space(20)]
        [Header(Texture properties)]
        _MainTex("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}

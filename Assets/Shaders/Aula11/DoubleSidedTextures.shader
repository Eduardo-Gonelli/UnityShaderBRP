Shader "Aula11/DoubleSidedTextures"
{
    Properties
    {
        _FrontTexture("Front Texture", 2D) = "white" {}
        _BackTexture("Back Texture", 2D) = "white" {}
    }

        SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        LOD 100
        Cull Off
        Pass {
            CGPROGRAM
        #pragma vertex vert
        #pragma fragment frag
        #include "UnityCG.cginc"

        struct appdata
        {
            float4 vertex : POSITION;
            float2 uv : TEXCOORD0;
            float3 normal : NORMAL;
        };

        struct v2f
        {
            float2 uv : TEXCOORD0;
            bool frontFace : TEXCOORD1;
            float4 vertex : SV_POSITION;
        };

        sampler2D _FrontTexture;
        sampler2D _BackTexture;

        v2f vert(appdata v)
        {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv = v.uv;
            o.frontFace = dot(v.normal, float3(0, 0, -1)) > 0.0;
            return o;
        }

        fixed4 frag(v2f i) : SV_Target
        {
            fixed4 colFront = tex2D(_FrontTexture, i.uv);
            fixed4 colBack = tex2D(_BackTexture, i.uv);
            return i.frontFace ? colFront : colBack;
        }
        ENDCG
        }
        
    } // Adicionei uma chave aqui para fechar a seção SubShader
        FallBack "Diffuse"
}

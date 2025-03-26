Shader "CG_Aulas/04/DoubleSided"
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
        // AlphaToMask On
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
            float frontFace : TEXCOORD1;
            float4 vertex : SV_POSITION;
        };

        sampler2D _FrontTexture;
        sampler2D _BackTexture;

        v2f vert(appdata v)
        {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv = v.uv;
            // ObjectSpaceViewDir: Retorna a direção do espaço do objeto (não normalizada) 
            // da posição do vértice do espaço do objeto fornecido em direção à câmera.
            o.frontFace = dot(v.normal, ObjSpaceViewDir(v.vertex));
            return o;
        }

        fixed4 frag(v2f i) : SV_Target
        {
            fixed4 colFront = tex2D(_FrontTexture, i.uv);
            fixed4 colBack = tex2D(_BackTexture, i.uv);
            // O produto escalar positivo entre a normal e o vetor em direção à câmera
            // se a câmera está na frente do vértice. Se for negativo, está atrás.
            return i.frontFace > 0.0 ? colFront : colBack;
        }
        ENDCG
        }
    }
        FallBack "Diffuse"
}

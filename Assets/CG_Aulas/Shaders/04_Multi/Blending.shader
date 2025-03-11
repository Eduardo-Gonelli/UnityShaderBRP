Shader "CG_Aulas/04/Blending" {
    Properties{
        _MainTex("Texture", 2D) = "white" {}
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcFactor", Float) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstFactor", Float) = 1
    }

    SubShader{
        Tags {"Queue" = "Transparent" "RenderType" = "Transparent"}

        Pass {
            // A linha abaixo aplica a fórmula
            // B = SourceFactor * SourceValue [OP] DestinationFactor * DestinationValue
            Blend[_SrcBlend][_DstBlend]

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;

            v2f vert(appdata v) {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target {
                fixed4 col = tex2D(_MainTex, i.uv);
                col.rgb *= col.a;
                col.a = col.a;
                return col;
            }
            ENDCG
        }
    }
}

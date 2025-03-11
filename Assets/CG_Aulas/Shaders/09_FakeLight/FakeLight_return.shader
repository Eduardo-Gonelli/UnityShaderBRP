Shader "CG_Aulas/09/FakeLight_return"
{
    Properties
    {
        _MainTex("Main Texture", 2D) = "white" {}
        _TintColor("Tint Color", Color) = (1, 1, 1, 1)
        _LightDirection("Light Direction", Vector) = (-0.5, 1, -0.5)
    }

    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        LOD 100

        Pass {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };        

            struct v2f
            {
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _TintColor;
            float3 _LightDirection;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                return o;
            }

            half3 FakeLight(float3 Normal)
            {
                // You should define some light direction here                
                float operation = dot(Normal, _LightDirection);
                return operation;
            }

            half4 frag(v2f i) : SV_Target
            {
                float3 n = normalize(i.normal);
                float3 col = FakeLight(n);

                // Sample the texture and apply the tint color
                half4 texColor = tex2D(_MainTex, i.uv);
                col *= texColor.rgb * _TintColor.rgb;

                return float4(col.rgb, 1);
            }
            ENDHLSL
        }
    }         
}

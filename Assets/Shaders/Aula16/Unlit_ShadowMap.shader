Shader "Aula16/Unlit_ShadowMap"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        // Pass para shadow caster
        Pass 
        {
            Name "Shadow Caster"       // Não obrigatório ser Shadow Caster
            Tags 
            {
            "RenderType"="Opaque"
            "LightMode"="ShadowCaster" // Obrigatório para reconhecer a natureza do shader
            }
            
            ZWrite On

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_shadowcaster
            #include "UnityCg.cginc"
            //struct appdata { float4 vertex : POSITION; };
            struct v2f 
            { 
                V2F_SHADOW_CASTER; 
            };            
            v2f vert(appdata_full v)
            {
                v2f o;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
        // Pass padrão da cor
        Pass
        {
            Name "Shadow Map Texture"
            Tags
            {
                "RenderType"="Opaque"
                "LightMode"="ForwardBase"
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight 
            #include "UnityCg.cginc"
            #include "AutoLight.cginc"
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;                
                float4 pos : SV_POSITION;
                SHADOW_COORDS(1)
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;            

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                TRANSFER_SHADOW(o)
                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {                
                fixed4 col = tex2D(_MainTex, i.uv);                
                float shadow = SHADOW_ATTENUATION(i);
                col.rgb *= shadow;                                
                return col;
            }
            ENDCG
        }        
    }
}

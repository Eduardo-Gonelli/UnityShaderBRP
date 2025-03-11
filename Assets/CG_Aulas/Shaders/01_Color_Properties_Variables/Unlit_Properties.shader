Shader "CG_Aulas/01/Unlit_Properties"
{
	// ATENÇÃO, ESTE SHADER NÃO USA AS PROPRIEDADES.
	// SÃO APENAS EXEMPLOS DE DECLARAÇÃO
	Properties
	{	
		_MainTex("Texture", 2D) = "white" {}		
		_Specular("Specular", Range(0.0, 1.1)) = 0.3
		_Factor("Color Factor", Float) = 0.3
		_Cid("Color id", Int) = 2
	}
	
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100		
		Pass
		{			
			CGPROGRAM			
			#pragma vertex vert
			#pragma fragment frag			
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
			
			v2f vert(appdata v)
			{
				v2f o;		
				o.vertex = UnityObjectToClipPos(v.vertex);				
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);				
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);			
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
        }
	}
}
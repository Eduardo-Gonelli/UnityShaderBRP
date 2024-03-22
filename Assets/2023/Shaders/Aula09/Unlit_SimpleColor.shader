Shader "2023/Aula09/Unlit_SimpleColor"
{
	// campo das propriedades do shader
	Properties
	{
		// define a textura como uma propriedade do shader, que pode ser alterada no material
		_MainTex("Texture", 2D) = "white" {}		
	}
	// subshader
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100
		// passes
		Pass
		{
			// programa Cg
			CGPROGRAM
			// define as fun��es 'vert' e 'frag' como fun��es de shader 
			// de v�rtice e fragmento, respectivamente
			#pragma vertex vert
			#pragma fragment frag
			// habilita o suporte a n�voa (fog)
			#pragma multi_compile_fog

			// inclui fun��es e macros �teis da Unity
			#include "UnityCG.cginc"

			// estrutura dos dados de entrada do shader de v�rtice
			struct appdata
			{
				float4 vertex : POSITION; // posi��o do v�rtice
				float2 uv : TEXCOORD0;    // coordenadas de textura
			};

			// estrutura dos dados de sa�da do shader de v�rtice e entrada do shader de fragmento
			struct v2f
			{
				float2 uv : TEXCOORD0;         // coordenadas de textura
				UNITY_FOG_COORDS(1)            // coordenadas de n�voa (fog)
				float4 vertex : SV_POSITION;   // posi��o do v�rtice no espa�o de recorte
			};

			// vari�veis para a textura e suas transforma��es
			sampler2D _MainTex;
			float4 _MainTex_ST;

			// fun��o do shader de v�rtice
			v2f vert(appdata v)
			{
				v2f o;
				// transforma a posi��o do v�rtice do espa�o do objeto para o espa�o de recorte
				o.vertex = UnityObjectToClipPos(v.vertex);
				// transforma as coordenadas de textura usando as transforma��es fornecidas (_MainTex_ST)
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				// transfere as coordenadas de n�voa (fog) para a estrutura de sa�da
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			// fun��o do shader de fragmento
			fixed4 frag(v2f i) : SV_Target
			{
				// amostra a textura usando as coordenadas de textura interpoladas
				fixed4 col = tex2D(_MainTex, i.uv);
				// aplica o efeito de n�voa (fog) � cor do fragmento
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
        }
	}
}
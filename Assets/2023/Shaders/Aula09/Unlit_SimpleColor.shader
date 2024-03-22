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
			// define as funções 'vert' e 'frag' como funções de shader 
			// de vértice e fragmento, respectivamente
			#pragma vertex vert
			#pragma fragment frag
			// habilita o suporte a névoa (fog)
			#pragma multi_compile_fog

			// inclui funções e macros úteis da Unity
			#include "UnityCG.cginc"

			// estrutura dos dados de entrada do shader de vértice
			struct appdata
			{
				float4 vertex : POSITION; // posição do vértice
				float2 uv : TEXCOORD0;    // coordenadas de textura
			};

			// estrutura dos dados de saída do shader de vértice e entrada do shader de fragmento
			struct v2f
			{
				float2 uv : TEXCOORD0;         // coordenadas de textura
				UNITY_FOG_COORDS(1)            // coordenadas de névoa (fog)
				float4 vertex : SV_POSITION;   // posição do vértice no espaço de recorte
			};

			// variáveis para a textura e suas transformações
			sampler2D _MainTex;
			float4 _MainTex_ST;

			// função do shader de vértice
			v2f vert(appdata v)
			{
				v2f o;
				// transforma a posição do vértice do espaço do objeto para o espaço de recorte
				o.vertex = UnityObjectToClipPos(v.vertex);
				// transforma as coordenadas de textura usando as transformações fornecidas (_MainTex_ST)
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				// transfere as coordenadas de névoa (fog) para a estrutura de saída
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}

			// função do shader de fragmento
			fixed4 frag(v2f i) : SV_Target
			{
				// amostra a textura usando as coordenadas de textura interpoladas
				fixed4 col = tex2D(_MainTex, i.uv);
				// aplica o efeito de névoa (fog) à cor do fragmento
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
        }
	}
}
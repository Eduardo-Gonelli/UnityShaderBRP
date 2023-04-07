// Comentarios gerados via ChatGPT
Shader "Unlit/USB_simple_color"
{
	Properties
	{
		// Define a textura como uma propriedade do shader, que pode ser alterada no material
		_MainTex("Texture", 2D) = "white" {}
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			// Define as funções 'vert' e 'frag' como funções de shader de vértice e fragmento, respectivamente
			#pragma vertex vert
			#pragma fragment frag
			// Habilita o suporte a névoa (fog)
			#pragma multi_compile_fog

			// Inclui funções e macros úteis da Unity
			#include "UnityCG.cginc"

			// Estrutura dos dados de entrada do shader de vértice
			struct appdata
			{
				float4 vertex : POSITION; // Posição do vértice
				float2 uv : TEXCOORD0;    // Coordenadas de textura
			};

	// Estrutura dos dados de saída do shader de vértice e entrada do shader de fragmento
	struct v2f
	{
		float2 uv : TEXCOORD0;         // Coordenadas de textura
		UNITY_FOG_COORDS(1)            // Coordenadas de névoa (fog)
		float4 vertex : SV_POSITION;   // Posição do vértice no espaço de recorte
	};

	// Variáveis para a textura e suas transformações
	sampler2D _MainTex;
	float4 _MainTex_ST;

	// Função do shader de vértice
	v2f vert(appdata v)
	{
		v2f o;
		// Transforma a posição do vértice do espaço do objeto para o espaço de recorte
		o.vertex = UnityObjectToClipPos(v.vertex);
		// Transforma as coordenadas de textura usando as transformações fornecidas (_MainTex_ST)
		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		// Transfere as coordenadas de névoa (fog) para a estrutura de saída
		UNITY_TRANSFER_FOG(o,o.vertex);
		return o;
	}

	// Função do shader de fragmento
	fixed4 frag(v2f i) : SV_Target
	{
		// Amostra a textura usando as coordenadas de textura interpoladas
		fixed4 col = tex2D(_MainTex, i.uv);
	    // Aplica o efeito de névoa (fog) à cor do fragmento
	    UNITY_APPLY_FOG(i.fogCoord, col);
	    return col;
    }
        ENDCG
        }
	}
}
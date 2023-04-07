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
			// Define as fun��es 'vert' e 'frag' como fun��es de shader de v�rtice e fragmento, respectivamente
			#pragma vertex vert
			#pragma fragment frag
			// Habilita o suporte a n�voa (fog)
			#pragma multi_compile_fog

			// Inclui fun��es e macros �teis da Unity
			#include "UnityCG.cginc"

			// Estrutura dos dados de entrada do shader de v�rtice
			struct appdata
			{
				float4 vertex : POSITION; // Posi��o do v�rtice
				float2 uv : TEXCOORD0;    // Coordenadas de textura
			};

	// Estrutura dos dados de sa�da do shader de v�rtice e entrada do shader de fragmento
	struct v2f
	{
		float2 uv : TEXCOORD0;         // Coordenadas de textura
		UNITY_FOG_COORDS(1)            // Coordenadas de n�voa (fog)
		float4 vertex : SV_POSITION;   // Posi��o do v�rtice no espa�o de recorte
	};

	// Vari�veis para a textura e suas transforma��es
	sampler2D _MainTex;
	float4 _MainTex_ST;

	// Fun��o do shader de v�rtice
	v2f vert(appdata v)
	{
		v2f o;
		// Transforma a posi��o do v�rtice do espa�o do objeto para o espa�o de recorte
		o.vertex = UnityObjectToClipPos(v.vertex);
		// Transforma as coordenadas de textura usando as transforma��es fornecidas (_MainTex_ST)
		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		// Transfere as coordenadas de n�voa (fog) para a estrutura de sa�da
		UNITY_TRANSFER_FOG(o,o.vertex);
		return o;
	}

	// Fun��o do shader de fragmento
	fixed4 frag(v2f i) : SV_Target
	{
		// Amostra a textura usando as coordenadas de textura interpoladas
		fixed4 col = tex2D(_MainTex, i.uv);
	    // Aplica o efeito de n�voa (fog) � cor do fragmento
	    UNITY_APPLY_FOG(i.fogCoord, col);
	    return col;
    }
        ENDCG
        }
	}
}
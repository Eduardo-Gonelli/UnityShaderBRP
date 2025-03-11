Shader "CG_Aulas/SFS_GlitchEffect"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_GlitchAmount("Glitch Amount", Range(0, 1)) = 0.1
		_GlitchFrequency("Glitch Frequency", Range(0, 1)) = 0.1
	}

		SubShader
		{
			Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
			LOD 100

			CGPROGRAM
			#pragma surface surf Lambert

			sampler2D _MainTex;
			float _GlitchAmount;
			float _GlitchFrequency;

			struct Input
			{
				float2 uv_MainTex;
			};

			void surf(Input IN, inout SurfaceOutput o)
			{
				// Calcula um valor aleatório baseado nas coordenadas de textura e tempo
				float randValue = _GlitchFrequency * (tex2D(_MainTex, frac(IN.uv_MainTex * 1000)).r - 0.5) * _GlitchAmount;

				// Aplica o deslocamento aleatório às coordenadas de textura
				float2 glitchedUV = IN.uv_MainTex;
				glitchedUV.x += randValue;

				// Amostra a textura usando as coordenadas de textura deslocadas
				o.Albedo = tex2D(_MainTex, glitchedUV).rgb;
				o.Alpha = 1;
			}
			ENDCG
		}
			FallBack "Diffuse"
}

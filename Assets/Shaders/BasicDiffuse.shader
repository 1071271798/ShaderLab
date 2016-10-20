Shader "Custom/BasicDiffuse" {
	Properties {
		_EmissiveColor ("Emissive Color", Color) = (1, 1, 1, 1)
		_AmbientColor ("Ambient Color", Color) = (0, 0, 0, 1)
		_MySliderValue ("This is slider", Range(0, 10)) = 2.5
		_MainTex ("Main Tex", 2D) = "white" {}
		_TexRect("Tex Rect", Rect) = "white" {}
		_TextCube("Test Cube", Cube) = "white" {}
		_TestFloat("Test Float", float) = 1
		_TestVector("Test Vector", Vector) = (1, 1, 1, 1)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf BasicDiffuse
		

		sampler2D _MainTex;
		float4 _EmissiveColor;
		float4 _AmbientColor;
		float _MySliderValue;
		float4 _TexRect;
		float4 _TextCube;
		float _TestFloat;
		float4 _TestVector;

		struct Input {
			float2 uv_MainTex;
		};
		
		

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c;// = tex2D (_MainTex, IN.uv_MainTex);
			c = pow((_EmissiveColor + _AmbientColor), _MySliderValue);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

		inline float4 LightingBasicDiffuse(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			float difLight = max(0, dot(s.Normal, lightDir));
			float rimLight = max(0, dot(s.Normal, viewDir));
			// Add this line  
			float dif_hLambert = difLight * 0.5 + 0.5;
			float rim_hLambert = rimLight * 0.5 + 0.5;
			float3 ramp = tex2D(_MainTex, float2(dif_hLambert, rim_hLambert)).rgb;
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			col.a = s.Alpha;
			return col;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}

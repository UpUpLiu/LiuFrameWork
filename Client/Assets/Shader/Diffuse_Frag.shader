// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Light/DIffuse"{
	Properties{
		_Diffuse("DIffuse", Color) = (1,1,1,1)
	}
	SubShader {
		Pass{
			Tags { "LightMonde" = "ForwardBase" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "Lighting.cginc"
			fixed4 _Diffuse;
			struct  a2v{
				float4 vertex : POSITION ;
				float3 normal : NORMAL;
			};

			struct v2f{
				float4  pos : SV_POSITION;
				fixed3 color : COLOR;
			};

			v2f vert(a2v v){
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex );

				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

				fixed3 worldNormal = normalize(mul(v.normal, (float3x3)unity_WorldToObject));

				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);

				fixed3 diffuse = _LightColor0 * _Diffuse.rgb * saturate(dot(worldNormal, worldLight));
				
				o.color = ambient + diffuse;

				return o;
			}

			fixed4 frag(v2f i) : SV_Target{
				return fixed4(i.color, 1.0);
			}
			
			ENDCG

		}

	}
	FallBack  "DIffuse"
}
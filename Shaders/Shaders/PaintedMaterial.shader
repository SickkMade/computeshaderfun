Shader "Unlit/PaintedMaterial"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            StructuredBuffer<float4> _ColorBuffer;

            struct appdata
            {
                float4 vertex : POSITION;
                uint id: SV_VertexID;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = _ColorBuffer[v.id];
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return saturate(i.color);
            }
            ENDCG
        }
    }
}

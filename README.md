# Sobre o projeto
Este projeto possui alguns exemplos de shaders em Unity para ensino das linguagens de programação Cg, HLSL e ShaderLab.
Deverá utilizar **obrigatoriamente** o pipeline _Built-In Render Pipeline_.

## Cenas
### 00_Exemplos_SS_e_Unlit
A cena é composta de quatro objetos com shaders, três do tipo Unlit e um do tipo Standard Suface Shader, para análise da estrutura dos códigos de shader.
#### Shaders na cena
- ExemploSlides
- ExemploSlidesStandardSS
- ExemploSlidesUnlit
- ExemploUnlitColor
### 01_Color_Properties_Variables
Esta cena trabalha três shaders para estudo das propriedades ShaderLab e sua respectiva exibição no Inspector.
#### Shaders na cena
- Unlit_Properties
- Unlit_SimpleColor
- Unlit_Variaveis
### 02_PSlider_Space_Header
São trabalhadas algumas ferramentas para alteração da visualização das propriedades no Inspector, variando da constrição de algumas informações até a organização das propriedades no Inspector.
#### Shaders na cena
- Unlit_Header
- Unlit_PowerSliderInRange
- Unlit_SpaceHeader
### 02_Replacement
A cena 02_Replacement exibe os mesmos elementos da cena anterior, mas aplicando um shader diferente que, na renderização da câmera, aplica um filtro de cor.
#### Shaders na cena
- Unlit_ReplacementShader
### 03_Toggle
Nesta cena são trabalhados o Toggle, Enum e KeywordEnum para ativação/desativação de alguma propriedade e seleção de atributos entre múltiplas propriedades.
#### Shaders na cena
- KeywordEnum
- ToggleColor
- ToggleEnum
### 04_Multi
Nesta cena são trabalhados os shaders para filtrar o canal alpha deixando os objetos com transparências, misturas de cores, máscara de cores e renderização dupla.
#### Shaders na cena
- Alpha2Mask
- Blending
- ColorMaskBlue
- ColorMaskGreen
- DoubleSided
### 05_Stencil
Stencil é uma técnica que permite ocultar partes de objetos com base em um outro objeto e é bastante útil para criar, por exemplo, efeitos de "raio x". Esta cena aplica o efeito de Stencil.
#### Shaders na cena
- Stencil
- Stencil2
### 06_Transparency
Esta cena é preparada para o ensino do Queue Transparent e RenderType Transparent, fornecendo ferramentas para que os materiais possam apresentar transparência e deixar os objetos "invisíveis".
#### Shaders na cena
- Color Transparency
### 07_ZTest
ZTest serve para renderizarmos objetos que estão mais distantes como se estivessem na frente do outro e possui os valores "Always", "Less", "Greater", "LEqual", "GEqual", "Equal", "NotEqual".
A variação desses valores muda o comportamento do objeto.
#### Shaders na cena
- Ztest
### 08_ZWrite
Quando objetos compartilham o mesmo espaço na cena, as faces desses objetos podem ter conflitos na ordem de renderização gerando um efeito de "flickering". Ao trabalhar a propriedade ZWrite, podemos evitar que isso ocorra.
#### Shaders na cena
- ZWriteOff
- ZWriteOn
### 09_FakeLight
Shaders do tipo Unlit não interagem naturalmente com a iluminação da cena. Quando se quer "simular" sombras nos objetos, podemos aplicar shaders que realizam os cálculos necessários para uma projeção de sombra falsa.
#### Shaders na cena
- FakeLight_return
- FakeLight_void


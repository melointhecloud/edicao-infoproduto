# Edição de infoproduto

Skill para cortar aulas, reels e VSLs. Você manda as cenas ou o bruto e diz como quer a edição. O agente devolve o MP4.

A janela do OpenChatCut é o motor. Ela fica aberta, minimizada. O trabalho acontece no chat.

## O que cada sócio faz

Clone este repositório, abra a pasta no Grok e cole:

```text
Faz o setup da skill edicao-infoproduto. Lê skills/edicao-infoproduto/references/setup.md e executa até o verificador passar. Não edita vídeo neste passo.
```

Quando o setup terminar, abra um chat novo nesta pasta. Coloque os vídeos em `entrada/`, a música em `trilhas/` e o stock em `banco/`. Depois:

```text
Edita os vídeos de entrada/. Reel 9:16, corta silêncio e tomada repetida, legenda em português, trilha de trilhas/ se existir, e me entrega o MP4 em saida/.
```

Troque a segunda frase pelo pedido real.

## O que não entra no GitHub

O aplicativo, o token e os vídeos ficam na máquina de quem clonou. O arquivo `.gitignore` cobre isso.

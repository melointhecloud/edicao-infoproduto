---
name: edicao-infoproduto
description: >
  Edita vídeos de infoproduto a partir das cenas ou do bruto e devolve o MP4.
  Corta, junta, coloca transição, legenda, trilha local, zoom e motion.
  Use quando a pessoa mandar vídeos para editar, pedir um reel, um corte de VSL,
  uma aula editada, ou /edicao-infoproduto. No clone novo, faça o setup antes de editar.
---

# Edição de infoproduto

A pessoa manda as cenas ou o bruto e descreve a edição. Você devolve o MP4. A janela do OpenChatCut fica aberta e minimizada: ela é o motor, não o lugar do trabalho.

Duas leituras, e só a que o momento pede:

- Clone novo, motor parado, ou `verificar.sh` falhando: leia `references/setup.md` e execute. Não edite vídeo nesse passo.
- Vídeos e um pedido de edição: leia `references/operacao.md` e execute.

O corte do material filmado segue a skill `openchatcut`, em modo automático. Cartela, stop motion, título cinético e peça que não existe no bruto seguem a skill `hyperframes`, saem como clipe curto e entram na timeline. Banco de imagem e trilha vêm só das pastas `banco/` e `trilhas/` deste repositório.

Diga que o vídeo está pronto só depois que o arquivo estiver em `saida/` e o `ffprobe` mostrar trilha de vídeo com duração maior que zero.

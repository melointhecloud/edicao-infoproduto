# Operação

## Antes de cortar

Rode `bash skills/edicao-infoproduto/scripts/verificar.sh`. Se falhar, faça o setup. Não invente um corte sem o motor aceitar o token.

As ferramentas do OpenChatCut vêm do MCP `openchatcut`. Se elas não aparecem neste chat, peça um chat novo nesta pasta. Não peça para a pessoa editar na janela.

## O que usar

Pegue os vídeos que a pessoa mandou e copie para `entrada/`, com o nome original. Trilha e stock só entram se estiverem em `trilhas/` e `banco/`, ou se a pessoa passou o caminho de um arquivo local. Sem API de banco de imagem, sem gerador de vídeo pago, sem baixar clipe da internet.

Se o pedido não disser o contrário:

- formato 9:16
- legenda em português, palavra a palavra, fora do rosto
- corte de silêncio, tropeço e tomada repetida
- áudio original se `trilhas/` estiver vazio
- zoom só onde o pedido ou a ênfase da fala pedem
- transição curta entre cenas, sem efeito em todo corte

## Corte

Siga a skill `openchatcut`. Crie ou abra um projeto, importe `entrada/`, e use `approvalMode: "auto"`. A pessoa pediu entrega sem aprovação na tela.

Ordem: transcrever, cortar, juntar as cenas na ordem do pedido, transição, legenda, trilha, zoom, exportar para `saida/<nome>.mp4`. O nome vem do pedido. Sem nome, use a data e a hora local.

## Motion

Cartela, preço, stop motion, título cinético ou gráfico que não está no bruto: siga a skill `hyperframes` e renderize só esse trecho, em geral de 2 a 6 segundos, no mesmo formato do vídeo. Importe o MP4 resultante para a timeline no ponto que o pedido marcou. O vídeo inteiro continua no OpenChatCut.

## Entrega

Confira com `ffprobe` duração e a existência de faixa de vídeo. Diga o caminho em `saida/` e a duração. Se o export falhar, diga a ferramenta e a mensagem. Não diga que está pronto.

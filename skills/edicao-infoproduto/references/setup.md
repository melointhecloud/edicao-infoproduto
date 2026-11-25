# Setup

Execute na raiz do repositório clonado, na ordem. Pare no primeiro passo que falhar e diga à pessoa o comando que falta. Não peça o token: o script cria `.local/mcp-token` e o motor lê essa senha ao subir.

1. Confira `ffmpeg`, `curl` e, no Linux, `unsquashfs`. Se faltar, peça a instalação e pare. No Ubuntu o pacote do `unsquashfs` é `squashfs-tools`.
2. Rode `bash skills/edicao-infoproduto/scripts/instalar-motor.sh`.
   - Saída 0: o motor está extraído.
   - Saída 2: esta máquina é macOS ou Windows. Entregue a URL que o script imprimiu, espere a pessoa instalar e abrir o OpenChatCut, e pare. O AppImage e o `unsquashfs` são o caminho Linux x86_64.
3. Rode `bash skills/edicao-infoproduto/scripts/abrir-openchatcut.sh --background`. Espere a frase de que a porta 5199 respondeu. A janela pode ser minimizada.
4. Rode `bash skills/edicao-infoproduto/scripts/verificar.sh`. A única linha de sucesso é `OK: motor no ar e token aceito.`
5. Rode `bash skills/edicao-infoproduto/scripts/registrar-mcp.sh`. Isso grava o servidor no Grok do usuário, fora do git.
6. Se as skills `openchatcut`, `hyperframes`, `hyperframes-cli` e `hyperframes-registry` não estiverem instaladas neste ambiente, a pessoa roda, na raiz do clone:

```bash
npx skills add 0xsline/OpenChatCut --skill openchatcut -y
npx skills add heygen-com/hyperframes --skill hyperframes --skill hyperframes-cli --skill hyperframes-registry -y
```

7. Diga para abrir um chat novo nesta pasta. O chat que rodou o registro não ganha as ferramentas do motor até recarregar. O próximo pedido de edição já pode ir para `entrada/`.

Pastas da pessoa, vazias no clone: `entrada/` recebe os vídeos, `trilhas/` a música, `banco/` os clipes de stock, `saida/` o MP4. Nada disso vai para o GitHub.

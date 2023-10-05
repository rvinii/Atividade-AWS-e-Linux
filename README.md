# Configuração de Requisitos AWS e Linux

## Parte prática: Requisitos AWS

### Criar uma instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD)

Para criar uma instância EC2:

1. Acesse o console da AWS e vá para "Serviços" -> "EC2".
2. Clique em "Executar instância" e siga as etapas de configuração.
3. Defina um nome e tags para a instância.
4. Escolha o sistema operacional Amazon Linux 2.
5. Selecione a família t3.small.
6. Gere as chaves pública e privada durante a criação.
7. Configure a rede e o Grupo de Segurança.
8. Certifique-se de permitir o tráfego SSH de qualquer lugar.
9. Configure o armazenamento com pelo menos 16GB de SSD.
10. Clique em "Executar instância".

### Gerar uma chave pública para acesso ao ambiente

Para gerar uma chave pública:

1. Vá para "Par de Chaves (login)" no console da AWS.
2. Clique em "Criar novo par de chaves".
3. Dê um nome ao par de chaves.
4. Selecione o tipo "RSA".
5. Escolha o formato de chave privada ".pem".
6. Clique em "Criar par de chaves".
7. Agora você pode clicar em "Executar instância".

### Gerar um Elastic IP e anexar à instância EC2

Após criar a instância EC2:

1. Acesse "Redes e segurança" -> "IPs Elásticos".
2. Crie um IP elástico e associe-o à instância EC2.

### Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

Para liberar as portas:

1. Acesse "Redes e segurança" -> "Security Groups".
2. Selecione o grupo de segurança criado.
3. Edite as regras de entrada para permitir as portas 22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP e 443/TCP.

## Requisitos no Linux

**Antes de começar, certifique-se de ter a chave SSH em mãos.**

### Configurar o NFS

Para configurar o NFS:

1. Instale o NFS: `sudo yum install nfs-utils`
2. Inicie o serviço: `sudo systemctl start nfs-server`
3. Verifique o status: `sudo systemctl status nfs-server`
4. Ative o serviço na inicialização: `sudo systemctl enable nfs-server`
5. Crie um diretório de compartilhamento: `sudo mkdir /srv/share`
6. Para não haver a necessidade de autenticação para acesso a pasta de compartilhamento do NFS, defina
   permissões para acesso anônimo: `sudo chown nfsnobody:nfsnobody /srv/share`
8. Dê permissão para o NFS compartilhar o diretório com o intervalo de intervalo de 
    IPs selecionado: `/srv/share 172.31.20.74 * (rw,all_squash)` .
9. Atualize e reexporte os compartilhamentos: `sudo exportfs -rva`
10. Reinicie o serviço NFS: `sudo service nfs-kernel-server restart`

### Criar um diretório dentro do filesystem do NFS com seu nome

Para criar um diretório:

1. Navegue até o diretório de compartilhamento: `cd /srv/share`
2. Crie um diretório com seu nome: `sudo mkdir robertvini` (substitua "robertvini" pelo seu nome)
3. Defina permissões leitura, gravação e execução ao diretório: `chmod 777 robertvini`

### Configurar um servidor Apache

Para configurar o Apache:

1. Atualize os pacotes: `sudo yum update`
2. Instale o Apache: `sudo yum install httpd`
3. Inicie o Apache: `sudo systemctl start httpd`
4. Configure-o para iniciar automaticamente no boot: `sudo systemctl enable httpd`
5. Verifique o status do Apache: `sudo systemctl status httpd`

### Criar um script para validar o status do Apache

1. Crie um script, por exemplo: `sudo nano validacao_apache.sh` (escolha o nome que preferir).
2. Adicione o código para verificar o status do Apache e gerar arquivos de saída.
3. Salve o script e saia do editor.
4. Torne o script executável: `sudo chmod +x validacao_apache.sh`
5. Execute o script: `./validacao_apache.sh`

### Preparar a execução automatizada do script a cada 5 minutos

Para automatizar a execução a cada 5 minutos:

1. Digite no terminal: `crontab -e`
2. Adicione a seguinte linha: `*/5 * * * * /srv/share/validacao_apache.sh`
3. Salve e saia.


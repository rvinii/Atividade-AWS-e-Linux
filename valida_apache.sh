#!/bin/bash

    #//para_verificar_a_data_e_hora
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")


    ##//identificar_o_nome_servico
    service_name="Apache"

    #//variavel_para_receber_status
    status=""

        if systemctl is-active --quiet httpd; then
            status="ONLINE"
        else
            status="OFFLINE"
        fi
    #/mensagem_personalizada
    mensagem="Serviço $service_name está $status"

    #//salvar_no_diretorio_com_meu_nome
    echo "$timestamp $service_name $status $mensagem" > "/srv/share/robertvini/status_$status.txt"

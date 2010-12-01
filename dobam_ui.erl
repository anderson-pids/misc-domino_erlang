%% DOBAM - Bernardino Anderson Mário
%%       
%% Disciplina: Paradigmas de Linguagem de Programação 2010/2
%% Professor:  Salvador Ramos ( sramosbs@gmail.com )
%% Alunos : Anderson Pimentel ( andbrain@gmail.com )
%%          Mário Angel(mr.garcia1@hotmail.com)
%%          Rodrigo Bernardino ( rbbernardino@gmail.com )
%%
%% Objetivo : Módulo da interface texto

-module(dobam_ui).
-vsn(0.1).

-author('rbbernardino@gmail.com').
-author('mr.garcia1@hotmail.com').
-author('andbrain@gmail.com').

-export([init/0]).

%%-----------------------------------------------------------------------------
%%init()
%%Imprime o cabecalho inicial e pergunta se deseja ou nao comecar uma partida

init() ->
    io:format(os:cmd(clear)),
    io:format(    
          "\n\n" ++
	  "\t\t                DOMINO DOBAM \n\n"++
	  "\t\t     Autores: Mario, Rodrigo, Anderson \n\n"),
    io:format(
          "Domino DOBAM \n" ++
	  "(1) Jogar \n"++
	  "(2) Sair \n"),
    Read = io:fread("Escolha Opcar: ","~d"),
    
    case Read of
	{ok,[1]} ->
	    bam_ctrl ! {bam_ui, ins_nome},
	    ins_nome();
	{ok,[2]} ->
	    sair()
	    io:format("\n Saindo do jogo\n");
%	    io:format(os:cmd(exit));
	{ok, _} -> io:format(
		     "\n OPCAO INVALIDA\n" ++
			 "TENTE NOVAMENTE\n"),
		   init()
    end.
%%-----------------------------------------------------------------------------
%%ins_nome()
%%   
%% Permitir inserir o nome dos jogadores

ins_nome() ->

    io:format(os:cmd(clear)),
    io:format(
	      "\nDomino DOBAM \n" ++
	      "Digite o Nome dos jogadores\n"),

    {ok,Nome1} = io:fread("Jogador 1: ","~s"),

    Nomes = {Nome1,"Computador1","Computador2","Computador3"},

    %bam_ctrl ! {bam_ui, nomes, Nomes},

    %receive
	%{bam_ctrl, nomes, ok} ->
	    comeco({ok,Nome1}).
    %end;
%%-----------------------------------------------------------------------------
%%comeco()
%%   
%% Inicia uma partida

comeco({ok,Jogador}) ->
    io:format(os:cmd(clear)),
    io:format("\n\nA PARTIDA SERA INICIADA\n\n"),
    io:format("EMBARALHANDO AS PECAS\n\n"),
	   %funcao que embaralhar as pecas do jogo
    io:format("PECAS EMBARALHAS \n\n"),
    io:format("DISTRIBUINDO AS PECAS DOS JOGADORES\n\n"),
           %funcao que distribui as pecas de cada jogador
    io:format("PECAS DISTRIBUIDAS \n\n"),
    io:format("\n\nO jogador "++Jogador++" e o que ira comecar a jogar."),

    %bam_ctrl ! {bam_ui, comeco},
    
    %receive
	%{bam_ctrl, comeco, ok} ->
	     ativo().
    %end.

%%-----------------------------------------------------------------------------
%%ativo()
%%   
%% Permite jogar uma partida no jogo da velha BAM
%%

ativo() ->
    io:format("Mesa: \n\n"++
	    "-------------------------------------------------------------------\n\n\n\n"++
	    "\t\t                  [1,6][6,6][6,2]\n\n\n\n"++
	    "-------------------------------------------------------------------"
	     ).

%%-----------------------------------------------------------------------------
%% sair()
  
sair() ->
    dobam_ctrl ! {dobam_ui, sair},
    ok.

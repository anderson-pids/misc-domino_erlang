%% DOBAM - Bernardino Anderson Mário
%%       
%% Disciplina: Paradigmas de Linguagem de Programação 2010/2
%% Professor:  Salvador Ramos ( sramosbs@gmail.com )
%% Alunos : Anderson Pimentel ( andbrain@gmail.com )
%%          Mário Angel(mr.garcia1@hotmail.com)
%%          Rodrigo Bernardino ( rbbernardino@gmail.com )
%%
%% Objetivo : Módulo de controle do jogo

-module(dobam_ctrl).
-vsn(0.1).

-author('rbbernardino@gmail.com').
-author('mr.garcia1@hotmail.com').
-author('andbrain@gmail.com').

-export([start/0]).

start() ->
    Ctrl = self(),
    Partida = spawn( dobam_partida, start, [Ctrl] ),
    receive
	{dobam_ui, ins_nome} ->
	    Partida ! {dobam_ctrl, ins_nome},
	    ins_nome();
	 {dobam_ui, sair} ->
	    die
    end.

ins_nome() ->
    receive
	{dobam_ui, {nomes, Nomes}}

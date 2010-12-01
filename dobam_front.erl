%% BAM - Bernardino Anderson Mário
%%       
%% Disciplina: Engenharia de Software 2010/2
%% Professor:  Jucimar Jr ( jucimar.jr@gmail.com )
%% Alunos : Anderson Pimentel ( andbrain@gmail.com )
%%          Mário Angel
%%          Rodrigo Bernardino ( rbbernardino@gmail.com )
%%
%% Objetivo : Módulo front - função para iniciar o jogo

-module(dobam_front).
-vsn(1.0).

-author('rbbernardino@gmail.com').
-author('mr.garcia1@hotmail.com').
-author('andbrain@gmail.com').

-export([start/1]).

%%-----------------------------------------------------------------------------
%% start( UI )
%%   -> inicia os processos do jogo
%%   -> dependendo da interface selecionada, inicia a GUI ou TUI

start() ->
%    register( bam_ui,   spawn( bam_tui,  init,  [] ) ),
    register( dobam_ui, self() ),
    register( dobam_ctrl, spawn( dobam_ctrl, start, [] ) ),
    bam_tui:init().

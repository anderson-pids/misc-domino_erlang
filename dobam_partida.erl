-module(dobam_partida).
-compile(export_all).


%%%%%%%%%%%%%%%%%%%
%% TABULEIRO
%%
%% Tab   = [ P1, P2, P3, P4 ]
%% PN    = [LadoA, LadoB]
%% LadoX = integer() == 0..6
%% 
%% exemplo de Tab: [ [1,2], [2,3], [3,6], [6,3] ]
%%
%%%%%%%%%%%%%%%%%%%

active( Tab ) ->
    receive
	{dobam_ctrl, extremos} ->
	    [P1| _] = Tab,
	    [Prim,_] = P1,
	    [_,Ult] = ultima_peca( Tab ),
	    Msg = { {prim, Prim}, {ult, Ult} },
	    io:format("\n\n~p\n\n", [Msg]),
%	    dobam_ctrl ! { dobam_partida, Msg },
	    active( Tab );
	
	%% supondo que a verificação já foi realizada,
	%% jogue!
	{dobam_ctrl, {jogar, prim, Peca}} ->
	    Prim_peca = hd(Tab),
	    [Prim_num, _] = Prim_peca,
	    [ A, B ] = Peca,
	    Nv_tab = case Prim_num of
			 A -> [ [B,A] ] ++ Tab;
			 B -> [ [A,B] ] ++ Tab
		     end,
	    io:format("\n\n~p\n\n", [Nv_tab]),
	%   dobam_ctrl ! {
	    active( Nv_tab );
	
	{dobam_ctrl, {jogar, ult, Peca}} ->
	    [_, Ult] = ultima_peca( Tab ),
	    [ A, B ] = Peca,
	    case Ult of
		A -> Nv_tab = Tab ++ [ [A,B] ];
		B -> Nv_tab = Tab ++ [ [B,A] ]
	    end,
	    io:format("\n\n~p\n\n", [Nv_tab]),
	    active( Nv_tab );

	die -> ok
    end.
			







ultima_peca( [P] )   -> P;
ultima_peca( [_|T] ) -> ultima_peca( T ).

t() ->
    L = gerar_pecas(),
    io:format("PECAS:\n" ++ 
	      "~p\n\n", [L]),
    Jogs = dist_pecas( L ),
    io:format("PECAS DISTRIBUIDAS:\n" ++
	      "Jog1: ~p\n" ++
	      "Jog2: ~p\n" ++
	      "Jog3: ~p\n" ++
	      "Jog4: ~p\n" ++
	      "\n",
	      Jogs).

gerar_pecas() ->
    L = lists:seq(0,6),
    [ [A, B] || A <- L,
		B <- L,
		B >= A
    ].

dist_pecas( L ) ->
    {J1, L1} = fill_jog( L  ),
    {J2, L2} = fill_jog( L1 ),
    {J3, L3} = fill_jog( L2 ),
    {J4, _L4} = fill_jog( L3 ),
    [J1, J2, J3, J4].
 
fill_jog( Pecas ) ->
    fill_jog( [], Pecas ).

fill_jog( Jog, Rest_pecas ) when (length(Jog) == 7) ->
    {Jog, Rest_pecas};

fill_jog( Jog, Pecas ) ->
    {P, Rest_pecas} = sortear_peca( Pecas ),
    fill_jog( [P| Jog], Rest_pecas ).

sortear_peca( Pecas ) ->
    Qtd_pecas = length(Pecas),
    %% gera inteiro aleatorio entre 1 e o tamanho especificado
    N = random:uniform( Qtd_pecas ),
    remover_peca( N, Pecas ).

%% Remover peca N da lista de pecas...
remover_peca( N, Pecas ) ->
    remover_peca( N, Pecas, [] ).

remover_peca( 1, [H| T], Rest_pecas ) ->
    Nv_pecas = T ++ Rest_pecas,
    {H, Nv_pecas};

remover_peca( N, [H| T], Rest_pecas ) ->
    remover_peca( N-1, T, [H| Rest_pecas] ).

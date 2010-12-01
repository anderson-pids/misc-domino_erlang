-module(dobam_partida).
-compile(export_all).

t() ->
    L = gerar_pecas(),
    dist_pecas( L ).

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
    {J1, J2, J3, J4}.

fill_jog( L ) ->
    fill_jog( [], L, [] ).

fill_jog( [], L, [] ) ->
    L. 

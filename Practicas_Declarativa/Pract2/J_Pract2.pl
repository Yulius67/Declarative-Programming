% Ejercicio 4 - Definir un predicado sus(X,Y,L1,L2) Capaz de sustituir
% un elemento X por otro Y en la lista L1 para dar L2.
%

sus(_,_,[],[]).
sus(X,Y,[X|Yn],[Y|Ln]):-!,sus(X,Y,Yn,Ln).
sus(X,Y,[T|Yn],[T|Ln]):-sus(X,Y,Yn,Ln).

sus2(_,_,[],[]).
sus2(X,Y,[T|Tn],[T|Un]):-Y=T,sus(X,Y,Tn,Un).
sus2(X,Y,[T|Tn],[T|Un]):-Y\=T,sus(X,Y,Tn,Un).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 5.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/* Aplanar una lista: Definir la relaci�n aplanar(Lista, Aplanada),
donde Lista es en general una lista de listas, tan compleja en su
anidamiento como queramos imaginar, y Aplanada es la lista que resulta
de reorganizar los elementos contenidos en las listas anidadas en un
�nico nivel. Por ejemplo:
	?- aplanar([[a, b], [c, [d, e]], f], L).
	L = [a, b, c, d, e, f]                              */

aplanar2([], []).
aplanar2([X|Resto], Resultado) :-atomic(X), aplanar2(Resto, Res_Resto), Resultado = [X|Res_Resto].
aplanar2([X|Resto], Resultado) :-not(atomic(X)), aplanar2(X, Res_X), aplanar2(Resto, Res_Resto), append(Res_X, Res_Resto, Resultado).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ejercicio 6.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% igualesElem(L1,L2) comprueba que L1 y L2 son listas con iguales elementos
%%% en cualquier orden.

% Primero ver que coincidan los tama�os de las listas
mismo_tamano([],[]).
mismo_tamano([_|L1],[_|L2]):-mismo_tamano(L1,L2).

% Tambi�n necesitamos eliminar elementos de una lista
eliminar(_,[],[]).
eliminar(X,[X|Ys],Ys):- !.
eliminar(X,[Y|Ys],[Y|Zs]):- eliminar(X,Ys,Zs).

% Y ahora el algoritmo
igualesElem([],[]).
igualesElem([X|Xn],[X|Yn]):- ! ; mismo_tamano([X|Xn],[X|Yn]),
                             igualesElem(Xn,Yn).
igualesElem([X|Xn],[Y|Yn]):-mismo_tamano([X|Xn],[Y|Yn]),
                             (eliminar(X,[Y|Yn],L1),eliminar(Y,[X|Xn],L2)),
                             igualesElem(L1,L2).

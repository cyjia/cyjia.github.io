prologues:=3;
verbatimtex
%&latex
\documentclass{minimal}
\begin{document}
etex

u:=25;
h:=10;
w:=10;

beginfig(1);
  draw (1u, 1u)--(1u, h * u);
  draw (1u, 1u)--(w*u, 1u);

  draw (0.9u, 9u)--(1.1u, 9u);
  draw (0.9u, 5u)--(1.1u, 5u);
  draw (0.9u, 3u)--(1.1u, 3u);
  draw (0.9u, 2u)--(1.1u, 2u);
  label.lft(btex $v_4=8$ etex, (1u, 9u));
  label.lft(btex $v_3=4$ etex, (1u, 5u));
  label.lft(btex $v_2=2$ etex, (1u, 3u));
  label.lft(btex $v_1=1$ etex, (1u, 2u));

  label.rt(btex $v_j=2^{j-1}$ etex, (1.5u, 7u));

  for i=1 upto 4:
    draw (1u + i * 1.8u, 1.1u)--(1u + i * 1.8u, 0.9u);
    label.bot(decimal i, (1u + i * 1.8u, 1u));
  endfor

  pickup pencircle scaled 2;
  draw (1u, 2u)--(2.8u,2u)--(2.8u,3u)--(4.6u,3u)--(4.6u,5u)--(6.4u,5u)--(6.4u,9u)--(8.2u,9u);

endfig ; end.

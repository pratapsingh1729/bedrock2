(*tag:importboilerplate*)
Require Coq.Lists.List.

(*tag:spec*)
Notation "xs ;+ x" := (cons x xs) (at level 60, format "xs ;+ x") : list_scope.
Notation "xs ;++ ys" := (app ys xs) (at level 60, format "xs  ;++  ys") : list_scope.

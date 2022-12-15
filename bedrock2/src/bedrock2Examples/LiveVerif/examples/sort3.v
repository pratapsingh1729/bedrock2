(* -*- eval: (load-file "../live_verif_setup.el"); -*- *)
Require Import coqutil.Sorting.Permutation.
Require Import bedrock2Examples.LiveVerif.LiveVerifLib. Load LiveVerif.

Hint Extern 4 (Permutation _ _) =>
  eauto using perm_nil, perm_skip, perm_swap, perm_trans
: prove_post.

#[export] Instance spec_of_sort3_separate_args: fnspec :=                      .**/

void sort3_separate_args(uintptr_t a0, uintptr_t a1, uintptr_t a2) /**#
  ghost_args := (R: mem -> Prop) in0 in1 in2;
  requires t m := <{ * uint 32 in0 a0
                     * uint 32 in1 a1
                     * uint 32 in2 a2
                     * R }> m;
  ensures t' m' := t' = t /\ exists out0 out1 out2,
            <{ * uint 32 out0 a0
               * uint 32 out1 a1
               * uint 32 out2 a2
               * R }> m' /\
            Permutation [| in0; in1; in2 |] [| out0; out1; out2 |] /\
            out0 <= out1 <= out2 #**/                                    /**.
Derive sort3_separate_args SuchThat (fun_correct! sort3_separate_args)
As sort3_separate_args_ok.                                                    .**/
{                                                                        /**. .**/
  uintptr_t w0 = load(a0);                                               /**. .**/
  uintptr_t w1 = load(a1);                                               /**. .**/
  uintptr_t w2 = load(a2);                                               /**. .**/
  if (w1 <= w0 && w1 <= w2) {                                            /**. .**/
    store(a0, w1);                                                       /**. .**/
    w1 = w0;                                                             /**. .**/
  } else {                                                               /**. .**/
    if (w2 <= w0 && w2 <= w1) {                                          /**. .**/
      store(a0, w2);                                                     /**. .**/
      w2 = w0;                                                           /**. .**/
    } else {                                                             /**. .**/
    }                                                                    /**. .**/
  }                                                                      /**. .**/
  if (w2 < w1) {                                                         /**. .**/
    store(a1, w2);                                                       /**. .**/
    store(a2, w1);                                                       /**. .**/
  } else {                                                               /**. .**/
    store(a1, w1);                                                       /**. .**/
    store(a2, w2);                                                       /**. .**/
  }                                                                      /**. .**/
}                                                                        /**.
Qed.

#[export] Instance spec_of_sort3: fnspec :=                                   .**/

void sort3(uintptr_t a) /**#
  ghost_args := (R: mem -> Prop) in1 in2 in3;
  requires t m := sep (array (uint 32) 3 [| in1; in2; in3 |] a) R m;
  ensures t' m' := t' = t /\ exists out1 out2 out3,
            sep (array (uint 32) 3 [| out1; out2; out3 |] a) R m' /\
            Permutation [| in1; in2; in3 |] [| out1; out2; out3 |] /\
            out1 <= out2 <= out3 #**/                                    /**.
Derive sort3 SuchThat (fun_correct! sort3) As sort3_ok.                       .**/
{                                                                        /**. (* .**/
  uintptr_t w0 = load(a);                                                /**. .**/
  uintptr_t w1 = load(a+4);                                              /**. .**/
  uintptr_t w2 = load(a+8);                                              /**. .**/
  if (w1 <= w0 && w1 <= w2) {                                            /**. .**/
    store(a, w1);                                                        /**. .**/
    w1 = w0;                                                             /**. .**/
  } else {                                                               /**. .**/
    if (w2 <= w0 && w2 <= w1) {                                          /**. .**/
      store(a, w2);                                                      /**. .**/
      w2 = w0;                                                           /**. .**/
    } else {                                                             /**. .**/
    }                                                          /**. .**/ /**. .**/
  }                                                            /**. .**/ /**. .**/
  if (w2 < w1) {                                                         /**. .**/
    store(a+4, w2);                                                      /**. .**/
    store(a+8, w1);                                                      /**. .**/
  } else {                                                               /**. .**/
    store(a+4, w1);                                                      /**. .**/
    store(a+8, w2);                                                      /**. .**/
  }                                                            /**. .**/ /**. .**/
}                                                                        /**.
Qed. *) Abort.

End LiveVerif. Comments .**/ //.
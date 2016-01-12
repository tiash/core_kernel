  $ utop=$TESTDIR/../src/utop

  $ $utop -stdin <<"EOF"
  > open Core_kernel.Std
  > let () =
  >   let added = ref false in
  >   let tree =
  >     Avltree.add Avltree.empty ~key:0 ~data:(`A "Hello, world!") ~compare
  >       ~added ~replace:true
  >   in
  >   let x : (int, [ `A of string ]) Avltree.t = tree in
  >   ignore (Avltree.add tree ~key:0 ~data:(`B 0) ~compare
  >             ~added ~replace:true : (_, _) Avltree.t);
  >   match Avltree.find x 0 ~compare:compare with
  >   | None -> assert false
  >   | Some (`A str) -> print_string str (* BOOM! *)
  > EOF
  File "(stdin)", line 9, characters 40-46:
  Error: This expression has type [> `B of int ]
         but an expression was expected of type [ `A of string ]
         The second variant type does not allow tag(s) `B
  [2]

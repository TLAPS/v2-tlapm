(* Copyright (C) 2014 MSR-INRIA
 *
 * SANY expressions
 * This file should be broken into xml utilities, sany ds and sany export
 *
 * Author: TL
 *)

open Commons
open Xmlm

type node =
  | N_ap_subst_in of ap_subst_in
  | N_assume_prove of assume_prove
  | N_def_step of def_step
  | N_expr of expr
  | N_op_arg of op_arg
  | N_instance of instance
  | N_new_symb of new_symb
  | N_proof of proof
  | N_formal_param of formal_param
  | N_module of mule
  | N_op_decl of op_decl
  | N_op_def of op_def
  | N_assume of assume
  | N_theorem of theorem
  | N_use_or_hide of use_or_hide

and expr =
  | E_at of at
  | E_decimal of decimal
  | E_label of label
  | E_let_in of let_in
  | E_numeral of numeral
  | E_op_appl of op_appl
  | E_string of strng
  | E_subst_in of subst_in

and expr_or_op_arg =
  | EO_expr of expr
  | EO_op_arg of op_arg

and expr_or_assume_prove =
  | EA_expr of expr
  | EA_assume_prove of assume_prove

and  new_symb_or_expr_or_assume_prove =
  | NEA_new_symb of new_symb
  | NEA_expr of expr
  | NEA_assume_prove of assume_prove

and ap_subst_in = {
  location          : location;
  level             : level;
  substs            : subst list;
  body              : node
}

and subst_in = {
  location          : location;
  level             : level;
  substs            : subst list;
  body              : expr
}

and instance = {
  location          : location;
  level             : level;
  name              : string;
  substs            : subst list;
  params            : formal_param list
}

and subst = {
  location          : location;
  level             : level;
  op                : op_decl;
  expr              : expr_or_op_arg
}

and assume = {
  location          : location;
  level             : level;
  expr              : expr
}

and theorem = {
  location          : location;
  level             : level;
  expr              : expr_or_assume_prove;
  proof             : proof;
  suffices          : bool
}

and assume_prove = {
  location          : location;
  level             : level;
  assumes           : new_symb_or_expr_or_assume_prove list;
  prove             : expr;
  suffices          : bool;
  boxed             : bool
}

and new_symb = {
  location          : location;
  level             : level;
  op_decl           : op_decl;
  set               : expr
}

and op_def =
  | O_module_instance of module_instance
  | O_user_defined_op of user_defined_op
  | O_builtin_op of builtin_op

and module_instance = {
  location          : location;
  level             : level;
  name              : string
}

and user_defined_op = {
  location          : location;
  level             : level;
  name              : string;
  arity             : int;
  body              : expr;
  params            : (formal_param * bool (*is leibniz*)) list;
  recursive         : bool
}

and builtin_op = {
  location          : location;
  level             : level;
  name              : string;
  arity             : int;
  params            : (formal_param * bool (*is leibniz*)) list
}

and op_arg = {
  location          : location;
  level             : level;
  name              : string;
  arity             : int
}

and formal_param = {
  location          : location;
  level             : level;
  name              : string;
  arity             : int
}

and op_decl = {
  location          : location;
  level             : level;
  name              : string;
  arity             : int;
  kind              : op_decl_kind
}

and proof =
  | P_omitted of omitted
  | P_obvious of obvious
  | P_by of by
  | P_steps of steps

and omitted = {
  location          : location;
  level             : level;
}

and obvious = {
  location          : location;
  level             : level;
}

and expr_or_module_or_module_instance =
  | EMM_expr of expr
  | EMM_module of mule
  | EMM_module_instance of module_instance

and user_defined_op_or_module_instance_or_theorem_or_assume =
  | UMTA_user_definewd_op of user_defined_op
  | UMTA_module_instance of module_instance
  | UMTA_theorem of theorem
  | UMTA_assume of assume

and by = {
  location          : location;
  level             : level;
  facts             : expr_or_module_or_module_instance list;
  defs              : user_defined_op_or_module_instance_or_theorem_or_assume list;
  only              : bool
}

and steps = {
  location          : location;
  level             : level;
  steps             : step list
}

and step =
  | S_def_step of def_step
  | S_use_or_hide of use_or_hide
  | S_instance of instance
  | S_theorem of theorem

and def_step = {
  location          : location;
  level             : level;
  defs              : op_def list
}

and use_or_hide = {
  location          : location;
  level             : level;
  facts             : expr_or_module_or_module_instance list;
  defs              : user_defined_op_or_module_instance_or_theorem_or_assume list;
  only              : bool;
  hide              : bool
}

and at = {
  location          : location;
  level             : level;
  except            : op_appl;
  except_component  : op_appl
}

and decimal = {
  location          : location;
  level             : level;
  mantissa          : int;
  exponent          : int
}

and label = {
  location          : location;
  level             : level;
  name              : string;
  arity             : int;
  body              : expr_or_assume_prove;
  params            : formal_param list
}

and op_def_or_theorem_or_assume =
  | OTA_op_def of op_def
  | OTA_theorem of theorem
  | OTA_assume of assume

and let_in = {
  location          : location;
  level             : level;
  body              : expr;
  op_defs           : op_def_or_theorem_or_assume list
}

and numeral = {
  location          : location;
  level             : level;
  value             : int
}

and strng = {
  location          : location;
  level             : level;
  value             : string
}

and formal_param_or_module_or_op_decl_or_op_def_or_theorem_or_assume =
  | FMOTA_formal_param of formal_param
  | FMOTA_module of mule
  | FMOTA_op_decl of op_decl
  | FMOTA_op_def of op_def
  | FMOTA_theorem of theorem
  | FMOTA_assume of assume

and op_appl = {
  location          : location;
  level             : level;
  operator          : formal_param_or_module_or_op_decl_or_op_def_or_theorem_or_assume;
  operands          : expr_or_op_arg list;
  bound_symbols     : bound_symbol list
}

and bound_symbol =
  | B_unbounded_bound_symbol of unbounded_bound_symbol
  | B_bound_bound_symbol of bounded_bound_symbol

and unbounded_bound_symbol = {
  param             : formal_param;
  tuple             : bool
}

and bounded_bound_symbol = {
  params            : formal_param list;
  tuple             : bool;
  domain            : expr
}

(* modules *)
and mule = {
  name              : string;
  location          : location;
  constants         : op_decl list;
  variables         : op_decl list;
  definitions       : op_def list ;
  assumptions       : assume list ;
  theorems          : theorem list ;
}
(*
 * if context is given, then we check both tg and tg^"Ref"
 * and if there is Ref, we get the item from the context.
 * We need to remember to use mk functions for term sharing
 * TODO in SANY, move the context element to be appended first in the tree (before, location, name, etc.)
 *)
let rec get_children ?context:(con=None) i tg f =
  match (peek i) with
  | `El_start tag when (snd (fst tag) = tg) ->
      let child =  f i in
      child :: (get_children ~context:con i tg f)
  | `El_start tag -> []
  | `El_end -> []
  | _ -> failwith "Illegal XML element"

let get_child ?context:(con=None) i tg f =
  let chldn = get_children ~context:con i tg f in
  assert (List.length chldn = 1);
  List.hd chldn

let open_tag i tg =  match (input i) with
  | `El_start tag when (snd (fst tag) = tg) -> ()
  | `El_start tag -> failwith ("Illegal XML start tag: " ^ (snd(fst tag)) ^ " expected: " ^ tg)
  | _ -> failwith "Illegal XML element"

let close_tag i = match (input i) with
  | `El_end -> ()
  | `El_start d -> failwith ("Illegal end tag, got start tag: " ^ (snd(fst d)))
  | _ -> failwith "Illegal XML element"

let get_children_in ?context:(con=None) i tg_par tg_chdrn f =
  open_tag i tg_par;
  let ret = get_children ~context:con i tg_chdrn f in
  close_tag i;
  ret

let get_child_in ?context:(con=None) i tg_par tg_chd f =
  let chldn = get_children_in ~context:con i tg_par tg_chd f in
  assert (List.length chldn = 1);
  List.hd chldn

let get_data_in i tg f =
  open_tag i tg;
  let ret = f i in
  close_tag i;
  ret

let read_int i = match (input i) with
  | `Data d -> int_of_string d
  | _ -> failwith "expected data element"

let read_string i = match (input i) with
  | `Data d -> d
  | _ -> failwith "expected data element"

let read_entry i = assert false
let init_context_map ls = assert false

let read_location i =
  open_tag i "location";
  open_tag i "column";
  let cb = get_data_in i "begin" read_int in
  let ce = get_data_in i "end" read_int in
  close_tag i;
  open_tag i "line";
  let lb = get_data_in i "begin" read_int in
  let le = get_data_in i "end" read_int in
  close_tag i;
  let fname = get_data_in i "filename" read_string in
  close_tag i;
  { column = {rbegin = cb; rend = ce};
    line = {rbegin = lb; rend = le};
    filename = fname }

let read_name i = assert false
let read_op_decl i = assert false
let read_op_def i = assert false
let read_assume i = assert false
let read_theorem i = assert false

let read_module i =
  open_tag i "ModuleNode";
  let loc = get_child i "location" read_location in
  (* we need to read the context first and pass it for the symbols (thm, const, etc.*)
  let con = Some (init_context_map (get_children_in i "context" "entry" read_entry)) in
  let name = get_data_in i "uniquename" read_string in
  print_string name;
  let ret = {
    location = loc;
    name = name;
    constants = get_children_in ~context:con i "constants" "OpDeclNode" read_op_decl;
    variables = get_children_in ~context:con i "variables" "OpDeclNode" read_op_decl;
    definitions = get_children_in ~context:con i "definitions" "OpDefNode" read_op_def;
    assumptions = get_children_in ~context:con i "assumptions" "AssumeNode" read_assume;
    theorems = get_children_in ~context:con i "theorems" "TheoremNode" read_theorem;
  } in
  close_tag i;
  ret


let read_modules i =
  open_tag i "modules";
  let ret = get_children i "ModuleNode" read_module in
  close_tag i;
  ret

let read_header i =
  input i (* first symbol is dtd *)

  (*while true do match (input i) with
  | `Data d -> print_string ("data: " ^ d ^ "\n")
  | `Dtd d -> print_string "dtd\n"
  | `El_start d -> print_string ("start: " ^ (snd(fst d)) ^ "\n")
  | `El_end -> print_string "end\n"
  done*)

let import_xml ic =
  let i = Xmlm.make_input (`Channel ic) in
  let _ = read_header i in
  read_modules i
  (*while not (Xmlm.eoi i) do match (Xmlm.input i) with
  done;
  assert false*)


(* -*- mode: caml; coding: utf-8 -*-
 Generate a dependency graph for CDBS Makefile fragments
 Copyright © 2003 Colin Walters <walters@verbum.org>
 
 This program is free software; you can redistribute it and/or
 modify it under the terms of the GNU General Public License as
 published by the Free Software Foundation; either version 2, or (at
 your option) any later version.

 This program is distributed in the hope that it will be useful, but
 WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 02111-1307 USA.
*)

open Str;;
open Lazy;;

type vertex = string;;

module VSet = Set.Make (
  struct
    type t = vertex
    let compare = compare
  end
 );;

type edge = vertex * vertex;;

module ESet = Set.Make (
  struct
    type t = edge
    let compare = compare
  end
 );;
    
type graph = VSet.t * ESet.t;;

module StrIntMap = Map.Make (
  struct
    type t = string
    let compare = compare
  end);;

(* Print graphs out in dotty format *)
let dotty name (vertices, edges) f =
  let (idmap, _) = VSet.fold (fun x (r, i) ->
    if not (StrIntMap.mem x r) then
      (StrIntMap.add x i r, i+1)
    else
      (r, i)) vertices (StrIntMap.empty, 0) in
  output_string f "digraph ";
  output_string f name;
  output_string f " {\n";
  VSet.iter (fun v ->
    Printf.fprintf f "\"%d\" [label=\"%s\"];\n" (StrIntMap.find v idmap) v) vertices;
  Printf.fprintf f "\n";
  ESet.iter (fun (a,b) ->
    Printf.fprintf f "  \"%d\" -> \"%d\";\n" (StrIntMap.find a idmap)
      (StrIntMap.find b idmap)) edges;
  output_string f "}\n";;

let fnameregexp = (Str.regexp "^\\(.+/\\)*\\(.+\\)$");;
let basename fname =
  if Str.string_match fnameregexp fname 0 then
    Str.matched_group 2 fname
  else
    raise (Failure "Couldn't parse filename");;

let stream_of_lines f =
  Stream.from (fun i -> try Some (input_line f) with End_of_file -> None)
;;

let rec stream_fold_left f init strm =
  try
    stream_fold_left f (f init (Stream.next strm)) strm
  with Stream.Failure -> init
;;
  
(* Generate the graph *)
dotty "deps" 
  (Array.fold_left (fun (verts, edges) x ->
    let base = basename x in
    (VSet.add base verts,
     let includeregexp = Str.regexp "^include.+/\\([-.A-Za-z0-9]+\\)\\$" in
     (stream_fold_left
	(fun edges x ->
	  if Str.string_match includeregexp x 0 then
	    ESet.add (base, (Str.matched_group 1 x)) edges
	  else
	    edges)
	edges
	(stream_of_lines (open_in x)))))
     (VSet.empty, ESet.empty)
     (Array.sub Sys.argv 1 ((Array.length Sys.argv)-1)))
    stdout;;
  

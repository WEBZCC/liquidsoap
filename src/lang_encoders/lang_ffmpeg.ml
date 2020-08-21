(*****************************************************************************

  Liquidsoap, a programmable audio stream generator.
  Copyright 2003-2019 Savonet team

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details, fully stated in the COPYING
  file at the root of the liquidsoap distribution.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

 *****************************************************************************)

open Lang_values
open Lang_values.Ground
open Lang_encoders

let ffmpeg_gen params =
  let defaults =
    {
      Ffmpeg_format.format = None;
      output = `Stream;
      channels = 2;
      samplerate = Frame.audio_rate;
      framerate = Frame.video_rate;
      width = Frame.video_width;
      height = Frame.video_height;
      audio_codec = None;
      video_codec = None;
      audio_opts = Hashtbl.create 0;
      video_opts = Hashtbl.create 0;
      other_opts = Hashtbl.create 0;
    }
  in
  let rec parse_args ~mode f = function
    | [] -> f
    (* Audio options *)
    | ("channels", { term = Ground (Int c); _ }) :: l when mode = `Audio ->
        parse_args ~mode { f with Ffmpeg_format.channels = c } l
    | ("ac", { term = Ground (Int c); _ }) :: l when mode = `Audio ->
        parse_args ~mode { f with Ffmpeg_format.channels = c } l
    | ("samplerate", { term = Ground (Int s); _ }) :: l when mode = `Audio ->
        parse_args ~mode { f with Ffmpeg_format.samplerate = Lazy.from_val s } l
    | ("ar", { term = Ground (Int s); _ }) :: l when mode = `Audio ->
        parse_args ~mode { f with Ffmpeg_format.samplerate = Lazy.from_val s } l
    (* Video options *)
    | ("framerate", { term = Ground (Int r); _ }) :: l when mode = `Video ->
        parse_args ~mode { f with Ffmpeg_format.framerate = Lazy.from_val r } l
    | ("r", { term = Ground (Int r); _ }) :: l when mode = `Video ->
        parse_args ~mode { f with Ffmpeg_format.framerate = Lazy.from_val r } l
    | ("width", { term = Ground (Int w); _ }) :: l when mode = `Video ->
        parse_args ~mode { f with Ffmpeg_format.width = Lazy.from_val w } l
    | ("height", { term = Ground (Int h); _ }) :: l when mode = `Video ->
        parse_args ~mode { f with Ffmpeg_format.height = Lazy.from_val h } l
    (* Shared options *)
    | ("codec", { term = Ground (String s); _ }) :: l
    | ("codec", { term = Var s; _ }) :: l
      when s = "none" ->
        let f =
          match mode with
            | `Audio ->
                { f with Ffmpeg_format.audio_codec = None; channels = 0 }
            | `Video -> { f with Ffmpeg_format.video_codec = None }
        in
        parse_args ~mode f l
    | ("codec", { term = Var s; _ }) :: l when s = "copy" ->
        let f =
          match mode with
            | `Audio -> { f with Ffmpeg_format.audio_codec = Some `Copy }
            | `Video -> { f with Ffmpeg_format.video_codec = Some `Copy }
        in
        parse_args ~mode f l
    | ("codec", { term = Ground (String c); _ }) :: l ->
        let f =
          match mode with
            | `Audio -> { f with Ffmpeg_format.audio_codec = Some (`Encode c) }
            | `Video -> { f with Ffmpeg_format.video_codec = Some (`Encode c) }
        in
        parse_args ~mode f l
    | (k, { term = Ground (String s); _ }) :: l ->
        ( match mode with
          | `Audio -> Hashtbl.add f.Ffmpeg_format.audio_opts k (`String s)
          | `Video -> Hashtbl.add f.Ffmpeg_format.video_opts k (`String s) );
        parse_args ~mode f l
    | (k, { term = Ground (Int i); _ }) :: l ->
        ( match mode with
          | `Audio -> Hashtbl.add f.Ffmpeg_format.audio_opts k (`Int i)
          | `Video -> Hashtbl.add f.Ffmpeg_format.video_opts k (`Int i) );
        parse_args ~mode f l
    | (k, { term = Ground (Float fl); _ }) :: l ->
        ( match mode with
          | `Audio -> Hashtbl.add f.Ffmpeg_format.audio_opts k (`Float fl)
          | `Video -> Hashtbl.add f.Ffmpeg_format.video_opts k (`Float fl) );
        parse_args ~mode f l
    | (_, t) :: _ -> raise (generic_error t)
  in
  List.fold_left
    (fun f -> function `Audio l -> parse_args ~mode:`Audio f l
      | `Video l -> parse_args ~mode:`Video f l
      | `Option ("format", { term = Ground (String s); _ })
      | `Option ("format", { term = Var s; _ })
        when s = "none" ->
          { f with Ffmpeg_format.format = None }
      | `Option ("format", { term = Ground (String fmt); _ }) ->
          { f with Ffmpeg_format.format = Some fmt }
      | `Option (k, { term = Ground (String s); _ }) ->
          Hashtbl.add f.Ffmpeg_format.other_opts k (`String s);
          f
      | `Option (k, { term = Ground (Int i); _ }) ->
          Hashtbl.add f.Ffmpeg_format.other_opts k (`Int i);
          f
      | `Option (k, { term = Ground (Float i); _ }) ->
          Hashtbl.add f.Ffmpeg_format.other_opts k (`Float i);
          f | `Option (_, t) -> raise (generic_error t))
    defaults params

let make params = Encoder.Ffmpeg (ffmpeg_gen params)

with Ada.Text_IO; use Ada.Text_IO;

procedure ANSI.Demo is
   function Pad (S : String; Len : Positive) return String is
     (S & (1 .. Len - S'Length => ' '));

   procedure Title (Text : String) is
   begin
      New_Line;
      Put_Line (Style_Wrap (Text  => "=== " & Text & "===",
                            Style => Bright));
   end Title;
begin
   Put_Line (Reset_All);

   Title ("BASIC COLOR TEST");
   --  Named color tests: best seen in a 96-column term
   for Fg in Colors'Range loop
      for Bg in Colors'Range loop
         if Fg /= Bg then
            Put (Color_Wrap (Text       => Fg'Img & " on " & Bg'Img,
                             Foreground => Foreground (Fg),
                             Background => Background (Bg)));
         end if;
      end loop;
   end loop;
   New_Line;

   Title ("PALETTE COLOR TEST (subsample)");
   declare
      Palette : constant array (Positive range <>) of Palette_RGB := (0, 1, 3, 5);
   begin
      for R of Palette loop
         for G of Palette loop
            for B of Palette loop
               for BR of Palette loop
                  for BG of Palette loop
                     for BB of Palette loop
                        Put (Color_Wrap (Text       => "X",
                                         Foreground => Palette_Fg (R, G, B),
                                         Background => Palette_Bg (BR, BG, BB)));
                     end loop;
                  end loop;
               end loop;
            end loop;
         end loop;
      end loop;
      New_Line;
   end;

   Title ("GREYSCALE COLOR TEST");
   for Fg in Greyscale'Range loop
      for Bg in Greyscale'Range loop
         Put (Color_Wrap (Text       => Fg'Img & " on" & Bg'Img,
                          Foreground => Foreground (Fg),
                          Background => Background (Bg)));
      end loop;
   end loop;

   Put_Line ("TRUE COLOR TEST (subsample)");
   declare
      Palette : constant array (Positive range <>) of True_RGB :=
                  (0, 84, 171, 255);
   begin
      for R of Palette loop
         for G of Palette loop
            for B of Palette loop
               for BR of Palette loop
                  for BG of Palette loop
                     for BB of Palette loop
                        Put (Color_Wrap (Text       => "X",
                                         Foreground => Foreground (R, G, B),
                                         Background => Background (BR, BG, BB)));
                     end loop;
                  end loop;
               end loop;
            end loop;
         end loop;
      end loop;
      New_Line;
   end;

   Title ("NAMED COLOR + STYLE TEST");
   for Color in Colors'Range loop
      for Style in Default .. Dim loop
         Put (Style_Wrap (Text => Color_Wrap
                          (Text       => Pad (Style'Img & " " & Color'Img, 22),
                           Foreground => Foreground (Color)),
                          Style => Style));
      end loop;

      New_Line;
   end loop;

   Title ("STYLE TEST");
   for Style in Styles'Range loop
      Put_Line
        (Style_Wrap ("This text is using the " & Style'Img & " style", Style));
   end loop;
end ANSI.Demo;

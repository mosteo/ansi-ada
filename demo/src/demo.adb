with Ada.Text_IO; use Ada.Text_IO;

with AnsiAda; use AnsiAda;

procedure Demo is
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
      Palette : constant array (Positive range <>) of Palette_RGB :=
        (0, 1, 3, 5);
   begin
      for R of Palette loop
         for G of Palette loop
            for B of Palette loop
               for BR of Palette loop
                  for BG of Palette loop
                     for BB of Palette loop
                        Put (Color_Wrap
                               (Text       => "X",
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
                        Put (Color_Wrap
                               (Text       => "X",
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

   Title ("CURSOR POSITIONING TEST");
   Put ("Storing cursor position...");
   Put_Line (Store);
   for I in 1 .. 4 loop
      Put_Line ((1 .. 20 => 'X'));
   end loop;
   Put (Scroll_Up (4));
   Put_Line ("Scrolled up 4 lines");
   Put (Restore);
   Put ("Restored cursor (should be aligned with 'Storing...' end column)");
   Put (Up (Lines => 8));
   Put (Horizontal (Column => 10));
   delay 1.0;
   Put (Clear_To_End_Of_Line);
   Put (Down);
   delay 1.0;
   Put (Clear_To_Beginning_Of_Line);
   Put (Down (Lines => 7));
   Put (Horizontal); -- Back to first position of last line
   Put (Store);
   Put (Position (4, 1));
   Put_Line ("Absolute positioning test to top-left");
   Put (Restore);
   New_Line;
   Put_Line ("Test ended, check the text at top-left");
end Demo;

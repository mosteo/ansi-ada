package ANSI with Pure is

   Reset_All : constant String;
   -- Resets the device to its original state. This may include (if
   -- applicable): reset graphic rendition, clear tabulation stops, reset
   -- to default font, and more.

   type States is (Off, On);

   function Shorten (Sequence : String) return String is (Sequence);
   --  Some consecutive commands can be combined, resulting in a shorter
   --  string. Currently does nothing, but included for future optimization.

   -----------
   -- COLOR --
   -----------

   type Colors is
     (Black,
      Red,
      Green,
      Yellow,
      Blue,
      Magenta,
      Cyan,
      Grey,

      --  Note: these light variants might not work in older terminals. In
      --  general, the bold + [light] color combination will result in the
      --  same bright color
      Light_Black,
      Light_Red,
      Light_Green,
      Light_Yellow,
      Light_Blue,
      Light_Magenta,
      Light_Cyan,
      Light_Grey);

   function Reset_Attributes return String;
   --  Back to defaults. Applies to colors & effects.

   function Foreground (Color : Colors) return String;
   function Background (Color : Colors) return String;
   --  Basic palette, 8/16 colors

   subtype Palette_RGB is Natural range 0 .. 5;
   --  Used for the 256-palette colors. Actual colors in this index-mode
   --  palette can slightly vary from terminal to terminal.

   function Palette_Fg (R, G, B : Palette_RGB) return String;
   function Palette_Bg (R, G, B : Palette_RGB) return String;

   subtype Grayscale is Natural range 0 .. 23;
   --  Drawn from the same palette mode. 0 is black, 23 is white

   function Foreground (Level : Grayscale) return String;
   function Background (Level : Grayscale) return String;

   subtype True_RGB is Natural range 0 .. 255;
   --  Modern terminals support true 24-bit RGB color

   function Foreground (R, G, B : True_RGB) return String;
   function Background (R, G, B : True_RGB) return String;

   Default_Foreground : constant String;
   Default_Background : constant String;

   function Color_Wrap (Text       : String;
                        Foreground : String := "";
                        Background : String := "")
                        return String;
   --  Wraps text between opening color and closing Defaults

   ------------
   -- STYLES --
   ------------

   type Styles is
     (Bright,      -- aka Bold
      Dim,         -- aka Faint
      Italic,
      Underline,
      Blink,
      Rapid_Blink, -- ansi.sys only
      Invert,      -- swaps fg/bg, aka reverse video
      Conceal,     -- aka hide
      Strike,      -- aka crossed-out
      Fraktur,     -- rarely supported, gothic style
      Double_Underline);

   function Style (Style : Styles; Active : States := On) return String;
   --  Apply/Remove a style

   function Style_Wrap (Text  : String;
                        Style : Styles) return String;
   --  Wraps Text in the given style between On/Off sequences


   ------------
   -- CURSOR --
   ------------

   --  Cursor movement. No effect if at edge of screen.

   function Back    (Cells : Positive := 1) return String;
   function Down    (Lines : Positive := 1) return String;
   function Forward (Cells : Positive := 1) return String;
   function Up      (Lines : Positive := 1) return String;

   function Next     (Lines : Positive := 1) return String;
   function Previous (Lines : Positive := 1) return String;
   --  Move to the beginning of the next/prev lines. Not in ansi.sys

   function Horizontal (Column : Positive := 1) return String;
   --  Move to a certain column. Not in ansy.sys

   function Position (Row, Column : Positive := 1) return String;
   --  1, 1 is top-left

   Store     : constant String;
   --  Store cursor position. Private SCO extension, may work in current vts
   Restore   : constant String;
   --  Restore cursor position to the previously stored one

   Hide      : constant String;
   Show      : constant String;
   --  DECTCEM private extension, may work in current vts

   --------------
   -- CLEARING --
   --------------

   Clear_Screen : constant String;

   Clear_To_Beginning_Of_Screen : constant String;
   Clear_To_End_Of_Screen       : constant String;
   --  From the cursor position

   Clear_Line : constant String;
   --  Does not change cursor position (neither the two following).

   Clear_To_Beginning_Of_Line : constant String;
   Clear_To_End_Of_Line       : constant String;

private

   ESC        : constant Character := ASCII.ESC;
   CSI        : constant String    := ESC & '[';

   Reset_All : constant String := ESC & "c";

   --  Helpers for the many int-to-str conversions

   function Tail (S : String) return String is
     (S (S'First + 1 .. S'Last));

   function Img (I : Natural) return String is
     (Tail (I'Img));

end ANSI;

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with graph; use graph;
with Ada.Containers; use Ada.Containers;

package body io is
   procedure myprint(s: in String) is
   begin
      if s = "" then
         New_Line;
      else
         Put_Line(s);
      end if;
   end myprint;

   procedure myprintnodes(ns: in GraphNode.Set) is
      n: Node;
      c: GraphNode.Cursor := GraphNode.First(ns);
   begin
      Put("Nodes");
      while (GraphNode.Has_Element(Container => ns,
                                   Position  => c)) loop
         n := GraphNode.Element(ns,c);
         Put(n'Image & " ");
         c := GraphNode.Next(ns,c);
      end loop;
      Put_Line(" *");
   end myprintnodes;

   procedure myprintedges(es: in GraphEdge.Set) is
      e: Edge;
      c: GraphEdge.Cursor := GraphEdge.First(es);
   begin
      Put("Edges");
      while (GraphEdge.Has_Element(Container => es,
                                   Position  => c)) loop
         e := GraphEdge.Element(es,c);
         Put("from:" & e.From'Image & " to:" & e.To'Image & " ");
         c := GraphEdge.Next(es,c);
      end loop;
      Put_Line(" *");
   end myprintedges;

   procedure myprintgraph(g : in mygraph) is
   begin
      myprintnodes(g.gnode);
      myprintedges(g.gedge);
   end myprintgraph;

   procedure printnode(n: in Node) is
   begin
      Put(n'Image);
   end printnode;

   procedure printnumber(i:in Integer) is
   begin
      Put(i);
      Put_Line("");
   end printnumber;



end IO;

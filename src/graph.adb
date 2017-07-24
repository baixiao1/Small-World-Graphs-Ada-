with io;
with Ada.Containers.Formal_Ordered_Sets; use Ada.Containers;

package body graph with SPARK_Mode is

   --mynodeset : GraphNode.Set(10);-- := GraphNode.Empty_Set;
   --myedgeset : GraphEdge.Set(10);-- := GraphEdge.Empty_Set;

   procedure addnode(g: in out mygraph; n:in Node) is
   begin
      GraphNode.Include(Container =>g.gnode,
                        New_Item  => n);
   end addnode;

   procedure addedge(g: in out mygraph; from: in Node; to: in Node) is
      e: Edge;

   begin
      e.From:= from;
      e.To:= to;
      GraphEdge.Include(Container =>g.gedge,
                        New_Item  => e);
   end addedge;

   function findnext(n:in Node; g: in mygraph) return GraphNode.Set is
      --an empty node set for the next nodes
      working : GraphNode.Set(10);
      c:GraphEdge.Cursor := GraphEdge.First(Container => g.gedge);
   begin
      while GraphEdge.Has_Element(Container => g.gedge, Position  => c) loop
         if  (GraphEdge.Element(g.gedge,c).From=n) then
            --io.printnode(GraphEdge.Element(g.gedge,c).To);
            GraphNode.Include(Container => working,New_Item  => GraphEdge.Element(g.gedge,c).To);
         end if;
         if (GraphEdge.Element(g.gedge,c).To =n) then
            GraphNode.Include(Container => working,New_Item  => GraphEdge.Element(g.gedge,c).From);
         end if;
         c := GraphEdge.Next(g.gedge,c);
      end loop;
      --io.myprint("the next node is:");
      return working;
   end findnext;

   function distance(source:in Node; target:in Node; g: in mygraph) return Integer is
      Next     : Node;
      --findnext nodeset
      reach: GraphNode.Set(10);
      --cursor in the findnext nodeset
      c1: GraphNode.Cursor;
      distance: Integer:=0;
   begin
      --io.myprint("The distance between node" & source'Image & " and node" & target'Image & " is: ");
      reach := findnext(source,g);
      if (GraphNode.Contains(Container => reach, Item => target)) then
         return 1;
      else
            c1 := GraphNode.First(Container => reach);
      while GraphNode.Has_Element(reach, c1) loop
               distance := distance+1;
            exit when GraphNode.Contains(Container => reach, Item => target);
            Next := GraphNode.Element(reach,c1);
               reach := findnext(n => Next, g => g);
            c1:= GraphNode.Next(reach,c1);
         end loop;
         return distance;
         end if;
      --end if;
   end distance;

   function diameter(g: in mygraph) return Integer is
      source: Node;
      target: Node;
      --cursor in the graph
      c: GraphNode.Cursor := GraphNode.First(Container => g.gnode);
      --cursor in the findnext nodeset
      c1: GraphNode.Cursor;
      diameter: Integer:=0;
      value: Integer;
   begin
      while GraphNode.Has_Element(Container => g.gnode,Position  => c) loop
         source := GraphNode.Element(g.gnode,c);
         c1:=GraphNode.Next(g.gnode,c);
         while GraphNode.Has_Element(Container => g.gnode, Position  => c1) loop
            target := GraphNode.Element(g.gnode,c1);
            value:= distance(source => source,target => target,g => g);
            --io.printnumber(value);
            c1:= GraphNode.Next(g.gnode, c1);
               if (value>=diameter) then
                  diameter:= value;
               end if;
         end loop;
            c:= GraphNode.Next(g.gnode,c);
         end loop;
         return diameter;
   end diameter;

   function small(x: in Integer; g: in mygraph) return Boolean is
      diametervalue: Integer;
      nodenumber : Integer;
   begin
      --io.myprint("X value is: "& x'Image);
      nodenumber := Integer(GraphNode.Length(Container => g.gnode));
      diametervalue := diameter(g);
      if( x*diametervalue >= nodenumber) then
         return True;
      else
         return False;
      end if;
   end small;

end graph;

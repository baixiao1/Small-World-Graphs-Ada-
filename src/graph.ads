with Ada.Containers.Formal_Ordered_Sets;
use Ada.Containers;

package graph is
   pragma SPARK_Mode;

   type Node is range 0..10;
   type Edge is record
      To : Node;
      From : Node;
   end record;

   -- "="  is for elements and "<" is for the key.
   --function "=" (e: in Edge; f:in Edge) return Boolean is
    --((e.To = f.To) and (e.From = f.From));

   function "<" (e: in Edge; f:in Edge) return Boolean is
   ((e.From < f.From) or ((e.From = f.From) and (e.To < f.To)));


   package GraphNode is new Formal_Ordered_Sets(Element_Type => Node,
                                                "<"       => "<",
                                                "="       => "=");

   package GraphEdge is new Formal_Ordered_Sets(Element_Type => Edge,
                                                "<"       => "<",
                                                "="       => "=");
   type mygraph is record
      gnode : GraphNode.Set(20);
      gedge: GraphEdge.Set(20);
   end record;

   procedure addnode(g: in out mygraph; n:in Node)
     with Depends => (g => +(n)),
       Pre => GraphNode.Length(Container => g.gnode)<g.gnode.Capacity,
       Post => not GraphNode.Is_Empty(g.gnode);

   procedure addedge(g: in out mygraph; from: in Node; to: in Node)
     with Depends => (g => +(from, to)),
       Pre => GraphEdge.Length(Container => g.gedge)<g.gedge.Capacity,
       Post=> not GraphEdge.Is_Empty(Container => g.gedge);

   function findnext(n:in Node; g: in mygraph) return GraphNode.Set
     with Depends => (findnext'Result => (g,n)),
     Pre => GraphNode.Contains(g.gnode,n) and GraphEdge.Is_Empty(g.gedge),
     Post => --(for some a of findnext'Result =>
                --GraphEdge.Contains(Container => g.gedge,
                                  -- Item      => ed)and
     GraphNode.Is_Empty(findnext'Result);

   function distance(source:in Node; target:in Node; g: in mygraph) return Integer
     with Pre => GraphNode.Contains(Container => g.gnode, Item  => source) and
     GraphNode.Contains(Container => g.gnode, Item  => target);

   function diameter(g: in mygraph) return Integer
   with Pre => GraphNode.Is_Empty(Container => g.gnode)=False and GraphEdge.Is_Empty(Container => g.gedge)=False;

   function small(x: in Integer; g: in mygraph) return Boolean
     with Pre => GraphNode.Is_Empty(Container => g.gnode)=False and GraphEdge.Is_Empty(Container => g.gedge)=False;

end graph;




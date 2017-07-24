with graph; use graph;

package io with SPARK_Mode is
   procedure myprint(s: in String);
   procedure myprintnodes(ns: in GraphNode.Set);
   procedure myprintedges(es: in GraphEdge.Set);
   procedure myprintgraph(g : in mygraph);
   procedure printnode(n: in Node);
   procedure printnumber(i:in Integer);
end io;

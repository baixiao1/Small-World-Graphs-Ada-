with Ada.Text_IO; use Ada.Text_IO;
with IO; use IO;
with graph; use graph;

procedure main is

   testgraph : mygraph;

begin
   Put_Line("Start");
   --adding nodes into nodeset.
   io.myprint("adding nodes and edges:");
   addnode(g => testgraph,n => Node(0));
   addnode(g => testgraph,n => Node(1));
   addnode(g => testgraph,n => Node(2));
   addnode(g => testgraph,n => Node(3));
   addnode(g => testgraph,n => Node(4));
   addnode(g => testgraph,n => Node(5));

   --adding edges into edgeset and connect the edges to its source and target nodes.
   addedge(g => testgraph,from => Node(0), to=> Node(1));
   addedge(g => testgraph,from => Node(1), to=> Node(2));
   addedge(g => testgraph,from => Node(2), to=> Node(3));
   addedge(g => testgraph,from => Node(3), to=> Node(4));
   addedge(g => testgraph,from => Node(4), to=> Node(5));
   addedge(g => testgraph,from => Node(1), to=> Node(3));
   addedge(g => testgraph,from => Node(3), to=> Node(5));
   addedge(g => testgraph,from => Node(3), to=> Node(5));
   addedge(g => testgraph,from => Node(5), to=> Node(1));
   addedge(g => testgraph,from => Node(0), to=> Node(2));
   addedge(g => testgraph,from => Node(2), to=> Node(4));
   addedge(g => testgraph,from => Node(4), to=> Node(0));
   addedge(g => testgraph,from => Node(5), to=> Node(0));

   --print the graph
   io.myprintgraph(g => testgraph);

   --find a next node of a node.
   io.myprint("The adjacent nodes of node 0 is: ");
   io.myprintnodes(findnext(n => Node(0),g => testgraph));
   io.myprint("The adjacent nodes of node 1 is: ");
   io.myprintnodes(findnext(n => Node(1),g => testgraph));
   io.myprint("The adjacent nodes of node 2 is: ");
   io.myprintnodes(findnext(n => Node(2),g => testgraph));
   io.myprint("The adjacent nodes of node 3 is: ");
   io.myprintnodes(findnext(n => Node(3),g => testgraph));
   io.myprint("The adjacent nodes of node 4 is: ");
   io.myprintnodes(findnext(n => Node(4),g => testgraph));
   io.myprint("The adjacent nodes of node 5 is: ");
   io.myprintnodes(findnext(n => Node(5),g => testgraph));


   --distance bwtween two nodes (the shortest path)
   io.myprint("The distance between the nodes are:");
   io.printnumber(distance(source => Node(0),target => Node(4),g => testgraph));

   --diameter of a graph
   io.myprint("The diameter of the graph is: ");
   io.printnumber(diameter(testgraph));

   --whether the graph is small
   io.myprint("The graph is small :");
   io.myprint(small(x => 2,g => testgraph)'Image);
end main;

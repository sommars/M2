----------------------------
-- The granddaddy node -----
----------------------------

document {
     Key => "Mathematical Overview",
     "In this section we give a comprehensive overview of the main 
     mathematical types of Macaulay 2, their construction and most common
     operations. WARNING: this overview is currently under construction.",
     Subnodes => {
	  TO "rings",
	  TO "ideals",
	  TO "matrices",
	  TO "substitution and maps between rings",
	  "Modules",
	  TO "modules: part I",
	  TO "modules: part II",
     	  "Other topics",
	  TO "Groebner bases and related computations",
	  TO "chain complexes",
	  TO "varieties",
	  "An unrelated topic",
	  TO "using external libraries",
	  "Specialized routines",
	  TO "commutative algebra",
	  TO "algebraic geometry",
	  }
     }

----------------------------
-- Top level nodes ---------
----------------------------

document {
     Key => "rings",
     HEADER2 "An overview",
     "Macaulay 2 differs from computer algebra systems such as maple and
     mathematica, in that rings are first class objects.  This means that
     before making polynomials or matrices, you must create a ring where
     you give the variables that you want, and the kinds of coefficients
     you want (e.g. rational numbers, or integers modulo a prime number).",
     Subnodes => {
	  "Rings",
	  TO "basic rings",
	  TO "finite fields",
	  TO "polynomial rings",
	  TO "monomial orderings",
	  TO "quasi- and multi-graded polynomial rings",
	  TO "quotient rings",
	  TO "manipulating polynomials",
	  TO "factoring polynomials",
	  "Fields",
	  TO "finite fields, part II",
	  TO "fraction fields",
	  TO "finite field extensions",
	  "Other algebras",
	  TO "exterior algebras",
	  TO "symmetric algebras",
	  TO "tensor products of rings",
	  TO "Weyl algebras",
	  TO "Schur rings", 
	  TO "associative algebras",
       	  },
     PARA,
     "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use rings, see ", TO "Ring", "."
     }

document {
     Key => "ideals",
     HEADER2 "An overview",     
     "In Macaulay 2, once a ring (see ",TO "rings", 
     ") is defined, ideals are constructed in the usual way
     by giving a set of generators.",
     Subnodes => {
	  TO "creating an ideal",
	  "conversions",
	  TO "ideals to and from matrices",
	  TO "ideals to and from modules",
	  "basic operations on ideals",
	  TO "sums, products, and powers of ideals",
	  TO "equality and containment",
	  TO "extracting generators of an ideal",
	  TO "dimension, codimension, and degree",
	  "components of ideals",
	  TO "intersection of ideals",
	  TO "ideal quotients and saturation",
	  TO "radical of an ideal",
	  TO "minimal primes of an ideal",
	  TO "associated primes of an ideal",
	  TO "primary decomposition",
	  -- TO "Groebner bases and related computations", -- already referred to in the Mathematical Overview
	  },
     PARA,
     "For those operations where we consider an ideal as a module, such
     as computing Hilbert functions and polynomials, syzygies, free resolutions, see ",
     TO "modules: part I", ".",
     PARA,
      "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use ideals, see ", TO "Ideal", "."
     }

///

This node is old -- is there anything we want to save from it?

document {
     Key => "ideals",
     "An ideal ", TT "I", " is represented by its generators,
     which are stored inside it in a one-rowed matrix.",
     PARA,
     "The ideal generated by a list of ring elements can be constructed with the function
     ", TO "ideal", ".",
     EXAMPLE {
	  "R = ZZ/101[a..d];",
      	  "I = ideal (a^2*b-c^2, a*b^2-d^3, c^5-d)",
	  },
     "If you have a matrix, then ", TT "ideal", " will produce the ideal generated
     by the entries of the matrix.",
     EXAMPLE {
	  "f = matrix {{a^2,b^2},{c^2,d^2}}",
      	  "J = ideal f",
	  },
     "An interesting class of ideals can be obtained as the defining ideals in 
     projective space of monomial curves.  The twisted cubic is the closure of the
     set of points ", TT "(1,t^1,t^2,t^3)", " in projective space.  We use a list of
     the exponents and ", TO "monomialCurveIdeal", " to get the ideal.",
     EXAMPLE "monomialCurveIdeal(R,{1,2,3})",
     "The command ", TO "substitute", " can be used to transfer an ideal to another
     ring.  You may want to do this because another ring has a monomial ordering
     more suitable for the computations you are about to do, or it may have
     additional variables in it, one of which you wish to use for homogenization.
     Here is an example of the latter.  We make another ring with a new variable ", TT "t", "
     in it, transfer the ideal, and then homogenize the ideal.",
     EXAMPLE {
	  "S = ZZ/101[a..d,t];",
      	  "substitute(I,S)",
      	  "homogenize(oo,t)",
	  },
     NOINDENT, "In this case, the substitution was done according to the names of
     the variables in the two rings.  There are more explicit ways to specify the
     substitution to be performed.  Here is one where we list the new values for
     all the variables.",
     EXAMPLE {
	  "T = ZZ/101[x,y,z,t];",
	  "use ring I",
      	  "substitute(I,{a=>x^10,b=>y^10,c=>z^10,d=>t^10})",
	  },
     "Now notice that the variable ", TT "a", " appears to be an element of ", TT "S", ".
     The creation of the ring ", TT "S", " supplanted the earlier value.",
     EXAMPLE "a",
     "We restore the variables of ", TT "R", " to visibility.",
     EXAMPLE "use R",
     "To recover the generators of an ideal as a matrix, use ", TO "generators", ".",
     EXAMPLE "generators J",
     "Use the operator ", TT "%", " to reduce a ring element with respect to a
     Groebner basis of the ideal.",
     EXAMPLE "(1+a+a^3+a^4) % J",
     "Membership in the ideal may be tested by comparing the answer to 0 with ", TT "==", ".",
     EXAMPLE {
	  "(1+a+a^3+a^4) % J == 0",
      	  "a^4 % J == 0",
	  },
     PARA,
     "The usual algebraic operations on ideals are available.",
     EXAMPLE {
	  "I+J",
      	  "intersect(I,J)",
      	  "I*J",
      	  "J:I",
	  "saturate(J,I)",
      	  "radical J",
	  },
     "See also: ", TO "intersect", ", ", TO (symbol :, Ideal, Ideal), ",
     ", TO "saturate", ", and ", TO "radical", ".",
     PARA,
     "We may ask whether one ideal is contained in another.",
     EXAMPLE {
	  "isSubset(I,J)",
      	  "isSubset(I,I+J)",
      	  "isSubset(I+J,J)",
	  },
     "Once you have an ideal, then you may construct the quotient ring or the quotient
     module (there is a difference).  Here is the quotient ring.",
     EXAMPLE "R/I",
     "Here is the quotient module.",
     EXAMPLE "M = R^1/I",
     "And if you want the module underlying ", TT "I", " itself, you can get it with
     ", TO "module", ".",
     EXAMPLE "module I",
     "In general, when an ideal is used as an argument to a function that usually
     would be given a module, we try to make an informed choice about whether the user
     intends the ideal to be used as a module directly, or whether the quotient module
     is more suitable.  In homological functions such as ", TO "Ext", " and ", TO "Tor", "
     the underlying module is used.  Here are some examples where the quotient 
     module is used.",
     PARA,
     "A free resolution of ", TT "R^1/I", " can be obtained with ", TO "resolution", ".",
     EXAMPLE "resolution I",
     "The Krull dimension or codimension of the support of the quotient module can
     be obtained.",
     EXAMPLE {
	  "dim I",
      	  "dim J",
      	  "codim I",
	  },
     NOINDENT, "(Beware that for a homogeneous ideal the
     dimension of its projective variety is one less than the number provided by
     ", TO "dim", ".)",
     PARA,
     "If the dimension of the quotient module as a vector space is needed,
     use ", TO "basis", " to get a matrix whose columns form a basis, and compute
     the dimension from it.",
     EXAMPLE {
	  "basis (R^1/J)",
      	  "rank source oo",
	  },
     NOINDENT, "(Here ", TO "oo", " refers to the result on the previous line.",
     PARA,
     "For more information see ", TO "Ideal", "."
     }

///


document {
     Key => "matrices",
     HEADER2 "An overview",     
     "In Macaulay 2, each matrix is defined over a ring, (see ", TO "rings", "). 
     Matrices are perhaps the most common data type in Macaulay 2.",
     Subnodes => {
	  "making matrices", 
	  TO "input a matrix",
	  TO "random and generic matrices",
	  TO "concatenating matrices",
	  "operations involving matrices",
	  TO "simple information about a matrix",
	  TO "basic arithmetic of matrices",
	  TO "kernel, cokernel and image of a matrix",
	  TO "differentiation",
	  "determinants and related computations",
	  TO "rank of a matrix",
	  TO "determinants and minors",
	  TO "Pfaffians",
	  TO "exterior power of a matrix",
	  "display of matrices and saving matrices to a file",
	  TO "format and display of matrices in Macaulay 2",
	  TO "importing and exporting matrices",
	  },
     PARA,
     "For an overview of matrices as homomorphisms between modules, 
     see ", TO "modules: part I", ".  
     For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use matrices, see ", TO "Matrix", "."
     }

document {
     Key => "substitution and maps between rings",
     HEADER2 "An overview",
     Subnodes => {
	  TO "substitute values for variables",
	  TO "working with multiple rings",
	  "ring maps",
	  TO "basic construction, source and target of a ring map",
	  TO "evaluation and composition of ring maps",
	  TO "kernel and image of a ring map",
	  },
     PARA,
      "For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use ring maps, see ", TO "RingMap", "."
     }
     
document {
     Key => "modules: part I",
     Headline => "getting started",
     Subnodes => {
	  "construction of modules",
	  TO "free modules",
	  TO "matrices to and from modules",
	  -- TO "ideals to and from modules", -- already referred to in the section on ideals
	  TO "Hilbert functions and free resolutions",
	  TO "operations on modules",
	  TO "homomorphisms (maps) between modules",
--		    TO "constructing maps between modules",
--		    TO "information about a map of modules",
--		    TO "kernel, cokernel and image of a map of modules",
--	  "graded modules",
--		    TO "degrees of elements and free modules",
--		    TO "degree and multiplicity of a module",
--		    TO "Hilbert functions and polynomials",
--		    TO "homogenization",
--		    TO "truncation and homogeneous components of a graded module",
	  TO "subquotient modules",
	  "Macaulay 2 has handed you a subquotient module.  What now?",
--		    TO "what is a subquotient module?",
--		    TO "extracting parts of a subquotient module",
--		    TO "quotients of modules",
	  },
     PARA,
     "See ", TO "modules: part II", " for more operations on modules."
     }

document {
     Key => "modules: part II",
     Headline => "homological and multilinear algebra",
     Subnodes => {
	  "multilinear algebra",
	  TO "exterior power of a module",
	  TO "Fitting ideals",
	  TO "adjoints of maps",
	  "homological algebra",
	  TO "Hom module",
	  TO "Tor and Ext",
	  },
     PARA,
     "For more operations in homological algebra, see ", TO "chain complexes", ".  For additional common operations and a comprehensive list of all routines
     in Macaulay 2 which return or use modules, see ", TO "Module", "."
     }

document {
     Key => "Groebner bases and related computations",
     HEADER2 "An overview",
     Subnodes => {
	  TO "what is a Groebner basis?",
	  TO "finding a Groebner basis",
	  TO "rings that are available for Groebner basis computations",
	  "A few applications of Groebner bases",
	  TO "elimination of variables",
	  TO "Hilbert functions",
	  TO "syzygies",
	  TO "saturation",
	  TO "fibers of maps",
	  TO "solving systems of polynomial equations",
	  TO "fine control of a Groebner basis computation"
	  }
     }

document {
     Key => "chain complexes",
     HEADER2 "An overview",
     Subnodes => {
	  TO "free resolutions of modules",
	  TO "extracting information from chain complexes",
	  TO "making chain complexes by hand",
	  TO "manipulating chain complexes",
	  TO "maps between chain complexes"
	  },
     PARA,
      "For additional common operations and a comprehensive list of all routines
      in Macaulay 2 which return or use chain complexes or maps between chain complexes, see ", 
      TO "ChainComplex", " and ", TO "ChainComplexMap", ".",
     }

document {
     Key => "varieties",
     HEADER2 "An overview",
     Subnodes => {
	  TO "algebraic varieties",
	  TO "coherent sheaves",
	  TO "Variety"
	  },
     }

document {
     Key => "using external libraries",
     "This node will be rewritten using packages.",
     Subnodes => {
     	  TO "loading a library",
     	  TO "how to get documentation on a library",
     	  "available libraries",
	  TO "blow ups",
	  TO "convex hulls and polar cones",
	  TO "D-modules",
	  TO "elimination theory",
	  TO "graphing curves and surfaces via 'surf'",
	  TO "invariants of finite groups",
	  TO "Lenstra-Lenstra-Lovasz (LLL) lattice basis reduction",
	  TO "SAGBI bases",
	  }
     }

----------------------------
-- Lead nodes --------------
----------------------------

document {
     Key => "rings that are available for Groebner basis computations",
     "In Macaulay 2, Groebner bases can be computed for ideals and submodules over many
     different rings.",
     Subnodes => {
	  TO "over fields",
          TO "over the ring of integers",
          TO "over polynomial rings over a field",
	  TO "over polynomial rings over the integers",
	  TO "over Weyl algebras",
	  TO "over local rings"
     	  }
    }

-------------------
-- Ring nodes -----
-------------------

-------------------
-- ideal nodes ----
-------------------


-------------------
-- Matrix nodes ---
-------------------


-------------------
-- ring map nodes -
-------------------

-------------------
-- module nodes ---
-------------------


-------------------
-- GB nodes -------
-------------------


-------------------
-- library nodes --
-------------------

document {
     Key => "loading a library",
     }

document {
     Key => "how to get documentation on a library",
     }

document {
     Key => "blow ups",
     }

document {
     Key => "convex hulls and polar cones",
     Headline => "polarCone.m2"
     }

document {
     Key => "D-modules",
     Headline => "D-modules.m2",
     }

document {
     Key => "elimination theory",
     Headline => "eliminate.m2",
     }

document {
     Key => "graphing curves and surfaces via 'surf'",
     }

document {
     Key => "invariants of finite groups",
     Headline => "invariants.m2",
     }

document {
     Key => "Lenstra-Lenstra-Lovasz (LLL) lattice basis reduction",
     Headline => "LLL.m2",
     }

document {
     Key => "SAGBI bases",
     Headline => "sagbi.m2",
     }

-------------------
-- specialized   --
-------------------

document {
     Key => "commutative algebra",
     SUBSECTION "integralClosure",
     SUBSECTION "primaryDecomposition",
     SUBSECTION "symmetricAlgebra"
     }

document {
     Key => "algebraic geometry",
     SUBSECTION "cotangentSheaf",
     }

-- Local Variables:
-- compile-command: "make -C $M2BUILDDIR/Macaulay2/m2 "
-- End:

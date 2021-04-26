## Principles Behind Java



* Java is close to "**PSTFbOB**"
   -  **FbOB** (objects) plus **STFb** (subtyping) plus **PEFb** (the P for polymorphism/generics, and the E for type inference).
* There are a few cases arising from the interaction of these pieces which are tricky and we will cover.

### Encoding Typed Objects

We encoded **FbOB** objects with records, but the encoding we gave does not lift perfectly to typed objects.

*   `this` imposes some additional issues in object typing. Notice that

    <pre>PointType = { x : Int; y : Int; magnitude: PointType -> Int -> Int; ...}</pre>

    should be a proper type for our point object encoding, but notice how `PointType` is contravariant, it is in the domain of the magnitude method. Consider

    <pre>ColorPointType = { x : Int; y : Int; c : Color; magnitude: ColorPointType -> Int -> Int; ...}</pre>

    -- for `ColorPointType <: PointType` to hold, `magnitude` subtyping would require `ColorPointType -> Int -> Int <: PointType -> Int -> Int` which would need `PointType <: ColorPointType` by function subtyping, which is **false!**
*   Its false for a good reason:

    <pre>Let p1 : Point = aPoint In let p2 : Point = aColorPoint In p2.magnitude p1 {}</pre>

    would result in an attempt to look up p1's color, a runtime error. Note we are abusing our encoding here by passing <tt>p1</tt> to <tt>p2</tt>.
*   Solution: pre-package the `self` into objects when created so self need not be passed in at each message send and it won't show up in object types.

    <pre>Let point = .. point object as in book... In
      Let prePackagedPoint = {
        x = point.x ;
        y = point.y ;
        magnitude = point.magnitude point; 
        isZero = point.isZero point; 
      };
    In prePackagedPoint.magnitude () (* no self passing needed on object use (and its gone from the type) *) </pre>

    -- with this encoding the subtyping above holds since the object type arguments have been removed
*   One more thing needed in the above that we skipped: notice how the <tt>PointType</tt> is self-referential, it refers to itself in its definition. Such types are called _recursive types_. Fortunately, we can make type systems with recursive types (but will skip that here).

### Encoding Other Java O-O Features

*   Information hiding is possible in Java via `private/protected` fields; information hiding in **STFbOB** is accomplished by subsumption -- use subsumption after every `new` of an object to hide the private/protected bits. Informal idea:

    <pre>      |-  ob : PointWithEverythingPublic     PointWithEverythingPublic <: PointHidingFields
          --------------------------------------------------------------------------------------
          |- ob : PointHidingFields </pre>

*   Static fields are easily encoded, think of the class as itself being an object.
*   Java classes can have multiple constructors, this is possible in an encoding by making other constructors besides `new` in the class-object of the previous point.

An example of encoding static fields and multiple constructors in **FbSR** taken from the book:

<pre>(* Make a "class object" - an object with some factory methods for building points *)
Let pointClass = {
  (* constructor method on the "class object": *)
  newWithXY = Function thisClass -> 
    Function newx -> 
    Function newy -> {
    x = Ref newx;
    y = Ref newy;
    magnitude = Function this -> Function _ ->
      sqrt ((!(this.x)) + (!(this.y)))
  };
  new = Function thisClass -> Function _ -> 
    (thisClass.newWithXY) thisClass (thisClass.xdefault) 
                            (thisClass.ydefault);
  xdefault = 0;
  ydefault = 0
} In
  Let point = (pointClass.new) pointClass {} In
    (point.magnitude) point {}    </pre>

### Java's Nominal Subtyping

*   Subtype relationships in Java are _nominal_: they must be declared via <tt>extends</tt>/<tt>implements</tt> aclass/aninterface, except for primitive type subtyping;  
    -- even if a class clearly implements all the methods of an interface, if the interface is not specified in the header there is no subtyping possible.
*   Running example: `Interface Iterable<T>` - if you have an `Iterable<Integer> thing` you can `thing.foreach(...)` it **but only if** <tt>thing</tt> is a class explicitly <tt>implements</tt>-ing that interface.
*   In **STFb** subtyping only depended on the structure of the underlying records. **STFb** subtyping is thus _purely structural_ and Java's is not.
    *   Any nominal subtyping system only adds _additional_ constraints over pure structural subtyping; you need structural subtyping to hold or the system will be unsound.
    *   Structural subtyping is more flexible: "use your own implicit interface without needing to declare it".
    *   Nominal subtyping lets you think about subtyping in terms of names of things, not the details of whats inside  
        -- a helpful abstraction of detail in many cases.
    *   All major languages used nominal subtyping until TypeScript decided to take the structural approach.

### [Generics](http://docs.oracle.com/javase/specs/jls/se14/html/jls-4.html#jls-4.4)

Generics are Java's version of parametric types. These notes assume familiarity with them; here is a [tutorial](http://download.oracle.com/javase/tutorial/extra/generics/index.html).

The **PEFb** language includes both type inference and polymorphism so it is the only language we studied with polymorphism. The main idea of how generic types are handled are expressed there, but in an inference context.

Here are some comparisons with the **PEFb** or OCaml-style parametric types that we studied:

*   ``'a list / int list`` from OCaml is ``List <T> / List <Integer>`` in Java
*   OCaml/**PEFb** often _infers_ generic types `'a` automatically; in Java, you need to declare them as `<T>`. But you can often just write `<>` to instantiate a generic type: the type will be inferred.
*   Java generics have _bounded subtyping_, the combination of polymorphism and subtyping (note, this doesn't exist in OCaml and we didn't cover the principles in class).

#### Bounded subtyping

Observe that with generics you cannot have `List<String> <: List<Object>` kinds of things even though `String <:Object` holds - !

*   The root of this in subtpying theory is that `String/Object` may occur both positively (rhs of function arrow) and negatively (lhs of arrow) in `List`'s signature, so it needs to be invariant.
*   Consider a list-like object encoded as a **STFbR** record:

    <pre>{ add: String -> {}; head : {} -> String } <: { add: Object -> {}; head : {} -> Object }      </pre>

    -- this relation _fails_ in **STFbR** because it requires `Object <: String` due to the `add` parameter argument contravariance.
*   In **STFb** we could in fact have such subtypings holding for the case they were positive only -- imagine some list which you could only get the head of, nothing else:

    <pre>{ head : {} -> String } <: { head : {} -> Object }      </pre>

    would be a legal subtyping in **STFb** assuming `String <: Object`.
*   Java is conservatively assuming that `List` will have `T` both as argument and return type of methods and so always forces invariance here. But, for the case the list class was immutable and T was never an argument the above subtyping would hold and our **STFb** approach would support that.

To get around this weakness, Java includes _bounded subtyping_

*   You can write things like `<T extends Comparable<T>> void test(List<T> t)`
*   the "`<T extends Comparable<T>>`" means `T` can be any type which extends `Comparable<T>>` -- in other words, `T <: Comparable<T>` in our subtyping terminology.  
    -- And, in English this means `T` can be compared with itself.
*   This adds more flexibility, `T` need not be any type, but from a restricted range of types which gives added flexibility later.
*   In terms of type theory this is the theory of _bounded polymorphism_: there are subtype bounds on the parametric types. Its a natural combination of polymorphism and subtyping.

### [Method Overloading](http://docs.oracle.com/javase/specs/jls/se14/html/jls-8.html#jls-8.4.9)

*   Java method overloading can be viewed as concatenating all of the argument types onto the method name.
*   This makes "a new method for each different type"
*   So it is just simple syntactic sugar.

### Immutable Data

One of the key lessons of OCaml is the importance of immutable data.

*   Java allows fields to not mutate if qualified with `final`; so, it is something like `let` in OCaml.
*   As with OCaml, immutability is only shallow - the field could contain _components_ that mutate.
*   Unlike OCaml the default case is swapped and this has a huge impact on expected programmer behavior.
*   One advantage of Java is no need for "`!`" when accessing mutable data.

### Lambdas

Java 8+ has Lambdas, use them! We are probably going to skip this topic, the only real novelty is the (gross) syntax.

*   Fully higher order functions in Java, 50 years after they appeared in PLs.
*   [Here is a tutorial](http://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html)
*   Javas Lambdas are admittedly a bit clunky to use compared to "real" higher-order functions due to how they were patched in.
*   Java 8 higher-order functions can "pun" as any interface with only one method in it.  
    -- the function is taken to be the body of that single method, no need to write the method name when declaring the function then.
*   There is also some (limited) type inference for Lambda parameters.
*   Lets put some spice in our latte! Here at long last is Currying in Java: [Gist currying example](https://gist.github.com/timyates/7674005). For that example here is the [Function](https://docs.oracle.com/en/java/javase/14/docs/api/java.base/java/util/function/Function.html) and [BiFunction](https://docs.oracle.com/en/java/javase/14/docs/api/java.base/java/util/function/BiFunction.html) type.

Terminology aside: _closure_

*   A _closure_ is just a higher-order function return value
*   The term "closure" comes from how they are implemented -- all variables not local to the function must be remembered
*   (We didn't have this problem in our interpreters because we _substituted_ when we did function application, but that is not very efficient)
*   OCaml example:

    <pre># let f = (fun x -> fun y -> x + y) 4;;
    val f : int -> int = <fun> (* f is at runtime the closure <fun y code, {x |-> 4}> *)
    # f 3;;
    - : int = 7   </pre>

    Note how `x` is a function parameter and is remembered in spite of function returning, means `x` needs to be _copied_ into the closure.

### Type Inference

*   For years Java followed the "declaring types is good for code reading" philosophy - types were all declared.
*   But, "type inference is coming to a language near you" caught on a few years ago, a trend initiated by Scala.
*   So, Java 10+ has _local type inference_, along with Scala, Kotlin, C++, etc:

    <pre>var first = "Hello"</pre>

    is legal and will infer <tt>first</tt> to be of type <tt>string</tt>.

### Other points of comparison between Java and OCaml / Fb

*   Java has no variant types?!? -- "Use subtyping and dynamic dispatch instead" (i.e. use the records side of the records/variants duality)
*   Java Exceptions -- very similar to OCaml or **TFbX** but OCaml has no `throws` declarations in the types: less apparent what is being thrown in OCaml, arguably inferior.

### The Java spin-offs: Scala, Kotlin, and Clojure

*   All three compile to Java bytecode so can share libraries with Java
*   Means much less work to get a language up and running
*   Each are popular in certain spaces

#### Scala

*   Scala "brings OCaml to Java" - functional programming style into O-O; it also led this trend which Java/C++ followed.
*   It was a big deal before Java 8 but Java has been back-patching to be more Scala-like
*   Local type inference is the latest such back-patch in Java 14
*   Scala shares the immutabilty by default aspect of OCaml  
    -- you can declare things final in Java for immutability, but its not the default.
*   Scala has an actor-based concurrency model built-in.
*   Scala also has pattern matching built in -- [tutorial link](https://www.tutorialspoint.com/scala/scala_pattern_matching.htm).

#### Kotlin

*   Kotlin is in a nutshell a cleaned-up version of Java; Java has gotten more and more crufty as it has evolved
*   It includes higher-order functions, local type inference PLUS operator overloading a la C++, etc.
*   One interesting novel tidbit, delegation (message forwarding) is directly supported in the syntax: [Kotlin docs of delegation](https://kotlinlang.org/docs/reference/delegation.html).

#### Clojure

*   Lisp is the "first implemented functional programming language", circa 1964.
*   Lisp is dynamically typed, it was also the first dynamically-typed language preceding Python, Ruby, Perl, JavaScript, Scheme, etc.
*   Clojure is "modern Lisp running on the JVM"
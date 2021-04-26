## A Taste of Rust

In a nutshell: "OCaml meets C++ for safe but efficient systems programming"  
OCaml goodies:

*   immutable by default with <tt>let</tt>-definition
*   parametric polymorphism (with syntax like Java's, <tt><T></tt>)
*   first-class functions
*   tuples such as <tt>(1,2)</tt>
*   algebraic data types - the <tt>type</tt> declarations in OCaml
*   pattern matching
*   Hindley-Milner type inference (similar to OCaml and EFb)

O-O goodies:

*   objects
*   method call syntax

Systems programming goodies:

*   true pointer references you can get your hands on
*   **no garbage collector!!** so no pausing problems for systems code, and also no manual freeing like in C++
*   support for (efficient) stack allocation of data

Key innovation: improved memory safety in spite of low-level memory model

*   Invariant: memory is not touched after it’s deallocated
*   Writes/reads are deterministic so concurrent data races are prevented

How: _ownership_ of data, a concept we also covered in the concurrency lecture.

#### Ownership

*   A function by default _owns_ values it defines or receives as parameters
*   The owner of a value knows nobody else can be accessing it (no aliases to it or threads accessing it)
*   Calling a function, by default means the caller must give up access to the value (but can give back by returning it)
*   Similarly, assignment often means giving up access to the value

We will look at some examples in the [documentation on ownership](https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html) for details.

#### Borrowing

OK at this point Rust sounds nearly-useless given this rigidity. But there are weakenings possible.

*   A function can accept arguments by-value or by-reference
*   by-value transfers ownership as we saw up to now
*   by-reference _borrows_ ownership - !

We will look at the examples in the [documentation on borrowing](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html) for details.

#### Lifetimes

*   Every value has a (statically known) _lifetime_, written <tt>'a</tt>
*   Usually, this can be inferred, but can declare if inference is not working
*   They are used to track borrowing and make sure references will not be dangling

Again we will consult the [documentation on lifetimes](https://doc.rust-lang.org/book/ch10-03-lifetime-syntax.html) for details.

#### Efficiency

Why all the pain compared to Java, python, etc? Efficiency while preserving safety!

*   Static dispatch by default - like C++ non-virtual, very efficient
*   No manual <tt>free</tt> required at runtime, and no garbage collection overhead
*   Corollary: if you don't care about these issues don't use Rust, the pain is not worth it.
*   Note that some Rust-ites would disagree with previous and point out how ownership preserves more referential transparency, etc. Yes, there are other benefits but the price is high.

#### Freeing (finalizing) data

*   No manual free - could free data still being used and thats bad!
*   Key concept: Memory freed and destructor called when value leaves owner’s scope (in reverse order of initialization, due to dependencies)
*   Particularly useful for resources like file handles, gets closed when scope over

[Rust playground](https://play.rust-lang.org)

<pre>struct HasDrop {z:i32}
impl Drop for HasDrop {
fn drop(&mut self) {  // drop method in Drop trait called when scope exits
        println!("Dropping {}!", self.z);
    }
}
fn takes(x:HasDrop) {}        // value parameter, takes x
fn borrows(x:&HasDrop) {} // reference parameter, only borrows x
fn main() {
    let x1 = HasDrop{z:1};
    let x2 = HasDrop{z:2};
    {
      let x3 = HasDrop{z:3};
      let x4 = HasDrop{z:4};
    }
    let x5 = HasDrop{z:5};
    takes(x5);
    let x6 = HasDrop{z:6};
    borrows(&x6);
    let x7 = HasDrop{z:7};
}
</pre>

<pre>Dropping 4!
Dropping 3!
Dropping 5!
Dropping 7!
Dropping 6!
Dropping 2!
Dropping 1!
</pre>

#### Relaxing Restrictions

Rust up to now is reasonable for many programming tasks, but is still extremely annoying in a few cases; there are advanced tools to help.

*   <tt>Rc<T></tt> types: allows multiple “owners”; reference couting is used to prevent too-early free
*   <tt>Arc<T></tt>: atomic version of the above
*   <tt>~*const T~</tt> and <tt>~*mut T~</tt>: raw pointers, aliasing is allowed, but dereferencing is unsafe.
*   <tt>Cell<T></tt>: allow mutation from multiple sources
*   Real corner cases may need unsafe escapes: Dereferencing raw pointers, violating “read XOR write” reference scope, unsafe typecasts
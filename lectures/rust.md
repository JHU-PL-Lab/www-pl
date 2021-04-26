## A Taste of Rust

In a nutshell: "OCaml meets C++ for safe but efficient systems programming"  
OCaml features borrowed:

*   immutable by default with `let`-definition
*   parametric polymorphism (with syntax like Java's, `<T>`)
*   first-class functions
*   tuples such as `(1,2)`
*   algebraic data types - the `type` declarations in OCaml
*   pattern matching
*   Hindley-Milner type inference (similar to OCaml and EFb)

O-O features:

*   objects (via traits, somewhat non-standard)
*   standard method call syntax

Systems programming features:

*   true pointer references
*   **no garbage collector** -- so no pausing problems for systems code, and also no manual freeing required
*   support for (efficient) stack allocation of data folling C/C++.

#### Ownership

Key innovation: **ownership** for improved heap memory safety without garbage collector

*   Invariant: runtime variables "own" their heap data
  - only one variable can alias a particular heap item (well, with a few exceptions)
*   Concurrent data races are thus prevented since threads don't share variables
*   Calling a function by default means the caller must give up access to the value (but can give back by returning it)
*   Similarly, assignment by default means giving up access to the heap value
*   No manual freeing - could free data still being used and thats bad!
*   Instead, use the above invariant: Memory freed when owning variables' scope ends

See the [documentation on ownership](https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html) for details.

#### Borrowing

Up to now Rust is far too rigid to be useful. But there are weakenings available.

*   A function can accept arguments by-value or by-reference
*   by-value transfers ownership as we saw up to now
*   by-reference _borrows_ ownership

See the [documentation on borrowing](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html) for details.

#### Lifetimes

*   Every value has a (statically known) _lifetime_, written `'a`
*   Usually, this can be inferred, but can declare if inference is not working
*   They are used to track borrowing and make sure references will not be dangling

Again see the [documentation on lifetimes](https://doc.rust-lang.org/book/ch10-03-lifetime-syntax.html) for details.

#### Efficiency

Why all the pain compared to Java, python, etc? Efficiency while preserving safety!

*   Static dispatch by default - like C++ non-virtual, very efficient
*   No manual `free` required at runtime, and no garbage collection overhead
*   Corollary: if you don't care about these issues don't use Rust, the pain is not worth it.
*   Note that some Rust-ites would disagree with previous and point out how ownership preserves more referential transparency, etc. Yes, there are other benefits but the price is high.


#### Big example showing many of the above features in one

Paste into [Rust playground](https://play.rust-lang.org) to run it

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

*   `Rc<T>` types: allows multiple “owners”; reference couting is used to prevent too-early free
*   `Arc<T>`: atomic version of the above
*   `~*const T~` and `~*mut T~`: raw pointers, aliasing is allowed, but dereferencing is unsafe.
*   `Cell<T>`: allow mutation from multiple sources
*   Real corner cases may need unsafe escapes: Dereferencing raw pointers, violating “read XOR write” reference scope, unsafe typecasts
*   Some studies of low-level systems code shows around 10-15% of the code may need unsafe hacks
  - Bad but at least for 85-90% of the code it is clean

let mySet = FSet.add 5 FSet.emptyset in
let found = FSet.contains 5 mySet in
      print_string ((string_of_bool found) ^ " is the answer! \n")

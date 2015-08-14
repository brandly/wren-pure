import "please" for Please
import "../pure" for Pure

{
  // Find first match
  var even = Pure.find(1..4) {|num|
    return num % 2 == 0
  }
  Please.equal(even, 2)
}

{
  // null if no match exists
  var big = Pure.find(1..4) {|num|
    return num > 5
  }
  Please.equal(big, null)
}

{
  // Get sequence _without_ values passing the predicate
  var odds = Pure.reject(1..5) {|num|
    return num % 2 == 0
  }
  Please.equal(1, odds.toList[0])
  Please.equal(3, odds.toList[1])
  Please.equal(5, odds.toList[2])
}

{
  // Extract sequence of property values
  var list = [{
    "name": "matt",
    "age": 23
  }, {
    "name": "mark",
    "age": 18
  }]
  var names = Pure.pluck(list, "name").toList
  Please.equal(names[0], "matt")
  Please.equal(names[1], "mark")
}

IO.print("All tests pass!")

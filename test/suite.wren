import "test-framework" for Expect, Suite, ConsoleReporter
import "../pure" for Pure

var TestPure = Suite.new("Pure") { |it|
  it.suite("find") { |it|
    it.should("find first match") {
      var even = Pure.find(1..4) { |num|
        return num % 2 == 0
      }
      Expect.call(even).toEqual(2)
    }

    it.should("return null if no match exists") {
      var big = Pure.find(1..4) { |num|
        return num > 5
      }
      Expect.call(big).toBeNull
    }
  }

  it.suite("reject") { |it|
    it.should("reject any value passing the predicate") {
      var odds = Pure.reject(1..5) { |num|
        return num % 2 == 0
      }.toList
      Expect.call(odds[0]).toEqual(1)
      Expect.call(odds[1]).toEqual(3)
      Expect.call(odds[2]).toEqual(5)
    }
  }

  it.suite("pluck") { |it|
    it.should("extract sequence of property values") {
      var list = [{
        "name": "matt",
        "age": 23
      }, {
        "name": "mark",
        "age": 18
      }]
      var names = Pure.pluck(list, "name").toList
      Expect.call(names[0]).toEqual("matt")
      Expect.call(names[1]).toEqual("mark")
    }
  }

  it.suite("max") { |it|
    it.should("use basic > comparison by default") {
      Expect.call(Pure.max((1..4).toList)).toEqual(4)
    }

    it.should("allow for custom comparison function") {
      var list = [{
        "name": "harden",
        "ppg": 27.4
      }, {
        "name": "curry",
        "ppg": 23.8
      }]
      var max = Pure.max(list) { |player| player["ppg"] }
      Expect.call(max).toEqual(list[0])
    }
  }

  it.suite("min") { |it|
    it.should("use basic < comparison by default") {
      Expect.call(Pure.min((1..4).toList)).toEqual(1)
    }

    it.should("allow for custom comparison function") {
      var combatless = [{
        "name": "bea5",
        "xp": 68952810
      }, {
        "name": "Z o D",
        "xp": 242195672
      }]
      var min = Pure.min(combatless) { |player| player["xp"]}
      Expect.call(min).toEqual(combatless[0])
    }
  }

  it.suite("first") { |it|
    it.should("extract the first item") {
      Expect.call(Pure.first((1..4).toList)).toEqual(1)
    }
  }

  it.suite("last") { |it|
    it.should("extract the last item") {
      Expect.call(Pure.last((1..4).toList)).toEqual(4)
    }
  }

  it.suite("initial") { |it|
    it.should("return everything but the last item") {
      var list = Pure.initial((1..4).toList)
      Expect.call(list.count).toEqual(3)
      Expect.call(Pure.last(list), 3)
    }
  }

  it.suite("tail") { |it|
    it.should("return everything but the first item") {
      var list = Pure.initial((1..4).toList)
      Expect.call(list.count).toEqual(3)
      Expect.call(Pure.first(list), 2)
    }
  }

  it.suite("without") { |it|
    it.should("remove all instances of a given value") {
      var numbers = Pure.without([1, 2, 3], 2)
      Expect.call(numbers.count).toEqual(2)
      Expect.call(numbers[1]).toEqual(3)
    }

    it.should("remove all instances of any value in a given List") {
      var numbers = Pure.without([1, 2, 3], [1, 2])
      Expect.call(numbers.count).toEqual(1)
      Expect.call(numbers[0]).toEqual(3)
    }
  }
}

// Run 'em
{
  var reporter = ConsoleReporter.new()
  TestPure.run(reporter)
  reporter.epilogue()
}

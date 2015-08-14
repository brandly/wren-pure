class Please {

  static errorMessage(message) {
    Fiber.abort("Assertion error: " + message)
  }

  static beTruthy(a) {
    if (a) {} else {
      errorMessage(a.toString + " isn't truthy")
    }
  }

  static beFalsy(a) {
    if (a) {
      errorMessage(a.toString + " isn't falsy")
    }
  }

  static exist(a) {
    if (a == null) {
      errorMessage(a.toString + " is null")
    }
  }

  static beNull(a) {
    if (a != null) {
      errorMessage(a.toString + " isn't null")
    }
  }

  static beTrue(a) {
    if (a != true) {
      errorMessage(a.toString + " isn't true")
    }
  }

  static beFalse(a) {
    if (a != false) {
      errorMessage(a.toString + " isn't false")
    }
  }

  static equal(a, b) {
    if (a != b) {
      errorMessage(a.toString + " doesn't equal " + b.toString)
    }
  }

  static notEqual(a, b) {
    if (a == b) {
      errorMessage(a.toString + " equals " + b.toString)
    }
  }

  static fail(a) {
    var fiber = Fiber.new(a)
    fiber.try()
    if (fiber.error == null) {
      errorMessage(a.toString + " doesn't fail")
    }
  }

  static succeed(a) {
    var fiber = Fiber.new(a)
    fiber.try()
    if (fiber.error != null) {
      errorMessage(a.toString + " aborts with error " + fiber.error)
    }
  }

}

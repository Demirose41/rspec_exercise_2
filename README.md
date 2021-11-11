# R Spec

## Intro To Testing Notes

### **TDD** (Test Driven Development)
**Test Driven Development** is a strategy to develop programs where the requirements for the program are turned into test cases. Changes to the program are made until the program passes the test cases. Here is a high level overview of a basic TDD workflow to create a method:

1. Write a new test
2. Run all tests & check for fail
- The new test should fail. If it passesm it should be rewritten
3. Make changes to the method to satisfy the tests
4. Run all tests & check for pass
- if any tests fail, go back to step 3
- if all tests pass, but more test coverage is needed, go to step 1

Once we complete all 4 steps, we have completed 1 iterration of TDD

In the course thus far, method problems usually come with examples of how the method should behave

### TDD worrkflow with 'prime?'

"Write a method `prime?(n)` that takes in a number and returns a
boolean indicating whether or not the number is a prime.
A prime number is a number only divisible by two numbers, 1 and itself."

We begin with an empty method
```
def prime?(num)

end
```

### Iteration 1: Write a new test

```
prime?(6) # => nil (FAIL)
prime?(8) # => nil (FAIL)
prime?(9) # => nil (FAIL)
```
These fails are good since we haven't actually written any code yet. By getting these failures we can reduce the likelyhood of false-positives later on.

Now with that settled, we can start writing code. ***We should only make changes to the method that will support the test. We should not add any extra functionality.*** 

```
# TDD Iteration 1: return false if the number is not prime
def prime?(num)
    (2...num).each do |i|
    return false if num % i == 0
    end
end 


prime?(6) # => false(PASS)
prime?(8) # => false(PASS)
prime?(9) # => false(PASS)
```
### Iteration 2 

```
# TDD Iteration 2: return true if the number is prime

def prime?(num)
  (2...num).each do |i|
    return false if num % i == 0
  end

  true
end

# desired output
prime?(2)   # => true
prime?(7)   # => true
prime?(11)  # => true

# current output
prime?(2)   # => true (PASS)
prime?(7)   # => true (PASS)
prime?(11)  # => true (PASS)
```

### Iteration 3 
```
def prime?(num)
  return false if num < 2

  (2...num).each do |i|
    return false if num % i == 0
  end

  true
end

# desired output
prime?(1)   # => false
prime?(0)   # => false
prime?(-42) # => false

# current output
prime?(1)   # => false
prime?(0)   # => false
prime?(-42) # => false
```

## When Should We Use TDD?
TDD is a ppopular development strategy to employ in the professional world. ***If you are designing a method, think of example method calls for yourself.***

# RSPEC 

## Why do we use automated testing? 
Currently, we manually test our code. For example, we create our own test cases by printing and checking the output of our functions. This can be tediious, repetitive, and **worst of all, it is a method vulnerable to both false positive and false negatives.** The larger you code base is, the more chances there are for both of these to occur. Because of this , relying on manual testing alone is not a sustainable sollution when you start working on larger code projects written by multiple people. 

Enter automated testing.

## What is automated testing? 
When using automated testing, developers will code *test suites*, a collection of test cases that are intended to show that a program demonstrates some specified set of behaviours. There are many libraries dedicated to doing this, with the most popular one for Ruby being RSpec.

While we will spend more time upfront writing and updating code for our test suite, the advantage is that we can instantly and easily test that code at any given time from then on, in a way that will e simpler and more robust tahn doing it manually.

## Foundations and testing
For now, our goal is to be able to interpret tests and understand the basics of RSpecm not necessarily write tests in RSpec. 

## Anatomy of an RSpec project 

To use RSpec, we'll need to structure our project file in a certain way. We separate our implementation code files from the testing files using a '/lib' and '/spec' folder respectively. Another word for a "test" is a "spec"(short for specification, since the tests specify how our code should behave). Let's say we had two methods that we wanted to have tests for, 'add' and 'prime?', then we can structure our project like so:

```
/example_project
  ├── lib
  │   ├── add.rb
  │   └── prime.rb
  └── spec
      ├── add_spec.rb
      └── prime_spec.rb
```
To use RSpec, we **must** follow this structure. We need folders with the literal names "lib" and "spec" as direct children of the project folder. The test files inside of the /spec folder must end with '_spec' in their names.

## How to Read Specs

Let's take a look at the contents of /spec/add_spec.rb to see how we test the add method. The behavior outlined in the specs will dictate how we ought to design the method in /lib/add.rb.

```
# /spec/add_spec.rb

require "add" # this line will include code from "/lib/add.rb"

describe "add method" do
  it "should accept two numbers as arguments" do
    expect { add(2, 3) }.to_not raise_error
  end

  it "should return the sum of the two numbers" do
    expect(add(2, 3)).to eq(5)
    expect(add(10, 12)).to eq(22)
  end
end
```

- The description of the add method outlines 2 criteria:
    
    -it shoould accept two members as arguments
     
    -it should return the sum of the two numbers

By simplly looking at the 'describe' and 'it' lines, we get a clear idea of how 'add' should behave. However, if you nneed morre clarity on the meaning, we can look inside of the 'expect's inside of each 'it' block. Let's hone in on the firrst 'it' block:

eq: short for equal and is the desired result we want

```
it "should accept two numbers as arguments" do
  expect { add(2, 3) }.to_not raise_error
end
```

With that in mind, here's the interpretation of the first it: *The expectation is that if we pass the add method 2 and 3 as arguments, it should not give us an error**

```
it "should return the sum of the two numbers" do
  expect(add(2, 3)).to eq(5)
  expect(add(10, 12)).to eq(22)
end
```

In the second itt block we are now checking for the proper return values.

Now let's show an example of RSpec for our prime? method

```
# /spec/prime_spec.rb
require "prime"

describe "prime? method" do
  it "should accept a number as an argument" do
    expect { prime?(7) }.to_not raise_error
  end

  context "when the number is prime" do
    it "should return true" do
      expect(prime?(7)).to eq(true)
      expect(prime?(11)).to eq(true)
      expect(prime?(13)).to eq(true)
    end
  end

  context "when the number is not prime" do
    it "should return false" do
      expect(prime?(4)).to eq(false)
      expect(prime?(9)).to eq(false)
      expect(prime?(20)).to eq(false)
      expect(prime?(1)).to eq(false)
    end
  end
end
```

## Wrapping up 

Here are the core RPsec terms you'll see in every spec file:

- describe nnames the method being tested
- it expresses the expected behavior of the method being tested
- expect shows how that behavior is tested

# Exceptions in Ruby 

**Exceptions** are what Ruby uses to deal with errors or other unexpected events. 
Here are two examples of classic exceptions or errors that will halt our execution:

```
def my_method(arg_1, arg_2)
  puts arg_1
  puts arg_2
end

my_method("a") # ArgumentError: wrong number of arguments (given 1, expected 2)
```
```
5 + nil # TypeError: nil can't be coerced into Integer
```

Upon reaching an exception, the default behavior in ruby is to terrminate the program. However, we can also define our own behavior to handle exceptions.

## Handling Exceptions

Let's look at the following code.

```
num = 0

10 / num # ZeroDivisionError: divided by 0

puts "finished"
```

In it, the program will terminate before ever getting to the put command. To counteract this we must begin to use, 'begin' and 'rescue'

```
num = 0

begin 
  puts "dividing 10 by #{num}"
  ans = 10/num
  puts "the answer is #{ans}"
rescue
  puts "Tjere was am error with that division"
end

puts "--------"
puts "finished"
```

- If an exception is reached during a begin block, the program will immediatly break off and go to the rescue block. 
- If no exception is reached than the program will not go into the rescue block

List of common errors 
- ArgumentError
- NameError
- NoMethodError
- IndexError
- TypeError

## Raising Exceptions

```
def format_name(first, last)
  first.capitalize + " " + last.capitalize
end

format_name("grace", "HOPPER") # => "Grace Hopper"
```

```
format_name(42, true) # => NoMethodError: undefined method `capitalize' for 42:Integer
```

```
def format_name(first,last)
  if!(first.instance_of?(String) && last.instance_of?(String))
    raise "arguments must be strings"
  end

  first.capitalize + " " + last.capitalize
end

format_name("grace", "hopper") # => "Grace Hopper"
format_name(42, true)          # => RuntimeError: arguments must be strings
```

In the refactored code above we use 'raise' to make our own exception.

We can now implement both 'raise' and 'begin...rescue' in our format_name function

```
def format_name(first,last)
  if!(first.instance_of?(String) && last.instance_of?(String))
    raise "arguments must be strings"
  end

  first.captialize + " " + last.capitalize
end

first_name = 42
last_name = true
begin
  format_name(first_name, last_name)
rescue 
  puts "There was an exception :("
end 
```

The imporatant take away here is [raise] is how we bring up an exception, whereas [begin...rescue] is how we react to that exception.


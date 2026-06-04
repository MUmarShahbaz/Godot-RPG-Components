Introduction to OOP
=================================================

This guide teaches **Object-Oriented Programming (OOP)** concepts to complete beginners using **Python**.

.. contents:: Table of Contents
   :depth: 2

What is OOP?
------------
Object-Oriented Programming is a programming paradigm that organizes code into **objects**. 

An object combines **data** (attributes) and **behavior** (methods) together — just like things in the real world.

**Core Benefits:**

- More organized and readable code
- Easier to reuse and maintain
- Better models real-world entities

**Four Main Pillars of OOP:**

#. :ref:`encapsulation` (bundling data and methods)
#. :ref:`containment` (Has-a relationship)
#. :ref:`inheritance` (Is-a relationship)
#. :ref:`polymorphism` (Many forms)

---

.. _oop:

OOP Basics - Classes and Objects
------------------------------------

.. mermaid::

   classDiagram
       class Dog {
           String name
           int age
           bark()
           get_info()
       }

A **Class** is a blueprint. An **Object** is an actual instance created from that blueprint.

OOP in Python
~~~~~~~~~~~~~

.. code-block:: python

    class Dog:
        def __init__(self, name, age):
            self.name = name      # Attribute
            self.age = age        # Attribute
        
        def bark(self):
            print(f"{self.name} says Woof!")
        
        def get_info(self):
            return f"{self.name} is {self.age} years old."


    # Creating objects
    dog1 = Dog("Buddy", 5)
    dog2 = Dog("Luna", 3)

    dog1.bark()
    print(dog2.get_info())

---

.. _encapsulation:

Encapsulation
-------------

**Encapsulation**  means **bundling data (attributes) and methods (functions) together** inside a class, and **protecting** the internal data from direct outside access.

Think of it like a capsule or a remote control:

- You only see the buttons (public interface)
- The complex wiring inside is hidden (protected)

This helps prevent accidental damage to the data and makes code easier to manage.

.. mermaid::

   classDiagram
       class Player {
           int _health
           int __score
           take_damage()
           add_score()
           get_health()
       }
       note for Player "Private attributes
       (start with _ or __)
       are hidden from outside"

**Why is Encapsulation Important?**

- Protects data from invalid changes
- Makes code more secure and maintainable
- Allows you to change internal implementation without breaking other code

Encapsulation in Python
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python

    class Player:
        def __init__(self, name):
            self.name = name
            self._health = 100        # Protected attribute (convention)
            self.__score = 0          # Private attribute (name mangling)
        
        # Public method - controlled way to change health
        def take_damage(self, damage: int):
            if damage > 0:
                self._health -= damage
                print(f"{self.name} took {damage} damage!")
                if self._health <= 0:
                    print(f"{self.name} has been defeated!")
                    self._health = 0
        
        # Public method to safely get health
        def get_health(self) -> int:
            return self._health
        
        # Public method to add score
        def add_score(self, points: int):
            if points > 0:
                self.__score += points
        
        def get_score(self) -> int:
            return self.__score


    # Using the class
    player1 = Player("Alex")

    player1.take_damage(30)
    print(f"Health: {player1.get_health()}")      # Safe access
    player1.add_score(250)
    print(f"Score: {player1.get_score()}")

    # Direct access to private attribute is discouraged:
    # print(player1.__score)   # This will not work easily

.. _containment:

Containment
-----------

**Containment** means one class *contains* another class.  
It represents a **"Has-a"** relationship.

Example: A **Car** has an **Engine**.

.. mermaid::

   classDiagram
       class Engine {
           int horsepower
           start()
       }
       class Car {
           String make
           String model
           Engine engine
           start_car()
       }
       Car o-- Engine : contains

Containment in Python
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python

    class Engine:
        def __init__(self, horsepower):
            self.horsepower = horsepower
        
        def start(self):
            print(f"Engine ({self.horsepower}hp) is roaring to life!")


    class Car:
        def __init__(self, make, model, horsepower):
            self.make = make
            self.model = model
            self.engine = Engine(horsepower)   # Containment
        
        def start_car(self):
            print(f"Starting {self.make} {self.model}")
            self.engine.start()


    my_car = Car("Tesla", "Model 3", 350)
    my_car.start_car()

---

.. _inheritance:

Inheritance
-----------

**Inheritance** allows a new class to inherit properties and methods from an existing class.  
It represents an **"Is-a"** relationship.

.. mermaid::

   classDiagram
       Animal <|-- Dog
       Animal <|-- Cat

       class Animal {
           String name
           eat()
           sleep()
       }
       class Dog {
           String breed
           bark()
       }
       class Cat {
           meow()
       }

Inheritance in Python
~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python

    class Animal:
        def __init__(self, name):
            self.name = name
        
        def eat(self):
            print(f"{self.name} is eating.")
        
        def sleep(self):
            print(f"{self.name} is sleeping.")


    class Dog(Animal):                    # Inheritance
        def __init__(self, name, breed):
            super().__init__(name)        # Call parent constructor
            self.breed = breed
        
        def bark(self):
            print(f"{self.name} says Woof!")


    class Cat(Animal):                    # Inheritance
        def meow(self):
            print(f"{self.name} says Meow!")


    my_dog = Dog("Max", "Golden Retriever")
    my_cat = Cat("Whiskers")

    my_dog.eat()      # Inherited method
    my_dog.bark()     # Dog's own method

---

.. _polymorphism:

Polymorphism
------------

**Polymorphism** means "many forms". It allows objects of different classes to be used interchangeably if they share a common interface.

The same method name can behave differently depending on the object.

.. mermaid::

   classDiagram
       Shape <|-- Rectangle
       Shape <|-- Circle

       class Shape {
           area()
       }
       class Rectangle {
           area()
       }
       class Circle {
           area()
       }

Polymorphism in Python
~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: python

    class Shape:
        def area(self):
            return 0


    class Rectangle(Shape):
        def __init__(self, width, height):
            self.width = width
            self.height = height
        
        def area(self):                     # Overriding
            return self.width * self.height


    class Circle(Shape):
        def __init__(self, radius):
            self.radius = radius
        
        def area(self):                     # Overriding
            return 3.14159 * self.radius ** 2


    # Polymorphism in action
    shapes = [
        Rectangle(5, 3),
        Circle(4),
        Rectangle(6, 2)
    ]

    for shape in shapes:
        print(f"Area = {shape.area():.2f}")

**Key Point**: Even though all are different shapes, we can call `.area()` on any of them uniformly.

Summary
-------

- **OOP** → Organize code using classes and objects
- **Containment** → "Has-a" relationship (one object owns another)
- **Inheritance** → "Is-a" relationship (code reuse through hierarchy)
- **Polymorphism** → Same method, different behavior

These four concepts together make your programs more powerful, flexible, and easier to maintain.

Happy coding!
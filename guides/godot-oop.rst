Effective Godot using OOP
=================================================

This guide teaches you how to effectivly use **Object-Oriented Programming (OOP)** and unlock the full powers of **Godot**!!

Technically, all :doc:`/class_variant` are themselves a class, however, we will only be discussing :doc:`/class_node`. After all, this guide is intended for total beginners.

.. contents:: Table of Contents
   :depth: 2

.. tip::
    Make sure to read :doc:`oop` first! You can't learn how to use **OOP** if you don't know what it is!!


Defining an Element
-------------------

The most important (unofficial) rule in **Godot** as well as other standard game engines is to make each element "`standalone`". This means that it should be self-conatined and completely independent.
This begs the question: **What is an Element?**

An element can be anything that can safely exist on it's own and is reusable. Each character is an element. Each map is an element. Each obstacle, projectile or pickup can also be an element.
It depends entirely on your setup, but you should always be on the lookout for anything you can turn into an element.

It's much easier to program small elements before using all of them together in a level or game.



When to use Classes
-------------------

Every :doc:`/class_node` is a class, and since you can't have a scene without a root node, you're already using classes. The question is, **when to use your own custom classes?**

First thing you need to understand is that a class must be a script, it can't be a scene. This means you can't use the GUI part of godot to define a class. Hence, it's best to create a custom class for anything, only if it can be done with a script alone.

Secondly, creating a new class from scratch is not recommended, especially when so many other classes already exist. It is best to use :ref:`inheritance` and inherit from another class.
Try to be creative and mold your idea so that you can use pre-written code as much as possible. For example, my :doc:`/class_meleeattack` is just an :doc:`/class_area2d` with a bit of extra code. They don't sound related at all, but it works!!

Finally, classes don't need to be something completely new. You can even directly copy a class and assign some default values so that you don't have to do it everytime you use it. You can even make a simple :doc:`/class_camera2d` with 2x ZOOM by doing :

.. code-block:: gdscript

    extends Camera2D
    class_name ZoomedCamera

    func _ready() -> void:
        zoom = Vector2(2, 2)

Using your own custom classes is really beneficial and definitely something worth mastering.

Creating multiple Classes & Hierarchies
---------------------------------------

Imagine you need to make multiple classes which have only some minute changes. For example, you can have ``Player``, ``Ally``, ``Enemy`` and ``NPC``. They may be different but are essentially just type of characters. This is where you should use the full advantage of OOP to create a hierarchy of classes.
You need only write the code once and it will automatically be used everywhere!! This will make updating core logic much more easier!!

A possible solution of the previous example would be:

.. mermaid::

    classDiagram
        Friendly <|-- NPC
        Friendly <|-- Ally
        Ally <|-- Player

        class Friendly {
            String name
            eat()
            sleep()
        }
        class Enemy {
            String name
            eat()
            sleep()
            attack_friendly()
        }
        class NPC {
            run()
        }
        class Ally {
            attack_enemy()
        }
        class Player {
            special_attack()
        }

This will result in:

.. mermaid::

    classDiagram

        class Enemy {
            String name
            eat()
            sleep()
            attack_friendly()
        }
        class NPC {
            String name
            eat()
            sleep()
            run()
        }
        class Ally {
            String name
            eat()
            sleep()
            attack_enemy()
        }
        class Player {
            String name
            eat()
            sleep()
            attack_enemy()
            special_attack()
        }

.. tip::

    The **Godot** editor also has much better code completion and debugging for Classes as compared to Scenes.
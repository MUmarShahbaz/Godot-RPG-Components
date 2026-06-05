Installing RPG Components 2D
============================

This guide describe how to install the latest release of **RPG Components 2D**.

.. contents:: Table of Contents
   :depth: 2

Requirements
------------

Before installing RPG Components 2D, ensure you have:

* Godot ``4.x`` or later
* Basic familiarity with the Godot editor

.. tip::

    People who are new to Godot should try to use the nodes as is, unless the documentation for the node specifically says `This method should be extended` or `This method should be overwritten`.

Installation
------------

Install from Asset Library
~~~~~~~~~~~~~~~~~~~~~~~~~~

#.  The library hasn't been added to the Asset Library just yet, but it will be soon.

Manual Installation
~~~~~~~~~~~~~~~~~~~

#. Download the latest release.
#. Extract the contents.
#. Copy the ``rpg_components_2d`` folder into your project's ``addons/`` directory.

Example project structure:

.. code-block:: text

   project/
   └── addons/
       └── rpg_components_2d/

Enabling the Addon
------------------

#. Open **Project > Project Settings > Plugins**.
#. Locate **RPG Components 2D**.
#. Enable the plugin.

Once enabled, the library's tools and resources will become available.

.. tip::
    Make sure to read :doc:`object_oriented_programming` to learn about Object-Oriented-Programming. This will allow you to use this addon more effectively.

Troubleshooting
---------------

The Plugin Does Not Appear
~~~~~~~~~~~~~~~~~~~~~~~~~~

* Verify the addon is located **inside** the ``addons`` directory.
* Confirm the plugin is enabled.
* Restart Godot if necessary.

Startup Errors
~~~~~~~~~~~~~~

* Verify you are using a supported Godot version.
* Check the Output panel for errors.
* Review the installation instructions.

Getting Help
------------

If you encounter issues:

* Read the documentation.
* Search existing issue reports.
* Create a bug report with reproduction steps.

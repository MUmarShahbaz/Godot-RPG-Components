.. raw:: html

    <div align="center" style="margin-bottom: 30px;">
        <img src="_static/icon.png" width="350" alt="RPG Components 2D Icon">
        <p style="font-size: 2em; margin-top: 20px;">RPG Components 2D</p>
        <a href="https://github.com/MUmarShahbaz/Godot-RPG-Components" target="blank"><img width=150px height=auto style="border: 2px solid black; border-radius: 5px; margin: 5px" src="https://img.shields.io/badge/GitHub-white?style=for-the-badge&logo=github&logoColor=white&logoSize=auto&labelColor=black"></a>
        <a href="https://godotengine.org/asset-library/asset/5184" target="blank"><img width=150px height=auto style="border: 2px solid #478cbf; border-radius: 5px; margin: 5px" src="https://img.shields.io/badge/Godot-white?style=for-the-badge&logo=godotengine&logoColor=white&logoSize=auto&labelColor=478cbf"></a>
    </div>


RPG Components 2D
=================

Welcome to **RPG Components 2D**!!!

**RPG Components 2D** is a collection of reusable components for building 2D RPGs in Godot. The library was designed with the principal of **Overwriting via Polymorphism** in mind. This means that extending the nodes with your own custom code is intended. This will allow greater customization and gives you the oppurtunity to fine-tune them (if needed).

.. raw:: html

    <style>
        .feature-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            align-items: center;
            margin: 40px 0;
        }

        .feature-text {
            font-size: 1.1em;
        }

        .feature-text b {
            font-size: 1.2em;
        }

        .feature-image img {
            width: 100%;
            border-radius: 8px;
        }

        @media (max-width: 800px) {
            .feature-row {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div style="text-align:center; font-size:2em; font-weight:800; margin:40px 0;">
        SKIP THE BORING STUFF<br><span style="font-size:3em;" class="pixelify neon" data-content="FOCUS ON THE MAGIC">FOCUS ON THE MAGIC</span>
    </div>

    <div class="feature-row">
        <div class="feature-text">
            <b>Entities come with Movement and HP pre-baked</b><br><br>
            Drop-ready entity system with movement, health, and core gameplay logic already implemented.
        </div>
        <div class="feature-image">
            <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Entity.gif">
        </div>
    </div>

    <div class="feature-row">
        <div class="feature-image">
            <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Projectile_Melee.gif">
        </div>
        <div class="feature-text">
            <b>Frame-synced Projectile & Melee Attacks</b><br><br>
            Combat system with minimal configuration and consistent frame-accurate execution.
        </div>
    </div>

    <div class="feature-row">
        <div class="feature-text">
            <b>Explosions with Custom Force & Radius</b><br><br>
            Create impactful effects like knockback, blast radius, and physics-driven reactions.
        </div>
        <div class="feature-image">
            <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Explosion.gif">
        </div>
    </div>

    <div class="feature-row">
        <div class="feature-image">
            <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Spawner.gif">
        </div>
        <div class="feature-text">
            <b>Automatic Area & Point Spawners</b><br><br>
            Drop-in spawning system for enemies, items, and environmental objects.
        </div>
    </div>
    <p style="text-align: center; font-size: 6em; margin: 150px 0;">AND MUCH MORE!!</p>
    <hr>

Useful Links
============

.. toctree::
    :maxdepth: 1
    :caption: Guides
    :name: toc-getting-started

    guides/installation
    guides/oop
    guides/godot-oop

.. toctree::
    :maxdepth: 2
    :caption: Class Reference
    :name: toc-class-ref

    index/character
    index/brain
    index/ability
    index/objects
    index/miscellaneous
    index/visuals_and_audio
    index/singletons

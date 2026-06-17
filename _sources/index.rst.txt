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
        .magic {
            text-align: center;
            font-size: 2em;
            font-weight: 800;
            margin: 40px 0;
        }

        .magic .pixelify {
            font-size: 3em;
        }

        .feature-left, .feature-right {
            display: flex;
            font-size: 1.1em;
            justify-content: space-between;
            margin: 50px 0;
        }

        .feature-left div, .feature-right div {
            display: flex;
            align-items: center;
        }

        .feature-left p, .feature-right p {
            margin: 0;
        }

        .feature-left b, .feature-right b {
            font-size: 1.2em;
        }

        .feature-left img, .feature-right img {
            max-width: 45%;
            min-width: 350px;
            border-radius: 8px;
        }

        .feature-left {
            flex-direction: row;
        }

        .feature-right {
            flex-direction: row-reverse;
        }

        .feature-left img {
            margin-right: 5%;
        }

        .feature-right img {
            margin-left: 5%;
        }

        .feature-end {
            text-align: center;
            line-height: unset;
            font-size: 6em;
            margin: 150px 0;
        }

        @media (max-width: 1050px) {
            .feature-left, .feature-right {
                flex-direction: column;
            }

            .feature-left img, .feature-right img {
                max-width: 100%;
                margin: 5% 0;
            }

            .feature-end {
                margin: 100px 0;
                font-size: 5em;
            }
        }

        @media (max-width: 800px) {
            .magic {
                font-size: 1.5em;
            }

            .magic .pixelify {
                font-size: 2em;
            }

            .feature-left img, .feature-right img {
                min-width: 200px;
            }

            .feature-end {
                font-size: 3em;
            }
        }
    </style>

    <hr>

    <div class="magic">
        SKIP THE BORING STUFF<br><span class="pixelify">FOCUS ON THE MAGIC</span>
    </div>

    <div class="feature-right">
        <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Entity.gif">
        <div>
        <p>
            <b>Entities come with Movement and HP baked-in!</b><br><br>
            Drop-ready entity system with movement, health, and animation control already implemented.
        </p>
        </div>
    </div>

    <div class="feature-left">
        <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Projectile_Melee.gif">
        <div>
        <p>
            <b>Frame-synced Projectile & Melee Attacks</b><br><br>
            Combat system with minimal configuration and consistent frame-accurate execution.
        </p>
        </div>
    </div>

    <div class="feature-right">
        <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Explosion.gif">
        <div>
        <p>
            <b>Explosions with Custom Force & Blast-Radius</b><br><br>
            Create impactful effects like knockback, blast radius, and physics-driven reactions.
        </p>
        </div>
    </div>

    <div class="feature-left">
        <img src="https://raw.githubusercontent.com/MUmarShahbaz/Godot-RPG-Components/main/images/Spawner.gif">
        <div>
        <p>
            <b>Automatic Area & Point Spawners</b><br><br>
            Drop-in spawning system for enemies, items, and environmental objects.
        </p>
        </div>
    </div>

    <p class="feature-end">AND MUCH MORE!!</p>

    <hr>

    <div class="magic" style="display: flex; flex-direction: row; align-items: center; justify-content: center; flex-wrap: wrap;">
        <div style="font-size: 2.5em; margin-right: 20px;">⭐</div>
        Show your Support!! <br> Star the Repo!!
    </div>

    <p> Starring the repository is completely free and it allows my project to gain more traction. This really helps me stay motivated and know that my project is appreciated. If you really took a liking to my project, please remember to open it on <a href="https://github.com/MUmarShahbaz/Godot-RPG-Components">GitHub</a> and click the <b>Star</b> button</p>

    <a style="display: flex; width: 100%; justify-content: center;" href="https://github.com/MUmarShahbaz/Godot-RPG-Components/stargazers">
        <img style="width: 60%; min-width: 320px" alt="Stargazers" src="https://bytecrank.com/nastyox/reporoster/php/stargazersSVG.php?user=MUmarShahbaz&repo=Godot-RPG-Components" />
    </a>

    <a style="display: flex; width: 100%; justify-content: center;" href="https://www.star-history.com/?repos=MUmarShahbaz%2FGodot-RPG-Components&type=date&legend=top-left">
        <img alt="Star History Chart" src="https://api.star-history.com/chart?repos=MUmarShahbaz/Godot-RPG-Components&type=date&legend=bottom-right" />
    </a>
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

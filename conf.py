# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'RPG Components 2D'
copyright = '2026, MUmarShahbaz'
author = 'MUmarShahbaz'
release = '1.1.0'
html_favicon = '_static/favicon.png'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinxcontrib.mermaid',
    'sphinxext.opengraph'
]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

ogp_image = '_static/og.png'
ogp_description_length = 200
ogp_type = 'website'
ogp_site_url = 'https://mumarshahbaz.github.io/Godot-RPG-Components/'
ogp_site_name = 'RPG Components 2D'

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_css_files = [
    "overwrite.css",
]
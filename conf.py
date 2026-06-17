project = 'RPG Components 2D'
short_name = 'RPG 2D'
description = 'A Framework for Godot 4 to help with Fast RPG Creation.'
author = 'MUmarShahbaz'
categories = ['godot', 'rpg', 'rpg-framework', 'rpg-tool', 'newbie', 'tutorial', 'game development', 'addon', 'plugin', 'components', 'library']

copyright = '%Y, MUmarShahbaz'

release = '1.1.1'
html_favicon = '_static/favicon.png'
html_baseurl = 'https://godotrpgcomponents.xyz/'

html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
html_css_files = ['overwrite.css']

extensions = [
    'sphinxcontrib.mermaid',
    'sphinxext.opengraph'
]

templates_path = ['_templates']
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']

ogp_image = '_static/og.png'
ogp_description_length = 200
ogp_type = 'website'
ogp_site_url = 'https://godotrpgcomponents.xyz/'
ogp_site_name = 'RPG Components 2D'
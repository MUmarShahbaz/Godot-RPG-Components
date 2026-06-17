import os
import conf
import json
from pathlib import Path
from datetime import datetime
from urllib.parse import urljoin

# Manifest Generator

manifest_content = f"""\
{{
  "name": "{conf.project}",
  "short_name": "{conf.short_name}",
  "description": "{conf.description}",
  "start_url": "/",
  "scope": "/",
  "id": "/?source=pwa",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#2980b9",
  "lang": "en",
  "orientation": "portrait-primary",
  
  "icons": [
    {{
      "src": "{conf.html_favicon}",
      "sizes": "512x512",
      "type": "image/png"
    }}
  ],

  "categories": {json.dumps(conf.categories)}
}}
"""

Path("_build/html/manifest.json").write_text(manifest_content, encoding="utf-8")
print("✅ Manifest generated successfully!")

# Sitemap Generator

build_path = Path("_build/html")
urls = []
today = datetime.now().strftime("%Y-%m-%d")

for root, _, files in os.walk(build_path):
    for file in files:
        if file.endswith(".html"):
            full_path = Path(root) / file
            rel_path = full_path.relative_to(build_path)
            
            if str(rel_path).startswith(("404", "search", "genindex")):
                continue
                
            url_path = str(rel_path).replace("\\", "/")
            if url_path == "index.html":
                url_path = ""
            
            full_url = urljoin(conf.html_baseurl, url_path)
            urls.append(full_url)

xml_content = '''\
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
'''

for url in sorted(urls):
    xml_content += f"""<url>
<loc>{url}</loc>
</url>
"""
xml_content += "</urlset>"

Path("_build/html/sitemap.xml").write_text(xml_content, encoding="utf-8")

print(f"✅ Sitemap generated successfully!")
print(f"🔗 Total URLs: {len(urls)}")

# robots.txt Generator

Path("_build/html/robots.txt").write_text(f"Sitemap: {conf.html_baseurl}sitemap.xml", encoding="utf-8")

print(f"✅ Robots.txt generated successfully!")
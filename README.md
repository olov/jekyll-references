## Jekyll Markdown references plugin

Created by Olov Lassus, Public Domain license.

https://github.com/olov/jekyll-references

### Usage
Add this file to your `_plugins` directory (create it if needed).
Create a file named `_references.md` in your Jekyll site root,
then add your markdown reference-style link definitions to it.

For example:

    [google]: http://www.google.com  "Google it!"
    [wiki]: http://wikipedia.org  "Online Encyclopedia"
    [id]: url  "tooltip"

You can now reference these links in any markdown file.
For example:

    [Google][google] is a popular search engine and [Wikipedia][wiki] an
    online encyclopedia.

### Changes
See [references.rb](https://github.com/olov/jekyll-references/blob/master/references.rb)

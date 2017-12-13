# references.rb: Jekyll Markdown references plugin
#
# Created by Olov Lassus, Public Domain license.
# Version 2.0
# https://github.com/olov/jekyll-references
#
# CHANGES
# 2013-05-06: v1.0
# * Updated to support Jekyll 1.0
#   (should still work with older Jekyll versions)
# * Works on all Markdown transformations, files or snippets
#
# 2017-12-13: v2.0
# * Updated to support Jekyll 3.x
#   (should still work with older Jekyll versions)
# * Only add labels for referenced links. Fixes #2
# * Only add labels if not already in content.
#
# USAGE
# Add references.rb to your _plugins directory (create it if needed).
# Create a file named _references.md in your Jekyll site root,
# then add your markdown reference-style link definitions to it.
# For example:
#   [google]: http://www.google.com  "Google it!"
#   [wiki]: http://wikipedia.org  "Online Encyclopedia"
#   [id]: url  "tooltip"
#
# Only labels will be read from the references file. Everything else
# will be ignored, so you can safely add comments or other content.
#
# You can now reference these links in any markdown file.
# For example:
# [Google][google] is a popular search engine and [Wikipedia][wiki] an
# online encyclopedia.

module Jekyll
  module Converters
    class Markdown < Converter
      alias old_convert convert
      @@links = nil

      LINK_REGEX = /(\[[^\[\]]+?\])(?=\s*[^\[ (:])/ # http://rubular.com/r/ahGtMifv6C
      LABEL_REGEX = /(\[[^\[\]]+?\]):\s*(.+)/

      # return hash of label => link with keys normalised to lower case
      def labels_from(s)
        h = {}
        s.scan(LABEL_REGEX).flatten.each_slice(2) { |k| k.first.downcase!; h.store(*k) }
        h
      end

      def convert(content)
        # read and cache references from _references.md as hash of label => link
        if @@links.nil?
          refs_path = File.join(@config["source"], "_references.md")
          refs = if File.exist?(refs_path) then File.read(refs_path) else '' end
          @@links = labels_from refs
        end

        # Append labels for links where a label is absent from the content
        links = labels_from content
        content.scan(LINK_REGEX).flatten.uniq.each do |k|
          k.downcase!
          if !links.include?(k) and v = @@links[k]
            content << "\n#{k}:#{v}"
          end
        end
        old_convert(content)
      end
    end
  end
end
